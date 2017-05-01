require "justify/version"

module Justify
  module NonwrappingArrayAt
    refine Array do
      def nonwrapping_at(index)
        if index >= 0 && index <= (length - 1)
          at(index)
        end
      end
    end
  end

  using NonwrappingArrayAt

  def self.split_into_paragraphs(string)
    paragraphs = []
    paragraph = ""

    chars = string.chars

    chars.each_with_index do |char, i|
      prev = chars.nonwrapping_at(i - 1)
      peek = chars.nonwrapping_at(i + 1)

      if peek.nil?
        paragraph << char
        paragraphs << paragraph
      elsif prev == "\n" && char == "\n" && peek != "\n"
        paragraph << char
        paragraphs << paragraph
        paragraph = ""
      elsif !char.nil?
        paragraph << char
      end
    end

    paragraphs
  end

  def self.split_into_words(string)
    string.split(/([^\s]*\s+)/).reject(&:empty?).map { |w| w.gsub(" ", "") }
  end

  def self.wrap(paragraph, width)
    words = split_into_words(paragraph)

    return [] if words.none?

#     longest_word = words.max_by(&:length)
#
#     if longest_word.length > width
#       error_message = <<EOF
# Error! Bad width.
#
# You specified a width of #{width} characters,
# but input contained the word "#{longest_word}"
# which has a length of #{longest_word.length}.
#
# You must specify a width of at least #{longest_word.length}.
# EOF
#       raise ArgumentError.new(error_message)
#     end

    lines = []
    line = nil

    words.each do |word|
      possible_line = [line, word].compact.join(" ")
      if possible_line.length <= width
        line = possible_line
      else
        lines << line
        line = word
      end
    end

    lines << line

    lines.compact
  end

  def self.justify(text, width)
    paragraphs = split_into_paragraphs(text)

    wrapped_paragraphs = paragraphs.map do |paragraph|
      wrap(paragraph, width)
    end

    justified_paragraphs = wrapped_paragraphs.map do |lines|
      justify_paragraph(lines, width)
    end

    justified_paragraphs.join
  end

  def self.justify_line(line, width)
    line = line.dup

    while line.length < width
      words = line.split(/ /)
      indexes = (0..(words.length - 2)).to_a
      return line if indexes.none?
      spaces_to_add = width - line.length
      indexes_of_words_to_space = indexes.shuffle.take(spaces_to_add)

      line = words.map.with_index do |word, index|
        if indexes_of_words_to_space.include?(index)
          "#{word} "
        else
          word
        end
      end.join(" ")
    end

    line
  end

  def self.justify_paragraph(lines, width)
    if lines.length > 0
      last_line = lines.pop
      justified_lines = lines.map { |line| justify(line, width) }

      [
        justified_lines,
        last_line
      ].compact.reject(&:empty?).join("\n")
    else
      lines.first
    end
  end
end
