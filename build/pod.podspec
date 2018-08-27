Pod::Spec.new do |spec|
  spec.name         = 'Gvsc'
  spec.version      = '{{.Version}}'
  spec.license      = { :type => 'GNU Lesser General Public License, Version 3.0' }
  spec.homepage     = 'https://github.com/vsportchain/go-vsc'
  spec.authors      = { {{range .Contributors}}
		'{{.Name}}' => '{{.Email}}',{{end}}
	}
  spec.summary      = 'iOS VSportChain Client'
  spec.source       = { :git => 'https://github.com/vsportchain/go-vsc.git', :commit => '{{.Commit}}' }

	spec.platform = :ios
  spec.ios.deployment_target  = '9.0'
	spec.ios.vendored_frameworks = 'Frameworks/Gvsc.framework'

	spec.prepare_command = <<-CMD
    curl https://gvscstore.blob.core.windows.net/builds/{{.Archive}}.tar.gz | tar -xvz
    mkdir Frameworks
    mv {{.Archive}}/Gvsc.framework Frameworks
    rm -rf {{.Archive}}
  CMD
end
