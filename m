Return-Path: <linux-integrity+bounces-4479-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 869909FCD94
	for <lists+linux-integrity@lfdr.de>; Thu, 26 Dec 2024 21:22:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C3DB160D8B
	for <lists+linux-integrity@lfdr.de>; Thu, 26 Dec 2024 20:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C66143C7E;
	Thu, 26 Dec 2024 20:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CGcLUbJ+"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A413518E1F;
	Thu, 26 Dec 2024 20:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735244562; cv=none; b=jkEL4q2iUk9jrQWNKHRNCBfUlpE7ScNgV9VrA2axrE+0W97SUxx0Jy5g0blh1FLsBnSoM7GVBlvFOWuBROxOiXUmuTIwcD2nUpuyz7g3tNAL1eTol/Y0M55dQcrEpkUUEVA5/IB19SpogPadB8Z+8jSL1BFgDXOmiaLzqKOw0BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735244562; c=relaxed/simple;
	bh=GA7J+jMmYsm8q4PJgNbUdwhz4o5CZkLxwcBc2wVOKps=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=JuKji18EWVdkh34SBwPyaAcSr05nXTpX7h/N4UBK5BkE8XQ1fJTvrfsRLDJN7j0nNqyxSSJG5xPthJIhCQotSlbHGIa/oCFGTZVtAgs2mFVNgLkQ6EiI1ju95RAbd+DUNuZP7ToV7XkozPww5yxkVfKC06kQRgN6ureA1owuI9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CGcLUbJ+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2DEFC4CED1;
	Thu, 26 Dec 2024 20:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735244562;
	bh=GA7J+jMmYsm8q4PJgNbUdwhz4o5CZkLxwcBc2wVOKps=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=CGcLUbJ+xvxTaAsl6USGbzIOA8Mt4KYrkhOsOQMF86UIEbGQAF7TYCpdXPpkI+qpm
	 jxPEA1ue3PhCw1qA+sOPsbt8diPD6nK2ll0o5ujL2lsTlMu8dkjEJfvKN1AMLe4iYc
	 7/FYX0R7+yLBc2tggYPQTHZ0WqK9a7UIWJhvn2SFZDlCgqtDqKQmBlCUcje1lpZFBj
	 Ac7hKvGj1Yw4dV4tF7RmLROsZhwSuRSt4r03desw0RnILZAvivT1oEQDelZkZBjiet
	 MIe9JwkF9iR20UXyHhySV02tepTmEJQRZFdIZVT6HC79oG9Bxn2Gq5ild4kXtxFusL
	 bHQqx+w3y/QWg==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 26 Dec 2024 22:22:37 +0200
Message-Id: <D6LWUWNIILWL.1JXPT3L8GOC1H@kernel.org>
Cc: <stable@vger.kernel.org>, "Andy Liang" <andy.liang@hpe.com>, "Matthew
 Garrett" <mjg59@srcf.ucam.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 1/2] tpm: Map the ACPI provided event log
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>,
 <linux-integrity@vger.kernel.org>, "Peter Huewe" <peterhuewe@gmx.de>,
 "Jason Gunthorpe" <jgg@ziepe.ca>, "Colin Ian King"
 <colin.i.king@gmail.com>, "Seiji Munetoh" <munetoh@jp.ibm.com>, "Andrew
 Morton" <akpm@osdl.org>, "Reiner Sailer" <sailer@us.ibm.com>, "Kylene Jo
 Hall" <kjhall@us.ibm.com>, "Stefan Berger" <stefanb@us.ibm.com>
X-Mailer: aerc 0.18.2
References: <20241225193242.40066-1-jarkko@kernel.org>
 <D6LRNN9Q88F8.3EVLQ1JYK3UEW@kernel.org>
In-Reply-To: <D6LRNN9Q88F8.3EVLQ1JYK3UEW@kernel.org>

On Thu Dec 26, 2024 at 6:18 PM EET, Jarkko Sakkinen wrote:
> On Wed Dec 25, 2024 at 9:32 PM EET, Jarkko Sakkinen wrote:
> > The following failure was reported:
> >
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
> >
> > Above shows that ACPI pointed a 16 MiB buffer for the log events becaus=
e
> > RSI maps to the 'order' parameter of __alloc_pages_noprof(). Address th=
e
> > bug with kvmalloc() and devres_add().
> >
> > Cc: stable@vger.kernel.org # v2.6.16+
> > Fixes: 55a82ab3181b ("[PATCH] tpm: add bios measurement log")
> > Reported-by: Andy Liang <andy.liang@hpe.com>
> > Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D219495
> > Suggested-by: Matthew Garrett <mjg59@srcf.ucam.org>
>
> Oops, needs to be dropped from this.
>
> > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> > ---
> > v6:
> > * A new patch.
> > ---
> >  drivers/char/tpm/eventlog/acpi.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/char/tpm/eventlog/acpi.c b/drivers/char/tpm/eventl=
og/acpi.c
> > index 69533d0bfb51..7cd44a46a0d7 100644
> > --- a/drivers/char/tpm/eventlog/acpi.c
> > +++ b/drivers/char/tpm/eventlog/acpi.c
> > @@ -136,10 +136,12 @@ int tpm_read_log_acpi(struct tpm_chip *chip)
> >  	}
> > =20
> >  	/* malloc EventLog space */
> > -	log->bios_event_log =3D devm_kmalloc(&chip->dev, len, GFP_KERNEL);
> > +	log->bios_event_log =3D kvmalloc(len, GFP_KERNEL);
> >  	if (!log->bios_event_log)
> >  		return -ENOMEM;
> > =20
> > +	devres_add(&chip->dev, log->bios_event_log);
> > +
>
> We either need to git revert 441b7152729f ("tpm: Use managed allocation
> for bios event log") OR alternatively use devm_add_action() creating a
> fix that wastes 16 MiB of memory and obfuscates flows more than needed.
>
> I don't necessarily get how come this is "less intrusive"...

Right, so I guess it's not actually very complicated:

ret =3D devm_add_action_or_reset(&chip->dev, kvfree, &log->bios_event_log)
if (ret) {
	log->bios_event_log =3D NULL;
	return ret;
}

Had not used this API since we used it in tpmm_chip_alloc(). I'll tweak
the patch accordingly...

And since 2/2 becomes a feature patch I'll refine it to do a traverse of
the log so we know the actual size of the populated contents and then
move back on using devm_kmalloc() in that patch (i.e. it will render
out also the fix that the first patch makes).

Not too bad, I can live this.

BR, Jarkko

