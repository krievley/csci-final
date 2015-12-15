xquery version "3.0" encoding "UTF-8";

declare variable $instructor := request:get-parameter('instructor','');

if ($instructor != '')

then (
    
    let $col_path := request:get-attribute('collection_path')
    let $col := collection($col_path)
    let $instructor := request:get-parameter('instructor','')

    return
        <course>
            {
            for $course in $col/courses/course
            where ($course/staff/person/display_name eq $instructor)
            order by $course/catalog_info/title
            return $course
            }
        <instructorname>
            {
                $instructor
            }
        </instructorname>
        
        </course>
    
    )
else ()