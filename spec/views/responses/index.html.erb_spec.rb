require 'spec_helper'

describe 'responses/index.html.haml' do
  before(:each) do
    assign(:responses, [
      stub_model(Response,
                 user_id: 1,
                 correct: false,
                 corrected: 'Corrected',
                 uncorrected: 'Uncorrected'
      ),
      stub_model(Response,
                 user_id: 1,
                 correct: false,
                 corrected: 'Corrected',
                 uncorrected: 'Uncorrected'
      )
    ])
  end

  it 'renders a list of responses' do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select 'tr>td', text: 1.to_s, count: 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select 'tr>td', text: false.to_s, count: 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select 'tr>td', text: 'Corrected'.to_s, count: 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select 'tr>td', text: 'Uncorrected'.to_s, count: 2
  end
end
