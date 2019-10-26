describe BooksController do
  # While automatically inferred, they can be also manually specified:
  base_path '/topics/{tag_id}/books'
  resource_name 'book'
  resource_summary 'Lists all books for a specific topic.'
  resource_description <<~HEREDOC
    This will fail if the topic does not exists.
    The results are not paginated.
  HEREDOC
  resource_tags 'topics', 'list'

  describe action 'GET #index' do
    subject(:make_request) { get :index, params: params }

    # This is also auto detected, but can be manually changed
    path ''
    deprecate!

    let(:params) { { topic_id: topic_id } }
    let(:topic_id) { 1 }

    describe example 'when a valid topic is given' do
      before do
        make_request
      end

      default_example

      it 'responds with ok status' do
        expect(response).to have_http_status(:ok)
      end
    end

    describe example 'when an invalid topic is given' do
      let(:topic_id) { -1 }

      include_examples 'not found examples'
    end
  end
end
