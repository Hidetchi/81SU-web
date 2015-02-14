class Api::PlayersController < ApplicationController
  include AuthenticatedSystem
  before_filter :activeresource_auth, :only => [:update,:destroy]

  # GET /api_players
  # GET /api_players.xml
  def index
    puts params.inspect
    @api_players = Player.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @api_players }
    end
  end

  # GET /api_players/1
  # GET /api_players/1.xml
  def show
    @player = Player.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @player.to_xml(:include => :titles) }
    end
  end

  # GET /api_players/new
  # GET /api_players/new.xml
  def new
    @player = Player.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @player }
    end
  end

  # GET /api_players/1/edit
  def edit
    @player = Player.find(params[:id])
  end

  # POST /api_players
  # POST /api_players.xml
  def create
    @player = Player.new(params[:player])

    respond_to do |format|
      if @player.save
        flash[:notice] = 'Api::Player was successfully created.'
        format.html { redirect_to(@player) }
        format.xml  { render :xml => @player, :status => :created, :location => @player }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @player.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /api_players/1
  # PUT /api_players/1.xml
  def update
    @player = Player.find(params[:id])

    respond_to do |format|
      params[:player].delete('country')
      params[:player].delete('auth_token')
      if @player.update_attributes(params[:player])
        flash[:notice] = 'Api::Player was successfully updated.'
        format.html { redirect_to(@player) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @player.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /api_players/1
  # DELETE /api_players/1.xml
  def destroy
    @player = Player.find(params[:id])
    @player.destroy

    respond_to do |format|
      format.html { redirect_to(api_players_url) }
      format.xml  { head :ok }
    end
  end

  def with_login
    @player = Player.find_by_login(params[:login])

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @player.to_xml(:include => :country) }
    end

  end
  
  def search
    @api_players = Array.new
    Player.all.each { |p|
      if (p.login.include?(params[:name])) then
        @api_players.push(p)
      end
      break if @api_players.size > 100
    }
    respond_to do |format|
      format.xml
    end
  end
  
  def detail
    @player = Player.find(:first, :conditions => ['login = ?',params[:name]])
    @player = Array.new if (!@player)

    respond_to do |format|
      format.xml  { render :xml => @player.to_xml(:only => [
        :avatar_image_url, :country_id, :created_at, :draws34, :exp34, :login, :wins10, :losses10, :exp10, :wins55, :losses55, :exp55,
        :losses, :losses34, :max_rate, :name, :pr, :rate, :streak, :streak_best, :wins56, :losses56, :exp56, :wins_ky, :losses_ky, :exp_ky,
        :updated_at, :wins, :wins34, :city_name, :city_lat, :city_lon, :mileage_total, :mileage_period]) }
    end
  end
  
  def blogparts
    @player = Player.find(:first, :conditions => ['login = ?',params[:name].downcase])
    @player = Array.new if (!@player)

    respond_to do |format|
      format.xml  { render :xml => @player.to_xml(:only => [
        :rate, :wins, :losses, :style_id]) }
    end
  end

  def setStyleId
    @player = Player.find(:first, :conditions => ['login = ?',params[:name]])
    @player.update_attribute(:style_id, params[:styleId]) if (@player)
    render :nothing => true
  end

  def ranking
    if (params[:country_id] == "*")
      conditions = 'players.updated_at >= ? and (players.wins + players.losses) >= ? and players.show_ranking = ?'
      @api_players = Player.find(:all,
                         :conditions => [conditions, DateTime.now - 90 , 30, true])
    else
      conditions = 'players.updated_at >= ? and (players.wins + players.losses) >= ? and players.show_ranking = ? and players.country_id = ?'
      @api_players = Player.find(:all,
                         :conditions => [conditions, DateTime.now - 90 , 30, true, params[:country_id]])
    end
    case params[:item]
    when "rate"
      @api_players = @api_players.sort_by { |v| - ( v.wins + v.losses ) }
      @api_players = @api_players.sort_by { |v| - v.rate }
    when "wins"
      @api_players = @api_players.sort_by { |v| - v.rate }
      @api_players = @api_players.sort_by { |v| v.losses }
      @api_players = @api_players.sort_by { |v| - v.wins }
    when "total"
      @api_players = @api_players.sort_by { |v| - v.rate }
      @api_players = @api_players.sort_by { |v| v.losses }
      @api_players = @api_players.sort_by { |v| - ( v.wins + v.losses ) }
    when "percentage"
      @api_players = @api_players.sort_by { |v| - v.rate }
      @api_players = @api_players.sort_by { |v| - ( v.wins + v.losses ) }
      @api_players = @api_players.sort_by { |v| - ( v.wins.to_f / [1, v.wins + v.losses].max ) }
    when "streak"
      @api_players = @api_players.sort_by { |v| - v.rate }
      @api_players = @api_players.sort_by { |v| - v.streak_best }
    when /^exp(.+)$/
      @api_players = @api_players.sort_by { |v| - v["wins"+$1] }
      @api_players = @api_players.sort_by { |v| - v["exp"+$1] }
    else
      @api_players = Array.new
    end

    respond_to do |format|
      format.xml
    end
  end

  def ranking34
    if (params[:country_id] == "*")
      conditions = 'players.updated_at >= ? and players.exp34 >= ? and players.show_ranking = ?'
      @api_players = Player.find(:all,
                         :conditions => [conditions, DateTime.now - 90 , 20, true])
    else
      conditions = 'players.updated_at >= ? and players.exp34 >= ? and players.show_ranking = ? and players.country_id = ?'
      @api_players = Player.find(:all,
                         :conditions => [conditions, DateTime.now - 90 , 20, true, params[:country_id]])
    end
    case params[:item]
    when "exp"
      @api_players = @api_players.sort_by { |v| - v.wins34 }
      @api_players = @api_players.sort_by { |v| - v.exp34 }
    when "wins"
      @api_players = @api_players.sort_by { |v| v.losses34 }
      @api_players = @api_players.sort_by { |v| - v.wins34 }
    when "total"
      @api_players = @api_players.sort_by { |v| - v.exp34 }
      @api_players = @api_players.sort_by { |v| - ( v.wins34 + v.losses34 + v.draws34 ) }
    when "percentage"
      @api_players = @api_players.sort_by { |v| - v.exp34 }
      @api_players = @api_players.sort_by { |v| - ( v.wins34.to_f / [1, v.wins34 + v.losses34 + v.draws34].max ) }
    else
      @api_players = Array.new
    end

    respond_to do |format|
      format.xml
    end
  end

  def activate
    I18n.locale = params[:locale]
    @player = Player.find(:first, :conditions => ['login = ?',params[:code1]])
    if (!@player || @player.salt[20,20] != params[:code2])
      render "activate_error"
    else
      if (@player.auth_token == 'activated') then
        @already = true
      else
	@already = false
        @player.update_attribute(:auth_token, 'activated')
      end
    end
  end

  def reset_pass
    @player = Player.find(:first, :conditions => ['login = ?',params[:code1]])
    if (!@player)
      @result = "error"
    elsif (@player.email == params[:code2].to_s)
      Notification.deliver_reset_pass_url(@player, request.remote_ip)
      @result = "success1"
    elsif (@player.salt[20,20] == params[:code2].to_s)
      newpass = (("a".."z").to_a + ("A".."Z").to_a + (0..9).to_a).shuffle[0..7].join
      @player.update_attribute(:password, newpass)
      Notification.deliver_reset_pass_done(@player, request.remote_ip, newpass)
      @result = "success2"
    else
      @result = "error"
    end
  end

  def authenticate
    logout_keeping_session!
    if @player = Player.authenticate(params[:login], params[:password])
      render :xml => @player.to_xml(:include => [:country,:titles]), :layout => false
    else
      render :nothing => true, :status => :unprocessable_entity
    end
  end

  private
  def activeresource_auth
    player = Player.find(params[:id])
    unless player.activeresource_auth(params[:player][:auth_token])
      render :nothing => true, :status => :unauthorized
      return
    end
  end

end
