class ApplicationController < ActionController::Base
  def hello
    respond_to do |format|
      format.html { render template: "applications/hello"}
      format.pdf do
        send_data(pdf.render,
          type: "application/pdf",
          disposition: "inline"
        )
      end
    end
  end

  private

  def pdf
    HelloPdf.new
  end
end
