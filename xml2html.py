from lxml import etree

# XMLとXSLファイルを読み込む
xml_tree = etree.parse("kamus.xml")
xsl_tree = etree.parse("kamus_style.xsl")

# XSLT変換を適用
transform = etree.XSLT(xsl_tree)
result_tree = transform(xml_tree)

# HTMLとして保存
result_tree.write("kamus.html", pretty_print=True, encoding="UTF-8")
