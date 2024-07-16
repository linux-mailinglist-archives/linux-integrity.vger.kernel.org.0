Return-Path: <linux-integrity+bounces-3126-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF325932616
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Jul 2024 14:02:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E160C1C20FD9
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Jul 2024 12:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29612195FE8;
	Tue, 16 Jul 2024 12:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eBMCRE8i"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3298143891;
	Tue, 16 Jul 2024 12:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721131322; cv=none; b=FTxaGXoSXTz4i3BbvvnNjiQNzzo7yMWBLeICz/i71nieMf9gVHhXz8mDVvcb7kcaPlUwJeqVUCwhVabMLxvA/PlXJANCAu0EeRzHzZlTMOm8p1dhXO9vzdGl7pcWx96wlLJc42wzMyM/2uBxHBDB60/x+Ej+0TY0zbXY5wJD7ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721131322; c=relaxed/simple;
	bh=Z+Gw3KqzThw6W27aaubnuxXcm9vRGKcfZME4+5tV5os=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=GPVWSwUU3vKwR+lhBL4Ax/D9MSe1qXjC/6v6sx3A3sSa8RWDJvwHwFaIi9xMkbzaK5VQD8w20V7D4+Ei5Sfnhf9svhtDddEE0+2HvoE3DRzBgDUSOyJ0e76XSl7wp/9s7ILPfqA2vbccGSCAA+a99YZvSNEvvBXUXPAXZO696wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eBMCRE8i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 242B5C116B1;
	Tue, 16 Jul 2024 12:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721131321;
	bh=Z+Gw3KqzThw6W27aaubnuxXcm9vRGKcfZME4+5tV5os=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eBMCRE8iOdlbHEp7uW4r2J8eJD6Lwqbw9r5fGvAAAW+qn4xn4SUXePzGwjOyPog3j
	 fkmDy8ZmWiHTMjQb9/hozrsDDs64dI2vpX1AlHfIYqjzu7vvWP5LYQw+taiUma0+I7
	 6HtFkfBhcjFXlc8tecw/xf1B+kNLQWArZqk2Fh5D3uCH8+23YLJcCyygjIaBE/Y0+0
	 /pUlw4FbjywxAQW2syaosoU9RRLQNMj53uHd5HSB6jsAXNaJqUayh20LqnjiZbYYmd
	 vybk+jZKo0+/DQ6fCaXLJDaT+eeRRirmDn4cOEqfPDkCnBc+Jhv5oQlYM0Yv4Q44tr
	 iO/vLHOVtfxAQ==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 16 Jul 2024 15:01:59 +0300
Message-Id: <D2QY4SJRTUOH.DCG8SDHMNQJP@kernel.org>
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "James Bottomley" <James.Bottomley@HansenPartnership.com>,
 <linux-integrity@vger.kernel.org>
Cc: <keyrings@vger.kernel.org>
Subject: Re: [PATCH 4/6] KEYS: trusted: add ability to specify arbitrary
 policy
X-Mailer: aerc 0.17.0
References: <20240524130459.21510-1-James.Bottomley@HansenPartnership.com>
 <20240524130459.21510-5-James.Bottomley@HansenPartnership.com>
In-Reply-To: <20240524130459.21510-5-James.Bottomley@HansenPartnership.com>

On Fri May 24, 2024 at 4:04 PM EEST, James Bottomley wrote:
> This patch adds a policy=3D argument to key creation.  The policy is the
> standard tss policymaker format and each separate policy line must
> have a newline after it.
>
> Thus to construct a policy requiring authorized value and pcr 16
> locking using a sha256 hash, the policy (policy.txt) file would be two
> lines:
>
> 0000017F00000001000B03000001303095B49BE85E381E5B20E557E46363EF55B0F43B132=
C2D8E3DE9AC436656F2
> 0000016b
>
> This can be inserted into the key with
>
> keyctl add trusted kmk "new 32 policy=3D`cat policy.txt` keyhandle=3D0x81=
000001 hash=3Dsha256" @u
>
> Note that although a few policies work like this, most require special
> handling which must be added to the kernel policy construction
> routine.
>
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> ---
>  .../security/keys/trusted-encrypted.rst       | 17 +++++-
>  security/keys/trusted-keys/tpm2-policy.c      | 53 +++++++++++++++++++
>  security/keys/trusted-keys/tpm2-policy.h      |  5 ++
>  security/keys/trusted-keys/trusted_tpm1.c     | 15 ++++++
>  4 files changed, 89 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/security/keys/trusted-encrypted.rst b/Document=
ation/security/keys/trusted-encrypted.rst
> index c37c08956ec1..fbb41cf16f30 100644
> --- a/Documentation/security/keys/trusted-encrypted.rst
> +++ b/Documentation/security/keys/trusted-encrypted.rst
> @@ -233,6 +233,9 @@ Usage::
>         policyhandle=3D handle to an authorization policy session that de=
fines the
>                       same policy and with the same hash algorithm as was=
 used to
>                       seal the key.
> +       policy=3D       specify an arbitrary set of policies.  These must
> +                     be in policymaker format with each separate
> +                     policy line newline terminated.
> =20
>  "keyctl print" returns an ascii hex copy of the sealed key, which is in =
standard
>  TPM_STORED_DATA format.  The key length for new keys are always in bytes=
.
> @@ -377,6 +380,19 @@ the sha1 pcr16 bank you'd say::
> =20
>  because the trailing hash is the sha256sum of 20 zero bytes.
> =20
> +You can also specify arbitrary policy in policymaker format, so a two
> +value policy (the pcr example above and authvalue) would look like
> +this in policymaker format::
> +
> +    0000017F000000010004030000016768033e216468247bd031a0a2d9876d79818f8f
> +    0000016b
> +
> +This can be placed in a file (say policy.txt) and then added to the key =
as::
> +
> +    $ keyctl add trusted kmk "new 32 keyhandle=3D0x81000001 hash=3Dsha1 =
policy=3D`cat policy.txt`" @u
> +
> +The newlines in the file policy.txt will be automatically processed.
> +
>  Reseal (TPM specific) a trusted key under new PCR values::
> =20
>      $ keyctl update 268728824 "update pcrinfo=3D`cat pcr.blob`"
> @@ -447,7 +463,6 @@ Another new format 'enc32' has been defined in order =
to support encrypted keys
>  with payload size of 32 bytes. This will initially be used for nvdimm se=
curity
>  but may expand to other usages that require 32 bytes payload.
> =20
> -
>  TPM 2.0 ASN.1 Key Format
>  ------------------------
> =20
> diff --git a/security/keys/trusted-keys/tpm2-policy.c b/security/keys/tru=
sted-keys/tpm2-policy.c
> index 8c3a09762c10..a731c10d9bba 100644
> --- a/security/keys/trusted-keys/tpm2-policy.c
> +++ b/security/keys/trusted-keys/tpm2-policy.c

Ditto.

> @@ -323,3 +323,56 @@ int tpm2_get_policy_session(struct tpm_chip *chip, s=
truct tpm2_policies *pols)
> =20
>  	return 0;
>  }
> +
> +int tpm2_parse_policies(struct tpm2_policies **ppols, char *str)
> +{
> +	struct tpm2_policies *pols;
> +	char *p;
> +	u8 *ptr;
> +	int i =3D 0, left =3D PAGE_SIZE, res;
> +
> +	pols =3D kmalloc(left, GFP_KERNEL);
> +	if (!pols)
> +		return -ENOMEM;
> +
> +	ptr =3D (u8 *)(pols + 1);
> +	left -=3D ptr - (u8 *)pols;
> +
> +	while ((p =3D strsep(&str, "\n"))) {
> +		if (*p =3D=3D '\0' || *p =3D=3D '\n')
> +			continue;
> +
> +		pols->len[i] =3D strlen(p)/2;
> +		if (pols->len[i] > left) {
> +			res =3D -E2BIG;
> +			goto err;
> +		}
> +
> +		res =3D hex2bin(ptr, p, pols->len[i]);
> +		if (res)
> +			goto err;
> +
> +		/* get command code and skip past */
> +		pols->code[i] =3D get_unaligned_be32(ptr);
> +		pols->policies[i] =3D ptr + 4;
> +		ptr +=3D pols->len[i];
> +		left -=3D pols->len[i];
> +		pols->len[i] -=3D 4;
> +
> +		/*
> +		 * FIXME: this does leave the code embedded in dead
> +		 * regions of the memory, but it's easier than
> +		 * hexdumping to a temporary or copying over
> +		 */
> +		i++;
> +	}
> +
> +	pols->count =3D i;
> +	*ppols =3D pols;
> +
> +	return 0;
> +
> + err:
> +	kfree(pols);
> +	return res;
> +}
> diff --git a/security/keys/trusted-keys/tpm2-policy.h b/security/keys/tru=
sted-keys/tpm2-policy.h
> index b20e9c3e2f06..8ddf235b3fec 100644
> --- a/security/keys/trusted-keys/tpm2-policy.h
> +++ b/security/keys/trusted-keys/tpm2-policy.h
> @@ -28,6 +28,7 @@ int tpm2_generate_policy_digest(struct tpm2_policies *p=
ols, u32 hash,
>  				u8 *policydigest, u32 *plen);
>  int tpm2_encode_policy(struct tpm2_policies *pols, u8 **data, u32 *len);
>  int tpm2_get_policy_session(struct tpm_chip *chip, struct tpm2_policies =
*pols);
> +int tpm2_parse_policies(struct tpm2_policies **ppols, char *str);
>  #else
>  static inline int tpm2_key_policy_process(struct tpm2_key_context *ctx,
>  					  struct trusted_key_payload *payload)
> @@ -50,4 +51,8 @@ static inline int tpm2_get_policy_session(struct tpm_ch=
ip *chip,
>  {
>  	return -EINVAL;
>  }
> +static inline int tpm2_parse_policies(struct tpm2_policies **ppols, char=
 *str)
> +{
> +	return -EINVAL;
> +}
>  #endif
> diff --git a/security/keys/trusted-keys/trusted_tpm1.c b/security/keys/tr=
usted-keys/trusted_tpm1.c
> index 89c9798d1800..4dcc1373dd05 100644
> --- a/security/keys/trusted-keys/trusted_tpm1.c
> +++ b/security/keys/trusted-keys/trusted_tpm1.c
> @@ -22,6 +22,8 @@
> =20
>  #include <keys/trusted_tpm.h>
> =20
> +#include "tpm2-policy.h"
> +
>  static const char hmac_alg[] =3D "hmac(sha1)";
>  static const char hash_alg[] =3D "sha1";
>  static struct tpm_chip *chip;
> @@ -724,6 +726,7 @@ enum {
>  	Opt_hash,
>  	Opt_policydigest,
>  	Opt_policyhandle,
> +	Opt_policy,
>  };
> =20
>  static const match_table_t key_tokens =3D {
> @@ -736,6 +739,7 @@ static const match_table_t key_tokens =3D {
>  	{Opt_hash, "hash=3D%s"},
>  	{Opt_policydigest, "policydigest=3D%s"},
>  	{Opt_policyhandle, "policyhandle=3D%s"},
> +	{Opt_policy, "policy=3D%s"},
>  	{Opt_err, NULL}
>  };
> =20
> @@ -869,6 +873,17 @@ static int getoptions(char *c, struct trusted_key_pa=
yload *pay,
>  				return -EINVAL;
>  			opt->policyhandle =3D handle;
>  			break;
> +
> +		case Opt_policy:
> +			if (pay->policies)
> +				return -EINVAL;
> +			if (!tpm2)
> +				return -EINVAL;
> +			res =3D tpm2_parse_policies(&pay->policies, args[0].from);
> +			if (res)
> +				return res;
> +			break;
> +
>  		default:
>  			return -EINVAL;
>  		}

BR, Jarkko

