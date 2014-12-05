describe 'mir' do
  before(:all) { `make pa5-encfs && ./pa5-encfs to_mnt/ mir/` }
  after(:all) { `fusermount -u mir/ && make clean` }

  subject{ Dir['mir/**/*'] }

  it 'contains files after mounting' do
    expect(subject).to_not be_empty
  end

  it 'contains the mirrored files after mounting' do
    expect(subject).to contain_exactly 'mir/test1.txt', 'mir/test2.txt',
      'mir/nested/test3.txt', 'mir/nested'
  end
end
