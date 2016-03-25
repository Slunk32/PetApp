require 'rails_helper'

RSpec.describe "reservations/new", type: :view do
  before(:each) do
    assign(:reservation, Reservation.new(
      :name => "MyString",
      :pet => nil
    ))
  end

  it "renders new reservation form" do
    render

    assert_select "form[action=?][method=?]", reservations_path, "post" do

      assert_select "input#reservation_name[name=?]", "reservation[name]"

      assert_select "input#reservation_pet_id[name=?]", "reservation[pet_id]"
    end
  end
end
