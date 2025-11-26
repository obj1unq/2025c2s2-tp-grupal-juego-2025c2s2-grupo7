import wollok.game.*
import personaje.*
import factories.*

object drops {
    const property dropsCreados = []

    method crear(position) {
        const probabilidad = self.rollDropeo()
        if (probabilidad <= 0.50){
            self.agregarNuevoDrop(position, probabilidad)
        }
	}

    method agregarDrop(drop){
        dropsCreados.add(drop)
        game.addVisual(drop)
    }

    method borrarDrops(){
        dropsCreados.forEach({drop => game.removeVisual(drop)})
        dropsCreados.clear()
    }

    method agregarNuevoDrop(position, probabilidad){
        if (probabilidad <= 0.15){
            self.agregarDrop(escopetaFactory.crear(position))
        } else if (probabilidad <= 0.30){
            self.agregarDrop(metralletaFactory.crear(position))
        } else if (probabilidad <= 0.45){
            self.agregarDrop(lanzacohetesFactory.crear(position))
        } else {
            self.agregarDrop(vidaFactory.crear(position))
        }
    }

    method rollDropeo(){
        return 0.randomUpTo(1)
    }
}


class Drop {
    const property image
    const property position

    method colisionarConPersonaje(personaje){
        
    }

    method colisionarConBala(arma){
        // No se hace nada.
    }
}

class DropDeArma inherits Drop{
    
    override method colisionarConPersonaje(personaje){
        if(not personaje.tieneArmaSecundaria()){
        personaje.recolectarArma(self)
        game.removeVisual(self)
        }
    }

}

class VidaDrop inherits Drop(image = "drop_vida.png"){

    override method colisionarConPersonaje(personaje){
        if(personaje.puedeAgarrarVida()){
            personaje.recolectarVida()
            game.removeVisual(self)
        }
    }
}

class EscopetaDrop inherits DropDeArma(image = "drop_escopeta.png"){}

class MetralletaDrop inherits DropDeArma(image = "drop_metralleta.png"){}

class LanzacohetesDrop inherits DropDeArma(image = "drop_lanzacohetes.png"){}