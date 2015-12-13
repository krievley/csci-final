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
                <link rel="stylesheet" href="https://cdn.datatables.net/1.10.10/css/jquery.dataTables.min.css"/>
            </head>
            <body>
                <div class="container-fluid">
                    <div>
                        <img class="img-responsive" style="padding:25px;" src="http://www.people.fas.harvard.edu/~gillum/harvard_fas_logo.jpg" alt="Harvard FAS" title="Harvard FAS"/>
                    </div>
                    <nav class="navbar navbar-default">
                        <div class="container-fluid">
                            <div class="navbar-header">
                                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
                                    <span class="icon-bar">
                                        <xsl:comment>Bar</xsl:comment>
                                    </span>
                                    <span class="icon-bar">
                                        <xsl:comment>Bar</xsl:comment>
                                    </span>
                                    <span class="icon-bar">
                                        <xsl:comment>Bar</xsl:comment>
                                    </span>
                                </button>
                            </div>
                            <div class="collapse navbar-collapse" id="myNavbar">
                                <ul class="nav navbar-nav">
                                    <li>
                                        <a href="?list=department">Departments</a>
                                    </li>
                                    <li>
                                        <a href="?list=instructor">Instructor</a>
                                    </li>
                                    <li>
                                        <a href="?list=term">Term</a>
                                    </li>
                                    <li>
                                        <a href="?list=schedule">Schedule</a>
                                    </li>
                                </ul>
                                <form class="navbar-form navbar-left" action="courses" method="GET">
                                    <div class="form-group">
                                        <input name="q" type="text" class="form-control" placeholder="Search by title..."/>
                                    </div>
                                    <button type="submit" class="btn btn-default">
                                        <span class="glyphicon glyphicon-search"/>
                                    </button>
                                </form>
                            </div>
                        </div>
                    </nav>
                    <xsl:apply-templates select="departments"/>
                    <xsl:apply-templates select="instructors"/>
                    <xsl:apply-templates select="terms"/>
                    <xsl:apply-templates select="schedule"/>
                </div>
                <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js">
                    <xsl:text>javascript here</xsl:text>
                </script><!-- Include all compiled plugins (below), or include individual files as needed -->
                <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js">
                    <xsl:text>javascript here</xsl:text>
                </script>
                <script src="https://cdn.datatables.net/1.10.10/js/jquery.dataTables.min.js">
                    <xsl:text>javascript here</xsl:text>
                </script>
                <script type="text/javascript">
                    //<xsl:comment>
                        $(function() {
                            $('.datatable').DataTable();
                        } );
                    //</xsl:comment>
                </script>
            </body>
        </html>
    </xsl:template>
    <xsl:template match="departments">
        <table class="table table-bordered table-hover datatable">
            <thead>
                <th>Department Names</th>
            </thead>
            <tbody>
                <xsl:for-each select="*">
                    <tr>
                        <td>
                            <strong>
                                <a href="courses?department={encode-for-uri(@code)}">
                                    <xsl:value-of select="text()"/>
                                </a>
                            </strong>
                        </td>
                    </tr>
                </xsl:for-each>
            </tbody>
        </table>
    </xsl:template>
    <xsl:template match="instructors">
        <table class="table table-bordered table-hover datatable">
            <thead>
                <th>Instructor Names</th>
            </thead>
            <tbody>
                <xsl:for-each select="*">
                    <tr>
                        <td>
                            <strong>
                                <a href="courses?instructor={@code}">
                                    <xsl:value-of select="text()"/>
                                </a>
                            </strong>
                        </td>
                    </tr>
                </xsl:for-each>
            </tbody>
        </table>
    </xsl:template>
    <xsl:template match="terms">
        <div class="row">
            <div class="col-md-6 col-xs-12">
                <h3>Fall Term</h3>
                <table class="table table-bordered table-hover datatable">
                    <thead>
                        <th>Title</th>
                        <th>Class #</th>
                        <th>Section</th>
                    </thead>
                    <tbody>
                        <xsl:for-each select="course[@term_code = 'fall']">
                            <tr>
                                <td>
                                    <strong><!-- Adding reference to course id and class number to browse to class details from terms page -->
                                        <a href="detail?course={encode-for-uri(@course_id)}&amp;classnum={encode-for-uri(@class_number)}">
                                            <xsl:value-of select="catalog_info/title/text()"/>
                                        </a>
                                    </strong>
                                </td>
                                <td>
                                    <xsl:value-of select="@class_number"/>
                                </td>
                                <td>
                                    <xsl:value-of select="@section"/>
                                </td>
                            </tr>
                        </xsl:for-each>
                    </tbody>
                </table>
            </div>
            <div class="col-md-6 col-xs-12">
                <h3>Spring Term</h3>
                <table class="table table-bordered table-hover datatable">
                    <thead>
                        <th>Title</th>
                        <th>Class #</th>
                        <th>Section</th>
                    </thead>
                    <tbody>
                        <xsl:for-each select="course[@term_code = 'spring']">
                            <tr>
                                <td>
                                    <strong>
                                        <a href="detail?course={encode-for-uri(@course_id)}&amp;classnum={encode-for-uri(@class_number)}">
                                            <xsl:value-of select="catalog_info/title/text()"/>
                                        </a>
                                    </strong>
                                </td>
                                <td>
                                    <xsl:value-of select="@class_number"/>
                                </td>
                                <td>
                                    <xsl:value-of select="@section"/>
                                </td>
                            </tr>
                        </xsl:for-each>
                    </tbody>
                </table>
            </div>
        </div>
    </xsl:template>
    <xsl:template match="schedule">
        <table class="table table-bordered table-hover datatable">
            <thead>
                <th>Meeting Schedules</th>
            </thead>
            <tbody>
                <xsl:for-each select="*">
                    <xsl:if test="not(@start_time=preceding-sibling::*[1]/@start_time)">
                        <tr>
                            <td>
                                <strong>
                                    <a href="courses?days={encode-for-uri(@days_of_week)}&amp;start={@start_time}&amp;end={@end_time}">
                                        <xsl:value-of select="@days_of_week"/>
                                        <xsl:text>  </xsl:text>
                                        <xsl:value-of select="@start_time"/>
                                        <xsl:text> - </xsl:text>
                                        <xsl:value-of select="@end_time"/>
                                    </a>
                                </strong>
                            </td>
                        </tr>
                    </xsl:if>
                </xsl:for-each>
            </tbody>
        </table>
    </xsl:template>
    <xsl:template match="text()"/>
</xsl:stylesheet>