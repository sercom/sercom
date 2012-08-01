print('Creating admin role...');
adminR = Rol(nombre='admin', descripcion='Superusuario', permisos=(Permiso.admin, Permiso.corregir, Permiso.enunciado_editar, Permiso.enunciado_eliminar, Permiso.alumno_editar, Permiso.alumno_eliminar, Permiso.examen.editar, Permiso.examen.eliminar, Permiso.examen.tema.editar, Permiso.examen.tema.eliminar, Permiso.examen.tipo.editar, Permiso.examen.tipo.eliminar, Permiso.examen.respuesta.revisar))
print('Creating alumno role...');
alumnoR = Rol(nombre='alumno', descripcion='Alumno del sistema', permisos=(Permiso.entregar_tp, Permiso.examen.respuesta.proponer))
print('Creating docente role...');
docenteR = Rol(nombre='docente', descripcion='Docente de la catedra', permisos=(Permiso.corregir, Permiso.examen.editar, Permiso.examen.tema.editar, Permiso.examen.tipo.editar, Permiso.examen.respuesta.revisar))
print('Creating JTP role...');
jtpR = Rol(nombre='JTP', descripcion='Jefe de Trabajos Practicos', permisos=(Permiso.admin, Permiso.corregir, Permiso.enunciado_editar, Permiso.enunciado_eliminar, Permiso.alumno_editar, Permiso.alumno_eliminar))
print('Creating redactor role...');
redactorR = Rol(nombre='redactor', descripcion='Redactor de trabajos practicos', permisos=(Permiso.corregir, Permiso.enunciado_editar, Permiso.enunciado_eliminar))
print('Creating alumno_colaborador role...');
alumnoColaboradorR = Rol(nombre='alumno_colaborador', descripcion='Alumno en colaboracion con la materia', permisos=(Permiso.examen.editar, Permiso.examen.tema.editar, Permiso.examen.tipo.editar))

print('Creating user:admin pass:admin');
adminUsr = Docente(usuario='admin', password='admin', nombre='Administrator', email='admin@sercom.fi.uba.ar')
print('Adding roles admin, docente, JTP to admin user...');
adminUsr.add_rol(adminR); #admin
adminUsr.add_rol(docenteR); #docente
adminUsr.add_rol(jtpR); #jtp

print('Commiting information...');
hub.commit();
exit();
