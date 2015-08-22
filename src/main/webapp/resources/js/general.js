function getCurrentURLWithoutGetParams()
{
    //get full url
    var url = window.location.href;
    //get url after/  
    var value = url.substring(0, url.indexOf('?'));
    //get the part after before ?
    //value = value.split("?")[0];
    return value;
}

//nth_occurrence('aaaaacabkhjecdddchjke', 'c', 3);
// Returns 16. The index of the third 'c' character.
function nth_occurrence(string, char, nth) {
    var first_index = string.indexOf(char);
    var length_up_to_first_index = first_index + 1;

    if (nth == 1) {
        return first_index;
    } else {
        var string_after_first_occurrence = string.slice(length_up_to_first_index);
        var next_occurrence = nth_occurrence(string_after_first_occurrence, char, nth - 1);

        if (next_occurrence === -1) {
            return -1;
        } else {
            return length_up_to_first_index + next_occurrence;
        }
    }
}

function clearGoogleParamsFromURL() {
    var currentURL = getCurrentURLWithoutGetParams();
    if (currentURL) {
        var indexOfProjectName = nth_occurrence(currentURL, '/', 3);
        window.history.pushState("object or string", "Title", "/" + currentURL.substring(indexOfProjectName + 1));
    }

}