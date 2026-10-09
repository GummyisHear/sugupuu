<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl">
	<xsl:output method="html" indent="yes"/>

	<xsl:template match="/">
		<link rel="stylesheet" type="text/css" href="reisStyle.css"/>

		<strong>Kõik reisid</strong>
		<br/>

		<h1>Reisid Tabel</h1>

		<div id="tabel">
			<table>
				<tr>
					<th>Riik</th>
					<th>Kestvus</th>
					<th>Transport</th>
					<th>Reisihind</th>
					<th>Ekskursioonid</th>
					<th>Muud Kulud</th>
					<th>Hinnang</th>
				</tr>
				<xsl:for-each select="/reisid/reis">
					<tr>

						<td>
							<xsl:value-of select="suund/riik"/>
						</td>
						<td>
							<xsl:value-of select="suund/kestvus"/>
						</td>
						<td>
							<xsl:value-of select="transport"/>
						</td>
						<td>
							<xsl:value-of select="reisihind"/>€
						</td>
						<td>
							<xsl:value-of select="ekskursioonid"/>€
						</td>
						<td>
							<xsl:value-of select="muudKulud"/>€
						</td>
						<td>
							<xsl:value-of select="hinnang"/>⭐
						</td>
					</tr>
				</xsl:for-each>
			</table>
		</div>
		
		<br/>
		<br/>
		<br/>

		<p>
			Transport:
			<select id="filter" onchange="filtreeri()">
				<option value="all">Kõik</option>
				<option value="lennureis">Lennureis</option>
				<option value="laev">Laev</option>
				<option value="buss">Buss</option>
				<option value="auto">Auto</option>
			</select>

			Sorteeri hinnangu järgi:
			<select id="sort" onchange="filtreeri()">
				<option value="desc">Kõrgeim enne</option>
				<option value="asc">Madalaim enne</option>
			</select>
		</p>

		<div id="reisid">
			<xsl:for-each select="/reisid/reis">
				<xsl:sort select="hinnang" data-type="number" order="descending"/>

				<div class="reis" data-transport="{transport}" data-hinnang="{hinnang}">
					<h1>
						<xsl:value-of select="suund/riik"/>
					</h1>

					<xsl:if test="suund/kestvus &gt; 7">
						<b style="color: red;">Pikk reis</b>
					</xsl:if>

					<ul>
						<li>
							Riik: <span style="background: yellow;">
								<xsl:value-of select="suund/riik"/>
							</span>
						</li>
						<li>
							Kestvus: <span style="background: yellow;">
								<xsl:value-of select="suund/kestvus"/> päeva
							</span>
						</li>
						<li>
							Transport: <xsl:value-of select="transport"/>
						</li>
						<li>
							Majutus: <xsl:value-of select="majutus"/>
						</li>
						<li>
							Ekskursioonid: <xsl:value-of select="ekskursioonid"/> €
						</li>
						<li>
							Muud kulud: <xsl:value-of select="muudKulud"/> €
						</li>
						<li>
							Reisihind: <xsl:value-of select="reisihind"/> €
						</li>
						<li>
							Hinnang: <xsl:value-of select="hinnang"/> ⭐
						</li>
					</ul>

					<b>
						Kogumaksumus: <xsl:value-of select="reisihind + muudKulud + ekskursioonid"/> €
					</b>
				</div>
			</xsl:for-each>
		</div>

		<br/>

		<!-- funktsioon mis kuvab filtreeritud reisid, nupu klikimiseks -->
		<script type="text/javascript">
			<![CDATA[
            function filtreeri() {
                var transport = document.getElementById('filter').value;
                var order = document.getElementById('sort').value;
                var box = document.getElementById('reisid');
                var items = Array.prototype.slice.call(box.getElementsByClassName('reis'));

                items.sort(function (a, b) {
                    var x = parseFloat(a.getAttribute('data-hinnang'));
                    var y = parseFloat(b.getAttribute('data-hinnang'));
                    return order === 'desc' ? y - x : x - y;
                });

                items.forEach(function (item) {
                    box.appendChild(item);
                    var show = transport === 'all' || item.getAttribute('data-transport') === transport;
                    item.style.display = show ? '' : 'none';
                });
            }
        ]]>
		</script>
	</xsl:template>
</xsl:stylesheet>