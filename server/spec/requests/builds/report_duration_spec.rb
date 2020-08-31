RSpec.describe "POST /builds", :type => :request do
  let(:project) { create(:project) }
  let(:build) { create(:build, project: project) }
  let(:node) { create(:node, build: build) }

  def do_request(params  = {})
    patch "/builds/#{build.build_number}/report_duration", params: params, headers: { Authorization: project.token }
  end

  it "updates duration of a node" do
    do_request(duration: 10, node_index: node.index)
    expect(response).to have_http_status(:no_content)
  end
end
