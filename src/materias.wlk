import estudiantes.*

class Carrera{
	var property misMaterias=#{}
	
	method tengoEstaMateria(materia){
		return self.misMaterias().contains(materia)
	}
	

		
}

class Materia {
	var property inscriptos=#{}
	var property listaDeEspera=[]	
	var property tipoPrerequisito
	var cupos
	var property anioAlQuePertenece
	var property carreraQuePertenece
	var property correlativas=#{}
	var property creditos
	
	method inscribirA(alumno){
		if(self.inscriptos().size()<cupos){
			self.inscriptos().add(alumno)			
		}else{
			self.listaDeEspera().add(alumno)
		}
	}
	
	method darDeBajaA(alumno){
		self.inscriptos().remove(alumno)
		self.inscribirA(self.listaDeEspera().first())	
	}
	
	method darListados(){
		
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

object aprobarAnioAnterior{
	method verificarCondicion(materia,alumno){
		var queAnio=materia.anioAlQuePertenece()-1
		return materia.carreraQuePertenece().misMaterias().all{otraMateria=>return(otraMateria.anioAlQuePertenece()==queAnio and alumno.materiasAprobadas().contais(otraMateria))}
	}	
}

object necesitaCreditos{
	method verificarCondicion(materia,alumno){
		return (alumno.creditos()>=materia.creditos())
	}
}

object tieneCorrelativas{
	method verificarCondicion(materia,alumno){
		return materia.correlativas().all{correlativa=>alumno.materiasAprobadas().contais(correlativa)}
	}
}
