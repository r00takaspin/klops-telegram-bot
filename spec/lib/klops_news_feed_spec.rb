describe KlopsNewsFeed do
  before(:each) do
    allow_any_instance_of(KlopsNewsFeed).to receive(:make_request) do
      File.read(File.expand_path('spec/fixtures/news_feed.rss'))
    end
  end

  it 'should return array' do
    subject.fetch!
    expect(subject.items).to be_a_kind_of(Array)
  end

  it 'should return right number of news' do
    subject.fetch!
    expect(subject.items.count).to eq(KlopsNewsFeed::NEWS_LIMIT)
  end

  context 'passing number of required news' do
    subject { KlopsNewsFeed.new(1)}

    it 'should return only one news' do
      subject.fetch!
      expect(subject.items.count).to eq(1)
    end
  end

  context 'it should not fetch error with huge number in argument' do
    subject { KlopsNewsFeed.new(999999999999) }

    it 'should return only one news' do
      subject.fetch!
      expect(subject.items.count).to eq(20)
    end
  end
end
