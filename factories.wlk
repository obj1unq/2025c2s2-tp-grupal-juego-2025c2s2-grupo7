import enemigos.*
import randomizer.*
import elementosDelMapa.*
import drops.*

// ENEMIGOS

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

// ELEMENTOS DEL MAPA

object muroFactory {
    method crear(posicion) {
        return new ElementoDelMapa(image="muro.png", position=posicion)
    }
}

// DROPS

object vidaFactory {
	method crear(posicion) {
		return new VidaDrop(position= posicion)
	}
}

object escopetaFactory {
    method crear(posicion){
        return new EscopetaDrop(position = posicion)
    }
}

object metralletaFactory {
	method crear(posicion) {
		return new MetralletaDrop(position = posicion)
	}
}

object lanzacohetesFactory {
	method crear(posicion) {
		return new LanzacohetesDrop(position = posicion)
	}
}