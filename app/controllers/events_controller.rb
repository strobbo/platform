#encoding: utf-8

class EventsController < ApplicationController
	before_filter :authenticate_user!
	load_and_authorize_resource

  # GET /events
  # GET /events.json
  def index
    if params[:name]
      @city = City.find_by_id(params[:name][:city_id])
    end
		
		# padrão de ordenação da página inicial
		params[:order] ||= 'followeds'
		@order = params[:order]

		if @order == 'date'
			if @city
				@events = @city.events.order('date ASC')
			else
				@events = Event.order('date ASC')
			end			
		elsif @order == 'followers'
			if @city
				@events = @city.events.sort {|a,b| b.number_of_followers(current_user) <=> a.number_of_followers(current_user)}
			else
				@events = Event.all.sort {|a,b| b.number_of_followers(current_user) <=> a.number_of_followers(current_user)}
			end
		else
			@order = 'followeds' # tratamento para garantir que qualquer requisição terá um valor válido para o @order
			if @city
				@events = @city.events.sort {|a,b| b.number_of_followeds(current_user) <=> a.number_of_followeds(current_user)}
			else
				@events = Event.all.sort {|a,b| b.number_of_followeds(current_user) <=> a.number_of_followeds(current_user)}
			end
		end

    @cities = City.find(:all, :order => "name")

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @events }
    end
  end

  # GET /events/1
  # GET /events/1.json
  def show
    @event = Event.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @event }
    end
  end

  # GET /events/new
  # GET /events/new.json
  def new
    @event = Event.new
    @cities = City.find(:all, :order => "name")

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @event }
    end
  end

  # GET /events/1/edit
  def edit
    @event = Event.find(params[:id])
    @cities = City.find(:all, :order => "name")
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(params[:event])
    @event.user = current_user

    respond_to do |format|
      if @event.save
				@event.create_activity :create, :owner => current_user
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render json: @event, status: :created, location: @event }
      else
        format.html { render action: "new" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /events/1
  # PUT /events/1.json
  def update
    @event = Event.find(params[:id])

    respond_to do |format|
      if @event.update_attributes(params[:event])
				@event.create_activity :update, :owner => current_user
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event = Event.find(params[:id])
    @event.destroy

    respond_to do |format|
      format.html { redirect_to events_url }
      format.json { head :no_content }
    end
  end

  def participants
		@title = "Participantes"
    @event = Event.find(params[:id])
    #render 'events/show_follow'
  end
end
