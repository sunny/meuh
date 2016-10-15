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

  let(:random_answers) { [":)", ":p", "lol"] }

  it 'has a botname' do
    expect(brain.botname).to eq("M3uh")
  end

  it 'can change its botname' do
    brain.botname = "bar"
    expect(brain.botname).to eq("bar")
  end

  it 'never responds to !commands' do
    200.times { expect(msg(%w(!foo !bar? !#{botname}).sample)).to eq(nil) }
  end

  it 'responds to "ping"' do
    expect(msg("ping")).to eq("pong")
    expect(msg("pingu")).not_to eq("pong")
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

  it 'answers A or B questions' do
    answers = ["vert", "bleu", "les deux"]
    5.times do
      expect(msg("M3uh vert ou bleu ?"))
        .to be_one_of(["vert", "bleu", "les deux"])
    end
  end

  it 'reponds to questions addressed to its name' do
    answers = ['ouais', 'euh ouais', 'vi', 'affirmatif', 'sans doute',
               "c'est possible", "j'en sais rien moi D:", 'arf, non',
               'non', 'nan', 'euh nan', 'negatif', 'euhh peut-être',
               /^demande à (sunny|NaPs)$/]
    100.times do
      expect(msg("et M3uh ça va ?")).to be_one_of(answers)
      expect(msg("et @M3uh ça va ?")).to be_one_of(answers)
    end
  end

  it 'reponds to its name' do
    answers = ['3:-0', 'oui ?', '...', 'lol', 'mdr', ":')",
               'arf', 'shhh', ':)', '3:)', 'tg :k',
               "moi aussi je t'aime", "oui oui sunny"]
    30.times do
      expect(msg("c'est la faute à M3uh")).to be_one_of(answers + [nil])
      expect(msg("c'est la faute à @M3uh")).to be_one_of(answers + [nil])
    end
    expect(msg("M3uhrtrier")).not_to be_one_of(answers - random_answers)
    expect(msg("@M3uhrtrier")).not_to be_one_of(answers)
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

  it "talks randomly" do
    answer = nil
    300.times.find { answer = msg("hello") }
    expect(answer).to be_one_of(random_answers)
  end

  context 'without the random chat plugin' do
    before do
      allow_any_instance_of(Meuh::Plugins::RandomChat).to receive(:answer)
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

    it 'does not replace s/// if there is no previous message' do
      expect(msg("s/A//")).to eq(nil)
    end

    context "with a s/// message and a previous message" do
      before { msg("Je t'aime") }

      it 'does not respond if the text does not match' do
        expect(msg("s/foo//")).to eq(nil)
      end

      it 'removes some of the previous text' do
        expect(msg("s/me//")).to eq("Je t'ai")
      end

      it 'replaces some of the previous text' do
        expect(msg("s/me/meuh/")).to eq("Je t'aimeuh")
      end

      it 'replaces previous text with a regexp' do
        expect(msg('s/me$/meuh/')).to eq("Je t'aimeuh")
      end

      it 'does not respond if no replacement is made' do
        expect(msg("s/aim./aime/")).to eq(nil)
      end

      it 'replaces previous text with a complex regexp' do
        msg("Je t/aime")
        expect(msg('s/[^a-z]|(m)|\//-/')).to eq("-e-t-ai-e")
      end

      it 'replaces previous text with a regexp with groups' do
        expect(msg('s/ai(me)/\0\1/')).to eq("Je t'aimeme")
      end

      it 'responds with an all-including plus regexp' do
        expect(msg('s/.+/foo/')).to eq("foo")
      end

      it 'replaces the whole text with s/^.*$/bar/' do
        expect(msg('s/^.*$/bar/')).to eq("bar")
      end

      it 'responds nothing for impossible regular expressions' do
        # Raises a RegexpError "too short escape sequence"
        expect(msg('s/\/-/')).to eq(nil)
      end

      it 'is case sensitive' do
        expect(msg("s/ME/MEUH/")).to eq(nil)
      end

      it 'accepts a case insensitive flag' do
        expect(msg("s/ME/MEUH/i")).to eq("Je t'aiMEUH")
      end

      it 'remembers previous s///' do
        expect(msg("s/me/meuh/")).to eq("Je t'aimeuh")
        expect(msg("s/meuh/me!!/")).to eq("Je t'aime!!")
      end

      it 'remembers other commands' do
        expect(msg("où est ma tête ?")).to eq("dtc")
        expect(msg("s/dtc/dans ton cul/")).to eq("dans ton cul")
      end
    end
  end

  # Simplify sending a message with the given message
  def msg(message, options = {})
    defaults = { nickname: nickname, message: message, nicknames: nicknames }
    bot_answer = nil
    brain.message(defaults.merge(options)) do |answer|
      bot_answer = answer
    end
    bot_answer
  end
end
