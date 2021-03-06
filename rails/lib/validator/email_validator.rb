# Email カスタムバリデーション

class EmailValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    # 長さ
    max = 255
    record.errors.add(attribute, :too_long, count: max) if value.length > max

    # 書式
    format = /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
    record.errors.add(attribute, :invalid) unless format =~ value

    # 重複排除
    record.errors.add(attribute, :taken) if record.email_activated?

  end
end