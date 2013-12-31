class Api::KifusController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => [:search_tournament]

  # GET /kifus
  # GET /kifus.xml
  def index
    @kifus = Kifu.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @kifus }
    end
  end

  # GET /kifus/1
  # GET /kifus/1.xml
  def show
    unless (request.referer && request.referer.match(/81dojo\.com/))
      render :nothing => true
      return
    end
    @kifu = Kifu.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @kifu }
    end
  end

  # GET /kifus/new
  # GET /kifus/new.xml
  def new
    @kifu = Kifu.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @kifu }
    end
  end

  # GET /kifus/1/edit
  def edit
    @kifu = Kifu.find(params[:id])
  end

  # POST /kifus
  # POST /kifus.xml
  def create
    @kifu = Kifu.new(params[:kifu])

    respond_to do |format|
      if @kifu.save
        flash[:notice] = 'Kifu was successfully created.'
        format.html { redirect_to(@kifu) }
        format.xml  { render :xml => @kifu, :status => :created }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @kifu.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /kifus/1
  # PUT /kifus/1.xml
  def update
    @kifu = Kifu.find(params[:id])

    respond_to do |format|
      if @kifu.update_attributes(params[:kifu])
        flash[:notice] = 'Kifu was successfully updated.'
        format.html { redirect_to(@kifu) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @kifu.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /kifus/1
  # DELETE /kifus/1.xml
  def destroy
    @kifu = Kifu.find(params[:id])
    @kifu.destroy

    respond_to do |format|
      format.html { redirect_to(kifus_url) }
      format.xml  { head :ok }
    end
  end
  
  def search
    unless (request.referer && request.referer.match(/81dojo\.com/))
      render :nothing => true
      return
    end
    @kifus = Array.new
    if (params[:opponent_name] == "*")
      @player = Player.find(:first, :conditions => ['login = ?',params[:player_name]])
      if (@player)
      	conditions = 'created_at >= ? and created_at <= ? and (blackid = ? or whiteid = ?)'
      	@kifus = Kifu.find(:all,
                           :conditions => [conditions,params[:begin_date],params[:end_date],@player.id,@player.id],
                           :limit => 101)
      end
    else
      @player = Player.find(:first, :conditions => ['login = ?',params[:player_name]])
      @opponent = Player.find(:first, :conditions => ['login = ?',params[:opponent_name]])
      if (@player && @opponent)
      	conditions = 'created_at >= ? and created_at <= ? and ((blackid = ? and whiteid = ?) or (blackid = ? and whiteid = ?))'
      	@kifus = Kifu.find(:all,
                           :conditions => [conditions,params[:begin_date],params[:end_date],@player.id,@opponent.id,@opponent.id,@player.id],
                           :limit => 101)
      end
    end

    respond_to do |format|
      format.xml
    end
  end

  def search_tournament
    raise "invalid params." unless params[:tournament_name].present? && params[:begin_date].present? && params[:end_date].present?

    @kifus = Kifu.find(:all,:include => [:white,:black],:order => "created_at asc",:conditions => ["tournament_name = ? AND created_at >= ? AND created_at <= ?",params[:tournament_name],params[:begin_date],params[:end_date]])

    respond_to do |format|
      format.xml 
    end
  end
  
end
