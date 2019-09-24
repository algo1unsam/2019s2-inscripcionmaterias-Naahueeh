import materias.*

class Estudiante {

	var property materiasInscriptas = #{}
	var property materiasAprobadas = #{}
	var property carreras = #{}
	var miLibreta
	var creditos
	
	method asignarLibreta(libreta){
		miLibreta=libreta
		miLibreta.asignarAlumno(self)
	}
	
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

//La libreta tiene dos listas (una de materia y una de notas), cada elemento se relaciona con el otro según la posición (el primero de una lista con el primero de la otra, etc) 
class LibretaDeEstudiante {

	var alumno
	var property materiasAprobadas = []
	
	method asignarAlumno(persona){
		alumno=persona
	}
	
	method alumno(){
		return alumno
	}

	method registraNota(materia, nota) {	
			self.materiasAprobadas().add(new RenglonLibreta(queMateria=materia,queNota=nota))
	}
	
	method verRenglon(numero){
		self.materiasAprobadas().get(numero).declararRegistro(alumno)
	}

}

class RenglonLibreta{
	var queMateria
	var queNota
	
	method declararRegistro(alumno){
		return "El alumno "+alumno+" aprobó "+queMateria+" con "+queNota+"."
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

