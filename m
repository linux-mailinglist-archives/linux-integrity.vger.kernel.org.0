Return-Path: <linux-integrity+bounces-9606-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OIzKG2bQDGrImQUAu9opvQ
	(envelope-from <linux-integrity+bounces-9606-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 19 May 2026 23:04:38 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E7F38584FA5
	for <lists+linux-integrity@lfdr.de>; Tue, 19 May 2026 23:04:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CF8FE305DEF3
	for <lists+linux-integrity@lfdr.de>; Tue, 19 May 2026 21:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC8013E3166;
	Tue, 19 May 2026 21:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RB0AlIja"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E943E276A
	for <linux-integrity@vger.kernel.org>; Tue, 19 May 2026 21:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779224483; cv=none; b=PvoI6kltUSLajeL2IVeqRObWZQ0SmI50rnL4co6SSAiY6KlWVuTEYLdCWZU+jgQbLWyu8rvBu9KdIDWhIviaBIya1B/XOTrzhTPSSs+gqW33/59o1PEl4s1nDA5iqFQSNhmrOY0ZBJrnk9BYUDiuPDLJIyrQEPGXM8Qw5RJDvYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779224483; c=relaxed/simple;
	bh=Z3cJOTmakhG2ToQHT/5FxzyoNWm1hdaFax+j9zTe9IY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fdcXVNyZ5Jlr+5RFqEgKH5x+gLXy7OnpFrQ6Npzgt5JfD/XIFk4LyvqESPhzZ38Ookr3CHJGpp6x34scQ6enUHt00hqdi79ma0f/oGnjlq3BoYcpuVChByJ3N5tXqYUIQ+ykLHE0R2BW3Q7q1gcI+D+vTWIvZnzDV25hsVgqquA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RB0AlIja; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C06981F00896
	for <linux-integrity@vger.kernel.org>; Tue, 19 May 2026 21:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779224480;
	bh=ciNNq/asO0Xczbe18xuJLKGNXvHiS5vIKAICk9vV2Vs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=RB0AlIjauT81LR0eELfgA7A/hnlIr1fLDoCEyXyT6J1958im936FTatmIVI4Pz344
	 Xf+jvS62tpekH73Y7xQXSvB8J4OSXXzrEoCfm7aeKReUCAJruTNJIB8f8T9qGM5sSP
	 McFOkACIJ+c/+GKjSvPxRizg1M4Gd7vVj2lGOuQPibIFKHSJ/RUIWgMptRxUFLtvQ6
	 esmr6A3N/S4+7slbgQ/WSU6z6Tpom2g6rjORcKJFqRLUXm+ksrwJYJBnsoL1n+49LG
	 eo0S4YKnXnfceUn32g1ha0b0fo9llWvduqDFnj7HxHR9Pd5k7XK60A6dqlWLCpPDxc
	 /cXDclu5H2U9w==
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-3942e9977a5so52446801fa.1
        for <linux-integrity@vger.kernel.org>; Tue, 19 May 2026 14:01:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/dhUz+p+uPs2t3/d2N3Sp1kDxdVJLt6n+4W5kvV5mvp2+AkmUmMNAxXEfKyAOG+q4wi3A8NyYP/CyUIHPZ9No=@vger.kernel.org
X-Gm-Message-State: AOJu0Yykp9QU+1z2comjAt+l9vh6DLZD7X9Q9j4jh0g25cxfFXqi4phl
	brX368jdOpH1D0LHCjTDN/+Hzm7/b05x7g2n6QnBY2JTC6FPVhsaO+ZF8CO3udQVnatnMTJCUXB
	OdMLv1R0QCGPStYdRwZr9X4iTgBuLZgQ=
X-Received: by 2002:a05:6512:3b1e:b0:5a2:b514:4fbb with SMTP id
 2adb3069b0e04-5aa0df9adf6mr5089577e87.11.1779224479262; Tue, 19 May 2026
 14:01:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2848144.mvXUDI8C0e@rafael.j.wysocki> <agfFERWn-5b-0H24@kernel.org>
In-Reply-To: <agfFERWn-5b-0H24@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 19 May 2026 23:01:07 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jQUQ85MpyPZNbLmxqaGGvsTBKsdf8gdPNmFFSpZkj4eQ@mail.gmail.com>
X-Gm-Features: AVHnY4I9klusfThoCs0TQ2e3DPUhwmyxrTWlknteBVSl45ihQaxaiAEhLjhk2eI
Message-ID: <CAJZ5v0jQUQ85MpyPZNbLmxqaGGvsTBKsdf8gdPNmFFSpZkj4eQ@mail.gmail.com>
Subject: Re: [PATCH v1] tpm_crb: Check ACPI_COMPANION() against NULL during probe
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, 
	linux-integrity@vger.kernel.org, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>, 
	Linux ACPI <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FREEMAIL_CC(0.00)[kernel.org,gmx.de,ziepe.ca,vger.kernel.org,linux.intel.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9606-lists,linux-integrity=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-integrity@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: E7F38584FA5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, May 16, 2026 at 3:15=E2=80=AFAM Jarkko Sakkinen <jarkko@kernel.org>=
 wrote:
>
> On Tue, May 12, 2026 at 06:16:23PM +0200, Rafael J. Wysocki wrote:
> > From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> >
> > Every platform driver can be forced to match a device that doesn't matc=
h
> > its list of device IDs because of device_match_driver_override(), so
> > platform drivers that rely on the existence of a device's ACPI companio=
n
> > object need to verify its presence.
> >
> > Accordingly, add a requisite ACPI_COMPANION() check against NULL to the
> > tpm_crb driver.
> >
> > Fixes: 48fe2cddc85c ("tpm_crb: Convert ACPI driver to a platform one")
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  drivers/char/tpm/tpm_crb.c |    6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > --- a/drivers/char/tpm/tpm_crb.c
> > +++ b/drivers/char/tpm/tpm_crb.c
> > @@ -786,8 +786,8 @@ static int crb_map_pluton(struct device
> >  static int crb_acpi_probe(struct platform_device *pdev)
> >  {
> >       struct device *dev =3D &pdev->dev;
> > -     struct acpi_device *device =3D ACPI_COMPANION(dev);
> >       struct acpi_table_tpm2 *buf;
> > +     struct acpi_device *device;
> >       struct crb_priv *priv;
> >       struct tpm_chip *chip;
> >       struct tpm2_crb_smc *crb_smc;
> > @@ -797,6 +797,10 @@ static int crb_acpi_probe(struct platfor
> >       u32 sm;
> >       int rc;
> >
> > +     device =3D ACPI_COMPANION(dev);
> > +     if (!device)
> > +             return -ENODEV;
> > +
> >       status =3D acpi_get_table(ACPI_SIG_TPM2, 1,
> >                               (struct acpi_table_header **) &buf);
> >       if (ACPI_FAILURE(status) || buf->header.length < sizeof(*buf)) {
> >
> >
> >
>
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

Thanks!

So do you want me to pick up this one?

