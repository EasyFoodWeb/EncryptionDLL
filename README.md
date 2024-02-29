# Schwind_Library
An DLL Library for cryptographic operations. Built in Delphi RAD-Studio 11. This also includes DUnit Tests for each cryptographic operation.

This is built for symmetric cryptography but can be extended for asymmetric cryptography operations. It is available for both text and file byte encryption/decryption.

Cryptographic operations currently available through linked library:
* File Encryption
* File Decryption
* Text Encryption
* Text Decryption
* Base64 Encoding
* Base64 Decoding

All above operations goes through a basic set of validation rules, failing any would render operation call result in predefined exception.

Validation Rules:
* SourceFile Validation - Source file and its text is checked for availibility & size.
* DestinationFile Validation - Destination file path is checked for availibility, if not found, source file name is used with apending '-Encrypt'.
* SecretKey Validation - Secret key for symmetric operation is checked for availibility & size of either 16, 24, or 32 characters.

Exceptions:
          Exception would result as an integer that could be mapped to specific exception message. There is a predefined set of exceptions that is further categorized based on the type of validation. A file will be provided including those exceptions list. 

DUnit Test:
            A DUnit Test Framework has also been developed for library external operations. This is a GUI Framework to show test selections and results on form based window. This framework includes tests for each external operation that is run on predefined inputs against benchmarked outputs that include both success or failure response. 

Either all or specific unit tests could be selected.



