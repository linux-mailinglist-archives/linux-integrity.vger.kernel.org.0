Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4538116A93
	for <lists+linux-integrity@lfdr.de>; Mon,  9 Dec 2019 11:09:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbfLIKJq (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 9 Dec 2019 05:09:46 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:40734 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726351AbfLIKJp (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 9 Dec 2019 05:09:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Mime-Version:Content-Type:References:
        In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=l15eZ/h0f6ooXptsApCbaVxRmx7fi01LtB9Ln/k7yME=; b=lmh0il1QgE43hIhU7AXGhlRcB
        NpPBca6o5vPjKsaSQrMmPU8FvVX6iKrYy7yLC6Fc9FwpN2xMjbMaia77Nlm4sI94OzcLDcWHtcjG/
        mvtLnIzkttjeNl2iJwBCZeKc671+t2ndfFQjLYO7rNgLODHbrEY5+QRb4oTCDowlydbfGCbV6AB7S
        n35cBjChNngKAnAnS8kUi+s/GY1rP0dPVNlUz+Tv43F5KyqaEg4saKtbjXh7iP/3WlGs3gYtZq5Bs
        W0KCaAqyv2sNlU5hX+MQ4KDFHRAv2px/+DeRnFEyZYCi95JGGMuwzNH+naXIqT6BEYwELrHWS+IXZ
        IIxsRg3Ng==;
Received: from 54-240-197-228.amazon.com ([54.240.197.228] helo=freeip.amazon.com)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ieFz7-0001pm-8s; Mon, 09 Dec 2019 10:09:45 +0000
Message-ID: <6fa42aee37f8207c7dcb037615b87cc02b708ec4.camel@infradead.org>
Subject: Re: [PATCH 5/8] security: keys: trusted: Make sealed key properly
 interoperable
From:   David Woodhouse <dwmw2@infradead.org>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date:   Mon, 09 Dec 2019 10:09:43 +0000
In-Reply-To: <1575781888.14069.14.camel@HansenPartnership.com>
References: <1575781600.14069.8.camel@HansenPartnership.com>
         <1575781888.14069.14.camel@HansenPartnership.com>
Content-Type: multipart/signed; micalg="sha-256";
        protocol="application/x-pkcs7-signature";
        boundary="=-szUFQSGF2y696U7mB2xx"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


--=-szUFQSGF2y696U7mB2xx
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 2019-12-07 at 21:11 -0800, James Bottomley wrote:
> The current implementation appends a migratable flag to the end of a
> key, meaning the format isn't exactly interoperable because the using
> party needs to know to strip this extra byte.  However, all other
> consumers of TPM sealed blobs expect the unseal to return exactly the
> key.  Since TPM2 keys have a key property flag that corresponds to
> migratable, use that flag instead and make the actual key the only
> sealed quantity.  This is secure because the key properties are bound
> to a hash in the private part, so if they're altered the key won't
> load.
>=20
> Backwards compatibility is implemented by detecting whether we're
> loading a new format key or not and correctly setting migratable from
> the last byte of old format keys.
>=20
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> ---
>  include/keys/trusted-type.h               |  1 +
>  include/linux/tpm.h                       |  2 ++
>  security/keys/trusted-keys/trusted_tpm2.c | 57 ++++++++++++++++++++++---=
------
>  3 files changed, 44 insertions(+), 16 deletions(-)
>=20
> diff --git a/include/keys/trusted-type.h b/include/keys/trusted-type.h
> index a94c03a61d8f..4728e13aada8 100644
> --- a/include/keys/trusted-type.h
> +++ b/include/keys/trusted-type.h
> @@ -22,6 +22,7 @@ struct trusted_key_payload {
>  	unsigned int key_len;
>  	unsigned int blob_len;
>  	unsigned char migratable;
> +	unsigned char old_format;
>  	unsigned char key[MAX_KEY_SIZE + 1];
>  	unsigned char blob[MAX_BLOB_SIZE];
>  };
> diff --git a/include/linux/tpm.h b/include/linux/tpm.h
> index 03e9b184411b..cd46ab27baa5 100644
> --- a/include/linux/tpm.h
> +++ b/include/linux/tpm.h
> @@ -297,6 +297,8 @@ struct tpm_buf {
>  };
> =20
>  enum tpm2_object_attributes {
> +	TPM2_OA_FIXED_TPM		=3D BIT(1),
> +	TPM2_OA_FIXED_PARENT		=3D BIT(4),
>  	TPM2_OA_USER_WITH_AUTH		=3D BIT(6),
>  };
> =20
> diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/tr=
usted-keys/trusted_tpm2.c
> index 4efc7b64d1cd..a34ab6f90f76 100644
> --- a/security/keys/trusted-keys/trusted_tpm2.c
> +++ b/security/keys/trusted-keys/trusted_tpm2.c
> @@ -207,6 +207,7 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
>  	unsigned int blob_len;
>  	struct tpm_buf buf;
>  	u32 hash;
> +	u32 flags;
>  	int i;
>  	int rc;
> =20
> @@ -235,29 +236,30 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
>  			     TPM_DIGEST_SIZE);
> =20
>  	/* sensitive */
> -	tpm_buf_append_u16(&buf, 4 + TPM_DIGEST_SIZE + payload->key_len + 1);
> +	tpm_buf_append_u16(&buf, 4 + TPM_DIGEST_SIZE + payload->key_len);
> =20
>  	tpm_buf_append_u16(&buf, TPM_DIGEST_SIZE);
>  	tpm_buf_append(&buf, options->blobauth, TPM_DIGEST_SIZE);
> -	tpm_buf_append_u16(&buf, payload->key_len + 1);
> +	tpm_buf_append_u16(&buf, payload->key_len);
>  	tpm_buf_append(&buf, payload->key, payload->key_len);
> -	tpm_buf_append_u8(&buf, payload->migratable);
> =20
>  	/* public */
>  	tpm_buf_append_u16(&buf, 14 + options->policydigest_len);
>  	tpm_buf_append_u16(&buf, TPM_ALG_KEYEDHASH);
>  	tpm_buf_append_u16(&buf, hash);
> =20
> +	/* key properties */
> +	flags =3D 0;
> +	flags |=3D options->policydigest_len ? 0 : TPM2_OA_USER_WITH_AUTH;
> +	flags |=3D payload->migratable ? (TPM2_OA_FIXED_TPM |
> +					TPM2_OA_FIXED_PARENT) : 0;
> +	tpm_buf_append_u32(&buf, flags);
> +
>  	/* policy */
> -	if (options->policydigest_len) {
> -		tpm_buf_append_u32(&buf, 0);
> -		tpm_buf_append_u16(&buf, options->policydigest_len);
> +	tpm_buf_append_u16(&buf, options->policydigest_len);
> +	if (options->policydigest_len)
>  		tpm_buf_append(&buf, options->policydigest,
>  			       options->policydigest_len);
> -	} else {
> -		tpm_buf_append_u32(&buf, TPM2_OA_USER_WITH_AUTH);
> -		tpm_buf_append_u16(&buf, 0);
> -	}
> =20
>  	/* public parameters */
>  	tpm_buf_append_u16(&buf, TPM_ALG_NULL);
> @@ -330,13 +332,16 @@ static int tpm2_load_cmd(struct tpm_chip *chip,
>  	unsigned int private_len;
>  	unsigned int public_len;
>  	unsigned int blob_len;
> -	u8 *blob;
> +	u8 *blob, *pub;
>  	int rc;
> +	u32 attrs;
> =20
>  	rc =3D tpm2_key_decode(payload, options, &blob);
> -	if (rc)
> +	if (rc) {
>  		/* old form */
>  		blob =3D payload->blob;
> +		payload->old_format =3D 1;
> +	}
> =20
>  	/* new format carries keyhandle but old format doesn't */
>  	if (!options->keyhandle)
> @@ -347,6 +352,16 @@ static int tpm2_load_cmd(struct tpm_chip *chip,
>  		return -E2BIG;
> =20
>  	public_len =3D be16_to_cpup((__be16 *) &blob[2 + private_len]);
> +
> +	pub =3D blob + 2 + private_len + 2;
> +	/* key attributes are always at offset 4 */
> +	attrs =3D get_unaligned_be32(pub + 4);


At this point I don't believe you've checked yet that payload->blob_len=20
is sufficient to know that these bytes exist.

I think you're reading 'private_len' from non-existent bytes too, if
payload->blob_len is zero or one? Which I think was there before you
started, but you touched it last...


> +	if ((attrs & (TPM2_OA_FIXED_TPM | TPM2_OA_FIXED_PARENT)) =3D=3D
> +	    (TPM2_OA_FIXED_TPM | TPM2_OA_FIXED_PARENT))
> +		payload->migratable =3D 0;
> +	else
> +		payload->migratable =3D 1;
> +
>  	blob_len =3D private_len + public_len + 4;
>  	if (blob_len > payload->blob_len)
>  		return -E2BIG;
> @@ -427,7 +442,7 @@ static int tpm2_unseal_cmd(struct tpm_chip *chip,
>  	if (!rc) {
>  		data_len =3D be16_to_cpup(
>  			(__be16 *) &buf.data[TPM_HEADER_SIZE + 4]);
> -		if (data_len < MIN_KEY_SIZE ||  data_len > MAX_KEY_SIZE + 1) {
> +		if (data_len < MIN_KEY_SIZE ||  data_len > MAX_KEY_SIZE) {
>  			rc =3D -EFAULT;
>  			goto out;
>  		}
> @@ -438,9 +453,19 @@ static int tpm2_unseal_cmd(struct tpm_chip *chip,
>  		}
>  		data =3D &buf.data[TPM_HEADER_SIZE + 6];
> =20
> -		memcpy(payload->key, data, data_len - 1);
> -		payload->key_len =3D data_len - 1;
> -		payload->migratable =3D data[data_len - 1];
> +		if (payload->old_format) {
> +			/* migratable flag is at the end of the key */
> +			memcpy(payload->key, data, data_len - 1);
> +			payload->key_len =3D data_len - 1;
> +			payload->migratable =3D data[data_len - 1];
> +		} else {
> +			/*
> +			 * migratable flag already collected from key
> +			 * attributes
> +			 */
> +			memcpy(payload->key, data, data_len);
> +			payload->key_len =3D data_len;
> +		}
>  	}
> =20
>  out:


--=-szUFQSGF2y696U7mB2xx
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCCECow
ggUcMIIEBKADAgECAhEA4rtJSHkq7AnpxKUY8ZlYZjANBgkqhkiG9w0BAQsFADCBlzELMAkGA1UE
BhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEaMBgG
A1UEChMRQ09NT0RPIENBIExpbWl0ZWQxPTA7BgNVBAMTNENPTU9ETyBSU0EgQ2xpZW50IEF1dGhl
bnRpY2F0aW9uIGFuZCBTZWN1cmUgRW1haWwgQ0EwHhcNMTkwMTAyMDAwMDAwWhcNMjIwMTAxMjM1
OTU5WjAkMSIwIAYJKoZIhvcNAQkBFhNkd213MkBpbmZyYWRlYWQub3JnMIIBIjANBgkqhkiG9w0B
AQEFAAOCAQ8AMIIBCgKCAQEAsv3wObLTCbUA7GJqKj9vHGf+Fa+tpkO+ZRVve9EpNsMsfXhvFpb8
RgL8vD+L133wK6csYoDU7zKiAo92FMUWaY1Hy6HqvVr9oevfTV3xhB5rQO1RHJoAfkvhy+wpjo7Q
cXuzkOpibq2YurVStHAiGqAOMGMXhcVGqPuGhcVcVzVUjsvEzAV9Po9K2rpZ52FE4rDkpDK1pBK+
uOAyOkgIg/cD8Kugav5tyapydeWMZRJQH1vMQ6OVT24CyAn2yXm2NgTQMS1mpzStP2ioPtTnszIQ
Ih7ASVzhV6csHb8Yrkx8mgllOyrt9Y2kWRRJFm/FPRNEurOeNV6lnYAXOymVJwIDAQABo4IB0zCC
Ac8wHwYDVR0jBBgwFoAUgq9sjPjF/pZhfOgfPStxSF7Ei8AwHQYDVR0OBBYEFLfuNf820LvaT4AK
xrGK3EKx1DE7MA4GA1UdDwEB/wQEAwIFoDAMBgNVHRMBAf8EAjAAMB0GA1UdJQQWMBQGCCsGAQUF
BwMEBggrBgEFBQcDAjBGBgNVHSAEPzA9MDsGDCsGAQQBsjEBAgEDBTArMCkGCCsGAQUFBwIBFh1o
dHRwczovL3NlY3VyZS5jb21vZG8ubmV0L0NQUzBaBgNVHR8EUzBRME+gTaBLhklodHRwOi8vY3Js
LmNvbW9kb2NhLmNvbS9DT01PRE9SU0FDbGllbnRBdXRoZW50aWNhdGlvbmFuZFNlY3VyZUVtYWls
Q0EuY3JsMIGLBggrBgEFBQcBAQR/MH0wVQYIKwYBBQUHMAKGSWh0dHA6Ly9jcnQuY29tb2RvY2Eu
Y29tL0NPTU9ET1JTQUNsaWVudEF1dGhlbnRpY2F0aW9uYW5kU2VjdXJlRW1haWxDQS5jcnQwJAYI
KwYBBQUHMAGGGGh0dHA6Ly9vY3NwLmNvbW9kb2NhLmNvbTAeBgNVHREEFzAVgRNkd213MkBpbmZy
YWRlYWQub3JnMA0GCSqGSIb3DQEBCwUAA4IBAQALbSykFusvvVkSIWttcEeifOGGKs7Wx2f5f45b
nv2ghcxK5URjUvCnJhg+soxOMoQLG6+nbhzzb2rLTdRVGbvjZH0fOOzq0LShq0EXsqnJbbuwJhK+
PnBtqX5O23PMHutP1l88AtVN+Rb72oSvnD+dK6708JqqUx2MAFLMevrhJRXLjKb2Mm+/8XBpEw+B
7DisN4TMlLB/d55WnT9UPNHmQ+3KFL7QrTO8hYExkU849g58Dn3Nw3oCbMUgny81ocrLlB2Z5fFG
Qu1AdNiBA+kg/UxzyJZpFbKfCITd5yX49bOriL692aMVDyqUvh8fP+T99PqorH4cIJP6OxSTdxKM
MIIFHDCCBASgAwIBAgIRAOK7SUh5KuwJ6cSlGPGZWGYwDQYJKoZIhvcNAQELBQAwgZcxCzAJBgNV
BAYTAkdCMRswGQYDVQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGjAY
BgNVBAoTEUNPTU9ETyBDQSBMaW1pdGVkMT0wOwYDVQQDEzRDT01PRE8gUlNBIENsaWVudCBBdXRo
ZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBMB4XDTE5MDEwMjAwMDAwMFoXDTIyMDEwMTIz
NTk1OVowJDEiMCAGCSqGSIb3DQEJARYTZHdtdzJAaW5mcmFkZWFkLm9yZzCCASIwDQYJKoZIhvcN
AQEBBQADggEPADCCAQoCggEBALL98Dmy0wm1AOxiaio/bxxn/hWvraZDvmUVb3vRKTbDLH14bxaW
/EYC/Lw/i9d98CunLGKA1O8yogKPdhTFFmmNR8uh6r1a/aHr301d8YQea0DtURyaAH5L4cvsKY6O
0HF7s5DqYm6tmLq1UrRwIhqgDjBjF4XFRqj7hoXFXFc1VI7LxMwFfT6PStq6WedhROKw5KQytaQS
vrjgMjpICIP3A/CroGr+bcmqcnXljGUSUB9bzEOjlU9uAsgJ9sl5tjYE0DEtZqc0rT9oqD7U57My
ECIewElc4VenLB2/GK5MfJoJZTsq7fWNpFkUSRZvxT0TRLqznjVepZ2AFzsplScCAwEAAaOCAdMw
ggHPMB8GA1UdIwQYMBaAFIKvbIz4xf6WYXzoHz0rcUhexIvAMB0GA1UdDgQWBBS37jX/NtC72k+A
CsaxitxCsdQxOzAOBgNVHQ8BAf8EBAMCBaAwDAYDVR0TAQH/BAIwADAdBgNVHSUEFjAUBggrBgEF
BQcDBAYIKwYBBQUHAwIwRgYDVR0gBD8wPTA7BgwrBgEEAbIxAQIBAwUwKzApBggrBgEFBQcCARYd
aHR0cHM6Ly9zZWN1cmUuY29tb2RvLm5ldC9DUFMwWgYDVR0fBFMwUTBPoE2gS4ZJaHR0cDovL2Ny
bC5jb21vZG9jYS5jb20vQ09NT0RPUlNBQ2xpZW50QXV0aGVudGljYXRpb25hbmRTZWN1cmVFbWFp
bENBLmNybDCBiwYIKwYBBQUHAQEEfzB9MFUGCCsGAQUFBzAChklodHRwOi8vY3J0LmNvbW9kb2Nh
LmNvbS9DT01PRE9SU0FDbGllbnRBdXRoZW50aWNhdGlvbmFuZFNlY3VyZUVtYWlsQ0EuY3J0MCQG
CCsGAQUFBzABhhhodHRwOi8vb2NzcC5jb21vZG9jYS5jb20wHgYDVR0RBBcwFYETZHdtdzJAaW5m
cmFkZWFkLm9yZzANBgkqhkiG9w0BAQsFAAOCAQEAC20spBbrL71ZEiFrbXBHonzhhirO1sdn+X+O
W579oIXMSuVEY1LwpyYYPrKMTjKECxuvp24c829qy03UVRm742R9Hzjs6tC0oatBF7KpyW27sCYS
vj5wbal+TttzzB7rT9ZfPALVTfkW+9qEr5w/nSuu9PCaqlMdjABSzHr64SUVy4ym9jJvv/FwaRMP
gew4rDeEzJSwf3eeVp0/VDzR5kPtyhS+0K0zvIWBMZFPOPYOfA59zcN6AmzFIJ8vNaHKy5QdmeXx
RkLtQHTYgQPpIP1Mc8iWaRWynwiE3ecl+PWzq4i+vdmjFQ8qlL4fHz/k/fT6qKx+HCCT+jsUk3cS
jDCCBeYwggPOoAMCAQICEGqb4Tg7/ytrnwHV2binUlYwDQYJKoZIhvcNAQEMBQAwgYUxCzAJBgNV
BAYTAkdCMRswGQYDVQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGjAY
BgNVBAoTEUNPTU9ETyBDQSBMaW1pdGVkMSswKQYDVQQDEyJDT01PRE8gUlNBIENlcnRpZmljYXRp
b24gQXV0aG9yaXR5MB4XDTEzMDExMDAwMDAwMFoXDTI4MDEwOTIzNTk1OVowgZcxCzAJBgNVBAYT
AkdCMRswGQYDVQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGjAYBgNV
BAoTEUNPTU9ETyBDQSBMaW1pdGVkMT0wOwYDVQQDEzRDT01PRE8gUlNBIENsaWVudCBBdXRoZW50
aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKC
AQEAvrOeV6wodnVAFsc4A5jTxhh2IVDzJXkLTLWg0X06WD6cpzEup/Y0dtmEatrQPTRI5Or1u6zf
+bGBSyD9aH95dDSmeny1nxdlYCeXIoymMv6pQHJGNcIDpFDIMypVpVSRsivlJTRENf+RKwrB6vcf
WlP8dSsE3Rfywq09N0ZfxcBa39V0wsGtkGWC+eQKiz4pBZYKjrc5NOpG9qrxpZxyb4o4yNNwTqza
aPpGRqXB7IMjtf7tTmU2jqPMLxFNe1VXj9XB1rHvbRikw8lBoNoSWY66nJN/VCJv5ym6Q0mdCbDK
CMPybTjoNCQuelc0IAaO4nLUXk0BOSxSxt8kCvsUtQIDAQABo4IBPDCCATgwHwYDVR0jBBgwFoAU
u69+Aj36pvE8hI6t7jiY7NkyMtQwHQYDVR0OBBYEFIKvbIz4xf6WYXzoHz0rcUhexIvAMA4GA1Ud
DwEB/wQEAwIBhjASBgNVHRMBAf8ECDAGAQH/AgEAMBEGA1UdIAQKMAgwBgYEVR0gADBMBgNVHR8E
RTBDMEGgP6A9hjtodHRwOi8vY3JsLmNvbW9kb2NhLmNvbS9DT01PRE9SU0FDZXJ0aWZpY2F0aW9u
QXV0aG9yaXR5LmNybDBxBggrBgEFBQcBAQRlMGMwOwYIKwYBBQUHMAKGL2h0dHA6Ly9jcnQuY29t
b2RvY2EuY29tL0NPTU9ET1JTQUFkZFRydXN0Q0EuY3J0MCQGCCsGAQUFBzABhhhodHRwOi8vb2Nz
cC5jb21vZG9jYS5jb20wDQYJKoZIhvcNAQEMBQADggIBAHhcsoEoNE887l9Wzp+XVuyPomsX9vP2
SQgG1NgvNc3fQP7TcePo7EIMERoh42awGGsma65u/ITse2hKZHzT0CBxhuhb6txM1n/y78e/4ZOs
0j8CGpfb+SJA3GaBQ+394k+z3ZByWPQedXLL1OdK8aRINTsjk/H5Ns77zwbjOKkDamxlpZ4TKSDM
KVmU/PUWNMKSTvtlenlxBhh7ETrN543j/Q6qqgCWgWuMAXijnRglp9fyadqGOncjZjaaSOGTTFB+
E2pvOUtY+hPebuPtTbq7vODqzCM6ryEhNhzf+enm0zlpXK7q332nXttNtjv7VFNYG+I31gnMrwfH
M5tdhYF/8v5UY5g2xANPECTQdu9vWPoqNSGDt87b3gXb1AiGGaI06vzgkejL580ul+9hz9D0S0U4
jkhJiA7EuTecP/CFtR72uYRBcunwwH3fciPjviDDAI9SnC/2aPY8ydehzuZutLbZdRJ5PDEJM/1t
yZR2niOYihZ+FCbtf3D9mB12D4ln9icgc7CwaxpNSCPt8i/GqK2HsOgkL3VYnwtx7cJUmpvVdZ4o
gnzgXtgtdk3ShrtOS1iAN2ZBXFiRmjVzmehoMof06r1xub+85hFQzVxZx5/bRaTKTlL8YXLI8nAb
R9HWdFqzcOoB/hxfEyIQpx9/s81rgzdEZOofSlZHynoSMYIDyjCCA8YCAQEwga0wgZcxCzAJBgNV
BAYTAkdCMRswGQYDVQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGjAY
BgNVBAoTEUNPTU9ETyBDQSBMaW1pdGVkMT0wOwYDVQQDEzRDT01PRE8gUlNBIENsaWVudCBBdXRo
ZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBAhEA4rtJSHkq7AnpxKUY8ZlYZjANBglghkgB
ZQMEAgEFAKCCAe0wGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMTkx
MjA5MTAwOTQzWjAvBgkqhkiG9w0BCQQxIgQgMj5MGyz5DQNDBikQ9lwD4CYBrNDPR0BahBp/4KlE
/ZMwgb4GCSsGAQQBgjcQBDGBsDCBrTCBlzELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIg
TWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEaMBgGA1UEChMRQ09NT0RPIENBIExpbWl0ZWQx
PTA7BgNVBAMTNENPTU9ETyBSU0EgQ2xpZW50IEF1dGhlbnRpY2F0aW9uIGFuZCBTZWN1cmUgRW1h
aWwgQ0ECEQDiu0lIeSrsCenEpRjxmVhmMIHABgsqhkiG9w0BCRACCzGBsKCBrTCBlzELMAkGA1UE
BhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEaMBgG
A1UEChMRQ09NT0RPIENBIExpbWl0ZWQxPTA7BgNVBAMTNENPTU9ETyBSU0EgQ2xpZW50IEF1dGhl
bnRpY2F0aW9uIGFuZCBTZWN1cmUgRW1haWwgQ0ECEQDiu0lIeSrsCenEpRjxmVhmMA0GCSqGSIb3
DQEBAQUABIIBABaygqjpkz2ZppDaohQYw3EKLWFGy5nL7dkAvWfEbALVHq6/0bddrArE8Ko2bS/h
fYXA7v3mEesJlfIqQv85dR8KyIx6DA1W0mOvmXKas3koH9Xyo8Mf2fAiBohULzKel7OwrR/hPR8T
JvOjPo3cDeEKMShTX9Brz8Pf6rGjU2V7N7wbGWF+vFM7Uank5feWq5EcAmNXglapUJ5yHuDN1HwC
FRs+Z/dwGlKkzl55ebr4nqH7P2nN/6xKvdcmNGVd1EJVu1ECUOwiG6SJY+Zf2tye6n/4v5brlJHi
0sa1T0rt59BYvY+XLyMzZXE3j30R+bEdA/AwTUqHl5q6VQeYkTcAAAAAAAA=


--=-szUFQSGF2y696U7mB2xx--

