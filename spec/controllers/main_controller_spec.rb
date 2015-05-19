require "rails_helper"

describe MainController do

  describe "test index" do
    it "loads the index page" do
      get :index
      expect(response).to render_template("index")
    end
  end
end
