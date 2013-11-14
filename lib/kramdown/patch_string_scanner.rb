# -*- coding: utf-8 -*-

# This patch adds line number information for current scan position to
# StringScanner. It also adds line_number_offset for nested StringScanners.
require 'strscan'
class StringScanner

  # Use :line_number_offset to handle nested StringScanners that scan a sub-string
  # of the source document. Kramdown uses this e.g., for span level parsers.
  attr_accessor :line_number_offset

  # To make this unicode (multibyte) aware, we have to use charpos which was
  # added in Ruby version 2.0.0.
  # This method will work with older versions of Ruby, however it will report
  # incorrect line numbers if the scanned string contains multibyte characters.
  if instance_methods.include?(:charpos)
    def best_pos
      charpos
    end
  else
    def best_pos
      pos
    end
  end

  # Returns the line number for current charpos.
  # NOTE: Requires that all line endings are normalized to '\n'
  def current_line_number
    string[0..best_pos].count("\n") + (line_number_offset || 1)
  end

end
