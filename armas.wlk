import personaje.*
import wollok.game.*

class Arma{
    const poseedor = personaje
    const bala

    method disparar(direccion){
        bala.disparar(direccion, velocidadProyectil)
    }
}

class Revolver inherits Arma (bala = bala){}

class Uzi inherits Arma (bala = bala){
    var municion = 25
    const armaPorDefecto = Revolver

    override method disparar(direccion){
        bala.disparar(direccion, velocidadProyectil)
        municion =- 1
        if (municion == 0){
            self.volverAArmaPorDefecto()
        }
    }

    method volverAArmaPorDefecto(){
        poseedor.arma(armaPorDefecto)
    }
}

class Escopeta inherits Arma (bala = cartucho){
    var municion = 10
    const armaPorDefecto = Revolver

    override method disparar(direccion){
        bala.disparar(direccion, velocidadProyectil)
        municion =- 1
        if (municion == 0){
            self.volverAArmaPorDefecto()
        }
    }

    method volverAArmaPorDefecto(){
        poseedor.arma(armaPorDefecto)
    }
}

class Lanzacohetes inherits Arma (bala = misil){
    var municion = 2
    const armaPorDefecto = Revolver

    override method disparar(direccion){
        bala.disparar(direccion, velocidadProyectil)
        municion =- 1
        if (municion == 0){
            self.volverAArmaPorDefecto()
        }
    }

    method volverAArmaPorDefecto(){
        poseedor.arma(armaPorDefecto)
    }
}

object Bala {
    const velocidadProyectil = 250
    const daño = 10
    const image = "bala.png"
    var tirador = personaje
    var position = tirador.position()
    var fueDisparada = false
    const enemigos = ejercito

    method serDisparada(direccion){
        const siguientePosicion = self.viajarA(direccion, position)
        if (!fueDisparada and !self.estaFueraDeRango (siguientePosicion)){
            fueDisparada = true
            position = siguientePosicion
            game.addVisual(self)
            game.onTick(velocidadProyectil, "Arma dispara", {self.viajar(direccion)})
        }
    }

    method viajar(direccion){
        const siguientePosicion = self.viajarA(direccion, position)
        if (!self.estaFueraDeRango(siguientePosicion)){
            position = siguientePosicion
        }
    }

    method estaFueraDeRango (position){
        const x = position.x()
        const y = position.y()
        return x < 0 or x >= game.width() or y < 0 or game.height()
    }
}


/*
object armaPrincipal{
    var position = game.at(7,7)
    const image = "bala.png"
    const poseedor = personaje 
    const daño = 10

    method image(){
        return image
    }

    method position(){
        return position
    }

    method disparar(direccion){
        game.removeTickEvent("Arma dispara")
        game.removeVisual(self)
        position = poseedor.position()
        game.addVisual(self)
        game.onTick (100, "Arma dispara", {self.balaViajando(direccion)})
    }

    method balaViajando(direccion){
        if (position.x().between(1,game.height()-1) and position.y().between(1,game.width()-1)){
            position = direccion.siguiente(position)
        } else {
            game.removeTickEvent("Arma dispara")
            game.removeVisual(self)
            position = poseedor.position()
        }
    }

    method colisionarCon(enemigo){
        enemigo.aplicarDaño(daño)
        game.removeTickEvent("Arma dispara")
        game.removeVisual(self)
        position = poseedor.position()
    }
}
*/