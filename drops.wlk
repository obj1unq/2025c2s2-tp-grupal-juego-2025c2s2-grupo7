import wollok.game.*
import factories.*
import armas.*
import enemigos.*
import juego.*

object drops {
    const property dropsCreados = []

    method crear(position) {
        const probabilidad = self.rollDropeo()
        if (probabilidad <= 0.25){
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
        if (probabilidad <= 0.05){
            drop = escopetaFactory.crear(position)
            self.agregarDrop(drop)
        } else if (probabilidad <= 0.10){
            drop = metralletaFactory.crear(position)
            self.agregarDrop(drop)
        } else if (probabilidad <= 0.15){
            drop = lanzacohetesFactory.crear(position)
            self.agregarDrop(drop)
        } else if (probabilidad <= 0.20){
            drop = arcoFactory.crear(position)
            self.agregarDrop(drop)
        } else if (probabilidad <= 0.22){
            drop = vidaFactory.crear(position)
            self.agregarDrop(drop)
        } else {
            drop = nuclearFactory.crear(position)
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

    method colisionarConPersonaje(personaje)

    method colisionarConBala(arma){} // No se hace nada.
}

object estrella inherits Drop(image = "drop_estrella.png", position = game.center()){
    const juego = reyDeLaPradera

    override method colisionarConPersonaje(personaje){
        game.removeVisual(self)
        juego.ganarJuego()
    }
}

class VidaDrop inherits Drop(image = "drop_vida.png"){
    override method colisionarConPersonaje(personaje){
        personaje.recolectarVida()
        game.removeVisual(self)
    }
}

class NuclearDrop inherits Drop(image = "drop_nuclear.png"){
    const enemigosDelNivel = enemigos

    override method colisionarConPersonaje(personaje){
        enemigosDelNivel.matarTodos()
        game.removeVisual(self)
    }
}

class ArmaDrop inherits Drop{
    const arma 
    
    override method colisionarConPersonaje(personaje){
        if (!personaje.tieneArmaSecundaria()){
            personaje.armaSecundaria(arma)
            game.removeVisual(self)
        }
    }
}

class EscopetaDrop inherits ArmaDrop(image = "drop_escopeta.png", arma = escopeta){}

class MetralletaDrop inherits ArmaDrop(image = "drop_metralleta.png",arma = metralleta){}

class LanzacohetesDrop inherits ArmaDrop(image = "drop_lanzacohetes.png",arma = lanzacohetes){}

class ArcoDrop inherits ArmaDrop(image = "drop_arco.png",arma = arco){}