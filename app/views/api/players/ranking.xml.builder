xml.ranking(:item => params[:item]) do
  nowDate = Date.strptime(DateTime.now.utc.strftime("%Y-%m-%d"))
  i = 0
  for p in @api_players
    next if (p.wins + p.losses < 30 || nowDate - Date.strptime(p.updated_at.strftime("%Y-%m-%d")) >= 180)
    xml.player do
      xml.login(p.login)
      xml.country_id(p.country_id)
      xml.rate(p.rate)
      xml.wins(p.wins)
      xml.losses(p.losses)
      xml.streak(p.streak)
      xml.streak_best(p.streak_best)
      xml.created_at(p.created_at)
      xml.updated_at(p.updated_at)
    end
    i += 1
    break if i >= 100
  end
end