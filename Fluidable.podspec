Pod::Spec.new do |s|

    s.name              = "Fluidable"
    s.version           = "1.0.0"
    s.summary           = "The Swift library that allows you to create a custom transition conforming to Fluid Interfaces."
    s.homepage          = "https://github.com/gumob/Fluidable"
    s.documentation_url = "https://gumob.github.io/Fluidable"
    s.license           = { :type => "MIT", :file => "LICENSE" }
    s.author            = { "gumob" => "hello@gumob.com" }

    s.module_name               = "Fluidable"
    s.source                    = { :git => "https://github.com/gumob/Fluidable.git", :tag => "#{s.version}", :submodules => true }
    s.source_files              = ["Sources/*.{swift}",
                                   "Sources/*/*.{swift}",
                                   "Sources/*/*/*.{swift}",
                                   "Sources/*/*/*/*.{swift}",]
    s.requires_arc              = true

    s.swift_version             = "5.0"

    s.ios.deployment_target     = "10.0"
    s.ios.framework             = "Foundation", "UIKit", "CoreGraphics"

    # s.test_spec 'FluidableTests' do |test_spec|
    #     test_spec.source_files = 'Tests/*.swift'
    #     test_spec.dependency 'Quick', '~> 2.1.0'
    #     test_spec.dependency 'Nimble', '~> 8.0.2'
    # end
    #
    # s.test_spec 'FluidableUITests' do |test_spec|
    #     test_spec.source_files = 'UITests/*.swift'
    #     test_spec.dependency 'Quick', '~> 2.1.0'
    #     test_spec.dependency 'Nimble', '~> 8.0.2'
    # end
end
