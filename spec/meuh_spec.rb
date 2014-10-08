# coding: utf-8
require "rspec"
require "meuh"


RSpec::Matchers.define :be_one_of do |elements|
  match do |text|
    elements.any? { |element| element === text }
  end
  failure_message do |text|
    "expected #{text.inspect} to be in #{elements.inspect}"
  end
end


describe Meuh::Brain do
  let(:botname) { "M3uh" }
  let(:brain) { Meuh::Brain.new(botname: botname) }
  let(:nickname) { "sunny" }
  let(:nicknames) { ["sunny", "NaPs", botname] }

  it 'has a botname' do
    expect(brain.botname).to eq("M3uh")
  end

  it 'can change its botname' do
    brain.botname = "bar"
    expect(brain.botname).to eq("bar")
  end

  it 'never responds to !commands' do
    300.times { expect(msg("!foo")).to eq(nil) }
  end

  it 'responds to "où"' do
    expect(msg("où est ma tête ?")).to eq("dtc")
    expect(msg("OÙ est la tienne?")).to eq("dtc")
    expect(msg("où la tête de M3uh ?")).to eq("dtc")
    expect(msg("mais où donc ?")).not_to eq("dtc")
    expect(msg("où pas")).not_to eq("dtc")
    expect(msg("oùzbèque")).not_to eq("dtc")
  end

  it 'responds to "qui"' do
    expected = /^[Cc][’']est (sunny|NaPs)( !)?$/
    expect(msg("qui a volé l’orange ?")).to match(expected)
    expect(msg("qui a volé M3uh?")).to match(expected)
    expect(msg("t’es qui ?")).not_to match(expected)
    expect(msg("quittons cet endroit infâme?")).not_to match(expected)
    expect(msg("qui peut le + peut le -")).not_to match(expected)
  end

  it 'reponds to questions addressed to its name' do
    answers = ['ouais', 'euh ouais', 'vi', 'affirmatif', 'sans doute',
               "c'est possible", "j'en sais rien moi D:", 'arf, non',
               'non', 'nan', 'euh nan', 'negatif', 'euhh peut-être',
               /^demande à (sunny|NaPs)$/]
    100.times do
      expect(msg("et M3uh ça va ?")).to be_one_of(answers)
    end
  end

  it 'reponds to its name' do
    answers = ['3:-0', 'oui ?', '...', 'lol', 'mdr', ":')",
               'arf', 'shhh', ':)', '3:)', 'tg :k',
               "moi aussi je t'aime", "oui oui sunny"]
    30.times do
      expect(msg("c'est la faute à M3uh")).to be_one_of(answers + [nil])
    end
    expect(msg("M3uhrtrier")).not_to be_one_of(answers)
  end

  it 'responds to "lu"' do
    5.times {
      expect(msg("lu")).to be_one_of(["tin", "stucru", "mière"])
      expect(msg("lut")).not_to be_one_of(["tin", "stucru", "mière"])
    }
  end

  it 'responds to "quoi?"' do
    expect(msg("Quoi ?")).to eq("feur !")
    expect(msg("quoi?")).to eq("feur !")
    expect(msg("à quoi bon ?")).not_to eq("feur !")
  end

  it 'responds to "hein?"' do
    expect(msg("hein?")).to be_one_of(["deux", "deux !!"])
    expect(msg("Hein ?")).to be_one_of(["deux", "deux !!"])
    expect(msg("heing")).not_to be_one_of(["deux", "deux !!"])
  end

  it 'responds to lolz' do
    expect(msg("lOl")).to match(/^(lol|mdr|rofl|ptdr|haha)$/)
    expect(msg("MDR!")).to match(/^(lol|mdr|rofl|ptdr|haha)$/)
    expect(msg("ptdr !!")).to match(/^(lol|mdr|rofl|ptdr|haha)$/)
    expect(msg("mais MDR !")).not_to match(/^(lol|mdr|rofl|ptdr|haha)$/)
  end

  it 'repeats when people change' do
    expect(msg("foo", nickname: "Bob")).not_to eq("foo")
    expect(msg("foo", nickname: "joe")).to eq("foo")
    expect(msg("foo", nickname: "Ace")).not_to eq("foo")
    expect(msg("foo", nickname: "joe")).to eq("foo")
  end

  it 'does not repeat when someone else repeats' do
    expect(msg("foo", nickname: "joe")).not_to eq("foo")
    expect(msg("foo", nickname: "joe")).not_to eq("foo")
    expect(msg("foo", nickname: "joe")).not_to eq("foo")
    expect(msg("foo", nickname: "Bob")).to eq("foo")
  end

  it "talks randomly" do
    answer = nil
    300.times.find { answer = msg("hello") }
    expect(answer).to be_one_of([":)", ":p", "3:)", "lol"])
  end

  # Simplify sending a message with the given message
  def msg(message, options = {})
    defaults = { nickname: nickname, message: message, nicknames: nicknames }
    brain.message(defaults.merge(options)) do |answer|
      return answer
    end
    nil
  end
end
