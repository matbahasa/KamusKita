# 『みんなのマレー語辞典』
『みんなのマレー語辞典』（マレー語：Kamus Melayu-Jepun Kita）は2018年からほぼ月1で開催しているマレー語勉強会のメンバーの協力のもと作っているオープンなマレー語・日本語辞典です。

例文はほどんどが[Leipzig Corpora Collection](https://wortschatz.uni-leipzig.de/en) (Goldhahn et al. 2012)のマレー語サブコーパス、[Asian Language Treebank](https://www2.nict.go.jp/astrec-att/member/mutiyama/ALT/) (Riza et al. 2016)、[TUFS Asian Language Parallel Corpus (TULPCo)](https://github.com/matbahasa/TALPCo) (Nomoto et al. 2018) から採った文やそれを改変（簡略化）した文ですが、一部その他のウェブデータから採った文もあります。

このレポジトリのすべてのファイルは、[Creative Commons Attribution 4.0 International（CC-BY 4.0）](https://creativecommons.org/licenses/by/4.0/)の下で提供されています。適切なクレジット（著者名・作品名・ライセンス）を付した上で、営利・非営利を問わず、自由に利用・改変・再配布が可能です。

## 引用
野元裕樹（監修）. 2025. 『みんなのマレー語辞典』. [https://github.com/matbahasa/KamusKita/](https://github.com/matbahasa/KamusKita/).

## 監修
野元裕樹（東京外国語大学）

## 執筆者（五十音順）
- 飯島葉月/Hazuki Iijima
- 上宮かれん/Karen Uemiya
- 内田美那/Mina Uchida
- 大沼千秋/Chiaki Onuma
- S. Ogawara
- 柏美紀/Miki Kashiwa
- 高橋はな/Hana Takahashi
- 田村陽太/Yota Tamura
- 西依勇輝/Yuki Nishiyori
- 野間口百合/Yuri Nomaguchi
- 野元裕樹/Hiroki Nomoto
- 由井彩花/Ayaka Yui

## 各ファイルの概要
- `kamus.xml`: 辞書ファイル本体。
- `kamus.html`: ブラウザで閲覧可能な辞書。
- `kamus_style.xsl`: 辞書ファイル`kamus.xml`をhtml形式に変換することを目的としたスタイルシート。
- `xml2html.py`: 辞書ファイル`kamus.xml`をスタイルシート`kamus_style.xsl`に基づいてhtmlファイルに変換するPythonスクリプト。`kamus.html`が出力結果。

### 辞書ファイル（kamus.xml）について
人文学におけるテキストの構造的マークアップの国際標準である[TEI (Text Encoding Initiative)](https://www.tei-c.org)のガイドラインに準拠しています。一般的なマレー語辞書と同様に語根を最上位の見出し（entry）とし、その下にその具体的な語形が下位エントリーとして列挙される形になっています。後者の`<entry>`の属性`xml:id`の値はマレー語・インドネシア語形態情報辞書[MALINDO Morph](https://github.com/matbahasa/MALINDO_Morph)のIDと同じものです。

```xml
<entry type="root">
   <!-- 同綴り語の場合は上位entryを設け、n="1" subtype="hom"を追加 -->
   <!-- 語根 -->
   <form>
      <orth>語根正書法</orth>
      <pron>語根発音</pron>
   </form>
   <xr type="cf">
      <ref target="#ID">参照先の見出し</ref>
   </xr>
   <xr type="abbr">
      <ref target="#ID">完全形</ref><lbl>の短縮形</lbl>
   </xr>
   <xr type="var">
      <ref target="#ID">標準形</ref><lbl>の異形</lbl>
   </xr>
   <!-- 語形 -->
   <entry xml:id="ID" resp="担当者">
      <form>語形</form>
      <usg type="register">文体（「口語]など）</usg>
      <xr type="formal">
         <ref target="ID">参照先の見出し</ref><lbl>の口語形</lbl>
      </xr>
      <!-- 品詞 -->
      <gramGrp>
         <pos>品詞</pos>
      </gramGrp>
      <usg type="register">文体（「口語]など）</usg>
      <xr type="formal">
         <ref target="ID">参照先の見出し</ref><lbl>の口語形</lbl>
      </xr>
      <sense n="1">
         <usg type="time">時代（「古」など）</usg>
         <usg type="gram">用法</usg>
         <def>意味</def>
         <cit type="example">
            <quote>例文（<emph>当該語形</emph>）</quote>
            <cit type="translation">
               <quote>例文日本語訳</quote>
            </cit>
         </cit>
      </sense>
      <!-- 熟語 -->
      <re>
         <entry>
            <form>熟語</form>
            <sense>
               <usg type="gram">用法</usg>
               <def>意味</def>
               <cit type="example">
                  <quote>例文（<emph>当該語形</emph>）</quote>
                  <cit type="translation">
                     <quote>例文日本語訳</quote>
                  </cit>
               </cit>
            </sense>
         </entry>
      </re>
   </entry>
</entry>
```

## 引用文献
- Goldhahn, Dirk, Thomas Eckart and Uwe Quasthoff. 2012. [Building large monolingual dictionaries at the Leipzig Corpora Collection: From 100 to 200 languages](http://www.lrec-conf.org/proceedings/lrec2012/pdf/327_Paper.pdf). In _Proceedings of the Eighth International Conference on Language Resources and Evaluation (LREC'12)_, 759-765. Istanbul:
European Language Resources Association.
- Nomoto, Hiroki, Kenji Okano, David Moeljadi and Hideo Sawada. 2018. [TUFS Asian Language Parallel Corpus (TALPCo)](http://www.anlp.jp/proceedings/annual_meeting/2018/pdf_dir/C3-5.pdf). In _Proceedings of the Twenty-Fourth Annual Meeting of the Association for Natural Language Processing_, 436-439.
- Riza, Hammam, Michael Purwoadi, Gunarso, Teduh Uliniansyah, Aw Ai Ti, Sharifah Mahani Aljunied, Luong Chi Mai, Vu Tat Thang, Nguyen Phuong Thai, Vichet Chea, Rapid Sun, Sethserey Sam, Sopheap Seng, Khin Mar Soe, Khin Thandar Nwet, Masao Utiyama and Chenchen Ding. 2016. [Introduction of the Asian Language Treebank](https://www2.nict.go.jp/astrec-att/member/mutiyama/ALT/ALT-Parallel-Corpus-20191206/ALT-O-COCOSDA.pdf). In _2016 Conference of the Oriental Chapter of International Committee for Coordination and Standardization of Speech Databases and Assessment Techniques (O-COCOSDA)_.
