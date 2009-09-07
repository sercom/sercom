# vim: set et sw=4 sts=4 encoding=utf-8 foldmethod=marker :

from turbogears import controllers, expose, view, url
from turbogears import widgets as W, validators as V
from turbogears import identity, redirect
from turbogears import validate, flash, error_handler
from cherrypy import request, response
#from turbogears.toolbox.catwalk import CatWalk
import model
from model import Visita, VisitaUsuario, InstanciaDeEntrega, Correccion, \
        Curso, Alumno, DateTimeCol, Entrega, Grupo, \
        DocenteInscripto, AlumnoInscripto, Rol, Ejercicio
from sqlobject import AND, IN
from sqlobject.dberrors import DuplicateEntryError
from sqlobject import SQLObjectNotFound
from formencode import Invalid
from datetime import datetime, timedelta
from sercom.presentation.controllers import BaseController

import sercom.presentation.subcontrollers as S

import logging
log = logging.getLogger("sercom.controllers")


def get_cursos_de_usuario():
    return [(-1, '--')] + [(c.id,c) for c in identity.current.user.cursos]

def get_cursos_activos():
    return [(-1, '--')] + [(c.id,c) for c in Curso.activos()]

class CursoValidator(V.Int):
    def validate_python(self, value, state):
        if value < 0:
            raise Invalid(_(u'Debe seleccionar un curso'), value, state)
        if value not in [c.id for c in self.get_cursos()]:
            raise Invalid(_(u'ID de curso incorrecto'), value, state)

class SeleccionCursoValidator(CursoValidator):
    def get_cursos(self):
        return identity.current.user.cursos

class RegisterCursoValidator(CursoValidator):
    def get_cursos(self):
        return Curso.activos()

class LoginForm(W.TableForm):
    class Fields(W.WidgetsList):
        login_user = W.TextField(label=_(u'Usuario'),
            validator=V.NotEmpty())
        login_password = W.PasswordField(label=_(u'Contraseña'),
            validator=V.NotEmpty())
    fields = Fields()
    javascript = [W.JSSource("MochiKit.DOM.focusOnLoad('form_login_user');")]
    submit = W.SubmitButton(name='login_submit')
    submit_text = _(u'Ingresar')

class SeleccionCursoForm(W.TableForm):
    class Fields(W.WidgetsList):
        curso = W.SingleSelectField(label=_(u'Curso'),
            options=get_cursos_de_usuario,
            validator=SeleccionCursoValidator)
    fields = Fields()
    javascript = [W.JSSource("MochiKit.DOM.focusOnLoad('form_curso');")]

seleccion_curso_form = SeleccionCursoForm()
#}}}


#{{{ Formulario de registración de alumnos
class RegisterForm(W.TableForm):
    class Fields(W.WidgetsList):
        padron = W.TextField(label=_(u'Padrón'),
            help_text=_(u'Requerido.'),
            validator=V.UnicodeString(min=3, max=10, strip=True))
        nombre = W.TextField(label=_(u'Nombre'),
            help_text=_(u'Requerido.'),
            validator=V.UnicodeString(min=5, max=255, strip=True))
        curso = W.SingleSelectField(label=_(u'Curso'),
            options=get_cursos_activos,
            validator=RegisterCursoValidator)
        password = W.PasswordField(label=_(u'Contraseña'),
            help_text=_(u'Mínimo 5 caracteres).'),
            attrs=dict(maxlength=255),
            validator=V.UnicodeString(min=5, max=255))
        password_confirm = W.PasswordField(label=_(u'Confirmar'),
            attrs=dict(maxlength=255),
            validator=V.UnicodeString(min=5, max=255))
        email = W.TextField(label=_(u'E-Mail'),
            #help_text=_(u'Dirección de e-mail.'),
            validator=V.All(
                V.Email(not_empty=False, resolve_domain=True),
                V.String(not_empty=False, max=255, strip=True,
                        encoding='ascii')))
        telefono = W.TextField(label=_(u'Teléfono'),
            #help_text=_(u'Texto libre para teléfono, se puede incluir '
            #    'horarios o varias entradas.'),
            validator=V.UnicodeString(not_empty=False, min=7, max=255,
                strip=True))
        observaciones = W.TextArea(label=_(u'Observaciones'),
            #help_text=_(u'Observaciones.'),
            validator=V.UnicodeString(not_empty=False, strip=True))
    fields = Fields()
    javascript = [W.JSSource("MochiKit.DOM.focusOnLoad('form_padron');")]
    validator = V.Schema(chained_validators=[
                         V.FieldsMatch('password', 'password_confirm') ])

register_form = RegisterForm()
#}}}

#{{{ Formulario de inscripción de alumnos recursantes
class UpgradeRegistrationForm(W.TableForm):
    class Fields(W.WidgetsList):
        padron = W.TextField(label=_(u'Padrón'),
            help_text=_(u'Requerido.'),
            validator=V.UnicodeString(min=3, max=10, strip=True))
        curso = W.SingleSelectField(label=_(u'Curso'),
            options=get_cursos_activos,
            validator=RegisterCursoValidator)
        password = W.PasswordField(label=_(u'Contraseña'),
            help_text=_(u'Mínimo 5 caracteres).'),
            attrs=dict(maxlength=255),
            validator=V.UnicodeString(min=5, max=255))
    fields = Fields()
    javascript = [W.JSSource("MochiKit.DOM.focusOnLoad('form_padron');")]

upgrade_registration_form = UpgradeRegistrationForm()
#}}}

class Root(controllers.RootController, BaseController):

    @expose()
    def index(self):
        raise redirect(url('/dashboard'))

    @expose(template='.presentation.templates.welcome')
    @identity.require(identity.not_anonymous())
    def dashboard(self):
        now = datetime.now()
        prev = now - timedelta(10) # TODO: config
        curso = self.get_curso_actual()
        if 'admin' in identity.current.permissions:
            docente = identity.current.user
            # busca las correcciones asignadas al docente
            correcciones = Correccion.selectBy(corrector=identity.current.user,
                corregido=None).count()
            instancias = list(InstanciaDeEntrega.select(
                AND(InstanciaDeEntrega.q.inicio <= now,
                    InstanciaDeEntrega.q.fin > now))
                        .orderBy(InstanciaDeEntrega.q.fin))
            return dict(a_corregir=correcciones, curso=curso,
                instancias_activas=instancias, now=now)

        if 'entregar' in identity.current.permissions:
            last_login = Visita.select(AND(VisitaUsuario.q.user_id == identity.current.user.id, Visita.q.visit_key == VisitaUsuario.q.visit_key))[-1:][0].created
            # Proximas instancias de entrega
            instancias = list(InstanciaDeEntrega.select(
                AND(InstanciaDeEntrega.q.inicio <= now,
                    InstanciaDeEntrega.q.fin > now,
                    InstanciaDeEntrega.q.ejercicioID == Ejercicio.q.id,
                    Ejercicio.q.cursoID == curso.id)).orderBy(InstanciaDeEntrega.q.fin))
            # Ultimas N entregas realizadas
            entregadores = identity.current.user.get_entregadores(curso)
            entregas = list(Entrega.select(IN(Entrega.q.entregador, entregadores))[:5])
            correcciones = list(Correccion.select(AND(IN(Correccion.q.entregador, entregadores), 
                                                      Correccion.q.corregido >= last_login)))
            return dict(instancias_activas=instancias, now=now, entregas=entregas, correcciones=correcciones)
        return dict()

    @expose(template='.presentation.templates.login')
    def login(self, forward_url=None, previous_url=None, tg_errors=None, *args,
            **kw):

        if tg_errors:
            flash(_(u'Hubo un error en el formulario!'))

        if not identity.current.anonymous \
                and identity.was_login_attempted() \
                and not identity.get_identity_errors():
            raise redirect(forward_url)

        forward_url = None
        previous_url = request.path

        if identity.was_login_attempted():
            msg = _(u'Las credenciales proporcionadas no son correctas o no '
                    'le dan acceso al recurso solicitado.')
        elif identity.get_identity_errors():
            msg = _(u'Debe proveer sus credenciales antes de acceder a este '
                    'recurso.')
        else:
            msg = _(u'Por favor ingrese sus credenciales.')
            forward_url = request.headers.get('Referer', '/')

        fields = list(LoginForm.fields)
        if forward_url:
            fields.append(W.HiddenField(name='forward_url'))
        fields.extend([W.HiddenField(name=name) for name in request.params
                if name not in ('login_user', 'login_password', 'login_submit',
                                'forward_url')])
        login_form = LoginForm(fields=fields, action=previous_url)

        values = dict(forward_url=forward_url)
        values.update(request.params)

        response.status=403
        return dict(login_form=login_form, form_data=values, message=msg,
                logging_in=True)

    @expose()
    def logout(self):
        identity.current.logout()
        raise redirect(url('/'))

    @expose(template='.presentation.templates.seleccion_curso')
    @identity.require(identity.not_anonymous())
    def seleccion_curso(self, **form_data):
        """Permite seleccionar el curso actual"""
        curso = self.get_curso_actual()
        if curso:
            form_data['curso'] = curso.id
        return dict(form=seleccion_curso_form, form_data=form_data)

    @validate(form=seleccion_curso_form)
    @error_handler(seleccion_curso)
    @expose()
    @identity.require(identity.not_anonymous())
    def seleccionar_curso(self, **form_data):
        curso = Curso.get(int(form_data['curso']))
        self.set_curso_actual(curso)
        raise redirect(url('/'))

    @expose(template='.presentation.templates.register')
    def register(self, **form_data):
        """Registrar un nuevo alumno"""
        return dict(form=register_form, form_data=form_data)

    @expose(template='.presentation.templates.upgrade_registration')
    def upgrade_registration(self, **form_data):
        """Registrar un alumno existente en un nuevo curso"""
        return dict(form=upgrade_registration_form, form_data=form_data)


    def _save_registration(self, form_data):
        curso = Curso.get(form_data['curso'])
        del form_data['curso']
        del form_data['password_confirm']
        try:
            alumno = Alumno(**form_data)
            # TODO: rol debería ser configurable
            alumno.add_rol(Rol.by_nombre('alumno'))
            curso.add_alumno(alumno)
            text = _(u'Te registraste exitosamente, ya podés ingresar')
        except DuplicateEntryError, e:
	    text = _(u'Ya estabas registrado. Si querés cambiar algún dato, '
		   u'hacelo desde la seccion correspondiete en SERCOM. '
		   u'Si perdiste tu password, contactate con la cátedra')
        except TypeError, e:
            return (_(u'No se pudo completar la registración porque falta un '
                    u'dato o es inválido (error: %s).') % e, '/register',
                    form_data)
        return (text, '/', dict())

    @expose()
    def error_registration_web(self, tg_errors=None):
        msg = ''
        if tg_errors:
            for field, error in tg_errors.items():
                msg += '%s: %s\n' % (field, error)
        response.headers["Content-Type"] = "text/plain; charset=utf-8"
        return msg.encode('utf-8')

    @validate(form=register_form)
    @error_handler(error_registration_web)
    @expose()
    def save_registration_web(self, **form_data):
        (msg, redir, data) = self._save_registration(form_data)
        response.headers["Content-Type"] = "text/plain; charset=utf-8"
        return msg.encode('utf-8')

    @validate(form=register_form)
    @error_handler(register)
    @expose()
    def save_registration(self, **form_data):
        (msg, redir, data) = self._save_registration(form_data)
        flash(msg)
        raise redirect(url(redir), **data)

    @validate(form=upgrade_registration_form)
    @error_handler(upgrade_registration)
    @expose()
    def save_upgrade_registration(self, **form_data):
        ERROR_CRED_INVALIDAS =_(u'No fue posible completar la operación. Revisar que el padrón y el password sean correctos.')
        ERROR_FORMAT =_(u'No fue posible completar la operación. El padrón se compone solamente de números.')
        curso = Curso.get(form_data['curso'])
        try:
            if not form_data['padron'].isdigit():
                error_msg = ERROR_FORMAT
            else:
                alumno = Alumno.by_padron(form_data['padron'])
                if alumno.equals_password(form_data['password']):
                    print curso
                    print alumno.cursos
                    if not curso in alumno.cursos:
                        curso.add_alumno(alumno)
                        flash(_(u'La inscripción ha sido exitosa.'))
                    else:
                        flash(_(u'¡Ya estabas inscripto a este curso!'))
                    raise redirect(url('/'))

                else:
                    error_msg = ERROR_CRED_INVALIDAS
        except SQLObjectNotFound:
            error_msg = ERROR_CRED_INVALIDAS
        except DuplicateEntryError, e:
	    error_msg = _(u'Ya estás registrado en el curso %s.' % curso)
        flash(error_msg)
        raise redirect(url('/upgrade_registration'), **form_data)

    docente = S.DocenteController()

    alumno = S.AlumnoController()

    enunciado = S.EnunciadoController()

    tarea_fuente = S.TareaFuenteController()

    tarea_prueba = S.TareaPruebaController()

    curso = S.CursoController()

    correccion = S.CorreccionController()

    #admin = identity.SecureObject(CatWalk(model), identity.has_permission('admin'))

    mis_entregas = S.MisEntregasController()

    mis_correcciones = S.MisCorreccionesController()

    corregir = S.CorregirController()

    examenes = S.ExamenFinalController()

#{{{ Agrega summarize a namespace tg de KID
def summarize(text, size, concat=True, continuation='...'):
    """Summarize a string if it's length is greater than a specified size. This
    is useful for table listings where you don't want the table to grow because
    of a large field.

    >>> from sercome.controllers
    >>> text = '''Why is it that nobody remembers the name of Johann
    ... Gambolputty de von Ausfern-schplenden-schlitter-crasscrenbon-fried-
    ... digger-dingle-dangle-dongle-dungle-burstein-von-knacker-thrasher-apple-
    ... banger-horowitz-ticolensic-grander-knotty-spelltinkle-grandlich-
    ... grumblemeyer-spelterwasser-kurstlich-himbleeisen-bahnwagen-gutenabend-
    ... bitte-ein-nurnburger-bratwustle-gernspurten-mitz-weimache-luber-
    ... hundsfut-gumberaber-shonedanker-kalbsfleisch-mittler-aucher von
    ... Hautkopft of Ulm?'''
    >>> summarize(text, 30)
    'Why is it that nobody remem...'
    >>> summarize(text, 68, False, ' [...]')
    'Why is it that nobody remembers the name of Johann\nGambolputty [...]'
    >>> summarize(text, 68, continuation=' >>')
    'Why is it that nobody remembers the name of Johann\nGambolputty de >>'
    """
    if not isinstance(text, unicode):
        text = unicode(text)
    if text:
        if concat:
            text = text.replace('\n', ' ')
        if len(text) > size:
            text = text[:size-len(continuation)] + continuation
    return text

def strbool(bool):
    if bool:
        return _(u'Sí')
    return _(u'No')

def add_custom_stdvars(vars):
    return vars.update(dict(summarize=summarize, strbool=strbool))

view.variable_providers.append(add_custom_stdvars)
#}}}

