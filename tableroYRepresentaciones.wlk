import wollok.game.*
import enemigos.*
import elementosDelMapa.*
import factories.*
import drops.*

object tablero{
    const property width = 17
    const property height = 17
    const property cellSize = 48
    const dropsEnElTablero = drops
    const enemigosEnElTablero = enemigos
    const elementosEnElTablero = elementos

    method hayAlgoAca(position){
        return enemigosEnElTablero.hayEnemigoAca(position) or 
               elementosEnElTablero.hayElementoAca(position)
    }

    method posicionesLindantes(position){
        return [position.left(1), position.right(1), position.up(1), position.down(1)]
    }

    method posicionesLindantesOrdenadasXDistancia(position, positionACompararDistancia){
        return self.posicionesLindantes(position).sortedBy({primeraPos, segundaPos => primeraPos.distance(positionACompararDistancia) < segundaPos.distance(positionACompararDistancia)})
    }

    method hayEnemigoAca(position){
        return enemigosEnElTablero.hayEnemigoAca(position)
    }

    method limpiarTablero(){
        elementosEnElTablero.limpiarElementos()
        dropsEnElTablero.borrarDrops()
    }

    method crearNivel(layout){
        (0 .. layout.size() - 1).forEach({ y =>
            (0 .. layout.get(y).size() - 1).forEach({ x =>
                layout.get(y).get(x).crear(game.at(x, y), elementosEnElTablero)
            })
        })
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

object ggl{ // Gargola.
    method crear(){
        return gargolaFactory.crear()
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

object ttr { // Zombie del nivel tutorial.
    method crear(){
        return zombieTutorialFactory.crear()
    }
}

object vmp{ // Vampiro aliado del jefe final.
    method crear(){
        return vampiroFactory.crear()
    }
}

// OBJETOS que representan un elemento en una celda del layout de un nivel.

object _{ // Celda vacia del nivel.
    method crear(posicion, elementos){}
}

object b{ // Borde del mapa de un nivel (es un elemento, pero se encuentra incorporado a la imagen del nivel).
    method crear(posicion, elementos){}
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