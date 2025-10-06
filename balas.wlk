import personaje.*
import direcciones.*
import wollok.game.*

object arma{
    var position = game.at(7,7)
    const image = "bala.png"
    const balas = #{}
    const daño = 2

    method image(){
        return image
    }

    method position(){
        return position
    }

    method dispararBalas(direccion){
        if (balas.size() <= 5){
            game.onTick (100, "Arma dispara", {balas.forEach({bala => bala.disparar(direccion)})})
        } else {
            const b = new bala()
            game.addVisual(b)
            balas.add(b)
            game.onTick (100, "Arma dispara", {balas.forEach({bala => bala.disparar(direccion)})})
        }
    }
}

class bala{
    var position = game.at(7,7)
    const poseedor = personaje
    const daño = 2

    method disparar(direccion){
        position = poseedor.position()
        game.addVisual(self)
        game.onTick (100, "Arma dispara", {self.balaViajando(direccion)})
    }

    method balaViajando(direccion){
        if (position.x().between(0,14) and position.y().between(0,14)){
            position = direccion.viajar(position)
        } else {
            game.removeTickEvent("Arma dispara")
            game.removeVisual(self)
            position = poseedor.position()
        }
    }

    method colisionarCon(enemigo){
        enemigo.colisionarCon(daño)
        game.removeTickEvent("Arma dispara")
        game.removeVisual(self)
        position = poseedor.position()
    }
}