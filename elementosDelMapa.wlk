import wollok.game.*
import factories.*

object elementosDelMapa {
    const property elementosEnElMapa= #{} 
    
    method agregarElemento(elemento) {
        elementosEnElMapa.add(elemento)
        game.addVisual(elemento)
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
    method crear(ejercito){
        return zombieFactory.crear(ejercito)
    }
}

object mtr{ // Minotauro.
    method crear(ejercito){
        return minotauroFactory.crear(ejercito)
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