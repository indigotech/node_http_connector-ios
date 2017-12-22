#
# Be sure to run `pod lib lint NodeHttpConnector.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "NodeHttpConnector"
  s.version          = "0.3.4"
  s.summary          = "This coacoapod will encapsulate the logic to communicate to our Node Servers while developing to iOS."
  s.description      = <<-DESC
                        This pod has the following responsibilities:

                        + Abstract http requests
                        + Handle common errors
                        + Support client authentication
                          + No authentication
                          + JWC
                        + Parse http responses

                       DESC
  s.homepage         = "https://github.com/indigotech/br-taqtile-node_http_connector-ios"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "Adriano Valente" => "dri9595@gmail.com" }
  s.source           = { :git => "https://github.com/indigotech/br-taqtile-node_http_connector-ios.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'NodeHttpConnector' => ['Pod/Assets/*.png']
  }

    s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
   s.dependency 'AFNetworking', '2.6.3'
end
