import wollok.game.*
import personaje.*
import factories.*
import armas.*

object drops {
    const property dropsCreados = []

    method crear(position) {
        const probabilidad = self.rollDropeo()
        if (probabilidad <= 0.50){
            self.agregarNuevoDrop(position, probabilidad)
        }
	}

    method borrarDropSuelto(drop){
        dropsCreados.remove(drop)
        game.removeVisual(drop)
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
       var drop 
        if (probabilidad <= 0.15){
            drop = escopetaFactory.crear(position)
            self.agregarDrop(drop)
        } else if (probabilidad <= 0.30){
            drop = metralletaFactory.crear(position)
            self.agregarDrop(drop)
        } else if (probabilidad <= 0.45){
            drop = lanzacohetesFactory.crear(position)
            self.agregarDrop(drop)
        } else {
            drop = vidaFactory.crear(position)
            self.agregarDrop(drop)
        }
        game.schedule(5000, {self.borrarDropSuelto(drop)})
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
    const arma 
    
    override method colisionarConPersonaje(personaje){
        if(not personaje.tieneArmaSecundaria()){
        personaje.recolectarArma(self.arma())
        game.removeVisual(self)
        }
    }

    method arma(){
        return arma
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

class EscopetaDrop inherits DropDeArma(image = "drop_escopeta.png", arma = escopeta){}

class MetralletaDrop inherits DropDeArma(image = "drop_metralleta.png",arma = uzi){}

class LanzacohetesDrop inherits DropDeArma(image = "drop_lanzacohetes.png",arma = lanzacohetes){}