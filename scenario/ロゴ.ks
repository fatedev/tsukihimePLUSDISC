;------------------------------------------------------------------------------
;	Copyright (C) 1999-2002 TYPE-MOON All Rights Reserved.
;		カンパニーロゴ
;------------------------------------------------------------------------------
*logo
;カンパニーロゴ準備
;ロゴ本体
@eval exp="f.lastlayercount=kag.fore.layers.count"
@laycount layers=30
@image layer=0 storage=logo_T.png opacity=0 left=129 top=216 visible=true page=fore
@image layer=1 storage=logo_Y.png opacity=0 left=172 top=216 visible=true page=fore
@image layer=2 storage=logo_P.png opacity=0 left=218 top=216 visible=true page=fore
@image layer=3 storage=logo_E.png opacity=0 left=261 top=216 visible=true page=fore
@image layer=4 storage=logo_M.png opacity=0 left=344 top=216 visible=true page=fore
@image layer=5 storage=logo_O.png opacity=0 left=392 top=215 visible=true page=fore
@image layer=6 storage=logo_O.png opacity=0 left=436 top=215 visible=true page=fore
@image layer=7 storage=logo_N.png opacity=0 left=480 top=215 visible=true page=fore
@image layer=8 storage=logo_-.png opacity=0 left=311 top=216 visible=true page=fore
;ライン page=fore
@image layer=9 storage=slash_h.png opacity=0 left=136 top=212 visible=true page=fore
@image layer=10 storage=slash_w.png opacity=0 left=110 top=217 visible=true page=fore
@image layer=11 storage=slash_Y.png opacity=0 left=180 top=200 visible=true page=fore
@image layer=12 storage=slash_h.png opacity=0 left=183 top=222 visible=true page=fore
@image layer=13 storage=slash_w.png opacity=0 left=211 top=217 visible=true page=fore
@image layer=14 storage=slash_w.png opacity=0 left=197 top=227 visible=true page=fore
@image layer=15 storage=slash_h.png opacity=0 left=225 top=198 visible=true page=fore
@image layer=16 storage=slash_h.png opacity=0 left=265 top=211 visible=true page=fore
@image layer=17 storage=slash_w.png opacity=0 left=254 top=228 visible=true page=fore
@image layer=18 storage=slash_w.png opacity=0 left=243 top=237 visible=true page=fore
@image layer=19 storage=slash_w.png opacity=0 left=295 top=226 visible=true page=fore
@image layer=20 storage=slash_M.png opacity=0 left=349 top=216 visible=true page=fore
@image layer=21 storage=slash_h.png opacity=0 left=347 top=200 visible=true page=fore
@image layer=22 storage=slash_h.png opacity=0 left=369 top=207 visible=true page=fore
@image layer=23 storage=slash_w.png opacity=0 left=391 top=236 visible=true page=fore
@image layer=24 storage=slash_h.png opacity=0 left=410 top=214 visible=true page=fore
@image layer=25 storage=slash_h.png opacity=0 left=438 top=198 visible=true page=fore
@image layer=26 storage=slash_w.png opacity=0 left=418 top=217 visible=true page=fore
@image layer=27 storage=slash_h.png opacity=0 left=482 top=213 visible=true page=fore
@image layer=28 storage=slash_h.png opacity=0 left=499 top=196 visible=true page=fore
@image layer=29 storage=slash_N.png opacity=0 left=472 top=206 visible=true page=fore
;	T
@move layer=9 time=60 path="(136,206,255) (136,200,0)"
@move layer=10 time=60 path="(117,217,255) (125,217,0)" delay=30
@move layer=0 time=60 path="(129,216,255)" delay=60
;	Y
@move layer=11 time=60 path="(176,207,255) (171,214,0)" delay=90
@move layer=12 time=60 path="(183,211,255) (183,200,0)" delay=120
@move layer=13 time=60 path="(204,217,255) (197,217,0)" delay=150
@move layer=1 time=60 path="(172,216,255)" delay=180
;	P
@move layer=14 time=60 path="(207,227,255) (216,227,0)" delay=210
@move layer=15 time=60 path="(225,205,255) (225,213,0)" delay=240
@move layer=16 time=60 path="(265,205,255) (265,198,0)" delay=270
@move layer=2 time=60 path="(218,216,255)" delay=300
;	E
@move layer=17 time=60 path="(245,228,255) (237,228,0)" delay=330
@move layer=18 time=60 path="(251,237,255) (260,237,0)" delay=360
@move layer=3 time=60 path="(261,216,255)" delay=390
;	-
@move layer=19 time=60 path="(289,226,255) (283,226,0)" delay=420
@move layer=8 time=60 path="(311,216,255)" delay=450
;	M
@move layer=20 time=60 path="(352,210,255) (355,204,0)" delay=480
@move layer=21 time=60 path="(347,207,255) (347,213,0)" delay=510
@move layer=22 time=60 path="(369,201,255) (369,195,0)" delay=540
@move layer=4 time=60 path="(344,216,255)" delay=570
;	O
@move layer=23 time=60 path="(382,236,255) (373,236,0)" delay=600
@move layer=24 time=60 path="(410,207,255) (410,199,0)" delay=630
@move layer=5 time=60 path="(392,215,255)" delay=660
;	O
@move layer=25 time=60 path="(438,205,255) (438,213,0)" delay=690
@move layer=26 time=60 path="(426,217,255) (434,217,0)" delay=720
@move layer=6 time=60 path="(436,215,255)" delay=750
;	N
@move layer=27 time=60 path="(482,207,255) (482,200,0)" delay=780
@move layer=28 time=60 path="(499,205,255) (499,214,0)" delay=810
@move layer=29 time=60 path="(478,212,255) (484,218,0)" delay=840
@move layer=7 time=60 path="(480,215,255)" delay=870
@wait time=1930 canskip=true
;	N
@move layer=29 time=60 path="(478,212,255) (484,218,0)"
@move layer=28 time=60 path="(499,205,255) (499,214,0)" delay=30
@move layer=27 time=60 path="(482,207,255) (482,200,0)" delay=60
@move layer=7 time=150 path="(480,215,0)" delay=90
;	O
@move layer=26 time=60 path="(426,217,255) (434,217,0)" delay=120
@move layer=25 time=60 path="(438,205,255) (438,213,0)" delay=150
@move layer=6 time=120 path="(436,215,0)" delay=180
;	O
@move layer=24 time=60 path="(410,207,255) (410,199,0)" delay=210
@move layer=23 time=60 path="(382,236,255) (373,236,0)" delay=240
@move layer=5 time=120 path="(392,215,0)" delay=270
;	M
@move layer=22 time=60 path="(369,201,255) (369,195,0)" delay=300
@move layer=21 time=60 path="(347,207,255) (347,213,0)" delay=330
@move layer=20 time=60 path="(352,210,255) (355,204,0)" delay=360
@move layer=4 time=150 path="(344,216,0)" delay=390
;	-
@move layer=19 time=60 path="(289,226,255) (283,226,0)" delay=420
@move layer=8 time=90 path="(311,216,0)" delay=450
;	E
@move layer=18 time=60 path="(251,237,255) (260,237,0)" delay=480
@move layer=17 time=60 path="(245,228,255) (237,228,0)" delay=510
@move layer=3 time=120 path="(261,216,0)" delay=540
;	P
@move layer=16 time=60 path="(265,205,255) (265,198,0)" delay=570
@move layer=15 time=60 path="(225,205,255) (225,213,0)" delay=600
@move layer=14 time=60 path="(207,227,255) (216,227,0)" delay=630
@move layer=2 time=150 path="(218,216,0)" delay=660
;	Y
@move layer=13 time=60 path="(204,217,255) (197,217,0)" delay=690
@move layer=12 time=60 path="(183,211,255) (183,200,0)" delay=720
@move layer=11 time=60 path="(176,207,255) (171,214,0)" delay=750
@move layer=1 time=150 path="(172,216,0)" delay=780
;	T
@move layer=10 time=60 path="(117,217,255) (125,217,0)" delay=810
@move layer=9 time=60 path="(136,206,255) (136,200,0)" delay=840
@move layer=0 time=120 path="(129,216,0)" delay=870
@wait time=1000 canskip=true
;レイヤーの数を元に戻す
@laycount layers=&f.lastlayercount
@return
