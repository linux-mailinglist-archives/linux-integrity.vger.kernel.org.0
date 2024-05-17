Return-Path: <linux-integrity+bounces-2427-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24E918C7F2A
	for <lists+linux-integrity@lfdr.de>; Fri, 17 May 2024 02:26:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 485B21C21539
	for <lists+linux-integrity@lfdr.de>; Fri, 17 May 2024 00:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8382038F;
	Fri, 17 May 2024 00:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ZH77HSI/"
X-Original-To: linux-integrity@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57073384;
	Fri, 17 May 2024 00:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715905561; cv=none; b=GRQGxPLZfnUhHofj0+wHI+ETaRjek6iUY0uBU1MbvksKFPBohacHJaE0Phtc7Uu6k88IwRpjXDJnYBtTGZRnmWKHZT00JKdaBOpddPGtiBzSL6dLngS375jlHCB4Prhmu5kkG0N9V89U/M30m0D515rFOsPh1Hu0hJD43Z7vX3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715905561; c=relaxed/simple;
	bh=dwE5vfdNWntyklCWwtGalycswCG/JZD7X/VH3MKKg+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WACMvm7+iPB9yGTz+kWwFloqy7LsVMyqTUGmFbZ54s6wDvxicE19SeLCBoj9rZL2BgNd7z5kNalJ1wxtGfNmFo71vHFpWSvqcw7HhFfOK5GiiYqQ4E79ivXUaqEMg/gpYxXie0Wc5pvWI6Mplc+Goy7yZWESy3FuCczfXyIGw8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ZH77HSI/; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1715905557;
	bh=dwE5vfdNWntyklCWwtGalycswCG/JZD7X/VH3MKKg+E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZH77HSI/KdUvTk1D4Xr3jyz2Oll4sjAJ94nj6Sv+jnWt8Y1ylwSyaGYqqT5gEuGbX
	 /Vq8cRQJRS1Fm6DAuduF1qhhvfzrsL4aH9HlK7xEC89F9WB1kEmbgH9r9HTCm2dakk
	 uGfiQXUPwlCMvkM0yD9Ud/nqrhaYPXOX6kL1o1HvF404OL1eMHY5Qpd7+wQUb98AMK
	 reTRRnsob5ewwhWqmnoH8DTi3AHAMmV5nEmq09UnINVeAGxuDHGp9sj1se92aQ1W5H
	 tLIgezzGeX/Pf2R6ZevEZ76itKmsTvtG91HKTPXJsYWYDNqwVkbea43y1PyVf3WQ5B
	 7RpQb0pxTAh4Q==
Received: from notapiano (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 33507378214E;
	Fri, 17 May 2024 00:25:56 +0000 (UTC)
Date: Thu, 16 May 2024 20:25:54 -0400
From: =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: linux-integrity@vger.kernel.org, Jarkko Sakkinen <jarkko@kernel.org>,
	keyrings@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
	regressions@lists.linux.dev, kernel@collabora.com
Subject: Re: [PATCH v8 18/22] tpm: add session encryption protection to
 tpm2_get_random()
Message-ID: <119dc5ed-f159-41be-9dda-1a056f29888d@notapiano>
References: <20240429202811.13643-1-James.Bottomley@HansenPartnership.com>
 <20240429202811.13643-19-James.Bottomley@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240429202811.13643-19-James.Bottomley@HansenPartnership.com>

On Mon, Apr 29, 2024 at 04:28:07PM -0400, James Bottomley wrote:
> If some entity is snooping the TPM bus, they can see the random
> numbers we're extracting from the TPM and do prediction attacks
> against their consumers.  Foil this attack by using response
> encryption to prevent the attacker from seeing the random sequence.
> 
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> 
> ---
> v7: add review
> ---
>  drivers/char/tpm/tpm2-cmd.c | 21 +++++++++++++++++----
>  1 file changed, 17 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
> index a53a843294ed..0cdf892ec2a7 100644
> --- a/drivers/char/tpm/tpm2-cmd.c
> +++ b/drivers/char/tpm/tpm2-cmd.c
> @@ -292,25 +292,35 @@ int tpm2_get_random(struct tpm_chip *chip, u8 *dest, size_t max)
>  	if (!num_bytes || max > TPM_MAX_RNG_DATA)
>  		return -EINVAL;
>  
> -	err = tpm_buf_init(&buf, 0, 0);
> +	err = tpm2_start_auth_session(chip);
>  	if (err)
>  		return err;
>  
> +	err = tpm_buf_init(&buf, 0, 0);
> +	if (err) {
> +		tpm2_end_auth_session(chip);
> +		return err;
> +	}
> +
>  	do {
> -		tpm_buf_reset(&buf, TPM2_ST_NO_SESSIONS, TPM2_CC_GET_RANDOM);
> +		tpm_buf_reset(&buf, TPM2_ST_SESSIONS, TPM2_CC_GET_RANDOM);
> +		tpm_buf_append_hmac_session_opt(chip, &buf, TPM2_SA_ENCRYPT
> +						| TPM2_SA_CONTINUE_SESSION,
> +						NULL, 0);
>  		tpm_buf_append_u16(&buf, num_bytes);
> +		tpm_buf_fill_hmac_session(chip, &buf);
>  		err = tpm_transmit_cmd(chip, &buf,
>  				       offsetof(struct tpm2_get_random_out,
>  						buffer),
>  				       "attempting get random");
> +		err = tpm_buf_check_hmac_response(chip, &buf, err);
>  		if (err) {
>  			if (err > 0)
>  				err = -EIO;
>  			goto out;
>  		}
>  
> -		out = (struct tpm2_get_random_out *)
> -			&buf.data[TPM_HEADER_SIZE];
> +		out = (struct tpm2_get_random_out *)tpm_buf_parameters(&buf);
>  		recd = min_t(u32, be16_to_cpu(out->size), num_bytes);
>  		if (tpm_buf_length(&buf) <
>  		    TPM_HEADER_SIZE +
> @@ -327,9 +337,12 @@ int tpm2_get_random(struct tpm_chip *chip, u8 *dest, size_t max)
>  	} while (retries-- && total < max);
>  
>  	tpm_buf_destroy(&buf);
> +	tpm2_end_auth_session(chip);
> +
>  	return total ? total : -EIO;
>  out:
>  	tpm_buf_destroy(&buf);
> +	tpm2_end_auth_session(chip);
>  	return err;
>  }
>  
> -- 
> 2.35.3
> 

Hi,

KernelCI has identified a new warning and I tracked it down to this commit. It
was observed on the following platforms:
* mt8183-kukui-jacuzzi-juniper-sku16
* sc7180-trogdor-kingoftown
(but probably affects all platforms that have a tpm driver with async probe)

The warning is the following:

[    2.017338] ------------[ cut here ]------------
[    2.025521] WARNING: CPU: 0 PID: 72 at kernel/module/kmod.c:144 __request_module+0x188/0x1f4
[    2.039508] Modules linked in:
[    2.046447] CPU: 0 PID: 72 Comm: kworker/u34:3 Not tainted 6.9.0 #1
[    2.046455] Hardware name: Google juniper sku16 board (DT)
[    2.046460] Workqueue: async async_run_entry_fn
[    2.060094]
[    2.060097] pstate: 00000005 (nzcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    2.091758] pc : __request_module+0x188/0x1f4
[    2.096114] lr : __request_module+0x180/0x1f4
[    2.100468] sp : ffff80008088b400
[    2.103777] x29: ffff80008088b400 x28: 0000000000281ae0 x27: ffffa13fd366e0d2
[    2.110915] x26: 0000000000000000 x25: ffff2387008f33c0 x24: 00000000ffffffff
[    2.118053] x23: 000000000000200f x22: ffffa13fd0ed49de x21: 0000000000000001
[    2.125190] x20: 0000000000000000 x19: ffffa13fd23f0be0 x18: 0000000000000014
[    2.132327] x17: 00000000fbdae5e3 x16: 000000005bcbb9f8 x15: 000000008700f694
[    2.139463] x14: 0000000000000001 x13: ffff80008088b850 x12: 0000000000000000
[    2.146600] x11: 00000000f8f4a4bb x10: fffffffffdd186ae x9 : 0000000000000004
[    2.153736] x8 : ffff2387008f33c0 x7 : 3135616873286361 x6 : 0c0406065b07370f
[    2.160873] x5 : 0f37075b0606040c x4 : 0000000000000000 x3 : 0000000000000000
[    2.168009] x2 : ffffa13fd0ed49de x1 : ffffa13fcfcc4768 x0 : 0000000000000001
[    2.175146] Call trace:
[    2.177587]  __request_module+0x188/0x1f4
[    2.181596]  crypto_alg_mod_lookup+0x178/0x21c
[    2.186042]  crypto_alloc_tfm_node+0x58/0x114
[    2.190396]  crypto_alloc_shash+0x24/0x30
[    2.194404]  drbg_init_hash_kernel+0x28/0xdc
[    2.198673]  drbg_kcapi_seed+0x21c/0x420
[    2.202593]  crypto_rng_reset+0x84/0xb4
[    2.206425]  crypto_get_default_rng+0xa4/0xd8
[    2.210779]  ecc_gen_privkey+0x58/0xd0
[    2.214526]  ecdh_set_secret+0x90/0x198
[    2.218360]  tpm_buf_append_salt+0x164/0x2dc
[    2.222632]  tpm2_start_auth_session+0xc8/0x29c
[    2.227162]  tpm2_get_random+0x44/0x204
[    2.230996]  tpm_get_random+0x74/0x90
[    2.234655]  tpm_hwrng_read+0x24/0x30
[    2.238314]  add_early_randomness+0x68/0x118
[    2.242584]  hwrng_register+0x16c/0x218
[    2.246418]  tpm_chip_register+0xf0/0x2cc
[    2.248143] cros-ec-spi spi2.0: SPI transfer timed out
[    2.250419]  tpm_tis_core_init+0x494/0x7e0
[    2.255552] spi_master spi2: failed to transfer one message from queue
[    2.259623]  tpm_tis_spi_init+0x54/0x70
[    2.259629]  cr50_spi_probe+0xf4/0x27c
[    2.266145] spi_master spi2: noqueue transfer failed
[    2.269961]  tpm_tis_spi_driver_probe+0x34/0x64
[    2.273704] cros-ec-spi spi2.0: spi transfer failed: -110
[    2.278647]  spi_probe+0x84/0xe4
[    2.291799]  really_probe+0xbc/0x2a0
[    2.295373]  __driver_probe_device+0x78/0x12c
[    2.299725]  driver_probe_device+0xdc/0x160
[    2.303903]  __device_attach_driver+0xb8/0x134
[    2.308342]  bus_for_each_drv+0x84/0xe0
[    2.312174]  __device_attach_async_helper+0xac/0xd0
[    2.317051]  async_run_entry_fn+0x34/0xe0
[    2.321058]  process_one_work+0x150/0x294
[    2.325068]  worker_thread+0x304/0x408
[    2.328816]  kthread+0x118/0x11c
[    2.332045]  ret_from_fork+0x10/0x20
[    2.335621] ---[ end trace 0000000000000000 ]---

Which is generated in __request_module() here:

	/*
	 * We don't allow synchronous module loading from async.  Module
	 * init may invoke async_synchronize_full() which will end up
	 * waiting for this task which already is waiting for the module
	 * loading to complete, leading to a deadlock.
	 */
	WARN_ON_ONCE(wait && current_is_async());

As the comment says this could lead to a deadlock so it seemed worthwhile to
report and get fixed.

The tpm_tis_spi driver probes asynchronously,

	.probe_type = PROBE_PREFER_ASYNCHRONOUS,

and as part of its probe registers the tpm device which ultimately leads to a
module being requested synchronously in crypto_larval_lookup():

	request_module("crypto-%s-all", name);

and that triggers the warning.

#regzbot introduced: 1b6d7f9eb150
#regzbot title: __request_module warning: sync module loading from async tpm driver probe

Thanks,
Nícolas

