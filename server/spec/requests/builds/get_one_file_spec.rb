RSpec.describe "GET /builds/:build_number/get_one_file", :type => :request do
  let(:project) { create(:project) }
  let(:build) { create(:build, project: project) }

  def do_request
    get "/builds/#{build.build_number}/get_one_file", headers: { Authorization: project.token }
  end

  it "returns one file from queue" do
    do_request

    expect(response).to have_http_status(:ok)
    expect(JSON.parse(response.body)).to eq([build.queue.first])
  end

  it "removes the file from queue" do
    expect { do_request }.to change { build.reload.queue.count }
  end

  it "returns 404 if queue is emtpy" do
    build.queue = []
    build.save!

    do_request

    expect(response).to have_http_status(:not_found)
  end

  it "append the file to processed" do
    expect { do_request }.to change { build.reload.processed.count }
  end
end
