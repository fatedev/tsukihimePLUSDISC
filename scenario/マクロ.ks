;#------------------------------------------------------------------------------
;#	Copyright (C) 1999-2002 TYPE-MOON All Rights Reserved.
;#		マクロ第2弾
;$macro=<<'ENDOFMACRO';
;------------------------------------------------------------------------------
@call storage=変数初期化.ks
;FUNC--------------------------------------------------------------------------
;	ページを変更して文字を消去
;------------------------------------------------------------------------------
@macro name=pg
;@eval exp="dm('macro: pg')"
@p
@cm
@endmacro

;FUNC---------------------------------------------------------------------------
;	シーンスキップマクロ
;	※各シナリオの先頭(ラベル直後)で呼び出す
;------------------------------------------------------------------------------
@macro name=skipcheck
;@eval exp="dm('macro: sceneskipcheck')"
;既読スキップの有効と、既読フラグのチェック
;@trace exp="kag.Ch2ndSkip"
;@trace exp="kag.currentRecordName"
@if exp="kag.Ch2ndSkip && sf[kag.currentRecordName]"
;チェックなしスキップか、問い合わせた上でのスキップ
;@trace exp="kag.skipWithoutCheck"
@if exp="kag.skipWithoutCheck || askYesNo('「'+kag.currentPageName+'」は一度表示されたことがあります。スキップしますか？')"
;以降の処理を行わずにシナリオハブへ戻る
@return
@endif
@endif
;未読/既読だけど再度読む
@endmacro

;FUNC--------------------------------------------------------------------------
;	トランジション＋α
;------------------------------------------------------------------------------
@macro name=transex
;@eval exp="dm('macro: transex')"
;瞬間表示
@eval cond="kag.effectSkip" exp="mp.time=0"
@trans cond="mp.rule==''&&mp.method==''" * method=crossfade
@trans cond="mp.rule!=''||mp.method!=''" *
@endmacro

;FUNC--------------------------------------------------------------------------
;	メッセージの表示/非表示を切り替える
;------------------------------------------------------------------------------
@macro name=text
;@eval exp="dm('macro: text')"
@backlay layer=message
@eval exp="f.message_visible=!f.message_visible"
@layopt page=back layer=message visible=&f.message_visible
;瞬間表示
@eval cond="mp.time===void" exp="mp.time=f.message_fadetime"
;@trace exp="mp.time"
@eval cond="kag.effectSkip" exp="mp.time=0"
@trans time=&mp.time method=crossfade
@wt
@endmacro

;FUNC--------------------------------------------------------------------------
;	メッセージ表示モードへ
;		フェードしてメッセージ表示の状態へ。
;------------------------------------------------------------------------------
@macro name=texton
;@eval exp="dm('macro: texton')"
;テキストが表示されていないときのみ変更する
@text * cond="f.message_visible==false"
@endmacro

;FUNC--------------------------------------------------------------------------
;	画像変更モードへ
;		フェードして、画像表示モードへ。
;------------------------------------------------------------------------------
@macro name=textoff
;@eval exp="dm('macro: textoff')"
;テキストが表示されているときのみ変更する
@text * cond="f.message_visible!=false"
@endmacro

;FUNC--------------------------------------------------------------------------
;	画像描画
;	in	: storage	ファイル名
;		: layer		書き込み先レイヤー
;	※	本当は"imageEx"にしたかったが、macroタグでは大文字を区別するのにタグ呼び出しで
;		区別されないため、正しく呼び出すことが出来なかった。そのため"imageex"にした。
;------------------------------------------------------------------------------
@macro name=imageex
@eval exp="dm('macro: imageex(storage='+mp.storage+',page='+mp.page+',layer='+mp.layer+',timezone='+f.timezone+',gray='+f.gray_on+',gamma='+f.gamma_on+')')"
;グレイスケールON?
@eval cond="f.gray_on" exp="mp.grayscale=true"
;ガンマ補正ON?
@if exp="f.gamma_on"
@eval exp="mp.rgamma=f.rgamma"
@eval exp="mp.ggamma=f.ggamma"
@eval exp="mp.bgamma=f.bgamma"
@endif
;最低輝度設定ON?
@if exp="f.floor_on"
@eval exp="mp.rfloor=f.rfloor"
@eval exp="mp.gfloor=f.gfloor"
@eval exp="mp.bfloor=f.bfloor"
@endif
;最高輝度設定ON?
@if exp="f.ceil_on"
@eval exp="mp.rceil=f.rceil"
@eval exp="mp.gceil=f.gceil"
@eval exp="mp.bceil=f.bceil"
@endif
;カラーブレンドON?
@if exp="f.blend_on"
@eval exp="mp.mcolor=f.mcolor"
@eval exp="mp.mopacity=f.mopacity"
@endif
;表示
@image *
@eval exp="f.layer_image[mp.layer]=mp.storage"
@endmacro

;FUNC--------------------------------------------------------------------------
;	背景切り替え
;		背景を切り替える。
;		ただし、テキスト表示/非表示の切り替えは行なわない
;	in	: file	背景ファイル名
;		: time	切り替え時間
;		: rule	切り替えルールファイル名
;		: vague	切り替えのなめらかさ(値が大きいとなめらか)
;		: noclear	立ち絵を消去しない(false)
;		: horizon	地平線の高さ(0で画面下端、プラスで浮き上がりマイナスで沈む)
;------------------------------------------------------------------------------
@macro name=fadein
;@eval exp="dm('macro: fadein')"
;場面が変わるので、立ち絵をすべて消去
@cl_notrans cond="mp.noclear===void||mp.noclear==false||mp.noclear==0"
;表示している立ち絵を描画しなおす
@imageEx cond="f.layer_image['0']!=''" storage="&f.layer_image['0']" layer=0 visible=true page=back
@imageEx cond="f.layer_image['2']!=''" storage="&f.layer_image['2']" layer=2 visible=true page=back
@imageEx cond="f.layer_image['4']!=''" storage="&f.layer_image['4']" layer=4 visible=true page=back
@imageEx cond="f.layer_image['3']!=''" storage="&f.layer_image['3']" layer=3 visible=true page=back
@imageEx cond="f.layer_image['1']!=''" storage="&f.layer_image['1']" layer=1 visible=true page=back
@endif
@imageEx storage=%file layer=base page=back horizon=%horizon|0
@transex * time=%time|0
@wt
@endmacro

;FUNC--------------------------------------------------------------------------
;	背景切り替え
;		背景を切り替える。
;	in	: file	背景ファイル名
;		: time	切り替え時間(Def:800)
;		: rule	切り替えルールファイル名(Def:フェード)
;		: vague	切り替えのなめらかさ(値が大きいとなめらか/Def:60000)
;		; noclear	立ち絵を消去しない(true)
;		: horizon	地平線の高さ(0で画面下端、プラスで浮き上がりマイナスで沈む)
;------------------------------------------------------------------------------
@macro name=bg
;@eval exp="dm('macro: bg')"
@textoff
;背景切り替え
@fadein *
@texton
@endmacro

;FUNC--------------------------------------------------------------------------
;	フラッシュオーバー(flushover/white)
;		画面を真っ白にする
;	in	: time	切り替え時間(Def:800)
;		: rule	切り替えルールファイル名(Def:フェード)
;		: vague	切り替えのなめらかさ(値が大きいとなめらか/Def:60000)
;------------------------------------------------------------------------------
@macro name=flushover
;@eval exp="dm('macro: flushover')"
@fadein * file=white
@endmacro

@macro name=white
;@eval exp="dm('macro: white')"
@bg * file=white
@endmacro

;FUNC--------------------------------------------------------------------------
;	ブラックアウト(blackout/black)
;		画面を真っ黒にする
;	in	: time	切り替え時間(Def:800)
;		: rule	切り替えルールファイル名(Def:フェード)
;		: vague	切り替えのなめらかさ(値が大きいとなめらか/Def:60000)
;		: noclear	立ち絵を消去しない(true)
;		: color	黒以外の色にするとき指定(0xRRGGBB形式)
;------------------------------------------------------------------------------
@macro name=blackout
;@eval exp="dm('macro: blackout')"
@fadein * file=black
@endmacro

@macro name=black
;@eval exp="dm('macro: black')"
@bg * file=black
@endmacro

;FUNC--------------------------------------------------------------------------
;	立ち絵表示
;		立ち絵を切り替える。
;		ただし、トランジションは行なわない
;	in	: file	立ち絵ファイル名
;		: pos	立ち位置(right/left/center)(Def:center)
;		: horizon	地平線の高さ(0で画面下端、プラスで浮き上がりマイナスで沈む)
;------------------------------------------------------------------------------
@macro name=ld_notrans
;@eval exp="dm('macro: ld_notrans')"
;表示位置が指定されていなければ、centerにする
@eval cond="mp.pos==''" exp="mp.pos='center'"
;表示レイヤーを表示位置から指定する
@eval exp="mp.layer=string(f.layer_no[f.curtailed_word[mp.pos]])"
;@trace exp="mp.pos"
;@trace exp="f.curtailed_word[mp.pos]"
;@trace exp="f.layer_no[f.curtailed_word[mp.pos]]"
;@trace exp="string(f.layer_no[f.curtailed_word[mp.pos]])"
;@trace exp="mp.layer"
@imageEx * storage=%file page=back visible=true
@endmacro

;FUNC--------------------------------------------------------------------------
;	立ち絵表示
;		立ち絵を切り替える。
;		ただし、テキスト表示/非表示の切り替えは行なわない
;	in	: file	立ち絵ファイル名
;		: pos	立ち位置(right/left/center)(Def:center)
;		: time	切り替え時間(Def:800)
;		: rule	切り替えルールファイル名(Def:フェード)
;		: vague	切り替えのなめらかさ(値が大きいとなめらか/Def:60000)
;		: horizon	地平線の高さ(0で画面下端、プラスで浮き上がりマイナスで沈む)
;------------------------------------------------------------------------------
@macro name=ld_auto
;@eval exp="dm('macro: ld_auto')"
@ld_notrans *
@transex *
@wt
@endmacro

;FUNC--------------------------------------------------------------------------
;	立ち絵表示
;		立ち絵を切り替える。
;	in	: file	立ち絵ファイル名
;		: pos	立ち位置(right/left/center)(Def:center)
;		: time	切り替え時間(Def:800)
;		: rule	切り替えルールファイル名(Def:フェード)
;		: vague	切り替えのなめらかさ(値が大きいとなめらか/Def:60000)
;		: horizon	地平線の高さ(0で画面下端、プラスで浮き上がりマイナスで沈む)
;------------------------------------------------------------------------------
@macro name=ld
;@eval exp="dm('macro: ld')"
@textoff
;立ち絵表示
@ld_auto *
@texton
@endmacro

;FUNC--------------------------------------------------------------------------
;	立ち絵消去
;		ただし、トランジションは行なわない
;	in	: pos	立ち位置(right/left/center/all)(Def:center)
;------------------------------------------------------------------------------
@macro name=cl_notrans
;@eval exp="dm('macro: cl_notrans')"
;消去位置が指定されていなければ、allにする
@eval cond="mp.pos==''" exp="mp.pos='all'"
;消去位置が"all"ならすべての立ち絵を消去する
@if exp="mp.pos=='all'"
@cl_notrans pos=l
@cl_notrans pos=lc
@cl_notrans pos=c
@cl_notrans pos=rc
@cl_notrans pos=r
@endif
;指定の位置にキャラクタが表示されているなら、そのレイヤーのみ消去
@if exp="mp.pos!='all'"
@eval exp="mp.layer=string(f.layer_no[f.curtailed_word[mp.pos]])"
@layopt page=back layer=%layer visible=false
@eval exp="f.layer_image[mp.layer]=''"
@endif
@endmacro

;FUNC--------------------------------------------------------------------------
;	立ち絵消去
;		ただし、テキスト表示/非表示の切り替えは行なわない
;	in	: pos	立ち位置(right/left/center/all)(Def:center)
;		: time	切り替え時間(Def:800)
;		: rule	切り替えルールファイル名(Def:フェード)
;		: vague	切り替えのなめらかさ(値が大きいとなめらか/Def:60000)
;------------------------------------------------------------------------------
@macro name=cl_auto
;@eval exp="dm('macro: cl_auto')"
@cl_notrans *
@transex *
@wt
@endmacro

;FUNC--------------------------------------------------------------------------
;	立ち絵消去
;	in	: pos	立ち位置(right/left/center/all)(Def:center)
;		: time	切り替え時間(Def:800)
;		: rule	切り替えルールファイル名(Def:フェード)
;		: vague	切り替えのなめらかさ(値が大きいとなめらか/Def:60000)
;------------------------------------------------------------------------------
@macro name=cl
;@eval exp="dm('macro: cl')"
@textoff
;立ち絵消去
@cl_auto *
@texton
@endmacro

;FUNC--------------------------------------------------------------------------
;	現在表示されている画像を再描画する
;	in	: time	切り替え時間(Def:800)
;		: rule	切り替えルールファイル名(Def:フェード)
;		: vague	切り替えのなめらかさ(値が大きいとなめらか/Def:60000)
;	※	一度マクロ変数へ代入する。こうしないとエラーになってしまう。
;		マクロ内のタグでは"[]"(ブラケット)が使えない!! たとえ、"@"で開始していても。
;		なので、"(ダブルクォーテーション)で囲う
;------------------------------------------------------------------------------
@macro name=redraw
;@eval exp="dm('macro: redraw')"
@backlay layer=message
@imageEx cond="f.layer_image['base']!=''" storage="&f.layer_image['base']" layer=base page=back
@imageEx cond="f.layer_image['0']!=''" storage="&f.layer_image['0']" layer=0 visible=true page=back
@imageEx cond="f.layer_image['2']!=''" storage="&f.layer_image['2']" layer=2 visible=true page=back
@imageEx cond="f.layer_image['4']!=''" storage="&f.layer_image['4']" layer=4 visible=true page=back
@imageEx cond="f.layer_image['3']!=''" storage="&f.layer_image['3']" layer=3 visible=true page=back
@imageEx cond="f.layer_image['1']!=''" storage="&f.layer_image['1']" layer=1 visible=true page=back
;まとめてトランジション
@transex * time=%time|800
@wt
@endmacro

;FUNC--------------------------------------------------------------------------
;	ガンマ補正値設定へ
;	in	: color	カラー(red,blue,green,sepia/指定が無ければ何もしない)
;------------------------------------------------------------------------------
@macro name=setgamma
;@eval exp="dm('macro: setgamma')"
@if exp="mp.color!='' && (typeof f.def_rgamma[mp.color] != 'Undefined')"
@eval exp="f.gamma_on=true"
@eval exp="f.rgamma=f.def_rgamma[mp.color]"
@eval exp="f.ggamma=f.def_ggamma[mp.color]"
@eval exp="f.bgamma=f.def_bgamma[mp.color]"
@endif
@endmacro

;FUNC--------------------------------------------------------------------------
;	ガンマ補正を解除
;------------------------------------------------------------------------------
@macro name=resetgamma
@eval exp="f.gamma_on=false"
@endmacro

;FUNC--------------------------------------------------------------------------
;	BGM再生
;	in	: track	再生トラック番号
;		: file	再生ファイル名
;		: time	フェードアウトする時間(Def:0)
;------------------------------------------------------------------------------
@macro name=play
;@eval exp="dm('macro: play')"
;トラック番号が指定されていたら、それをファイル名へ入れる
@eval cond="mp.track!=''" exp="mp.file=mp.track"
;フェード時間が指定されていなければ、即座に再生開始
@playbgm cond="mp.time==''" storage=%file
;フェード時間が指定されていれば、その時間でフェードイン
@fadeinbgm exp="mp.time!=''" storage=%file time=%time
@endmacro

;FUNC--------------------------------------------------------------------------
;	BGM停止
;	in	: time	フェードアウトする時間(Def:0)
;		: nowait	フェードアウト終了を待たない(Def:true)
;------------------------------------------------------------------------------
@macro name=playstop
;@eval exp="dm('macro: playstop')"
@eval cond="mp.nowait==''" exp="mp.nowait=true"
;フェードなしなら、即座に停止
@stopbgm cond="mp.time==''"
;フェードアウト時間を指定して停止
@ignore exp="mp.time==''"
@fadeoutbgm *
@wb cond="mp.nowait!=true"
@endignore
@endmacro

;FUNC--------------------------------------------------------------------------
;	効果音再生
;	in	: file	再生するファイル
;		: nowait	フェードアウト終了を待たない(Def:true)
;------------------------------------------------------------------------------
@macro name=wave
;@eval exp="dm('macro: wave')"
;@eval cond="mp.nowait==''" exp="mp.nowait=true"
;@eval exp="mp.loop=false"
;;@call storage=サブルーチン.ks target=*select_playbuffer
;@eval exp="selectSoundBuffer(mp)"
;@playse buf=&f.bufno storage=%file
;@ws cond="mp.nowait!=true"
;;鳴り終わったので、ファイル名をクリア
;@eval exp="f.current_SEfile[f.current_SEbuffer]=''"
@eval exp="playSoundBuffer(mp.file,mp.nowait)"
@endmacro

;FUNC--------------------------------------------------------------------------
;	効果音再生(ループ)
;	in	: file	再生するファイル
;		: time	フェードイン時間(Def:0)
;------------------------------------------------------------------------------
@macro name=waveloop
;@eval exp="dm('macro: waveloop')"
;@eval exp="mp.loop=true"
;;@call storage=サブルーチン.ks target=*select_playbuffer
;@eval exp="selectSoundBuffer(mp)"
;;即座に再生開始
;@playse cond="mp.time==''" buf=&f.bufno storage=%file loop=true
;フェードインでの再生開始
;@ignore exp="mp.time==''"
;@fadeinse buf=&f.bufno storage=%file time=%time loop=true
;;フェードイン終了待ち
;@wait time=%time canskip=false mode=normal
;@endignore
@eval exp="loopSoundBuffer(mp.file,mp.time,mp.nowait)"
@endmacro

;FUNC--------------------------------------------------------------------------
;	効果音再生停止
;	in	: file		停止するファイル(指定されなければすべての効果音を停止)
;		: time		フェードアウト時間(Def:0)
;		: nowait	フェードアウト終了を待たない(Def:true)
;------------------------------------------------------------------------------
@macro name=wavestop
;@eval exp="dm('macro: wavestop')"
;@call storage=サブルーチン.ks target=*wavestop
@eval exp="stopSoundBuffer(mp.file,mp.time,mp.nowait)"
@endmacro

;FUNC--------------------------------------------------------------------------
;	各種データを登録する
;	in	: term	登録する用語
;------------------------------------------------------------------------------
@macro name=reg
;まだ登録されていない用語なら、
@if exp="mp.term!='' && !kag.alreadyKnownTerms[mp.term]"
;登録を行う
@eval exp="kag.alreadyKnownTerms[mp.term]=true"
;ポップアップメッセージを出す
@eval exp="popupMessage('「'+mp.term+'」が用語集に登録されました。')"
@endif
@endmacro

;FUNC--------------------------------------------------------------------------
;	メッセージレイヤーの設定を変更するマクロ
;	in	: 
;------------------------------------------------------------------------------
@iscript
var LastMessageLayerProperty = %[];
var MessageLayerProperties = [ "left", "top", "width", "height", "frame", "framekey", "color", "opacity", "marginl", "margint", "marginr", "marginb", "vertical", "draggable" ];
var MessageLayerProperties2= [ "left", "top", "imageWidth", "imageHeight", "frameGraphic", "frameKey", "frameColor", "frameOpacity", "marginL", "marginT", "marginR", "marginB", "vertical", "draggable" ];
function changeMessageLayer(elm)
{
	//	記録
	var ml = kag.getMessageLayerObjectFromElm(elm);
	for(var i=0; i<MessageLayerProperties.count; i++)
		LastMessageLayerProperty[MessageLayerProperties[i]] = ml[MessageLayerProperties2[i]];
	LastMessageLayerProperty["layer"]	= elm["layer"];
	LastMessageLayerProperty["page"]	= elm["page"];

	ml.setPosition(elm);
}
function resetMessageLayer()
{
	//	復帰
	kag.getMessageLayerObjectFromElm(LastMessageLayerProperty).setPosition(LastMessageLayerProperty);
	(Dictionary.clear incontextof LastMessageLayerProperty)();
}
@endscript
@macro name=position2
@eval exp="changeMessageLayer(%[layer:'message',page:'fore',left:16,top:344,width:608,height:120,marginl:21,marginr:16,margint:5,marginb:16,color:0x000000,opacity:128])"
@endmacro
@macro name=resetposition2
@eval exp="resetMessageLayer()"
@endmacro

;FUNC--------------------------------------------------------------------------
;	
;	in	: 
;------------------------------------------------------------------------------
;FUNC--------------------------------------------------------------------------
;	
;	in	: 
;------------------------------------------------------------------------------

;------------------------------------------------------------------------------
;	End of File
@return
;------------------------------------------------------------------------------
/*	マクロリファレンスを作成するPerlスクリプト
ENDOFMACRO
#	設定
$htmlfile	= "macro.html";
#	処理
open(FH, ">$htmlfile");
print FH <<ENDOFHTML;
<HTML LANG=ja>
<HEAD><TITLE>マクロリファレンス</TITLE></HEAD>
<BODY>
<A NAME=#top>
<H3>マクロリファレンス</H3>
<HR SIZE=1>
<TABLE>
ENDOFHTML
$status	= 0;
@lines	= split(/\n/, $macro);
foreach $line (@lines)
{
	if($status==0)
	{
		if($line=~/^;FUNC/){ $status=1; }
	}
	elsif($status==1)
	{
		if($line=~/\tin\t: ([^\s]+)\s*(.*)$/) {
			push(@in, $1);
			push(@ininfo, $2);
			$status=2;
		}
		elsif($line=~/\tout\t: ([^\s]+)\s*(.*)$/) {
			push(@out, $1);
			push(@outinfo, $2);
			$status=3;
		}
		elsif($line=~/^;\t([^\t]*)$/){ $main = $1; }
		elsif($line=~/^;\t\t([^\t]*)$/){ $sub .= $1."<BR>"; }
	}
	elsif($status==2)
	{
		if($line=~/^;\tout\t: ([^\s]+)\s*(.*)$/) {
			push(@in, $1);
			push(@ininfo, $2);
			$status=3;
		}
		elsif($line=~/\t\t: ([^\s]+)\s*(.*)$/) {
			push(@in, $1);
			push(@ininfo, $2);
		}
	}
	elsif($status==3)
	{
		if($line=~/\t\t: ([^\s]+)\s*(.*)$/) {
			push(@out, $1);
			push(@outinfo, $2);
		}
	}
	if($line=~/macro.*name=([^\]]*)/ and $status>0){
		$list .= "<A NAME=#{$1}><DL><DT><H4 STYLE=\"background-color: royalblue; color: white;\">$1 : $main&nbsp;&nbsp<A HREF=#top>△</A></H4><DD>$sub\n";
		print( FH "<TR><TD><B><A HREF=#{$1}>$1</A></B></TD><TD> : $main</TD></TR>\n" );
		if($#in>=0){
			$list .= "<HR SIZE=1><TABLE>\n";
			$fst	= "<TH ROWSPAN=".($#in+1)." STYLE=\"background-color: gray; color: white;\">in</TH>";
			for($cnt=0; $cnt<=$#in; $cnt++){
				$list .= "<TR>$fst<TH>$in[$cnt]</TH><TD>$ininfo[$cnt]</TD></TR>\n";
				$fst	= "";
			}
		}
		if($#out>=0){
			$list .= "<HR SIZE=1><TABLE>\n" if ($#in<0);
			$list .= "<TR><TD COLSPAN=2><HR SIZE=1></TD></TR>\n" if ($#in>=0);
			$fst	= "<TH ROWSPAN=".($#out+1)." STYLE=\"background-color: gray; color: white;\">out</TH>";
			for($cnt=0; $cnt<=$#out; $cnt++){
				$list .= "<TR>$fst<TH>$out[$cnt]</TH><TD>$outinfo[$cnt]</TD></TR>\n";
				$fst	= "";
			}
		}
		if($#in>=0 or $#out>=0){
			$list .= "</TABLE>";
		}
		$list .= "</DL>\n";#<HR SIZE=1>\n";
		$status=0;
		$main	= "";
		$sub	= "";
		@in		= ();
		@ininfo	= ();
		@out	= ();
		@outinfo= ();
	}
}
print FH <<ENDOFHTML;
</TABLE>
<HR SIZE=1>
$list
</BODY>
</HTML>
ENDOFHTML
close(FH);
#*/