import enemigos.*
import elementosDelMapa.*
import factories.*
// import personaje.* // SOLO HACE FALTA EN LA VERSION RAPIDA DE hayAlgoAca

object tablero{ // TAL VEZ HABRIA QUE HACER QUE EL LAYOUT ESTE ACA O DE ALGUNA MANERA SE CONECTE CON ESTE OBJETO TABLERO
    const property width = 17
    const property height = 17
    const property cellSize = 48
    const ejercitoEnElTablero = enemigos
    const elementosEnElTablero = elementos // SOLO HACE FALTA EN LA VERSION LENTA DE hayAlgoAca
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

// OBJETOS que representan un enemigo a crear.

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

object ep { // Enemigo prueba nivel muestra.
    method crear(){
        return enemigoPruebaFactory.crear()
    }
}

// OBJETOS que representan un elemento en una celda del layout de un nivel.

object _{ // Celda vacia del nivel.
    method crear(posicion, elemento){}
}

object m{ // Muro en el nivel.
    method crear(posicion, elementos) {
        elementos.agregarElemento(muroFactory.crear(posicion))
    }
}

object a{ // Arbusto en el nivel.
    method crear(posicion, elementos) {
        elementos.agregarElemento(arbustoFactory.crear(posicion))
    }
}

object c{ // Cactus en el nivel.
    method crear(posicion, elementos) {
        elementos.agregarElemento(cactusFactory.crear(posicion))
    }
}

object t{ // Tronco en el nivel.
    method crear(posicion, elementos) {
        elementos.agregarElemento(troncoFactory.crear(posicion))
    }
}

object s{ // Sepulcro en el nivel.
    method crear(posicion, elementos) {
        elementos.agregarElemento(sepulcroFactory.crear(posicion))
    }
}