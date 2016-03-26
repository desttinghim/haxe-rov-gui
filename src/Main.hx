package ;

import hxSerial.Serial;
import haxe.ui.toolkit.core.Toolkit;
import haxe.ui.toolkit.themes.GradientTheme;
import haxe.ui.toolkit.core.Root;
import haxe.ui.toolkit.controls.Button;
import haxe.ui.toolkit.events.UIEvent;
import haxe.ui.toolkit.containers.ScrollView;
import haxe.ui.toolkit.containers.VBox;
import haxe.ui.toolkit.controls.Text;
import haxe.ui.toolkit.core.interfaces.IDisplayObject;
import haxe.ui.toolkit.core.ClassManager;
import components.LineGraph;

class Main {
	public static var serial : ROVSerial;

	public static function main() {

		serial = new ROVSerial();


		ClassManager.instance.registerComponentClass(LineGraph, "linegraph");
		Toolkit.init();
		Toolkit.open( viewSetup );

	} // main

	public static function viewSetup(root:Root):Void {
		var view : IDisplayObject = Toolkit.processXmlResource("layouts/main.xml");
		root.addChild(view);

		var portView = root.findChild("ports", VBox, true);
		var statsView = root.findChild("stats", VBox, true);

		// statsView.addChild(new LineGraph());

		var isComConnected = false;
		for(port in Serial.getDeviceList()) {
			if(~/.*(acm|com).*/i.match(port)) {
				isComConnected = true;
				var button = new Button();
				button.text = port;
				button.width = portView.width;
				button.onClick = function(event:UIEvent) {
					serial.serial = new Serial(port, 9600);
				};
				portView.addChild(button);
			}
		}
		if(!isComConnected) {
			// portView.text = "The ROV is unavailable. Is it plugged in?";
			var text = new Text();
			text.text = "The ROV is unavailable. Is it plugged in?";
			text.wrapLines = true;
			text.multiline = true;
			portView.addChild(text);
		}
	} // viewSetup

}