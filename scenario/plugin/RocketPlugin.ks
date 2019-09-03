;------------------------------------------------------------------------------
;	Copyright (C) TYPE-MOON All Rights Reserved.
;		特定の立ち絵のみに移動及び拡大・縮小(回転も？)を行う
;------------------------------------------------------------------------------
@if exp="typeof(global.rocket_object) == 'undefined'"
@iscript
Scripts.execStorage("RenderPlugin.tjs");

dm("Rocket Plugin Loaded.");
class RocketPlugin extends RenderPlugin
{
	var tmplayer;

	var layer, layerno;
	var mx, my;
	var magnify;
	var opacity;
//	var cx, cy;
//	var rot;
	var interpolationmode	= stFastLinear;

	var lastvalue;

	var magwidth, magheight;
	var gradientopacity;

	var valuenames = [ "left", "top", "imageWidth", "imageHeight", "width", "height", "opacity" ];

	function RocketPlugin(window)
	{
		super.RenderPlugin(...);
		lastvalue	= %[];
		triggername	= "rocket";
	}

	function finalize()
	{
		stop();

		release(lastvalue);
		super.finalize(...);
	}

	function init(elm)
	{
//		finish();

		//	規定値
		mx	= my	= 0;
		magnify		= 1.0;
		opacity		= 255;

		//	設定値の取得
		if(elm.layer[0]=="l" || elm.layer[0]=="c" || elm.layer[0]=="r")
			layerno	= f.layer_no[f.curtailed_word[elm.layer]];
		else
			layerno	= +elm.layer;
		mx		= +elm.mx if elm.mx!==void;		//	移動量
		my		= +elm.my if elm.my!==void;
		magnify	= +elm.magnify if elm.magnify!==void;	//	拡大率
		opacity	= +elm.opacity if elm.opacity!==void;	//	不透明度
/*		if(center!==void)
		{
			switch(center)
			{
			case "lt":
			case "ct":
			case "rt":
			case "lm":
			case "cm":
			case "rm":
			case "lb":
			case "cb":
			case "rb":
			}
		}
		else
		{
			cx	= +elm.cx if elm.cx!==void;
			cy	= +elm.cy if elm.cy!==void;
		}
		rot		= +elm.rot if elm.rot!==void;		//	回転
*/
		interpolationmode	= elm.mode if elm.mode!==void;	//	補間モード

		//	現在の画像を保存する
		var fore = window.fore;
		layer	= fore.layers[layerno];
		dm("layer.name: "+layer.name);
		tmplayer= new global.Layer(window, fore.base);
		with(tmplayer)
		{
			.setImageSize(layer.imageWidth, layer.imageHeight);
			.setSizeToImageSize();
			.piledCopy(0, 0, layer, 0, 0, layer.imageWidth, layer.imageHeight);
		}

		//	現在の前景レイヤー情報を保存する
		(Dictionary.clear incontextof lastvalue)();
		for(var i=0; i<valuenames.count; i++)
			lastvalue[valuenames[i]]	= layer[valuenames[i]];

		//	ワークの計算
		magwidth	= layer.width * (magnify - 1.0);
		magheight	= layer.height * (magnify - 1.0);
		gradientopacity	= opacity - layer.opacity;

		start(elm);	//	開始
	}

	function render(per)
	{
		var l, t, w, h;

		with(lastvalue)
		{
			w = .width + magwidth * per;
			h = .height + magheight * per;
			l = .left + (.width >> 1) + mx * per - (w >> 1);
			t = .top + (.height >> 1) + my * per - (h >> 1);
		}

		with(layer)
		{
			.setPos(l, t);
			.setSize(w, h);
			.stretchCopy(0, 0, w, h, tmplayer, 0, 0, tmplayer.imageWidth, tmplayer.imageHeight, interpolationmode);
			.opacity	= lastvalue.opacity + gradientopacity * per;
		}
	}

	function finish()
	{
		//	レイヤーを元の状態に戻す
		if(rendering)
		{
			layer.visible	= false;
			for(var i=0; i<valuenames.count; i++)
				layer[valuenames[i]]	= lastvalue[valuenames[i]];
		}
	}
}
// プラグインオブジェクトを作成し、登録する
kag.addPlugin(global.rocket_object = new RocketPlugin(kag));

@endscript
@endif

;マクロを登録
@macro name="rocket"
@eval exp="rocket_object.init(mp)"
@endmacro

@macro name="wrocket"
@if exp="rocket_object.rendering"
@waittrig * name="rocket" onskip="rocket_object.finish()" canskip=%canskip|true
@endif
@endmacro

@return
;------------------------------------------------------------------------------
;	End of File
;------------------------------------------------------------------------------
