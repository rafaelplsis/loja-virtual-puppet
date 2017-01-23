class loja_virtual::ci inherits loja_virtual{
package { ['git', 'maven2', 'openjdk-6-jdk','rubygems']:
 ensure => "installed",
}

package {['fpm','bundler']:
 ensure		=>	['1.4.0','installed'],		
 provider	=>	'gem',
 require		=>	Package['rubygems'],
}

class { 'jenkins':
 config_hash => {
  'JAVA_ARGS' => { 'value' => '-Xmx512m' }
 },
}
$plugins = [
 'structs',
 'workflow-basic-steps',
 'matrix-project',
 'resource-disposer',
 'workflow-scm-step',
 'workflow-step-api',
 'workflow-api',
 'script-security',
 'display-url-api',
 'junit',
 'ssh-credentials',
 'credentials',
 'scm-api',
 'git-client',
 'git',
 'maven-plugin',
 'javadoc',
 'mailer',
 'greenballs',
 'ws-cleanup'
]

jenkins::plugin { $plugins: }
 file {'/var/lib/jenkins/hudson.tasks.Maven.xml':
  mode		=>	0644,
  owner		=> 	'jenkins',
  group		=>	'jenkins',
  source		=>	'puppet:///modules/loja_virtual/hudson.tasks.Maven.xml',
  require		=>	Class['jenkins::package'],
  notify		=>	Service['jenkins'],
}

$job_structure = [
 '/var/lib/jenkins/jobs/',
 '/var/lib/jenkins/jobs/loja_virtual_devops'
 ]

 $git_repository = 
 'https://github.com/rafaelplsis/loja-virtual-devops.git'
 $git_poll_interval = '* * * * *'
 $maven_goal = 'install'
 $archive_artifacts = 'combined/target/*.war'
 $repo_dir = '/var/lib/apt/repo'
 $repo_name = 'devopspkgs'

 file { $job_structure:
 ensure		=>	'directory',
 owner		=>	'jenkins',
 group		=>	'jenkins',
 require		=>	Class['jenkins::package'],
}
file { "${job_structure[1]}/config.xml":
 mode		=>	0644,
 owner		=>	'jenkins',
 group		=>	'jenkins',
 content		=>	template('loja_virtual/config.xml'),
 require		=>	File[$job_structure],
 notify		=>	Service['jenkins'],
}

class {'loja_virtual::repo':
 basedir =>	$repo_dir,
 name	=>	$repo_name,
}
}