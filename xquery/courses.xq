xquery version "3.0" encoding "UTF-8";

declare variable $col_path := request:get-attribute('collection_path');
declare variable $col := collection($col_path);
declare variable $query := request:get-parameter('department','*');

<result>
    {   
        for $course in $col/courses/course
        where $course/catalog_info/department/@code eq $query
        return $course
    }
</result>