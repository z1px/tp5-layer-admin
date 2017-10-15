# PHPMailer Change Log

## Version 6.0
This is a major update that breaks backwards compatibility.

* **Requires PHP 5.5 or later**
* Uses the `PHPMailer\PHPMailer` namespace
* File structure simplified, classes live in the `src/` folder
* The custom autoloader has been removed, now PSR-4 compatible: [**use composer**](https://getcomposer.org)!
* Classes & Exceptions renamed to make use of the namespace
* Most statically called functions now use the `static` keyword instead of `self`, so it's possible to override static internal functions in subclasses, for example `validateAddress()`
* `Extras` classes have been removed - use packages from [packagist.org](https://packagist.org) instead
* All elements previously marked as deprecated have been removed:
  * `PHPMailer->Version`
  * `PHPMailer->ReturnPath`
  * `PHPMailer->PluginDir`
  * `PHPMailer->encodeQPphp()`
  * `SMTP->CRLF`
  * `SMTP->Version`
  * `SMTP->SMTP_PORT`
  * `POP3->CRLF`
  * `POP3->Version`
* NTLM authentication removed - never worked anyway!
  * `PHPMailer->Workstation`
  * `PHPMailer->Realm`
* `SMTP::authenticate` method signature changed
* `parseAddresses()` is now static
* `validateAddress()` is now called statically from `parseAddresses()`
* `PHPMailer->SingleToArray` is now protected
* Extensive reworking of XOAUTH2, adding support for Google, Yahoo and Microsoft providers, thanks to @sherryl4george
* Major cleanup of docs and examples

## Version 5.2.15 (May 10th 2016)
* Added ability to inject custom address validators, and set the default validator
* Fix TLS 1.2 compatibility
* Remove some excess line breaks in MIME structure
* Updated Polish, Russian, Brazilian Portuguese, Georgian translations
* More DRY!
* Improve error messages
* Update dependencies
* Add example showing how to handle multiple form file uploads
* Improve SMTP example
* Improve Windows compatibility
* Use consistent names for temp files
* Fix gmail XOAUTH2 scope, thanks to @sherryl4george
* Fix extra line break in getSentMIMEMessage()
* Improve DKIM signing to use SHA-2

## Version 5.2.14 (Nov 1st 2015)
* Allow addresses with IDN (Internationalized Domain Name) in PHP 5.3+, thanks to @fbonzon
* Allow access to POP3 errors
* Make all POP3 private properties and methods protected
* **SECURITY** Fix vulnerability that allowed email addresses with line breaks (valid in RFC5322) to pass to SMTP, permitting message injection at the SMTP level. Mitigated in both the address validator and in the lower-level SMTP class. Thanks to Takeshi Terada.
* Updated Brazilian Portuguese translations (Thanks to @phelipealves)

## Version 5.2.13 (Sep 14th 2015)
* Rename internal oauth class to avoid name clashes
* Improve Estonian translations

## Version 5.2.12 (Sep 1st 2015)
* Fix incorrect composer package dependencies
* Skip existing embedded image `cid`s in `msgHTML`

## Version 5.2.11 (Aug 31st 2015)
* Don't switch to quoted-printable for long lines if already using base64
* Fixed Travis-CI config when run on PHP 7
* Added Google XOAUTH2 authentication mechanism, thanks to @sherryl4george
* Add address parser for RFC822-format addresses
* Update MS Office MIME types
* Don't convert line breaks when using quoted-printable encoding
* Handle MS Exchange returning an invalid empty AUTH-type list in EHLO
* Don't set name or filename properties on MIME parts that don't have one

## Version 5.2.10 (May 4th 2015)
* Add custom header getter
* Use `application/javascript` for .js attachments
* Improve RFC2821 compliance for timelimits, especially for end-of-data
* Add Azerbaijani translations (Thanks to @mirjalal)
* Minor code cleanup for robustness
* Add Indonesian translations (Thanks to @ceceprawiro)
* Avoid `error_log` Debugoutput naming clash
* Add ability to parse server capabilities in response to EHLO (useful for SendGrid etc)
* Amended default values for WordWrap to match RFC
* Remove html2text converter class (has incompatible license)
* Provide new mechanism for injecting html to text converters
* Improve pointers to docs and support in README
* Add example file upload script
* Refactor and major cleanup of EasyPeasyICS, now a lot more usable
* Make set() method simpler and more reliable
* Add Malay translation (Thanks to @nawawi)
* Add Bulgarian translation (Thanks to @mialy)
* Add Armenian translation (Thanks to Hrayr Grigoryan)
* Add Slovenian translation (Thanks to Klemen Tu