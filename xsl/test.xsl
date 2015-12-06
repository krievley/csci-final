<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0">
    <xsl:output method="html" doctype-system="about:legacy-compat"/>
    <xsl:template match="/">
        <html>
            <head>
                <title>Test Page</title>
            </head>
            <body>
                <h1>Test Page</h1>
                <xsl:apply-templates/>
            </body>
        </html>
    </xsl:template>
    <xsl:template match="result">
        <ul>
            <xsl:for-each select="*">
                <li>
                    <strong>
                        <xsl:value-of select="@label"/>
                    </strong>:  <xsl:value-of select="@value"/>
                </li>
            </xsl:for-each>
        </ul>
    </xsl:template>
    <xsl:template match="text()"/>
</xsl:stylesheet>