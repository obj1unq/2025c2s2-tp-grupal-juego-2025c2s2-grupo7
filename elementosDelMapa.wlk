import wollok.game.*
import factories.*
import enemigos.*
// import personaje.* // SOLO HACE FALTA EN LA VERSION RAPIDA DE hayAlgoAca

object tablero{ // TAL VEZ HABRIA QUE HACER QUE EL LAYOUT ESTE ACA O DE ALGUNA MANERA SE CONECTE CON ESTE OBJETO TABLERO
    const property width = 17
    const property height = 17
    const property cellSize = 48
    const ejercitoEnElTablero = ejercito
    const elementosEnElTablero = elementosDelMapa // SOLO HACE FALTA EN LA VERSION LENTA DE hayAlgoAca
    // const jugador = personaje // SOLO HACE FALTA EN LA VERSION RAPIDA DE hayAlgoAca

    method hayAlgoAca(position){ // VERSION LENTA
        return ejercitoEnElTablero.hayEnemigoAca(position) or 
               elementosEnElTablero.hayElementoAca(position)
    }

    /*
    method hayAlgoAca(position){ // VERSION RAPIDA
        const objetosEnPosicion = game.getObjectsIn(position)
        objetosEnPosicion.remove(jugador)
        return !objetosEnPosicion.isEmpty()
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
    const elementos = #{}
    const elementosDestructibles = #{}
    
    method agregarElemento(elemento){
        elementos.add(elemento)
        if (!self.hayElementoDeBordeDeMapaAca(elemento.position())){
            elementosDestructibles.add(elemento)
        }
        game.addVisual(elemento)
    }

    method hayElementoAca (position){
        return self.hayElementoDeBordeDeMapaAca(position) or
               elementosDestructibles.any({elemento => elemento.position() == position})
    }

    method hayElementoDeBordeDeMapaAca(position){ // Se crea esta función para evitar recorrer el set de elementos del mapa lo más que se pueda.
        const x = position.x()
        const y = position.y()
        return ( (x == 0 or x == 16) and (y < 7 or y > 9) ) or ( (y == 0 or y == 16) and (x < 7 or x > 9) )  
        //       Es elemento del borde superior o inferior   O    Es elemento del borde derecho o izquierdo  
    }

    method limpiarNivel(){
        elementos.forEach({elemento => game.removeVisual(elemento)})
        elementos.clear()
        elementosDestructibles.clear()
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

object m{ // Muro en el mapa.
    method crear(posicion, elementos) {
        elementos.agregarElemento(muroFactory.crear(posicion))
    }
}

object a{ // Arbusto en el mapa.
    method crear(posicion, elementos) {
        elementos.agregarElemento(arbustoFactory.crear(posicion))
    }
}

object c{ // Cactus en el mapa.
    method crear(posicion, elementos) {
        elementos.agregarElemento(cactusFactory.crear(posicion))
    }
}

object t{ // Tronco en el mapa.
    method crear(posicion, elementos) {
        elementos.agregarElemento(troncoFactory.crear(posicion))
    }
}

object s{ // Sepulcro en el mapa.
    method crear(posicion, elementos) {
        elementos.agregarElemento(sepulcroFactory.crear(posicion))
    }
}