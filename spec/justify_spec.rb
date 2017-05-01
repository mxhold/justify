require "spec_helper"

describe Justify do
  it "has a version number" do
    expect(Justify::VERSION).not_to be nil
  end

  describe ".split_into_paragraphs" do
    it "splits a string into paragraphs separated by two new lines" do
      string = <<EOF
Here's a paragraph that has a really long line on it that goes on and on and on and on and on and on and on and on.
This is a sentence on another line in the same paragraph.

This is a new paragraph, followed by one empty line.

This is a paragraph, followed by two empty lines.


This is a paragraph, followed by three empty lines.



This is a paragraph, followed by four empty lines.




Last line
EOF

      split_string = Justify.split_into_paragraphs(string)

      expect(split_string).to eql [
        "Here's a paragraph that has a really long line on it that goes on and on and on and on and on and on and on and on.\nThis is a sentence on another line in the same paragraph.\n\n",
         "This is a new paragraph, followed by one empty line.\n\n",
         "This is a paragraph, followed by two empty lines.\n\n\n",
         "This is a paragraph, followed by three empty lines.\n\n\n\n",
         "This is a paragraph, followed by four empty lines.\n\n\n\n\n",
         "Last line\n",
      ]
    end
  end

  describe ".wrap" do
    it "wraps a paragraph to the provided width" do
      paragraph = <<EOF
The Text Justification algorithm will ensure that the output from your program is both left and right justified when displayed in a mono-spaced font  such as Courier. This paragraph is an example of such  justification. All the lines (except the last) of the output from a given run of your program should have the same length, and the last line is to be no longer than the other lines.
EOF

      wrapped_lines = Justify.wrap(paragraph, 40)

      expect(wrapped_lines).to eql [
        "The Text Justification algorithm will",
        "ensure that the output from your program",
        "is both left and right justified when",
        "displayed in a mono-spaced font such as",
        "Courier. This paragraph is an example of",
        "such justification. All the lines",
        "(except the last) of the output from a",
        "given run of your program should have",
        "the same length, and the last line is to",
        "be no longer than the other lines.\n",
      ]
    end

    it "doesn't count newlines towards a line's length" do
      expect(Justify.wrap("one\ntwo\n\n\n", 3)).to eq [
        "one\n",
        "two\n\n\n",
      ]
    end

    it "raises an ArgumentError if it's impossible to wrap to the provided length"
  end

  describe ".split_into_words" do
    it "splits a string into words" do
      expect(Justify.split_into_words("one two\nthree\nfour\n\n\nfive")).to eq [
        "one",
        "two\n",
        "three\n",
        "four\n\n\n",
        "five",
      ]
    end

    it "compacts extra spaces between words" do
      expect(Justify.split_into_words("one     two")).to eq ["one", "two"]
    end
  end

  describe ".justify" do
    it "justifies the text to the provided width" do
      paragraph = <<EOF
The Text Justification algorithm will ensure that the output from your program is both left and right justified when displayed in a mono-spaced font  such as Courier. This paragraph is an example of such  justification. All the lines (except the last) of the output from a given run of your program should have the same length, and the last line is to be no longer than the other lines.
EOF

      justified_lines = Justify.justify(paragraph, 30)

      expect(justified_lines).to eql <<EOF
The Text Justification
algorithm will ensure that the
output from your program is
both left and right justified
when displayed in a
mono-spaced font such as
Courier. This paragraph is an
example of such justification.
All the lines (except the
last) of the output from a
given run of your program
should have the same length,
and the last line is to be no
longer than the other lines.
EOF
    end
  end
end
