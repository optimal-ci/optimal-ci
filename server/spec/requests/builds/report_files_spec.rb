RSpec.describe "POST /builds", :type => :request do
  let(:project) { create(:project) }
  let(:build) { create(:build, project: project) }
  let(:node) { create(:node, build: build) }

  def do_request(params  = {})
    post "/builds/#{build.build_number}/report_files", params: params, headers: { Authorization: project.token }
  end

  it "updates the files" do
    do_request(files: { 'file_1_spec.rb' => [Time.now.to_i, 6.0] })
    expect(response).to have_http_status(:no_content)
  end
end
