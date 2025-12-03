Return-Path: <linux-integrity+bounces-7775-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B769C9D7A8
	for <lists+linux-integrity@lfdr.de>; Wed, 03 Dec 2025 02:12:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 455683484EB
	for <lists+linux-integrity@lfdr.de>; Wed,  3 Dec 2025 01:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3F571E8826;
	Wed,  3 Dec 2025 01:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lq/Oim19"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA27918A6AD;
	Wed,  3 Dec 2025 01:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764724319; cv=none; b=koV1T7ccsZX4qWBdFqHytbikbKk+yXM9NQIkDZt4pWzxLwE5vg9dEMuRQP0jj/I+XSZnMKpmBrzLOhtjpfVALWH5lkCW/XuV57Q0RF3gVw9EcChUb6vZjQhpqzzwWH99ag2GRfHb2aP87LqAKXmgv0jiLKJjXXOwXOm98FG5IyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764724319; c=relaxed/simple;
	bh=velcNMp2Hs2UlUnupGOYcRguLiA0gQCCNPu4KRMgg4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dAVbm/yD+V/P43t33105tVDhhQzPfGYTmrMM/+w0wWQ2sDgw32G9bpU1ODG1/J//LQp6bPzM/c03P1HXyqutqSyH7qn4xqhwrwDKMJC9TlBInmWKeydwLzVbKavkIcZIQhJ1k+8aq2vVfMFYtUg7JOdr+P8QdL/5orZAbN0PGi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lq/Oim19; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6B5FC4CEF1;
	Wed,  3 Dec 2025 01:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764724319;
	bh=velcNMp2Hs2UlUnupGOYcRguLiA0gQCCNPu4KRMgg4Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lq/Oim19GBFVqTUfzMGLZ52oeenQbbkcvTi9P9kYguVOzyinAM+BgvX1fbG9u/2lE
	 hZl54LO11yoGvaV83jEY0EAIcIEniPVeHkw3yPxxHnuzQeBwmIfK1X3VC0im822fZ6
	 WN9GkOmMlZp4atlEYFmB4QY2N2NHRrIzB8b/vL7y6TG5XP0wfzwfjrX7JcHbnb8Vn0
	 84Re0EVkoX+MzXFndP4o79fFNVFs3KDMfSqoahohaQl4CF8ER1SKhRo0IeAixZcrgh
	 hwJ4UJZ67hjRUiVoaCypNA56t6O9FGCOZpk0x2vCVygZFjcnXVT5VJsiYBY0wcAUg1
	 FZEnkMDpsC+HA==
Date: Wed, 3 Dec 2025 03:11:54 +0200
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
Message-ID: <aS-OWjUbhERbh3Za@kernel.org>
References: <20251127135445.2141241-1-jarkko@kernel.org>
 <20251127135445.2141241-2-jarkko@kernel.org>
 <aS+K5nO2MP7N+kxQ@ly-workstation>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aS+K5nO2MP7N+kxQ@ly-workstation>

On Wed, Dec 03, 2025 at 08:57:10AM +0800, Lai, Yi wrote:
> On Thu, Nov 27, 2025 at 03:54:33PM +0200, Jarkko Sakkinen wrote:
> > From: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
> > 
> > tpm2_get_pcr_allocation() does not cap any upper limit for the number of
> > banks. Cap the limit to eight banks so that out of bounds values coming
> > from external I/O cause on only limited harm.
> > 
> > Cc: Roberto Sassu <roberto.sassu@huawei.com>
> > Fixes: bcfff8384f6c ("tpm: dynamically allocate the allocated_banks array")
> > Reviewed-By: Jonathan McDowell <noodles@meta.com>
> > Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
> > ---
> > v7:
> > - In Ryzen desktop there is total three banks so yep, eight is probably
> >   much safer bet than four banks. Fixed the commit message as per remark
> >   from Jonathan:
> > 
> >   https://lore.kernel.org/linux-integrity/aPYg1N0TvrkG6AJI@earth.li/#t
> > 
> >   And with that added also reviewed-by.
> > v6
> > - No changes.
> > v5:
> > - No changes.
> > v4:
> > - Revert spurious changes from include/linux/tpm.h.
> > - Increase TPM2_MAX_BANKS to 8.
> > - Rename TPM2_MAX_BANKS as TPM2_MAX_PCR_BANKS for the sake of clarity.
> > v3:
> > - Wrote a more clear commit message.
> > - Fixed pr_err() message.
> > v2:
> > - A new patch.
> > ---
> >  drivers/char/tpm/tpm-chip.c | 13 +++++++++----
> >  drivers/char/tpm/tpm.h      |  1 -
> >  drivers/char/tpm/tpm1-cmd.c | 25 -------------------------
> >  drivers/char/tpm/tpm2-cmd.c |  8 +++-----
> >  include/linux/tpm.h         |  8 +++++---
> >  5 files changed, 17 insertions(+), 38 deletions(-)
> > 
> > diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
> > index e25daf2396d3..6cb25862688f 100644
> > --- a/drivers/char/tpm/tpm-chip.c
> > +++ b/drivers/char/tpm/tpm-chip.c
> > @@ -559,14 +559,19 @@ static int tpm_add_hwrng(struct tpm_chip *chip)
> >  
> >  static int tpm_get_pcr_allocation(struct tpm_chip *chip)
> >  {
> > -	int rc;
> > +	int rc = 0;
> >  
> >  	if (tpm_is_firmware_upgrade(chip))
> >  		return 0;
> >  
> > -	rc = (chip->flags & TPM_CHIP_FLAG_TPM2) ?
> > -	     tpm2_get_pcr_allocation(chip) :
> > -	     tpm1_get_pcr_allocation(chip);
> > +	if (!(chip->flags & TPM_CHIP_FLAG_TPM2)) {
> > +		chip->allocated_banks[0].alg_id = TPM_ALG_SHA1;
> > +		chip->allocated_banks[0].digest_size = hash_digest_size[HASH_ALGO_SHA1];
> > +		chip->allocated_banks[0].crypto_id = HASH_ALGO_SHA1;
> > +		chip->nr_allocated_banks = 1;
> > +	} else {
> > +		rc = tpm2_get_pcr_allocation(chip);
> > +	}
> >  
> >  	if (rc > 0)
> >  		return -ENODEV;
> > diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
> > index 2726bd38e5ac..a37712c02e44 100644
> > --- a/drivers/char/tpm/tpm.h
> > +++ b/drivers/char/tpm/tpm.h
> > @@ -252,7 +252,6 @@ int tpm1_pcr_read(struct tpm_chip *chip, u32 pcr_idx, u8 *res_buf);
> >  ssize_t tpm1_getcap(struct tpm_chip *chip, u32 subcap_id, cap_t *cap,
> >  		    const char *desc, size_t min_cap_length);
> >  int tpm1_get_random(struct tpm_chip *chip, u8 *out, size_t max);
> > -int tpm1_get_pcr_allocation(struct tpm_chip *chip);
> >  unsigned long tpm_calc_ordinal_duration(struct tpm_chip *chip, u32 ordinal);
> >  int tpm_pm_suspend(struct device *dev);
> >  int tpm_pm_resume(struct device *dev);
> > diff --git a/drivers/char/tpm/tpm1-cmd.c b/drivers/char/tpm/tpm1-cmd.c
> > index 11088bda4e68..708bc553437b 100644
> > --- a/drivers/char/tpm/tpm1-cmd.c
> > +++ b/drivers/char/tpm/tpm1-cmd.c
> > @@ -786,28 +786,3 @@ int tpm1_pm_suspend(struct tpm_chip *chip, u32 tpm_suspend_pcr)
> >  
> >  	return rc;
> >  }
> > -
> > -/**
> > - * tpm1_get_pcr_allocation() - initialize the allocated bank
> > - * @chip: TPM chip to use.
> > - *
> > - * The function initializes the SHA1 allocated bank to extend PCR
> > - *
> > - * Return:
> > - * * 0 on success,
> > - * * < 0 on error.
> > - */
> > -int tpm1_get_pcr_allocation(struct tpm_chip *chip)
> > -{
> > -	chip->allocated_banks = kcalloc(1, sizeof(*chip->allocated_banks),
> > -					GFP_KERNEL);
> > -	if (!chip->allocated_banks)
> > -		return -ENOMEM;
> > -
> > -	chip->allocated_banks[0].alg_id = TPM_ALG_SHA1;
> > -	chip->allocated_banks[0].digest_size = hash_digest_size[HASH_ALGO_SHA1];
> > -	chip->allocated_banks[0].crypto_id = HASH_ALGO_SHA1;
> > -	chip->nr_allocated_banks = 1;
> > -
> > -	return 0;
> > -}
> > diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
> > index 7d77f6fbc152..97501c567c34 100644
> > --- a/drivers/char/tpm/tpm2-cmd.c
> > +++ b/drivers/char/tpm/tpm2-cmd.c
> > @@ -538,11 +538,9 @@ ssize_t tpm2_get_pcr_allocation(struct tpm_chip *chip)
> >  
> >  	nr_possible_banks = be32_to_cpup(
> >  		(__be32 *)&buf.data[TPM_HEADER_SIZE + 5]);
> > -
> > -	chip->allocated_banks = kcalloc(nr_possible_banks,
> > -					sizeof(*chip->allocated_banks),
> > -					GFP_KERNEL);
> > -	if (!chip->allocated_banks) {
> > +	if (nr_possible_banks > TPM2_MAX_PCR_BANKS) {
> > +		pr_err("tpm: unexpected number of banks: %u > %u",
> > +		       nr_possible_banks, TPM2_MAX_PCR_BANKS);
> >  		rc = -ENOMEM;
> >  		goto out;
> >  	}
> > diff --git a/include/linux/tpm.h b/include/linux/tpm.h
> > index dc0338a783f3..eb0ff071bcae 100644
> > --- a/include/linux/tpm.h
> > +++ b/include/linux/tpm.h
> > @@ -26,7 +26,9 @@
> >  #include <crypto/aes.h>
> >  
> >  #define TPM_DIGEST_SIZE 20	/* Max TPM v1.2 PCR size */
> > -#define TPM_MAX_DIGEST_SIZE SHA512_DIGEST_SIZE
> > +
> > +#define TPM2_MAX_DIGEST_SIZE	SHA512_DIGEST_SIZE
> > +#define TPM2_MAX_PCR_BANKS	8
> >  
> >  struct tpm_chip;
> >  struct trusted_key_payload;
> > @@ -68,7 +70,7 @@ enum tpm2_curves {
> >  
> >  struct tpm_digest {
> >  	u16 alg_id;
> > -	u8 digest[TPM_MAX_DIGEST_SIZE];
> > +	u8 digest[TPM2_MAX_DIGEST_SIZE];
> >  } __packed;
> >  
> >  struct tpm_bank_info {
> > @@ -189,7 +191,7 @@ struct tpm_chip {
> >  	unsigned int groups_cnt;
> >  
> >  	u32 nr_allocated_banks;
> > -	struct tpm_bank_info *allocated_banks;
> > +	struct tpm_bank_info allocated_banks[TPM2_MAX_PCR_BANKS];
> >  #ifdef CONFIG_ACPI
> >  	acpi_handle acpi_dev_handle;
> >  	char ppi_version[TPM_PPI_VERSION_LEN + 1];
> > -- 
> > 2.52.0
> >
> 
> Hi Jarkko Sakkinen,
> 
> Greetings!
> 
> I used Syzkaller and found that there is KASAN: invalid-free in tpm_dev_release in linux-tpmdd branch tpmdd-next-6.19-rc1-v3.
> 
> After bisection and the first bad commit is:
> "
> 83f6ace27d21 tpm: Cap the number of PCR banks
   
Thank you. I updated the patch in my branch:

https://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git/commit/?id=bb731e948843a947b2b7e51552c1387e2c377e03

Possible to re-test (I can add your tested-by afterwards)?

BR, Jarkko

