<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0">
    <xsl:output method="html" doctype-system="about:legacy-compat"/>
    <xsl:template match="/">
        <html>
            <head>
                <title>CSCI E-18, Assignment 2</title>
            </head>
            <body>
                <h1>Harvard University<br/>Faculty of Arts and Sciences</h1>
                <h2>Departments</h2>
                <xsl:apply-templates/>
            </body>
        </html>
    </xsl:template>
    <xsl:template match="result">
        <ul>
            <xsl:for-each select="*[not(@code=preceding-sibling::*/@code)]">
                <li>
                    <strong>
                        <a href="courses?department={encode-for-uri(@code)}">
                            <xsl:value-of select="text()"/>
                        </a>
                    </strong>
                </li>
            </xsl:for-each>
        </ul>
    </xsl:template>
    <xsl:template match="text()"/>
</xsl:stylesheet>