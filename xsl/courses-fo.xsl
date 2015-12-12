<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:xs="http://www.w3.org/2001/XMLSchema" version="2.0">
    <xsl:output method="xml" indent="yes"/>

<!-- matching on top level object - document - to set all configuration options and call xslt for content -->
    <xsl:template match="/">
        <fo:root>
            <fo:layout-master-set>
                <fo:simple-page-master master-name="main" page-height="11in" page-width="8.5in" margin-top="0.5in" margin-bottom="0.5in" margin-left="1in" margin-right="1in">
                    <fo:region-body margin-top="0.5in" margin-bottom="0.5in"/>
                    <fo:region-before extent="0.5in"/>
                    <fo:region-after extent="0.5in"/>
                </fo:simple-page-master>
            </fo:layout-master-set>
            <fo:page-sequence master-reference="main">
                <!-- fo:static-content for header -->
                <fo:static-content flow-name="xsl-region-before">
                    <fo:block xsl:use-attribute-sets="normal header">
                        
                        <!-- Adding Page Number to Header - According to PDF Sample -->
                        <xsl:text>Page </xsl:text>
                        <fo:page-number/>
                        <xsl:text> of </xsl:text>
                        <fo:page-number-citation ref-id="EndOfDoc"/>
                    </fo:block>
                </fo:static-content>
                <fo:flow flow-name="xsl-region-body">
                    <!-- This is the "main" content -->
                    <!-- title -->
                    <fo:block>
                        <fo:block xsl:use-attribute-sets="title">
                            <xsl:for-each select="course">
                                <xsl:value-of select="catalog_info/title"/>
                            </xsl:for-each>
                        </fo:block>
                    </fo:block>
                    
                    <!-- give empty block at end a known id go get total page numbers -->
                    <fo:block id="EndOfDoc"/>
                </fo:flow>
            </fo:page-sequence>
        </fo:root>
    </xsl:template>

</xsl:stylesheet>