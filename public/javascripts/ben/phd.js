

// Setup the back button warning:

/*
window.onbeforeunload = function() {
    return 'Hitting the back button will break this experiment, and is disabled';
}
*/

var TIME_LIMIT_IN_MINUTES = 20;

window.participant_id = undefined;
window.group_id       = undefined;


$(document).ready(function() {
    
    //Group and participant ID
    $(".participant").modal({
        close:false,
		overlayId: 'simplemodal-overlay',
		containerId: 'simplemodal-container',         
        onShow: function (dialog) {
			var modal = this;
            $(".participant").show();
            
			// if the user clicks "yes"
			$('.participant .button').click(function () {
			    // clear error message
                $('.participant .error').html("");
                
				// close the dialog
                window.participant_id = $('.participant #participant_id').val();
                window.group_id = $('.participant #group_id').val();

                if(window.participant_id && window.group_id && window.group_id.match(/^\d\d*$/) 
                    && window.participant_id.match(/^\d\d*$/)) {
                        
				    modal.close();
				    // move on to the next step..
                    
                    
                    // HACK: setTimeout because we can only have one modal dialog 
                    //       at a time
                    setTimeout(function(){
                        window.show_instructions();
                    },10);
				    
				    
                }else {
                    var error = "You must enter a valid group id and participant id"
                    $('.participant .error').html(error);
                    if(window.console){
                        window.console.error(error)
                    }
                }
			});
		}
    });
    
    // Add instructions
    window.show_instructions= function() {
        $('.instructions').modal({
            close:true,
            overlayClose:true,
    		overlayId: 'instructions-overlay',
    		containerId: 'instructions-container',         
        });
    }
    
    $(".show_instructions").click(function(event){
        event.stopPropagation();
        
        show_instructions();
        return false;
    });
    
    
    
    // add click handlers for all the individual essays
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    // timer related functions and variables
    var timer = null;
    var seconds = 0;
    window.start_timer = function(){
        window.stop_timer();

        timer = setInterval(function(){
            seconds +=1;
            
            var minutes_to_render =  parseInt(seconds / 60)
            var seconds_to_render = parseInt(seconds % 60)
            
            // render the seconds
            $(".timer").html(minute_to_render + ":" + seconds_to_render);
        
            if(minutes_to_render == TIME_LIMIT_IN_MINUTES){
                window.stop_timer();
                window.quit({'timeout' : true});
            }
        
        },1000)
        
    };
    
    window.stop_timer = function(){
        if(timer){
            clearInterval(timer)
        }
    }
    
    
    
  // Handler for .ready() called.
});
