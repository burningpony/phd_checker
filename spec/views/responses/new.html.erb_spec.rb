require 'spec_helper'

describe "responses/new.html.erb" do
  before(:each) do
    assign(:response, stub_model(Response,
      :user_id => 1,
      :correct => false,
      :corrected => "MyString",
      :uncorrected => "MyString"
    ).as_new_record)
  end

  it "renders new response form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => responses_path, :method => "post" do
      assert_select "input#response_user_id", :name => "response[user_id]"
      assert_select "input#response_correct", :name => "response[correct]"
      assert_select "input#response_corrected", :name => "response[corrected]"
      assert_select "input#response_uncorrected", :name => "response[uncorrected]"
    end
  end
end
