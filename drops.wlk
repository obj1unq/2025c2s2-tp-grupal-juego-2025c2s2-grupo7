import wollok.game.*
import personaje.*
import randomizer.*
import factories.*

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
	     	return vidaFactory
        } else {
            return metralletaFactory
        }
    }
}


class Drop {
    const property image
    const property position

    method colisionarConPersonaje(){
        personaje.recolectarArma(self)
        game.removeVisual(self)
    }
}

class DropDeArma inherits Drop{
    override method colisionarConPersonaje(){
        self.validarRecoleccionDeArma()
        super()
    }

    method validarRecoleccionDeArma(){
        if (personaje.tieneArmaSecundaria()){
            self.error ("Ya tiene un arma secundaria en poseción")
        }
    }
}

class VidaDrop inherits Drop(image = "drop_botiquin.png"){}

class EscopetaDrop inherits DropDeArma(image = "drop_escopeta.png"){}

class MetralletaDrop inherits DropDeArma(image = "drop_metralleta.png"){}

class LanzacohetesDrop inherits DropDeArma(image = "drop_lanzacohetes.png"){}