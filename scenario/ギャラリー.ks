;------------------------------------------------------------------------------
;	Copyright (C) TYPE-MOON All Rights Reserved.
;		ギャラリーメニュー
;------------------------------------------------------------------------------
@if exp="typeof(global.gallerymenu) == 'undefined'"
@iscript
Scripts.execStorage("ExButtonLayer.tjs");
Scripts.execStorage("subroutine.tjs");
Scripts.execStorage("ShrinkLayer.tjs");
Scripts.execStorage("SlideUpLayer.tjs");
Plugins.link("wallpaper.dll");

var GalleryImageListFiles	= %[
	"default"	=> "ギャラリー.txt",
];

var ThumbnailSuffix			= "_thumb";
var ThumbnailPendingImage	= "gl_pending";

Scripts.execStorage("GalleryThumbnailsLayer.tjs");	//	サムネールを表示するレイヤー
Scripts.execStorage("GalleryImageLayer.tjs");		//	全画面の画像を表示するレイヤー

//	ギャラリーメニュー
class GalleryMenuLayer extends FadeLayer
{
	var plugin;
	var _gid;

	var bgimage	= "壁紙選択背景";

	var buttons;
	var buttondata = [
		[ 3, "leftpage",	"gl_leftpage",	"左ページを表示します。", 232, 362 ],
		[ 3, "rightpage",	"gl_rightpage",	"右ページを表示します。", 353, 362 ],
		[ 3, "back",		"gl_back",		"タイトルメニューに戻ります。", 522, 424 ],
	];

	var thumbnails;
	var imagelayer;
	var namecard;
	var pagecount;
	var curpage;
	var pagecount_width_3;
	var extension	= "_name";
	var whisker		= 6;
	var last_position;

	var filenames;

	var default_time	= 300;
	var default_accel	= 0;

	var slide_time	= 200;
	var slide_accel	= -3;

	var enter_se	= "plus_se01.wav";
	var return_se	= "plus_se07.wav";
	var openwp_se	= "plus_se05.wav";

	function GalleryMenuLayer(win, par, plugin, gid="default")
	{
		super.FadeLayer(...);
		this.plugin	= plugin;
		name	= "ギャラリー["+gid+"]";
		var w, h;
		setSize(w = win.scWidth, h = win.scHeight);
		loadImages(bgimage);
		hitType		= htMask;
		hitThreshold= 0;	//	すべて非透過

		//	その他ボタン
		buttons = createButtons(win, this, buttondata);
		buttons.setAll("entersound", enter_se);

		//	サムネイル表示
		thumbnails = new GalleryThumbnailsLayer(win, this);
		thumbnails.visible	= true;

		//	ページ番号
		pagecount	= new global.Layer(win, this);
		with(pagecount)
		{
			.loadImages("pagecount");
			.setPos(292, 362);
			pagecount_width_3	= .imageWidth \ 3;
			.setSize(pagecount_width_3, .imageHeight);
			.setImagePos(0, 0);
			.visible	= true;
		}
		curpage	= 0;

		//	名札
		namecard	= new SlideUpLayer(win, this, 0, 0);

		//	画像表示
		imagelayer = new GalleryImageLayer(win, this);

		_gid	= gid;
		reload();
	}

	function finalize()
	{
		release(filenames);
		release(imagelayer);
		release(thumbnails);
		release(buttons);
		super.finalize(...);
	}

	function show(time=default_time, accel=default_accel)
	{
//		changeBGM();
		super.show(time, accel);
		delayFocus(50, thumbnails);

		thumbnails.changeOrifice();
		setMode();
	}

	function hide(time=default_time, accel=default_accel)
	{
		removeMode();
		super.hide(time, accel, onClosed);
		playSoundBuffer(return_se);
	}

	//	galleryidにあわせたサムネール・タイトルを読み込む
	function reload()
	{
		//	表示する画像をリストアップする
		release(filenames);
		filenames	= [];

		var file;
		var pi = ThumbnailPendingImage;
		var suffix = ThumbnailSuffix;
		if((file = GalleryImageListFiles[galleryid])!=void)
		{
			var lines = [].load(file);
			for(var i=0; i<lines.count; i++)
			{
				if(lines[i].length < 1 || lines[i][0] == "#")
					continue;

				filenames.add(lines[i]);
			}
		}
		imagelayer.filenames = filenames;

		thumbnails.loadThumbnails(filenames);

		//	終わったら開く
		thumbnails.changeOrifice();
	}

	//	画像を表示する
	function displayImage(itemno)
	{
		imagelayer.show(itemno, 300, 2);
		playSoundBuffer(openwp_se);
	}

	//	フォーカスを受け取るか
	function setFocusable(flag=true)
	{
		buttons.setAll("focusable", flag);
		thumbnails.focusable	= flag;
	}

	function onMouseDown(x, y, button, shift)
	{
		if(button == mbRight)
			hide();
	}

	function onButtonDown(btn)
	{
		switch(btn.id)
		{
		case "back":
			//	タイトルメニューへ戻る
			hide();
			break;

		case "leftpage":
			//	左のページを表示
			thumbnails.move("right");
			curpage--;
			curpage	= 2 if curpage<0;
			pagecount.imageLeft	= -curpage * pagecount_width_3;
			break;

		case "rightpage":
			//	右のページを表示
			thumbnails.move("left");
			curpage++;
			curpage	= 0 if curpage>2;
			pagecount.imageLeft	= -curpage * pagecount_width_3;
			break;
		}
	}

	function onClosed()
	{
		thumbnails.orifice	= 0;	//	閉じる
		plugin.onMenuClosed();
	}

	function onIndicate(no, l, t)
	{
		//	壁紙作者名の表示
		namecard.loadImages(filenames[no]+extension);
		namecard.setBasePosition(l+thumbnails.left-whisker, t+thumbnails.top-namecard.imageHeight+whisker);
		namecard.slideUp(slide_time, slide_accel);
	}

	function onDigress()
	{
		//	作者名表示を閉じる
		namecard.slideDown(slide_time, slide_accel);
	}

	function onReIndicate()
	{
		//	再度同じ作者名表示を行う
		namecard.slideUp(slide_time, slide_accel);
	}

	property galleryid
	{
		setter(id)
		{
			if(galleryid != id)
			{
				_gid = id;

				//	タイトル・サムネール変更開始
				thumbnails.changeOrifice(0,,,reload);
			}
		}
		getter	{ return _gid; }
	}
}

//	ギャラリープラグイン
class GalleryMenuPlugin extends KAGPlugin
{
	var window;	// ウィンドウへの参照
	var menu;	// メニューレイヤー

	var opened;	//	開いているか

	function GalleryMenuPlugin(window)
	{
		super.KAGPlugin();		// スーパークラスのコンストラクタを呼ぶ
		this.window = window;	// window への参照を保存する

		opened	= false;
	}

	function finalize()
	{
		invalidate menu if menu !== void;
		super.finalize(...);
	}

	function show()
	{
		if(!opened)
		{
			opened	= true;

			// 表示
			if(menu === void)
				menu = new GalleryMenuLayer(window, window.fore.base, this);
			menu.parent = window.fore.base;
			dm(@"menu parent: ${menu.parent}");
				// 親を再設定する
				// (トランジションによって表背景レイヤは変わるため)
			menu.show();
		}
	}

	function close()
	{
		if(opened)	//	openedのチェックすると、ロックしてしまったので
		{
			menu.hide() if menu !== void;
			onMenuClosed();
		}
	}

	function onMenuClosed()
	{
		opened	= false;
		//	戻る
		window.process("タイトル.ks", "*return_from_gallery", true);
	}
}

kag.addPlugin(global.gallerymenu = new GalleryMenuPlugin(kag));
@endscript
@endif

@eval exp="gallerymenu.show()"
@s