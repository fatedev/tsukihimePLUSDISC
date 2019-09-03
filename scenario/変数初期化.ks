;------------------------------------------------------------------------------
;	Copyright (C) 1999-2002 TYPE-MOON All Rights Reserved.
;		変数初期化
;------------------------------------------------------------------------------
*start
@iscript
if(!f.initalized)
{//情報が初期化されていなければ、初期化する
	//	メッセージレイヤー
	f.message_visible	= true;	//	状態
	f.message_fadetime	= 0;	//	メッセージレイヤーの表示/消去時間

	//	レイヤーの使用状況(ファイル名)
	f.layer_image	= new Dictionary();
	f.layer_image['base']	= "";	//	背景
	f.layer_image['0']		= "";	//	左端
	f.layer_image['2']		= "";	//	左中
	f.layer_image['4']		= "";	//	真ん中
	f.layer_image['3']		= "";	//	右中
	f.layer_image['1']		= "";	//	右端

	//	短縮形
	f.curtailed_word	= new Dictionary();
	f.curtailed_word['left']		= "l";
	f.curtailed_word['l']			= "l";
	f.curtailed_word['leftcenter']	= "lc";
	f.curtailed_word['lc']			= "lc";
	f.curtailed_word['center']		= "c";
	f.curtailed_word['c']			= "c";
	f.curtailed_word['rightcenter']	= "rc";
	f.curtailed_word['rc']			= "rc";
	f.curtailed_word['right']		= "r";
	f.curtailed_word['r']			= "r";

	//	立ち絵位置とレイヤーの関係
	f.layer_no		= new Dictionary();
	f.layer_no['l']	= "0";
	f.layer_no['lc']= "2";
	f.layer_no['c']	= "4";
	f.layer_no['rc']= "3";
	f.layer_no['r']	= "1";

	//	SEバッファ(0〜2(kag.numSEBuffer-1)の間で変わる)
	f.current_SEbuffer	= 0;
	f.current_SEfile	= new Array();	//	ループ再生中の効果音ファイル名
	//	※	マクロ中で追加されたハッシュメンバは、永続的には記録されない。
	//		なので、バッファ番号毎に再生中のファイル名を記録しておく
	for(var i=0; i<kag.numSEBuffers; i++)
		f.current_SEfile[i]		= '';

	f.initialized	= true;
}
@endscript
@return
