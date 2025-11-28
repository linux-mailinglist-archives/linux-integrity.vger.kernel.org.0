Return-Path: <linux-integrity+bounces-7733-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24CFDC916CA
	for <lists+linux-integrity@lfdr.de>; Fri, 28 Nov 2025 10:23:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A570A3A6C16
	for <lists+linux-integrity@lfdr.de>; Fri, 28 Nov 2025 09:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DB442FF147;
	Fri, 28 Nov 2025 09:22:16 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8749B30277E;
	Fri, 28 Nov 2025 09:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764321736; cv=none; b=MFE03eKTlLHKbFD4uFiQW4gI/WjHNRqct42yh6aFra6g0eSjIlBgSwlDlEbkWIJG79OleOGyfqvM6zwTHHAdtk92spuJIQprVNpbXOgW/R0kgNYzfNzy2vD8wHMEp9ZKLjxqe5ixgGgCTqHUmnIyllnrWjEoSTgX2F1IGffnkg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764321736; c=relaxed/simple;
	bh=mysHyVKo20YNlTl1WuHje4KuEorD8D7oS5QmxPPo1vc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aieQXK21PHApZVjlEUs9JS/TS+0onV1jznpDmSvAFf2XkODjUKB1elYQ502wUeahSl4rHD5Ya1ItcaRlKJelgZaCZnlkuKuNlEAE6DYkQi5vclXFHHuN1cZiUmQI45MQD54K+dp1/nntVr6WxmG+nYAGxWY7tW1ODluzeIh9u9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTPS id 4dHnpP2Ng2zpThr;
	Fri, 28 Nov 2025 17:20:45 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 5DCC21402F9;
	Fri, 28 Nov 2025 17:22:09 +0800 (CST)
Received: from [10.204.63.22] (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwDnwIi4aSlpy705AQ--.4544S2;
	Fri, 28 Nov 2025 10:22:08 +0100 (CET)
Message-ID: <eff8c944622851683597a4738a2089c4b9a15b71.camel@huaweicloud.com>
Subject: Re: [PATCH v7 01/11] tpm: Cap the number of PCR banks
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-integrity@vger.kernel.org, ross.philipson@oracle.com, Jonathan
 McDowell <noodles@earth.li>, Stefano Garzarella <sgarzare@redhat.com>,
 Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>, Roberto Sassu
 <roberto.sassu@huawei.com>,  Jonathan McDowell <noodles@meta.com>, Peter
 Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
 linux-kernel@vger.kernel.org
Date: Fri, 28 Nov 2025 10:21:57 +0100
In-Reply-To: <aSid1oEcDY9mzwq4@kernel.org>
References: <20251127135445.2141241-1-jarkko@kernel.org>
	 <20251127135445.2141241-2-jarkko@kernel.org>
	 <69de8fea4851ef378613e66685c3c34c43d71f05.camel@huaweicloud.com>
	 <aSiG7l_1E12r_56c@kernel.org>
	 <a6e73690e73b7a3e190719d179dbc73b93d1c1f1.camel@huaweicloud.com>
	 <aSid1oEcDY9mzwq4@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:LxC2BwDnwIi4aSlpy705AQ--.4544S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWw43Kw18tF47ZrWUAr4fKrg_yoWrZw4rpF
	Z8t3WUCF45Xr47Ar90y3WIkrnxK3y7XryUGay0qFyjvwnxKFn8K3WDGryfWry0grn5JF18
	XrZFqF9xJw4q9aUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAGBGkpBbID8AABsG

On Thu, 2025-11-27 at 20:52 +0200, Jarkko Sakkinen wrote:
> On Thu, Nov 27, 2025 at 06:17:42PM +0100, Roberto Sassu wrote:
> > On Thu, 2025-11-27 at 19:14 +0200, Jarkko Sakkinen wrote:
> > > On Thu, Nov 27, 2025 at 05:09:38PM +0100, Roberto Sassu wrote:
> > > > On Thu, 2025-11-27 at 15:54 +0200, Jarkko Sakkinen wrote:
> > > > > From: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
> > > > >=20
> > > > > tpm2_get_pcr_allocation() does not cap any upper limit for the nu=
mber of
> > > > > banks. Cap the limit to eight banks so that out of bounds values =
coming
> > > > > from external I/O cause on only limited harm.
> > > > >=20
> > > > > Cc: Roberto Sassu <roberto.sassu@huawei.com>
> > > >=20
> > > > Sorry, I realized that you are expecting me to review.
> > > >=20
> > > > I have a couple of questions:
> > > > - Could you explain better how out of bounds would occur, since one
> > > >   could check the number of PCR banks?
> > > > - Is dynamic allocation that bad? And if yes, why?
> > > > - Couldn't you just check that the number of available PCR banks is=
=C2=A0
> > > >   below the threshold you like and keep dynamic allocation?
> > > > - Is removing tpm1_get_pcr_allocation() improving code readability?
> > >=20
> > > nr_possible_banks is read from external source i.e., neither kernel n=
or
> > > CPU fully control its value. This causes *uncontrolled* dynamic
> > > allocation. Thus, it must be capped to some value.
> >=20
> > Sure, I'm fine with capping. Isn't that enough?
>=20
> It makes sense to make the whole memory allocation then infallible,
> especially since it does not have much effect on diff. And it has
> not significant effect on memory usage either.

Ok. In that case (even if it does not get in):

Reviewed-by: Roberto Sassu <roberto.sassu@huawei.com>

Roberto

> But I do see one completely spurious and actually unintended change=20
> that I spotted: tpm1_get_pcr_allocation. It there's no intention
> doing this it has just carried over the series.
>=20
> I reverted that part, which make it look like a proper bug fix:
>=20
> diff --git a/drivers/char/tpm/tpm1-cmd.c b/drivers/char/tpm/tpm1-cmd.c
> index 11088bda4e68..6849f216ba0b 100644
> --- a/drivers/char/tpm/tpm1-cmd.c
> +++ b/drivers/char/tpm/tpm1-cmd.c
> @@ -799,11 +799,6 @@ int tpm1_pm_suspend(struct tpm_chip *chip, u32 tpm_s=
uspend_pcr)
>   */
>  int tpm1_get_pcr_allocation(struct tpm_chip *chip)
>  {
> -	chip->allocated_banks =3D kcalloc(1, sizeof(*chip->allocated_banks),
> -					GFP_KERNEL);
> -	if (!chip->allocated_banks)
> -		return -ENOMEM;
> -
>  	chip->allocated_banks[0].alg_id =3D TPM_ALG_SHA1;
>  	chip->allocated_banks[0].digest_size =3D hash_digest_size[HASH_ALGO_SHA=
1];
>  	chip->allocated_banks[0].crypto_id =3D HASH_ALGO_SHA1;
> diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
> index 7d77f6fbc152..97501c567c34 100644
> --- a/drivers/char/tpm/tpm2-cmd.c
> +++ b/drivers/char/tpm/tpm2-cmd.c
> @@ -538,11 +538,9 @@ ssize_t tpm2_get_pcr_allocation(struct tpm_chip *chi=
p)
>=20
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
>=20
>  #define TPM_DIGEST_SIZE 20	/* Max TPM v1.2 PCR size */
> -#define TPM_MAX_DIGEST_SIZE SHA512_DIGEST_SIZE
> +
> +#define TPM2_MAX_DIGEST_SIZE	SHA512_DIGEST_SIZE
> +#define TPM2_MAX_PCR_BANKS	8
>=20
>  struct tpm_chip;
>  struct trusted_key_payload;
> @@ -68,7 +70,7 @@ enum tpm2_curves {
>=20
>  struct tpm_digest {
>  	u16 alg_id;
> -	u8 digest[TPM_MAX_DIGEST_SIZE];
> +	u8 digest[TPM2_MAX_DIGEST_SIZE];
>  } __packed;
>=20
>  struct tpm_bank_info {
> @@ -189,7 +191,7 @@ struct tpm_chip {
>  	unsigned int groups_cnt;
>=20
>  	u32 nr_allocated_banks;
> -	struct tpm_bank_info *allocated_banks;
> +	struct tpm_bank_info allocated_banks[TPM2_MAX_PCR_BANKS];
>  #ifdef CONFIG_ACPI
>  	acpi_handle acpi_dev_handle;
>  	char ppi_version[TPM_PPI_VERSION_LEN + 1];
>=20
>=20
> >=20
> > Thanks
> >=20
> > Roberto
> >=20
> > > > Thanks
> > > >=20
> > > > Roberto
> > >=20
> > > BR, Jarkko
> >=20
>=20
> BR, Jarkko


