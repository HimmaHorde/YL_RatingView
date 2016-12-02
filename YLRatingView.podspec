
Pod::Spec.new do |s|
  s.name         = "YLRatingView"

  s.version      = "1.0.0"
  
  s.summary      = "星级评分，支持 xib，支持自动布局"

  s.homepage     = "http://www.jianshu.com/users/d2c069de1a7d"

  s.license      = "MIT"

  s.author       = { "GuiFoA" => "18253561530@163.com" }

  s.platform     = :ios, "8.0"

  s.source       = { :git => "https://github.com/GuiFoA/YL_RatingView.git", :tag => "#{s.version}" }

  s.source_files  = "Classes", "YLRatingView/Classes/*.{h,m}"

  s.resources = "YLRatingView/Resources/*.png"

  s.requires_arc = true

end
