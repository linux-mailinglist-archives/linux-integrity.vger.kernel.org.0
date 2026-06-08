Return-Path: <linux-integrity+bounces-9778-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id H4KxLQX+JmpPpQIAu9opvQ
	(envelope-from <linux-integrity+bounces-9778-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Mon, 08 Jun 2026 19:38:13 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC7F659520
	for <lists+linux-integrity@lfdr.de>; Mon, 08 Jun 2026 19:38:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=TrXt9bfr;
	spf=pass (mail.lfdr.de: domain of "linux-integrity+bounces-9778-lists+linux-integrity=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-integrity+bounces-9778-lists+linux-integrity=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5EAA3300E17F
	for <lists+linux-integrity@lfdr.de>; Mon,  8 Jun 2026 17:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40AB63546C3;
	Mon,  8 Jun 2026 17:35:42 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF637367B6A
	for <linux-integrity@vger.kernel.org>; Mon,  8 Jun 2026 17:35:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780940142; cv=none; b=g1CyB9FYuajdKt1QlTA7zapRUfSFWy5KYSlr5OkKlhw3qIl9YiGXPG7H5w0RQzdCRfVV0qltyhHGK3Qw4E7le59qsnlG5wv05kOKptRU2JRge+z8g8UKgDNnuK15WSUCT6bCBx59WjczoiOKfC6BpUAKyH7I+cRtjm7WlibfDRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780940142; c=relaxed/simple;
	bh=1daNk5q97HSwa0tb1eBdGNzq9g+BPBCGIHlCqWVWhyM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZPpZBEXG4F4JdAB0EEgZwPgmj9jY4/RazMmXruv8REmIPamznSv2nEnGuB/fmvvO9+51tIUSKFGnvTayYaLjo6ILiAJhuDjP+xEGvlTg4JOvbd9PnjnnPdtoiUDJT/mCPg27QpJ3aVswBM9fKmvZvIh8MYX93G5f2bjcbfeUzDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TrXt9bfr; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE8461F00898
	for <linux-integrity@vger.kernel.org>; Mon,  8 Jun 2026 17:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780940139;
	bh=u10T0nD1NN9n3AXGG2trN5i3eQsRrI+TOcRfuwZgmKQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=TrXt9bfrPHFgv/TM8y+6Lkz8YsS8pUkPqxY2HB42q/XNCaWkxcXe/CpI9l4iXnrix
	 adcMkZMZvbuTgtFPy3m02UQ1ubtKA9uBg5Ng1LTPLrWsGzKLFfYx2MkWV1JlJQpHW1
	 nB5fs39XpplGBaThJLPxIqDeenwOE4I7CuNGa0NAnU58y1vAwHy18rTsYdIjMCYrIh
	 6Tekejp6Fv8X6CQ92/cF8JmE9CwggB4bM+n5RNmAY5pemr4Z9gvd8LuvIBVvN1IUK7
	 n0SEmwSlsshgGBq4OghNk/mU2tJWkcuUj5PeY56dMa/hXegEWADywmjS6fSG/tmHxQ
	 BOc80YrnHWMkg==
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-3965adfd75fso41402371fa.1
        for <linux-integrity@vger.kernel.org>; Mon, 08 Jun 2026 10:35:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9Kf+EUqbl1XFgKvdYVgAHL+o2fsAFwiU0WdFfoTMOMpqDKeGL/hM/ZCteH27tKwMwX6YBt5LadlO+GJ+m6250=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjYwNuI1u/DJjhSiXrjsMY+Mi2cYDUEXR60uWYQLtFRK6LyTCI
	85DNToWvLH1owqvbtLNqJCpMH2Wj6Suqx4R5aYt+M2uxJpbPVg9R0k3ZlxKoOQ+6g2O+0scXLTU
	MSB/Dsr8R8mlpIkXlQsb/JqTHk6tyE5I=
X-Received: by 2002:a05:6512:138b:b0:5aa:6b09:2ac3 with SMTP id
 2adb3069b0e04-5aa87b80a79mr5423518e87.24.1780940138110; Mon, 08 Jun 2026
 10:35:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2848144.mvXUDI8C0e@rafael.j.wysocki> <agfFERWn-5b-0H24@kernel.org>
 <CAJZ5v0jQUQ85MpyPZNbLmxqaGGvsTBKsdf8gdPNmFFSpZkj4eQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0jQUQ85MpyPZNbLmxqaGGvsTBKsdf8gdPNmFFSpZkj4eQ@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 8 Jun 2026 19:35:26 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iQO_ozXQpzj4qKLegRzMURPDjJV47ynfL6OAUUg_8f4w@mail.gmail.com>
X-Gm-Features: AVVi8CfAsmPELV8FvWVvQLiemflysSn_64WMNTO18O0ofD1QNhP95Vleo2mm8ic
Message-ID: <CAJZ5v0iQO_ozXQpzj4qKLegRzMURPDjJV47ynfL6OAUUg_8f4w@mail.gmail.com>
Subject: Re: [PATCH v1] tpm_crb: Check ACPI_COMPANION() against NULL during probe
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>, 
	Linux ACPI <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmx.de,ziepe.ca,vger.kernel.org,linux.intel.com];
	TAGGED_FROM(0.00)[bounces-9778-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jarkko@kernel.org,m:peterhuewe@gmx.de,m:jgg@ziepe.ca,m:linux-integrity@vger.kernel.org,m:andriy.shevchenko@linux.intel.com,m:linux-kernel@vger.kernel.org,m:linux-acpi@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[rafael@kernel.org,linux-integrity@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-integrity@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,vger.kernel.org:from_smtp,intel.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BFC7F659520

On Tue, May 19, 2026 at 11:01=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.o=
rg> wrote:
>
> On Sat, May 16, 2026 at 3:15=E2=80=AFAM Jarkko Sakkinen <jarkko@kernel.or=
g> wrote:
> >
> > On Tue, May 12, 2026 at 06:16:23PM +0200, Rafael J. Wysocki wrote:
> > > From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> > >
> > > Every platform driver can be forced to match a device that doesn't ma=
tch
> > > its list of device IDs because of device_match_driver_override(), so
> > > platform drivers that rely on the existence of a device's ACPI compan=
ion
> > > object need to verify its presence.
> > >
> > > Accordingly, add a requisite ACPI_COMPANION() check against NULL to t=
he
> > > tpm_crb driver.
> > >
> > > Fixes: 48fe2cddc85c ("tpm_crb: Convert ACPI driver to a platform one"=
)
> > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > ---
> > >  drivers/char/tpm/tpm_crb.c |    6 +++++-
> > >  1 file changed, 5 insertions(+), 1 deletion(-)
> > >
> > > --- a/drivers/char/tpm/tpm_crb.c
> > > +++ b/drivers/char/tpm/tpm_crb.c
> > > @@ -786,8 +786,8 @@ static int crb_map_pluton(struct device
> > >  static int crb_acpi_probe(struct platform_device *pdev)
> > >  {
> > >       struct device *dev =3D &pdev->dev;
> > > -     struct acpi_device *device =3D ACPI_COMPANION(dev);
> > >       struct acpi_table_tpm2 *buf;
> > > +     struct acpi_device *device;
> > >       struct crb_priv *priv;
> > >       struct tpm_chip *chip;
> > >       struct tpm2_crb_smc *crb_smc;
> > > @@ -797,6 +797,10 @@ static int crb_acpi_probe(struct platfor
> > >       u32 sm;
> > >       int rc;
> > >
> > > +     device =3D ACPI_COMPANION(dev);
> > > +     if (!device)
> > > +             return -ENODEV;
> > > +
> > >       status =3D acpi_get_table(ACPI_SIG_TPM2, 1,
> > >                               (struct acpi_table_header **) &buf);
> > >       if (ACPI_FAILURE(status) || buf->header.length < sizeof(*buf)) =
{
> > >
> > >
> > >
> >
> > Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
>
> Thanks!
>
> So do you want me to pick up this one?

I took the silence as consent and picked it up.  If you'd rather route
it differently, please let me know.

Thanks!

