Pod::Spec.new do |s|
  s.name             = "RamblerTyphoonUtils"
  s.version          = "1.4.0"
  s.summary          = "A collection of Typhoon utils and tools used by Rambler&Co."

  s.description      = <<-DESC
  Typhoon is a great tool, and iOS team in Rambler&Co loves it a lot. Besides actual contributing, we've developed some useful tools which cannot be included in the main project.
  1. RamblerInitialAssemblyCollector - this class can be used for activating assemblies on startup instead of plist integration.
  2. RamblerTyphoonAssemblyTests - A base test class used for TyphoonAssembly testing.
                       DESC

  s.homepage         = "https://github.com/rambler-ios/RamblerTyphoonUtils"
  s.license          = 'MIT'
  s.authors           = { "Egor Tolstoy" => "e.tolstoy@rambler-co.ru", "Irina Dyagileva" => "i.dyagileva@rambler-co.ru", "Andrey Rezanov" => "a.rezanov@rambler-co.ru", "Andrey Zarembo-Godzyatsky" => "a.zarembo-godzyatsky@rambler-co.ru", "Aleksandr Sychev" => "a.sychev@rambler-co.ru" }
  s.source           = { :git => "https://github.com/rambler-ios/RamblerTyphoonUtils.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/rambler_ios'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = "Code/Production/**/*.{h,m}"

  s.subspec 'AssemblyCollector' do |subspec|
    subspec.source_files = "Code/Production/AssemblyCollector.h", "Code/Production/AssemblyCollector/*.{h,m}"
  end

  s.subspec 'AssemblyTesting' do |subspec|
    subspec.source_files = "Code/Testing/AssemblyTesting.h", "Code/Testing/AssemblyTesting/*.{h,m}"
    subspec.framework = 'XCTest'
    subspec.user_target_xcconfig = { 'FRAMEWORK_SEARCH_PATHS' => '$(PLATFORM_DIR)/Developer/Library/Frameworks' }
    subspec.dependency 'OCMock', '~> 3'
  end  
end
