describe KlopsPopularNews do
  before(:each) do
    allow_any_instance_of(KlopsPopularNews).to receive(:make_request) do
      File.read(File.expand_path('spec/fixtures/popular_news.json'))
    end
  end

  it 'should return array' do
    subject.fetch!
    expect(subject.items).to be_a_kind_of(Array)
  end

  it 'should return right number of news' do
    subject.fetch!
    expect(subject.items.count).to eq(KlopsPopularNews::NEWS_LIMIT)
  end
end
