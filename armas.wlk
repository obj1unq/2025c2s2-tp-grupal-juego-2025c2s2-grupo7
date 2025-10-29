import personaje.*
import wollok.game.*

class Arma{
    const poseedor = personaje
    const balas = #{}
    const tipoDeBala = balaFactory
    const velocidadDeDisparo

    method disparar(direccion){
        const position = poseedor.position()
        if (balas.size() <= 5 and direccion.siguienteHastaBorde(position) !== position){
            const b = tipoDeBala.crear(direccion.siguienteHastaBorde(position))
            balas.add(b)
            game.addVisual(b)
            game.onCollideDo(b, {_ => b.volverATirador()})
        }
        balas.forEach({bala => bala.viajar(direccion)})
    }

    method velocidadDeDisparo(){
        return velocidadDeDisparo
    }
}

class Bala {
    const daño = 10
    const image = "bala.png"
    const tirador = personaje
    var position

    method image(){
        return image
    }

    method position(){
        return position
    }

    method viajar(direccion){
        const siguientePosicion = direccion.siguienteHastaBorde(position)
        if (!self.estaFueraDeRango(siguientePosicion)){
            position = siguientePosicion
        } else {
            self.volverATirador()
        }
    }

    method colisionarCon (enemigo){
        enemigo.aplicarDaño(daño)
        self.volverATirador()
    }

    method volverATirador(){
        position = tirador.position()
    }

    method estaFueraDeRango (_position){
        const x = _position.x()
        const y = _position.y()
        return x < 0 or x >= game.width() or y < 0 or y >= game.height()
    }
}

object balaFactory{
    method crear(position){
        return (new Bala (position = position))
    }
}

class Revolver inherits Arma (velocidadDeDisparo = 250){}
/*
class Uzi inherits Arma{
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

class Escopeta inherits Arma{
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

class Lanzacohetes inherits Arma{
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