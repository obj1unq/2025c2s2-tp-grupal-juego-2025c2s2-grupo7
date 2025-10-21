import wollok.game.*
import enemigos.*

object personaje{
    var position = game.at(7,7)
    const image = "personaje.png"
    var property vida = 100
    var property armaUtilizada = armaPrincipal

    method text() { //PROVISORIO
		return vida.toString()
	}
	method textColor() {
		return "FF0000FF"
	}

    method curarCon(botiquin){
        if(vida < 100){
            vida = (vida + botiquin).min(100)
        } else {
            vida = 100
        }
    }

    method cambiarArma(arma){
        armaUtilizada = arma
    }

    method image(){
        return image
    }

    method position(){
        return position
    }

    method mover(direccion){
        position = direccion.siguiente(position)
    }

    method disparar(direccion){
        armaUtilizada.disparar(direccion)
    }

    method colisionarCon(enemigo){
        if(vida > enemigo.daño()){
            vida = vida - enemigo.daño()
        }else {
            game.stop()
        }
    }
}

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