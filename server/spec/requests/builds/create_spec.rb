RSpec.describe "Create Builds", :type => :request do
  it "creates a Widget and redirects to the Widget's page" do
    post "/builds", params: { total_files: ['felan_spec.rb'] }

    expect(response).to have_http_status(:no_content)
  end
end
