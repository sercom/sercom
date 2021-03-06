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
        DocenteInscripto, AlumnoInscripto, Rol, Ejercicio, Usuario, Permiso, \
        Respuesta
from sqlobject import AND, IN
from sqlobject.dberrors import DuplicateEntryError
from sqlobject import SQLObjectNotFound
from formencode import Invalid
from datetime import datetime, timedelta
from sercom.presentation.controllers import BaseController
from sercom.widgets import *
from turbogears import config
from sercom.presentation.subcontrollers import validate as val

import sercom.presentation.subcontrollers as S
import smtplib
from email.mime.text import MIMEText
import os
import sercom.serverinfo
import inspect 
import cherrypy
import time
import feedparser

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
        forward_url = W.HiddenField()
    fields = Fields()
    javascript = [FocusJSSource('form_login_user')]
    submit = W.SubmitButton(name='login_submit')
    submit_text = _(u'Ingresar')

class RecoverForm(W.TableForm):
    class Fields(W.WidgetsList):
        rec_address = W.TextField(label=_(u'Dirección'),
            validator=V.Email(not_empty=True))
        rec_address_v = W.TextField(label=_(u'La dirección nuevamente para verificar'),
            validator=V.Email(not_empty=True))
        chained_validators = [V.FieldsMatch('rec_address','rec_address_v')]

    fields = Fields()
    javascript = [FocusJSSource('form_recover')]
    submit = W.SubmitButton(name='recover_submit')
    submit_text = _(u'Recuperar')

recover_form = RecoverForm()

class UserPanelForm(W.TableForm):
    class Fields(W.WidgetsList):
        pwd_old = W.PasswordField(label=_(u'Contraseña anterior:'),
            help_text=_(u'Requerida para establecer una nueva contraseña.'),
            attrs=dict(maxlength=255),
            validator=V.UnicodeString(min=5, max=255, not_empty=False))
        pwd_new = W.PasswordField(label=_(u'Nueva contraseña'),
            help_text=_(u'Mínimo 5 caracteres.'),
            attrs=dict(maxlength=255),
            validator=V.UnicodeString(min=5, max=255, not_empty=False))
        pwd_confirm = W.PasswordField(label=_(u'Confirmar'),
            attrs=dict(maxlength=255),
            validator=V.UnicodeString(min=5, max=255, not_empty=False))
        nombre = W.TextField(label=_(u'Nombre'),
            help_text=_(u'Sólo lectura.') if config.get('sercom.user_panel.name_readonly', True) else _(u'Obligatorio.'),
            validator=V.UnicodeString(min=10, max=255, strip=True),
            attrs=dict(readonly='readonly') if config.get('sercom.user_panel.name_readonly', True) else dict())
        telefono = W.TextField(label=_(u'Teléfono'),
            validator=V.UnicodeString(not_empty=False, min=7, max=255,
                strip=True))
        paginador = W.TextField(label=_(u'Ítems por página'),
            help_text=_(u'Cantidad de ítems por página de listado. (10..250)'),
            validator=V.Int(min=10, max=250))
    fields = Fields()
    javascript = [FocusJSSource('form_usuario')]
    validator = V.Schema(chained_validators=[
                            V.FieldsMatch('pwd_new', 'pwd_confirm') ])

user_panel_form = UserPanelForm()

class SeleccionCursoForm(W.TableForm):
    class Fields(W.WidgetsList):
        curso = W.SingleSelectField(label=_(u'Curso'),
            options=get_cursos_de_usuario,
            validator=SeleccionCursoValidator)
    fields = Fields()
    javascript = [FocusJSSource('form_curso')]

seleccion_curso_form = SeleccionCursoForm()
#}}}


#{{{ Formulario de registración de alumnos
class RegisterForm(W.TableForm):
    class Fields(W.WidgetsList):
        padron = W.TextField(label=_(u'Padrón'),
            help_text=_(u'Requerido.'),
            validator=V.UnicodeString(min=3, max=10, strip=True))
        apellido = W.TextField(label=_(u'Apellido'),
            help_text=_(u'Requerido.'),
            validator=V.UnicodeString(min=1, max=100, strip=True))
        nombres = W.TextField(label=_(u'Nombres'),
            help_text=_(u'Requerido.'),
            validator=V.UnicodeString(min=1, max=155, strip=True))
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
            validator=V.All(
                V.Email(not_empty=False, resolve_domain=True),
                V.String(not_empty=False, max=255, strip=True,
                        encoding='ascii')))
        telefono = W.TextField(label=_(u'Teléfono'),
            validator=V.UnicodeString(not_empty=False, min=7, max=255,
                strip=True))
        observaciones = W.TextArea(label=_(u'Observaciones'),
            validator=V.UnicodeString(not_empty=False, strip=True))
    fields = Fields()
    javascript = [FocusJSSource('form_padron')]
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
    javascript = [FocusJSSource('form_padron')]

upgrade_registration_form = UpgradeRegistrationForm()
#}}}

class Root(controllers.RootController, BaseController):

    @expose()
    def index(self):
        raise redirect(url('/dashboard'))


    @expose(template='sercom.presentation.templates.error')
    @identity.require(identity.not_anonymous())
    def error(self, mensaje):
        return dict(mensaje=mensaje)
 
    @expose(template='sercom.presentation.templates.welcome')
    @identity.require(identity.not_anonymous())
    def dashboard(self):
        q_score = None
        current = None
        age = None
        feed_entries = None
        usage = dict()
        now = datetime.now()
        curso = self.get_curso_actual()
        instancias = list()
        correcciones = list()
        respuestas_pendientes = list()
        if curso and identity.has_permission(Permiso.entregar_tp):
            for ej in curso.ejercicios:
                for inst in ej.instancias_a_entregar:
                    instancias.append(inst)
            alumno = identity.current.user
            alumno_inscripto = alumno.get_inscripcion(curso)
            correcciones = alumno.get_correcciones(curso)
            correcciones.sort(lambda x,y: cmp(x.instancia, y.instancia))
        if identity.has_permission(Permiso.examen.respuesta.revisar):
            respuestas_pendientes = Respuesta.get_pendientes_de_revision()

        feed_url = config.get('sercom.welcome.rssfeed.url')
        if identity.has_permission(Permiso.admin):
            # A los admins les muestro info del server
            q_score = Entrega.selectBy(inicio=None).count()
            current = None
            try:
                current = Entrega.select(AND(Entrega.q.inicio!=None, Entrega.q.fin==None)).orderBy(Entrega.q.fecha).reversed()[0]
                age = current.fecha
            except:
                pass
            usage = sercom.serverinfo.getinfo()
        elif feed_url:
            # Al resto el feed de noticias, hasta cuatro
            count = 0
            
            feed = feedparser.parse(feed_url)
            if feed is not None:
                feed_entries = list()
                for e in feed.entries:
                    if e.category == 'Noticias' and count < 4:
                        # No logré que el parser deje de escapear el HTML y lo necesito
                        e.html_content = e.summary.replace('&gt;', '>')
                        e.html_content = e.html_content.replace('&lt;', '<')
                        e.presented_date = time.strftime('%d/%m/%Y %H:%M', e.updated_parsed)
                        feed_entries.append(e)
                        count = count + 1

        return dict(curso=curso, now=now, instancias_activas = instancias, correcciones = correcciones, 
                    respuestas_pendientes = respuestas_pendientes, q_score = q_score, usage=usage, age=age, q_current=current,
                    feed_entries = feed_entries) 

    @expose(template='kid:sercom.presentation.templates.user_panel')
    def user_panel(self, id=None, tg_errors=None, **formdata):

        if not id:
            flash(_(u'Error accediendo al panel de control de usuario.'))
            raise redirect('/dashboard')

        if (identity.current.user_id == int(id)): 

            if tg_errors:
                msg = 'Hay uno o más errores:\n'
                for field, error in tg_errors.items():
                    msg += '%s: %s\n' % (field, error)
                flash(msg)

            fields = list(UserPanelForm.fields)
            usuario = val.validate_get(Usuario, 'usuario', id)

            user_form = RecoverForm(fields=fields, action=('/user_update/%i' % int(id)))
            return dict(user_form=user_form, record=usuario)
        else:
            flash(_(u'Solo podés editar tus propios datos.'))
            raise redirect('/dashboard')

    @validate(form=user_panel_form)
    @error_handler(user_panel)
    @expose(template='kid:sercom.presentation.templates.user_panel')
    def user_update(self, id=None, **form_data):

        if not id:
            flash(_(u'Error accediendo al panel de control de usuario.'))
            raise redirect('/dashboard')

        if (identity.current.user_id == int(id)):

            usuario = val.validate_get(Usuario, 'usuario', id)

            if form_data['pwd_new'] and usuario.equals_password(form_data['pwd_old']):
                usuario.reset_password(form_data['pwd_new']) 
                msg = u'Contraseña modificada correctamente.'
            else:
                msg = u'No se modificó la contraseña'
            usuario.nombre = form_data['nombre']
            usuario.telefono = form_data['telefono']
            usuario.paginador = form_data['paginador']
            identity.current.user.paginador = usuario.paginador

            flash(u'Datos actualizados correctamente.\n'+msg)
            raise redirect('/dashboard')
        else:
            flash(_(u'Solo podés editar tus propios datos.'))
            raise redirect('/dashboard')


    @expose(template='kid:sercom.presentation.templates.recover')
    def recover(self, tg_errors=None, **formdata):

        if tg_errors:
            flash(_(u'Debe ingresar su dirección de mail dos veces, para asegurarse que está correctamente escrita.'))

        now = datetime.now()
        previous_url = request.path_info
        
        fields = list(RecoverForm.fields)

        values = dict()
        values.update(request.params)

        recover_form = RecoverForm(fields=fields, action='/recover_password')
        return dict(now=now, recover_form=recover_form, form_data=values)

    @validate(form=recover_form)
    @error_handler(recover)
    @expose(template='kid:sercom.presentation.templates.recover')
    def recover_password(self, **form_data):
        (msg, redir, data) = self._recover_password(form_data)
        flash(msg)
        raise redirect(url(redir), **data)

    @validate(form=recover_form)
    @error_handler(recover)
    def _recover_password(self, form_data):
        msg = _(u'Se le ha enviado un mensaje a su dirección de correo.')
        delay =  config.get('sercom.passrecovery.between_mails_delay', 15)
        try:
            usuario = Usuario.by_email(form_data['rec_address'])
            if (usuario.hash_ts == None or (datetime.now() - usuario.hash_ts) > timedelta(minutes=delay) ):
                # Sólo si no se envió un mail en los últimos 15 minutos a esta cuenta...
                hash = usuario.set_hash(cherrypy.request.headers.get('Remote-Addr'))
                text = 'Este mensaje ha sido enviado para el recupero de contraseña de SERCOM [Taller de programación]\n\n'
                if config.get('sercom.passrecovery.send_username', False):
                    text += 'Su usuario es: %s\n\n' % usuario.usuario.encode('ascii')
                text += 'Para recuperar su contraseña siga el enlace: %s/recover_hash/?h=%s\n\n' % (request.base, hash)
                text += 'En caso de no haber solicitado este mensaje, simplemente ignórelo.'
                self._sendmail(usuario.email, text, config.get('sercom.passrecovery.mail_from', 'sercom@7542.fi.uba.ar'), 'Recupero de contraseña')
            else:
                msg = _(u'El uso reinterado de este mecanismo contituye un abuso del sistema')
        except SQLObjectNotFound, e:
            pass
        except:
            raise

        return (msg, '/', dict())

    @expose()
    def recover_hash(self, **form_data):
        usuario = Usuario.by_hash(form_data['h'])
        if usuario:
            newpass = usuario.reset_password()
            text = 'Nueva contraseña de SERCOM [Taller de programación]\n\n'
            text += 'Su nueva clave de acceso es: %s\n\n' % newpass
            self._sendmail(usuario.email, text, config.get('sercom.passrecovery.mail_from', 'sercom@7542.fi.uba.ar'), 'Nueva contraseña')
            flash(_(u'Su contraseña fue reestablecida y enviada a su correo electrónico.'))
        raise redirect(url('/'))

    def _sendmail(self, to_addr, text, from_addr=None, subject=None):
        # set defaults
        smtp_server = cherrypy.config.get('email.smtp_server', 'localhost')
        smtp_user = cherrypy.config.get('email.smtp_user')
        smtp_password = cherrypy.config.get('email.smtp_password')

        if from_addr == None:
            from_addr = cherrypy.config.get('email.from_addr')

        if subject == None:
            subject = 'Mail desde SERCOM'

        s = smtplib.SMTP(smtp_server)
        # Remove to get more debug messages
        #s.set_debuglevel(1)

        msg = MIMEText(text)

        msg['Subject'] = subject
        msg['From'] = from_addr
        msg['To'] = to_addr

        s.sendmail( from_addr, to_addr, msg.as_string())
        s.close()



    @expose(template='sercom.presentation.templates.login')
    def login(self, redirect_to=None, tg_errors=None, *args,
            **kw):
        if not redirect_to:
            if request.path_info != '/login':
                redirect_to = request.path_info
            else:
                redirect_to = '/dashboard'

        if tg_errors:
            flash(_(u'Hubo un error en el formulario!'))

        if not identity.current.anonymous \
                and identity.was_login_attempted() \
                and not identity.get_identity_errors():
            raise redirect(redirect_to)

        if identity.was_login_attempted():
            msg = _(u'Las credenciales proporcionadas no son correctas o no '
                    'le dan acceso al recurso solicitado.')
        elif identity.get_identity_errors():
            msg = _(u'Debe proveer sus credenciales antes de acceder a este '
                    'recurso.')
        else:
            msg = _(u'Por favor ingrese sus credenciales.')

        fields = list(LoginForm.fields)
        fields.append(W.HiddenField(name='redirect_to'))
        fields.extend([W.HiddenField(name=name) for name in request.params
                if name not in ('login_user', 'login_password', 'login_submit',
                                'redirect_to')])
        login_form = LoginForm(fields=fields, action='/login')

     
        values = dict(request.params)
        values['redirect_to'] = redirect_to

        response.status=403
        return dict(login_form=login_form, form_data=values, message=msg,
                logging_in=True)

    @expose()
    def logout(self):
        cherrypy.lib.sessions.expire()
        identity.current.logout()
        raise redirect(url('/'))

    @expose(template='sercom.presentation.templates.seleccion_curso')
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

    @expose(template='sercom.presentation.templates.register')
    def register(self, **form_data):
        """Registrar un nuevo alumno"""
        return dict(form=register_form, form_data=form_data)

    @expose(template='sercom.presentation.templates.upgrade_registration')
    def upgrade_registration(self, **form_data):
        """Registrar un alumno existente en un nuevo curso"""
        return dict(form=upgrade_registration_form, form_data=form_data)


    def _save_registration(self, form_data):
        curso = Curso.get(form_data['curso'])
        del form_data['curso']
        del form_data['password_confirm']
	if not curso.inscripcion_abierta:
          return (u'La inscripcion esta cerrada', '/', dict())
        try:
            form_data['nombre'] = form_data['nombres'] + ' ' + form_data['apellido']
            del form_data['apellido']
            del form_data['nombres']
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
        if not curso.inscripcion_abierta:
            flash('La inscripción al curso elegido se encuentra cerrada.')
            raise redirect(url('/'))

        try:
            if not form_data['padron'].isdigit():
                error_msg = ERROR_FORMAT
            else:
                alumno = Alumno.by_padron(form_data['padron'])
                if alumno.equals_password(form_data['password']):
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

    entregas = S.EntregasController()

    mis_entregas = S.MisEntregasController()

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

