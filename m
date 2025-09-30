Return-Path: <linux-integrity+bounces-7309-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05D4CBACA30
	for <lists+linux-integrity@lfdr.de>; Tue, 30 Sep 2025 13:09:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B60133C7D82
	for <lists+linux-integrity@lfdr.de>; Tue, 30 Sep 2025 11:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07CAC23D287;
	Tue, 30 Sep 2025 11:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=earth.li header.i=@earth.li header.b="voJ6ybdW"
X-Original-To: linux-integrity@vger.kernel.org
Received: from the.earth.li (the.earth.li [93.93.131.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F0C23BF83;
	Tue, 30 Sep 2025 11:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.93.131.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759230588; cv=none; b=AF0TSr4U/E+fPswrvIeWEY9cGveAyiBflfbJ63JPkgB+UACoJDwDpMIf5YJzzbhLwdeWgQE1so+AbsYiuvLMoszfwcqBULeckzIKabAXUzyxbPREwOcUjxvMZLA9PdPeWhlqd8mMTHaqq3TzZP4UeTj3v/HOc6XenIKMBOrEZCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759230588; c=relaxed/simple;
	bh=+uM48FBNgAszSyWHgTOUgexeTYLwgEXzwU03YYcitSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aMpaksiV1MonKIoSBWIk278ebASIqTLS0j2iW4Xqfs658R5X5VKteO1e7JpyhmZjyUJv3WJ1dr+cHX5HskrX4WzRmAzYO/jwic4AunKEsIPc1UJTtNKKaV0K9pRE2xsQMc+E6u4ayKLCwg5WexL5c6gQW4PvhBeFyaJ0nZIRVTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li; spf=pass smtp.mailfrom=earth.li; dkim=pass (2048-bit key) header.d=earth.li header.i=@earth.li header.b=voJ6ybdW; arc=none smtp.client-ip=93.93.131.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=earth.li
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=earth.li;
	s=the; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:
	Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=gmYmDmPVGG6EDpdyOlVODOpmWPBaka9dH36EYjVQnao=; b=voJ6ybdWyIqRuHYMNfZmoGAXcI
	RentZSrbjUnBa12IO6d9Vecm2/YtAIcRNdMogYglDJfDxAyUWG5U5VC6m5kOkPv8PJusUKeQuR4T7
	baq/Co1F25DPvfdJyBwO9lRcO1ylgn4eB9rqfWZNX6d3tjQfhg90wfemSJFdyOAlQloJJqE9rXIm1
	7Qx2ULA7sL29UEbTE1Iuhn7rYw4WwmxCWQoFCWg9D8dm7ydu8k2osUiA9Wyxompdzu9Nfm5E5/uKY
	GpItQvVB56x3BPoPF1ESgLbgo3s5Kv3sdr7FxFmUXgIqEuwdV5UxrCWWmoFVDGq7Z2j4JORRMI+pD
	FDvgVc4Q==;
Received: from noodles by the.earth.li with local (Exim 4.96)
	(envelope-from <noodles@earth.li>)
	id 1v3YEN-006wrA-0F;
	Tue, 30 Sep 2025 12:09:15 +0100
Date: Tue, 30 Sep 2025 12:09:15 +0100
From: Jonathan McDowell <noodles@earth.li>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-integrity@vger.kernel.org, dpsmith@apertussolutions.com,
	ross.philipson@oracle.com,
	Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:KEYS/KEYRINGS" <keyrings@vger.kernel.org>,
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH v3 01/10] tpm: Cap the number of PCR banks
Message-ID: <aNu6W0GagfCliWTx@earth.li>
References: <20250929194832.2913286-1-jarkko@kernel.org>
 <20250929194832.2913286-2-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250929194832.2913286-2-jarkko@kernel.org>

On Mon, Sep 29, 2025 at 10:48:23PM +0300, Jarkko Sakkinen wrote:
> From: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
> 
> tpm2_get_pcr_allocation() does not cap any upper limit for the number of
> banks. Cap the limit to four banks so that out of bounds values coming
> from external I/O cause on only limited harm.
> 
> Cc: Roberto Sassu <roberto.sassu@huawei.com>
> Fixes: bcfff8384f6c ("tpm: dynamically allocate the allocated_banks array")
> Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
> ---
> v3:
> - Wrote a more clear commit message.
> - Fixed pr_err() message.
> v2:
> - A new patch.
> ---
>  drivers/char/tpm/tpm-chip.c | 13 +++++++++----
>  drivers/char/tpm/tpm.h      |  1 -
>  drivers/char/tpm/tpm1-cmd.c | 25 -------------------------
>  drivers/char/tpm/tpm2-cmd.c |  8 +++-----
>  include/linux/tpm.h         | 18 ++++++++----------
>  5 files changed, 20 insertions(+), 45 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
> index 687f6d8cd601..9a6538f76f50 100644
> --- a/drivers/char/tpm/tpm-chip.c
> +++ b/drivers/char/tpm/tpm-chip.c
> @@ -559,14 +559,19 @@ static int tpm_add_hwrng(struct tpm_chip *chip)
>  
>  static int tpm_get_pcr_allocation(struct tpm_chip *chip)
>  {
> -	int rc;
> +	int rc = 0;
>  
>  	if (tpm_is_firmware_upgrade(chip))
>  		return 0;
>  
> -	rc = (chip->flags & TPM_CHIP_FLAG_TPM2) ?
> -	     tpm2_get_pcr_allocation(chip) :
> -	     tpm1_get_pcr_allocation(chip);
> +	if (!(chip->flags & TPM_CHIP_FLAG_TPM2)) {
> +		chip->allocated_banks[0].alg_id = TPM_ALG_SHA1;
> +		chip->allocated_banks[0].digest_size = hash_digest_size[HASH_ALGO_SHA1];
> +		chip->allocated_banks[0].crypto_id = HASH_ALGO_SHA1;
> +		chip->nr_allocated_banks = 1;
> +	} else {
> +		rc = tpm2_get_pcr_allocation(chip);
> +	}
>  
>  	if (rc > 0)
>  		return -ENODEV;
> diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
> index 57ef8589f5f5..769fa6b00c54 100644
> --- a/drivers/char/tpm/tpm.h
> +++ b/drivers/char/tpm/tpm.h
> @@ -252,7 +252,6 @@ int tpm1_pcr_read(struct tpm_chip *chip, u32 pcr_idx, u8 *res_buf);
>  ssize_t tpm1_getcap(struct tpm_chip *chip, u32 subcap_id, cap_t *cap,
>  		    const char *desc, size_t min_cap_length);
>  int tpm1_get_random(struct tpm_chip *chip, u8 *out, size_t max);
> -int tpm1_get_pcr_allocation(struct tpm_chip *chip);
>  unsigned long tpm_calc_ordinal_duration(struct tpm_chip *chip, u32 ordinal);
>  int tpm_pm_suspend(struct device *dev);
>  int tpm_pm_resume(struct device *dev);
> diff --git a/drivers/char/tpm/tpm1-cmd.c b/drivers/char/tpm/tpm1-cmd.c
> index cf64c7385105..5c49bdff33de 100644
> --- a/drivers/char/tpm/tpm1-cmd.c
> +++ b/drivers/char/tpm/tpm1-cmd.c
> @@ -786,28 +786,3 @@ int tpm1_pm_suspend(struct tpm_chip *chip, u32 tpm_suspend_pcr)
>  
>  	return rc;
>  }
> -
> -/**
> - * tpm1_get_pcr_allocation() - initialize the allocated bank
> - * @chip: TPM chip to use.
> - *
> - * The function initializes the SHA1 allocated bank to extend PCR
> - *
> - * Return:
> - * * 0 on success,
> - * * < 0 on error.
> - */
> -int tpm1_get_pcr_allocation(struct tpm_chip *chip)
> -{
> -	chip->allocated_banks = kcalloc(1, sizeof(*chip->allocated_banks),
> -					GFP_KERNEL);
> -	if (!chip->allocated_banks)
> -		return -ENOMEM;
> -
> -	chip->allocated_banks[0].alg_id = TPM_ALG_SHA1;
> -	chip->allocated_banks[0].digest_size = hash_digest_size[HASH_ALGO_SHA1];
> -	chip->allocated_banks[0].crypto_id = HASH_ALGO_SHA1;
> -	chip->nr_allocated_banks = 1;
> -
> -	return 0;
> -}
> diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
> index 7d77f6fbc152..a7cddd4b5626 100644
> --- a/drivers/char/tpm/tpm2-cmd.c
> +++ b/drivers/char/tpm/tpm2-cmd.c
> @@ -538,11 +538,9 @@ ssize_t tpm2_get_pcr_allocation(struct tpm_chip *chip)
>  
>  	nr_possible_banks = be32_to_cpup(
>  		(__be32 *)&buf.data[TPM_HEADER_SIZE + 5]);
> -
> -	chip->allocated_banks = kcalloc(nr_possible_banks,
> -					sizeof(*chip->allocated_banks),
> -					GFP_KERNEL);
> -	if (!chip->allocated_banks) {
> +	if (nr_possible_banks > TPM2_MAX_BANKS) {
> +		pr_err("tpm: unexpected number of banks: %u > %u",
> +		       nr_possible_banks, TPM2_MAX_BANKS);
>  		rc = -ENOMEM;
>  		goto out;
>  	}
> diff --git a/include/linux/tpm.h b/include/linux/tpm.h
> index 900c81a2bc41..fc7df87dfb9a 100644
> --- a/include/linux/tpm.h
> +++ b/include/linux/tpm.h
> @@ -27,7 +27,12 @@
>  #include <crypto/aes.h>
>  
>  #define TPM_DIGEST_SIZE 20	/* Max TPM v1.2 PCR size */
> -#define TPM_MAX_DIGEST_SIZE SHA512_DIGEST_SIZE
> +#define TPM_HEADER_SIZE		10
> +
> +#define TPM2_PLATFORM_PCR	24
> +#define TPM2_PCR_SELECT_MIN	3

By changing this to 3 we lose the fact it's related to TPM2_PLATFORM_PCR 
- it's the number of bytes required to hold a bitmap with at least 
 TPM2_PLATFORM_PCR entries. Can we at least have a comment about that 
fact?

> +#define TPM2_MAX_DIGEST_SIZE	SHA512_DIGEST_SIZE
> +#define TPM2_MAX_BANKS		4

Where does this max come from? It matches what I see with swtpm by 
default (SHA1, SHA2-256, SHA2-384, SHA-512), so I haven't seen anything 
that exceeds it myself.

>  struct tpm_chip;
>  struct trusted_key_payload;
> @@ -69,7 +74,7 @@ enum tpm2_curves {
>  
>  struct tpm_digest {
>  	u16 alg_id;
> -	u8 digest[TPM_MAX_DIGEST_SIZE];
> +	u8 digest[TPM2_MAX_DIGEST_SIZE];
>  } __packed;
>  
>  struct tpm_bank_info {
> @@ -190,7 +195,7 @@ struct tpm_chip {
>  	unsigned int groups_cnt;
>  
>  	u32 nr_allocated_banks;
> -	struct tpm_bank_info *allocated_banks;
> +	struct tpm_bank_info allocated_banks[TPM2_MAX_BANKS];
>  #ifdef CONFIG_ACPI
>  	acpi_handle acpi_dev_handle;
>  	char ppi_version[TPM_PPI_VERSION_LEN + 1];
> @@ -217,13 +222,6 @@ struct tpm_chip {
>  #endif
>  };
>  
> -#define TPM_HEADER_SIZE		10
> -
> -enum tpm2_const {
> -	TPM2_PLATFORM_PCR       =     24,
> -	TPM2_PCR_SELECT_MIN     = ((TPM2_PLATFORM_PCR + 7) / 8),
> -};
> -
>  enum tpm2_timeouts {
>  	TPM2_TIMEOUT_A          =    750,
>  	TPM2_TIMEOUT_B          =   4000,
> -- 
> 2.39.5
> 
> 

J.

-- 
"How the f**k did you work that out?" -- Pythagoras

