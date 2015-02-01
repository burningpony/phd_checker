require 'spec_helper'

describe 'users/show.html.haml' do
  before(:each) do
    @user = assign(:user, stub_model(User,
                                     id: 1,
                                     name: 'Name'
    ))
  end

  it 'renders attributes in <p>' do
    render template: 'users/show.html.haml', layout: 'layouts/application'
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    expect(rendered).to match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    expect(rendered).to match(/Name/)
  end
end
