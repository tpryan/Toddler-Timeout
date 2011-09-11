package com.terrenceryan.timeout
{
	import flash.utils.Timer;

	public class Kid
	{
		
		private var _name:String;
		private var _timeout:int;
		private var _timer:Timer = new Timer(1,1);
		
		
		
		[Bindable]
		public function get name():String { return _name; }
		
		public function set name(value:String):void
		{
			if (_name == value)
				return;
			_name = value;
		}
		
		
		public function get timeout():int { return _timeout; }
		
		public function set timeout(value:int):void
		{
			if (_timeout == value)
				return;
			_timeout = value;
			resetTimer();
		}
		
		
		public function get timer():Timer { return _timer; }
		
		public function set timer(value:Timer):void
		{
			if (_timer == value)
				return;
			_timer = value;
		}
		
		public function get timeoutLeft():int { return _timer.repeatCount - _timer.currentCount; }
		
		public function resetTimer():void
		{
			_timer = new Timer(1,1);
			_timer.repeatCount = _timeout;
			_timer.delay = 1000;
		}
		
		public function cancelTimer():void
		{
			_timer = null;
			_timer = new Timer(1,1);
			_timer.stop();
			_timer.repeatCount = _timeout;
			_timer.delay = 1000;
			
		}
		
		
		public function get clockReadout():String{
			var timeleft:int = timeoutLeft;
			var min:int = Math.floor(timeleft/60); 
			var sec:int = timeleft % 60;
			
			var minutes:String = min.toString();
			var seconds:String = sec.toString();
			
			if (seconds.length == 1){
				seconds = "0" + seconds;
			}
			return minutes + ":" + seconds;
		}
		
		
	}
}