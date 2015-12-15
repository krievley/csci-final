xquery version "3.0" encoding "UTF-8";

import module namespace local = "http://cscie18.dce.harvard.edu/courses" at "functions.xqm";
import module namespace xslfo="http://exist-db.org/xquery/xslfo";

declare variable $instructor := request:get-parameter('instructor','');

(: If instructor is empty, we are likely working on course detail page only :)
if ($instructor = '')

then (

    let $source-document as document-node() := local:coursedetail()
    let $xslt-document as document-node() := doc('../xsl/courses-fo.xsl')

    let $xslfo-document as document-node() := transform:transform($source-document,$xslt-document,())

    let $media-type as xs:string := "application/pdf"
    return
        response:stream-binary(
            xslfo:render($xslfo-document, $media-type, ()),
            $media-type,
            "courses.pdf"
        )
    )

(: If instructor is not empty, we are working on PDF for course detail page by instructor :)
else if ($instructor != '')

then (
    
    let $source-document as document-node() := local:coursebyinstructordetail()
    let $xslt-document as document-node() := doc('../xsl/coursebyinstructor-fo.xsl')

    let $xslfo-document as document-node() := transform:transform($source-document,$xslt-document,())

    let $media-type as xs:string := "application/pdf"
    return
        response:stream-binary(
            xslfo:render($xslfo-document, $media-type, ()),
            $media-type,
            "coursebyinstructor.pdf"
        )
    
    )
else ()