Return-Path: <linux-integrity+bounces-4525-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D380FA030CB
	for <lists+linux-integrity@lfdr.de>; Mon,  6 Jan 2025 20:39:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D2E11886082
	for <lists+linux-integrity@lfdr.de>; Mon,  6 Jan 2025 19:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E651B3597E;
	Mon,  6 Jan 2025 19:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fWb1ng1t"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF3CEEB3;
	Mon,  6 Jan 2025 19:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736192373; cv=none; b=pcSdQs6Jnm8rTls0242juFeYuMRAUYOlOY5BHb99nKMrXKu5Y4Yrp2cVX0cSKEPPsgYQti9WZFuyqu/OrHIuEmp3tfnDTsHAAZDU2hkTgStdNhY52oBvhb+QaIQlPdWjA3aavGtClFcdWIuqI6nn/sCOiRWbOqxMuhbNe1x/WS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736192373; c=relaxed/simple;
	bh=MwVEorGOcQge4PyZbRon7At1OjCBUAIVlwMCUFluevw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=dzpICu14wOp4C/yEBBDNUECJLsPAzln6gdYzxHuorwvWC5KTM2hyJaFwykN9WfgB7ybXdpzhu/zp5ckN/asbaJeW/wZel8qEiuUWGzC6qYzYSRC04I8f/l9g8C2NBOU768Jg1rZTuTXBixCP89C3WCjSgfg0sNmgN/D/dq2itas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fWb1ng1t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B319FC4CED2;
	Mon,  6 Jan 2025 19:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736192373;
	bh=MwVEorGOcQge4PyZbRon7At1OjCBUAIVlwMCUFluevw=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=fWb1ng1tsmVi28iaVYcaTMbKU3GttYz0b5o4J1/8jPbNKBiqbtRXmNneG7fuxkUsL
	 kuQOJnOYQY0YXEtfzyLAx7r4b4+zcBWveOJ5Dm5P0Yr/IQm9CaDLvn1oVgIzy7+uwE
	 XnRx0AsnuUEoJFLmNntIs+F1O+ncckfgO1hxhn+aILScFj7Kn7+hNeAkI81rP0XsGR
	 UZJ5VtnOcQqEVljgwXhek8Z7z7fxly6y6UJQG7cI1EglmcSTvTAAfMi1wC7KshucxB
	 ZBmD/PDLOuBah0lNdTkSd1uuAo0+OveQAje38EKEwSrBaYy3tT5S6YqyN3JkfzfH+l
	 v8WjQftj72V8w==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 06 Jan 2025 21:39:28 +0200
Message-Id: <D6V8TV20OP76.10AIALB0FV0HF@kernel.org>
Cc: <linux-integrity@vger.kernel.org>, "Peter Huewe" <peterhuewe@gmx.de>,
 "Jason Gunthorpe" <jgg@ziepe.ca>, "Colin Ian King"
 <colin.i.king@gmail.com>, "Stefan Berger" <stefanb@us.ibm.com>, "Andrew
 Morton" <akpm@osdl.org>, "Seiji Munetoh" <munetoh@jp.ibm.com>, "Kylene Jo
 Hall" <kjhall@us.ibm.com>, "Reiner Sailer" <sailer@us.ibm.com>, "Ard
 Biesheuvel" <ardb@kernel.org>, <stable@vger.kernel.org>, "Andy Liang"
 <andy.liang@hpe.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8] tpm: Map the ACPI provided event log
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Takashi Iwai" <tiwai@suse.de>
X-Mailer: aerc 0.18.2
References: <20241227153911.28128-1-jarkko@kernel.org>
 <87frlzzx14.wl-tiwai@suse.de>
In-Reply-To: <87frlzzx14.wl-tiwai@suse.de>

On Fri Jan 3, 2025 at 6:23 PM EET, Takashi Iwai wrote:
> On Fri, 27 Dec 2024 16:39:09 +0100,
> Jarkko Sakkinen wrote:
> >=20
> > The following failure was reported:
> >=20
> > [   10.693310][    T1] tpm_tis STM0925:00: 2.0 TPM (device-id 0x3, rev-=
id 0)
> > [   10.848132][    T1] ------------[ cut here ]------------
> > [   10.853559][    T1] WARNING: CPU: 59 PID: 1 at mm/page_alloc.c:4727 =
__alloc_pages_noprof+0x2ca/0x330
> > [   10.862827][    T1] Modules linked in:
> > [   10.866671][    T1] CPU: 59 UID: 0 PID: 1 Comm: swapper/0 Not tainte=
d 6.12.0-lp155.2.g52785e2-default #1 openSUSE Tumbleweed (unreleased) 588cd=
98293a7c9eba9013378d807364c088c9375
> > [   10.882741][    T1] Hardware name: HPE ProLiant DL320 Gen12/ProLiant=
 DL320 Gen12, BIOS 1.20 10/28/2024
> > [   10.892170][    T1] RIP: 0010:__alloc_pages_noprof+0x2ca/0x330
> > [   10.898103][    T1] Code: 24 08 e9 4a fe ff ff e8 34 36 fa ff e9 88 =
fe ff ff 83 fe 0a 0f 86 b3 fd ff ff 80 3d 01 e7 ce 01 00 75 09 c6 05 f8 e6 =
ce 01 01 <0f> 0b 45 31 ff e9 e5 fe ff ff f7 c2 00 00 08 00 75 42 89 d9 80 e=
1
> > [   10.917750][    T1] RSP: 0000:ffffb7cf40077980 EFLAGS: 00010246
> > [   10.923777][    T1] RAX: 0000000000000000 RBX: 0000000000040cc0 RCX:=
 0000000000000000
> > [   10.931727][    T1] RDX: 0000000000000000 RSI: 000000000000000c RDI:=
 0000000000040cc0
> >=20
> > Above shows that ACPI pointed a 16 MiB buffer for the log events becaus=
e
> > RSI maps to the 'order' parameter of __alloc_pages_noprof(). Address th=
e
> > bug with kvmalloc() and devm_add_action_or_reset().
>
> It looks like that the subject doesn't match with the patch
> description?
>
> (snip)
> > --- a/drivers/char/tpm/eventlog/acpi.c
> > +++ b/drivers/char/tpm/eventlog/acpi.c
> > @@ -63,6 +63,11 @@ static bool tpm_is_tpm2_log(void *bios_event_log, u6=
4 len)
> >  	return n =3D=3D 0;
> >  }
> > =20
> > +static void tpm_bios_log_free(void *data)
> > +{
> > +	kvfree(data);
> > +}
> > +
> >  /* read binary bios log */
> >  int tpm_read_log_acpi(struct tpm_chip *chip)
> >  {
> > @@ -136,10 +141,16 @@ int tpm_read_log_acpi(struct tpm_chip *chip)
> >  	}
> > =20
> >  	/* malloc EventLog space */
> > -	log->bios_event_log =3D devm_kmalloc(&chip->dev, len, GFP_KERNEL);
> > +	log->bios_event_log =3D kvmalloc(len, GFP_KERNEL);
> >  	if (!log->bios_event_log)
> >  		return -ENOMEM;
> > =20
> > +	ret =3D devm_add_action_or_reset(&chip->dev, tpm_bios_log_free, log->=
bios_event_log);
> > +	if (ret) {
> > +		log->bios_event_log =3D NULL;
> > +		return ret;
> > +	}
> > +
> >  	log->bios_event_log_end =3D log->bios_event_log + len;
> > =20
> >  	virt =3D acpi_os_map_iomem(start, len);
>
> I'm afraid that you forgot to correct the remaining devm_kfree() in
> the error path of this function.
>
> (I know it because I initially posted a similar fix in
>    https://lore.kernel.org/all/20241107112054.28448-1-tiwai@suse.de/
>  Your devm_add_action_or_reset() is a better choice, indeed, though
>  :-)

OK, thanks for the remark! I totally forgot your fix when I went on
tripping on over-engineering :-) [better to admit when you go over the
top]

I'll fix this up after I get back on track after holidays (later this
week or early next weeek).

>
>
> thanks,
>
> Takashi


BR, Jarkko

