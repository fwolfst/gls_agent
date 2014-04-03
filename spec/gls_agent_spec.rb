require_relative '../lib/gls_agent'

describe 'GLSAgent Module helpers' do
  it 'creates ParcelJob from csv string' do
    job = GLSAgent::job_from_csv 'Name,Street,1,1234,City,1'
    expect(job.name).to eq 'Name'
    expect(job.street).to eq 'Street'
    expect(job.streetno).to eq '1'
    expect(job.zip).to eq '1234'
    expect(job.city).to eq 'City'
    expect(job.weight).to eq '1'
  end

  it 'creates ParcelJob from hash' do
    hash = {:name => 'Name', :street => 'Street', :streetno => '1', :zip => '1234', :city => 'City', :weight => '1'}
    job = GLSAgent::job_from_hash hash
    expect(job.name).to eq 'Name'
    expect(job.street).to eq 'Street'
    expect(job.streetno).to eq '1'
    expect(job.zip).to eq '1234'
    expect(job.city).to eq 'City'
    expect(job.weight).to eq '1'
  end
end

describe 'Dotfile-Parsing' do
  it 'makes a hash from abc=def options' do
    hash = GLSAgent::hash_from_text 'abc=def'
    expect(hash[:abc]).to eq 'def'
  end
  it 'is tolerant about spaces' do
    hash = GLSAgent::hash_from_text ' abc =def '
    expect(hash[:abc]).to eq 'def'
  end
  it 'handles multiple options' do
    hash = GLSAgent::hash_from_text " abc =def \nuser= 123\n pass   = h"
    expect(hash[:abc]).to eq 'def'
    expect(hash[:user]).to eq '123'
    expect(hash[:pass]).to eq 'h'
  end
end
