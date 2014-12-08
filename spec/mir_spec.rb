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

	describe 'encryption' do
		before(:all) { `make encrypt` }
		subject{ Dir['mnt/**/*'] }
		let(:mirror_directory) { Dir['mir/**/*'] }

		it 'encrypted file was created' do
			`echo "encryption test" >> mir/encrypted_input.txt`
			expect(subject).to contain_exactly 'mnt/test1.txt', 'mnt/test2.txt', 'mnt/encrypted_input.txt'
			expect(mirror_directory).to contain_exactly 'mir/test1.txt', 'mir/test2.txt', 'mir/encrypted_input.txt'
		end

		it 'encrypted file contains proper text in fuse system' do
			expect(`cat mir/encrypted_input.txt`).to include 'encryption test'
		end

		it 'created file is properly encrypted outside of the fuse system' do
			expect(`cat mnt/encrypted_input.txt`).to_not include 'encryption test'
		end
	end
end
