require 'spec_helper'

describe Payment do
  let(:subject) {Payment.new(option)}

  describe "option 1" do
    let(:option) {1}
    it "properly calculates a" do
      subject.a(round_completed_essay: 4, total_completed_essay: 2)
      expect(subject.total_payment).to eq (2 * 0.625)
      expect(subject.round_payment).to eq (4 * 0.625)
    end

    it "properly calculates c" do
      subject.c(total_responses: 5, responses_from_round: 4)
      expect(subject.total_payment).to eq (5 * 0.20)
      expect(subject.round_payment).to eq (4 * 0.20)
    end

    it "properly calculates f" do
      subject.f
      expect(subject.total_payment).to eq (25)
      expect(subject.round_payment).to eq (0)
    end
  end

  describe "option 2" do
    let(:option) {2}
    it "properly calculates a" do
      subject.a(round_completed_essay: 4, total_completed_essay: 2)
      expect(subject.total_payment).to eq (2 * 1.54)
      expect(subject.round_payment).to eq (4 * 1.54)
    end

    it "properly calculates c" do
      subject.c(total_responses: 5, responses_from_round: 4)
      expect(subject.total_payment).to eq (5 * 0.56)
      expect(subject.round_payment).to eq (4 * 0.56)
    end

    it "properly calculates f" do
      subject.f
      expect(subject.total_payment).to eq (24.64)
      expect(subject.round_payment).to eq (0)
    end

  end

  describe "option 3" do
    let(:option) {3}
    it "properly calculates a" do
      subject.a(round_completed_essay: 4, total_completed_essay: 2)
      expect(subject.total_payment).to eq (2 * 1.54)
      expect(subject.round_payment).to eq (4 * 1.54)
    end

    it "properly calculates c" do
      subject.c(total_responses: 5, responses_from_round: 4)
      expect(subject.total_payment).to eq (5 * 0.56)
      expect(subject.round_payment).to eq (4 * 0.56)
    end

    it "properly calculates f" do
      subject.f
      expect(subject.total_payment).to eq (24.64)
      expect(subject.round_payment).to eq (0)
    end
  end

  describe "Invalid Option" do
    let(:option) {"a"}
    it "properly calculates a" do
      expect { subject.a(round_completed_essay: 4, total_completed_essay: 2)}.to raise_error
    end

    it "properly calculates c" do
      expect { subject.c(total_responses: 5, responses_from_round: 4)}.to raise_error
    end

    it "properly calculates f" do
      expect { subject.f }.to raise_error
    end
  end
end
