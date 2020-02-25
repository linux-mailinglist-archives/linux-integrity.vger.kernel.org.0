Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0B0C16EBB6
	for <lists+linux-integrity@lfdr.de>; Tue, 25 Feb 2020 17:48:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729193AbgBYQsy (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 25 Feb 2020 11:48:54 -0500
Received: from mga12.intel.com ([192.55.52.136]:47869 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728200AbgBYQsx (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 25 Feb 2020 11:48:53 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Feb 2020 08:48:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,484,1574150400"; 
   d="scan'208";a="271377075"
Received: from gbwalsh-mobl6.ger.corp.intel.com (HELO localhost) ([10.252.26.72])
  by fmsmga002.fm.intel.com with ESMTP; 25 Feb 2020 08:48:51 -0800
Date:   Tue, 25 Feb 2020 18:48:50 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        David Woodhouse <dwmw2@infradead.org>, keyrings@vger.kernel.org
Subject: Re: [PATCH v5 3/6] security: keys: trusted fix tpm2 authorizations
Message-ID: <20200225164850.GB15662@linux.intel.com>
References: <20200130101812.6271-1-James.Bottomley@HansenPartnership.com>
 <20200130101812.6271-4-James.Bottomley@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200130101812.6271-4-James.Bottomley@HansenPartnership.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Jan 30, 2020 at 11:18:09AM +0100, James Bottomley wrote:
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
> after we will accept both the old hex sha1 form as well as a new
> directly supplied password:
> 
> keyctl add trusted kmk "new 32 blobauth=hello keyhandle=81000001"
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
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>

Should have a fixes tag.

> ---
>  include/keys/trusted-type.h               |  1 +
>  security/keys/trusted-keys/trusted_tpm1.c | 26 +++++++++++++++++++++-----
>  security/keys/trusted-keys/trusted_tpm2.c | 10 ++++++----
>  3 files changed, 28 insertions(+), 9 deletions(-)
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
> index d2c5ec1e040b..3f33d3f74d3c 100644
> --- a/security/keys/trusted-keys/trusted_tpm1.c
> +++ b/security/keys/trusted-keys/trusted_tpm1.c
> @@ -781,12 +781,28 @@ static int getoptions(char *c, struct trusted_key_payload *pay,
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

Justify to the 80 character line length.

> +			 */
> +			opt->blobauth_len = strlen(args[0].from);
> +			if (opt->blobauth_len == 2 * TPM_DIGEST_SIZE) {
> +				res = hex2bin(opt->blobauth, args[0].from,
> +					      TPM_DIGEST_SIZE);
> +				if (res < 0)
> +					return -EINVAL;
> +
> +				opt->blobauth_len = TPM_DIGEST_SIZE;
> +			} else if (tpm2 &&
> +				   opt->blobauth_len <= sizeof(opt->blobauth)) {
> +				memcpy(opt->blobauth, args[0].from,
> +				       opt->blobauth_len);
> +			} else {
>  				return -EINVAL;
> +			}

This starts to be unnecessarily complicated.

This is what I would suggest:

opt->blobauth_len = strlen(args[0].from);
if (opt->blobauth_len == 2 * TPM_DIGEST_SIZE) {
	res = hex2bin(opt->blobauth, args[0].from,
		      TPM_DIGEST_SIZE);
	if (res < 0)
		return -EINVAL;

	opt->blobauth_len = TPM_DIGEST_SIZE;
	return 0;
}

if (tpm2 && opt->blobauth_len <= sizeof(opt->blobauth)) {
	memcpy(opt->blobauth, args[0].from,
	       opt->blobauth_len);
	return 0;
}

return -EINVAL;

Easier to see quickly "when happens what".

/Jarkko
