class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  # 共通 ファイル形式のバリデーション
  ALLOWED_CONTENT_TYPES = %q{ image/jpeg
                              image/png }

end
