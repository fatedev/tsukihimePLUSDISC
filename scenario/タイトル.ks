;------------------------------------------------------------------------------
;	Copyright (C) TYPE-MOON All Rights Reserved.
;		タイトル画面
;------------------------------------------------------------------------------
;--	ロゴ ----------------------------------------------------------------------
@call storage=ロゴ.ks

;--	タイトル表示 --------------------------------------------------------------
*title|タイトル
@startanchor
;タイトルメニュー表示
@current layer=message page=back
@position opacity=0
@nowait
@locate x=499 y=206
@button graphic=幻視同盟 storage=幻視同盟.ks hint=「幻視同盟」を開始します。 onenter="playSoundBuffer('plus_se01.wav')" exp="playSoundBuffer('plus_se02.wav')"
@locate x=508 y=248
@button graphic=げっちゃ storage=げっちゃ.ks hint=「げっちゃ」を開始します。 onenter="playSoundBuffer('plus_se01.wav')" exp="playSoundBuffer('plus_se02.wav')"
@locate x=491 y=290
@button graphic=げっちゃ2 storage=真・弓塚夢想3.ks hint=「げっちゃ2」を開始します。 onenter="playSoundBuffer('plus_se01.wav')" exp="playSoundBuffer('plus_se02.wav')"
@locate x=421 y=331
@button graphic=きのこ名作実験場 storage=きのこ名作実験場.ks hint=「きのこ名作実験場」を開始します。 onenter="playSoundBuffer('plus_se01.wav')" exp="playSoundBuffer('plus_se02.wav')"
@locate x=542 y=373
@button graphic=壁紙 storage=ギャラリー.ks hint=壁紙コーナーを開きます。 onenter="playSoundBuffer('plus_se01.wav')" exp="playSoundBuffer('plus_se02.wav')"
@locate x=543 y=415
@button graphic=終了 target=*quit hint=PLUS+DISCを終了します。 onenter="playSoundBuffer('plus_se01.wav')" exp="playSoundBuffer('plus_se02.wav')"
;メニュー表示
@layopt layer=message page=back visible=true
@fadein file=menu_bg time=800
@current layer=message page=fore
@layopt layer=message page=back visible=true
;動作停止
@endnowait
@s

;-- ギャラリーから戻ってきたとき ---
*return_from_gallery
@cm
@nowait
@locate x=499 y=206
@button graphic=幻視同盟 storage=幻視同盟.ks hint=「幻視同盟」を開始します。 onenter="playSoundBuffer('plus_se01.wav')" exp="playSoundBuffer('plus_se02.wav')"
@locate x=508 y=248
@button graphic=げっちゃ storage=げっちゃ.ks hint=「げっちゃ」を開始します。 onenter="playSoundBuffer('plus_se01.wav')" exp="playSoundBuffer('plus_se02.wav')"
@locate x=491 y=290
@button graphic=げっちゃ2 storage=真・弓塚夢想3.ks hint=「げっちゃ2」を開始します。 onenter="playSoundBuffer('plus_se01.wav')" exp="playSoundBuffer('plus_se02.wav')"
@locate x=421 y=331
@button graphic=きのこ名作実験場 storage=きのこ名作実験場.ks hint=「きのこ名作実験場」を開始します。 onenter="playSoundBuffer('plus_se01.wav')" exp="playSoundBuffer('plus_se02.wav')"
@locate x=542 y=373
@button graphic=壁紙 storage=ギャラリー.ks hint=壁紙コーナーを開きます。 onenter="playSoundBuffer('plus_se01.wav')" exp="playSoundBuffer('plus_se02.wav')"
@locate x=543 y=415
@button graphic=終了 target=*quit hint=PLUS+DISCを終了します。 onenter="playSoundBuffer('plus_se01.wav')" exp="playSoundBuffer('plus_se02.wav')"
@endnowait
@s

;-- 終わる ---
*quit
@layopt layer=message page=back visible=false
@flushover time=1000
@wait time=500
@eval exp="kag.shutdown()"
