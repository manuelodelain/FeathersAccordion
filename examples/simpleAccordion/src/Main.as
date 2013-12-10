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
	[SWF(backgroundColor="#FFFFFF", frameRate="60", width="800", height="600")] 
	public class Main extends Sprite
	{
		
		protected var _starling:Starling;
		protected var _app:Root;
		
		public function Main()
		{
			mouseEnabled = false;
			mouseChildren = false;
			
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.LEFT;
			
			stage.addEventListener(flash.events.Event.RESIZE, _onResizeStage);
		}

		private function _onResizeStage(event:flash.events.Event):void
		{
			stage.removeEventListener(flash.events.Event.RESIZE, _onResizeStage);
			
			_init();
		}

		private function _init():void
		{
			_starling = new Starling(Root, stage);
			_starling.addEventListener(starling.events.Event.ROOT_CREATED, _onRootCreated);
		}
		
		protected function _startApp():void
		{
			_starling.start();
		}

		protected function _onRootCreated(event:starling.events.Event, app:Root):void
		{
			trace('_onRootCreated: ' + (_onRootCreated));
			_starling.removeEventListener(starling.events.Event.ROOT_CREATED, _onRootCreated);

			_app = app;

			_startApp();
		}
	}
}
