<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0">
    <xsl:output method="html" doctype-system="about:legacy-compat"/>
    <xsl:template match="/">
        <html>
            <head>
                <meta charset="utf-8"/>
                <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
                <meta name="viewport" content="width=device-width, initial-scale=1"/>
                <title>CSCI E-18, Final Assignment</title>
                <xsl:comment>Bootstrap</xsl:comment>
                <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css"/>
                <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css"/>
                <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap-theme.min.css"/>
            </head>
            <body>
                <div class="container-fluid">
                    <h1>Harvard University<br/>Faculty of Arts and Sciences</h1>
                    <xsl:call-template name="breadcrumb"/>
                    <xsl:apply-templates/>
                </div><!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
                <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js">
                    <xsl:text/>
                </script><!-- Include all compiled plugins (below), or include individual files as needed -->
                <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js">
                    <xsl:text/>
                </script>
            </body>
        </html>
    </xsl:template>
    <xsl:template match="result">
        <xsl:for-each select="course">
            <div class="col-md-12" style="padding-bottom:20px;padding-top:20px;border-bottom:1px solid #f5f5f5;">
                <div class="row">
                    <div class="col-md-2">
                        <strong>Title</strong>
                    </div>
                    <div class="col-md-10">
                        <xsl:value-of select="catalog_info/title"/>
                        <xsl:text> - </xsl:text>
                        <xsl:value-of select="catalog_info/title/@short_title"/>
                    </div>
                </div>
                <xsl:if test="catalog_info/exam_group != ''">
                    <div class="row">
                        <div class="col-md-2">
                            <strong>Exam Group</strong>
                        </div>
                        <div class="col-md-10">
                            <xsl:value-of select="catalog_info/exam_group"/>
                        </div>
                    </div>
                </xsl:if>
                <xsl:if test="catalog_info/description != ''">
                    <div class="row">
                        <div class="col-md-2">
                            <strong>Description</strong>
                        </div>
                        <div class="col-md-10">
                            <xsl:value-of select="catalog_info/description"/>
                        </div>
                    </div>
                </xsl:if>
                <xsl:if test="catalog_info/department/@code != ''">
                    <div class="row">
                        <div class="col-md-2">
                            <strong>Department Code</strong>
                        </div>
                        <div class="col-md-10">
                            <xsl:value-of select="catalog_info/department/@code"/>
                        </div>
                    </div>
                </xsl:if>
                <xsl:if test="catalog_info/department != ''">
                    <div class="row">
                        <div class="col-md-2">
                            <strong>Department</strong>
                        </div>
                        <div class="col-md-10">
                            <xsl:value-of select="catalog_info/department"/>
                        </div>
                    </div>
                </xsl:if>
                <xsl:if test="catalog_info/course_type != ''">
                    <div class="row">
                        <div class="col-md-2">
                            <strong>Course Type</strong>
                        </div>
                        <div class="col-md-10">
                            <xsl:value-of select="catalog_info/course_type"/>
                        </div>
                    </div>
                </xsl:if>
                <xsl:if test="catalog_info/credits != ''">
                    <div class="row">
                        <div class="col-md-2">
                            <strong>Credits</strong>
                        </div>
                        <div class="col-md-10">
                            <xsl:value-of select="catalog_info/credits"/>
                        </div>
                    </div>
                </xsl:if>
                <xsl:if test="catalog_info/meeting_schedule != ''">
                    <div class="row">
                        <div class="col-md-2">
                            <strong>Meeting Schedule</strong>
                        </div>
                        <div class="col-md-10">
                            <xsl:value-of select="catalog_info/meeting_schedule/meeting/@days_of_week"/>
                            <xsl:text> </xsl:text>
                            <xsl:value-of select="catalog_info/meeting_schedule/meeting/@start_time"/>
                            <xsl:text> - </xsl:text>
                            <xsl:value-of select="catalog_info/meeting_schedule/meeting/@end_time"/>
                        </div>
                    </div>
                </xsl:if>
                <xsl:if test="catalog_info/meeting_schedule/meeting/@location != ''">
                    <div class="row">
                        <div class="col-md-2">
                            <strong>Location</strong>
                        </div>
                        <div class="col-md-10">
                            <xsl:value-of select="catalog_info/meeting_schedule/meeting/@location"/>
                        </div>
                    </div>
                </xsl:if>
                <xsl:if test="catalog_info/exam_date != ''">
                    <div class="row">
                        <div class="col-md-2">
                            <strong>Exam Date</strong>
                        </div>
                        <div class="col-md-10">
                            <xsl:value-of select="catalog_info/exam_date"/>
                        </div>
                    </div>
                </xsl:if>
                <xsl:if test="person/display_name != ''">
                    <div class="row">
                        <div class="col-md-2">
                            <strong>Teacher Name</strong>
                        </div>
                        <xsl:for-each select="staff">
                            <div class="col-md-10">
                                <xsl:value-of select="person/display_name"/>
                            </div>
                        </xsl:for-each>
                    </div>
                </xsl:if>
            </div>
        </xsl:for-each>
    </xsl:template>
    <xsl:template name="breadcrumb">
        <ol class="breadcrumb">
            <li>
                <a href="./departments">Home</a>
            </li>
            <li>
                <a href="./courses">Courses</a>
            </li>
            <li class="active">Course Detail</li>
        </ol>
    </xsl:template>
    <xsl:template match="text()"/>
</xsl:stylesheet>