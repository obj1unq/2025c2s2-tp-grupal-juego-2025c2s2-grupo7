import enemigos.*
import randomizer.*
import elementosDelMapa.*

object zombieFactory{
    method crear(){
        const _position = randomizer.posicionVaciaCentral()
        return new Zombie(position = _position)
    }
}

object minotauroFactory{
    method crear(){
        const _position = randomizer.posicionVaciaCentral()
        return new Minotauro(position = _position)
    }
}

object vampiroFactory{
    method crear(){
        const _position = randomizer.posicionVaciaCentral()
        return new Vampiro(position = _position)
    }
}

object acorazadoFactory{
    method crear(){
        const _position = randomizer.posicionVaciaCentral()
        return new Acorazado(position = _position)
    }
}

object momiaFactory{
    method crear(){
        const _position = randomizer.posicionVaciaCentral()
        return new Momia(position = _position)
    }
}

object muroFactory {
    method crear(posicion) {
        return new ElementoDelMapa(image="muro.png", position=posicion)
    }
}