--[[

This Lua filter abbreviates certain Croatian given names to two symbols
(letters). In Croatian, "Dž", "Lj", and "Nj" are regarded as single letters.
If a Croatian given name starts with these letters, it is abbreviated to two
symbols (letters). This abbreviation is applied only to the list of references
within a Div element with the "refs" identifier.

--]]

-- Define a table to hold the function that abbreviates the given name
local abbreviate_given_name = {
  -- Function to process paragraph elements
  Para = function(el)
    -- Check if the element type is "Para"
    if el.t == "Para" then
      -- Iterate over each element in the content of the paragraph
      for k,_ in ipairs(el.content) do
        -- Check if the current element is a string "Iveša," followed by a space and then "L."
        if el.content[k].t == "Str" and el.content[k].text == "Iveša,"
        and el.content[k+1].t == "Space"
        and el.content[k+2].t == "Str" and el.content[k+2].text == "L." then
          -- Change abbreviation "L." to "Lj."
          el.content[k+2].text = "Lj."
        -- Check if the current element is a string "Iveša," followed by a space and then "L.,"
        elseif el.content[k].t == "Str" and el.content[k].text == "Iveša,"
        and el.content[k+1].t == "Space"
        and el.content[k+2].t == "Str" and el.content[k+2].text == "L.," then
          -- Change abbreviattion "L.," to "Lj.,"
          el.content[k+2].text = "Lj.,"
        end
      end
    end
    -- Return the modified element
    return el
  end
}

-- Function to process Div elements
function Div (div)
  -- Check if the Div element has the identifier "refs"
  if div.identifier == "refs" then
    -- Walk through the block elements of the Div and apply the abbreviate_given_name function
    return pandoc.walk_block(div, abbreviate_given_name)
  end
  -- Return nil if the Div element does not have the identifier "refs"
  return nil
end
