RSpec.describe "POST /builds", :type => :request do
  it "creates a build" do
    post "/builds", params: { total_files: ['felan_spec.rb'], ci: 'travis', build_number: '1' }

    expect(response).to have_http_status(:no_content)
  end

  it "returns  :unprocessable_entity if some parameters are missing" do
    post "/builds"
    expect(response).to have_http_status(:unprocessable_entity)


    post "/builds", params: { total_files: ['felan_spec.rb'], ci: 'travis' }
    expect(response).to have_http_status(:unprocessable_entity)

    post "/builds", params: { build_number: '1', ci: 'travis' }
    expect(response).to have_http_status(:unprocessable_entity)
  end
end
