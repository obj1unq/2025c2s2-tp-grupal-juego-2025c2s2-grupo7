import wollok.game.*
import randomizer.*
import factories.*

class Nivel{
    const layout
    const enemigos
    const tiempoDeSpawn

    method crearNivel(){
        layout.forEach({elementoDeNivel => elementoDeNivel.crear()})
    }

    method spawnearEnemigos(){
        enemigos.forEach({enemigo => game.schedule(tiempoDeSpawn, {enemigos.agregarEnemigo (enemigo.crear())})})
    }

    method jugarNivel(){
        self.crearNivel()
        enemigos.enemigosDanPaso()
        enemigos.enemigosPersiguen()
    }
}

const nivel1 = new Nivel(enemigos = [b,b,b,b], tiempoDeSpawn = 350, layout=[_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,
                                                                            _,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,
                                                                            _,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,
                                                                            _,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,
                                                                            _,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,
                                                                            _,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,
                                                                            _,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,
                                                                            _,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,
                                                                            _,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,
                                                                            _,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,
                                                                            _,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,
                                                                            _,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,
                                                                            _,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,
                                                                            _,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,
                                                                            _,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,
                                                                            _,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,
                                                                            _,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,
                                                                            _,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,
                                                                            _,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,
                                                                            _,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_])

object b{
    method crear(){
        return basicoFactory.crear()
    }
}

object _{
    method crear(){}
}