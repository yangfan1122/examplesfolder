package
{
	import D5Power.Controller.KeyController;
	import D5Power.Controller.MonsterController;
	import D5Power.Objects.ActionObject;
	import D5Power.Objects.Monster;
	import D5Power.Objects.Player;
	import D5Power.Scene.gameScene;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author yangfan1122@gmail.com
	 */
	public class Main extends Sprite
	{
		
		public function Main()
		{
			var scene:gameScene = new gameScene(stage);		// 声明游戏舞台
			var ctrl:KeyController = new KeyController();	// 定义控制器
			var obj:Player = new Player(ctrl, new Skin1());
			obj.x = 200;
			obj.y = 200;
			scene.addObject(obj);// 将对象添加到舞台中
			
			for (var i:uint = 0; i < 3; i++)
			{
				var ctrl2:MonsterController = new MonsterController();
				var monster:Monster = new Monster(ctrl2, new Skin2());
				monster.x = int(Math.random() * 500);
				monster.y = int(Math.random() * 300);
				scene.addObject(monster);
			}
			// 显示游戏舞台
			addChild(scene);
			
			
			
		}
	
	}

}