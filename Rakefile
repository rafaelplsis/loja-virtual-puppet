# encoding: utf-8
namespace :librarian do
	desc "Instala os modulos usando o Librarian Puppet"
	task :install do
		Dir.chdir('librarian') do
			sh "librarian-puppet install"
		end
	end
end

desc "Cria o pacote puppet.tgz"
task :package => 'librarian:install' do
	sh "tar czvf puppet.tgz manifests modules librarian/modules"
end

desc "Limpa o pacote puppet.tgz"
task :clean do
	sh "rm puppet.tgz"
end