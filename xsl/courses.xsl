<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0">
    <xsl:output method="html" doctype-system="about:legacy-compat"/>
    <xsl:template match="/">
        <html>
            <head>
                <meta charset="utf-8"/>
                <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
                <meta name="viewport" content="width=device-width, initial-scale=1"/>
                <title>CSCI E-18, Assignment 2</title>
                <xsl:comment>Bootstrap</xsl:comment>
                <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css"/>
                <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css"/>
                <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap-theme.min.css"/>
            </head>
            <body>
                <div class="container-fluid">
                    <h1>Harvard University<br/>Faculty of Arts and Sciences</h1>
                    
                    
                    <!-- Applying Department Template -->
                    <xsl:apply-templates select="department"/>
                    
                    <!-- Applying Course Template -->
                    <xsl:apply-templates select="course"/>
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
    <xsl:template match="department">
    <!-- Calling breadcrumb on Department -->
        <xsl:call-template name="breadcrumb-dept"/>
    
    <!-- Calling for Department View -->
        <table class="table table-bordered">
            <thead>
                <th>Course Group</th>
                <th>Course</th>
                <th>Term</th>
                <th>Title</th>
                <th>Type</th>
            </thead>
            <tbody>
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
                                        <!-- Found that some classes have the same course_id # - had to build in logic to include class number to make the request distinct -->
                            <a href="?course={encode-for-uri(@course_id)}&amp;classnum={encode-for-uri(@class_number)}">
                                <xsl:value-of select="catalog_info/title"/>
                            </a>
                        </td>
                        <td>
                            <xsl:value-of select="catalog_info/course_type"/>
                        </td>
                    </tr>
                </xsl:for-each>
            </tbody>
        </table>
    </xsl:template>
    
    
    <!-- Setting up Course detailed view -->
    <xsl:template match="course">
    
    <!-- Calling breadcrumb on Course -->
        <xsl:call-template name="breadcrumb-course"/>
    
    <!-- Selecting Course Title -->
        <h2>
            <xsl:value-of select="course/catalog_info/title"/>
        </h2>
        <table class="table">
        <!-- Selecting multiple course values for display in detailed course information page -->
            <tbody>
                <tr>
                    <td>Course ID:</td>
                    <td>
                        <xsl:value-of select="course/@course_id"/>
                    </td>
                </tr>
                <tr>
                    <td>Class Number:</td>
                    <td>
                        <xsl:value-of select="course/@class_number"/>
                    </td>
                </tr>
                <tr>
                    <td>Academic Year:</td>
                    <td>
                        <xsl:value-of select="course/@academic_year"/>
                    </td>
                </tr>
                <tr>
                    <td>Class Type:</td>
                    <td>
                        <xsl:value-of select="course/catalog_info/course_type"/>
                    </td>
                </tr>
                <tr>
                    <td>Department:</td>
                    <td>
                        <xsl:value-of select="course/catalog_info/department"/>
                    </td>
                </tr>
                <tr>
                    <td>Credits:</td>
                    <td>
                        <xsl:value-of select="course/catalog_info/credits"/>
                    </td>
                </tr>
                <tr>
                                    <!-- Selecting Staff members - also using XSL Sorting on seniority -->
                    <td>Staff:</td>
                    <td>
                        <xsl:for-each select="course/staff/person">
                            <xsl:sort select="course/staff/person/@seniority_sort"/>
                            <xsl:value-of select="display_name"/>
                        </xsl:for-each>
                    </td>
                </tr>
                <tr>
                                    <!-- displaying meeting schedule/information -->
                    <table class="table">
                        <tr>
                            <th>Meeting Information</th>
                        </tr>
                        <tr>
                                            <!-- Testing whether meeting information is available or not -->
                            <xsl:choose>
                                                <!-- Testing existance of meeting node -->
                                <xsl:when test="course/catalog_info/meeting_schedule">
                                    <td>Start Time: <xsl:value-of select="course/catalog_info/meeting_schedule/meeting/@start_time"/>
                                    </td>
                                    <td>End Time: <xsl:value-of select="course/catalog_info/meeting_schedule/meeting/@end_time"/>
                                    </td>
                                    <td>Location: <xsl:value-of select="course/catalog_info/meeting_schedule/meeting/@location"/>
                                    </td>
                                    <td>Days of the Week: <xsl:value-of select="course/catalog_info/meeting_schedule/meeting/@days_of_week"/>
                                    </td>
                                </xsl:when>
                                                <!-- if node isn't present, echo friendly message -->
                                <xsl:otherwise>
                                    <td>Unfortunately no Meeting Information is available at this time.</td>
                                </xsl:otherwise>
                            </xsl:choose>
                        </tr>
                    </table>
                </tr>
                                
                                <!-- Displaying Course Description -->
                <tr>
                    <table class="table">
                        <tr>
                            <th>Class Description</th>
                        </tr>
                        <tr>
                            <td>
                                <xsl:value-of select="course/catalog_info/description"/>
                            </td>
                        </tr>
                    </table>
                </tr>
            </tbody>
        </table>
    </xsl:template>
    <xsl:template name="breadcrumb-dept">
        <ol class="breadcrumb">
            <li>
                <a href="./departments">Home</a>
            </li>
            <li class="active">Department</li>
        </ol>
    </xsl:template>
    <xsl:template name="breadcrumb-course">
        <ol class="breadcrumb">
            <li>
                <a href="./departments">Home</a>
            </li>
            <li class="active">Course</li>
        </ol>
    </xsl:template>
    <xsl:template match="text()"/>
</xsl:stylesheet>