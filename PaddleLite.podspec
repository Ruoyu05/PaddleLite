Pod::Spec.new do |s|
  s.name                    = 'PaddleLite'
  s.version                 = '0.0.1'
  s.summary                 = 'A lightweight API wrapper for Paddle-Lite.'
  s.description             = 'PaddleLite is a Swift library for integrating the Paddle-Lite.'

  s.homepage                = 'https://github.com/Ruoyu05/PaddleLite'
  s.author                  = { 'Ruoyu' => 'xyhuyumao@gmail.com' }
  s.source                  = { :git => 'https://github.com/Ruoyu05/PaddleLite.git', :tag => s.version.to_s }
  s.license                 = { :type => 'MIT', :file => 'LICENSE' }

  s.public_header_files     = 'PaddleLite/include/**/*.h', 'PaddleLite/PaddleLiteWrapper.h'
  s.source_files            = 'PaddleLite/PaddleApi.swift', 'PaddleLite/PaddleLiteWrapper.*', 'PaddleLite/include/**/*'
  s.ios.vendored_libraries  = 'PaddleLite/lib/libpaddle_api_light_bundled.a'

  s.ios.deployment_target   = '18.0'
  s.library                 = 'c++'
  s.static_framework        = true
  s.swift_version           = '5.0'
end
