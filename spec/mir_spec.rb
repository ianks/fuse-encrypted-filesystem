describe 'Encrypted Filesystem' do
  before(:all) { `make mount` }
  after(:all) { `make unmount && make clean` }

  describe 'mounting' do
    subject{ Dir['mir/**/*'] }

    it 'contains files after mounting' do
      expect(subject).to_not be_empty
    end

    it 'contains the mirrored files after mounting' do
      expect(subject).to contain_exactly 'mir/test1.txt', 'mir/test2.txt'
    end
  end

  describe 'decryption' do
    it 'decrypts the files' do
      expect(`cat mnt/test1.txt`).to_not include 'foo'
      expect(`cat mir/test1.txt`).to include 'foo'
    end
  end
end
