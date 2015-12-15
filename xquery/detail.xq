xquery version "3.0" encoding "UTF-8";

declare variable $col_path := request:get-attribute('collection_path');
declare variable $col := collection($col_path);
declare variable $id := request:get-parameter('id','*');
declare variable $code := request:get-parameter('course','');
declare variable $classnum := request:get-parameter('classnum','');
declare variable $term := request:get-parameter('term','');

(:<result>:)
(:    {   :)
(:        for $course in $col/courses/course:)
(:        where $course/@course_id eq $id:)
(:        return $course:)
(:    }:)
(:</result>:)

if ($code != "" and $classnum != "")
then
<course>
    {   
        for $course in $col/courses/course
        where $course/@course_id eq $code 
        and $course/@class_number eq $classnum
        and $course/@term_code eq $term
        return $course
    }
</course>

else
    <none></none>