Return-Path: <linux-integrity+bounces-2428-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A28668C7FB6
	for <lists+linux-integrity@lfdr.de>; Fri, 17 May 2024 03:59:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3264A1F21F8B
	for <lists+linux-integrity@lfdr.de>; Fri, 17 May 2024 01:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A5618F5B;
	Fri, 17 May 2024 01:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="nEI9ozVe";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="nEI9ozVe"
X-Original-To: linux-integrity@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6788F55;
	Fri, 17 May 2024 01:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715911178; cv=none; b=I5Mboosw2CcZxL3MscAu26PZPLFDj4Zx7b+liR14K8YWG/ot42BEvq4FCL3qCLMaaMOskw1cr+ek9Tv+wVJ77EPf7SlRNtEaiVXRaj6I0kx11Z37GGAbXgHY1ZPdfCPv0Axho81QraKmKZaKa03CphpXgDSDx+3SSFcrsuLzseg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715911178; c=relaxed/simple;
	bh=PC1ovNDQuFrpZk9K7VfQ8Ki1Q2V9F1/v9bHK13XRcz4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Xt00BgJzyLU02KTK5GDENuZAu1tULWGugPArUDcBloM0xH5HjofCRCTxm+ttFYrDNXo2EOLDPrFs58uerbIX0fpQpgG2WYaYe4VK4x8OAoKQ2I24kuKTE9qDrHaDK7DyfevkBQmHH05mWeyDjlKW3WDeiQpn28sT/mZd2t2link=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=nEI9ozVe; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=nEI9ozVe; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1715911174;
	bh=PC1ovNDQuFrpZk9K7VfQ8Ki1Q2V9F1/v9bHK13XRcz4=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=nEI9ozVegltfUH7Efq7/orpic3T1f9XiBKg9G3LZCFojETPpqCTPrPb/Kk3byK5XH
	 E/23/uG1mOel3RFJoKSpoXKPZqzRw1L8R7Iq/O+BxRdpJrwpz0aVlM++t8a9jHOjD7
	 D0IEvy525/N2I3qUVk/wWnhtAb9/naoGjdX3wpf4=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id F21FF1287711;
	Thu, 16 May 2024 21:59:34 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id g0L6c6nI-2eY; Thu, 16 May 2024 21:59:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1715911174;
	bh=PC1ovNDQuFrpZk9K7VfQ8Ki1Q2V9F1/v9bHK13XRcz4=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=nEI9ozVegltfUH7Efq7/orpic3T1f9XiBKg9G3LZCFojETPpqCTPrPb/Kk3byK5XH
	 E/23/uG1mOel3RFJoKSpoXKPZqzRw1L8R7Iq/O+BxRdpJrwpz0aVlM++t8a9jHOjD7
	 D0IEvy525/N2I3qUVk/wWnhtAb9/naoGjdX3wpf4=
Received: from [172.20.11.192] (unknown [74.85.233.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 73FA212876F7;
	Thu, 16 May 2024 21:59:34 -0400 (EDT)
Message-ID: <0f68c283ff4bbb89b8a019d47891f798c6fff287.camel@HansenPartnership.com>
Subject: Re: [PATCH v8 18/22] tpm: add session encryption protection to
 tpm2_get_random()
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: =?ISO-8859-1?Q?N=EDcolas?= "F. R. A. Prado" <nfraprado@collabora.com>
Cc: linux-integrity@vger.kernel.org, Jarkko Sakkinen <jarkko@kernel.org>, 
	keyrings@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>, 
	regressions@lists.linux.dev, kernel@collabora.com
Date: Thu, 16 May 2024 18:59:33 -0700
In-Reply-To: <119dc5ed-f159-41be-9dda-1a056f29888d@notapiano>
References: <20240429202811.13643-1-James.Bottomley@HansenPartnership.com>
	 <20240429202811.13643-19-James.Bottomley@HansenPartnership.com>
	 <119dc5ed-f159-41be-9dda-1a056f29888d@notapiano>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 2024-05-16 at 20:25 -0400, Nícolas F. R. A. Prado wrote:
> On Mon, Apr 29, 2024 at 04:28:07PM -0400, James Bottomley wrote:
> > If some entity is snooping the TPM bus, they can see the random
> > numbers we're extracting from the TPM and do prediction attacks
> > against their consumers.  Foil this attack by using response
> > encryption to prevent the attacker from seeing the random sequence.
> > 
> > Signed-off-by: James Bottomley
> > <James.Bottomley@HansenPartnership.com>
> > Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> > 
> > ---
> > v7: add review
> > ---
> >  drivers/char/tpm/tpm2-cmd.c | 21 +++++++++++++++++----
> >  1 file changed, 17 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-
> > cmd.c
> > index a53a843294ed..0cdf892ec2a7 100644
> > --- a/drivers/char/tpm/tpm2-cmd.c
> > +++ b/drivers/char/tpm/tpm2-cmd.c
> > @@ -292,25 +292,35 @@ int tpm2_get_random(struct tpm_chip *chip, u8
> > *dest, size_t max)
> >         if (!num_bytes || max > TPM_MAX_RNG_DATA)
> >                 return -EINVAL;
> >  
> > -       err = tpm_buf_init(&buf, 0, 0);
> > +       err = tpm2_start_auth_session(chip);
> >         if (err)
> >                 return err;
> >  
> > +       err = tpm_buf_init(&buf, 0, 0);
> > +       if (err) {
> > +               tpm2_end_auth_session(chip);
> > +               return err;
> > +       }
> > +
> >         do {
> > -               tpm_buf_reset(&buf, TPM2_ST_NO_SESSIONS,
> > TPM2_CC_GET_RANDOM);
> > +               tpm_buf_reset(&buf, TPM2_ST_SESSIONS,
> > TPM2_CC_GET_RANDOM);
> > +               tpm_buf_append_hmac_session_opt(chip, &buf,
> > TPM2_SA_ENCRYPT
> > +                                               |
> > TPM2_SA_CONTINUE_SESSION,
> > +                                               NULL, 0);
> >                 tpm_buf_append_u16(&buf, num_bytes);
> > +               tpm_buf_fill_hmac_session(chip, &buf);
> >                 err = tpm_transmit_cmd(chip, &buf,
> >                                        offsetof(struct
> > tpm2_get_random_out,
> >                                                 buffer),
> >                                        "attempting get random");
> > +               err = tpm_buf_check_hmac_response(chip, &buf, err);
> >                 if (err) {
> >                         if (err > 0)
> >                                 err = -EIO;
> >                         goto out;
> >                 }
> >  
> > -               out = (struct tpm2_get_random_out *)
> > -                       &buf.data[TPM_HEADER_SIZE];
> > +               out = (struct tpm2_get_random_out
> > *)tpm_buf_parameters(&buf);
> >                 recd = min_t(u32, be16_to_cpu(out->size),
> > num_bytes);
> >                 if (tpm_buf_length(&buf) <
> >                     TPM_HEADER_SIZE +
> > @@ -327,9 +337,12 @@ int tpm2_get_random(struct tpm_chip *chip, u8
> > *dest, size_t max)
> >         } while (retries-- && total < max);
> >  
> >         tpm_buf_destroy(&buf);
> > +       tpm2_end_auth_session(chip);
> > +
> >         return total ? total : -EIO;
> >  out:
> >         tpm_buf_destroy(&buf);
> > +       tpm2_end_auth_session(chip);
> >         return err;
> >  }
> >  
> > -- 
> > 2.35.3
> > 
> 
> Hi,
> 
> KernelCI has identified a new warning and I tracked it down to this
> commit. It
> was observed on the following platforms:
> * mt8183-kukui-jacuzzi-juniper-sku16
> * sc7180-trogdor-kingoftown
> (but probably affects all platforms that have a tpm driver with async
> probe)
> 
> The warning is the following:
> 
> [    2.017338] ------------[ cut here ]------------
> [    2.025521] WARNING: CPU: 0 PID: 72 at kernel/module/kmod.c:144
> __request_module+0x188/0x1f4
> [    2.039508] Modules linked in:
> [    2.046447] CPU: 0 PID: 72 Comm: kworker/u34:3 Not tainted 6.9.0
> #1
> [    2.046455] Hardware name: Google juniper sku16 board (DT)
> [    2.046460] Workqueue: async async_run_entry_fn
> [    2.060094]
> [    2.060097] pstate: 00000005 (nzcv daif -PAN -UAO -TCO -DIT -SSBS
> BTYPE=--)
> [    2.091758] pc : __request_module+0x188/0x1f4
> [    2.096114] lr : __request_module+0x180/0x1f4
> [    2.100468] sp : ffff80008088b400
> [    2.103777] x29: ffff80008088b400 x28: 0000000000281ae0 x27:
> ffffa13fd366e0d2
> [    2.110915] x26: 0000000000000000 x25: ffff2387008f33c0 x24:
> 00000000ffffffff
> [    2.118053] x23: 000000000000200f x22: ffffa13fd0ed49de x21:
> 0000000000000001
> [    2.125190] x20: 0000000000000000 x19: ffffa13fd23f0be0 x18:
> 0000000000000014
> [    2.132327] x17: 00000000fbdae5e3 x16: 000000005bcbb9f8 x15:
> 000000008700f694
> [    2.139463] x14: 0000000000000001 x13: ffff80008088b850 x12:
> 0000000000000000
> [    2.146600] x11: 00000000f8f4a4bb x10: fffffffffdd186ae x9 :
> 0000000000000004
> [    2.153736] x8 : ffff2387008f33c0 x7 : 3135616873286361 x6 :
> 0c0406065b07370f
> [    2.160873] x5 : 0f37075b0606040c x4 : 0000000000000000 x3 :
> 0000000000000000
> [    2.168009] x2 : ffffa13fd0ed49de x1 : ffffa13fcfcc4768 x0 :
> 0000000000000001
> [    2.175146] Call trace:
> [    2.177587]  __request_module+0x188/0x1f4
> [    2.181596]  crypto_alg_mod_lookup+0x178/0x21c
> [    2.186042]  crypto_alloc_tfm_node+0x58/0x114
> [    2.190396]  crypto_alloc_shash+0x24/0x30
> [    2.194404]  drbg_init_hash_kernel+0x28/0xdc
> [    2.198673]  drbg_kcapi_seed+0x21c/0x420
> [    2.202593]  crypto_rng_reset+0x84/0xb4
> [    2.206425]  crypto_get_default_rng+0xa4/0xd8
> [    2.210779]  ecc_gen_privkey+0x58/0xd0
> [    2.214526]  ecdh_set_secret+0x90/0x198
> [    2.218360]  tpm_buf_append_salt+0x164/0x2dc

This looks like a misconfiguration.  The kernel is trying to load the
ecdh module, but it should have been selected as built in by this in
drivers/char/tpm/Kconfig:

config TCG_TPM2_HMAC
        bool "Use HMAC and encrypted transactions on the TPM bus"
        default y
        select CRYPTO_ECDH
        select CRYPTO_LIB_AESCFB
        select CRYPTO_LIB_SHA256

Can you check what the status of CONFIG_CRYPTO_ECHD is for your build?

Regards,

James


