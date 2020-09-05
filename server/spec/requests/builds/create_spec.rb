RSpec.describe "POST /builds", :type => :request do
  let(:project) { create(:project, files: { "file_1_#{time}" => "0.5" }) }
  let(:time) { Time.now.to_i.to_s }

  def do_request(params  = {})
    post "/builds", params: params, headers: { Authorization: project.token }
  end

  it "creates a build" do
    do_request(total_files: {'felan_spec.rb' => time.to_i, "file_1" => time.to_i }, ci: 'travis', build_number: '1')
    expect(response).to have_http_status(:no_content)
  end

  it "returns  :unprocessable_entity if some parameters are missing" do
    do_request
    expect(response).to have_http_status(:unprocessable_entity)


    do_request(total_files: {'felan_spec.rb' => time.to_i}, ci: 'travis')
    expect(response).to have_http_status(:unprocessable_entity)

    do_request(build_number: '1', ci: 'travis')
    expect(response).to have_http_status(:unprocessable_entity)
  end

  it "does not create duplicated builds" do
    do_request(total_files: {'felan_spec.rb' => time}, ci: 'travis', build_number: '1')

    expect(response).to have_http_status(:no_content)

    do_request(total_files: {'felan_spec.rb' => time}, ci: 'travis', build_number: '1')

    expect(response).to have_http_status(:conflict)
  end
end
