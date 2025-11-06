import wollok.game.*
import factories.*
import enemigos.*

object tablero{ // TAL VEZ HABRIA QUE HACER QUE EL LAYOUT ESTE ACA O DE ALGUNA MANERA SE CONECTE CON ESTE OBJETO TABLERO
    const width = 21
    const height = 21
    const ejercitoEnElTablero = ejercito
    const elementosEnElTablero = elementosDelMapa

    method width(){
        return width
    }

    method height(){
        return height
    }

    method hayAlgoAca(position){
        return ejercitoEnElTablero.hayEnemigoAca(position) or elementosEnElTablero.hayElementoAca(position)
    }

    method posicionesLindantesVacias(position){
        return self.posicionesLindantes(position).filter({posicion => !self.hayAlgoAca(posicion)})
    }

    method posicionesLindantes(position){
        return #{position.left(1), position.right(1), position.up(1), position.down(1)}
    }

    method posicionesLindantesSinEnemigos(position){
        return self.posicionesLindantes(position).filter({posicion => !ejercitoEnElTablero.hayEnemigoAca(posicion)})
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
}

class ElementoDelMapa{
    const image
    const position

    method image(){
        return image
    }

    method position(){
        return position
    }
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
        const muro = muroFactory.crear(posicion)
        elementos.agregarElemento(muro)
    }
}