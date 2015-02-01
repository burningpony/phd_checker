require 'spec_helper'
require 'will_paginate/array'
describe 'responses/index.html.haml' do
  before(:each) do
    @u = User.create
    assign(:responses, [
      stub_model(Response,
                 user_id: @u.id,
                 correct: false,
                 corrected: 'Corrected',
                 uncorrected: 'Uncorrected'
      ),
      stub_model(Response,
                 user_id: @u.id,

                 correct: false,
                 corrected: 'Corrected',
                 uncorrected: 'Uncorrected'
      )
    ].paginate(per_page: 1))
  end

  it 'renders a list of responses' do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select 'tr>td', text: @u.id.to_s, count: 1
  end
end
