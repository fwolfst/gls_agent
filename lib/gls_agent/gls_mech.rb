require 'mechanize'
require 'logger'
require 'date'
require 'gls_agent'

# Utilize mechanize to do stuff on GLS webpage.
class GLSMech
  attr_accessor :mech
  attr_accessor :user
  attr_accessor :pass
  @@parcel_creation_url = 'http://www.your-gls.eu/276-I-PORTAL-WEB/content/GLS/DE03/DE/15005.htm'.freeze

  # Setup the mech.
  def initialize
    @mech = Mechanize.new
    @mech.user_agent_alias = 'Windows Mozilla'
  end

  # Enable logging to given file.
  def log_to filename
    @mech.log = Logger.new filename
  end

  # Saves parcel labels as pdf, does not overwrite file if exists,
  # yields error, filename that was saved to.
  # Later is nil if login, creation or redirect failed.
  def save_parcel_labels parcel_jobs, filenames
    return nil if !login! @user, @pass

    parcel_jobs.zip(filenames).each do |parcel, filename|
      if @mech.page.uri.to_s != @@parcel_creation_url
        @mech.get @@parcel_creation_url
      end

      if @mech.page.uri.to_s != @@parcel_creation_url
        yield "not logged in", nil
        next
      end

      form = @mech.page.forms.first
      fill_parcel_form form, parcel
      
      @mech.submit(form, form.buttons.first)

      pdf_iframe = @mech.page.iframes.first

      @mech.page.save_as "save_label#{DateTime.now.strftime('%s')}.html"
      
      if page_has_error?
        yield page_error_text, nil
      elsif pdf_iframe
        yield nil, pdf_iframe.content.save_as(filename)
      else
        yield 'unkown error', nil
      end
    end
  end

  # Saves parcel label as pdf, does not overwrite file if exists,
  # returns filename that label was saved to,
  # or nil if login, creation or redirect failed.
  def save_parcel_label parcel_job, filename
    if !login! @user, @pass
      raise GLSAgent::GLSEndpointError.new page_error_text
    end

    form = @mech.page.forms.first
    fill_parcel_form form, parcel_job

    @mech.submit(form, form.buttons.first)

    pdf_iframe = @mech.page.iframes.first

    if @mech.log
      @mech.page.save_as "save_label#{DateTime.now.strftime('%s')}.html"
    end

    if page_has_error?
      raise GLSAgent::GLSEndpointError.new page_error_text
    end

    if pdf_iframe
      return pdf_iframe.content.save_as filename
    elsif @mech.log
      @mech.page.save_as "gls_agent_debug_save-parcel-fail.html"
    end
    return nil
  end

  private

  # Login to GLS parcel creation web page using provided credentials.
  # returns true if login and navigation afterwards succeeded.
  def login! username, password
    page = @mech.get @@parcel_creation_url
    form = page.forms.first
    form.fields[5].value = username
    form.fields[6].value = password
    form.submit
    # Move on to target page.
    page = @mech.get @@parcel_creation_url
    page.uri.to_s == @@parcel_creation_url
  end

  def fill_parcel_form form, parcel_job
    form.field_with(:name => 'txtName1').value = parcel_job.name
    form.field_with(:name => 'txtName2').value = parcel_job.company
    form.field_with(:name => 'txtStreet').value = parcel_job.street
    form.field_with(:name => 'txtBlockNo').value = parcel_job.streetno
    form.field_with(:name => 'txtZipCodeDisplay').value = parcel_job.zip
    form.field_with(:name => 'txtCity').value = parcel_job.city
    form.field_with(:name => 'txtWeight').value = parcel_job.weight
    form.field_with(:name => 'txtDate').value = parcel_job.date
  end

  # Is there an error (div with .prefix class) on the current page?
  def page_has_error?
    !@mech.page.search(".prefix").empty?
  end

  # Error text (div with .prefix class) of the current page.
  def page_error_text
    error_div = @mech.page.search(".prefix")[0]
    error_div ? error_div.text : "general error"
  end
end
