xml.kifus do
  for k in @kifus
    next unless (k && k.contents)
    xml.kifu do
      xml.result(k.result)
      xml.black_id(k.whiteid)
      xml.black_name(k.black.login)
      xml.white_id(k.blackid)
      xml.white_name(k.white.login)
      xml.created_at(k.created_at)
    end
  end
end
