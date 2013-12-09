xml.kifus do
  for k in @kifus
    next unless (k && k.contents)
    lines = k.contents.split("\n")
    xml.kifu do
      xml.id(k.id)
      xml.game_id(lines[4])
      xml.result(lines[lines.size-2])
    end
  end
end
