require 'rails_helper'

RSpec.describe "pets/new", type: :view do
  before(:each) do
    assign(:pet, Pet.new(
      :name => "MyString",
      :breed => "MyString",
      :size => "MyString",
      :age => "MyString",
      :personality => "MyString"
    ))
  end

  it "renders new pet form" do
    render

    assert_select "form[action=?][method=?]", pets_path, "post" do

      assert_select "input#pet_name[name=?]", "pet[name]"

      assert_select "input#pet_breed[name=?]", "pet[breed]"

      assert_select "input#pet_size[name=?]", "pet[size]"

      assert_select "input#pet_age[name=?]", "pet[age]"

      assert_select "input#pet_personality[name=?]", "pet[personality]"
    end
  end
end
