/*
                window.group_id,
                window.participant_id,
                window.essay_id,
                field_id,
                original_value,
                current_value,
                correct_answer,
                (span.className.match(/quota/i)) 
*/    
    
    
// Russell's correction function
window.send_correction = function(group_id, participant_id, essay_id, field_id, original_value, current_value, correct_answer, quota, round_number ) {
    var params = {
        "participant_id": participant_id,
		"group" : group_id,
        "response": {
            essay: essay_id,
            id: field_id,
            group: group_id
            uncorrected: original_value,
            corrected: current_value,
            correct: (correct_answer == current_value),
            correct_answer: correct_answer,
            quota: quota,
            round_number: round_number, 
            controller: window.path_to_controller 
        }
    };
    
    if(window.console) {
        console.log("storing data:", params)
    }
    
    var str = jQuery.param(params);

    $.ajax({
        type: 'POST',
        url: "responses",
        data: str
    });
}


