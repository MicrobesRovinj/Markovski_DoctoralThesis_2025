--[[

This Lua filter translates citations from English to Croatian.
The translations occur only in the section named "Prošireni sažetak 
(extended abstract)" with the identifier "prosireni-sazetak-extended-abstract".
As part of the translation, this Lua filter removes the comma before "i sur." 
in the same section. When citing in Croatian, the comma before "i sur." must be 
removed.

--]]

-- Function to translate specific citations terms from English to Croatian
local function translate_citations_to_hr(item, i)
  -- Translate "et" to "i"
  if item[i].t == "Str" and
  item[i].text == "et" then
    item[i].text = "i"
  -- Translate "al." to "sur."
  elseif item[i].t == "Str" and
  item[i].text == "al." then
    item[i].text = "sur."
  -- Translate "al.," to "sur.,"
  elseif item[i].t == "Str" and
  item[i].text == "al.," then
    item[i].text = "sur.,"
  -- Translate "and" to "i"
  elseif item[i].t == "Str" and
  item[i].text == "and" then
    item[i].text = "i"
  -- Translate "&" to "i"
  elseif item[i].t == "Str" and
  item[i].text == "&" then
    item[i].text = "i"
  -- Remove the comma before "et al." or "et al.,"
  elseif item[i].t == "Str" and
  item[i].text:sub(-1) == "," and
  item[i+2].text == "et" and
  (item[i+4].text == "al." or
  item[i+4].text == "al.,") then
    -- Remove the comma
    item[i].text = item[i].text:sub(1, -2)
  end
end

-- Translate citations from English to Croatian in the section "Prošireni
-- sažetak (extended abstract)"
function Blocks(blocks)
  
  -- Flag to track whether we are currently in the specified section
  local in_section = false
  
  -- Iterate through each block in the blocks table
  for i, block in ipairs(blocks) do
    -- Check if we are in the specified section for translation
    if block.identifier == "prosireni-sazetak-extended-abstract" then
      -- Set the flag to true if we are in the section
      in_section = true
    -- Reset the flag if we leave the section
    elseif block.t == "RawBlock" and block.text:match("\\tableofcontents") then
      in_section = false
    end
    
    -- If we are in the specified section and the block is a paragraph
    if block.t == "Para" and in_section then
      -- Iterate through each item in the content of the paragraph block
      for i, item in ipairs(block.content) do
        -- Check if the item is a citation with a normal citation mode
        if item.t == "Cite" and item.citations[1].mode == "NormalCitation" then
          -- Iterate through each content item within the citation
          for i, item in ipairs(item.content) do
            -- Check if the content item is a link
            if item.t == "Link" then
              -- Iterate through each content item within the link
              for i = 1, #item.content, 1 do
                -- Call the function to translate the citation terms
                translate_citations_to_hr(item.content, i)
              end
            end
          end
        -- Check if the item is a citation with an author-in-text citation mode
        elseif item.t == "Cite" and item.citations[1].mode == "AuthorInText" then
          -- Iterate through each content item within the citation
          for i = 1, #item.content, 1 do
            -- Call the function to translate the citation terms
            translate_citations_to_hr(item.content, i)
          end
        end
      end
    end
    
  end
  
  -- Return the modified blocks table after modification
  return blocks

end
