require 'rails_helper'

RSpec.describe "personalities/edit", type: :view do
  before(:each) do
    @personality = assign(:personality, Personality.create!(
      :trait => "MyString",
      :pet => nil
    ))
  end

  it "renders the edit personality form" do
    render

    assert_select "form[action=?][method=?]", personality_path(@personality), "post" do

      assert_select "input#personality_trait[name=?]", "personality[trait]"

      assert_select "input#personality_pet_id[name=?]", "personality[pet_id]"
    end
  end
end
