Return-Path: <linux-integrity+bounces-7506-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7924DBF11A9
	for <lists+linux-integrity@lfdr.de>; Mon, 20 Oct 2025 14:18:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 575334F3BC9
	for <lists+linux-integrity@lfdr.de>; Mon, 20 Oct 2025 12:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9274930DD33;
	Mon, 20 Oct 2025 12:13:37 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3182FB08C;
	Mon, 20 Oct 2025 12:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760962417; cv=none; b=ktM1f5nnilRs9LDxYKjBLiRXcdzx4/FdAIS/3mAzZl+aiCuGzcxXnouIScoH+pHgGQ3ZpFTHOJESD/4KznRv2ULtJYsacBd/H9O7CGB7ho6l7BV0JOTGwXIUBH4aeZv5xnzJBPUVszhSYVWQ0OFvQJcL7R29Sr5ffDDg/Cpy7cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760962417; c=relaxed/simple;
	bh=uRQt2BLn66gYf65UQCYarlFoLBJ3MSeRb88u26ArA/U=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TaYdgtljeEPfJdh87kEC6jc8l/nAz+seqTIpabayso5i4w5276ZIbgEhSvykLjqaNDu1TSfhpfd90mtSViADewZ+UxwGYOVrAvOLRvLMIGylj8p3R3jL3FS56qwZ8s4EeIU2l6AG4/vw8kgLn85rbebCbVJ/6fR+//kOOLKR35Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cqv295YFxz1HBMx;
	Mon, 20 Oct 2025 19:53:05 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id D70CE1402EC;
	Mon, 20 Oct 2025 19:53:40 +0800 (CST)
Received: from [10.204.63.22] (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwD3th68IvZo8MqQAA--.3781S2;
	Mon, 20 Oct 2025 12:53:40 +0100 (CET)
Message-ID: <cec499d5130f37a7887d39b44efd8538dd361fe3.camel@huaweicloud.com>
Subject: Re: [PATCH v3 4/4] tpm: Allow for exclusive TPM access when using
 /dev/tpm<n>
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Jonathan McDowell <noodles@earth.li>, Peter Huewe <peterhuewe@gmx.de>, 
 Jarkko Sakkinen <jarkko@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, James Bottomley
	 <James.Bottomley@hansenpartnership.com>, linux-integrity@vger.kernel.org, 
	linux-kernel@vger.kernel.org, zohar@linux.ibm.com
Date: Mon, 20 Oct 2025 13:53:30 +0200
In-Reply-To: <61049f236fe1eaf72402895cea6892b52ce7e279.1760958898.git.noodles@meta.com>
References: <cover.1760958898.git.noodles@meta.com>
	 <61049f236fe1eaf72402895cea6892b52ce7e279.1760958898.git.noodles@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:GxC2BwD3th68IvZo8MqQAA--.3781S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Gry8CF1DGw15KF4UGw15Arb_yoWxtw18pF
	45CF93urs8Jr4qqFn7ZanruF1a9w4IgayUG397K3s3Cwn0gF15Wrn8KFy3Zry7Wr1rCrsY
	y3y0vFyUCFyjkaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUymb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vI
	r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E
	14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UAwIDUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAHBGj1k+sH2QAAs6

On Mon, 2025-10-20 at 12:31 +0100, Jonathan McDowell wrote:
> From: Jonathan McDowell <noodles@meta.com>
>=20
> There are situations where userspace might reasonably desire exclusive
> access to the TPM, or the kernel's internal context saving + flushing
> may cause issues, for example when performing firmware upgrades. Extend
> the locking already used for avoiding concurrent userspace access to
> prevent internal users of the TPM when /dev/tpm<n> is in use.
>=20
> The few internal users who already hold the open_lock are changed to use
> tpm_internal_(try_get|put)_ops, with the old tpm_(try_get|put)_ops
> functions changing to obtain read access to the open_lock.  We return
> -EBUSY when another user has exclusive access, rather than adding waits.
>=20
> Signed-off-by: Jonathan McDowell <noodles@meta.com>
> ---
> v2: Switch to _locked instead of _internal_ for function names.
> v3: Move to end of patch series.
>=20
>  drivers/char/tpm/tpm-chip.c       | 53 +++++++++++++++++++++++++------
>  drivers/char/tpm/tpm-dev-common.c |  8 ++---
>  drivers/char/tpm/tpm.h            |  2 ++
>  drivers/char/tpm/tpm2-space.c     |  5 ++-
>  4 files changed, 52 insertions(+), 16 deletions(-)
>=20
> diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
> index ba906966721a..687f6d8cd601 100644
> --- a/drivers/char/tpm/tpm-chip.c
> +++ b/drivers/char/tpm/tpm-chip.c
> @@ -144,7 +144,7 @@ void tpm_chip_stop(struct tpm_chip *chip)
>  EXPORT_SYMBOL_GPL(tpm_chip_stop);
> =20
>  /**
> - * tpm_try_get_ops() - Get a ref to the tpm_chip
> + * tpm_try_get_ops_locked() - Get a ref to the tpm_chip
>   * @chip: Chip to ref
>   *
>   * The caller must already have some kind of locking to ensure that chip=
 is
> @@ -154,7 +154,7 @@ EXPORT_SYMBOL_GPL(tpm_chip_stop);
>   *
>   * Returns -ERRNO if the chip could not be got.
>   */
> -int tpm_try_get_ops(struct tpm_chip *chip)
> +int tpm_try_get_ops_locked(struct tpm_chip *chip)
>  {
>  	int rc =3D -EIO;
> =20
> @@ -185,22 +185,57 @@ int tpm_try_get_ops(struct tpm_chip *chip)
>  	put_device(&chip->dev);
>  	return rc;
>  }
> -EXPORT_SYMBOL_GPL(tpm_try_get_ops);
> =20
>  /**
> - * tpm_put_ops() - Release a ref to the tpm_chip
> + * tpm_put_ops_locked() - Release a ref to the tpm_chip
>   * @chip: Chip to put
>   *
> - * This is the opposite pair to tpm_try_get_ops(). After this returns ch=
ip may
> - * be kfree'd.
> + * This is the opposite pair to tpm_try_get_ops_locked(). After this ret=
urns
> + * chip may be kfree'd.
>   */
> -void tpm_put_ops(struct tpm_chip *chip)
> +void tpm_put_ops_locked(struct tpm_chip *chip)
>  {
>  	tpm_chip_stop(chip);
>  	mutex_unlock(&chip->tpm_mutex);
>  	up_read(&chip->ops_sem);
>  	put_device(&chip->dev);
>  }
> +
> +/**
> + * tpm_try_get_ops() - Get a ref to the tpm_chip
> + * @chip: Chip to ref
> + *
> + * The caller must already have some kind of locking to ensure that chip=
 is
> + * valid. This function will attempt to get the open_lock for the chip,
> + * ensuring no other user is expecting exclusive access, before locking =
the
> + * chip so that the ops member can be accessed safely. The locking preve=
nts
> + * tpm_chip_unregister from completing, so it should not be held for lon=
g
> + * periods.
> + *
> + * Returns -ERRNO if the chip could not be got.
> + */
> +int tpm_try_get_ops(struct tpm_chip *chip)
> +{
> +	if (!down_read_trylock(&chip->open_lock))
> +		return -EBUSY;

Hi Jonathan

do I understand it correctly, that a process might open the TPM with
O_EXCL, and this will prevent IMA from extending a PCR until that
process closes the file descriptor?

If yes, this might be a concern, and I think an additional API to
prevent such behavior would be needed (for example when IMA is active,
i.e. there is a measurement policy loaded).

Thanks

Roberto

> +
> +	return tpm_try_get_ops_locked(chip);
> +}
> +EXPORT_SYMBOL_GPL(tpm_try_get_ops);
> +
> +/**
> + * tpm_put_ops() - Release a ref to the tpm_chip
> + * @chip: Chip to put
> + *
> + * This is the opposite pair to tpm_try_get_ops(). After this returns
> + * chip may be kfree'd.
> + */
> +void tpm_put_ops(struct tpm_chip *chip)
> +{
> +	tpm_put_ops_locked(chip);
> +
> +	up_read(&chip->open_lock);
> +}
>  EXPORT_SYMBOL_GPL(tpm_put_ops);
> =20
>  /**
> @@ -644,10 +679,10 @@ void tpm_chip_unregister(struct tpm_chip *chip)
>  #ifdef CONFIG_TCG_TPM2_HMAC
>  	int rc;
> =20
> -	rc =3D tpm_try_get_ops(chip);
> +	rc =3D tpm_try_get_ops_locked(chip);
>  	if (!rc) {
>  		tpm2_end_auth_session(chip);
> -		tpm_put_ops(chip);
> +		tpm_put_ops_locked(chip);
>  	}
>  #endif
> =20
> diff --git a/drivers/char/tpm/tpm-dev-common.c b/drivers/char/tpm/tpm-dev=
-common.c
> index f2a5e09257dd..0f5bc63411aa 100644
> --- a/drivers/char/tpm/tpm-dev-common.c
> +++ b/drivers/char/tpm/tpm-dev-common.c
> @@ -65,7 +65,7 @@ static void tpm_dev_async_work(struct work_struct *work=
)
> =20
>  	mutex_lock(&priv->buffer_mutex);
>  	priv->command_enqueued =3D false;
> -	ret =3D tpm_try_get_ops(priv->chip);
> +	ret =3D tpm_try_get_ops_locked(priv->chip);
>  	if (ret) {
>  		priv->response_length =3D ret;
>  		goto out;
> @@ -73,7 +73,7 @@ static void tpm_dev_async_work(struct work_struct *work=
)
> =20
>  	ret =3D tpm_dev_transmit(priv->chip, priv->space, priv->data_buffer,
>  			       sizeof(priv->data_buffer));
> -	tpm_put_ops(priv->chip);
> +	tpm_put_ops_locked(priv->chip);
> =20
>  	/*
>  	 * If ret is > 0 then tpm_dev_transmit returned the size of the
> @@ -220,14 +220,14 @@ ssize_t tpm_common_write(struct file *file, const c=
har __user *buf,
>  	 * lock during this period so that the tpm can be unregistered even if
>  	 * the char dev is held open.
>  	 */
> -	if (tpm_try_get_ops(priv->chip)) {
> +	if (tpm_try_get_ops_locked(priv->chip)) {
>  		ret =3D -EPIPE;
>  		goto out;
>  	}
> =20
>  	ret =3D tpm_dev_transmit(priv->chip, priv->space, priv->data_buffer,
>  			       sizeof(priv->data_buffer));
> -	tpm_put_ops(priv->chip);
> +	tpm_put_ops_locked(priv->chip);
> =20
>  	if (ret > 0) {
>  		priv->response_length =3D ret;
> diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
> index 02c07fef41ba..57ef8589f5f5 100644
> --- a/drivers/char/tpm/tpm.h
> +++ b/drivers/char/tpm/tpm.h
> @@ -272,6 +272,8 @@ struct tpm_chip *tpm_chip_alloc(struct device *dev,
>  				const struct tpm_class_ops *ops);
>  struct tpm_chip *tpmm_chip_alloc(struct device *pdev,
>  				 const struct tpm_class_ops *ops);
> +int tpm_try_get_ops_locked(struct tpm_chip *chip);
> +void tpm_put_ops_locked(struct tpm_chip *chip);
>  int tpm_chip_register(struct tpm_chip *chip);
>  void tpm_chip_unregister(struct tpm_chip *chip);
> =20
> diff --git a/drivers/char/tpm/tpm2-space.c b/drivers/char/tpm/tpm2-space.=
c
> index 60354cd53b5c..0ad5e18355e0 100644
> --- a/drivers/char/tpm/tpm2-space.c
> +++ b/drivers/char/tpm/tpm2-space.c
> @@ -58,10 +58,9 @@ int tpm2_init_space(struct tpm_space *space, unsigned =
int buf_size)
> =20
>  void tpm2_del_space(struct tpm_chip *chip, struct tpm_space *space)
>  {
> -
> -	if (tpm_try_get_ops(chip) =3D=3D 0) {
> +	if (tpm_try_get_ops_locked(chip) =3D=3D 0) {
>  		tpm2_flush_sessions(chip, space);
> -		tpm_put_ops(chip);
> +		tpm_put_ops_locked(chip);
>  	}
> =20
>  	kfree(space->context_buf);


