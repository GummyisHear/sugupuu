<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl"
>
    <xsl:output method="xml" indent="yes"/>
	
	<!-- parameetri määramine -->
	<xsl:param name="otsing">ll</xsl:param>
	<xsl:param name="pikkus">8</xsl:param>
	
    <xsl:template match="/">
		<strong>Kõik sugupuu nimed</strong>
		<ul>
			<xsl:for-each select="//inimene">
				<li>
					<xsl:value-of select="nimi"/>, 
					<xsl:value-of select="@synd"/>:
					<xsl:value-of select="concat(nimi, ' sünniaasta: ', @synd)"/>. Vanus -
					<xsl:value-of select="2026-@synd"/> aastat vana
				</li>
			</xsl:for-each>
		</ul>
		<ol>
			<li>Esimene täht kõikidest nimedest
				<xsl:for-each select="//inimene">
					<xsl:value-of select="substring(nimi, 1, 1)"/>
				</xsl:for-each>
			</li>
			<li>Näita nimed ja tähtede kogused:
				<xsl:for-each select="//inimene">
					<xsl:value-of select="concat(nimi, ' (', string-length(nimi), '), ')"/>
				</xsl:for-each>
				
			</li>
		</ol>
		<table style="border: 1px solid black; border-collapse: collapse;">
			<tr>
				<th>Nimi</th>
				<th>Aasta</th>
				<th>Vanus</th>
				<th>1. täht</th>
				<th>Viimane täht</th>
				<th>Tähtede arv</th>
			</tr>
			<xsl:for-each select="//inimene">
				<tr>
					<td>
						<xsl:value-of select="nimi"/>
					</td>
					<td>
						<xsl:value-of select="@synd"/>
					</td>
					<td>
						<xsl:value-of select="2026-@synd"/>
					</td>
					<td>
						<xsl:value-of select="substring(nimi, 1, 1)"/>
					</td>
					<td>
						<xsl:value-of select="substring(nimi, string-length(nimi), 1)"/>
					</td>
					<td>
						<xsl:value-of select="string-length(nimi)"/>
					</td>
				</tr>
			</xsl:for-each>
		</table>

		<strong>Näita kõik nimed mis algavad C-tähega</strong>
		<ol>
		<xsl:for-each select="//inimene[starts-with(nimi, 'C')]">
			<li>
				<xsl:value-of select="nimi"/>
			</li>
		</xsl:for-each>
		</ol>

		<strong>Parameetrite kasutamine</strong>
		<br/>Otsime nimed mis sisaldavad pareemt osting='<xsl:value-of select="$otsing"/>'
		<ol>
		<xsl:for-each select="//inimene[contains(nimi, $otsing)]">
			<li>
				<xsl:value-of select="nimi"/>
			</li>
		</xsl:for-each>	
		</ol>
		
		<br/>Otsime nimed mis on pikkusega <xsl:value-of select="$pikkus"/> ja rohkem
		<ol>
		<xsl:for-each select="//inimene[string-length(nimi)>=$pikkus]">
			<li>
				<xsl:value-of select="concat(nimi, ' (', string-length(nimi), ')')"/>
			</li>
		</xsl:for-each>	
		</ol>

		<strong>Kasutame if lause</strong>
		<br/>Iga inimese kohta näitame mitmendal oma vanema sünniastal ta sündis
		<ul>
		<xsl:for-each select="//inimene">
			<li>
				<xsl:value-of select="nimi"/>
				<xsl:if test="../..">
					- vanema vanus oli -
					<xsl:value-of select="../../@synd - @synd"/> aastat vana
				</xsl:if>
			</li>	
		</xsl:for-each>	
		</ul>

		<strong>Värvime nimed pikkusega rohkem 7</strong>
		<table border="1">
			<tr>
				<th>Nimi</th>
			</tr>
			<xsl:for-each select="//inimene">
				<tr>
				<td>
					<xsl:if test="string-length(nimi) > 7">
						<xsl:attribute name="style">
							background-color: green;	
						</xsl:attribute>
					</xsl:if>
					<xsl:value-of select="nimi"/>
				</td>
				</tr>
			</xsl:for-each>
		</table>
	
    </xsl:template>
</xsl:stylesheet>
