# frozen_string_literal: true

# Temporary site-level fix for al_cookie 1.0.0. Its consent callback treats the
# CookieConsent callback payload as a category map, so GA4 remains denied after
# visitors accept analytics. Remove this when the upstream plugin is fixed.
module AnalyticsConsentFix
  FIRST_CONSENT_CALLBACK = "onFirstConsent: function (consentData) {"
  CATEGORY_LOOKUP = "var categories = consentData.categories || consentData;"

  module_function

  def apply(rendered)
    return rendered unless rendered&.include?(FIRST_CONSENT_CALLBACK)
    return rendered unless rendered.include?(CATEGORY_LOOKUP)

    rendered
      .sub(FIRST_CONSENT_CALLBACK, "onConsent: function (consentData) {")
      .sub(CATEGORY_LOOKUP, 'var categories = { analytics: window.CookieConsent.acceptedCategory("analytics") };')
  end
end

Jekyll::Hooks.register :site, :post_render do |site|
  items = site.pages + site.collections.values.flat_map(&:docs)
  items.each do |item|
    fixed_output = AnalyticsConsentFix.apply(item.output)
    item.output = fixed_output unless fixed_output.equal?(item.output)
  end
end
