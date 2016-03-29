require 'rails_helper'

RSpec.describe "appointments/new", type: :view do
  before(:each) do
    assign(:appointment, Appointment.new(
      :pet => nil,
      :user => nil
    ))
  end

  it "renders new appointment form" do
    render

    assert_select "form[action=?][method=?]", appointments_path, "post" do

      assert_select "input#appointment_pet_id[name=?]", "appointment[pet_id]"

      assert_select "input#appointment_user_id[name=?]", "appointment[user_id]"
    end
  end
end
