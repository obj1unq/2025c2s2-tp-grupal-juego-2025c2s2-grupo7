import personaje.*
import wollok.game.*

class Arma{
    const poseedor = personaje
    const balaADisparar

    method disparar(direccion){
        if (!balaADisparar.fueDisparada()){
            balaADisparar.serDisparada(direccion)
        }
    }
}

class Revolver inherits Arma (balaADisparar = bala){}

class Uzi inherits Arma (balaADisparar = bala){
    var municion = 25
    const armaPorDefecto = Revolver

    override method disparar(direccion){
        if (!balaADisparar.fueDisparada()){
            balaADisparar.disparar(direccion)
            municion =- 1
        }
        if (municion == 0){
            self.volverAArmaPorDefecto()
        }
    }

    method volverAArmaPorDefecto(){
        poseedor.arma(armaPorDefecto)
    }
}

class Escopeta inherits Arma (balaADisparar = cartucho){
    var municion = 10
    const armaPorDefecto = Revolver

    override method disparar(direccion){
        if (!balaADisparar.fueDisparada()){
            balaADisparar.disparar(direccion)
            municion =- 1
        }
        if (municion == 0){
            self.volverAArmaPorDefecto()
        }
    }

    method volverAArmaPorDefecto(){
        poseedor.arma(armaPorDefecto)
    }
}

class Lanzacohetes inherits Arma (balaADisparar = misil){
    var municion = 2
    const armaPorDefecto = Revolver

    override method disparar(direccion){
        if (balaADisparar.fueDisparada()){
            balaADisparar.disparar(direccion)
            municion -= 1
        }
        if (municion == 0){
            self.volverAArmaPorDefecto()
        }
    }

    method volverAArmaPorDefecto(){
        poseedor.arma(armaPorDefecto)
    }
}

object bala {
    const velocidadProyectil = 250
    const daño = 10
    const image = "bala.png"
    const tirador = personaje
    var position = tirador.position()
    var fueDisparada = false

    method image(){
        return image
    }

    method position(){
        return position
    }

    method serDisparada(direccion){
        const siguientePosicion = direccion.siguienteHastaBorde(tirador.position())
        if (!self.estaFueraDeRango (siguientePosicion)){
            fueDisparada = true
            position = siguientePosicion
            game.addVisual(self)
            game.onTick(velocidadProyectil, "Bala viaja", {self.viajar(direccion)})
        }
    }

    method viajar(direccion){
        const siguientePosicion = direccion.siguienteHastaBorde(position)
        if (!self.estaFueraDeRango(siguientePosicion)){
            position = siguientePosicion
        } else {
            fueDisparada = false
            game.removeVisual(self)
            game.removeTickEvent("Bala viaja")
        }
    }

    method colisionarCon (enemigo){
        enemigo.aplicarDaño(daño)
        fueDisparada = false
        game.removeVisual(self)
        game.removeTickEvent("Bala viaja")
    }

    method estaFueraDeRango (_position){
        const x = _position.x()
        const y = _position.y()
        return x < 0 or x >= game.width() or y < 0 or y >= game.height()
    }

    method fueDisparada(){
        return fueDisparada
    }
}

object cartucho{}

object misil{}


/*
object armaPrincipal{
    var position = game.at(7,7)
    const image = "bala.png"
    const poseedor = personaje 
    const daño = 10

    

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