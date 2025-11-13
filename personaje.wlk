import wollok.game.*
import enemigos.*
import juego.*

object personaje{
    var position = game.center()
    const image = "personaje.png"
    var property vidas = 3
    var property armaUtilizada = armaPrincipal
    var property armaSecundaria = null
    const juego = reyDeLaPradera

    method ganarVida(){
        if (vidas < 3){
            vidas += 1
        }
    }

    method text() {
		return armaUtilizada.toString()
	}
	method textColor() {
		return "FF0000FF"
	}

    method cambiarArma(){
        self.asertarCambioDeArma()
        armaUtilizada = armaSecundaria
        game.schedule(10000, {armaUtilizada = armaPrincipal})
        armaSecundaria = null
    }

    method asertarCambioDeArma(){
        if(armaSecundaria == null){
            self.error("No poseo arma Secundaria")
        }
    }

    method recolectarArma(arma){
        armaSecundaria = arma
    }

    method tieneArmaSecundaria(){
        return armaSecundaria != null
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

    method muerte(){
        vidas -= 1
        if (vidas == 0){
            juego.perderJuego()
        } else {
            juego.reiniciarNivel()
            position = game.center()
        }
    }

    method colisionarConBala(arma){} // No se hace nada. El personaje no interacciona con su bala disparada.
}

object armaPrincipal{
    var position = game.at(7,7)
    const property image = "bala.png"
    const poseedor = personaje 
    const property daño = 10

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
        const nuevaPosicion = direccion.siguiente(position)
        if (nuevaPosicion != position){ // La bala puede moverse a su siguiente posicion ya que esta vacía y esta dentro de los limites del mapa.
            position = nuevaPosicion
        } else { // Significa que la bala colisiono con un elemento del mapa o con el borde del mapa.
            game.removeTickEvent("Arma dispara")
            game.removeVisual(self)
            position = poseedor.position()
        }
    }

    method colisiono(){
        game.removeTickEvent("Arma dispara")
        game.removeVisual(self)
        position = poseedor.position()
    }

    method colisionarConPersonaje(personaje){} // No se hace nada. El personaje no interacciona con su bala disparada.
}