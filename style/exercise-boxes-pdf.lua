-- PDF counterpart of style/exercise-boxes.css: numbers .exercise divs and
-- turns .answer divs into blank boxes sized for handwriting.
-- Only referenced from format.pdf.filters, so HTML renders never load it.
-- Box height comes from the div's HTML min-height (in em, ~0.42cm each), default 4.5cm.
function Div(el)
  if el.classes:includes("exercise") then
    local out = pandoc.List({
      pandoc.RawBlock("latex",
        "\\par\\Needspace{6\\baselineskip}\\refstepcounter{exn}" ..
        "\\noindent{\\color{cofipurple}\\textbf{EXERCISE \\theexn}}\\par\\nopagebreak")
    })
    out:extend(el.content)
    return out
  elseif el.classes:includes("answer") then
    local h = "4.5cm"
    local em = (el.attributes["style"] or ""):match("min%-height:%s*([%d%.]+)em")
    if em then h = string.format("%.1fcm", tonumber(em) * 0.42) end
    return pandoc.RawBlock("latex",
      "\\par\\nopagebreak[4]\\noindent\\fbox{\\parbox[c][" .. h ..
      "][t]{\\dimexpr\\linewidth-2\\fboxsep-2\\fboxrule\\relax}" ..
      "{\\textcolor{gray}{\\footnotesize\\textsc{Your answer}}}}\\par\\medskip")
  end
end
