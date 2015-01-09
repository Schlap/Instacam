require 'spec_helper'

describe Photo, :type => :model do
  it 'is not valid with a name of less than three characters' do
    photo = Photo.new(name: "ST")
    expect(photo).to have(1).error_on(:name)
    expect(photo).not_to be_valid
  end

  it "is not valid unless it has a unique name" do
    Photo.create(name: "STAG")
    photo = Photo.new(name: "STAG")
    expect(photo).to have(1).error_on(:name)
  end
end
