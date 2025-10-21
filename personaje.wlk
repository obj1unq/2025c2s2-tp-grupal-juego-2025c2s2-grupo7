import wollok.game.*
import enemigos.*
import armas.*

object personaje{
    var position = game.at(7,7)
    const image = "personaje.png"
    var property vida = 100
    var property armaUtilizada = Revolver

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