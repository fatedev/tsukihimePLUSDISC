;------------------------------------------------------------------------------
;	Copyright (C) TYPE-MOON All Rights Reserved.
;		吉里吉里初期化
;------------------------------------------------------------------------------
@eval exp="var Version='PLUS+DISC Ver.1.1'"
;初期表示レイヤーの設定
@image storage=white page=fore layer=base
@layopt layer=message page=fore visible=false
@wait time=100
;--	開始 ----------------------------------------------------------------------
*start
;しおり使用不可
@disablestore
;--	初期設定 ------------------------------------------------------------------
;マクロ宣言
@call storage=マクロ.ks

;OggVorbisの再生
@loadplugin module=wuvorbis.dll

;ロケット
@call storage=RocketPlugin.ks

;--	タイトル ------------------------------------------------------------------
@jump storage=タイトル.ks
