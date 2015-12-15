xquery version "3.0" encoding "UTF-8";

module namespace local = "http://cscie18.dce.harvard.edu/courses";

(: function used by course detail page - detail.xsl - to render content in PDF format :)
declare function local:coursedetail() as node() 
{
    let $col_path := request:get-attribute('collection_path')
    let $col := collection($col_path)
    let $code := request:get-parameter('course','')
    let $classnum := request:get-parameter('classnum','')
    let $term :=request:get-parameter('term','')

    return
        <course>
            {
            for $course in $col/courses/course
            where ($course/@course_id eq $code 
            and $course/@class_number eq $classnum
            and $course/@term_code eq $term
            )
            return $course
            }
        </course>    
};

(: function used by instructor page, to print course detail information for all courses taught by a specific professor :)
declare function local:coursebyinstructordetail() as node() 
{
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
};