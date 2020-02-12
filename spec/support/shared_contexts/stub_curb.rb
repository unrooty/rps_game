# frozen_string_literal: true

RSpec.shared_context "stub_curb", :stub_curb do
  before do
    WebMock.enable!
  end

  after(:all) do
    WebMock.disable!
  end
end
