Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA331116AC2
	for <lists+linux-integrity@lfdr.de>; Mon,  9 Dec 2019 11:18:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726297AbfLIKSu (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 9 Dec 2019 05:18:50 -0500
Received: from merlin.infradead.org ([205.233.59.134]:57312 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726279AbfLIKSt (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 9 Dec 2019 05:18:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Mime-Version:Content-Type:References:
        In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=xw1x5bkEUyUfbw0w3C3u+2GJLoEIk0Cdpx+T5UdGURg=; b=GDgjK7LpsudZ1uKbSEvX+1SW3
        bqM7SAJG42haoIx7zfjRsFhV/YhFzZO54zcnw4WuWKtvO9PVMwkprTqcyBmTLOUfkLB55/9iTHmCG
        M7R8NshR2ZOo6E6BEii1FTvggflC+210olHLn+lKMkLniIbAiF9bh+KHc+yIr6x4rRwLgEDBJkzaL
        UkMxjDxM1/AfGZUu0LOWzX70rkZsy89TmqPvO4ItqPKIKuWDN3riT9VNcPZ86tc4Frpo8E4J4U6z6
        AkDAESsO5vuFMH0lGdTz1hLQqG7yvxXejr/RW00rFLbxo6japsT+g9b+06XhdtuQ/otv7+Ji+UNKM
        BSMuk+Uvw==;
Received: from 54-240-197-228.amazon.com ([54.240.197.228] helo=freeip.amazon.com)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ieG7q-00076n-R9; Mon, 09 Dec 2019 10:18:47 +0000
Message-ID: <c2de442430dc0e6cd8e66af8479f6cc382545ac5.camel@infradead.org>
Subject: Re: [PATCH 6/8] security: keys: trusted: add PCR policy to TPM2 keys
From:   David Woodhouse <dwmw2@infradead.org>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date:   Mon, 09 Dec 2019 10:18:45 +0000
In-Reply-To: <1575781957.14069.16.camel@HansenPartnership.com>
References: <1575781600.14069.8.camel@HansenPartnership.com>
         <1575781957.14069.16.camel@HansenPartnership.com>
Content-Type: multipart/signed; micalg="sha-256";
        protocol="application/x-pkcs7-signature";
        boundary="=-nJJijTkMWg9uHKJn2jqH"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by merlin.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


--=-nJJijTkMWg9uHKJn2jqH
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 2019-12-07 at 21:12 -0800, James Bottomley wrote:
> This commit adds the ability to specify a PCR lock policy to TPM2
> keys.  There is a complexity in that the creator of the key must chose
> either to use a PCR lock policy or to use authentication.  At the
> current time they can't use both due to a complexity with the way
> authentication works when policy registers are in use.  The way to
> construct a pcrinfo statement for a key is simply to use the
> TPMS_PCR_SELECT structure to specify the PCRs and follow this by a
> hash of all their values in order of ascending PCR number.
>=20
> For simplicity, we require the policy name hash and the hash used for
> the PCRs to be the same.  Thus to construct a policy around the value
> of the resettable PCR 16 using the sha1 bank, first reset the pcr to
> zero giving a hash of all zeros as:
>=20
> 6768033e216468247bd031a0a2d9876d79818f8f
>=20
> Then the TPMS_PCR_SELECT value for PCR 16 is
>=20
> 03000001
>=20
> So create a new 32 byte key with a policy policy locking the key to
> this value of PCR 16 with a parent key of 81000001 would be:
>=20
> keyctl new 32 keyhandle=3D0x81000001 hash=3Dsha1 pcrinfo=3D03000001676803=
3e216468247bd031a0a2d9876d79818f8f" @u

OK... but I've love to see a more formal definition of this binary
format, as part of the "standard" we allegedly have for the overall
ASN.1 representation.

> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> ---
>  Documentation/security/keys/trusted-encrypted.rst |  25 +-
>  include/keys/trusted-type.h                       |   5 +-
>  include/linux/tpm.h                               |   5 +
>  security/keys/Kconfig                             |   2 +
>  security/keys/trusted-keys/Makefile               |   2 +-
>  security/keys/trusted-keys/tpm2-policy.c          | 344 ++++++++++++++++=
++++++
>  security/keys/trusted-keys/tpm2-policy.h          |  30 ++
>  security/keys/trusted-keys/tpm2key.asn1           |   4 +-
>  security/keys/trusted-keys/trusted_tpm1.c         |  32 +-
>  security/keys/trusted-keys/trusted_tpm2.c         |  77 ++++-
>  10 files changed, 478 insertions(+), 48 deletions(-)
>  create mode 100644 security/keys/trusted-keys/tpm2-policy.c
>  create mode 100644 security/keys/trusted-keys/tpm2-policy.h
>=20
> diff --git a/Documentation/security/keys/trusted-encrypted.rst b/Document=
ation/security/keys/trusted-encrypted.rst
> index 50ac8bcd6970..1a3ca84ad3cd 100644
> --- a/Documentation/security/keys/trusted-encrypted.rst
> +++ b/Documentation/security/keys/trusted-encrypted.rst
> @@ -60,19 +60,16 @@ Usage::
>                       (40 ascii zeros)
>         blobauth=3D     ascii hex auth for sealed data default 0x00...
>                       (40 ascii zeros)
> -       pcrinfo=3D	     ascii hex of PCR_INFO or PCR_INFO_LONG (no defaul=
t)
> +       pcrinfo=3D      ascii hex of PCR_INFO or PCR_INFO_LONG (no
> +                     default) on TPM 1.2 and a TPMS_PCR_SELECTION
> +                     coupled with a hash of all the selected PCRs on
> +                     TPM 2.0 using the selected hash.
>         pcrlock=3D	     pcr number to be extended to "lock" blob
>         migratable=3D   0|1 indicating permission to reseal to new PCR va=
lues,
>                       default 1 (resealing allowed)
>         hash=3D         hash algorithm name as a string. For TPM 1.x the =
only
>                       allowed value is sha1. For TPM 2.x the allowed valu=
es
>                       are sha1, sha256, sha384, sha512 and sm3-256.
> -       policydigest=3D digest for the authorization policy. must be calc=
ulated
> -                     with the same hash algorithm as specified by the 'h=
ash=3D'
> -                     option.
> -       policyhandle=3D handle to an authorization policy session that de=
fines the
> -                     same policy and with the same hash algorithm as was=
 used to
> -                     seal the key.
> =20
>  "keyctl print" returns an ascii hex copy of the sealed key, which is in =
standard
>  TPM_STORED_DATA format.  The key length for new keys are always in bytes=
.
> @@ -151,6 +148,20 @@ Load a trusted key from the saved blob::
>      f1f8fff03ad0acb083725535636addb08d73dedb9832da198081e5deae84bfaf0409=
c22b
>      e4a8aea2b607ec96931e6f4d4fe563ba
> =20
> +Create a trusted key on TPM 2.0 using an all zero value of PCR16 and
> +using the NV storage root 81000001 as the parent::
> +
> +    $ keyctl add trusted kmk "new 32 keyhandle=3D0x81000001 hash=3Dsha1 =
pcrinfo=3D030000016768033e216468247bd031a0a2d9876d79818f8f" @u
> +
> +Note the TPMS_PCR_SELECT value for PCR 16 is 03000001 because all
> +current TPMs have 24 PCRs, so the initial 03 says there are three
> +following bytes of selection and then because the bytes are big
> +endian, 16 is bit zero of byte 2. the hash is the sha1 sum of all
> +zeros (the value of PCR 16)::
> +
> +    $ dd if=3D/dev/zero bs=3D1 count=3D20 2>/dev/null|sha1sum
> +    6768033e216468247bd031a0a2d9876d79818f8f
> +
>  Reseal a trusted key under new pcr values::
> =20
>      $ keyctl update 268728824 "update pcrinfo=3D`cat pcr.blob`"
> diff --git a/include/keys/trusted-type.h b/include/keys/trusted-type.h
> index 4728e13aada8..fc9c13802c06 100644
> --- a/include/keys/trusted-type.h
> +++ b/include/keys/trusted-type.h
> @@ -14,9 +14,11 @@
>  #define MIN_KEY_SIZE			32
>  #define MAX_KEY_SIZE			128
>  #define MAX_BLOB_SIZE			512
> -#define MAX_PCRINFO_SIZE		64
> +#define MAX_PCRINFO_SIZE		128
>  #define MAX_DIGEST_SIZE			64
> =20
> +#define TPM2_MAX_POLICIES		16
> +
>  struct trusted_key_payload {
>  	struct rcu_head rcu;
>  	unsigned int key_len;
> @@ -25,6 +27,7 @@ struct trusted_key_payload {
>  	unsigned char old_format;
>  	unsigned char key[MAX_KEY_SIZE + 1];
>  	unsigned char blob[MAX_BLOB_SIZE];
> +	struct tpm2_policies *policies;
>  };
> =20
>  struct trusted_key_options {
> diff --git a/include/linux/tpm.h b/include/linux/tpm.h
> index cd46ab27baa5..e32e9728adce 100644
> --- a/include/linux/tpm.h
> +++ b/include/linux/tpm.h
> @@ -222,10 +222,14 @@ enum tpm2_command_codes {
>  	TPM2_CC_CONTEXT_LOAD	        =3D 0x0161,
>  	TPM2_CC_CONTEXT_SAVE	        =3D 0x0162,
>  	TPM2_CC_FLUSH_CONTEXT	        =3D 0x0165,
> +	TPM2_CC_POLICY_AUTHVALUE	=3D 0x016B,
> +	TPM2_CC_POLICY_COUNTER_TIMER	=3D 0x016D,
> +	TPM2_CC_START_AUTH_SESS		=3D 0x0176,
>  	TPM2_CC_VERIFY_SIGNATURE        =3D 0x0177,
>  	TPM2_CC_GET_CAPABILITY	        =3D 0x017A,
>  	TPM2_CC_GET_RANDOM	        =3D 0x017B,
>  	TPM2_CC_PCR_READ	        =3D 0x017E,
> +	TPM2_CC_POLICY_PCR		=3D 0x017F,
>  	TPM2_CC_PCR_EXTEND	        =3D 0x0182,
>  	TPM2_CC_EVENT_SEQUENCE_COMPLETE =3D 0x0185,
>  	TPM2_CC_HASH_SEQUENCE_START     =3D 0x0186,
> @@ -234,6 +238,7 @@ enum tpm2_command_codes {
>  };
> =20
>  enum tpm2_permanent_handles {
> +	TPM2_RH_NULL		=3D 0x40000007,
>  	TPM2_RS_PW		=3D 0x40000009,
>  };
> =20
> diff --git a/security/keys/Kconfig b/security/keys/Kconfig
> index dd313438fecf..6c2f2c22b284 100644
> --- a/security/keys/Kconfig
> +++ b/security/keys/Kconfig
> @@ -80,6 +80,8 @@ config TRUSTED_KEYS
>  	select CRYPTO
>  	select CRYPTO_HMAC
>  	select CRYPTO_SHA1
> +	select CRYPTO_SHA256
> +	select CRYPTO_SHA512
>  	select CRYPTO_HASH_INFO
>  	help
>  	  This option provides support for creating, sealing, and unsealing
> diff --git a/security/keys/trusted-keys/Makefile b/security/keys/trusted-=
keys/Makefile
> index e0198641eff2..194febacf362 100644
> --- a/security/keys/trusted-keys/Makefile
> +++ b/security/keys/trusted-keys/Makefile
> @@ -5,4 +5,4 @@
> =20
>  obj-$(CONFIG_TRUSTED_KEYS) +=3D trusted.o
>  trusted-y +=3D trusted_tpm1.o
> -trusted-y +=3D trusted_tpm2.o tpm2key.asn1.o
> +trusted-y +=3D trusted_tpm2.o tpm2key.asn1.o tpm2-policy.o
> diff --git a/security/keys/trusted-keys/tpm2-policy.c b/security/keys/tru=
sted-keys/tpm2-policy.c
> new file mode 100644
> index 000000000000..ae83636ece37
> --- /dev/null
> +++ b/security/keys/trusted-keys/tpm2-policy.c
> @@ -0,0 +1,344 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2019 James.Bottomley@HansenPartnership.com
> + */
> +
> +#include <linux/asn1_encoder.h>
> +#include <linux/err.h>
> +#include <linux/types.h>
> +#include <linux/printk.h>
> +#include <linux/string.h>
> +#include <linux/tpm.h>
> +
> +#include <asm/unaligned.h>
> +
> +#include <crypto/hash.h>
> +
> +#include <keys/trusted-type.h>
> +#include <keys/trusted_tpm.h>
> +
> +#include "tpm2key.asn1.h"
> +#include "tpm2-policy.h"
> +
> +int tpmkey_code(void *context, size_t hdrlen,
> +		unsigned char tag,
> +		const void *value, size_t vlen)
> +{
> +	struct tpm2key_context *ctx =3D context;
> +	u32 code =3D 0;
> +	const u8 *v =3D value;
> +	int i;
> +
> +	for (i =3D 0; i < vlen; i++) {
> +		code <<=3D 8;
> +		code |=3D v[i];
> +	}
> +
> +	ctx->policy_code[ctx->policy_count] =3D code;
> +
> +	return 0;
> +}
> +
> +int tpmkey_policy(void *context, size_t hdrlen,
> +		  unsigned char tag,
> +		  const void *value, size_t vlen)
> +{
> +	struct tpm2key_context *ctx =3D context;
> +
> +	ctx->policies[ctx->policy_count] =3D value;
> +	ctx->policy_len[ctx->policy_count++] =3D vlen;
> +
> +	return 0;
> +}
> +
> +/* we only support a limited number of policy statement so
> + * make sure we don't have anything we can't support
> + */
> +static int tpm2_validate_policy(struct tpm2_policies *pols)
> +{
> +	int i;
> +
> +	if (pols->count =3D=3D 0)
> +		return 0;
> +
> +	for (i =3D 0; i < pols->count; i++) {
> +		switch (pols->code[i]) {
> +		case TPM2_CC_POLICY_COUNTER_TIMER:
> +		case TPM2_CC_POLICY_PCR:
> +		case TPM2_CC_POLICY_AUTHVALUE:
> +			break;
> +		default:
> +			printk(KERN_INFO "tpm2 policy 0x%x is unsupported",
> +			       pols->code[i]);
> +			return -EINVAL;
> +		}
> +	}
> +	return 0;
> +}
> +
> +/**
> + * tpmkey_process_policy - collect the policty from the context
> + * @ctx: the context to collect from
> + * @payload: the payload structure to place it in
> + *
> + * THis function sizes the policy statements and allocates space
> + * within the payload to receive them before copying them over.  It
> + * should be used after the ber decoder has completed successfully
> + */
> +int tpmkey_policy_process(struct tpm2key_context *ctx,
> +			  struct trusted_key_payload *payload)
> +{
> +	int tot_len =3D 0;
> +	u8 *buf;
> +	int i, ret, len =3D 0;
> +	struct tpm2_policies *pols;
> +
> +	if (ctx->policy_count =3D=3D 0)
> +		return 0;
> +
> +	for (i =3D 0; i < ctx->policy_count; i++)
> +		tot_len +=3D ctx->policy_len[i];
> +	tot_len +=3D sizeof(*pols);
> +
> +	pols =3D kmalloc(tot_len, GFP_KERNEL);
> +	if (!pols)
> +		return -ENOMEM;
> +
> +	payload->policies =3D pols;
> +	buf =3D (u8 *)(pols + 1);
> +
> +	for (i =3D 0; i < ctx->policy_count; i++) {
> +		pols->policies[i] =3D &buf[len];
> +		pols->len[i] =3D ctx->policy_len[i];
> +		pols->code[i] =3D ctx->policy_code[i];
> +		if (pols->len[i])
> +			memcpy(pols->policies[i], ctx->policies[i],
> +			       ctx->policy_len[i]);
> +		len +=3D ctx->policy_len[i];
> +	}
> +	pols->count =3D ctx->policy_count;
> +
> +	ret =3D tpm2_validate_policy(pols);
> +	if (ret) {
> +		kfree(pols);
> +		payload->policies =3D NULL;
> +	}
> +
> +	/* capture the hash and size */
> +
> +	/* the hash is the second algorithm */
> +	pols->hash =3D get_unaligned_be16(&ctx->pub[2]);
> +	/* and the digest appears after the attributes */
> +	pols->hash_size =3D get_unaligned_be16(&ctx->pub[8]);
> +
> +	return ret;
> +}
> +
> +int tpm2_generate_policy_digest(struct tpm2_policies *pols,
> +				u32 hash, u8 *policydigest, u32 *plen)
> +{
> +	int i;
> +	struct crypto_shash *tfm;
> +	int rc;
> +
> +	if (pols->count =3D=3D 0)
> +		return 0;
> +
> +	tfm =3D crypto_alloc_shash(hash_algo_name[hash], 0, 0);
> +	if (IS_ERR(tfm))
> +		return PTR_ERR(tfm);
> +
> +	rc =3D crypto_shash_digestsize(tfm);
> +	if (WARN(rc > MAX_DIGEST_SIZE,
> +		 "BUG: trusted key code has alg %s with digest too large (%d)",
> +		 hash_algo_name[hash], rc)) {
> +		rc =3D -EINVAL;
> +		goto err;
> +	}
> +	pols->hash =3D hash;
> +	pols->hash_size =3D rc;
> +	*plen =3D rc;
> +
> +	/* policy digests always start out all zeros */
> +	memset(policydigest, 0, rc);
> +
> +	for (i =3D 0; i < pols->count; i++) {
> +		u8 *policy =3D pols->policies[i];
> +		int len =3D pols->len[i];
> +		u32 cmd =3D pols->code[i];
> +		u8 digest[MAX_DIGEST_SIZE];
> +		u8 code[4];
> +		SHASH_DESC_ON_STACK(sdesc, tfm);
> +
> +		sdesc->tfm =3D tfm;
> +		rc =3D crypto_shash_init(sdesc);
> +		if (rc)
> +			goto err;
> +
> +		/* first hash the previous digest */
> +		crypto_shash_update(sdesc, policydigest, *plen);
> +		/* then hash the command code */
> +		put_unaligned_be32(cmd, code);
> +		crypto_shash_update(sdesc, code, 4);
> +
> +		/* commands that need special handling */
> +		if (cmd =3D=3D TPM2_CC_POLICY_COUNTER_TIMER) {
> +			SHASH_DESC_ON_STACK(sdesc1, tfm);
> +
> +			sdesc1->tfm =3D tfm;
> +
> +			/* counter timer policies are double hashed */
> +			crypto_shash_digest(sdesc1, policy, len,
> +					    digest);
> +			policy =3D digest;
> +			len =3D *plen;
> +		}
> +		crypto_shash_update(sdesc, policy, len);
> +		/* now output the intermediate to the policydigest */
> +		crypto_shash_final(sdesc, policydigest);
> +
> +	}
> +	rc =3D 0;
> +
> + err:
> +	crypto_free_shash(tfm);
> +	return rc;
> +}
> +
> +int tpm2_encode_policy(struct tpm2_policies *pols, u8 **data, u32 *len)
> +{
> +	u8 *buf =3D kmalloc(2 * PAGE_SIZE, GFP_KERNEL);
> +	u8 *work =3D buf + PAGE_SIZE, *ptr;
> +	int i;
> +
> +	if (!buf)
> +		return -ENOMEM;
> +
> +	for (i =3D 0; i < pols->count; i++) {
> +		u8 *seq_len, *tag_len;
> +		u32 cmd =3D pols->code[i];
> +		int l;
> +
> +		/*
> +		 * cheat a bit here: we know a policy is < 128 bytes,
> +		 * so the sequence and cons tags will only be two
> +		 * bytes long
> +		 */
> +		*work++ =3D _tag(UNIV, CONS, SEQ);
> +		seq_len =3D work++;
> +		*work++ =3D _tagn(CONT, CONS, 0);
> +		tag_len =3D work++;
> +		asn1_encode_integer(&work, cmd);
> +		*tag_len =3D work - tag_len - 1;
> +		*work++ =3D _tagn(CONT, CONS, 1);
> +		tag_len =3D work++;
> +		asn1_encode_octet_string(&work, pols->policies[i],
> +					 pols->len[i]);
> +		*tag_len =3D work - tag_len - 1;
> +		l =3D work - seq_len - 1;
> +		/* our assumption about policy length failed */
> +		if (WARN(l > 127,
> +			 "policy is too long: %d but must be < 128", l)) {
> +			kfree(buf);
> +			return -EINVAL;
> +		}
> +		*seq_len =3D l;



You're not even using your own sequence encoding here, because it only
works when you know the length in advance. How about setting *seq_len
to 0x80 to start with, for an indeterminate length.

Then in the happy case where it is <128, just go back and fill it in as
you currently do. Otherwise append 0x00 0x00 as the end marker.

None of this has to be DER, does it?

<Insert more whining about PAGE_SIZE assumptions and buffer overflows>

> +	}
> +	ptr =3D buf;
> +	asn1_encode_sequence(&ptr, buf + PAGE_SIZE, work - buf - PAGE_SIZE);
> +	*data =3D buf;
> +	*len =3D ptr - buf;
> +
> +	return 0;
> +}
> +
> +int tpm2_start_policy_session(struct tpm_chip *chip, u16 hash, u32 *hand=
le)
> +{
> +	struct tpm_buf buf;
> +	int rc;
> +	int i;
> +
> +	rc =3D tpm_buf_init(&buf, TPM2_ST_NO_SESSIONS, TPM2_CC_START_AUTH_SESS)=
;
> +	if (rc)
> +		return rc;
> +
> +	/* NULL salt key handle */
> +	tpm_buf_append_u32(&buf, TPM2_RH_NULL);
> +	/* NULL bind key handle */
> +	tpm_buf_append_u32(&buf, TPM2_RH_NULL);
> +	/* empty nonce caller */
> +	tpm_buf_append_u16(&buf, 20);
> +	for (i =3D 0; i < 20; i++)
> +		tpm_buf_append_u8(&buf, 0);
> +	/* empty auth */
> +	tpm_buf_append_u16(&buf, 0);
> +	/* session type policy */
> +	tpm_buf_append_u8(&buf, 0x01);
> +
> +	/* symmetric encryption parameters */
> +	/* symmetric algorithm  */
> +	tpm_buf_append_u16(&buf, TPM_ALG_NULL);
> +	/* hash algorithm for session */
> +	tpm_buf_append_u16(&buf, hash);
> +
> +	rc =3D tpm_send(chip, buf.data, tpm_buf_length(&buf));
> +	if (rc)
> +		goto out;
> +
> +	*handle =3D get_unaligned_be32(buf.data + TPM_HEADER_SIZE);
> + out:
> +	tpm_buf_destroy(&buf);
> +
> +	return rc <=3D 0 ? rc : -EPERM;
> +}
> +
> +int tpm2_get_policy_session(struct tpm_chip *chip, struct tpm2_policies =
*pols,
> +			    u32 *handle)
> +{
> +	int i, rc;
> +	const char *failure;
> +
> +	rc =3D tpm2_start_policy_session(chip, pols->hash, handle);
> +	if (rc)
> +		return rc;
> +
> +	for (i =3D 0; i < pols->count; i++) {
> +		u32 cmd =3D pols->code[i];
> +		struct tpm_buf buf;
> +
> +		rc =3D tpm_buf_init(&buf, TPM2_ST_NO_SESSIONS, cmd);
> +		if (rc)
> +			return rc;
> +
> +		tpm_buf_append_u32(&buf, *handle);
> +
> +		switch (cmd) {
> +		case TPM2_CC_POLICY_PCR:
> +			failure =3D "PCR";
> +			/*
> +			 * for reasons best known to the TCG we have
> +			 * to reverse the two arguments to send to the
> +			 * policy command
> +			 */
> +			tpm_buf_append_u16(&buf, pols->hash_size);
> +			tpm_buf_append(&buf, pols->policies[i] + pols->len[i] -
> +				       pols->hash_size, pols->hash_size);
> +			tpm_buf_append(&buf, pols->policies[i],
> +				       pols->len[i] - pols->hash_size);
> +			break;
> +		default:
> +			failure =3D "unknown policy";
> +			break;
> +		}
> +		rc =3D tpm_send(chip, buf.data, tpm_buf_length(&buf));
> +		tpm_buf_destroy(&buf);
> +		if (rc) {
> +			printk(KERN_NOTICE "TPM policy %s failed, rc=3D%d\n",
> +			       failure, rc);
> +			tpm2_flush_context(chip, *handle);
> +			*handle =3D 0;
> +			return -EPERM;
> +		}
> +	}
> +	return 0;
> +}
> diff --git a/security/keys/trusted-keys/tpm2-policy.h b/security/keys/tru=
sted-keys/tpm2-policy.h
> new file mode 100644
> index 000000000000..152c948743f3
> --- /dev/null
> +++ b/security/keys/trusted-keys/tpm2-policy.h
> @@ -0,0 +1,30 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +
> +struct tpm2key_context {
> +	u32 parent;
> +	const u8 *pub;
> +	u32 pub_len;
> +	const u8 *priv;
> +	u32 priv_len;
> +	const u8 *policies[TPM2_MAX_POLICIES];
> +	u32 policy_code[TPM2_MAX_POLICIES];
> +	u16 policy_len[TPM2_MAX_POLICIES];
> +	u8 policy_count;
> +};
> +
> +struct tpm2_policies {
> +	u32 code[TPM2_MAX_POLICIES];
> +	u8 *policies[TPM2_MAX_POLICIES];
> +	u16 len[TPM2_MAX_POLICIES];
> +	u8 count;
> +	u16 hash;
> +	u16 hash_size;
> +};
> +
> +int tpmkey_policy_process(struct tpm2key_context *ctx,
> +			  struct trusted_key_payload *payload);
> +int tpm2_generate_policy_digest(struct tpm2_policies *pols, u32 hash,
> +				u8 *policydigest, u32 *plen);
> +int tpm2_encode_policy(struct tpm2_policies *pols, u8 **data, u32 *len);
> +int tpm2_get_policy_session(struct tpm_chip *chip, struct tpm2_policies =
*pols,
> +			    u32 *handle);
> diff --git a/security/keys/trusted-keys/tpm2key.asn1 b/security/keys/trus=
ted-keys/tpm2key.asn1
> index 1851b7c80f08..f930fd812db3 100644
> --- a/security/keys/trusted-keys/tpm2key.asn1
> +++ b/security/keys/trusted-keys/tpm2key.asn1
> @@ -18,6 +18,6 @@ TPMKey ::=3D SEQUENCE {
>  TPMPolicySequence ::=3D SEQUENCE OF TPMPolicy
> =20
>  TPMPolicy ::=3D SEQUENCE {
> -	commandCode		[0] EXPLICIT INTEGER,
> -	commandPolicy		[1] EXPLICIT OCTET STRING
> +	commandCode		[0] EXPLICIT INTEGER ({tpmkey_code}),
> +	commandPolicy		[1] EXPLICIT OCTET STRING ({tpmkey_policy})
>  	}
> diff --git a/security/keys/trusted-keys/trusted_tpm1.c b/security/keys/tr=
usted-keys/trusted_tpm1.c
> index d744a0d1cb89..6290e611b632 100644
> --- a/security/keys/trusted-keys/trusted_tpm1.c
> +++ b/security/keys/trusted-keys/trusted_tpm1.c
> @@ -707,8 +707,6 @@ enum {
>  	Opt_keyhandle, Opt_keyauth, Opt_blobauth,
>  	Opt_pcrinfo, Opt_pcrlock, Opt_migratable,
>  	Opt_hash,
> -	Opt_policydigest,
> -	Opt_policyhandle,
>  };
> =20
>  static const match_table_t key_tokens =3D {
> @@ -722,8 +720,6 @@ static const match_table_t key_tokens =3D {
>  	{Opt_pcrlock, "pcrlock=3D%s"},
>  	{Opt_migratable, "migratable=3D%s"},
>  	{Opt_hash, "hash=3D%s"},
> -	{Opt_policydigest, "policydigest=3D%s"},
> -	{Opt_policyhandle, "policyhandle=3D%s"},
>  	{Opt_err, NULL}
>  };
> =20
> @@ -738,7 +734,6 @@ static int getoptions(char *c, struct trusted_key_pay=
load *pay,
>  	unsigned long handle;
>  	unsigned long lock;
>  	unsigned long token_mask =3D 0;
> -	unsigned int digest_len;
>  	int i;
>  	int tpm2;
> =20
> @@ -801,8 +796,6 @@ static int getoptions(char *c, struct trusted_key_pay=
load *pay,
>  			opt->pcrlock =3D lock;
>  			break;
>  		case Opt_hash:
> -			if (test_bit(Opt_policydigest, &token_mask))
> -				return -EINVAL;
>  			for (i =3D 0; i < HASH_ALGO__LAST; i++) {
>  				if (!strcmp(args[0].from, hash_algo_name[i])) {
>  					opt->hash =3D i;
> @@ -816,24 +809,6 @@ static int getoptions(char *c, struct trusted_key_pa=
yload *pay,
>  				return -EINVAL;
>  			}
>  			break;
> -		case Opt_policydigest:
> -			digest_len =3D hash_digest_size[opt->hash];
> -			if (!tpm2 || strlen(args[0].from) !=3D (2 * digest_len))
> -				return -EINVAL;
> -			res =3D hex2bin(opt->policydigest, args[0].from,
> -				      digest_len);
> -			if (res < 0)
> -				return -EINVAL;
> -			opt->policydigest_len =3D digest_len;
> -			break;
> -		case Opt_policyhandle:
> -			if (!tpm2)
> -				return -EINVAL;
> -			res =3D kstrtoul(args[0].from, 16, &handle);
> -			if (res < 0)
> -				return -EINVAL;
> -			opt->policyhandle =3D handle;
> -			break;
>  		default:
>  			return -EINVAL;
>  		}
> @@ -1045,6 +1020,7 @@ static void trusted_rcu_free(struct rcu_head *rcu)
>  	struct trusted_key_payload *p;
> =20
>  	p =3D container_of(rcu, struct trusted_key_payload, rcu);
> +	kzfree(p->policies);
>  	kzfree(p);
>  }
> =20
> @@ -1164,7 +1140,11 @@ static long trusted_read(const struct key *key, ch=
ar __user *buffer,
>   */
>  static void trusted_destroy(struct key *key)
>  {
> -	kzfree(key->payload.data[0]);
> +	struct trusted_key_payload *p;
> +
> +	p =3D key->payload.data[0];
> +	kzfree(p->policies);
> +	kzfree(p);
>  }
> =20
>  struct key_type key_type_trusted =3D {
> diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/tr=
usted-keys/trusted_tpm2.c
> index a34ab6f90f76..6d0d427bc5c5 100644
> --- a/security/keys/trusted-keys/trusted_tpm2.c
> +++ b/security/keys/trusted-keys/trusted_tpm2.c
> @@ -17,6 +17,7 @@
>  #include <asm/unaligned.h>
> =20
>  #include "tpm2key.asn1.h"
> +#include "tpm2-policy.h"
> =20
>  static struct tpm2_hash tpm2_hash_map[] =3D {
>  	{HASH_ALGO_SHA1, TPM_ALG_SHA1},
> @@ -55,6 +56,20 @@ static int tpm2_key_encode(struct trusted_key_payload =
*payload,
>  		asn1_encode_boolean(&w, true);
>  		asn1_encode_tag(&work, 0, bool, w - bool);
>  	}
> +	if (payload->policies) {
> +		u8 *encoded_pols;
> +		u32 encoded_pol_len;
> +		int ret;
> +
> +		ret =3D tpm2_encode_policy(payload->policies, &encoded_pols,
> +					 &encoded_pol_len);
> +
> +		if (!ret) {
> +			asn1_encode_tag(&work, 1, encoded_pols,
> +					encoded_pol_len);
> +			kfree(encoded_pols);
> +		}
> +	}
>  	asn1_encode_integer(&work, options->keyhandle);
>  	asn1_encode_octet_string(&work, pub, pub_len);
>  	asn1_encode_octet_string(&work, priv, priv_len);
> @@ -65,14 +80,6 @@ static int tpm2_key_encode(struct trusted_key_payload =
*payload,
>  	return work1 - payload->blob;
>  }
> =20
> -struct tpm2key_context {
> -	u32 parent;
> -	const u8 *pub;
> -	u32 pub_len;
> -	const u8 *priv;
> -	u32 priv_len;
> -};
> -
>  static int tpm2_key_decode(struct trusted_key_payload *payload,
>  			   struct trusted_key_options *options,
>  			   u8 **buf)
> @@ -81,6 +88,8 @@ static int tpm2_key_decode(struct trusted_key_payload *=
payload,
>  	struct tpm2key_context ctx;
>  	u8 *blob;
> =20
> +	memset(&ctx, 0, sizeof(ctx));
> +
>  	ret =3D asn1_ber_decoder(&tpm2key_decoder, &ctx, payload->blob,
>  			       payload->blob_len);
>  	if (ret < 0)
> @@ -93,6 +102,12 @@ static int tpm2_key_decode(struct trusted_key_payload=
 *payload,
>  	if (!blob)
>  		return -ENOMEM;
> =20
> +	ret =3D tpmkey_policy_process(&ctx, payload);
> +	if (ret) {
> +		kfree(blob);
> +		return ret;
> +	}
> +
>  	*buf =3D blob;
>  	options->keyhandle =3D ctx.parent;
>  	put_unaligned_be16(ctx.priv_len, blob);
> @@ -224,6 +239,37 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
>  	if (!options->keyhandle)
>  		return -EINVAL;
> =20
> +	if (options->pcrinfo_len !=3D 0) {
> +		struct tpm2_policies *pols;
> +		static u8 *scratch;
> +		/* 4 array len, 2 hash alg */
> +		const int len =3D 4 + 2 + options->pcrinfo_len;
> +
> +		pols =3D kmalloc(sizeof(*pols) + len, GFP_KERNEL);
> +		if (!pols)
> +			return -ENOMEM;
> +
> +		pols->count =3D 1;
> +		pols->len[0] =3D len;
> +		scratch =3D (u8 *)(pols + 1);
> +		pols->policies[0] =3D scratch;
> +		pols->code[0] =3D TPM2_CC_POLICY_PCR;
> +
> +		put_unaligned_be32(1, &scratch[0]);
> +		put_unaligned_be16(hash, &scratch[4]);
> +		memcpy(&scratch[6], options->pcrinfo, options->pcrinfo_len);
> +		payload->policies =3D pols;
> +	}
> +
> +	if (payload->policies) {
> +		rc =3D tpm2_generate_policy_digest(payload->policies,
> +						 options->hash,
> +						 options->policydigest,
> +						 &options->policydigest_len);
> +		if (rc)
> +			return rc;
> +	}
> +
>  	rc =3D tpm_buf_init(&buf, TPM2_ST_SESSIONS, TPM2_CC_CREATE);
>  	if (rc)
>  		return rc;
> @@ -421,21 +467,30 @@ static int tpm2_unseal_cmd(struct tpm_chip *chip,
>  	u16 data_len;
>  	u8 *data;
>  	int rc;
> +	u32 policyhandle =3D 0;
> =20
>  	rc =3D tpm_buf_init(&buf, TPM2_ST_SESSIONS, TPM2_CC_UNSEAL);
>  	if (rc)
>  		return rc;
> =20
> +	if (payload->policies) {
> +		rc =3D tpm2_get_policy_session(chip, payload->policies,
> +					     &policyhandle);
> +		if (rc)
> +			return rc;
> +	}
> +
>  	tpm_buf_append_u32(&buf, blob_handle);
>  	tpm2_buf_append_auth(&buf,
> -			     options->policyhandle ?
> -			     options->policyhandle : TPM2_RS_PW,
> +			     policyhandle ?
> +			     policyhandle : TPM2_RS_PW,
>  			     NULL /* nonce */, 0,
>  			     TPM2_SA_CONTINUE_SESSION,
>  			     options->blobauth /* hmac */,
> -			     TPM_DIGEST_SIZE);
> +			     policyhandle ? 0 : TPM_DIGEST_SIZE);
> =20
>  	rc =3D tpm_send(chip, buf.data, tpm_buf_length(&buf));
> +	tpm2_flush_context(chip, policyhandle);
>  	if (rc > 0)
>  		rc =3D -EPERM;
> =20


--=-nJJijTkMWg9uHKJn2jqH
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
MjA5MTAxODQ1WjAvBgkqhkiG9w0BCQQxIgQgauZnQNN6rEwSFMIUFM5IM2nVRp2gWs6B1oKVg6vD
ICowgb4GCSsGAQQBgjcQBDGBsDCBrTCBlzELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIg
TWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEaMBgGA1UEChMRQ09NT0RPIENBIExpbWl0ZWQx
PTA7BgNVBAMTNENPTU9ETyBSU0EgQ2xpZW50IEF1dGhlbnRpY2F0aW9uIGFuZCBTZWN1cmUgRW1h
aWwgQ0ECEQDiu0lIeSrsCenEpRjxmVhmMIHABgsqhkiG9w0BCRACCzGBsKCBrTCBlzELMAkGA1UE
BhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEaMBgG
A1UEChMRQ09NT0RPIENBIExpbWl0ZWQxPTA7BgNVBAMTNENPTU9ETyBSU0EgQ2xpZW50IEF1dGhl
bnRpY2F0aW9uIGFuZCBTZWN1cmUgRW1haWwgQ0ECEQDiu0lIeSrsCenEpRjxmVhmMA0GCSqGSIb3
DQEBAQUABIIBAFKvgaI6nMl4NH/k5WUV0NnQIi/ZA76fKzXx3Vh5zD8bssR0txo0IFF+J3dd5TDf
IXlUWdjKC74DuLdSIulIrR/pCJbv3/padtehPiX89xq9btVQk/fIVlvtnCC67+hu0Pwi5AIvg8q1
V/SqSPC6Xgrv2EeF7cPBbEdLppac4ENz6ntU7/DFHIG2pq726h6Km1jdfQMXRpbe8VGqG5Odv08Y
HmcNZe0B6ZZgRuDR8HbArlD7qs1zO7y2frP6hzhKPMA6eQuhCwYdlBRZ3z4DH41snf2IQqJLPciz
jRLhuqWiebbs7b8vi6c/bkZm2Ok+x/yKnE8hUoX1x2ygAOa6xLEAAAAAAAA=


--=-nJJijTkMWg9uHKJn2jqH--

