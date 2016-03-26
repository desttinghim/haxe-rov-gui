package components;

import haxe.ui.toolkit.core.Component;

class LineGraph extends Component {

	public var xmax:Float = 100;
	public var ymax:Float = 100;

	public var xlineinterval:Float = 10;
	public var ylineinterval:Float = 10;

	public var dataset:List<{ x: Float, y: Float}>;

	public function new() {
		super();

		xmax = 100;
		ymax = 100;
		xlineinterval = 10;
		ylineinterval = 10;

		dataset = new List<{x:Float,y:Float}>();
		dataset.add({x: 25, y: 25});
		dataset.add({x: 50, y: 30});
		dataset.add({x: 75, y: 50});

		updateGraph();
	}

	public function updateGraph() {
		graphics.clear();
		graphics.beginFill(0xffffff);
		graphics.drawRect(0, 0, xmax, ymax);
		graphics.endFill();
		graphics.lineStyle(1.0, 0xaaaaaa);
		// Iterate over vertical lines
		var i:Float = 0;
		while(i < xmax) {
			// Draw vertical line
			graphics.moveTo(i, 0);
			graphics.lineTo(i, ymax);
			i += xlineinterval;
		}
		// Iterate over horizontal lines
		i = 0;
		while(i < ymax) {
			// Draw horizontal line
			graphics.moveTo(0, i);
			graphics.lineTo(xmax, i);
			i += ylineinterval;
		}

		graphics.moveTo(0, ymax);
		graphics.lineStyle(2.0, 0xddaadd);
		for(point in dataset) {
			graphics.lineTo(point.x, ymax-point.y);
			graphics.drawCircle(point.x, ymax-point.y, 2);
		}
	}

}