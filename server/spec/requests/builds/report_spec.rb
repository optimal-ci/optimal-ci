RSpec.describe "POST /builds/:build_number/report", :type => :request do
  let(:project) { create(:project) }
  let(:build) { create(:build, project: project) }
  let(:node) { create(:node, build: build) }

  def do_request(params  = {})
    post "/builds/#{build.build_number}/report", params: params, headers: { Authorization: project.token }
  end

  it "updates duration of a node" do
    params = {
      files: {
        'file_1_spec.rb' => [Time.now.to_i, 6.0],
      },
      node_index: node.index,
      duration: 20
    }

    do_request(params)
    expect(response).to have_http_status(:no_content)
  end
end
