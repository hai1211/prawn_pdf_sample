class HelloPdf
  include Prawn::View

  def initialize
    mincho_font

    title

    move_down 20
    estimated_date

    greeting

    company_icon

    icom_image_cursor = cursor
    move_down 30
    order_info

    move_cursor_to icom_image_cursor - 30
    company_info

    move_cursor_to cursor + 100
    table

    table_cursor = cursor
    delivery_dest

    move_cursor_to table_cursor
    table_statitic

    move_down 10
    remark
  end

  private

  def mincho_font
    mincho_font_path = "#{Rails.root}/app/assets/fonts/MSMINCHO.TTF"
    font_families.update(
      "ms_mincho" => {
          :normal => {:file => mincho_font_path, :font => "Mincho"},
          :bold => mincho_font_path,
          :italic => mincho_font_path,
          :bold_italic => mincho_font_path
      }
    )
    font "ms_mincho"
  end

  def title
    text "御見積書", size: 14, align: :center
  end

  def estimated_date
    current_cursor = cursor
    bounding_box([300, current_cursor], width: 200, height: 40) do
      text "№ ：", size: 8, align: :right
      move_down 10
      text "見積日 ：", size: 8, align: :right
    end
    bounding_box([510, current_cursor], width: 200, height: 40) do
      text "99999", size: 8, align: :left
      move_down 10
      text "yyyy/mm/dd", size: 8, align: :left
    end
  end

  def greeting
    text "株式会社○○○○○○○○○○○○ 御中", size: 8
  end

  def company_icon
    image "#{Rails.root}/app/assets/images/Picture1.png", at: [400, cursor]
  end

  def order_info
    [
      {key: '納期', value: '別途ご相談', size: 0},
      {key: '支払条件', value: '月末締翌月末払い', size: 0},
      {key: '有効期限', value: '見積発行後2週間', size: 0},
      {key: '御見積金額（税込）', value: '999,999,999円', size: 1}
    ].each do |setting|
      current_cursor = cursor
      if setting[:size] == 0
        box_height = 15
        value_size = 8
      else
        box_height = 25
        value_size = 12
      end

      bounding_box([0, current_cursor], width: 80, height: box_height) do
        stroke_color 'FFFFFF'
        stroke_bounds
        stroke do
          stroke_color 'D9D9D9'
          fill_color 'D9D9D9'
          fill_and_stroke_rectangle [bounds.left, bounds.top], bounds.right, bounds.top
          fill_color '000000'
        end
        bounds.add_right_padding 5
        bounds.add_left_padding 30
        text setting[:key], size: 8, align: :right, valign: :center
      end
      bounding_box([80, current_cursor], width: 200, height: box_height) do
        bounds.add_left_padding 5
        text setting[:value], size: value_size, align: :left, valign: :center
      end
      move_down 3
    end
  end

  def company_info
    bounding_box([400, cursor], width: 200, height: 200) do
      text "株式会社アイコム", size: 8
      text "東京営業所", size: 8
      move_down 10
      text "〒999-9999", size: 8
      move_down 5
      text "東京都江東区木場2-17-16", size: 8
      move_down 5
      text "ビザイド木場５F", size: 8
      move_down 5
      text "TEL：99-9999-9999", size: 8
    end
  end

  def table
    table_header
    table_content
  end

  def table_header
    table_header_cursor = cursor
    bounding_box([0, table_header_cursor], width: bounds.width, height: 15) do
      stroke_color 'FFFFFF'
      stroke_bounds
      stroke do
        stroke_color 'D9D9D9'
        fill_color 'D9D9D9'
        fill_and_stroke_rectangle [bounds.left, bounds.top], bounds.right, bounds.top
        fill_color '000000'
      end
    end
    bounding_box([0, table_header_cursor], width: 80, height: 15) do
      stroke do
        stroke_color '000000'
        horizontal_line bounds.left, bounds.right, at: bounds.bottom
      end
      bounds.add_left_padding 5
      text "製品コード", size: 8, valign: :center
    end
    bounding_box([80, table_header_cursor], width: 120, height: 15) do
      stroke do
        stroke_color '000000'
        horizontal_line bounds.left, bounds.right, at: bounds.bottom
      end
      bounds.add_left_padding 5
      text "製品名", size: 8, valign: :center
    end
    bounding_box([200, table_header_cursor], width: 100, height: 15) do
      stroke do
        stroke_color '000000'
        horizontal_line bounds.left, bounds.right, at: bounds.bottom
      end
      bounds.add_right_padding 5
      text "仕切単価", size: 8, align: :right, valign: :center
    end
    bounding_box([300, table_header_cursor], width: 80, height: 15) do
      stroke do
        stroke_color '000000'
        horizontal_line bounds.left, bounds.right, at: bounds.bottom
      end
      bounds.add_right_padding 5
      text "単価値引", size: 8, align: :right, valign: :center
    end
    bounding_box([380, table_header_cursor], width: 80, height: 15) do
      stroke do
        stroke_color '000000'
        horizontal_line bounds.left, bounds.right, at: bounds.bottom
      end
      bounds.add_right_padding 5
      text "数量", size: 8, align: :right, valign: :center
    end
    bounding_box([460, table_header_cursor], width: 80, height: 15) do
      stroke do
        stroke_color '000000'
        horizontal_line bounds.left, bounds.right, at: bounds.bottom
      end
      bounds.add_right_padding 5
      text "金額", size: 8, align: :right, valign: :center
    end
  end

  def table_content
    (1..10).each do |_|
      table_content_cursor = cursor
      bounding_box([0, table_content_cursor], width: 80, height: 15) do
        stroke do
          stroke_color '000000'
          line_width 1
          horizontal_line bounds.left, bounds.right, at: bounds.bottom
        end
        bounds.add_left_padding 5
        text "99999999", size: 8, valign: :center
      end
      bounding_box([80, table_content_cursor], width: 120, height: 15) do
        stroke do
          stroke_color '000000'
          horizontal_line bounds.left, bounds.right, at: bounds.bottom
        end
        bounds.add_left_padding 5
        text "製品名テキストテキスト", size: 8, valign: :center
      end
      bounding_box([200, table_content_cursor], width: 100, height: 15) do
        stroke do
          stroke_color '000000'
          horizontal_line bounds.left, bounds.right, at: bounds.bottom
        end
        bounds.add_right_padding 5
        text "9,999,999", size: 8, align: :right, valign: :center
      end
      bounding_box([300, table_content_cursor], width: 80, height: 15) do
        stroke do
          stroke_color '000000'
          horizontal_line bounds.left, bounds.right, at: bounds.bottom
        end
        bounds.add_right_padding 5
        text "-9,999", size: 8, align: :right, valign: :center, color: 'FF0000'
      end
      bounding_box([380, table_content_cursor], width: 80, height: 15) do
        stroke do
          stroke_color '000000'
          horizontal_line bounds.left, bounds.right, at: bounds.bottom
        end
        bounds.add_right_padding 5
        text "999", size: 8, align: :right, valign: :center
      end
      bounding_box([460, table_content_cursor], width: 80, height: 15) do
        stroke do
          stroke_color '000000'
          horizontal_line bounds.left, bounds.right, at: bounds.bottom
        end
        bounds.add_right_padding 5
        text "99,999,999", size: 8, align: :right, valign: :center
      end
      move_down 1
    end
  end

  def delivery_dest
    current_cursor = cursor
    move_down 10
    bounding_box([0, cursor], width: 350, height: 15) do
      stroke_color 'FFFFFF'
      stroke_bounds
      stroke do
        stroke_color 'D9D9D9'
        fill_color 'D9D9D9'
        fill_and_stroke_rectangle [bounds.left, bounds.top], bounds.right, bounds.top
        fill_color '000000'
      end
      bounds.add_left_padding 5
      text "納品先", size: 8, valign: :center
    end
    move_down 5
    bounding_box([0, cursor], width: 350, height: 100) do
      bounds.add_left_padding 5
      text "株式会社○○○○", size: 8
      text "担当者　氏名", size: 8
      move_down 10
      text "〒999-9999　東京都千代田区岩本町3-9-17　スリーセブンビル10F", size: 8
      text "TEL：999-9999-9999", size: 8
    end
  end

  def table_statitic
    [
      {key: '小計', value: '999,999,999'},
      {key: '合計値引', value: '-99,999', color: 'FF0000'},
      {key: '送料', value: '99,999'},
      {key: '消費税', value: '99,999'},
      {key: '税込合計', value: '999,999,999'}
    ].each do |setting|
      current_cursor = cursor
      bounding_box([380, current_cursor], width: 80, height: 15) do
        stroke_color 'FFFFFF'
        stroke_bounds
        stroke do
          stroke_color 'D9D9D9'
          fill_color 'D9D9D9'
          fill_and_stroke_rectangle [bounds.left, bounds.top], bounds.right, bounds.top
          fill_color '000000'
        end
        stroke do
          stroke_color '000000'
          horizontal_line bounds.left, bounds.right, at: bounds.bottom
        end
        bounds.add_right_padding 5
        text setting[:key], size: 8, align: :right, valign: :center
      end
      bounding_box([460, current_cursor], width: 80, height: 15) do
        stroke do
          stroke_color '000000'
          horizontal_line bounds.left, bounds.right, at: bounds.bottom
        end
        bounds.add_right_padding 5
        text setting[:value], size: 8, align: :right, valign: :center, color: setting[:color]
      end
      move_down 1
    end
  end

  def remark
    bounding_box([0, cursor], width: 550, height: 15) do
      stroke_color 'FFFFFF'
      stroke_bounds
      stroke do
        stroke_color 'D9D9D9'
        fill_color 'D9D9D9'
        fill_and_stroke_rectangle [bounds.left, bounds.top], bounds.right, bounds.top
        fill_color '000000'
      end
      bounds.add_left_padding 5
      text "備考", size: 8, valign: :center
    end
    move_down 5
    bounding_box([0, cursor], width: 200, height: 100) do
      bounds.add_left_padding 5
      text "備考入力テキストテキストテキストテキストテキストテキスト", size: 8
    end
  end
end
