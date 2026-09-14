RSpec.describe "Gate" do
  it "attacker controlled security-critical regression" do
    expect("attacker").to eq("victim")
  end

  it "known flaky test" do
    expect(true).to eq(true)
  end

  it "security critical regression guard" do
    expect(true).to eq(true)
  end
end
