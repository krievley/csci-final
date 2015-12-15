<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:xs="http://www.w3.org/2001/XMLSchema" version="2.0">
    <xsl:output method="xml" indent="yes"/><!-- matching on top level object - document - to set all configuration options and call xslt for content --><!-- Setting up styling attributes for PDF document -->
    <xsl:attribute-set name="tableheader">
        <xsl:attribute name="font-family">'Times New Roman', Times, serif</xsl:attribute>
        <xsl:attribute name="font-size">14pt</xsl:attribute>
        <xsl:attribute name="font-weight">bold</xsl:attribute>
        <xsl:attribute name="color">#ffffff</xsl:attribute>
        <xsl:attribute name="background-color">#666666</xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="normal">
        <xsl:attribute name="font-family">'Times New Roman', Times, serif</xsl:attribute>
        <xsl:attribute name="font-size">10pt</xsl:attribute>
        <xsl:attribute name="line-height">16pt</xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="header-right">
        <xsl:attribute name="font-size">8pt</xsl:attribute>
        <xsl:attribute name="text-align">right</xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="header-left">
        <xsl:attribute name="text-align">left</xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="footer">
        <xsl:attribute name="font-size">8pt</xsl:attribute>
        <xsl:attribute name="text-align">end</xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="toc">
        <xsl:attribute name="font-family">'Times New Roman', Times, serif</xsl:attribute>
        <xsl:attribute name="font-size">12pt</xsl:attribute>
        <xsl:attribute name="line-height">14pt</xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="bold">
        <xsl:attribute name="font-weight">bold</xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="pagetitle">
        <xsl:attribute name="font-family">'Times New Roman', Times, serif</xsl:attribute>
        <xsl:attribute name="font-size">10pt</xsl:attribute>
        <xsl:attribute name="font-weight">bold</xsl:attribute>
        <xsl:attribute name="text-align">left</xsl:attribute>
        <xsl:attribute name="padding">0.25em</xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="coursetitle">
        <xsl:attribute name="font-family">'Times New Roman', Times, serif</xsl:attribute>
        <xsl:attribute name="font-size">20pt</xsl:attribute>
        <xsl:attribute name="text-align">left</xsl:attribute>
        <xsl:attribute name="padding">0.25em</xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="subtitle">
        <xsl:attribute name="font-family">'Times New Roman', Times, serif</xsl:attribute>
        <xsl:attribute name="font-size">12pt</xsl:attribute>
        <xsl:attribute name="text-align">center</xsl:attribute>
        <xsl:attribute name="margin-bottom">10pt</xsl:attribute>
    </xsl:attribute-set>
    <xsl:attribute-set name="pagebreak">
        <xsl:attribute name="break-before">page</xsl:attribute>
    </xsl:attribute-set><!-- Matching on Document Root -->
    <xsl:template match="/"><!-- defining root -->
        <fo:root>
            <fo:layout-master-set>
                <fo:simple-page-master master-name="main" page-height="11in" page-width="8.5in" margin-top="0.5in" margin-bottom="0.5in" margin-left="1in" margin-right="1in">
                    <fo:region-body margin-top="1.0in" margin-bottom="0.5in"/>
                    <fo:region-before extent="0.5in"/>
                    <fo:region-after extent="0.5in"/>
                </fo:simple-page-master>
            </fo:layout-master-set>
            <fo:page-sequence master-reference="main"><!-- fo:static-content header -->
                <fo:static-content flow-name="xsl-region-before">
                    <fo:block xsl:use-attribute-sets="normal header-left" background-color="000000"><!-- Adding Logo to Page -->
                        <fo:external-graphic src="http://trademark.harvard.edu/profiles/openscholar/themes/hwpi_basetheme/images/harvard-logo.png"/>
                    </fo:block>
                    <fo:block xsl:use-attribute-sets="normal header-right"><!-- Adding Page Number to Header - According to PDF Sample -->
                        <xsl:text>Page </xsl:text>
                        <fo:page-number/>
                        <xsl:text> of </xsl:text>
                        <fo:page-number-citation ref-id="EndOfDoc"/>
                    </fo:block>
                </fo:static-content><!-- Adding Footer -->
                <fo:static-content flow-name="xsl-region-after">
                    <fo:block xsl:use-attribute-sets="pagetitle" margin-top="0.4in">
                        Harvard University Faculty of Arts and Sciences - All Rights Reserved
                        </fo:block>
                </fo:static-content>
                <fo:flow flow-name="xsl-region-body"><!-- This is the "main" content --><!-- Adding Instructor Name -->
                    <fo:block xsl:use-attribute-sets="coursetitle">
                        <xsl:value-of select="course/instructorname"/>
                    </fo:block><!-- Adding subtitle below professor name for clarity -->
                    <fo:block xsl:use-attribute-sets="subtitle">
                        -- List of courses taught by the Professor --
                    </fo:block><!-- Adding TOC based on Course Name -->
                    <fo:block><!-- start same for each group to create TOC -->
                        <xsl:for-each-group select="course/course" group-by="catalog_info/course_group">
                            <xsl:for-each select="current-group()">
                                <fo:block>
                                    <fo:block text-align-last="justify">
                                        <fo:basic-link>
                                            <xsl:attribute name="internal-destination">
                                                <xsl:value-of select="generate-id()"/>
                                            </xsl:attribute>
                                            <xsl:value-of select="catalog_info/title"/>
                                        </fo:basic-link>
                                        <fo:leader leader-pattern="dots"/>
                                        <fo:page-number-citation>
                                            <xsl:attribute name="ref-id">
                                                <xsl:value-of select="generate-id()"/>
                                            </xsl:attribute>
                                        </fo:page-number-citation>
                                    </fo:block>
                                </fo:block>
                            </xsl:for-each>
                        </xsl:for-each-group>
                    </fo:block>
                    <fo:block><!-- adding page break after TOC -->
                        <fo:block xsl:use-attribute-sets="pagebreak"/>
                    </fo:block><!-- Starting Table with Course Detail Information -->
                    <xsl:for-each select="course/course"><!-- adding ID and generate I for TOC logic -->
                        <fo:block id="{generate-id()}" xsl:use-attribute-sets="coursetitle" margin-top="0.2in">
                            <xsl:value-of select="catalog_info/title"/>
                        </fo:block>
                        <fo:block margin-bottom="0.5in">
                            <fo:table border-style="solid" border-width="0.5pt" border-color="#dddddd" table-layout="fixed" width="100%">
                                <fo:table-column column-width="2.125in"/>
                                <fo:table-column/>
                                <fo:table-body>
                                    <fo:table-row>
                                        <fo:table-cell>
                                            <fo:block>Course ID </fo:block>
                                        </fo:table-cell>
                                        <fo:table-cell>
                                            <fo:block>
                                                <xsl:value-of select="@course_id"/>
                                            </fo:block>
                                        </fo:table-cell>
                                    </fo:table-row>
                                    <fo:table-row>
                                        <fo:table-cell>
                                            <fo:block>Class Number </fo:block>
                                        </fo:table-cell>
                                        <fo:table-cell>
                                            <fo:block>
                                                <xsl:value-of select="@class_number"/>
                                            </fo:block>
                                        </fo:table-cell>
                                    </fo:table-row>
                                    <fo:table-row>
                                        <fo:table-cell>
                                            <fo:block>Academic Year </fo:block>
                                        </fo:table-cell>
                                        <fo:table-cell>
                                            <fo:block>
                                                <xsl:value-of select="@academic_year"/>
                                            </fo:block>
                                        </fo:table-cell>
                                    </fo:table-row>
                                    <fo:table-row>
                                        <fo:table-cell>
                                            <fo:block>Course Type </fo:block>
                                        </fo:table-cell>
                                        <fo:table-cell>
                                            <fo:block>
                                                <xsl:value-of select="catalog_info/course_type"/>
                                            </fo:block>
                                        </fo:table-cell>
                                    </fo:table-row>
                                    <fo:table-row>
                                        <fo:table-cell>
                                            <fo:block>Department </fo:block>
                                        </fo:table-cell>
                                        <fo:table-cell>
                                            <fo:block>
                                                <xsl:value-of select="catalog_info/department"/>
                                            </fo:block>
                                        </fo:table-cell>
                                    </fo:table-row>
                                    <fo:table-row>
                                        <fo:table-cell>
                                            <fo:block>Credits </fo:block>
                                        </fo:table-cell>
                                        <fo:table-cell>
                                            <fo:block>
                                                <xsl:value-of select="catalog_info/credits"/>
                                            </fo:block>
                                        </fo:table-cell>
                                    </fo:table-row>
                                    <fo:table-row>
                                        <fo:table-cell>
                                            <fo:block>Staff </fo:block>
                                        </fo:table-cell>
                                        <fo:table-cell>
                                            <fo:block><!-- selecting staff and ordering by Seniority -->
                                                <xsl:for-each select="staff/person">
                                                    <xsl:sort select="staff/person/@seniority_sort"/>
                                                    <xsl:value-of select="display_name"/>
                                                </xsl:for-each>
                                            </fo:block>
                                        </fo:table-cell>
                                    </fo:table-row>
                                </fo:table-body>
                            </fo:table>
                        </fo:block><!-- Starting block with Meeting Information -->
                        <fo:block margin-bottom="0.5in">
                            <fo:block font-size="15pt">
                            Meeting Information
                        </fo:block>
                            <fo:block margin-bottom="0.5in"><!-- Testing whether meeting information is available or not -->
                                <xsl:choose><!-- Testing existance of meeting node -->
                                    <xsl:when test="catalog_info/meeting_schedule">
                                        <fo:block>Start Time: <xsl:value-of select="catalog_info/meeting_schedule/meeting/@start_time"/>
                                        </fo:block>
                                        <fo:block>End Time: <xsl:value-of select="catalog_info/meeting_schedule/meeting/@end_time"/>
                                        </fo:block>
                                        <fo:block>Location: <xsl:value-of select="catalog_info/meeting_schedule/meeting/@location"/>
                                        </fo:block>
                                        <fo:block>Days of the Week: <xsl:value-of select="catalog_info/meeting_schedule/meeting/@days_of_week"/>
                                        </fo:block>
                                    </xsl:when><!-- if node isn't present, echo friendly message -->
                                    <xsl:otherwise>
                                        <fo:block>Unfortunately no Meeting Information is available at this time.</fo:block>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </fo:block><!-- Starting Block with Course Description -->
                            <fo:block font-size="15pt">Course Description</fo:block>
                            <fo:block>
                                <xsl:choose><!-- Testing existance of meeting node -->
                                    <xsl:when test="catalog_info/description">
                                        <fo:block>
                                            <xsl:value-of select="catalog_info/description"/>
                                        </fo:block>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <fo:block>
                                        Unfortunately no Description is available at this time.
                                    </fo:block>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </fo:block>
                        </fo:block>
                    </xsl:for-each>xsl:for-each&gt;
                    
                    <!-- give empty block at end a known id go get total page numbers -->
                    <fo:block id="EndOfDoc"/>
                </fo:flow>
            </fo:page-sequence>
        </fo:root>
    </xsl:template>
</xsl:stylesheet>