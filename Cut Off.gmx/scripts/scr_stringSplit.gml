///scr_stringSplit(str, delimiter, letDelimiter);
/* This code separates a string into an array
*
* Note, you must use Dont forget ds_list_destroy after you iterate all strings for example:
* var splited = string_split("first part|second part", '|')
* for(splited) {
* //do something with each string
* }
* ds_list_destroy(splited)
*/

var str = argument[0]; //string to split
var delimiter = argument[1]; // delimiter
var letDelimiter = false; // append delimiter to each part
if(argument_count == 3) {
    letDelimiter = argument[2];
}
str += delimiter;

var list = ds_list_create();
var d_at = string_pos(delimiter, str);

while(d_at > 0) {
    var part = string_delete(str, d_at , string_length(str));
    if (letDelimiter) {
        part += delimiter;
    }
    str = string_delete(str, 1, d_at);
    d_at = string_pos(delimiter, str);
    ds_list_add(list, part);
    
    if (d_at == 0 && str != "") {//last string without delimiter, need to add too
        ds_list_add(list, str);
    }
}

return list;