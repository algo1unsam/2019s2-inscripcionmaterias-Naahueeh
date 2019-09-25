import estudiantes.*

class Carrera{
	var property misMaterias=#{}
	
	method tengoEstaMateria(materia){
		return  self.misMaterias().contains(materia)
	}
	
	method agregarMaterias(lista){
		misMaterias.addAll(lista)
		lista.forEach{materia=>materia.carreraQuePertenece(self)}
	}

		
}

class Materia {
	var inscriptos=#{}
	var listaDeEspera=[]	
	var property tipoPrerequisito
	var property cupos
	var property anioAlQuePertenece
	var property carreraQuePertenece // Cuando la materia se agrega a la carrera a la que pertenece, el mismo metodo autocomplta esta variable
	var property creditos

	method inscriptos(){
		return inscriptos
	}
	
	method listaDeEspera(){
		return listaDeEspera
	}
	
	method inscribirA(alumno){
		if(self.inscriptos().size()<cupos){
			self.inscriptos().add(alumno)
			alumno.materiasInscriptas().add(self)			
		}else{
			self.listaDeEspera().add(alumno)
		}
	}
	
	method darDeBajaA(alumno){
		self.inscriptos().remove(alumno)
		alumno.materiasInscriptas().remove(self)
		self.inscribirA(self.listaDeEspera().first())	
	}
	
	method verificaPrerequisitos(alumno){
		return self.tipoPrerequisito().verificarCondicion(self,alumno)
	}	
	
}

//Prerequisitos

object ningunPrerequisito{
	method verificarCondicion(materia,alumno){
		return true
	}
}

class AprobarAnioAnterior{
	method verificarCondicion(materia,alumno){
		var queAnio=materia.anioAlQuePertenece()-1
		return materia.carreraQuePertenece().misMaterias().filter({otraMateria=>otraMateria.anioAlQuePertenece()==queAnio}).all{laMateria=>alumno.aprobeEsta(laMateria)}
	}	
}

class NecesitaCreditos{
	var property creditosNecesarios
	method verificarCondicion(materia,alumno){
		return (alumno.creditos()>=self.creditosNecesarios())
	}
}

class TieneCorrelativas{
	var property correlativas=#{}
	method verificarCondicion(materia,alumno){
		return self.correlativas().all{correlativa=>alumno.materiasAprobadas().contains(correlativa)}
	}
}
