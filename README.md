# 『みんなのマレー語辞典』
『みんなのマレー語辞典』（マレー語：Kamus Melayu-Jepun Kita）は2018年からほぼ月1で開催しているマレー語勉強会のメンバーの協力のもと作っているオープンなマレー語・日本語辞典です。

例文はほどんどが[Leipzig Corpora Collection](https://wortschatz.uni-leipzig.de/en) (Goldhahn et al. 2012)のマレー語サブコーパス、[Asian Language Treebank](https://www2.nict.go.jp/astrec-att/member/mutiyama/ALT/) (Riza et al. 2016)、[TUFS Asian Language Parallel Corpus (TULPCo)](https://github.com/matbahasa/TALPCo) (Nomoto et al. 2018) から採った文やそれを改変（簡略化）した文ですが、一部その他のウェブデータから採った文もあります。

## 各ファイルの概要
- `kamus.xml`: 辞書ファイル本体。人文学におけるテキストの構造的マークアップの国際標準である[TEI (Text Encoding Initiative)](https://www.tei-c.org)のガイドラインに準拠したXMLファイル。
- `kamus_style.xsl`: 辞書ファイル`kamus.xml`をhtml形式に変換することを目的としたスタイルシート。
- `xml2html.py`: 辞書ファイル`kamus.xml`をスタイルシート`kamus_style.xsl`に基づいてhtmlファイルに変換するPythonスクリプト。
- `output.html`: ブラウザで閲覧可能な辞書。`xml2html.py`の出力結果。

## 引用
野元裕樹（監修）. 2025. 『みんなのマレー語辞典』. [https://github.com/matbahasa/KamusKita/](https://github.com/matbahasa/KamusKita/).

## ライセンス
このレポジトリのすべてのファイルは、[Creative Commons Attribution 4.0 International（CC-BY 4.0）](https://creativecommons.org/licenses/by/4.0/)の下で提供されています。適切なクレジット（著者名・作品名・ライセンス）を付した上で、営利・非営利を問わず、自由に利用・改変・再配布が可能です。

## 監修
野元裕樹（東京外国語大学）

## 執筆者
- 野元裕樹/Hiroki Nomoto
- 飯島葉月/Hazuki Iijima
- S. Ogawara
- 柏美紀/Miki Kashiwa
- 高橋はな/Hana Takahashi
- 田村陽太/Yota Tamura

## 引用文献
- Goldhahn, Dirk, Thomas Eckart and Uwe Quasthoff. 2012. [Building large monolingual dictionaries at the Leipzig Corpora Collection: From 100 to 200 languages](http://www.lrec-conf.org/proceedings/lrec2012/pdf/327_Paper.pdf). In _Proceedings of the Eighth International Conference on Language Resources and Evaluation (LREC'12)_, 759-765. Istanbul:
European Language Resources Association.
- Nomoto, Hiroki, Kenji Okano, David Moeljadi and Hideo Sawada. 2018. [TUFS Asian Language Parallel Corpus (TALPCo)](http://www.anlp.jp/proceedings/annual_meeting/2018/pdf_dir/C3-5.pdf). In _Proceedings of the Twenty-Fourth Annual Meeting of the Association for Natural Language Processing_, 436-439.
- Riza, Hammam, Michael Purwoadi, Gunarso, Teduh Uliniansyah, Aw Ai Ti, Sharifah Mahani Aljunied, Luong Chi Mai, Vu Tat Thang, Nguyen Phuong Thai, Vichet Chea, Rapid Sun, Sethserey Sam, Sopheap Seng, Khin Mar Soe, Khin Thandar Nwet, Masao Utiyama and Chenchen Ding. 2016. [Introduction of the Asian Language Treebank](https://www2.nict.go.jp/astrec-att/member/mutiyama/ALT/ALT-Parallel-Corpus-20191206/ALT-O-COCOSDA.pdf). In _2016 Conference of the Oriental Chapter of International Committee for Coordination and Standardization of Speech Databases and Assessment Techniques (O-COCOSDA)_.
