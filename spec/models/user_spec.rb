require 'rails_helper'

RSpec.describe User do
  it { should validate_presence_of :email }
  it { shoul validate_presence_of :pass }
end