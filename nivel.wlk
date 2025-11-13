import wollok.game.*
import personaje.*
import elementosDelMapa.*
import enemigos.*

class Nivel{
    const layout
    var enemigos = enemigosIniciales.copy() // Un set de los enemigos que aun no se han spawneado durante la ejecución de un nivel.
    const enemigosIniciales // Un set de los enemigos que se van a spawnear en un nivel. (No se le deben eliminar o agregar elementos).
    const ejercitoDeNivel   
    const tiempoDeSpawn
    const elementosEnNivel // Son los objetos que habra en el mapa, es decir, cajas, barriles, arbustos, etc, etc.
    const limiteDeEnemigosEnMapa
    const property siguienteNivel

    method crearNivel(){
        (0 .. layout.size() - 1).forEach({ y =>
            (0 .. layout.get(y).size() - 1).forEach({ x =>
                layout.get(y).get(x).crear(game.at(x, y), elementosEnNivel)
            })
        })
    }

    method spawnearEnemigos(){
        game.onTick(tiempoDeSpawn, "Spawn de enemigos del nivel", {self. spawnearSiguienteEnemigo()})
    }

    method spawnearSiguienteEnemigo(){
        if (!enemigos.isEmpty()){
            if (self.hayEspacioParaSpawnearEnemigo()){
                const enemigoASpawnear = enemigos.anyOne()
                ejercitoDeNivel.agregarEnemigo(enemigoASpawnear)
                enemigos.remove(enemigoASpawnear)
            }
        } else {
            game.removeTickEvent("Spawn de enemigos del nivel")
        }
    }

    method hayEspacioParaSpawnearEnemigo(){
        return limiteDeEnemigosEnMapa > ejercitoDeNivel.cantidadDeEnemigosEnMapa()
    }

    method jugarNivel(){
        game.boardGround("fondo_nivel.png")
        self.crearNivel()
        enemigos = enemigosIniciales
        self.spawnearEnemigos()
        ejercitoDeNivel.enemigosDanPaso()
        ejercitoDeNivel.enemigosPersiguen(personaje) // Hay que cambiar esto, para no usar la referencia global de personaje
    }

    method reiniciarNivel(){
        ejercitoDeNivel.matarTodos()
        enemigos = enemigosIniciales
        self.spawnearEnemigos()
        ejercitoDeNivel.enemigosDanPaso()
        ejercitoDeNivel.enemigosPersiguen(personaje)
    }

    method siguienteNivel(){
        return self
    }
}

const primerNivel = new Nivel(
layout = [[_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
          [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
          [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
          [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
          [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
          [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
          [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
          [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
          [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
          [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
          [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
          [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
          [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
          [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
          [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
          [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
          [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
          [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
          [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
          [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
          [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_]].reverse(),
enemigosIniciales = [zmb, zmb, zmb, zmb],
siguienteNivel = segundoNivel, limiteDeEnemigosEnMapa = 3, tiempoDeSpawn =350, ejercitoDeNivel = ejercito, elementosEnNivel = elementosDelMapa)

const segundoNivel = new Nivel(
layout = [[_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
          [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
          [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
          [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
          [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
          [_,_,_,_,_,m,m,m,_,_,_,_,_,m,m,m,_,_,_,_,_],
          [_,_,_,_,_,m,_,_,_,_,_,_,_,_,_,m,_,_,_,_,_],
          [_,_,_,_,_,m,_,_,_,_,_,_,_,_,_,m,_,_,_,_,_],
          [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
          [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
          [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
          [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
          [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
          [_,_,_,_,_,m,_,_,_,_,_,_,_,_,_,m,_,_,_,_,_],
          [_,_,_,_,_,m,_,_,_,_,_,_,_,_,_,m,_,_,_,_,_],
          [_,_,_,_,_,m,m,m,_,_,_,_,_,m,m,m,_,_,_,_,_],
          [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
          [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
          [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
          [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
          [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_]].reverse(),
enemigosIniciales = [zmb, zmb, zmb, zmb,
                     zmb, zmb, zmb, zmb,
                     acz, vmp, vmp, acz,
                     zmb, zmb, zmb, zmb,
                     zmb, zmb, zmb, zmb],
siguienteNivel = tercerNivel, limiteDeEnemigosEnMapa = 4, tiempoDeSpawn =350, ejercitoDeNivel = ejercito, elementosEnNivel = elementosDelMapa)

const tercerNivel = new Nivel(
layout = [[_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
          [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
          [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
          [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
          [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
          [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
          [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
          [_,_,_,_,_,_,_,m,_,_,_,_,_,m,_,_,_,_,_,_,_],
          [_,_,_,_,_,_,_,m,_,_,_,_,_,m,_,_,_,_,_,_,_],
          [_,_,_,_,_,_,_,m,_,_,_,_,_,m,_,_,_,_,_,_,_],
          [_,_,_,_,_,_,_,m,_,_,_,_,_,m,_,_,_,_,_,_,_],
          [_,_,_,_,_,_,_,m,_,_,_,_,_,m,_,_,_,_,_,_,_],
          [_,_,_,_,_,_,_,m,_,_,_,_,_,m,_,_,_,_,_,_,_],
          [_,_,_,_,_,_,_,m,m,m,m,m,m,m,_,_,_,_,_,_,_],
          [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
          [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
          [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
          [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
          [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
          [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
          [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_]].reverse(),
enemigosIniciales = [zmb, zmb, zmb, zmb,
                     zmb, zmb, zmb, zmb,
                     acz, vmp, vmp, acz,
                     zmb, zmb, zmb, zmb,
                     zmb, zmb, zmb, zmb],
siguienteNivel = ultimoNivel, limiteDeEnemigosEnMapa = 4, tiempoDeSpawn =350, ejercitoDeNivel = ejercito, elementosEnNivel = elementosDelMapa)

const ultimoNivel = new Nivel(
layout = [[_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
          [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
          [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
          [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
          [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
          [_,_,_,_,_,m,m,m,m,m,_,m,m,m,m,m,_,_,_,_,_],
          [_,_,_,_,_,m,_,_,_,_,_,_,_,_,_,m,_,_,_,_,_],
          [_,_,_,_,_,m,_,_,_,_,_,_,_,_,_,m,_,_,_,_,_],
          [_,_,_,_,_,m,_,_,_,_,_,_,_,_,_,m,_,_,_,_,_],
          [_,_,_,_,_,m,_,_,_,_,_,_,_,_,_,m,_,_,_,_,_],
          [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
          [_,_,_,_,_,m,_,_,_,_,_,_,_,_,_,m,_,_,_,_,_],
          [_,_,_,_,_,m,_,_,_,_,_,_,_,_,_,m,_,_,_,_,_],
          [_,_,_,_,_,m,_,_,_,_,_,_,_,_,_,m,_,_,_,_,_],
          [_,_,_,_,_,m,_,_,_,_,_,_,_,_,_,m,_,_,_,_,_],
          [_,_,_,_,_,m,m,m,m,m,_,m,m,m,m,m,_,_,_,_,_],
          [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
          [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
          [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
          [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
          [_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_]].reverse(),
enemigosIniciales = [zmb, zmb, zmb, zmb,
                     zmb, zmb, zmb, zmb,
                     acz, vmp, vmp, acz,
                     zmb, zmb, zmb, zmb,
                     zmb, zmb, zmb, zmb],
siguienteNivel = ultimoNivel, limiteDeEnemigosEnMapa = 5, tiempoDeSpawn =350, ejercitoDeNivel = ejercito, elementosEnNivel = elementosDelMapa)