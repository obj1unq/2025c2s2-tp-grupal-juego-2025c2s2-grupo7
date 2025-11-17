import personaje.*
import wollok.game.*
import personaje.*

object arma{
    const balas = #{}
    const property velocidadDeDisparo = 350
    const poseedor = personaje

    method disparar(direccion){
        if (balas.size() <= 5){
            const b = new Bala(direccion = direccion, position = direccion.siguienteHastaBorde(poseedor.position()))
            balas.add(b)
            b.dispararse()
        }
        balas.forEach({bala => bala.siguienteDireccion(direccion)})
    }
}

class Bala{
    var position
    const poseedor = personaje
    const daño = 10
    const property image = "bala.png"
    var direccion
    var siguienteDireccion = direccion

    method direccion(){
        return direccion
    }

    method siguienteDireccion(_siguienteDireccion){
        siguienteDireccion = _siguienteDireccion
    }

    method position(){
        return position
    }

    method dispararse(){
        game.onCollideDo(self, {_ => self.colisionoOSalioDelMapa()})
        game.addVisual(self)
        game.onTick(50, "Bala disparandose", {self.balaViajando()})
    }

    method balaViajando(){
        const siguientePosicion = direccion.siguienteHastaBorde(position)
        if (position != siguientePosicion){
            position = siguientePosicion
        } else {
            self.colisionoOSalioDelMapa()
        }
    }

    method colisionarCon(enemigo){
        enemigo.colisionarCon(daño)
        self.colisionoOSalioDelMapa()
    }

    method colisionoOSalioDelMapa(){
        direccion = siguienteDireccion
        self.volverAPoseedor()
    }

    method volverAPoseedor(){
        position = poseedor.position()
    }

    method colisionarConPersonaje(personaje){}
}

object balaFactory{

}