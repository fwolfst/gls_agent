require 'mechanize'
require 'logger'

# Utilize mechanize to do stuff on GLS webpage.
class GLSMech
  attr_accessor :mech
  attr_accessor :user
  attr_accessor :pass

  # Setup the mech.
  def initialize
    @mech = Mechanize.new
    @mech.user_agent_alias = 'Windows Mozilla'
  end

  # Enable logging to given file.
  def log_to filename
    @mech.log = Logger.new filename
  end

  # Saves parcel label as pdf, does not overwrite file if exists,
  # returns filename that label was saved to.
  # returns nil if login, creation or redirect failed.
  def save_parcel_label parcel_job, filename
    return nil if !login! @user, @pass

    form = @mech.page.forms.first

    form.field_with(:name => 'txtName1').value = parcel_job.name
    form.field_with(:name => 'txtStreet').value = parcel_job.street
    form.field_with(:name => 'txtBlockNo').value = parcel_job.streetno
    form.field_with(:name => 'txtZipCodeDisplay').value = parcel_job.zip
    form.field_with(:name => 'txtCity').value = parcel_job.city
    form.field_with(:name => 'txtWeight').value = parcel_job.weight
    form.field_with(:name => 'txtDate').value = parcel_job.date
    
    @mech.submit(form, form.buttons.first)

    pdf_iframe = @mech.page.iframes.first

    if pdf_iframe
      return @mech.page.iframes.first.content.save_as filename
    elsif @mech.log
      @mech.page.save_as "gls_agent_debug_save-parcel-fail.html"
    end

    return nil
  end

  private

  # Login to GLS parcel creation web page using provided credentials.
  # returns true if login and navigation afterwards succeeded.
  def login! username, password
    target_url = 'http://www.your-gls.eu/276-I-PORTAL-WEB/content/GLS/DE03/DE/15005.htm'
    page = @mech.get target_url
    form = page.forms.first
    form.fields[5].value = username
    form.fields[6].value = password
    form.submit
    # Move on to target page.
    page = @mech.get target_url
    page.uri.to_s == target_url
  end
end
