#
# Be sure to run `pod lib lint amplify-tools.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'amplify-tools'
  s.version          = '0.3.0'
  s.summary          = 'Installs Amplify CLI'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/nikhname/amplify-tools'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Nikhil Lingireddy' => 'nikling@amazon.com' }
  s.source           = { :git => 'https://github.com/nikhname/amplify-tools.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'
  s.swift_versions = '4.0'
  s.source_files = 'Classes/*'
  
  s.script_phase = {
    :name => 'Install Amplify CLI',
    :script =>
'set -e
export PATH=$PATH:`npm bin -g`

if ! which node > /dev/null; then
  echo "warning: node is not installed. Vist https://nodejs.org/en/download/ to install it"
elif ! which amplify > /dev/null; then
  npm install -g @aws-amplify/cli
fi

amplify-dev init --iosSkeleton
cd ..

AWSCLOUDFORMATIONCONFIG="{\
\"configLevel\":\"project\",\
\"useProfile\":true,\
\"profileName\":\"default\"\
}"
AMPLIFY="{\
\"envName\":\"ios\"\
}"
PROVIDERS="{\
\"awscloudformation\":$AWSCLOUDFORMATIONCONFIG\
}"

amplifyPush=false

if $amplifyPush; then
  amplify-dev init --amplify $AMPLIFY --providers $PROVIDERS --yes
fi',
    :execution_position => :before_compile
  }
  
  # s.resource_bundles = {
  #   'amplify-tools' => ['amplify-tools/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
