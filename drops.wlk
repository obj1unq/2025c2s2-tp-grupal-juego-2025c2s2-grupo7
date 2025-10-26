import wollok.game.*
import personaje.*
import randomizer.*

class Drop {

}

class Botiquin inherits Drop {
    var property position 

    method image(){
        return "botiquin1.png"
    }

    method colisionarConPersonaje(){
        personaje.ganarVida()
        game.removeVisual(self)
    }
}

class Escopeta inherits Drop {

    var property position 

    method image(){
        return "escopeta.png"
    }

    method colisionarConPersonaje(){
        personaje.cambiarArma(self)
        game.removeVisual(self)
    }
}

class Metralleta inherits Drop {
    var property position 

    method image(){
        return "uzi.png"
    }

     method colisionarConPersonaje(){
        personaje.cambiarArma(self)
        game.removeVisual(self)
     }
}

class Lanzacohetes {
    var property position 
    
    method image(){
        return "lanzacohetes.png"
    }
}



object botiquinFactory {
	method crearEn(posicion) {
		return new Botiquin(position= posicion)
	}
}

object escopetaFactory {
    method crearEn(posicion){
        return new Escopeta(position = posicion)
    }
}
object metralletaFactory {
	method crearEn(posicion) {
		return new Metralleta(position = posicion)
	}
}


object drops {
    const property dropsCreados = []
     method nuevoDropEn(posicion) {
            const drop = self.creacionDropEn(posicion)
			self.agregarDrop(drop)
            game.addVisual(drop)
		}

    method agregarDrop(drop){
        dropsCreados.add(drop)
    }

    method borrarDrops(){
        dropsCreados.forEach({drop => game.removeVisual(drop)})
        dropsCreados.clear()
    }
     
     
     method creacionDropEn(posicion){
        return self.elegirDrop().crearEn(posicion)
     }

     method elegirDrop(){
        const probabilidad =  0.randomUpTo(1) 
        if (probabilidad.between(0, 0.15)){
            return escopetaFactory
        } else if (probabilidad.between(0.15,0.65)) {
	     	return botiquinFactory
        } else {
            return metralletaFactory
        }
    }
}
