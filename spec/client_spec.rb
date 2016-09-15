require "rspec"

describe "client" do
  before(:each) do
    User.base_uri = "http://localhost:3000"
  end

  it "should get a user" do
    user = User.find_by_name("paul")
    expect(user["name"]).to eql("paul")
    expect(user["email"]).to eql("paul@pauldix.net")
    expect(user["bio"]).to eql("rubyist")
  end

  it "should return nil for a user not found" do
    expect(User.find_by_name("gosling").to be_nil)
  end

  it "should create a user" do
    user = User.create({
      :name => "trotter",
      :email => "no spam",
      :password => "whatev"})
    expect(user["name"]).to eql("trotter")
    expect(user["email"]).to eql("no spam")
    expect(User.find_by_name("trotter")).to eql(user)
  end

  it "should update a user" do
    user = User.update("paul", {:bio => "rubyist and author"})
    expect(user["name"]).to eql("paul")
    expect(user["bio"]).to eql("rubyist and author")
    expect(User.find_by_name("paul")).to eql(user)
  end

  it "should destroy a user" do
    expect(User.destroy("bryan")).to be_true
    expect(User.find_by_name("bryan")).to be_nil
  end

  it "should verify login credentials" do
    user = User.login("paul", "strongpass")
    expect(user["name"]).to eql("paul")
  end

  it "should return nil with invalid credentials" do
    expect(User.login("paul", "wrongpassword")).to be_nil
  end
end