# vim: set et sw=4 sts=4 encoding=utf-8 foldmethod=marker :

#{{{ Imports
from turbogears import controllers, expose, redirect
from turbogears import validate, flash, error_handler
from turbogears import validators as V
from turbogears import widgets as W
from turbogears import identity
from turbogears import paginate
from docutils.core import publish_parts
from sercom.subcontrollers import validate as val
from sercom.model import CasoDePrueba, Enunciado
#}}}

#{{{ Configuración
cls = CasoDePrueba
name = 'caso de prueba'
namepl = 'casos de prueba'

fkcls = Enunciado
fkname = 'enunciado'
fknamepl = fkname + 's'
#}}}

#{{{ Validación
def validate_fk(data):
    fk = data.get(fkname + 'ID', None)
    if fk == 0: fk = None
    if fk is not None:
        try:
            fk = fkcls.get(fk)
        except LookupError:
            flash(_(u'No se pudo crear el nuevo %s porque el %s con '
                'identificador %d no existe.' % (name, fkname, fk)))
            raise redirect('new', **data)
    else:
        flash(_(u'No se pudo crear el nuevo %s porque el %s con '
            'identificador %d no existe.' % (name, fkname, fk)))
        raise redirect('new', **data)
    data.pop(fkname + 'ID', None)
    data[fkname] = fk
    return fk

def validate_get(id):
    return val.validate_get(cls, name, id)

def validate_set(id, data):
    validate_fk(data)
    return val.validate_set(cls, name, id, data)

def validate_new(data):
    validate_fk(data)
    return val.validate_new(cls, name, data)

def validate_del(id):
    return val.validate_del(cls, name, id)
#}}}

#{{{ Formulario
class CasoDePruebaForm(W.TableForm):
    class Fields(W.WidgetsList):
        enunciadoID = W.HiddenField()
        nombre = W.TextField(label=_(u'Nombre'), validator=V.UnicodeString(min=3, max=255, strip=True))
        comando = W.TextField(label=_(u'Comando'), validator=V.UnicodeString(min=3, max=255, strip=True))
        descripcion = W.TextField(label=_(u'Descripcion'), validator=V.UnicodeString(max=255, strip=True))
        retorno = W.TextField(label=_(u'Retorno'), help_text=u"Codigo de retorno esperado",validator=V.Int)
        max_tiempo_cpu = W.TextField(label=_(u'CPU'), help_text=u"Maximo tiempo de CPU que puede utilizar [seg]",validator=V.Int)
        max_memoria = W.TextField(label=_(u'Memoria'), help_text=u"Maximo cantidad de memoria que puede utilizar [MB]",validator=V.Int)
        max_tam_archivo = W.TextField(label=_(u'Tam. Archivo'), help_text=u"Maximo tamanio de archivo a crear [MB]",validator=V.Int)
        max_cant_archivos = W.TextField(label=_(u'Archivos'),validator=V.Int)
        max_cant_procesos = W.TextField(label=_(u'Procesos'),validator=V.Int)
        max_locks_memoria = W.TextField(label=_(u'Mem. Locks'),validator=V.Int)
        terminar_si_falla = W.CheckBox(label=_(u'Terminar si falla'), default=0, validator=V.Bool(if_empty=0))
        rechazar_si_falla = W.CheckBox(label=_(u'Rechazar si falla'), default=1, validator=V.Bool(if_empty=1))
        publico = W.CheckBox(label=_(u'Es público?'), default=1, validator=V.Bool(if_empty=1))
        los_archivos_entrada = W.FileField(label=_(u'Archivos Entrada'))
        los_archivos_a_comparar = W.FileField(label=_(u'Archivos a Comparar'))
        archivos_guardar = W.TextField(label=_(u'Archivos a Guardar'))
        activo = W.CheckBox(label=_(u'Activo'), default=1, validator=V.Bool(if_empty=1))
    fields = Fields()
    javascript = [W.JSSource("MochiKit.DOM.focusOnLoad('form_nombre');")]

form = CasoDePruebaForm()
#}}}

#{{{ Controlador

class CasoDePruebaController(controllers.Controller, identity.SecureResource):
    """Basic model admin interface"""
    require = identity.has_permission('admin')

    @expose(template='kid:%s.templates.list' % __name__)
    @validate(validators=dict(enunciado=V.Int))
    @paginate('records')
    def list(self, enunciado):
        """List records in model"""
        r = cls.selectBy(enunciadoID=enunciado)
        return dict(records=r, name=name, namepl=namepl, enunciado=enunciado)

    @expose(template='kid:%s.templates.new' % __name__)
    def new(self, enunciadoID=0, **kw):
        """Create new records in model"""
        form.fields[0].attrs['value'] = enunciadoID or kw['enunciadoID']
        return dict(name=name, namepl=namepl, form=form, values=kw, enunciado=int(enunciadoID))

    @validate(form=form)
    @error_handler(new)
    @expose()
    def create(self, **kw):
        """Save or create record to model"""
        t = Enunciado.get(kw['enunciadoID'])
        del(kw['enunciadoID'])
        if kw['los_archivos_entrada'].filename:
            kw['archivos_entrada'] = kw['los_archivos_entrada'].file.read()
        del kw['los_archivos_entrada']
        if kw['los_archivos_a_comparar'].filename:
            kw['archivos_a_comparar'] = kw['los_archivos_a_comparar'].file.read()
        del kw['los_archivos_a_comparar']
        # TODO : Hacer ventanita mas amigable para cargar esto.
        try:
            kw['archivos_a_guardar'] = tuple(kw['archivos_guardar'].split(','))
        except AttributeError:
            pass
        del kw['archivos_guardar']
        nombre = kw['nombre'];
        del kw['nombre']
        t.add_caso_de_prueba(nombre, **kw)
        flash(_(u'Se creó un nuevo %s.') % name)
        raise redirect('list/%d' % t.id)

    @expose(template='kid:%s.templates.edit' % __name__)
    def edit(self, id, **kw):
        """Edit record in model"""
        r = validate_get(id)
        r.archivos_guardar = ",".join(r.archivos_a_guardar)
        form.fields[0].attrs['value'] = r.enunciado.id
        return dict(name=name, namepl=namepl, record=r, form=form)

    @validate(form=form)
    @error_handler(edit)
    @expose()
    def update(self, id, **kw):
        """Save or create record to model"""
        if kw['los_archivos_entrada'].filename:
            kw['archivos_entrada'] = kw['los_archivos_entrada'].file.read()
        del kw['los_archivos_entrada']
        if kw['los_archivos_a_comparar'].filename:
            kw['archivos_a_comparar'] = kw['los_archivos_a_comparar'].file.read()
        del kw['los_archivos_a_comparar']
        # TODO : Hacer ventanita mas amigable para cargar esto.
        try:
            kw['archivos_a_guardar'] = tuple(kw['archivos_guardar'].split(','))
        except AttributeError:
            pass
        del kw['archivos_guardar']
        r = validate_set(id, kw)
        flash(_(u'El %s fue actualizado.') % name)
        raise redirect('../list/%d' % r.enunciado.id)

    @expose(template='kid:%s.templates.show' % __name__)
    def show(self, id, **kw):
        """Show record in model"""
        r = validate_get(id)
        return dict(name=name, namepl=namepl, record=r)

    @expose()
    def delete(self, enunciado, id):
        """Destroy record in model"""
        validate_del(id)
        flash(_(u'El %s fue eliminado permanentemente.') % name)
        raise redirect('../../list/%d' % int(enunciado))

    @expose()
    def file(self, id, name):
        from cherrypy import request, response
        r = validate_get(id)
        response.headers["Content-Type"] = "application/zip"
        response.headers["Content-disposition"] = "attachment;filename=%s_%d.zip" % (name, r.id)
        if name == "archivos_entrada":
            ret = r.archivos_entrada
        elif name == "archivos_a_comparar":
            ret = r.archivos_a_comparar
        else:
            raise NotFound
        return ret
#}}}

