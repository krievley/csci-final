xquery version "3.0" encoding "UTF-8";

module namespace local = "http://cscie18.dce.harvard.edu/courses";

declare function local:coursedetail() as node() 

{
    let $col_path := request:get-attribute('collection_path')
    let $col := collection($col_path)
    let $code := request:get-parameter('course','')
    let $classnum := request:get-parameter('classnum','')

    return
        <course>
            {
            for $course in $col/courses/course
            where ($course/@course_id eq $code and $course/@class_number eq $classnum)
            return $course
            }
        </course>    
};