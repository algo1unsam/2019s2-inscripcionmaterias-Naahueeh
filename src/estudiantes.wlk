import materias.*

class Estudiante {

	var property materiasInscriptas = #{}
	var property materiasAprobadas = #{}
	var property carreras = #{}
	var miLibreta
	var creditos

	method puedoCursarEsta(materia) {
		return (self.estaEnMisCarrerasEsta(materia) and not self.aprobeEsta(materia) and not self.estoyInscriptoA(materia) and self.preguntarPrerequisitosA(materia))
	}
	
	method inscrbirA(materia){
		if(self.puedoCursarEsta(materia)){
			materia.inscribirA(self)
		}else{
			self.error("Tienes un impedimento para cursar esta materia")
		}
	}

	method estaEnMisCarrerasEsta(materia) {
		return self.carreras().any{ carrera => carrera.tengoEstaMateria(materia) }
	}

	method aprobeEsta(materia) {
		return self.materiasAprobadas().contains(materia)
	}

	method estoyInscriptoA(materia) {
		return self.materiasInscriptas().contains(materia)
	}

	method preguntarPrerequisitosA(materia) {
		return materia.verificaPrerequisitos(self)
	}

	method miLibreta() {
		return miLibreta
	}
	
	method agregarCreditos(cantidad){
		creditos=creditos+cantidad
	}
	
	method creditos(){
		return creditos
	}

	method agregarAprobadaLa(materia, nota) {
		self.materiasAprobadas().add(materia)
		self.agregarCreditos(materia.creditos())
		self.miLibreta().registraNota(materia, nota)
	}

}

class LibretaDeEstudiante {

	var alumno
	var property materiasAprobadas = []
	var property notasMateriasAprobadas = []

	method asignarAlumno(nombre) {
		alumno = nombre
	}

	method registraNota(materia, nota) {
		if (not self.aproboEsa(materia)) {
			self.materiasAprobadas().add(materia)
			self.notasMateriasAprobadas().add(nota)
		} else {
			self.error("La materia ya tiene una nota asignada")
		}
	}

	method aproboEsa(materia) {
		return self.materiasAprobadas().contains(materia)
	}

	method dameLaNotaDe(materia) {
		return materia
	}

}

object guia{
	method decimeElPrograma(alumno,carrera){
		if(alumno.carreras().contais(carrera)){
			return carrera.misMaterias()
		}else{
			self.error("El alumno no esta inscripto a la carrera")
			return false
		}
	}
}

