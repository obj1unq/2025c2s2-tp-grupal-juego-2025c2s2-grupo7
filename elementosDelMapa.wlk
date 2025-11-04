import wollok.game.*
import factories.*

object elementosDelMapa {
    const property elementosEnElMapa= new Dictionary() // Hay que preguntar si se pueden usar diccionarios, si no se puede cambiarlo por un set.
    
    method agregarElemento(elemento) {
        elementosEnElMapa.put(elemento.position(), elemento) // Si no se pueden usar diccionarios, usar add.
        game.addVisual(elemento)
    }

    method hayElementoAca (posicion){
        return elementosEnElMapa.containsKey(posicion) // Si no se pueden usar diccionarios, hacer una iteración sobre el set.
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

object vpr{ // Vampiro.
    method crear(ejercito){
        return vampiroFactory.crear(ejercito)
    }
}

object acz{ // Acorazado.
    method crear(ejercito){
        return acorazadoFactory.crear(ejercito)
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