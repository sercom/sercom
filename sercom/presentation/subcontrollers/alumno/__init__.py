# vim: set et sw=4 sts=4 encoding=utf-8 foldmethod=marker :

#{{{ Imports
import cherrypy
from turbogears import controllers, expose, redirect
from turbogears import validate, flash, error_handler
from turbogears import validators as V
from turbogears import widgets as W
from turbogears import identity
from turbogears import paginate
from turbogears import config
from docutils.core import publish_parts
from sercom.presentation.subcontrollers import validate as val
from sercom.model import Alumno, Rol
from sqlobject import *
from sercom.widgets import FocusJSSource
#}}}

#{{{ Configuración
cls = Alumno
name = 'alumno'
namepl = name + 's'
#}}}

#{{{ Validación
def validate_get(id):
    return val.validate_get(cls, name, id)

def validate_set(id, data):
    return val.validate_set(cls, name, id, data)

def validate_new(data):
    return val.validate_new(cls, name, data)
#}}}

#{{{ Formulario
class AlumnoForm(W.TableForm):
    class Fields(W.WidgetsList):
        padron = W.TextField(label=_(u'Padrón'),
            help_text=_(u'Requerido y único.'),
            validator=V.UnicodeString(min=3, max=10, strip=True))
        nombre = W.TextField(label=_(u'Nombre'),
            help_text=_(u'Requerido.'),
            validator=V.UnicodeString(min=10, max=255, strip=True))
        email = W.TextField(label=_(u'E-Mail'),
            #help_text=_(u'Dirección de e-mail.'),
            validator=V.All(
                V.Email(not_empty=False, resolve_domain=True),
                V.String(not_empty=False, max=255, strip=True,
                        encoding='ascii')))

        new_pwd = W.PasswordField(label=_(u'Password'),
            help_text=_(u'Requerido Mínimo 5 máximo 20.'),
            validator=V.UnicodeString(min=5, max=20, strip=False,not_empty=False))                        
            
        new_pwd_copy = W.PasswordField(label=_(u'Repetir Password'),
            help_text=_(u'Requerido Mínimo 5 máximo 20.'),
            validator=V.UnicodeString(min=5, max=20, strip=False,not_empty=False))                                                

        telefono = W.TextField(label=_(u'Teléfono'),
            #help_text=_(u'Texto libre para teléfono, se puede incluir '
            #    'horarios o varias entradas.'),
            validator=V.UnicodeString(not_empty=False, min=7, max=255,
                strip=True))
        nota = W.TextField(label=_(u'Nota'),
            #help_text=_(u'Texto libre para teléfono, se puede incluir '
            #    'horarios o varias entradas.'),
            validator=V.Number(not_empty=False, strip=True))
        observaciones = W.TextArea(label=_(u'Observaciones'),
            #help_text=_(u'Observaciones.'),
            validator=V.UnicodeString(not_empty=False, strip=True))
        activo = W.CheckBox(label=_(u'Activo'), default=1,
            #help_text=_(u'Si no está activo no puede ingresar al sistema.'),
            validator=V.Bool(if_empty=1))
    fields = Fields()
    javascript = [FocusJSSource('form_padron')]

form = AlumnoForm()
#}}}

#{{{ Controlador
class AlumnoController(controllers.Controller, identity.SecureResource):
    """Basic model admin interface"""
    require = identity.in_any_group('admin','JTP','docente', 'redactor')

    @expose()
    def default(self, tg_errors=None):
        """handle non exist urls"""
        raise redirect('list')

    @expose()
    def index(self):
        raise redirect('list')

    @expose(template='kid:%s.templates.list' % __name__)
    @paginate('records', limit=config.get('items_por_pagina'), dynamic_limit='limit_to')
    def list(self, **kw):
        """List records in model"""
        f = True 
        if 'padron' in kw and kw['padron'] != '':
            f = AND(f, Alumno.q.usuario==kw['padron'])
        else:
            kw['padron'] = None
        if 'nombre' in kw and kw['nombre'] != '':
            f = AND(f, LIKE(Alumno.q.nombre, '%'+kw['nombre']+'%'))
        else:
            kw['nombre'] = None
        if 'mail' in kw and kw['mail'] != '':
            f = AND(f, LIKE(Alumno.q.email, '%'+kw['mail']+'%'))
        else:
            kw['mail'] = None
        r = cls.select(f, orderBy=Alumno.q.usuario)
        return dict(records=r, name=name, namepl=namepl, filter=kw, limit_to=identity.current.user.paginador)

    @expose()
    @identity.require(identity.in_any_group("JTP", "admin"))
    def activate(self, id, activo):
        """Save or create record to model"""
        r = validate_get(id)
        try:
            r.activo = bool(int(activo))
        except ValueError:
            raise cherrypy.NotFound
        raise redirect('../../list')

    @expose(template='kid:%s.templates.new' % __name__)
    @identity.require(identity.in_any_group("JTP", "admin"))
    def new(self, **kw):
        """Create new records in model"""
        return dict(name=name, namepl=namepl, form=form, values=kw)

    @validate(form=form)
    @error_handler(new)
    @expose()
    @identity.require(identity.in_any_group("JTP", "admin"))
    def create(self, **kw):

        # verifica que los pwd coincidan
        if kw['new_pwd'] != kw['new_pwd_copy'] or kw['new_pwd']=="":
        	flash(_(u'Los passwords no coinciden'))
        	del kw['new_pwd']
        	del kw['new_pwd_copy']
        	raise redirect("new", **kw)
        else:
        	kw['password'] = kw['new_pwd']
        	del kw['new_pwd']
        	del kw['new_pwd_copy']
        	
        """Save or create record to model"""
        kw['roles'] = [Rol.by_nombre('alumno')]
        validate_new(kw)
        print 'todo ok'
        flash(_(u'Se creó un nuevo %s.') % name)
        raise redirect('list')

    @expose(template='kid:%s.templates.edit' % __name__)
    @identity.require(identity.in_any_group("JTP", "admin"))
    def edit(self, id, **kw):
        """Edit record in model"""
        r = validate_get(id)
        return dict(name=name, namepl=namepl, record=r, form=form)

    @validate(form=form)
    @error_handler(edit)
    @expose()
    @identity.require(identity.in_any_group("JTP", "admin"))
    def update(self, id, **kw):
        """Save or create record to model"""
        
        if kw['new_pwd']!="" or kw['new_pwd_copy']!="":        
        	if kw['new_pwd'] != kw['new_pwd_copy']:
        		flash(_(u'Los passwords no coinciden'))
        		del kw['new_pwd']
        		del kw['new_pwd_copy']
        		raise redirect('../edit/%d' % int(id), **kw)
        	else:
        		kw['password'] = kw['new_pwd']
        		del kw['new_pwd']
        		del kw['new_pwd_copy']
        else:
        	del kw['new_pwd']
        	del kw['new_pwd_copy']
        
        r = validate_set(id, kw)
        flash(_(u'El %s fue actualizado.') % name)
        raise redirect('../list')

    @expose(template='kid:%s.templates.show' % __name__)
    def show(self,id, **kw):
        """Show record in model"""
        r = validate_get(id)
        if r.observaciones is None:
            r.obs = ''
        else:
            r.obs = publish_parts(r.observaciones, writer_name='html')['html_body']
        return dict(name=name, namepl=namepl, record=r)

    @expose()
    @identity.require(identity.in_any_group("JTP", "admin"))
    def delete(self, id):
        """Destroy record in model"""
        r = validate_get(id)
        r.destroySelf()
        flash(_(u'El %s fue eliminado permanentemente.') % name)
        raise redirect('../list')

    @expose(template='kid:%s.templates.from_file' % __name__)
    @identity.require(identity.in_any_group("JTP", "admin"))
    def from_file(self):
        return dict()

    @expose(template='kid:%s.templates.import_results' % __name__)
    @identity.require(identity.in_any_group("JTP", "admin"))
    def from_file_add(self, archivo):
        """ Se espera :
             padron,nombre,email,telefono
        """
        import csv
        lines = archivo.file.read().split('\n')
        ok = []
        fail = []
        entregador = Rol.get(2)
        for line in lines:
            for row in csv.reader([line]):
                if row == []:
                    continue
                try:
                    u = Alumno(row[0], nombre=row[1], roles=[Rol.by_nombre('alumno')])
                    u.email = row[2]
                    u.telefono = row[3]
                    u.password = row[0]
                    u.activo = True
                    u.add_rol(entregador)
                    ok.append(row)
                except Exception, e:
                    row.append(str(e))
                    fail.append(row)
        return dict(ok=ok, fail=fail)
    
    @expose('json')
    def get_alumno(self, padron):
        msg = u''
        error=False
        try:
            # Busco el alumno inscripto
            alumno = Alumno.byPadron(padron=padron)
            msg = {}
            msg['id'] = alumno.id
            msg['value'] = alumno.nombre
        except SQLObjectNotFound:
            msg = 'No existe el alumno con padron: %s.' % padron
            error=True
        except Exception, (inst):
            msg = u'Se ha producido un error inesperado al buscar el registro:\n      %s' % unicode(inst)
            error = True
        return dict(msg=msg, error=error)

   
#}}}

