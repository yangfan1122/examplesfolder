package
{
	import com.adobe.utils.AGALMiniAssembler;
	
	import flash.display.Sprite;
	import flash.display.Stage3D;
	import flash.display3D.Context3D;
	import flash.display3D.Context3DProgramType;
	import flash.display3D.Context3DVertexBufferFormat;
	import flash.display3D.IndexBuffer3D;
	import flash.display3D.Program3D;
	import flash.display3D.VertexBuffer3D;
	import flash.events.Event;
	import flash.geom.Matrix3D;
	import flash.geom.Rectangle;
	import flash.geom.Vector3D;
	import flash.utils.getTimer;
	import flash.text.TextField;
	
	[SWF(width="800",height="600",frameRate="60",backgroundColor="#EEEEEE")]
	
	public class HelloTriangleColored extends Sprite
	{
		protected var context3D:Context3D;
		protected var program:Program3D;
		protected var vertexbuffer:VertexBuffer3D;
		protected var indexbuffer:IndexBuffer3D;
		
		public function HelloTriangleColored()
		{
			stage.stage3Ds[0].addEventListener(Event.CONTEXT3D_CREATE, initMolehill);
			stage.stage3Ds[0].requestContext3D();//申请获取Context3D对象
			
			addEventListener(Event.ENTER_FRAME, onRender);
			
			
			
			
			
			var t:TextField = new TextField();
			addChild(t);
			t.text = "1111";
			t.x = 0;
			t.y = 0;
		
		}
		
		/*
			这里需要注意Event.CONTEXT3D_CREATE事件可能多次发生，假如其他程序中断了Flash Player的GPU使用权后Flash Player重新获得其使用权，则会再次发生Event.CONTEXT3D_CREATE事件。假如你在Event.CONTEXT3D_CREATE事件的回调中做了一些初始化工作，那么就要小心了，如果你不及时移除监听，就有重复初始化的隐患。
		*/
		protected function initMolehill(e:Event):void
		{
			context3D = stage.stage3Ds[0].context3D;
			context3D.configureBackBuffer(800, 600, 1, true);
			
			
			//图形 ----------
			
			var vertices:Vector.<Number> = Vector.<Number>([-0.3, -0.3, 0, 1, 0, 0, // x, y, z, r, g, b
				-0.3, 0.3, 0, 0, 1, 0, 0.3, 0.3, 0, 0, 0, 1]);
			
			
			//创建一个VertextBuffer3D实例，以便将Vertext Buffer上传至GPU。
			// Create VertexBuffer3D. 3 vertices, of 6 Numbers each
			vertexbuffer = context3D.createVertexBuffer(3, 6);//顶点缓冲
			// Upload VertexBuffer3D to GPU. Offset 0, 3 vertices
			vertexbuffer.uploadFromVector(vertices, 0, 3);//第三个参数：顶点数量。
			
			
			//还需要一个Index Buffer来定义三角形
			var indices:Vector.<uint> = Vector.<uint>([0, 1, 2]);
			
			// //图形 ----------
			
			
			// Create IndexBuffer3D. Total of 3 indices. 1 triangle of 3 vertices
			indexbuffer = context3D.createIndexBuffer(3);//顶点索引
			// Upload IndexBuffer3D to GPU. Offset 0, count 3
			indexbuffer.uploadFromVector(indices, 0, 3);
			
			var vertexShaderAssembler:AGALMiniAssembler = new AGALMiniAssembler();
			//assemble汇编, vertex顶点
			//输出寄存器op，用于顶点着色器
			//从着色器中访问该属性寄存器的语法：va<n>，其中<n>是属性寄存器的索引号。
			//从着色器中访问这些寄存器(常量寄存器)的语法：vc<n>，用于顶点着色器
			//变量寄存器v0
			vertexShaderAssembler.assemble(Context3DProgramType.VERTEX, "m44 op, va0, vc0\n" + // pos to clipspace
				"mov v0, va1" // copy color
				);
			
			var fragmentShaderAssembler:AGALMiniAssembler = new AGALMiniAssembler();
			//fragment片段
			//输出寄存器oc，用于像素着色器
			fragmentShaderAssembler.assemble(Context3DProgramType.FRAGMENT, "mov oc, v0");
			
			program = context3D.createProgram();//Program3D对象负责储存着色器程序。
			
			/*
				我们可以通过Program3D对象的upload方法上传程序，该方法接收两个参数，第一个是顶点着色器程序（Vertex Shader），
			另外一个是段着色器程序（Fragment Shader）。但是请注意，upload的两个参数类型是字节数组（ByteArray）而非字符串（String），
			所以我们需要AGALMiniAssembler对象来帮助我们把字符串的着色器程序变成字节数组。
			通过AGALMiniAssembler对象的assemble方法可以达到上述功能。该方法第一个参数是程序类型，可能值是两个，
			一个是"vertex"，表示第二个参数是顶点着色器程序，另外一个是"fragment"，代表第二个参数是段着色器程序。
			*/
			program.upload(vertexShaderAssembler.agalcode, fragmentShaderAssembler.agalcode);
		}
		
		protected function onRender(e:Event):void
		{
			if (!context3D)
				return;
			
			context3D.clear(1, 1, 1, 1);
			
			// vertex position to attribute register 0
			context3D.setVertexBufferAt(0, vertexbuffer, 0, Context3DVertexBufferFormat.FLOAT_3);
			// color to attribute register 1
			context3D.setVertexBufferAt(1, vertexbuffer, 3, Context3DVertexBufferFormat.FLOAT_3);
			// assign shader program
			context3D.setProgram(program);
			
			var m:Matrix3D = new Matrix3D();
			//m.appendRotation(getTimer() / 40, Vector3D.Z_AXIS);//旋转
			context3D.setProgramConstantsFromMatrix(Context3DProgramType.VERTEX, 0, m, true);
			
			context3D.drawTriangles(indexbuffer);
			
			context3D.present();
		}
	}
}