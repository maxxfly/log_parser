require 'spec_helper'
require 'log_parser'

describe LogParser do
  let(:parser) { described_class.new(File.dirname(__FILE__) + '/fixtures/webserver.log') }

  describe "#entries" do
    let(:entry1) { {path: "/home", address: "127.0.0.1"} }
    let(:entry2) { {path: "/panda.txt", address: "127.0.0.1"} }
    let(:entry3) { {path: "/panda.txt", address: "192.168.1.1"} }

    it { expect(parser.entries.count).to eql 7 }
    it { expect(parser.entries).to include entry1 }
    it { expect(parser.entries).to include entry2 }
    it { expect(parser.entries).to include entry3 }

    it { expect(parser.entries).to eql [entry1, entry2, entry3, entry3, entry1, entry1, entry1] }
  end

  describe "#retrieve_top_views" do
    let(:result_top_view) { parser.retrieve_top_views }

    it { expect(result_top_view.count).to eql 2 }
    it { expect(result_top_view[0]).to eql ["/home", 4] }
    it { expect(result_top_view[1]).to eql ["/panda.txt", 3] }
  end

  describe "#retrieve_top_uniq_views" do
    let(:result_top_view) { parser.retrieve_top_uniq_views }

    it { expect(result_top_view.count).to eql 2 }
    it { expect(result_top_view[0]).to eql ["/panda.txt", 2] }
    it { expect(result_top_view[1]).to eql ["/home", 1] }
  end

  describe "#output" do
    let(:result) { parser.output }

    it do
      expect(result).to eql "/home\t4 views\n" +
                            "/panda.txt\t3 views\n" +
                            "\n" +
                            "/panda.txt\t2 uniq views\n" +
                            "/home\t1 uniq views"
    end
  end

end
