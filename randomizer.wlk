import wollok.game.*

object randomizer {
	method position() {
		return 	game.at( 
					(0 .. game.width() - 1 ).anyOne(),
					(0..  game.height() - 1).anyOne()
		) 
	}
	
	method emptyPosition() {
		const position = self.position()
		if(game.getObjectsIn(position).isEmpty()) {
			return position	
		}
		else {
			return self.emptyPosition()
		}
	}

	method posicionVaciaCentral(){
		const position = self.posicionParaEnemigo()
		if(game.getObjectsIn(position).isEmpty()) {
			return position	
		}
		else {
			return self.posicionVaciaCentral()
		}
	}

	method posicionParaEnemigo(){
		const width = 20  // game.width()-1, pero por ahora pongo el número directamente, ya que sino toma como que el tablero es 5x5 (se ejecuta antes de definir el tablero)
		const height = 20 // Deberia ser game.height()-1, idem arriba.
		const mitadWidth = width.div(2)
		const mitadHeight = height.div(2)
		return 	[game.at([mitadWidth - 1, mitadWidth, mitadWidth + 1].anyOne(), [0, height].anyOne()),
				 game.at([0, width].anyOne(), [mitadHeight - 1, mitadHeight, mitadHeight + 1].anyOne())].anyOne()
	}
}