<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0">
    <xsl:output method="html" doctype-system="about:legacy-compat"/>
    <xsl:template match="/">
        <html>
            <head>
                <title>CSCI E-18, Assignment 2</title>
            </head>
            <body>
                <h1>Harvard University<br/>Faculty of Arts and Sciences</h1>
                <table>
                    <thead>
                        <th>Course Group</th>
                        <th>Course</th>
                        <th>Term</th>
                        <th>Title</th>
                        <th>Type</th>
                    </thead>
                    <tbody>
                        <xsl:apply-templates/>
                    </tbody>
                </table>
            </body>
        </html>
    </xsl:template>
    <xsl:template match="result">
        <xsl:for-each select="course">
            <tr>
                <td>
                    <xsl:value-of select="catalog_info/course_group"/>
                </td>
                <td>
                    <xsl:value-of select="catalog_info/course_group/@code"/>
                </td>
                <td>
                    <xsl:value-of select="@term_code"/>
                </td>
                <td>
                    <xsl:value-of select="catalog_info/title"/>
                </td>
                <td>
                    <xsl:value-of select="catalog_info/course_type"/>
                </td>
            </tr>
        </xsl:for-each>
    </xsl:template>
    <xsl:template match="text()"/>
</xsl:stylesheet>