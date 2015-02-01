require 'spec_helper'

describe 'users/index.html.haml' do
  before(:each) do
    assign(:users, [
      stub_model(User,
                 id: 1,
                 name: 'Name',
                 group: '4'
      ),
      stub_model(User,
                 id: 1,
                 name: 'Name',
                 group: '4'
      )
    ])
  end

  it 'renders a list of users' do
    render template: 'users/index', layout: 'layouts/application'
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select 'tr>td', text: 1.to_s, count: 2
  end
end
