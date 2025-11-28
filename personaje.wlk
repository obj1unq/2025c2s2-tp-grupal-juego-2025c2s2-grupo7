import wollok.game.*
import juego.*
import armas.*

object personaje{
    var property position = game.center() // Es property para tener un setter que facilitara los tests.
    var property vidas = 3                // Es property para tener un setter que facilitara los tests.
    var property armaUtilizada = escopeta
    var property armaSecundaria = null
    const juego = reyDeLaPradera
    var estado = personajeDerecha

    method image(){
        return estado.image()
    }

    method puedeAgarrarVida(){
        return vidas < self.maximoVidas()
    }

    method recolectarVida(){
            vidas += 1
    }
    

    method maximoVidas(){
        return 3
    }

    method text() {
		return armaUtilizada.toString()
	}
	method textColor() {
		return "FF0000FF"
	}

    method cambiarArma(){
        if(self.puedeCambiarDeArma())
        armaUtilizada = armaSecundaria
        game.schedule(10000, {armaUtilizada = armaPrincipal})
        armaSecundaria = null
    }

    method puedeCambiarDeArma(){
        return armaSecundaria != null
    }

    method recolectarArma(arma){
        armaSecundaria = arma
    }

    method tieneArmaSecundaria(){
        return armaSecundaria != null
    }


    method mover(direccion){
        position = direccion.siguiente(position)
    }

    method disparar(direccion){
        estado = direccion.estadoDePersonajeAsociado()
        armaUtilizada.disparar(direccion)
    }

    method muerte(){
        vidas -= 1
        if (vidas == -1){ // Es -1 porque el personaje tiene una "vida 0".
            juego.perderJuego()
        } else {
            juego.reiniciarNivel()
            self.volverAPosicionInicial()
        }
    }

    method volverAPosicionInicial(){
        position = game.center()
    }

    method colisionarConBala(arma){} // No se hace nada. El personaje no interacciona con su bala disparada.
}

// ESTADOS DEL PERSONAJE

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