import wollok.game.*
import factories.*
import enemigos.*
import personaje.*

object tablero{ // TAL VEZ HABRIA QUE HACER QUE EL LAYOUT ESTE ACA O DE ALGUNA MANERA SE CONECTE CON ESTE OBJETO TABLERO
    const property width = 17
    const property height = 17
    const property cellSize = 48
    const ejercitoEnElTablero = ejercito
    const elementosEnElTablero = elementosDelMapa // SOLO HACE FALTA EN LA VERSION LENTA DE hayAlgoAca
    const jugador = personaje // SOLO HACE FALTA EN LA VERSION RAPIDA DE hayAlgoAca

    method hayAlgoAca(position){ // VERSION RAPIDA
        const objetosEnPosicion = game.getObjectsIn(position)
        objetosEnPosicion.remove(jugador)
        return !objetosEnPosicion.isEmpty()
    }
    /*
    method hayAlgoAca(position){ // VERSION LENTA
        return ejercitoEnElTablero.hayEnemigoAca(position) or elementosEnElTablero.hayElementoAca(position)
    }
    */

    method posicionesLindantes(position){
        return [position.left(1), position.right(1), position.up(1), position.down(1)]
    }

    method posicionesLindantesOrdenadasXDistancia(position, positionACompararDistancia){
        return self.posicionesLindantes(position).sortedBy({primeraPos, segundaPos => primeraPos.distance(positionACompararDistancia) < segundaPos.distance(positionACompararDistancia)})
    }

    method hayEnemigoAca(position){
        return ejercitoEnElTablero.hayEnemigoAca(position)
    }
}

object elementosDelMapa {
    const property elementos= #{}
    
    method agregarElemento(elemento) {
        elementos.add(elemento)
        game.addVisual(elemento)
    }

    method hayElementoAca (posicion){
        return elementos.any({elemento => elemento.position() == posicion})
    }

    method limpiarNivel(){
        elementos.forEach({elemento => game.removeVisual(elemento)})
        elementos.clear()
    }
}

class ElementoDelMapa{
    const property image
    const property position
}

object zmb{ // Zombie.
    method crear(){
        return zombieFactory.crear()
    }
}

object mtr{ // Minotauro.
    method crear(){
        return minotauroFactory.crear()
    }
}

object vmp{ // Vampiro.
    method crear(){
        return vampiroFactory.crear()
    }
}

object acz{ // Acorazado.
    method crear(){
        return acorazadoFactory.crear()
    }
}

object mom{ // Momia.
    method crear(){
        return momiaFactory.crear()
    }
}

object _{ // Espacio vacío del mapa.
    method crear(posicion, elemento){}
}

object m{ // Muro de madera en el mapa.
    method crear(posicion, elementos) {
        const muro = muroDeMaderaFactory.crear(posicion)
        elementos.agregarElemento(muro)
    }
}

object a{ // Arbusto en el mapa.
    method crear(posicion, elementos) {
        const arbusto = arbustoFactory.crear(posicion)
        elementos.agregarElemento(arbusto)
    }
}

object p{ // Muro de piedra en el mapa.
    method crear(posicion, elementos) {
        const muro = muroDePiedraFactory.crear(posicion)
        elementos.agregarElemento(muro)
    }
}

object t{ // Arbol en el mapa.
    method crear(posicion, elementos) {
        const arbol = arbolFactory.crear(posicion)
        elementos.agregarElemento(arbol)
    }
}