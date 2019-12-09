Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED914116A7E
	for <lists+linux-integrity@lfdr.de>; Mon,  9 Dec 2019 11:04:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727249AbfLIKEy (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 9 Dec 2019 05:04:54 -0500
Received: from merlin.infradead.org ([205.233.59.134]:57232 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727060AbfLIKEy (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 9 Dec 2019 05:04:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Mime-Version:Content-Type:References:
        In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=SMuiV3/yROalRziGR2DntMNkUKqi5eUF3k8CCj+Nfe8=; b=aBvW6s/fCFUVKDu1Xic3fwtk6
        y4grlL5MO/miAa6oxvDXuVwFpPBfodDUuvoyiJQ37j2a+p5Njp3uKp/GLh36/Lt5nfaFhSajEKNUS
        jvmjdMI+f7Bg58dNg0hoJCN8F0gMB8Om6CO8AgN4e8FMMy7jq+sy9EcekPNu8IC1rYO/jqdgV48gv
        vF8RYsiWlsIpf87IvvX/kXZT1sckEbfkPXuEQnAg9WcJLlvWemMzyGKAgd0QFLNRCCvcJ2FNli+9d
        G/+lWEg9PavwA+keYSyEOADIxxc22VPxLRIijuV/WI3mBIQT3rO56TKEdKVLslAKFIygxrbVll1wB
        +g5+IivsA==;
Received: from 54-240-197-228.amazon.com ([54.240.197.228] helo=freeip.amazon.com)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ieFuK-0006vz-Rb; Mon, 09 Dec 2019 10:04:49 +0000
Message-ID: <3b035027b934eb253143dca66ebae4356b386efe.camel@infradead.org>
Subject: Re: [PATCH 4/8] security: keys: trusted: use ASN.1 tpm2 key format
 for the blobs
From:   David Woodhouse <dwmw2@infradead.org>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-integrity@vger.kernel.org,
        David Howells <dhowells@redhat.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date:   Mon, 09 Dec 2019 10:04:45 +0000
In-Reply-To: <1575781831.14069.13.camel@HansenPartnership.com>
References: <1575781600.14069.8.camel@HansenPartnership.com>
         <1575781831.14069.13.camel@HansenPartnership.com>
Content-Type: multipart/signed; micalg="sha-256";
        protocol="application/x-pkcs7-signature";
        boundary="=-jOQsVIbnyjHJ35ZY96La"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by merlin.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


--=-jOQsVIbnyjHJ35ZY96La
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 2019-12-07 at 21:10 -0800, James Bottomley wrote:
> Modify the tpm2 key format blob output to export and import in the
> ASN.1 form for tpm2 sealed object keys.  For compatibility with prior
> trusted keys, the importer will also accept two tpm2b quantities
> representing the public and private parts of the key.  However, the
> export via keyctl pipe will only output the ASN.1 format.

You still have a tpm2_key_encode() function which spits out the raw
private/public blobs each prefixed with a length word. What's that
still used for?

> The benefit of the ASN.1 format is that it's a standard

We should probably make that true. Did we even get as far as writing up
an RFC-style description of the ASN.1?=20

>  and thus the
> exported key can be used by userspace tools.  The format includes
> policy specifications, thus it gets us out of having to construct
> policy handles in userspace and the format includes the parent meaning
> you don't have to keep passing it in each time.
>=20
> This patch only implements basic handling for the ASN.1 format, so
> keys with passwords but no policy.

... but doesn't bail out with an error when it sees something it
doesn't yet understand? Including the 'secret' field which is only
relevant for importable keys, etc.

> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> ---
>  security/keys/trusted-keys/Makefile       |   2 +-
>  security/keys/trusted-keys/tpm2key.asn1   |  23 ++++
>  security/keys/trusted-keys/trusted_tpm1.c |   2 +-
>  security/keys/trusted-keys/trusted_tpm2.c | 170 ++++++++++++++++++++++++=
+++++-
>  4 files changed, 190 insertions(+), 7 deletions(-)
>  create mode 100644 security/keys/trusted-keys/tpm2key.asn1
>=20
> diff --git a/security/keys/trusted-keys/Makefile b/security/keys/trusted-=
keys/Makefile
> index 7b73cebbb378..e0198641eff2 100644
> --- a/security/keys/trusted-keys/Makefile
> +++ b/security/keys/trusted-keys/Makefile
> @@ -5,4 +5,4 @@
> =20
>  obj-$(CONFIG_TRUSTED_KEYS) +=3D trusted.o
>  trusted-y +=3D trusted_tpm1.o
> -trusted-y +=3D trusted_tpm2.o
> +trusted-y +=3D trusted_tpm2.o tpm2key.asn1.o
> diff --git a/security/keys/trusted-keys/tpm2key.asn1 b/security/keys/trus=
ted-keys/tpm2key.asn1
> new file mode 100644
> index 000000000000..1851b7c80f08
> --- /dev/null
> +++ b/security/keys/trusted-keys/tpm2key.asn1
> @@ -0,0 +1,23 @@
> +---
> +--- Note: This isn't quite the definition in the standard
> +---       However, the Linux asn.1 parser doesn't understand
> +---       [2] EXPLICIT SEQUENCE OF OPTIONAL
> +---       So there's an extra intermediate TPMPolicySequence
> +---       definition to work around this

At the very least we should prod David with a pointy stick on that
topic, rather than quietly working around it.


> +
> +TPMKey ::=3D SEQUENCE {
> +	type		OBJECT IDENTIFIER ({tpmkey_type}),
> +	emptyAuth	[0] EXPLICIT BOOLEAN OPTIONAL,
> +	policy		[1] EXPLICIT TPMPolicySequence OPTIONAL,
> +	secret		[2] EXPLICIT OCTET STRING OPTIONAL,
> +	parent		INTEGER ({tpmkey_parent}),
> +	pubkey		OCTET STRING ({tpmkey_pub}),
> +	privkey		OCTET STRING ({tpmkey_priv})
> +	}
> +
> +TPMPolicySequence ::=3D SEQUENCE OF TPMPolicy
> +
> +TPMPolicy ::=3D SEQUENCE {
> +	commandCode		[0] EXPLICIT INTEGER,
> +	commandPolicy		[1] EXPLICIT OCTET STRING
> +	}
> diff --git a/security/keys/trusted-keys/trusted_tpm1.c b/security/keys/tr=
usted-keys/trusted_tpm1.c
> index d2c5ec1e040b..d744a0d1cb89 100644
> --- a/security/keys/trusted-keys/trusted_tpm1.c
> +++ b/security/keys/trusted-keys/trusted_tpm1.c
> @@ -991,7 +991,7 @@ static int trusted_instantiate(struct key *key,
>  		goto out;
>  	}
> =20
> -	if (!options->keyhandle) {
> +	if (!options->keyhandle && !tpm2) {
>  		ret =3D -EINVAL;
>  		goto out;
>  	}
> diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/tr=
usted-keys/trusted_tpm2.c
> index 08ec7f48f01d..4efc7b64d1cd 100644
> --- a/security/keys/trusted-keys/trusted_tpm2.c
> +++ b/security/keys/trusted-keys/trusted_tpm2.c
> @@ -4,6 +4,8 @@
>   * Copyright (C) 2014 Intel Corporation
>   */
> =20
> +#include <linux/asn1_encoder.h>
> +#include <linux/oid_registry.h>
>  #include <linux/string.h>
>  #include <linux/err.h>
>  #include <linux/tpm.h>
> @@ -12,6 +14,10 @@
>  #include <keys/trusted-type.h>
>  #include <keys/trusted_tpm.h>
> =20
> +#include <asm/unaligned.h>
> +
> +#include "tpm2key.asn1.h"
> +
>  static struct tpm2_hash tpm2_hash_map[] =3D {
>  	{HASH_ALGO_SHA1, TPM_ALG_SHA1},
>  	{HASH_ALGO_SHA256, TPM_ALG_SHA256},
> @@ -20,6 +26,141 @@ static struct tpm2_hash tpm2_hash_map[] =3D {
>  	{HASH_ALGO_SM3_256, TPM_ALG_SM3_256},
>  };
> =20
> +static u32 tpm2key_oid[] =3D { 2,23,133,10,1,5 };
> +
> +static int tpm2_key_encode(struct trusted_key_payload *payload,
> +			   struct trusted_key_options *options,
> +			   u8 *src, u32 len)
> +{
> +	u8 *scratch =3D kmalloc(PAGE_SIZE, GFP_KERNEL);
> +	u8 *work =3D scratch, *work1;
> +	u8 *priv, *pub;
> +	u16 priv_len, pub_len;
> +
> +	priv_len =3D get_unaligned_be16(src);
> +	src +=3D 2;
> +	priv =3D src;
> +	src +=3D priv_len;
> +	pub_len =3D get_unaligned_be16(src);
> +	src +=3D 2;
> +	pub =3D src;
> +
> +	if (!scratch)
> +		return -ENOMEM;
> +
> +	asn1_encode_oid(&work, tpm2key_oid, asn1_oid_len(tpm2key_oid));
> +	if (options->blobauth[0] =3D=3D 0) {
> +		unsigned char bool[3], *w =3D bool;
> +		/* tag 0 is emptyAuth */
> +		asn1_encode_boolean(&w, true);
> +		asn1_encode_tag(&work, 0, bool, w - bool);
> +	}
> +	asn1_encode_integer(&work, options->keyhandle);
> +	asn1_encode_octet_string(&work, pub, pub_len);
> +	asn1_encode_octet_string(&work, priv, priv_len);
> +
> +	work1 =3D payload->blob;
> +	asn1_encode_sequence(&work1, scratch, work - scratch);
> +
> +	return work1 - payload->blob;
> +}

I still don't like the lack of overflow protection here, one layer up
from the underlying encoding APIs I already commented on.


> +struct tpm2key_context {
> +	u32 parent;
> +	const u8 *pub;
> +	u32 pub_len;
> +	const u8 *priv;
> +	u32 priv_len;
> +};
> +
> +static int tpm2_key_decode(struct trusted_key_payload *payload,
> +			   struct trusted_key_options *options,
> +			   u8 **buf)
> +{
> +	int ret;
> +	struct tpm2key_context ctx;
> +	u8 *blob;
> +
> +	ret =3D asn1_ber_decoder(&tpm2key_decoder, &ctx, payload->blob,
> +			       payload->blob_len);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (ctx.priv_len + ctx.pub_len > MAX_BLOB_SIZE)
> +		return -EINVAL;
> +
> +	blob =3D kmalloc(ctx.priv_len + ctx.pub_len + 4, GFP_KERNEL);
> +	if (!blob)
> +		return -ENOMEM;
> +
> +	*buf =3D blob;
> +	options->keyhandle =3D ctx.parent;
> +	put_unaligned_be16(ctx.priv_len, blob);
> +	blob +=3D 2;
> +	memcpy(blob, ctx.priv, ctx.priv_len);
> +	blob +=3D ctx.priv_len;
> +	put_unaligned_be16(ctx.pub_len, blob);
> +	blob +=3D 2;
> +	memcpy(blob, ctx.pub, ctx.pub_len);
>=20

Hm, do we really have to create this legacy form here and pass it
around? Can't we change whatever consumes this?

> +	return 0;
> +}
> +
> +int tpmkey_parent(void *context, size_t hdrlen,
> +		  unsigned char tag,
> +		  const void *value, size_t vlen)
> +{
> +	struct tpm2key_context *ctx =3D context;
> +	const u8 *v =3D value;
> +	int i;
> +
> +	ctx->parent =3D 0;
> +	for (i =3D 0; i < vlen; i++) {
> +		ctx->parent <<=3D 8;
> +		ctx->parent |=3D v[i];
> +	}
> +	return 0;
> +}
> +
> +int tpmkey_type(void *context, size_t hdrlen,
> +		unsigned char tag,
> +		const void *value, size_t vlen)
> +{
> +	enum OID oid =3D look_up_OID(value, vlen);
> +
> +	if (oid !=3D OID_TPMSealedData) {
> +		char buffer[50];
> +
> +		sprint_oid(value, vlen, buffer, sizeof(buffer));
> +		pr_debug("OID is \"%s\" which is not TPMSealedData\n",
> +			 buffer);
> +		return -EINVAL;
> +	}
> +	return 0;
> +}
> +
> +int tpmkey_pub(void *context, size_t hdrlen,
> +	       unsigned char tag,
> +	       const void *value, size_t vlen)
> +{
> +	struct tpm2key_context *ctx =3D context;
> +
> +	ctx->pub =3D value;
> +	ctx->pub_len =3D vlen;
> +	return 0;
> +}
> +
> +int tpmkey_priv(void *context, size_t hdrlen,
> +		unsigned char tag,
> +		const void *value, size_t vlen)
> +{
> +	struct tpm2key_context *ctx =3D context;
> +
> +	ctx->priv =3D value;
> +	ctx->priv_len =3D vlen;
> +	return 0;
> +}
> +
>  /**
>   * tpm_buf_append_auth() - append TPMS_AUTH_COMMAND to the buffer.
>   *
> @@ -79,6 +220,9 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
>  	if (i =3D=3D ARRAY_SIZE(tpm2_hash_map))
>  		return -EINVAL;
> =20
> +	if (!options->keyhandle)
> +		return -EINVAL;
> +
>  	rc =3D tpm_buf_init(&buf, TPM2_ST_SESSIONS, TPM2_CC_CREATE);
>  	if (rc)
>  		return rc;
> @@ -144,8 +288,10 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
>  		goto out;
>  	}
> =20
> -	memcpy(payload->blob, &buf.data[TPM_HEADER_SIZE + 4], blob_len);
> -	payload->blob_len =3D blob_len;
> +	payload->blob_len =3D
> +		tpm2_key_encode(payload, options,
> +				&buf.data[TPM_HEADER_SIZE + 4],
> +				blob_len);
> =20
>  out:
>  	tpm_buf_destroy(&buf);
> @@ -156,6 +302,8 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
>  		else
>  			rc =3D -EPERM;
>  	}
> +	if (payload->blob_len < 0)
> +		return payload->blob_len;
> =20
>  	return rc;
>  }
> @@ -182,13 +330,23 @@ static int tpm2_load_cmd(struct tpm_chip *chip,
>  	unsigned int private_len;
>  	unsigned int public_len;
>  	unsigned int blob_len;
> +	u8 *blob;
>  	int rc;
> =20
> -	private_len =3D be16_to_cpup((__be16 *) &payload->blob[0]);
> +	rc =3D tpm2_key_decode(payload, options, &blob);
> +	if (rc)
> +		/* old form */
> +		blob =3D payload->blob;
> +
> +	/* new format carries keyhandle but old format doesn't */
> +	if (!options->keyhandle)
> +		return -EINVAL;
> +
> +	private_len =3D be16_to_cpup((__be16 *) &blob[0]);
>  	if (private_len > (payload->blob_len - 2))
>  		return -E2BIG;
> =20
> -	public_len =3D be16_to_cpup((__be16 *) &payload->blob[2 + private_len])=
;
> +	public_len =3D be16_to_cpup((__be16 *) &blob[2 + private_len]);
>  	blob_len =3D private_len + public_len + 4;
>  	if (blob_len > payload->blob_len)
>  		return -E2BIG;
> @@ -204,7 +362,7 @@ static int tpm2_load_cmd(struct tpm_chip *chip,
>  			     options->keyauth /* hmac */,
>  			     TPM_DIGEST_SIZE);
> =20
> -	tpm_buf_append(&buf, payload->blob, blob_len);
> +	tpm_buf_append(&buf, blob, blob_len);
> =20
>  	if (buf.flags & TPM_BUF_OVERFLOW) {
>  		rc =3D -E2BIG;
> @@ -217,6 +375,8 @@ static int tpm2_load_cmd(struct tpm_chip *chip,
>  			(__be32 *) &buf.data[TPM_HEADER_SIZE]);
> =20
>  out:
> +	if (blob !=3D payload->blob)
> +		kfree(blob);
>  	tpm_buf_destroy(&buf);
> =20
>  	if (rc > 0)


--=-jOQsVIbnyjHJ35ZY96La
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
MjA5MTAwNDQ1WjAvBgkqhkiG9w0BCQQxIgQgE8C0U4D52gDJ5q6U3wbFxotmZzGAsQain3Cm9lne
qKcwgb4GCSsGAQQBgjcQBDGBsDCBrTCBlzELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIg
TWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEaMBgGA1UEChMRQ09NT0RPIENBIExpbWl0ZWQx
PTA7BgNVBAMTNENPTU9ETyBSU0EgQ2xpZW50IEF1dGhlbnRpY2F0aW9uIGFuZCBTZWN1cmUgRW1h
aWwgQ0ECEQDiu0lIeSrsCenEpRjxmVhmMIHABgsqhkiG9w0BCRACCzGBsKCBrTCBlzELMAkGA1UE
BhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEaMBgG
A1UEChMRQ09NT0RPIENBIExpbWl0ZWQxPTA7BgNVBAMTNENPTU9ETyBSU0EgQ2xpZW50IEF1dGhl
bnRpY2F0aW9uIGFuZCBTZWN1cmUgRW1haWwgQ0ECEQDiu0lIeSrsCenEpRjxmVhmMA0GCSqGSIb3
DQEBAQUABIIBAFlhO9asWqINPl5hHxOUM5/srIa2SBwL1PuZgp6LFh0oDgoQ6JRuvOyPZz2xRPyM
0Lqw+Bm53X717LIvmouTBWBxP4bS3UFQyGgoi3+QDIgJwwV8NxDFF9WC6eJLaFncyPr7xi+9eDxx
GixI3bTIHSG8n3gLw+PV8v4ptw3jgc48nYIhKAhf1n2xj3PnGXbtudqcY2t4K3pQh2aWVl2jU15G
dSpc0I5L+Qz5QxF8mF78EKjaIoFYibH6ZrEdOCR/eqv3f80LhQpXrvvRWa0kPxSldNOUCxXkpQeU
fOP5eUylmTJhZUfXe3nE3xdrt8niOkRjZZwB+xSYSdQ4cOtVOxcAAAAAAAA=


--=-jOQsVIbnyjHJ35ZY96La--

