import enemigos.*
import randomizer.*
import elementosDelMapa.*
import drops.*
import wollok.game.*

// ENEMIGOS

object zombieFactory{
    const randomizador = randomizer

    method crear(){
        return new Zombie(position = randomizador.posicionVaciaCentral())
    }
}

object minotauroFactory{
    const randomizador = randomizer

    method crear(){
        return new Minotauro(position = randomizador.posicionVaciaCentral())
    }
}

object vampiroFactory{
    const randomizador = randomizer

    method crear(){
        return new Vampiro(position = randomizador.posicionVaciaCentral())
    }
}

object acorazadoFactory{
    const randomizador = randomizer

    method crear(){
        return new Acorazado(position = randomizador.posicionVaciaCentral())
    }
}

object momiaFactory{
    const randomizador = randomizer

    method crear(){
        return new Momia(position = randomizador.posicionVaciaCentral())
    }
}

object enemigoPruebaFactory { // LAS CONSTANTES ESTAN MEDIAS FEITAS :(, PERO ES LO QUE SE ME OCURRIO
     const enemigoPrueba1 = new EnemigoPrueba (vida = 10, position = game.at(2,2), estado = zombiePasoDerecho)
     const enemigoPrueba2 = new EnemigoPrueba (vida = 20, position = game.at(14,14), estado = vampiroArriba)
     const enemigoPrueba3 = new EnemigoPrueba (vida = 30, position = game.at(14,2), estado = minotauroPasoDerecho)
     const enemigoPrueba4 = new EnemigoPrueba (vida = 150, position = game.at(2,14), estado = momiaPasoDerecho)
     const enemigoPrueba5 = new EnemigoPrueba (vida = 70, position = game.at(8,14), estado = desprotegido)
     const enemigosPruebas = [enemigoPrueba1,enemigoPrueba2,enemigoPrueba3,enemigoPrueba4,enemigoPrueba5]

    method crear(){
        const enemigo = enemigosPruebas.anyOne()
        enemigosPruebas.remove(enemigo)
        return enemigo
    }
}

// DROPS

object vidaFactory {
	method crear(_position) {
		return new VidaDrop(position= _position)
	}
}

object escopetaFactory {
    method crear(_position){
        return new EscopetaDrop(position = _position)
    }
}

object metralletaFactory {
	method crear(_position) {
		return new MetralletaDrop(position = _position)
	}
}

object lanzacohetesFactory {
	method crear(_position) {
		return new LanzacohetesDrop(position = _position)
	}
}

// ELEMENTOS DEL MAPA

object muroFactory {
    method crear(posicion) {
        return new ElementoDelMapa(image="elemento_muro.png", position=posicion)
    }
}

object arbustoFactory {
    method crear(posicion) {
        return new ElementoDelMapa(image="elemento_arbusto.png", position=posicion)
    }
}

object troncoFactory {
    method crear(posicion) {
        return new ElementoDelMapa(image="elemento_tronco.png", position=posicion)
    }
}

object sepulcroFactory {
    method crear(posicion) {
        return new ElementoDelMapa(image="elemento_sepulcro.png", position=posicion)
    }
}

object cactusFactory {
    method crear(posicion) {
        return new ElementoDelMapa(image="elemento_cactus.png", position=posicion)
    }
}

