<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:date="http://exslt.org/dates-and-times"
    extension-element-prefixes="date">

  <!--
        A stylesheet for TEI-encoded dictionaries.
        Author: Michal Boleslav Měchura, http://www.lexiconista.com/
        Modified by: Hiroki Nomoto 
    -->

<xsl:output method="html"/>

<xsl:template match="/">
  <html>
<head>
  <style>
    a {
      text-decoration: none !important;
    }
  </style>
</head>

    <body>
      <!-- XML の title を取得 -->
      <xsl:variable name="dictTitle"
        select="/tei:TEI/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title"/>

      <!-- EXSLT で現在の日時を取得（例: 2025-12-04T12:45:30Z） -->
      <xsl:variable name="now" select="date:date-time()"/>

      <!-- YYYY-MM-DD の部分だけ取り出す -->
      <xsl:variable name="today" select="substring($now, 1, 10)"/>

<div style="
  max-width:650px;
  margin:0 auto 2em auto;
  padding:1em 1.2em;
  background:linear-gradient(135deg,#f0f4ff,#e8f0ff);
  border:1px solid #ccd9ff;
  border-radius:10px;
  font-family:'Segoe UI',sans-serif;
  box-shadow:0 2px 6px rgba(0,0,0,0.15);
">

        <!-- 見出し -->
        <div style="font-size:1.3em; font-weight:bold; color:#003399; margin-bottom:0.4em;">
          📘<xsl:value-of select="$dictTitle"/>
        </div>
	<!-- 監修者 -->
	<div style="margin:0.3em 0; color:#003366;">
	  <span style="font-weight:bold;">監修：</span>
	  <span style="color:#000;">
	    野元裕樹（東京外国語大学）
	  </span>
	</div>
        <!-- 項目数 -->
        <div style="margin:0.3em 0; color:#003366;">
          <span style="font-weight:bold;">見出し語数：</span>
          <span style="color:#000;">
            <xsl:value-of select="count(/tei:TEI//tei:entry[@xml:id])-1"/>
          </span>
        </div>

        <!-- 最終更新日 -->
        <div style="margin:0.3em 0; color:#003366;">
          <span style="font-weight:bold;">最終更新日：</span>
          <span style="color:#000;">
            <xsl:value-of select="substring($today,1,4)"/>年
            <xsl:value-of select="substring($today,6,2)"/>月
            <xsl:value-of select="substring($today,9,2)"/>日
          </span>
        </div>

<!-- CC-BY 4.0（公式アイコン＋フル説明） -->
<div style="margin-top:1em; font-size:0.9em; color:#333; line-height:1.4;">

  <!-- CC-BY 公式アイコン -->
  <img src="by.svg"
       alt="CC-BY 4.0"
       style="height:32px; vertical-align:middle; margin-right:0.6em;" />

    本辞書の内容は、<a href="https://creativecommons.org/licenses/by/4.0/" target="_blank" style="color:#1A4DB3; text-decoration:none;">Creative Commons Attribution 4.0 International（CC-BY 4.0）</a>の下で提供されています。
    適切なクレジット（著者名・作品名・ライセンス）を付した上で、営利・非営利を問わず、自由に利用・改変・再配布が可能 です。
  </div>

      </div>
      <!-- ======== ヘッダーここまで ======== -->

      <div style="max-width: 600px; margin: 0px auto; x-column-count: 2; x-column-gap: 40px;">
        <xsl:apply-templates select="/tei:TEI/tei:text/tei:body/*"/>
      </div>

    </body>
  </html>
</xsl:template>

  <!--top-level entry element: root -->
  <xsl:template match="tei:entry[@type='root']">
    <span style="display: block; line-height: 1.3em; margin: 1.5em 0 1.5em -1em; text-indent: -1em;" xml:space="preserve">
            <xsl:apply-templates/>
        </span>
  </xsl:template>

  <!--subentry with grey left border and indent: form -->
  <xsl:template match="tei:entry[@type='root']/tei:entry">
    <span style="display: block; line-height: 1.3em; margin: 0.35em 0 0 0; border-left: 5px solid #dddddd; padding: 0.25em 0 0.25em 1em; text-indent: 0em;" id="{@xml:id}">
      <xsl:apply-templates/>
    </span>
  </xsl:template>

  <!--subentry with bullet and indent-->
  <xsl:template match="tei:re">
    <span style="display: block; margin: 0.5em 0 0.5em 0.5em; min-height: 1.5em; text-indent: 0em;">
		    <!--      <span style="float: left; font-weight: bold; color: #666666">»</span>-->
      <span style="display: block;"><xsl:apply-templates/></span>
    </span>
  </xsl:template>

<!-- <re> の内部にある <entry> を必ずブロック表示にする -->
<xsl:template match="tei:re//tei:entry">
  <span style="display:block; margin:0.5em 0 0.5em 0; text-indent:0em;">
    <xsl:apply-templates/>
  </span>
</xsl:template>

  <!--sense with bullet or number, and indent-->
  <!--  <xsl:template match="tei:sense">
    <span style="display: block; margin: 0.5em 0 0.5em 0.5em; min-height: 1.5em; text-indent: 0em;">
      <xsl:variable name="bullet">
      <xsl:choose>
          <xsl:when test="@n"><xsl:value-of select="@n"/></xsl:when>
          <xsl:otherwise>▪</xsl:otherwise>
        </xsl:choose>
      </xsl:variable>
      <span style="float: left; font-weight: bold; color: #999999"><xsl:value-of select="$bullet"/></span>
      <span style="display: block; margin-left: 1.5em;"><xsl:apply-templates/></span>
    </span>
  </xsl:template>-->

<xsl:template match="tei:sense">
  <xsl:choose>
    <!-- 番号がある場合 -->
    <xsl:when test="@n">
      <span style="display:block; margin:0.5em 0 0.5em 0.5em; min-height:1.5em; text-indent:0em;">
        <span style="float:left; font-weight:bold; color:#999999">
          <xsl:value-of select="@n"/>
        </span>
        <span style="display:block; margin-left:1.5em;">
          <xsl:apply-templates/>
        </span>
      </span>
    </xsl:when>
    <!-- 番号がない場合 -->
    <xsl:otherwise>
      <!-- 改行やブロック表示をせず、インラインで本文だけ出力 -->
      <xsl:apply-templates/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

  <!---tilda-->
  <xsl:template match="tei:oRef|tei:pRef">
    <xsl:choose>
      <xsl:when test="text()|*"><xsl:apply-templates/></xsl:when>
      <xsl:otherwise>~</xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!--when <form> seems complex, give it a bullet and indent it-->
  <xsl:template match="tei:form[tei:gramGrp and not(position()=1)]">
    <span style="display: block; margin: 0.5em 0 0.5em 0.5em; min-height: 1.5em;">
      <span style="float: left; font-weight: bold; color: #999999">›</span>
      <span style="display: block; margin-left: 1.5em;"><xsl:apply-templates/></span>
    </span>
  </xsl:template>

<!-- hom のあるエントリ -->
<xsl:template match="tei:entry[@n][@subtype='hom']">
    <span style="display: block; line-height: 1.3em; margin: 1.5em 0 1.5em -1em; text-indent: -1em;" xml:space="preserve">
    <!-- form 内の orth を出力 -->
    <xsl:for-each select="tei:form">
      <span style="font-family: sans-serif; font-weight: bold; color:blue; text-shadow: 0px 0px 1px #999999;">
      <xsl:value-of select="tei:orth"/>
      <!-- @n を orth の後に表示 -->
      <sup><xsl:value-of select="../@n"/></sup>
      </span>
    <!-- form 内の pron を出力 -->
      <span style="font-family: sans-serif;color: #006600;">
      <xsl:text>[</xsl:text><xsl:value-of select="tei:pron"/><xsl:text>]</xsl:text>
      </span>
    </xsl:for-each>
    <!-- 他の内容 apply-templates -->
        <xsl:apply-templates select="tei:entry"/>
  </span>
</xsl:template>

  <!--a default <orth>-->
  <xsl:template match="tei:orth">
    <span style="font-family: sans-serif;">
      <xsl:apply-templates/>
    </span>
    <xsl:if test="following-sibling::node()[1][name()='orth']"><xsl:text> </xsl:text><span style="color: #999999">|</span><xsl:text> </xsl:text></xsl:if>
  </xsl:template>

  <!--an <orth> that seems like a headword; overrides default <orth>-->
   <xsl:template match="tei:form[@type='lemma' or @type='compound']//tei:orth
    | tei:form[1][parent::tei:entry or parent::tei:entryFree or parent::tei:superEntry or parent::tei:re]/tei:orth[not(preceding-sibling::*)]
    | tei:form[1][not(*) and (parent::tei:entry or parent::tei:entryFree or parent::tei:superEntry or parent::tei:re)]">
  <!-- re の中かどうかで分岐 -->
  <xsl:choose>
    <!-- re の中なら■を前置き、文字の影なし -->
    <xsl:when test="ancestor::tei:re">
      <span style="font-weight:bold; color:#999999;">■</span>
      <xsl:text> </xsl:text>
      <span style="font-family: sans-serif; font-weight: bold">
        <xsl:apply-templates/>
      </span>
    </xsl:when>
    <!-- 通常は何もなし、青色文字、文字の影あり -->
    <xsl:otherwise>
      <span style="font-family: sans-serif; font-weight: bold; color:blue; text-shadow: 0px 0px 1px #999999;">
        <xsl:apply-templates/>
      </span>
    </xsl:otherwise>
  </xsl:choose>
  <!-- orth が複数ある場合は区切り記号 | を出す -->
    <xsl:if test="following-sibling::*[1][name()='orth']"><xsl:text> </xsl:text><span style="color: #999999">|</span><xsl:text> </xsl:text></xsl:if>
</xsl:template>

  <!--defintion, etymology, note-->
  <xsl:template match="tei:def | tei:etym | tei:note">
    <xsl:apply-templates/>
    <xsl:if test="following-sibling::*[1][name()='def' or name()='etym' or name()='note' or (name()='cit' and (@type='translation' or @type='trans')) or name()='quote']">
      <xsl:text> </xsl:text><span style="color: #999999">|</span><xsl:text> </xsl:text>
    </xsl:if>
  </xsl:template>
  
  <!--a default <cit>-->
  <xsl:template match="tei:cit">
    <xsl:apply-templates/>
    <xsl:if test="following-sibling::node()[1][name()='cit']"><xsl:text> </xsl:text><span style="color: #999999">|</span><xsl:text> </xsl:text></xsl:if>
  </xsl:template>
  
  <!--a <cit> that looks like a translation of the headword-->
  <xsl:template match="tei:cit[(@type='translation' or @type='trans') and not (parent::tei:cit)]">
    <xsl:apply-templates/>
    <xsl:if test="following-sibling::*[1][name()='def' or name()='etym' or name()='note' or (name()='cit' and (@type='translation' or @type='trans'))  or name()='quote']">
      <xsl:text> </xsl:text><span style="color: #999999">|</span><xsl:text> </xsl:text>
    </xsl:if>
  </xsl:template>
  
  <!--a <cit> that looks like an example sentence-->
  <xsl:template match="tei:cit[@type='example' or @type='ex' or not(@type)]">
    <span style="display: block; margin: 0.5em 0 0.5em 0.5em; min-height: 1.5em; text-indent: 0em;">
      <span style="float: left; color: #666666">◇</span>
      <span style="display: block; margin-left: 1.5em;"><xsl:apply-templates/></span>
    </span>
  </xsl:template>
  
  <!--a default <quote>-->
  <xsl:template match="tei:quote">
    <span style="font-family: sans-serif; font-weight: bold; color: #666666;">
      <xsl:apply-templates/>
    </span>
    <xsl:if test="following-sibling::*[1][name()='quote']"><xsl:text> </xsl:text><span style="color: #999999">|</span><xsl:text> </xsl:text></xsl:if>
  </xsl:template>
  
  <!--a <quote> inside a translation of the headword-->
  <xsl:template match="tei:cit[@type='translation' or @type='trans']/tei:quote">
    <span style="font-family: sans-serif; text-shadow: 0px 0px 1px #999999;">
      <xsl:apply-templates/>
    </span>
    <xsl:if test="following-sibling::*[1][name()='quote' or name()='def' or name()='note']"><xsl:text> </xsl:text><span style="color: #999999">|</span><xsl:text> </xsl:text></xsl:if>
  </xsl:template>
  
  <!--a <quote> inside a translation of an example sentence-->
	  <!--  <xsl:template match="tei:cit/tei:cit[@type='translation' or @type='trans']/tei:quote">
    <span style="font-family: sans-serif; color: #666666;">
      <xsl:apply-templates/>
    </span>
    <xsl:if test="following-sibling::*[1][name()='quote' or name()='def' or name()='note']"><xsl:text> </xsl:text><span style="color: #999999">|</span><xsl:text> </xsl:text></xsl:if>
	  </xsl:template>-->
  <xsl:template match="tei:cit/tei:cit[@type='translation' or @type='trans']/tei:quote">
  <xsl:choose>
    <!-- 番号がある場合 -->
    <xsl:when test="@n">
	    <span style="font-weight:bold; color:#999999">
		    <xsl:value-of select="@n"/><xsl:text>. </xsl:text>
	    </span>
          <xsl:apply-templates/>
    </xsl:when>
    <!-- 番号がない場合 -->
    <xsl:otherwise>
      <!-- 改行やブロック表示をせず、インラインで本文だけ出力 -->
      <xsl:apply-templates/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>
  
  <!--pronunciation-->
  <xsl:template match="tei:pron">
    <span style="font-family: sans-serif; color: #006600">
      <xsl:text>[</xsl:text>
      <xsl:apply-templates/>
      <xsl:text>]</xsl:text>
    </span>
  </xsl:template>
  
  <!--various <form> children-->
  <xsl:template match="tei:hyph|tei:syll|tei:stress">
    <span style="font-family: sans-serif; color: #666666">
      <xsl:text>(</xsl:text>
      <xsl:apply-templates/>
      <xsl:text>)</xsl:text>
    </span>
  </xsl:template>
  
  <!--grammatical labels-->
  <xsl:template match="tei:gram|tei:gen|tei:number|tei:case|tei:per|tei:tns|tei:mood|tei:iType|tei:pos|tei:subc|tei:gramGrp[not(*)]">
    <span style="font-family: sans-serif; color: #000066; background-color: #eeeeee; padding: 1px 5px; border-radius: 2px;">
      <xsl:choose>
        <xsl:when test="text()|*"><xsl:apply-templates/></xsl:when>
        <xsl:otherwise><xsl:value-of select="@value"/></xsl:otherwise>
      </xsl:choose>
    </span>
  </xsl:template>

  <!--a collocate: looks like a grammatical label and like <orth> at the same time-->
  <xsl:template match="tei:colloc">
    <span style="font-family: sans-serif; border: 1px solid #aaaaaa; padding: 0px 5px; border-radius: 2px;">
      <xsl:apply-templates/>
    </span>
  </xsl:template>
  
  <!--various labels-->
  <!--  <xsl:template match="tei:lbl|tei:usg|tei:lang">
    <span style="color: #666666;">
      <xsl:apply-templates/>
    </span>
  </xsl:template>-->
  <xsl:template match="tei:lbl|tei:usg|tei:lang">
  <span style="color:#666666;">
    <xsl:choose>
      <xsl:when test="self::tei:usg[@type='gram']">
        《<xsl:apply-templates/>》
      </xsl:when>
      <xsl:otherwise>
        <xsl:apply-templates/>
      </xsl:otherwise>
    </xsl:choose>
  </span>
</xsl:template>

<!--  xr（formal / abbrev / var）本体を （…） で囲む -->
<xsl:template match="tei:xr[@type='formal' or @type='abbrev' or @type='var']">
  <span style="font-family:sans-serif;">
    （
    <xsl:apply-templates/>
    ）
  </span>
</xsl:template>

  <!-- a cross-reference -->
  <xsl:template match="tei:ref | tei:xr[not(tei:ref)] | tei:ptr">
	  <xsl:choose>
		  <!-- formalとabbrevとvar内の <ref> 矢印なし -->
    <xsl:when test="ancestor::tei:xr[@type='formal' or @type='abbrev' or @type='var']">
      <a href="{@target}"
         style="text-decoration:none; border-bottom:1px dotted #006600; font-family:sans-serif;">
        <xsl:choose>
          <xsl:when test="text()|*"><xsl:apply-templates/></xsl:when>
          <xsl:otherwise><xsl:value-of select="@target"/></xsl:otherwise>
        </xsl:choose>
      </a>
    </xsl:when>
	    <!-- その他の cross-reference（矢印を付ける） -->
    <xsl:otherwise>
  <span style="color:#006600; font-weight:bold;">⇒ </span>
	  <a href="{@target}" style="border-bottom: 1px dotted #006600; font-family: sans-serif;">
      <xsl:choose>
        <xsl:when test="text()|*"><xsl:apply-templates/></xsl:when>
        <xsl:otherwise><xsl:value-of select="@target"/></xsl:otherwise>
      </xsl:choose>
      <!--      <xsl:text>&#160;</xsl:text>
      <span style="color: #006600; font-weight: bold;">›</span> -->
    </a>
    </xsl:otherwise>
    </xsl:choose>
    <!-- 区切り線 -->
    <xsl:if test="following-sibling::node()[1][name()='ref' or name()='xr']"><xsl:text> </xsl:text><span style="color: #cccccc">|</span><xsl:text> </xsl:text></xsl:if>
  </xsl:template>

  <!--a <mentioned> inside an etymology: looks a bit like a headword-->
  <xsl:template match="tei:mentioned">
    <span style="font-family: sans-serif; text-shadow: 0px 0px 1px #999999;">
      <xsl:apply-templates/>
    </span>
    <xsl:if test="following-sibling::node()[1][name()='mentioned']"><xsl:text> </xsl:text><span style="color: #999999">|</span><xsl:text> </xsl:text></xsl:if>
  </xsl:template>
  
  <!--a gloss: surrounded by 69-shaped single quotes-->
  <xsl:template match="tei:gloss">
    <xsl:text>‘</xsl:text>
    <xsl:apply-templates/>
    <xsl:text>’</xsl:text>
  </xsl:template>
  
  <!-- emph要素の処理 -->
  <xsl:template match="tei:emph">
    <span style="color:#B8860B; font-weight:bold;">
      <xsl:apply-templates/>
    </span>
  </xsl:template>

</xsl:stylesheet>
