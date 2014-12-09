describe 'Encrypted Filesystem' do
  before(:all) { `make mount` }
  after(:all) { `make unmount && make clean` }

  describe 'mounting' do
    subject{ Dir['mir/**/*'] }

    it 'contains files after mounting' do
      expect(subject).to_not be_empty
    end

    it 'contains the mirrored files after mounting' do
      expect(subject).to include 'mir/test1.txt', 'mir/test2.txt'
    end
  end

  describe 'decryption' do
    it 'decrypts the files' do
      expect(`cat mnt/test1.txt`).to_not include 'foo'
      expect(`cat mir/test1.txt`).to include 'foo'
    end
  end

	describe 'encryption' do
		let(:fuse_dir_contents) { Dir['mir/**/*'] }
		let(:filesystem_dir_contents) { Dir['mnt/**/*'] }
    after(:all) { `rm mir/encryption_test.txt`}
    after(:all) { `rm mir/encryption_test2.txt`}

		it 'create a file to be encrypted' do
			`echo "test encryption" >> mir/encryption_test.txt`
			expect(fuse_dir_contents).to include 'mir/encryption_test.txt'
			expect(filesystem_dir_contents).to include 'mnt/encryption_test.txt'
		end

		it 'file is readable in fuse' do
			expect(`cat mir/encryption_test.txt`).to include "test encryption"
		end

		it 'file is encrypted in the base filesystem' do
			expect(`cat mnt/encryption_test.txt`).to_not include "test encryption"
		end

		it 'appending works' do
			`echo "first input" >> mir/encryption_test2.txt`
			`echo "second input" >> mir/encryption_test2.txt`
			expect(`cat mir/encryption_test2.txt`).to include "first input"
			expect(`cat mir/encryption_test2.txt`).to include "second input"
		end

	end
end
