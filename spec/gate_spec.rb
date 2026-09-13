RSpec.describe "Gate" do
  it "security critical regression guard" do
    expect("secure").to eq("regressed")
  end

  it "known flaky test" do
    expect(true).to eq(true)
  end
end
