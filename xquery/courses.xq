xquery version "3.0" encoding "UTF-8";

declare variable $col_path := request:get-attribute('collection_path');
declare variable $col := collection($col_path);
declare variable $query := request:get-attribute('xslt.querystring');

<result>
    {   
        for $course in $col/courses/course
        return $course
    }
</result>