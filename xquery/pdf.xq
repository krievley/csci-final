xquery version "3.0" encoding "UTF-8";

import module namespace local = "http://cscie18.dce.harvard.edu/courses" at "functions.xqm";
import module namespace xslfo="http://exist-db.org/xquery/xslfo";

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