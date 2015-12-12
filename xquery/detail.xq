xquery version "3.0" encoding "UTF-8";

declare variable $col_path := request:get-attribute('collection_path');
declare variable $col := collection($col_path);
declare variable $id := request:get-parameter('id','*');

<result>
    {   
        for $course in $col/courses/course
        where $course/@course_id eq $id
        return $course
    }
</result>