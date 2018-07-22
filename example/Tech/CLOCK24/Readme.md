# 時刻合わせ機能付き24時間時計

## 概要

24時間時計．時刻カウント，秒修正，分修正，時修正の
4つの状態をもつ．


## 仕様

プロジェクト名

* CLOCK24


構造

* clock24.v
	* seccnt.v （秒カウンタ）
	* mincnt.v （分カウンタ）
	* hourcnt.v （時間カウンタ）
	* seg7dec.v（点滅制御7セグメントデコーダ）
	* cnt1sec.v （1Hz，2Hz生成回路）
	* state.v （ステートマシン）
	* btn\_in.v （チャタリング除去回路）

seccnt.v
```
入力
	CLK : システムクロック
	RST : システムリセット
	EN : 1Hzクロック
	CLR : ボタン入力による秒リセット
出力
	QL : 秒の1桁目
	QH : 秒の2桁目
	CA : 桁上げ
```

mincnt.v
```
入力
	CLK : システムクロック
	RST : システムリセット
	EN : 秒からの桁上げ
	INC : ボタン入力による+1min
出力
	QL : 分の1桁目
	QH : 分の2桁目
	CA : 桁上げ
```

hourcnt.v
```
入力
	CLK : システムクロック
	RST : システムリセット
	EN : 分からの桁上げ
	INC : ボタン入力による+1h
出力
	QL : 時の1桁目
	QH : 時の2桁目
```

seg7dec.v
```
入力
	EN : 7セグメントLED点灯イネーブル
	DIN : バイナリの秒，分，時
出力
	nHEX : 7セグメントLEDデコーダ
```

state.v
```
入力
	CLK : システムクロック
	RST : システムリセット
	MODE : 時計モードと修正モード切替
	SIG2HZ : 2Hz信号
	SELECT : 秒，分，時から修正桁を選択
	ADJUST : 修正
出力
	SECCLR : 秒リセット
	MININC : +1min
	HOURINC : +1hour
	SECON : 秒信号点滅
	MINON : 分信号点滅
	HOURON : 時信号点滅
```

btn_in.v
```
入力
	CLK : システムクロック
	RST : システムリセット
	nBUTTON : ボタン入力（MODE, SELECT, ADJUST）
出力
	nBOUT : チャタリング除去後の出力
```
