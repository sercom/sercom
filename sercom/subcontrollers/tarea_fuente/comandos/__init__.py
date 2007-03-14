# vim: set et sw=4 sts=4 encoding=utf-8 foldmethod=marker :

#{{{ Imports
import cherrypy
from turbogears import controllers, expose, redirect
from turbogears import validate, flash, error_handler
from turbogears import validators as V
from turbogears import widgets as W
from turbogears import identity
from turbogears import paginate
from docutils.core import publish_parts
from sercom.subcontrollers import validate as val
from sercom.model import TareaFuente, ComandoFuente, Comando
from sqlobject import *
#}}}

#{{{ Configuración
cls = ComandoFuente
name = 'comando fuente'
namepl = 'comandos fuente'
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
class ComandoFuenteForm(W.TableForm):
    class Fields(W.WidgetsList):
        tareaID = W.HiddenField()
        orden = W.TextField(label=_(u'Orden'), validator=V.Int(not_empty=True))
        comando = W.TextField(label=_(u'Comando'), validator=V.UnicodeString(min=3, max=255, strip=True))
        descripcion = W.TextField(label=_(u'Descripcion'), validator=V.UnicodeString(min=3, max=255, strip=True))
        retorno = W.TextField(label=_(u'Retorno'), help_text=u"Codigo de retorno esperado",validator=V.Int(if_empty=0))
        max_tiempo_cpu = W.TextField(label=_(u'CPU'), help_text=u"Maximo tiempo de CPU que puede utilizar [seg]",validator=V.Int())
        max_memoria = W.TextField(label=_(u'Memoria'), help_text=u"Maximo cantidad de memoria que puede utilizar [MB]",validator=V.Int())
        max_tam_archivo = W.TextField(label=_(u'Tam. Archivo'), help_text=u"Maximo tamanio de archivo a crear [MB]",validator=V.Int())
        max_cant_archivos = W.TextField(label=_(u'Archivos'),validator=V.Int())
        max_cant_procesos = W.TextField(label=_(u'Procesos'),validator=V.Int())
        max_locks_memoria = W.TextField(label=_(u'Mem. Locks'),validator=V.Int())
        terminar_si_falla = W.CheckBox(label=_(u'Terminar si falla'), default=1, validator=V.Bool(if_empty=1))
        rechazar_si_falla = W.CheckBox(label=_(u'Terminar si falla'), default=1, validator=V.Bool(if_empty=1))
        archivos_entrada = W.FileField(label=_(u'Archivos Entrada'))
        archivos_a_comparar = W.FileField(label=_(u'Archivos a Comparar'))
        archivos_a_guardar = W.TextField(label=_(u'Archivos a Guardar'))
        activo = W.CheckBox(label=_(u'Activo'), default=1, validator=V.Bool(if_empty=1))
    fields = Fields()
    javascript = [W.JSSource("MochiKit.DOM.focusOnLoad('form_comando');")]

form = ComandoFuenteForm()
#}}}

#{{{ Controlador
class ComandoFuenteController(controllers.Controller, identity.SecureResource):
    """Basic model admin interface"""
    require = identity.has_permission('admin')

    @expose(template='kid:%s.templates.list' % __name__)
    @paginate('records')
    def list(self, tareaID):
        """List records in model"""
        r = cls.select(cls.q.tareaID == tareaID)
        return dict(records=r, name=name, tareaID=int(tareaID),namepl=namepl)

    @expose(template='kid:%s.templates.new' % __name__)
    def new(self, tareaID,**kw):
        """Create new records in model"""
        form.fields[0].attrs['value'] = tareaID
        return dict(name=name, namepl=namepl, form=form, values=kw)

    @validate(form=form)
    @error_handler(new)
    @expose()
    def create(self, **kw):
        """Save or create record to model"""
        t = TareaFuente.get(kw['tareaID'])
        orden = kw['orden']
        del(kw['orden'])
        del(kw['tareaID'])
        kw['archivos_a_guardar'] = tuple(kw['archivos_a_guardar'].split(','))
        t.add_comando(orden, **kw)
        flash(_(u'Se creó un nuevo %s.') % name)
        raise redirect('list/%d' % t.id)

    @expose(template='kid:%s.templates.edit' % __name__)
    def edit(self, id, **kw):
        """Edit record in model"""
        r = validate_get(id)
        return dict(name=name, namepl=namepl, record=r, form=form)

    @validate(form=form)
    @error_handler(edit)
    @expose()
    def update(self, id, **kw):
        """Save or create record to model"""
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
    def delete(self, id):
        """Destroy record in model"""
        r = validate_get(id)
        r.destroySelf()
        flash(_(u'El %s fue eliminado permanentemente.') % name)
        raise redirect('../list')

    @expose(template='kid:%s.templates.from_file' % __name__)
    def from_file(self):
        return dict()

    @expose(template='kid:%s.templates.import_results' % __name__)
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
                    u = Alumno(row[0], nombre=row[1])
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
            msg['value'] = alumno.shortrepr()
        except SQLObjectNotFound:
            msg = 'No existe el alumno con padron: %s.' % padron
            error=True
        except Exception, (inst):
            msg = u"""Se ha producido un error inesperado al buscar el registro:\n      %s""" % str(inst)
            error = True
        return dict(msg=msg, error=error)

   
#}}}

