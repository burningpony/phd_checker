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
window.send_correction = function( group_id, participant_id, essay_id, field_id, original_value, current_value, correct_answer, quota, round_number ) {
    var params = {
        "user_id": window.user.id,
        "participant_id": participant_id,
        "group": group_id,
        "response": {
            essay: essay_id,
            field_id: field_id,
            uncorrected: original_value,
            corrected: current_value,
            correct: ( correct_answer == current_value ),
            correct_answer: correct_answer,
            quota: quota,
            round_number: round_number,
            controller: window.path_to_controller
        }
    };

    if ( window.console ) {
        console.log( "storing data:", params )
    }

    var str = jQuery.param( params );

    $.ajax( {
            type: 'POST',
            url: "responses",
            data: str,
            error: function( data ) {

                window.stop_timer();
                console.log( 'fail', data )
                $( ".error-modal" ).modal( {
                    close: false,
                    overlayId: 'simplemodal-overlay',
                    containerId: 'simplemodal-container',
                    onShow: function( dialog ) {
                      var modal = this;
                      $(".error-modal").show();
                      $('.error-modal a.close-modal').click( function(){
                        modal.close();
                        window.start_timer();
                      });
                    }
                } );
            }
    } );
}
