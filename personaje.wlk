import wollok.game.*
import juego.*
import armas.*

object personaje{
    var image = "personaje_derecha.png"
    var property position = game.center() // Es property para tener un setter que facilitara los tests.
    var property vidas = 3                // Es property para tener un setter que facilitara los tests.
    var property armaUtilizada = revolver // Es property para tener un setter que facilitara los tests.
    var property armaSecundaria = null
    const juego = reyDeLaPradera
    const sonidoDeMuerte = "_sonido_perderJuego.mp3"

    method image(){
        return image
    }

    method recolectarVida(){
        if (self.puedeAgarrarVida()){
            vidas += 1
        }
    }

    method puedeAgarrarVida(){
        return vidas < self.maximoVidas()
    }

    method maximoVidas(){
        return 3
    }

    method text(){
        if (armaSecundaria == null){
            return ""
        } else {
            return armaSecundaria.toString()
        }
	}
    
	method textColor() {
		return "FF0000FF"
	}

    method cambiarArma(){
        if(self.puedeCambiarDeArma()){
            armaUtilizada = armaSecundaria
            game.schedule(10000, {armaUtilizada = revolver})
            armaSecundaria = null
        }
    }

    method puedeCambiarDeArma(){
        return armaSecundaria != null
    }

    method armaSecundaria(_armaSecundaria){
        armaSecundaria = _armaSecundaria
    }

    method tieneArmaSecundaria(){
        return armaSecundaria != null
    }


    method mover(direccion){
        position = direccion.siguiente(position)
    }

    method disparar(direccion){
        image = "personaje_" + direccion + ".png"
        armaUtilizada.disparar(direccion)
    }

    method muerte(){
        vidas -= 1
        game.sound(sonidoDeMuerte).play()
        if (self.debePerderElJuego()){ 
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
    
    method debePerderElJuego(){
        return vidas == -1 // Es -1 porque el personaje tiene una "vida 0".
    }
}