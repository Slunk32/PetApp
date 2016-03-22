require 'rails_helper'

RSpec.describe "personalities/new", type: :view do
  before(:each) do
    assign(:personality, Personality.new(
      :trait => "MyString",
      :pet => nil
    ))
  end

  it "renders new personality form" do
    render

    assert_select "form[action=?][method=?]", personalities_path, "post" do

      assert_select "input#personality_trait[name=?]", "personality[trait]"

      assert_select "input#personality_pet_id[name=?]", "personality[pet_id]"
    end
  end
end
