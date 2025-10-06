import personaje.*
import direcciones.*
import wollok.game.*

object arma{
    const balas = #{}

    method dispararBalas(_direccion){
        if (balas.size() <= 5){
            const b = new Bala(direccion = _direccion, siguienteDireccion = _direccion)
            balas.add(b)
        }
        balas.forEach({bala => if (_direccion !== bala.direccion()){
                                    bala.direccion(_direccion)
                                    }bala.balaViajando()})
    }
}

class Bala{
    var position = poseedor.position()
    const poseedor = personaje
    const daño = 2
    const image = "bala.png"
    var direccion = abajo
    var siguienteDireccion = arriba

    method direccion(){
        return direccion
    }

    method direccion(_siguienteDireccion){
        siguienteDireccion = _siguienteDireccion
    }
    
    method image(){
        return image
    }

    method position(){
        return position
    }

    method balaViajando(){
        if (!game.hasVisual(self)){
            game.addVisual(self)
        }
        if (position.x().between(0,14) and position.y().between(0,14)){
            position = direccion.viajar(position)
        } else {
            self.colisionoOSalioDelMapa()
        }
    }

    method colisionarCon(enemigo){
        enemigo.colisionarCon(daño)
        self.colisionoOSalioDelMapa()
    }

    method colisionoOSalioDelMapa(){
        game.removeVisual(self)
        position = poseedor.position()
        direccion = siguienteDireccion
    }
}