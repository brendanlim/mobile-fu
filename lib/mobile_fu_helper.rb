module MobileFuHelper
  def mobile_xhtml_doctype
    "<!DOCTYPE html PUBLIC \"-//WAPFORUM//DTD XHTML Mobile 1.0//EN\" \"http://www.wapforum.org/DTD/xhtml-mobile10.dtd\">"
  end
  
  def js_enabled_mobile_device?
    is_device?('iphone') || is_device?('mobileexplorer') || is_device?('android')
  end
end