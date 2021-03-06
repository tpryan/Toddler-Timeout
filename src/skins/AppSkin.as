package skins
{
	import flash.system.Capabilities;
	
	import spark.components.Group;
	import spark.components.ViewNavigator;
	import spark.primitives.BitmapImage;
	import spark.skins.mobile.ViewNavigatorApplicationSkin;
	import spark.skins.mobile.supportClasses.MobileSkin;
	
	public class AppSkin extends ViewNavigatorApplicationSkin
	{
		
		[Bindable]
		[Embed(source="/assets/backgroundStartBurst.png")]
		private var bgClass:Class;
		
		private var bg:BitmapImage = new BitmapImage();
		
		public function AppSkin()
		{
			super();
			var holderGroup:Group = new Group();
			addChild(holderGroup);
			bg.source = bgClass;
			
			bg.width = 1500;
			bg.height = 1500;
			holderGroup.addElement(bg);
			
		}
		
		
		override protected function layoutContents(unscaledWidth:Number, unscaledHeight:Number):void
		{
			super.layoutContents(unscaledWidth, unscaledHeight);
			bg.x = -750 + unscaledWidth/2;
			bg.y = -750 + unscaledHeight/2;
			
		}
		
	}
}