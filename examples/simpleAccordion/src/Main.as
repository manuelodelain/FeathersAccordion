package simpleAccordion.src
{
	import starling.core.Starling;
	import starling.events.Event;

	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	/**
	 * @author Manuel Odelain
	 */
	[SWF(backgroundColor="#4a4137", frameRate="60", width="800", height="600")] 
	public class Main extends Sprite
	{
		
		protected var _starling:Starling;
		protected var _app:Root;
		
		public function Main()
		{
			_init();
		}

		private function _init():void
		{
            mouseEnabled = false;
			mouseChildren = false;
			
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.LEFT;
            
			_starling = new Starling(Root, stage);
			_starling.addEventListener(starling.events.Event.ROOT_CREATED, _onRootCreated);
		}
		
		protected function _startApp():void
		{
			_starling.start();
            _app.start();
		}

		protected function _onRootCreated(event:starling.events.Event, app:Root):void
		{
			_starling.removeEventListener(starling.events.Event.ROOT_CREATED, _onRootCreated);

			_app = app;

			_startApp();
		}
	}
}
