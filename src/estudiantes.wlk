import materias.*

class Estudiante {

	var property materiasInscriptas = #{}
	var property materiasAprobadas = #{}
	var property carreras = #{}
	var miLibreta = []
	var creditos
	
	method miLibreta(){
		return miLibreta
	}
	
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
		creditos = self.materiasAprobadas().sum{materia=>materia.creditos()}
		return creditos
	}

	method agregarAprobadaLa(materia, nota) {
		if (not self.aprobeEsta(materia)){
			self.materiasAprobadas().add(materia)
			self.miLibreta().add(new RenglonLibreta(queMateria=materia,queNota=nota))
		} else {
			self.error("La materia ya tiene una nota asignada")
		}
	}
	
	method verRenglon(numero){
		self.miLibreta().get(numero).declararRegistro(self)
	}

}

class RenglonLibreta{
	var queMateria
	var queNota
	
	method declararRegistro(alumno){
		return "El alumno "+alumno.toString()+" aprobó "+queMateria.toString()+" con "+queNota.toString()+"."
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

