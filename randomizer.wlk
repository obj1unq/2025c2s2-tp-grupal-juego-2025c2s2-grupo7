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
		const widthAndHeight = game.width()-1 // Para que esto funcione bien, en la config del juego width == height
		const mitadWidthAndHeight = widthAndHeight.div(2)
		return 	[game.at([mitadWidthAndHeight - 1, mitadWidthAndHeight, mitadWidthAndHeight + 1].anyOne(), [0, widthAndHeight].anyOne()),
				 game.at([0, widthAndHeight].anyOne(), [mitadWidthAndHeight - 1, mitadWidthAndHeight, mitadWidthAndHeight + 1].anyOne())].anyOne()
	}
}