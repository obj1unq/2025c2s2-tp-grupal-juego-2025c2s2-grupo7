import wollok.game.*
import enemigos.*
import juego.*
import armas.*
import movimiento.*

object personaje{
    var position = game.center()
    var property vidas = 3
    var property municion = cartucho
    var property armaSecundaria = null
    const juego = reyDeLaPradera
    var estado = personajeDerecha

    method image(){
        return estado.image()
    }

    method ganarVida(){
        if (vidas < 3){
            vidas += 1
        }
    }

    method text() {
		return municion.toString()
	}
	method textColor() {
		return "FF0000FF"
	}

    method cambiarArma(){
        self.asertarCambioDeArma()
        municion = armaSecundaria
        game.schedule(10000, {municion = municionNormal})
        armaSecundaria = null
    }

    method asertarCambioDeArma(){
        if(armaSecundaria == null){
            self.error("No poseo arma Secundaria")
        }
    }

    method recolectarArma(_arma){
        armaSecundaria = _arma
    }

    method tieneArmaSecundaria(){
        return armaSecundaria != null
    }
    
    method position(){
        return position
    }

    method mover(direccion){
        position = direccion.siguiente(position)
    }

    method disparar(direccion){
        estado = direccion.estadoDePersonajeAsociado()
        municion.disparar(direccion)
    }

    method muerte(){
        vidas -= 1
        if (vidas == 0){
            juego.perderJuego()
        } else {
            juego.reiniciarNivel()
            self.volverAPosicionInicial()
        }
    }

    method volverAPosicionInicial(){
        position = game.center()
    }

    method colisionarConBala(_arma){} // No se hace nada. El personaje no interacciona con su bala disparada.
}

object personajeArriba{
    const property image = "personaje_arriba.png"
}

object personajeDerecha{
    const property image = "personaje_derecha.png"
}

object personajeAbajo{
    const property image = "personaje_abajo.png"
}

object personajeIzquierda{
    const property image = "personaje_izquierda.png"
}