shared_examples 'an endpoint with a middle page' do
  let(:next_page) { response.headers['Next-Page'].to_i }

  it 'should give all pagination links' do
    expect(links).to include('<http://example.org/numbers?count=100&page=1>; rel="first"')
    expect(links).to include('<http://example.org/numbers?count=100&page=10>; rel="last"')
    expect(links).to include('<http://example.org/numbers?count=100&page=3>; rel="next"')
    expect(links).to include('<http://example.org/numbers?count=100&page=1>; rel="prev"')
  end

  it 'should give a Total header' do
    expect(total).to eq(100)
  end

  it 'should give a Per-Page header' do
    expect(per_page).to eq(10)
  end

  it 'should give a Next-Page header' do
    expect(response.headers.keys).to include('Next-Page')
  end

  it 'should give a Next-Page header value' do
    expect(next_page).to eq(3)
  end

  it 'should list a middle page of numbers in the response body' do
    body = '[11,12,13,14,15,16,17,18,19,20]'

    if defined?(response)
      expect(response.body).to eq(body)
    else
      expect(last_response.body).to eq(body)
    end
  end
end
