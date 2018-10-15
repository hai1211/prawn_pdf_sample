class ApplicationController < ActionController::Base
  def hello
    respond_to do |format|
      format.html { render html: "hello"}
      format.pdf do
        send_data(generate_pdf,
          filename: "hello.pdf",
          type: "application/pdf",
          disposition: "inline"
        )
      end
    end
  end

  private

  def generate_pdf
    mincho_font_path = "#{Rails.root}/app/assets/fonts/MSMINCHO.TTF"
    Prawn::Document.new do
      font_families.update(
        "ms_mincho" => {
            :normal => {:file => mincho_font_path, :font => "Mincho"},
            :bold => mincho_font_path,
            :italic => mincho_font_path,
            :bold_italic => mincho_font_path
        }
      )
      font "ms_mincho"

      text "御見積書", size: 14, align: :center
      move_down 20

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

      text "株式会社○○○○○○○○○○○○ 御中", size: 8
      image "#{Rails.root}/app/assets/images/Picture1.png", at: [400, cursor]
      icom_image_cursor = cursor
      move_down 30

      current_cursor = cursor
      bounding_box([0, current_cursor], width: 80, height: 15) do
        stroke_color 'FFFFFF'
        stroke_bounds
        stroke do
          stroke_color 'D9D9D9'
          fill_color 'D9D9D9'
          fill_and_stroke_rectangle [bounds.left, bounds.top], bounds.right, bounds.top
          fill_color '000000'
        end
        bounds.add_right_padding 5
        text "納期", size: 8, align: :right, valign: :center
      end
      bounding_box([80, current_cursor], width: 60, height: 15) do
        bounds.add_left_padding 5
        text "別途ご相談", size: 8, align: :left, valign: :center
      end

      move_down 3

      current_cursor = cursor
      bounding_box([0, current_cursor], width: 80, height: 15) do
        stroke_color 'FFFFFF'
        stroke_bounds
        stroke do
          stroke_color 'D9D9D9'
          fill_color 'D9D9D9'
          fill_and_stroke_rectangle [bounds.left, bounds.top], bounds.right, bounds.top
          fill_color '000000'
        end
        bounds.add_right_padding 5
        text "支払条件", size: 8, align: :right, valign: :center
      end
      bounding_box([80, current_cursor], width: 100, height: 15) do
        bounds.add_left_padding 5
        text "月末締翌月末払い", size: 8, align: :left, valign: :center
      end

      move_down 3

      current_cursor = cursor
      bounding_box([0, current_cursor], width: 80, height: 15) do
        stroke_color 'FFFFFF'
        stroke_bounds
        stroke do
          stroke_color 'D9D9D9'
          fill_color 'D9D9D9'
          fill_and_stroke_rectangle [bounds.left, bounds.top], bounds.right, bounds.top
          fill_color '000000'
        end
        bounds.add_right_padding 5
        text "有効期限", size: 8, align: :right, valign: :center
      end
      bounding_box([80, current_cursor], width: 100, height: 15) do
        bounds.add_left_padding 5
        text "見積発行後2週間", size: 8, align: :left, valign: :center
      end

      move_down 3

      current_cursor = cursor
      bounding_box([0, current_cursor], width: 80, height: 25) do
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
        text "御見積金額（税込）", size: 8, align: :right, valign: :center
      end
      bounding_box([80, current_cursor], width: 200, height: 25) do
        bounds.add_left_padding 5
        text "999,999,999円", size: 11, align: :left, valign: :center
      end

      move_cursor_to icom_image_cursor - 30
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

      move_cursor_to cursor + 100
      bounding_box([0, cursor], width: 500, height: 10) do
        stroke_color 'FFFFFF'
        stroke_bounds
        stroke do
          stroke_color 'D9D9D9'
          fill_color 'D9D9D9'
          fill_and_stroke_rectangle [bounds.left, bounds.top], bounds.right, bounds.top
          fill_color '000000'
        end
      end
    end.render
  end
end
