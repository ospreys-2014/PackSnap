require 'rails_helper'
require 'date'

describe ItinerariesController do
  describe "itineraries Get routes" do
    before do
      @itinerary = create(:itinerary)
      @trip = @itinerary.trip
    end
    describe "Get#show" do
      it "should locate the requested itinerary" do
        get :show, trip_id: @trip, id: @itinerary
        expect(assigns[:itinerary]).to eq(@itinerary)
      end
      it "should render :show template for itineraries" do
        get :show, trip_id: @trip, id: @itinerary
        expect(response).to render_template(:show)
      end
    end

    describe "Get#index" do
      it "should locate all itineraries" do
        get :index, trip_id: @trip
        expect(assigns[:itineraries]).to match_array([@itinerary])
      end
      it "should render :index template for itineraries" do
        get :index, trip_id: @trip
        expect(response).to render_template(:index)
      end
    end

    describe "Get#new" do
      it "should assign a new itinerary" do
        get :new, trip_id: @trip
        expect(assigns[:itinerary]).to be_a_new(Itinerary)
      end
      it "should render :new template for itineraries" do
        get :new, trip_id: @trip
        expect(response).to render_template(partial: 'itineraries/_form_itinerary')
      end
    end

    describe "Get#edit" do
      it "should locate the requested itinerary" do
        get :edit, trip_id: @trip, id: @itinerary
        expect(assigns[:itinerary]).to eq(@itinerary)
      end
      it "should render :edit template for itineraries" do
        get :edit, trip_id: @trip, id: @itinerary
        expect(response).to render_template(:edit)
      end
    end
  end

  describe "Post#create" do
    before do
      @trip = create(:trip)
    end
    context 'with valid attributes' do
      it "should save valid itinerary to database" do
        expect { post :create, trip_id: @trip, itinerary: attributes_for(:itinerary) }.to change(Itinerary, :count).by(1)
      end
      it "should redirect to location :new" do
        post :create, trip_id: @trip, itinerary: attributes_for(:itinerary)
        expect(response.status).to eq(200)
      end
    end
    context 'with invalid attributes' do
      it "should not save into the database" do
        expect { post :create, trip_id: @trip, itinerary: attributes_for(:invalid_itinerary) }.to_not change(Itinerary, :count)
      end
      it "should set flash[:alert]" do
        post :create, trip_id: @trip, itinerary: attributes_for(:invalid_itinerary)
        expect(response.request.flash[:alert]).to_not be_nil
      end
      it "should re-render :new template" do
        post :create, trip_id: @trip, itinerary: attributes_for(:invalid_itinerary)
        expect(response).to render_template(:new)
      end
    end
  end

  describe "Put#update" do
    before do
      @itinerary = create(:itinerary)
      @trip = @itinerary.trip
    end
    context 'with valid attributes' do
      it "should locate the requested itinerary" do
        put :update, trip_id: @trip, id: @itinerary, itinerary: attributes_for(:itinerary)
        expect(assigns[:itinerary]).to eq(@itinerary)
      end
      it "should update attributes" do
        date = Date.new(2014,11,27)
        put :update, trip_id: @trip, id: @itinerary, itinerary: attributes_for(:itinerary, end_date: date)
        @itinerary.reload
        expect(@itinerary.end_date).to eq(date)
      end
      it "should redirect to itinerary :show" do
        put :update, trip_id: @trip, id: @itinerary, itinerary: attributes_for(:itinerary)
        expect(response).to redirect_to(trip_itineraries_path(@trip))
      end
    end
    context 'with invalid attributes' do
      it "should not save into the database" do
        put :update, trip_id: @trip, id: @itinerary, itinerary: attributes_for(:invalid_itinerary)
        @itinerary.reload
        expect(@itinerary.start_date).to_not be_nil
      end
      it "should set flash[:alert]" do
        put :update, trip_id: @trip, id: @itinerary, itinerary: attributes_for(:invalid_itinerary)
        expect(response.request.flash[:alert]).to_not be_nil
      end
      it "should re-render :edit template" do
        put :update, trip_id: @trip, id: @itinerary, itinerary: attributes_for(:invalid_itinerary)
        expect(response).to render_template(:edit)
      end
    end
  end

  describe "Delete#destroy" do
    before :each do
      @itinerary = create(:itinerary)
      @trip = @itinerary.trip
    end
    it "should locate the requested itinerary" do
      delete :destroy, trip_id: @trip, id: @itinerary
      expect(assigns[:itinerary]).to eq(@itinerary)
    end
    it "should delete record from database" do
      expect { delete :destroy, trip_id: @trip, id: @itinerary }.to change(Itinerary, :count).by(-1)
    end
    it "should redirect to :index" do
      delete :destroy, trip_id: @itinerary.trip, id: @itinerary
      expect(response).to redirect_to(trip_itineraries_path(@trip))
    end
  end

end