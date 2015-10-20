<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0">
    <xsl:output method="html" doctype-system="about:legacy-compat"/>
    <xsl:template match="/">
        <html>
            <head>
                <title>CSCI E-18, Assignment 2</title>
            </head>
            <body>
                <h1>Harvard University<br/>Faculty of Arts and Sciences</h1>
                <xsl:apply-templates/>
            </body>
        </html>
    </xsl:template>
    <table>
        <th>
            <td>Course Group</td>
            <td>Course</td>
            <td>Term</td>
            <td>Title</td>
            <td>Type</td>
        </th>
        <tbody>
            <xsl:template match="result">
                <xsl:for-each select="*">
                    <tr>
                        <td>
                            <xsl:value-of select="course_group "/>
                        </td>
                        <td>
                            <xsl:value-of select="course/@course_id"/>
                        </td>
                        <td>
                            <xsl:value-of select="course/@term_code"/>
                        </td>
                        <td>
                            <xsl:value-of select="title"/>
                        </td>
                        <td>
                            <xsl:value-of select="course_type"/>
                        </td>
                    </tr>
                </xsl:for-each>
            </xsl:template>
        </tbody>
    </table>
    <xsl:template match="text()"/>
</xsl:stylesheet>