Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA4AF38D7AD
	for <lists+linux-integrity@lfdr.de>; Sun, 23 May 2021 00:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231465AbhEVWmH (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 22 May 2021 18:42:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:51270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231461AbhEVWmG (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 22 May 2021 18:42:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E14E461074;
        Sat, 22 May 2021 22:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621723241;
        bh=v5Nkwa7pAvGXhn5bc6Jvkeb8hs+rDKYEa1Z+8Te4xt8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AlXNpxBUOj08S6LxIk+UdySmH/1ELItBTXwe2Si0zAIhDumWbCDO7k+hjaSdISgFe
         py7nkxhIs/xDLlTJa35PsGNYlfSqLOrz/mVATtEY19ZB/oA4EQ2ET52H5qehUPw92X
         Qg3CmyDNUkCpmj9/L+dKS4UW7rhRWWC229c5vcgsqkoTkXc4NYgUlTiKw/3eUzbyM+
         m9nMl2H7yj5z3hA3ph9/lCgsObjV26rP9ytf522RItCF7kk7PT5JLuWeaZqBddSZyz
         6E52OpFH5nUmETV1DvpoZz9/BHhbow7AY69GfUvh3hKijelNMcEbyoL0bvOMrQjuqR
         zsp05LrJIdRnw==
Date:   Sun, 23 May 2021 01:40:39 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        David Woodhouse <dwmw2@infradead.org>,
        keyrings@vger.kernel.org, David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 2/4] security: keys: trusted: add ability to specify
 arbitrary policy
Message-ID: <YKmIZ+PZ1vSE+tLd@kernel.org>
References: <20210521004401.4167-1-James.Bottomley@HansenPartnership.com>
 <20210521004401.4167-3-James.Bottomley@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210521004401.4167-3-James.Bottomley@HansenPartnership.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, May 20, 2021 at 05:43:59PM -0700, James Bottomley wrote:
> This patch adds a policy= argument to key creation.  The policy is the
> standard tss policymaker format and each separate policy line must
> have a newline after it.
> 
> Thus to construct a policy requiring authorized value and pcr 16
> locking using a sha256 hash, the policy (policy.txt) file would be two
> lines:
> 
> 0000017F00000001000B03000001303095B49BE85E381E5B20E557E46363EF55B0F43B132C2D8E3DE9AC436656F2
> 0000016b
> 
> This can be inserted into the key with
> 
> keyctl add trusted kmk "new 32 policy=`cat policy.txt` keyhandle=0x81000001 hash=sha256" @u
> 
> Note that although a few policies work like this, most require special
> handling which must be added to the kernel policy construction
> routine.
> 
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> ---
>  .../security/keys/trusted-encrypted.rst       | 16 ++++++
>  security/keys/trusted-keys/tpm2-policy.c      | 53 +++++++++++++++++++
>  security/keys/trusted-keys/tpm2-policy.h      |  1 +
>  security/keys/trusted-keys/trusted_tpm1.c     | 15 ++++++
>  security/keys/trusted-keys/trusted_tpm2.c     |  4 ++
>  5 files changed, 89 insertions(+)
> 
> diff --git a/Documentation/security/keys/trusted-encrypted.rst b/Documentation/security/keys/trusted-encrypted.rst
> index 5c66f29b7a1c..883844c95e91 100644
> --- a/Documentation/security/keys/trusted-encrypted.rst
> +++ b/Documentation/security/keys/trusted-encrypted.rst
> @@ -172,6 +172,9 @@ Usage::
>         policyhandle= handle to an authorization policy session that defines the
>                       same policy and with the same hash algorithm as was used to
>                       seal the key.
> +       policy=       specify an arbitrary set of policies.  These must
> +                     be in policymaker format with each separate
> +                     policy line newline terminated.
>  
>  "keyctl print" returns an ascii hex copy of the sealed key, which is in standard
>  TPM_STORED_DATA format.  The key length for new keys are always in bytes.
> @@ -271,6 +274,19 @@ zeros (the value of PCR 16)::
>      $ dd if=/dev/zero bs=1 count=20 2>/dev/null|sha1sum
>      6768033e216468247bd031a0a2d9876d79818f8f
>  
> +You can also specify arbitrary policy in policymaker format, so a two
> +value policy (the pcr example above and authvalue) would look like
> +this in policymaker format::
> +
> +    0000017F000000010004030000016768033e216468247bd031a0a2d9876d79818f8f
> +    0000016b
> +
> +This can be placed in a file (say policy.txt) and then added to the key as::
> +
> +    $ keyctl add trusted kmk "new 32 keyhandle=0x81000001 hash=sha1 policy=`cat policy.txt`" @u
> +
> +The newlines in the file policy.txt will be automatically processed.
> +
>  Reseal (TPM specific) a trusted key under new PCR values::
>  
>      $ keyctl update 268728824 "update pcrinfo=`cat pcr.blob`"
> diff --git a/security/keys/trusted-keys/tpm2-policy.c b/security/keys/trusted-keys/tpm2-policy.c
> index b05b2953d5ea..bb28c864fa9b 100644
> --- a/security/keys/trusted-keys/tpm2-policy.c
> +++ b/security/keys/trusted-keys/tpm2-policy.c
> @@ -357,3 +357,56 @@ int tpm2_get_policy_session(struct tpm_chip *chip, struct tpm2_policies *pols,
>  
>  	return 0;
>  }
> +
> +int tpm2_parse_policies(struct tpm2_policies **ppols, char *str)
> +{
> +	struct tpm2_policies *pols;
> +	char *p;
> +	u8 *ptr;
> +	int i = 0, left = PAGE_SIZE, res;
> +
> +	pols = kmalloc(left, GFP_KERNEL);
> +	if (!pols)
> +		return -ENOMEM;
> +
> +	ptr = (u8 *)(pols + 1);
> +	left -= ptr - (u8 *)pols;
> +
> +	while ((p = strsep(&str, "\n"))) {
> +		if (*p == '\0' || *p == '\n')
> +			continue;
> +
> +		pols->len[i] = strlen(p)/2;
> +		if (pols->len[i] > left) {
> +			res = -E2BIG;
> +			goto err;
> +		}
> +
> +		res = hex2bin(ptr, p, pols->len[i]);
> +		if (res)
> +			goto err;
> +
> +		/* get command code and skip past */
> +		pols->code[i] = get_unaligned_be32(ptr);
> +		pols->policies[i] = ptr + 4;
> +		ptr += pols->len[i];
> +		left -= pols->len[i];
> +		pols->len[i] -= 4;
> +
> +		/*
> +		 * FIXME: this does leave the code embedded in dead
> +		 * regions of the memory, but it's easier than
> +		 * hexdumping to a temporary or copying over

What is "this"?

> +		 */
> +		i++;
> +	}
> +
> +	pols->count = i;
> +	*ppols = pols;
> +
> +	return 0;
> +
> + err:
> +	kfree(pols);
> +	return res;
> +}
> diff --git a/security/keys/trusted-keys/tpm2-policy.h b/security/keys/trusted-keys/tpm2-policy.h
> index 46bf1f0a9325..0da013116c1c 100644
> --- a/security/keys/trusted-keys/tpm2-policy.h
> +++ b/security/keys/trusted-keys/tpm2-policy.h
> @@ -28,3 +28,4 @@ int tpm2_generate_policy_digest(struct tpm2_policies *pols, u32 hash,
>  int tpm2_encode_policy(struct tpm2_policies *pols, u8 **data, u32 *len);
>  int tpm2_get_policy_session(struct tpm_chip *chip, struct tpm2_policies *pols,
>  			    u32 *handle);
> +int tpm2_parse_policies(struct tpm2_policies **ppols, char *str);
> diff --git a/security/keys/trusted-keys/trusted_tpm1.c b/security/keys/trusted-keys/trusted_tpm1.c
> index aa108bea6739..6ed7303e36b5 100644
> --- a/security/keys/trusted-keys/trusted_tpm1.c
> +++ b/security/keys/trusted-keys/trusted_tpm1.c
> @@ -22,6 +22,8 @@
>  
>  #include <keys/trusted_tpm.h>
>  
> +#include "tpm2-policy.h"
> +
>  static const char hmac_alg[] = "hmac(sha1)";
>  static const char hash_alg[] = "sha1";
>  static struct tpm_chip *chip;
> @@ -713,6 +715,7 @@ enum {
>  	Opt_hash,
>  	Opt_policydigest,
>  	Opt_policyhandle,
> +	Opt_policy,
>  };
>  
>  static const match_table_t key_tokens = {
> @@ -725,6 +728,7 @@ static const match_table_t key_tokens = {
>  	{Opt_hash, "hash=%s"},
>  	{Opt_policydigest, "policydigest=%s"},
>  	{Opt_policyhandle, "policyhandle=%s"},
> +	{Opt_policy, "policy=%s"},
>  	{Opt_err, NULL}
>  };
>  
> @@ -858,6 +862,17 @@ static int getoptions(char *c, struct trusted_key_payload *pay,
>  				return -EINVAL;
>  			opt->policyhandle = handle;
>  			break;
> +
> +		case Opt_policy:
> +			if (pay->policies)
> +				return -EINVAL;
> +			if (!tpm2)
> +				return -EINVAL;
> +			res = tpm2_parse_policies(&pay->policies, args[0].from);
> +			if (res)
> +				return res;
> +			break;
> +
>  		default:
>  			return -EINVAL;
>  		}
> diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
> index a218f982fef5..afe9cc41885e 100644
> --- a/security/keys/trusted-keys/trusted_tpm2.c
> +++ b/security/keys/trusted-keys/trusted_tpm2.c
> @@ -268,6 +268,10 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
>  		/* 4 array len, 2 hash alg */
>  		const int len = 4 + 2 + options->pcrinfo_len;
>  
> +		if (payload->policies)
> +			/* can't specify pcr and general policy */
> +			return -EINVAL;
> +
>  		pols = kmalloc(sizeof(*pols) + len, GFP_KERNEL);
>  		if (!pols)
>  			return -ENOMEM;
> -- 
> 2.26.2
> 
> 

/Jarkko
