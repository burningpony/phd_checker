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
window.send_correction = function(
    group_id,
    participant_id,
    essay_id,
    field_id,
    original_value,
    current_value,
    correct_answer,
    quota,
    round_number,
    phase
) {
    phase_int = phase === 'phase_one' ? 1 : 2

    var params = {
        user_id: window.user.id,
        participant_id: participant_id,
        group: group_id,
        response: {
            essay: essay_id,
            error: field_id,
            uncorrected: original_value,
            corrected: current_value.toLowerCase(),
            correct_answer: correct_answer.toLowerCase(),
            quota: quota,
            round_number: round_number,
            controller: window.path_to_controller,
            phase: phase_int
        }
    };

    if (window.console) {
        console.log("storing data:", JSON.stringify(params));
    }

    var str = jQuery.param(params);

    $.ajax({
        type: "POST",
        url: "responses",
        data: str,
        error: function(data) {
            window.stop_timer();
            console.log("fail", JSON.stringify(data));
            $(".error-modal").modal({
                close: false,
                overlayId: "simplemodal-overlay",
                containerId: "simplemodal-container",
                onShow: function(dialog) {
                    var modal = this;
                    $(".error-modal").show();
                    $(".error-modal a.close-modal").click(function() {
                        modal.close();
                        window.start_timer();
                    });
                }
            });
        }
    });
};

window.create_user = function(
    participant_id,
    group_id,
    available_payments,
    job
) {
    if (window.console) {
        console.log("storing user");
    }
    return $.ajax({
        type: "POST",
        url: "users.json",
        data: {
            participant_id: participant_id,
            group: group_id,
            available_payments: available_payments,
            job: job,
            controller: window.path_to_controller
        },
        success: function(data) {
            window.user = data.user;
        }
    });
};

window.start_round = function(round_number, user_id, option, treatment) {
    if (window.console) {
        console.log("updating round");
    }
    return $.ajax({
        type: "POST",
        url: "rounds.json",
        data: {
            user_id: user_id,
            round_number: round_number,
            option: window.option,
            treatment: treatment,
            controller: window.path_to_controller
        },
        success: function(data) {
            window.round = data.round;
        }
    });
};
