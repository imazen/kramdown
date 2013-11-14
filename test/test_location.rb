# -*- coding: utf-8 -*-

require 'minitest/autorun'
require 'kramdown'

Encoding.default_external = 'utf-8' if RUBY_VERSION >= '1.9'

describe 'location' do

  # checks that +element+'s :location option corresponds to the location stored
  # in the element.attr['class']
  def check_element_for_location(element)
    if (match = /^line-(\d+)/.match(element.attr['class'] || ''))
      expected_line = match[1].to_i
      element.options[:location].must_equal(expected_line)
    end
    element.children.each do |child|
      check_element_for_location(child)
    end
  end

  test_cases = {
    'Blockquotes' => %(
> block quote1
>
> * {:.line-3} list item in block quote
> * {:.line-4} list item in block quote
> {:.line-3}
{:.line-1}

> block quote2
> {:.line-8}
    ),
    'Code blocks' => %(
a para

~~~~
test code 1
~~~~
{:.line-3}

    test code 2
{:.line-8}
    ),
    'Headers' => %(
# header1
{:.line-1}

## header2
{:.line-4}

## header3
{:.line-7}

header4
=======
{:.line-10}

header5
-------
{:.line-14}
    ),
    'Horizontal rules' => %(
a para

----
{:.line-3}
    ),
# TODO: implement location info for HTML parser
#     'HTML Blocks' => %(
# a para
#
# <div>some text</div>
# {:.line-3}
#     ),
    'Lists' => %(
* {:.line-1} list item
* {:.line-2} list item
* {:.line-3} list item
{:.line-1}

{:.line-7}
1. {:.line-7} list item
2. {:.line-8} list item
3. {:.line-9} list item

{:.line-12}
definition term 1
: {:.line-13} definition definition 1
definition term 2
: {:.line-15} definition definition 2
    ),
    'Math blocks' => %(
a para

$$5+5$$
{:.line-3}
    ),
    'Paragraphs' => %(
para1
{:.line-1}

para2
{:.line-4}

Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,
quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo
consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse
{:.line-7}

{:.line-14}
para with leading IAL
    ),
    'Spans' => %(
para *span*{:.line-1}
{:.line-1}

## header *span*{:.line-4}
{:.line-4}

Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,
quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo
consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse
cillum *short span on single line*{:.line-11}
dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non
*long span over multiple lines - proident, sunt in culpa qui officia deserunt
mollit anim id est laborum.*{:.line-13}
Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,
quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo
`code span`{:.line-18}
Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,
quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo
{:.line-7}
    ),
    'Tables' => %(
a para

|first|second|third|
|-----|------|-----|
|a    |b     |c    |
{:.line-3}
    )
  }
  test_cases.each do |name, test_string|
    it "Handles #{ name }" do
      doc = Kramdown::Document.new(test_string.strip)
      check_element_for_location(doc.root)
    end
  end

end
