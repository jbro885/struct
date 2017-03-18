require_relative '../spec_helper'

RSpec.describe StructCore::Migrator do
	describe '#migrate' do
		it 'can migrate projects with xcconfig files instead of configuration settings' do
			xcodeproj_file = File.join(File.dirname(__FILE__), 'support_files', 'xcconfig', 'Xcconfig.xcodeproj')
			spec = nil

			expect { spec = StructCore::Migrator.migrate xcodeproj_file, Dir.tmpdir, true }.not_to raise_error
			expect(spec).to_not be_nil
			expect(spec.targets.length).to eq(1)
			expect(spec.targets[0].configurations.length).to eq(2)
			expect(spec.targets[0].configurations[0].source).to_not be_nil
		end

		it 'can migrate projects with missing xcconfig files' do
			xcodeproj_file = File.join(File.dirname(__FILE__), 'support_files', 'missing-xcconfig', 'Xcconfig.xcodeproj')
			spec = nil

			expect { spec = StructCore::Migrator.migrate xcodeproj_file, Dir.tmpdir, true }.not_to raise_error
			expect(spec).to_not be_nil
			expect(spec.targets.length).to eq(1)
			expect(spec.targets[0].configurations.length).to eq(2)
			expect(spec.targets[0].configurations[0].source).to be_nil
		end
		it 'can migrate projects with local libraries' do
			xcodeproj_file = File.join(File.dirname(__FILE__), 'support_files', 'migrate_local_library', 'MigrateLocalLibrary.xcodeproj')
			spec = nil

			expect { spec = StructCore::Migrator.migrate xcodeproj_file, Dir.tmpdir, true }.not_to raise_error
			expect(spec).to_not be_nil
			expect(spec.targets.length).to eq(1)
			expect(spec.targets[0].references.length).to eq(1)
		end
	end
end