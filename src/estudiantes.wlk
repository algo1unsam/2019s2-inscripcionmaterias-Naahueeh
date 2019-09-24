import materias.*

class Estudiante {

	var property materiasInscriptas = #{}
	var property materiasAprobadas = #{}
	var property carreras = #{}
	var property miLibreta
	var creditos

	method puedoCursarEsta(materia) {
		return (self.estaEnMisCarrerasEsta(materia) and not self.aprobeEsta(materia) and not self.estoyInscriptoA(materia) and self.preguntarPrerequisitosA(materia))
	}
	
	method inscribirA(materia){
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
	
	method creditos(){
		self.materiasAprobadas().forEach(){materia=>creditos=creditos+materia.creditos()}
		return creditos
	}

	method agregarAprobadaLa(materia, nota) {
		if (not self.aproboEsa(materia)){
			self.materiasAprobadas().add(materia)
			self.miLibreta().registraNota(materia, nota)
		} else {
			self.error("La materia ya tiene una nota asignada")
		}
	}
	
	method aproboEsa(materia)  {
		return self.materiasAprobadas().contains(materia)
	}

}

class LibretaDeEstudiante {

	var property alumno
	var property materiasAprobadas = []
	var property notasMateriasAprobadas = []

	method registraNota(materia, nota) {
			self.materiasAprobadas().add(materia)
			self.notasMateriasAprobadas().add(nota)
	}

	method dameLaNotaDe(materia) {
		var x=0
		var y
		self.materiasAprobadas().forEach{unaMateria=>
			if(unaMateria==materia){
				y=x
			}else{
				x+=1
			}
		}
		var traerNota = self.notasMateriasAprobadas().get(y)
		return "La nota del alumno "+ self.alumno().toString() + " en la materia " + materia.toString() + " es " + traerNota + "."
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

