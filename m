Return-Path: <linux-integrity+bounces-7701-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9228CC8F734
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Nov 2025 17:10:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4814D35109B
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Nov 2025 16:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8A243375AE;
	Thu, 27 Nov 2025 16:09:57 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E90B3375D0;
	Thu, 27 Nov 2025 16:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764259797; cv=none; b=CLfWFuOGTankvgEUEY19W6inatRYRbIUjfisKAqutNbRdppkb8TJYhgpBtt0ZYs42WUpcUns0OXjDQfGQgr3kXI3ykt4kfPcxi0GY+hGISd5txTkArfcFXnu/8emRRfo+UxWQxd0UXQtnvG3mNttMI2qfixc/SX/dVlKwHG7qMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764259797; c=relaxed/simple;
	bh=4YulYiNqHFiMsOgRZSfjIOwW89ySualm8GgDPQZwadk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Smq/YTaF7uh4vxrEBpSjwNHQprJG3EX6aeclc1iLKkHDwr3Jz4OTleKd6GofSX4hNwvlg1jPFUk28frqRIQ1LMsdq0rr6lrsUdR+JxTFCCfb/vr187XBmugUMLLOw6DpVg8odiiqwIHSd8dOm0ZfhCl329YvkqfZFXIIiDe+skQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTPS id 4dHLvJ6lVRzpTV9;
	Fri, 28 Nov 2025 00:08:28 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 232411400CA;
	Fri, 28 Nov 2025 00:09:52 +0800 (CST)
Received: from [10.204.63.22] (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwBX4onFdyhpTasuAQ--.16496S2;
	Thu, 27 Nov 2025 17:09:51 +0100 (CET)
Message-ID: <69de8fea4851ef378613e66685c3c34c43d71f05.camel@huaweicloud.com>
Subject: Re: [PATCH v7 01/11] tpm: Cap the number of PCR banks
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Jarkko Sakkinen <jarkko@kernel.org>, linux-integrity@vger.kernel.org
Cc: ross.philipson@oracle.com, Jonathan McDowell <noodles@earth.li>, Stefano
 Garzarella <sgarzare@redhat.com>, Jarkko Sakkinen
 <jarkko.sakkinen@opinsys.com>, Roberto Sassu <roberto.sassu@huawei.com>,
 Jonathan McDowell <noodles@meta.com>, Peter Huewe <peterhuewe@gmx.de>,
 Jason Gunthorpe <jgg@ziepe.ca>,  linux-kernel@vger.kernel.org
Date: Thu, 27 Nov 2025 17:09:38 +0100
In-Reply-To: <20251127135445.2141241-2-jarkko@kernel.org>
References: <20251127135445.2141241-1-jarkko@kernel.org>
	 <20251127135445.2141241-2-jarkko@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:LxC2BwBX4onFdyhpTasuAQ--.16496S2
X-Coremail-Antispam: 1UD129KBjvJXoW3GFW8KFWrGw4rZry8Cw1Utrb_yoWxGw1UpF
	Z8Gw1UCws8Jr4xGrnFyws7CrnxK3y7XrWUGay0v34vvwnI93W5K3WqkryrXryI9rWkKF1r
	XFZ2vFyfCF4q9aUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUF1
	v3UUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAFBGkntDIKZQABsm

On Thu, 2025-11-27 at 15:54 +0200, Jarkko Sakkinen wrote:
> From: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
>=20
> tpm2_get_pcr_allocation() does not cap any upper limit for the number of
> banks. Cap the limit to eight banks so that out of bounds values coming
> from external I/O cause on only limited harm.
>=20
> Cc: Roberto Sassu <roberto.sassu@huawei.com>

Sorry, I realized that you are expecting me to review.

I have a couple of questions:
- Could you explain better how out of bounds would occur, since one
  could check the number of PCR banks?
- Is dynamic allocation that bad? And if yes, why?
- Couldn't you just check that the number of available PCR banks is=C2=A0
  below the threshold you like and keep dynamic allocation?
- Is removing tpm1_get_pcr_allocation() improving code readability?

Thanks

Roberto

> Fixes: bcfff8384f6c ("tpm: dynamically allocate the allocated_banks array=
")
> Reviewed-By: Jonathan McDowell <noodles@meta.com>
> Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
> ---
> v7:
> - In Ryzen desktop there is total three banks so yep, eight is probably
>   much safer bet than four banks. Fixed the commit message as per remark
>   from Jonathan:
>=20
>   https://lore.kernel.org/linux-integrity/aPYg1N0TvrkG6AJI@earth.li/#t
>=20
>   And with that added also reviewed-by.
> v6
> - No changes.
> v5:
> - No changes.
> v4:
> - Revert spurious changes from include/linux/tpm.h.
> - Increase TPM2_MAX_BANKS to 8.
> - Rename TPM2_MAX_BANKS as TPM2_MAX_PCR_BANKS for the sake of clarity.
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
>  include/linux/tpm.h         |  8 +++++---
>  5 files changed, 17 insertions(+), 38 deletions(-)
>=20
> diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
> index e25daf2396d3..6cb25862688f 100644
> --- a/drivers/char/tpm/tpm-chip.c
> +++ b/drivers/char/tpm/tpm-chip.c
> @@ -559,14 +559,19 @@ static int tpm_add_hwrng(struct tpm_chip *chip)
> =20
>  static int tpm_get_pcr_allocation(struct tpm_chip *chip)
>  {
> -	int rc;
> +	int rc =3D 0;
> =20
>  	if (tpm_is_firmware_upgrade(chip))
>  		return 0;
> =20
> -	rc =3D (chip->flags & TPM_CHIP_FLAG_TPM2) ?
> -	     tpm2_get_pcr_allocation(chip) :
> -	     tpm1_get_pcr_allocation(chip);
> +	if (!(chip->flags & TPM_CHIP_FLAG_TPM2)) {
> +		chip->allocated_banks[0].alg_id =3D TPM_ALG_SHA1;
> +		chip->allocated_banks[0].digest_size =3D hash_digest_size[HASH_ALGO_SH=
A1];
> +		chip->allocated_banks[0].crypto_id =3D HASH_ALGO_SHA1;
> +		chip->nr_allocated_banks =3D 1;
> +	} else {
> +		rc =3D tpm2_get_pcr_allocation(chip);
> +	}
> =20
>  	if (rc > 0)
>  		return -ENODEV;
> diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
> index 2726bd38e5ac..a37712c02e44 100644
> --- a/drivers/char/tpm/tpm.h
> +++ b/drivers/char/tpm/tpm.h
> @@ -252,7 +252,6 @@ int tpm1_pcr_read(struct tpm_chip *chip, u32 pcr_idx,=
 u8 *res_buf);
>  ssize_t tpm1_getcap(struct tpm_chip *chip, u32 subcap_id, cap_t *cap,
>  		    const char *desc, size_t min_cap_length);
>  int tpm1_get_random(struct tpm_chip *chip, u8 *out, size_t max);
> -int tpm1_get_pcr_allocation(struct tpm_chip *chip);
>  unsigned long tpm_calc_ordinal_duration(struct tpm_chip *chip, u32 ordin=
al);
>  int tpm_pm_suspend(struct device *dev);
>  int tpm_pm_resume(struct device *dev);
> diff --git a/drivers/char/tpm/tpm1-cmd.c b/drivers/char/tpm/tpm1-cmd.c
> index 11088bda4e68..708bc553437b 100644
> --- a/drivers/char/tpm/tpm1-cmd.c
> +++ b/drivers/char/tpm/tpm1-cmd.c
> @@ -786,28 +786,3 @@ int tpm1_pm_suspend(struct tpm_chip *chip, u32 tpm_s=
uspend_pcr)
> =20
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
> -	chip->allocated_banks =3D kcalloc(1, sizeof(*chip->allocated_banks),
> -					GFP_KERNEL);
> -	if (!chip->allocated_banks)
> -		return -ENOMEM;
> -
> -	chip->allocated_banks[0].alg_id =3D TPM_ALG_SHA1;
> -	chip->allocated_banks[0].digest_size =3D hash_digest_size[HASH_ALGO_SHA=
1];
> -	chip->allocated_banks[0].crypto_id =3D HASH_ALGO_SHA1;
> -	chip->nr_allocated_banks =3D 1;
> -
> -	return 0;
> -}
> diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
> index 7d77f6fbc152..97501c567c34 100644
> --- a/drivers/char/tpm/tpm2-cmd.c
> +++ b/drivers/char/tpm/tpm2-cmd.c
> @@ -538,11 +538,9 @@ ssize_t tpm2_get_pcr_allocation(struct tpm_chip *chi=
p)
> =20
>  	nr_possible_banks =3D be32_to_cpup(
>  		(__be32 *)&buf.data[TPM_HEADER_SIZE + 5]);
> -
> -	chip->allocated_banks =3D kcalloc(nr_possible_banks,
> -					sizeof(*chip->allocated_banks),
> -					GFP_KERNEL);
> -	if (!chip->allocated_banks) {
> +	if (nr_possible_banks > TPM2_MAX_PCR_BANKS) {
> +		pr_err("tpm: unexpected number of banks: %u > %u",
> +		       nr_possible_banks, TPM2_MAX_PCR_BANKS);
>  		rc =3D -ENOMEM;
>  		goto out;
>  	}
> diff --git a/include/linux/tpm.h b/include/linux/tpm.h
> index dc0338a783f3..eb0ff071bcae 100644
> --- a/include/linux/tpm.h
> +++ b/include/linux/tpm.h
> @@ -26,7 +26,9 @@
>  #include <crypto/aes.h>
> =20
>  #define TPM_DIGEST_SIZE 20	/* Max TPM v1.2 PCR size */
> -#define TPM_MAX_DIGEST_SIZE SHA512_DIGEST_SIZE
> +
> +#define TPM2_MAX_DIGEST_SIZE	SHA512_DIGEST_SIZE
> +#define TPM2_MAX_PCR_BANKS	8
> =20
>  struct tpm_chip;
>  struct trusted_key_payload;
> @@ -68,7 +70,7 @@ enum tpm2_curves {
> =20
>  struct tpm_digest {
>  	u16 alg_id;
> -	u8 digest[TPM_MAX_DIGEST_SIZE];
> +	u8 digest[TPM2_MAX_DIGEST_SIZE];
>  } __packed;
> =20
>  struct tpm_bank_info {
> @@ -189,7 +191,7 @@ struct tpm_chip {
>  	unsigned int groups_cnt;
> =20
>  	u32 nr_allocated_banks;
> -	struct tpm_bank_info *allocated_banks;
> +	struct tpm_bank_info allocated_banks[TPM2_MAX_PCR_BANKS];
>  #ifdef CONFIG_ACPI
>  	acpi_handle acpi_dev_handle;
>  	char ppi_version[TPM_PPI_VERSION_LEN + 1];


