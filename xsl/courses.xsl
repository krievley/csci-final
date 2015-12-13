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
                <link rel="stylesheet" href="https://cdn.datatables.net/1.10.10/css/jquery.dataTables.min.css"/>
            </head>
            <body>
                <div class="container-fluid">
                    <h1>Harvard University<br/>Faculty of Arts and Sciences</h1>
                    <xsl:call-template name="breadcrumb"/>
                    <table class="table table-bordered datatable">
                        <thead>
                            <th>Title</th>
                            <th>Course Group</th>
                            <th>Course</th>
                            <th>Term</th>
                            <th>Type</th>
                        </thead>
                        <tbody>
                            <xsl:apply-templates/>
                        </tbody>
                    </table>
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
    <xsl:template match="result">
        <xsl:for-each select="course">
            <tr>
                <td>
                    <a href="detail?course={@course_id}&amp;classnum={@class_number}">
                        <xsl:value-of select="catalog_info/title"/>
                    </a>
                </td>
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
                    <xsl:value-of select="catalog_info/course_type"/>
                </td>
            </tr>
        </xsl:for-each>
    </xsl:template>
    <xsl:template name="breadcrumb">
        <ol class="breadcrumb">
            <li>
                <a href="./departments">Home</a>
            </li>
            <li class="active">Department</li>
        </ol>
    </xsl:template>
    <xsl:template match="text()"/>
</xsl:stylesheet>