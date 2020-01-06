Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2AAFC131AA7
	for <lists+linux-integrity@lfdr.de>; Mon,  6 Jan 2020 22:46:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbgAFVqH (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 6 Jan 2020 16:46:07 -0500
Received: from mga14.intel.com ([192.55.52.115]:8311 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726731AbgAFVqH (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 6 Jan 2020 16:46:07 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Jan 2020 13:46:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,403,1571727600"; 
   d="scan'208";a="210911633"
Received: from ryanchev-mobl.ger.corp.intel.com ([10.252.23.147])
  by orsmga007.jf.intel.com with ESMTP; 06 Jan 2020 13:46:03 -0800
Message-ID: <c03eb4a8aa3627f58bc45bbc23a4dcd660dc6e2f.camel@linux.intel.com>
Subject: Re: [PATCH v4 3/9] security: keys: trusted fix tpm2 authorizations
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        David Woodhouse <dwmw2@infradead.org>, keyrings@vger.kernel.org
In-Reply-To: <20191230173802.8731-4-James.Bottomley@HansenPartnership.com>
References: <20191230173802.8731-1-James.Bottomley@HansenPartnership.com>
         <20191230173802.8731-4-James.Bottomley@HansenPartnership.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160
 Espoo
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Date:   Mon, 06 Jan 2020 23:45:47 +0200
User-Agent: Evolution 3.34.1-2 
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2019-12-30 at 09:37 -0800, James Bottomley wrote:
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
> keyctl add trusted kmk "new 32 blobauth=f572d396fae9206628714fb2ce00f72e94f2258f"
> 
> after:
> 
> keyctl add trusted kmk "new 32 blobauth=hello keyhandle=81000001"
> 
> Note this is both and enhancement and a potential bug fix.  The TPM
> 2.0 spec requires us to strip leading zeros, meaning empyty
> authorization is a zero length HMAC whereas we're currently passing in
> 20 bytes of zeros.  A lot of TPMs simply accept this as OK, but the
> Microsoft TPM emulator rejects it with TPM_RC_BAD_AUTH, so this patch
> makes the Microsoft TPM emulator work with trusted keys.

Even if for good reasons, you should be explicit when you make an API
change that is not backwards compatible.

> 
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> ---
>  include/keys/trusted-type.h               |  1 +
>  security/keys/trusted-keys/trusted_tpm1.c | 24 +++++++++++++++++++-----
>  security/keys/trusted-keys/trusted_tpm2.c |  9 +++++----
>  3 files changed, 25 insertions(+), 9 deletions(-)
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
> index d2c5ec1e040b..ef15b6cda6ec 100644
> --- a/security/keys/trusted-keys/trusted_tpm1.c
> +++ b/security/keys/trusted-keys/trusted_tpm1.c
> @@ -781,12 +781,26 @@ static int getoptions(char *c, struct trusted_key_payload *pay,
>  				return -EINVAL;
>  			break;
>  		case Opt_blobauth:
> -			if (strlen(args[0].from) != 2 * SHA1_DIGEST_SIZE)
> -				return -EINVAL;
> -			res = hex2bin(opt->blobauth, args[0].from,
> -				      SHA1_DIGEST_SIZE);
> -			if (res < 0)
> +			/*
> +			 * TPM 1.2 authorizations are sha1 hashes
> +			 * passed in as hex strings.  TPM 2.0
> +			 * authorizations are simple passwords
> +			 * (although it can take a hash as well)
> +			 */
> +			opt->blobauth_len = strlen(args[0].from);
> +			if (opt->blobauth_len == 2 * TPM_DIGEST_SIZE) {
> +				res = hex2bin(opt->blobauth, args[0].from,
> +					      TPM_DIGEST_SIZE);
> +				if (res < 0)
> +					return -EINVAL;
> +				opt->blobauth_len = TPM_DIGEST_SIZE;
> +			} else if (tpm2 &&
> +				   opt->blobauth_len <= sizeof(opt->blobauth)) {
> +				memcpy(opt->blobauth, args[0].from,
> +				       opt->blobauth_len);
> +			} else {
>  				return -EINVAL;
> +			}

I don't see any reason of packing conditional statements like this even
if it has been done in the past. Makes the code only exhausting to read.

I'd consider moving the whole code block to a static function of its
own.  Please also document to that function how the passphrase is
handled in TPM 1.2 and TPM 2.0 (you can derive it from you commit
message description) just to remind us how it is being handled when
reviewing future patches.

>  			break;
>  		case Opt_migratable:
>  			if (*args[0].from == '0')
> diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
> index 08ec7f48f01d..11a331a94327 100644
> --- a/security/keys/trusted-keys/trusted_tpm2.c
> +++ b/security/keys/trusted-keys/trusted_tpm2.c
> @@ -91,10 +91,11 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
>  			     TPM_DIGEST_SIZE);
>  
>  	/* sensitive */
> -	tpm_buf_append_u16(&buf, 4 + TPM_DIGEST_SIZE + payload->key_len + 1);
> +	tpm_buf_append_u16(&buf, 4 + options->blobauth_len + payload->key_len + 1);
>  
> -	tpm_buf_append_u16(&buf, TPM_DIGEST_SIZE);
> -	tpm_buf_append(&buf, options->blobauth, TPM_DIGEST_SIZE);
> +	tpm_buf_append_u16(&buf, options->blobauth_len);

Empty line.

> +	if (options->blobauth_len)
> +		tpm_buf_append(&buf, options->blobauth, options->blobauth_len);

Empty line.

>  	tpm_buf_append_u16(&buf, payload->key_len + 1);
>  	tpm_buf_append(&buf, payload->key, payload->key_len);
>  	tpm_buf_append_u8(&buf, payload->migratable);
> @@ -258,7 +259,7 @@ static int tpm2_unseal_cmd(struct tpm_chip *chip,
>  			     NULL /* nonce */, 0,
>  			     TPM2_SA_CONTINUE_SESSION,
>  			     options->blobauth /* hmac */,
> -			     TPM_DIGEST_SIZE);
> +			     options->blobauth_len);
>  
>  	rc = tpm_send(chip, buf.data, tpm_buf_length(&buf));
>  	if (rc > 0)

/Jarkko

