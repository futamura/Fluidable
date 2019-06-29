Pod::Spec.new do |s|

    s.name              = "Fluidable"
    s.version           = "0.0.1"
    s.summary           = "A Swift library allows you to create a flexibly customizable pull-to-refresh view supporting RxSwift."
    s.homepage          = "https://github.com/gumob/Fluidable"
    s.documentation_url = "https://gumob.github.io/Fluidable"
    s.license           = { :type => "MIT", :file => "LICENSE" }
    s.author            = { "gumob" => "hello@gumob.com" }

    s.module_name               = "Fluidable"
    s.source                    = { :git => "https://github.com/gumob/Fluidable.git", :tag => "#{s.version}", :submodules => true }
    s.source_files              = ["Sources/*.{swift}"]
    s.requires_arc              = true

    s.swift_version             = "4.2"

    s.ios.deployment_target     = "9.0"
    s.ios.framework             = "Foundation", "UIKit", "CoreGraphics"

    s.dependency 'Sica', '~> 0.3'

end
