Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AC7827E757
	for <lists+linux-integrity@lfdr.de>; Wed, 30 Sep 2020 13:02:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728500AbgI3LCl (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 30 Sep 2020 07:02:41 -0400
Received: from mga11.intel.com ([192.55.52.93]:13342 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725779AbgI3LCl (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 30 Sep 2020 07:02:41 -0400
IronPort-SDR: lfDDrDvhcbR1xdG9MaQe9cLe8UBZj/9mTy2uGmydTLB4Uxa4/5ElWaK8y7hmatgN42WrtN/dc4
 ZtT538pwB52g==
X-IronPort-AV: E=McAfee;i="6000,8403,9759"; a="159759449"
X-IronPort-AV: E=Sophos;i="5.77,322,1596524400"; 
   d="scan'208";a="159759449"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2020 04:02:39 -0700
IronPort-SDR: BCBhpW2bM7uRhFpHn8NfauXkbtTodbaBTF74YvZqsiFBo3+pWYI9cpHAypBJOR2Trtyaw/c1SV
 z1ct+EYmD8wQ==
X-IronPort-AV: E=Sophos;i="5.77,322,1596524400"; 
   d="scan'208";a="496985713"
Received: from lbentzio-mobl.ger.corp.intel.com (HELO localhost) ([10.252.32.88])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2020 04:02:37 -0700
Date:   Wed, 30 Sep 2020 14:02:34 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        David Woodhouse <dwmw2@infradead.org>,
        keyrings@vger.kernel.org, David Howells <dhowells@redhat.com>
Subject: Re: [PATCH v13 3/5] security: keys: trusted: fix TPM2 authorizations
Message-ID: <20200930110227.GA5145@linux.intel.com>
References: <20200922022809.7105-1-James.Bottomley@HansenPartnership.com>
 <20200922022809.7105-4-James.Bottomley@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200922022809.7105-4-James.Bottomley@HansenPartnership.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Sep 21, 2020 at 07:28:07PM -0700, James Bottomley wrote:
> In TPM 1.2 an authorization was a 20 byte number.  The spec actually
> recommended you to hash variable length passwords and use the sha1
> hash as the authorization.  Because the spec doesn't require this
> hashing, the current authorization for trusted keys is a 40 digit hex
> number.  For TPM 2.0 the spec allows the passing in of variable length
> passwords and passphrases directly, so we should allow that in trusted
> keys for ease of use.  Update the 'blobauth' parameter to take this
> into account, so we can now use plain text passwords for the keys.
> 
> so before
> 
> keyctl add trusted kmk "new 32 blobauth=f572d396fae9206628714fb2ce00f72e94f2258fkeyhandle=81000001" @u
> 
> after we will accept both the old hex sha1 form as well as a new
> directly supplied password:
> 
> keyctl add trusted kmk "new 32 blobauth=hello keyhandle=81000001" @u
> 
> Since a sha1 hex code must be exactly 40 bytes long and a direct
> password must be 20 or less, we use the length as the discriminator
> for which form is input.
> 
> Note this is both and enhancement and a potential bug fix.  The TPM
> 2.0 spec requires us to strip leading zeros, meaning empyty
> authorization is a zero length HMAC whereas we're currently passing in
> 20 bytes of zeros.  A lot of TPMs simply accept this as OK, but the
> Microsoft TPM emulator rejects it with TPM_RC_BAD_AUTH, so this patch
> makes the Microsoft TPM emulator work with trusted keys.
> 
> Fixes: 0fe5480303a1 ("keys, trusted: seal/unseal with TPM 2.0 chips")
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> 
> ---
> 
> v6: change comment, eliminate else clauses and add fixes tag
> v7: fixes before signoff
> v12: fix mismerge from v6 to make processing continue after blobauth
> 
> Merge with auth fix
> ---
>  include/keys/trusted-type.h               |  1 +
>  security/keys/trusted-keys/trusted_tpm1.c | 32 ++++++++++++++++++-----
>  security/keys/trusted-keys/trusted_tpm2.c | 10 ++++---
>  3 files changed, 33 insertions(+), 10 deletions(-)
> 
> diff --git a/include/keys/trusted-type.h b/include/keys/trusted-type.h
> index a94c03a61d8f..b2ed3481c6a0 100644
> --- a/include/keys/trusted-type.h
> +++ b/include/keys/trusted-type.h
> @@ -30,6 +30,7 @@ struct trusted_key_options {
>  	uint16_t keytype;
>  	uint32_t keyhandle;
>  	unsigned char keyauth[TPM_DIGEST_SIZE];
> +	uint32_t blobauth_len;
>  	unsigned char blobauth[TPM_DIGEST_SIZE];
>  	uint32_t pcrinfo_len;
>  	unsigned char pcrinfo[MAX_PCRINFO_SIZE];
> diff --git a/security/keys/trusted-keys/trusted_tpm1.c b/security/keys/trusted-keys/trusted_tpm1.c
> index b9fe02e5f84f..eaa2e7ca136e 100644
> --- a/security/keys/trusted-keys/trusted_tpm1.c
> +++ b/security/keys/trusted-keys/trusted_tpm1.c
> @@ -781,13 +781,33 @@ static int getoptions(char *c, struct trusted_key_payload *pay,
>  				return -EINVAL;
>  			break;
>  		case Opt_blobauth:
> -			if (strlen(args[0].from) != 2 * SHA1_DIGEST_SIZE)
> -				return -EINVAL;
> -			res = hex2bin(opt->blobauth, args[0].from,
> -				      SHA1_DIGEST_SIZE);
> -			if (res < 0)
> -				return -EINVAL;
> +			/*
> +			 * TPM 1.2 authorizations are sha1 hashes passed in as
> +			 * hex strings.  TPM 2.0 authorizations are simple
> +			 * passwords (although it can take a hash as well)
> +			 */
> +			opt->blobauth_len = strlen(args[0].from);
> +
> +			if (opt->blobauth_len == 2 * TPM_DIGEST_SIZE) {
> +				res = hex2bin(opt->blobauth, args[0].from,
> +					      TPM_DIGEST_SIZE);
> +				if (res < 0)
> +					return -EINVAL;
> +
> +				opt->blobauth_len = TPM_DIGEST_SIZE;
> +				break;
> +			}
> +
> +			if (tpm2 && opt->blobauth_len <= sizeof(opt->blobauth)) {
> +				memcpy(opt->blobauth, args[0].from,
> +				       opt->blobauth_len);
> +				break;
> +			}
> +
> +			return -EINVAL;
> +
>  			break;
> +
>  		case Opt_migratable:
>  			if (*args[0].from == '0')
>  				pay->migratable = 0;
> diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
> index 08ec7f48f01d..b4a5058107c2 100644
> --- a/security/keys/trusted-keys/trusted_tpm2.c
> +++ b/security/keys/trusted-keys/trusted_tpm2.c
> @@ -91,10 +91,12 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
>  			     TPM_DIGEST_SIZE);
>  
>  	/* sensitive */
> -	tpm_buf_append_u16(&buf, 4 + TPM_DIGEST_SIZE + payload->key_len + 1);
> +	tpm_buf_append_u16(&buf, 4 + options->blobauth_len + payload->key_len + 1);
> +
> +	tpm_buf_append_u16(&buf, options->blobauth_len);
> +	if (options->blobauth_len)
> +		tpm_buf_append(&buf, options->blobauth, options->blobauth_len);
>  
> -	tpm_buf_append_u16(&buf, TPM_DIGEST_SIZE);
> -	tpm_buf_append(&buf, options->blobauth, TPM_DIGEST_SIZE);
>  	tpm_buf_append_u16(&buf, payload->key_len + 1);
>  	tpm_buf_append(&buf, payload->key, payload->key_len);
>  	tpm_buf_append_u8(&buf, payload->migratable);
> @@ -258,7 +260,7 @@ static int tpm2_unseal_cmd(struct tpm_chip *chip,
>  			     NULL /* nonce */, 0,
>  			     TPM2_SA_CONTINUE_SESSION,
>  			     options->blobauth /* hmac */,
> -			     TPM_DIGEST_SIZE);
> +			     options->blobauth_len);
>  
>  	rc = tpm_send(chip, buf.data, tpm_buf_length(&buf));
>  	if (rc > 0)
> -- 
> 2.26.2
> 

Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

Transcript:

➜  tpm2-scripts (master) ✗ sudo ./tpm2-root-key
0x80000000
➜  tpm2-scripts (master) ✗ sudo keyctl add trusted kmk "new 32 blobauth=hello keyhandle=80000000" @u
751240563

/Jarkko
