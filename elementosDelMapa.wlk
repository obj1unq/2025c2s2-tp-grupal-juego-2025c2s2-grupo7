import wollok.game.*
import tableroYRepresentaciones.*

object elementos {
    const elementosEnNivel = #{}
    const tableroDelJuego = tablero
    
    method agregarElemento(elemento){
        elementosEnNivel.add(elemento)
        game.addVisual(elemento)
    }

    method hayElementoAca (position){
        return self.hayElementoDeBordeDeMapaAca(position) or
               elementosEnNivel.any({elemento => elemento.position() == position})
    }

    method hayElementoDeBordeDeMapaAca(position){ // Se crea esta función para evitar recorrer el set de elementos del mapa lo más que se pueda.
        const x = position.x()
        const y = position.y()
        const anchoYAlto = tableroDelJuego.width() - 1 // Para que esto funcione bien width == height en el juego.
        const mitadAnchoYAlto = anchoYAlto.div(2)
        return ( (x == 0 or x == anchoYAlto) and (y < mitadAnchoYAlto - 1 or y > mitadAnchoYAlto + 1)) or ((y == 0 or y == anchoYAlto) and (x < mitadAnchoYAlto - 1 or x > mitadAnchoYAlto + 1))
        //       Es elemento del borde superior o inferior   O    Es elemento del borde derecho o izquierdo  
    }

    method limpiarElementos(){
        elementosEnNivel.forEach({elemento => game.removeVisual(elemento)})
        elementosEnNivel.clear()
    }
}

class Elemento{
    const property image
    const property position
}