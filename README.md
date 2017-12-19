# List-Unsubscribe MailMate Bundle

MailMate Bundle to unsubscribe from mailing lists that expose a `List-Unsubscribe` header


First looks for a `mailto:` URI in the `List-Unsubscribe` header. If found will automatically send an unsubscribe email to that address.

Next looks for a `http` URI in the `List-Unsubscribe` header. If found will open that URI in the default web browser.
