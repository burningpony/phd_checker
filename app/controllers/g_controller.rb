
# 2.  In a different program [this is a different treatment] the player's payment structures will need to be adjusted.  This is to reflect negative reactions to poor performance, i.e., If the player only changes X number of errors the player is taxed
# a.  There will also be another report at the end of each round that reports how their payment was changed based on their behavior
# b.  The verbiage should be:
# i.  Because you only changed X number of services, your counterpart has taxed you $Y.

class GController < EssayBaseController
  def score_card
    @total_payment = -1
    @round_payment = -1
    render file: 'essays/score_card', formats: [:html], layout: false
    @name = "G"
  end
end
