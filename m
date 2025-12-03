Return-Path: <linux-integrity+bounces-7777-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A035EC9D89F
	for <lists+linux-integrity@lfdr.de>; Wed, 03 Dec 2025 02:55:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 408704E4562
	for <lists+linux-integrity@lfdr.de>; Wed,  3 Dec 2025 01:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A62A2343C0;
	Wed,  3 Dec 2025 01:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="plcLk4km"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33309231A30;
	Wed,  3 Dec 2025 01:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764726855; cv=none; b=C2/T3uiGTRNsKnyfwB6bO6zv3r/AlPBd+WPkDx4LwFEi+6CVqhDDBW2oWzBgK2tBpfCRJcReEapCXu+9AFoApomTCv9F9dWjn2zvzk6TUjxFTXbH0EjxV9rxPORegZdbeZ1734zFC5B0CsCMooa+K1WNoM2wXim+LeF0r75MNT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764726855; c=relaxed/simple;
	bh=u9i26Ge7fShtrBmgHmP+jVs4HiBM3DAatxWtY04wBQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=erD+YchFbKSWDcYX13lNDu3rlRh4DWl3FTfd9eOQYhnrqBlLQ7hrZ0qWu8O5QcpYDHbKsDUj1T1ZCgtB8QB986HfbkpphPjWj48NOYJMnhD7qBwrshTw/LKc0v+Ozkvecnq2wIlJ3Izr/6QaBfrjQ7yxZ2Ow0vL9SXTjp012AK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=plcLk4km; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DD65C4CEF1;
	Wed,  3 Dec 2025 01:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764726855;
	bh=u9i26Ge7fShtrBmgHmP+jVs4HiBM3DAatxWtY04wBQI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=plcLk4kmTT39s6Rdb6KzCqhh0gJzh427uCqeSkaaWdxcwKVZ+NU77g+t2S2sgbjcr
	 PG0EXksjDH6yGteKqKwidafziheO6SGbZ5eetcvq7AwN4xIdn8PQqmidG9vmCFYmZR
	 rY4GgfxOdaZEqRWarLMYZoxsB2aA/0aFqPx9+JEkDdj2/1jk0tf4L7dz2KFUwMnxwb
	 FP9GYCWTOgcRJAyEhomFxrWBfi889dquPVuA+MoehNYlSxLerDTBoLqBS8FvSbrcmM
	 O120UxVqSsh+adyardn9TwyjWmxgFkXTXSlfZTZlK3xhKhTK4MpqsGlHvPETScdngn
	 MoSKdTs620XWg==
Date: Wed, 3 Dec 2025 03:54:10 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: "Lai, Yi" <yi1.lai@linux.intel.com>
Cc: linux-integrity@vger.kernel.org, ross.philipson@oracle.com,
	Jonathan McDowell <noodles@earth.li>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Jonathan McDowell <noodles@meta.com>,
	Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	linux-kernel@vger.kernel.org, yi1.lai@intel.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH v7 01/11] tpm: Cap the number of PCR banks
Message-ID: <aS-YQjztmfbJCKNd@kernel.org>
References: <20251127135445.2141241-1-jarkko@kernel.org>
 <20251127135445.2141241-2-jarkko@kernel.org>
 <aS+K5nO2MP7N+kxQ@ly-workstation>
 <aS-OWjUbhERbh3Za@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aS-OWjUbhERbh3Za@kernel.org>

On Wed, Dec 03, 2025 at 03:11:59AM +0200, Jarkko Sakkinen wrote:
> On Wed, Dec 03, 2025 at 08:57:10AM +0800, Lai, Yi wrote:
> > On Thu, Nov 27, 2025 at 03:54:33PM +0200, Jarkko Sakkinen wrote:
> > > From: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
> > > 
> > > tpm2_get_pcr_allocation() does not cap any upper limit for the number of
> > > banks. Cap the limit to eight banks so that out of bounds values coming
> > > from external I/O cause on only limited harm.
> > > 
> > > Cc: Roberto Sassu <roberto.sassu@huawei.com>
> > > Fixes: bcfff8384f6c ("tpm: dynamically allocate the allocated_banks array")
> > > Reviewed-By: Jonathan McDowell <noodles@meta.com>
> > > Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
> > > ---
> > > v7:
> > > - In Ryzen desktop there is total three banks so yep, eight is probably
> > >   much safer bet than four banks. Fixed the commit message as per remark
> > >   from Jonathan:
> > > 
> > >   https://lore.kernel.org/linux-integrity/aPYg1N0TvrkG6AJI@earth.li/#t
> > > 
> > >   And with that added also reviewed-by.
> > > v6
> > > - No changes.
> > > v5:
> > > - No changes.
> > > v4:
> > > - Revert spurious changes from include/linux/tpm.h.
> > > - Increase TPM2_MAX_BANKS to 8.
> > > - Rename TPM2_MAX_BANKS as TPM2_MAX_PCR_BANKS for the sake of clarity.
> > > v3:
> > > - Wrote a more clear commit message.
> > > - Fixed pr_err() message.
> > > v2:
> > > - A new patch.
> > > ---
> > >  drivers/char/tpm/tpm-chip.c | 13 +++++++++----
> > >  drivers/char/tpm/tpm.h      |  1 -
> > >  drivers/char/tpm/tpm1-cmd.c | 25 -------------------------
> > >  drivers/char/tpm/tpm2-cmd.c |  8 +++-----
> > >  include/linux/tpm.h         |  8 +++++---
> > >  5 files changed, 17 insertions(+), 38 deletions(-)
> > > 
> > > diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
> > > index e25daf2396d3..6cb25862688f 100644
> > > --- a/drivers/char/tpm/tpm-chip.c
> > > +++ b/drivers/char/tpm/tpm-chip.c
> > > @@ -559,14 +559,19 @@ static int tpm_add_hwrng(struct tpm_chip *chip)
> > >  
> > >  static int tpm_get_pcr_allocation(struct tpm_chip *chip)
> > >  {
> > > -	int rc;
> > > +	int rc = 0;
> > >  
> > >  	if (tpm_is_firmware_upgrade(chip))
> > >  		return 0;
> > >  
> > > -	rc = (chip->flags & TPM_CHIP_FLAG_TPM2) ?
> > > -	     tpm2_get_pcr_allocation(chip) :
> > > -	     tpm1_get_pcr_allocation(chip);
> > > +	if (!(chip->flags & TPM_CHIP_FLAG_TPM2)) {
> > > +		chip->allocated_banks[0].alg_id = TPM_ALG_SHA1;
> > > +		chip->allocated_banks[0].digest_size = hash_digest_size[HASH_ALGO_SHA1];
> > > +		chip->allocated_banks[0].crypto_id = HASH_ALGO_SHA1;
> > > +		chip->nr_allocated_banks = 1;
> > > +	} else {
> > > +		rc = tpm2_get_pcr_allocation(chip);
> > > +	}
> > >  
> > >  	if (rc > 0)
> > >  		return -ENODEV;
> > > diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
> > > index 2726bd38e5ac..a37712c02e44 100644
> > > --- a/drivers/char/tpm/tpm.h
> > > +++ b/drivers/char/tpm/tpm.h
> > > @@ -252,7 +252,6 @@ int tpm1_pcr_read(struct tpm_chip *chip, u32 pcr_idx, u8 *res_buf);
> > >  ssize_t tpm1_getcap(struct tpm_chip *chip, u32 subcap_id, cap_t *cap,
> > >  		    const char *desc, size_t min_cap_length);
> > >  int tpm1_get_random(struct tpm_chip *chip, u8 *out, size_t max);
> > > -int tpm1_get_pcr_allocation(struct tpm_chip *chip);
> > >  unsigned long tpm_calc_ordinal_duration(struct tpm_chip *chip, u32 ordinal);
> > >  int tpm_pm_suspend(struct device *dev);
> > >  int tpm_pm_resume(struct device *dev);
> > > diff --git a/drivers/char/tpm/tpm1-cmd.c b/drivers/char/tpm/tpm1-cmd.c
> > > index 11088bda4e68..708bc553437b 100644
> > > --- a/drivers/char/tpm/tpm1-cmd.c
> > > +++ b/drivers/char/tpm/tpm1-cmd.c
> > > @@ -786,28 +786,3 @@ int tpm1_pm_suspend(struct tpm_chip *chip, u32 tpm_suspend_pcr)
> > >  
> > >  	return rc;
> > >  }
> > > -
> > > -/**
> > > - * tpm1_get_pcr_allocation() - initialize the allocated bank
> > > - * @chip: TPM chip to use.
> > > - *
> > > - * The function initializes the SHA1 allocated bank to extend PCR
> > > - *
> > > - * Return:
> > > - * * 0 on success,
> > > - * * < 0 on error.
> > > - */
> > > -int tpm1_get_pcr_allocation(struct tpm_chip *chip)
> > > -{
> > > -	chip->allocated_banks = kcalloc(1, sizeof(*chip->allocated_banks),
> > > -					GFP_KERNEL);
> > > -	if (!chip->allocated_banks)
> > > -		return -ENOMEM;
> > > -
> > > -	chip->allocated_banks[0].alg_id = TPM_ALG_SHA1;
> > > -	chip->allocated_banks[0].digest_size = hash_digest_size[HASH_ALGO_SHA1];
> > > -	chip->allocated_banks[0].crypto_id = HASH_ALGO_SHA1;
> > > -	chip->nr_allocated_banks = 1;
> > > -
> > > -	return 0;
> > > -}
> > > diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
> > > index 7d77f6fbc152..97501c567c34 100644
> > > --- a/drivers/char/tpm/tpm2-cmd.c
> > > +++ b/drivers/char/tpm/tpm2-cmd.c
> > > @@ -538,11 +538,9 @@ ssize_t tpm2_get_pcr_allocation(struct tpm_chip *chip)
> > >  
> > >  	nr_possible_banks = be32_to_cpup(
> > >  		(__be32 *)&buf.data[TPM_HEADER_SIZE + 5]);
> > > -
> > > -	chip->allocated_banks = kcalloc(nr_possible_banks,
> > > -					sizeof(*chip->allocated_banks),
> > > -					GFP_KERNEL);
> > > -	if (!chip->allocated_banks) {
> > > +	if (nr_possible_banks > TPM2_MAX_PCR_BANKS) {
> > > +		pr_err("tpm: unexpected number of banks: %u > %u",
> > > +		       nr_possible_banks, TPM2_MAX_PCR_BANKS);
> > >  		rc = -ENOMEM;
> > >  		goto out;
> > >  	}
> > > diff --git a/include/linux/tpm.h b/include/linux/tpm.h
> > > index dc0338a783f3..eb0ff071bcae 100644
> > > --- a/include/linux/tpm.h
> > > +++ b/include/linux/tpm.h
> > > @@ -26,7 +26,9 @@
> > >  #include <crypto/aes.h>
> > >  
> > >  #define TPM_DIGEST_SIZE 20	/* Max TPM v1.2 PCR size */
> > > -#define TPM_MAX_DIGEST_SIZE SHA512_DIGEST_SIZE
> > > +
> > > +#define TPM2_MAX_DIGEST_SIZE	SHA512_DIGEST_SIZE
> > > +#define TPM2_MAX_PCR_BANKS	8
> > >  
> > >  struct tpm_chip;
> > >  struct trusted_key_payload;
> > > @@ -68,7 +70,7 @@ enum tpm2_curves {
> > >  
> > >  struct tpm_digest {
> > >  	u16 alg_id;
> > > -	u8 digest[TPM_MAX_DIGEST_SIZE];
> > > +	u8 digest[TPM2_MAX_DIGEST_SIZE];
> > >  } __packed;
> > >  
> > >  struct tpm_bank_info {
> > > @@ -189,7 +191,7 @@ struct tpm_chip {
> > >  	unsigned int groups_cnt;
> > >  
> > >  	u32 nr_allocated_banks;
> > > -	struct tpm_bank_info *allocated_banks;
> > > +	struct tpm_bank_info allocated_banks[TPM2_MAX_PCR_BANKS];
> > >  #ifdef CONFIG_ACPI
> > >  	acpi_handle acpi_dev_handle;
> > >  	char ppi_version[TPM_PPI_VERSION_LEN + 1];
> > > -- 
> > > 2.52.0
> > >
> > 
> > Hi Jarkko Sakkinen,
> > 
> > Greetings!
> > 
> > I used Syzkaller and found that there is KASAN: invalid-free in tpm_dev_release in linux-tpmdd branch tpmdd-next-6.19-rc1-v3.
> > 
> > After bisection and the first bad commit is:
> > "
> > 83f6ace27d21 tpm: Cap the number of PCR banks
>    
> Thank you. I updated the patch in my branch:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git/commit/?id=bb731e948843a947b2b7e51552c1387e2c377e03
> 
> Possible to re-test (I can add your tested-by afterwards)?

I mean tested-by AND reported-by.

BR, Jarkko

