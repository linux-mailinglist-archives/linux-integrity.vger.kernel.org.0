Return-Path: <linux-integrity+bounces-9784-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id G8TAH7NDKGodBQMAu9opvQ
	(envelope-from <linux-integrity+bounces-9784-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 09 Jun 2026 18:47:47 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C6AF1662921
	for <lists+linux-integrity@lfdr.de>; Tue, 09 Jun 2026 18:47:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=WplAexqP;
	spf=pass (mail.lfdr.de: domain of "linux-integrity+bounces-9784-lists+linux-integrity=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-integrity+bounces-9784-lists+linux-integrity=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7B9C3304B106
	for <lists+linux-integrity@lfdr.de>; Tue,  9 Jun 2026 16:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 204C8379C48;
	Tue,  9 Jun 2026 16:15:02 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0746B370AC0
	for <linux-integrity@vger.kernel.org>; Tue,  9 Jun 2026 16:15:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781021702; cv=none; b=DfYtdY9r3RaNBbk1u5pcQtayWeg4zXDGMV0OTzoQ4E0VM+ekh+k9+kRMadmqQv82SuLyxjEQGIy3+Z4jsCaGYIkbTDaEGkwTe3nkuLpKBLf94EVy0b0iDdvxfI/5T3VnxkZ5i8LAnG0H/9pTklsj4lkLDsK7Y9lY+2IdrgvKPpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781021702; c=relaxed/simple;
	bh=Q9bWpMZs8FyTozy8wXnSMg5QFjTaPa60Wbjesa7I+A4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ijMPxWdNyY+/TY/MV9CMOgcKnQWNiJN2n124SHmeYcKdx91hITti1NiqIIshNNX1m0dciob9Khw14oAU0zpj9XEFRxfq1i56MG4Bi9fgpbUrwnkJ1s6GgTOFYM+kClbzD0z2CYdV1fbMQh7zGa/f4a3dJdvyGFWd8NOeGFWRRLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WplAexqP; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C72AA1F0089B
	for <linux-integrity@vger.kernel.org>; Tue,  9 Jun 2026 16:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781021700;
	bh=Ab4aIADGVblTrxw/cAPTIFYBhgT6NEHMoT+mxpSvH5U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=WplAexqP1rkCHo6I9YnD6ESmBwUBwNWIfgcgYtcAtZRbPuTuU7N1d+c2UR9lyjidL
	 70tZgC5wQUH0yVYJqViF0EzGPbFCt2wwdxIFYruSFcYI1QYAhZ9joKBhSgGnSHELnM
	 xhEAddO1m/hfDEvfY8kA5YNHMSFnzEK2gB8TEqiNJ9KJ5RyymI9C6jnzBRCHrbacHZ
	 zeTUSrVSn68XrkIRZQwID1xe2cHG/V0ynDWuS8Uu7KPEn7UxNZnDKU6+J9rfff/TGl
	 ZgOaq4wc32HTBTL08KCbQHjVHPK38/5Icfmly6NrJVh2Rjiuu3nsBWhh4Tn7voqxn4
	 noAMpx9aZs7Dw==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5aa68d9d56fso5813818e87.2
        for <linux-integrity@vger.kernel.org>; Tue, 09 Jun 2026 09:15:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8dTApgdnaQi+AE8Ivo9mpGwmiuxA29v/KjzfGZqKHqBvbTK7VZzWOVsG6fUQsEQczER9JMSdvLm3EammerIT0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yza/vj/3dQ2JHZ4pTChP5+JNtX20s7bx+tayq3Cj3UnLwkH4SOu
	jujz/C35UVjxoUTb2mZraFMo+l8Q3Nd0kPdnh/t5M+NWiztK54lhdtSooRVlW7wZ6wyfLNiMWfk
	Q43xt8Zs/nfpZ8LNB8vV6hIofoV1vInk=
X-Received: by 2002:a05:6512:6482:b0:5aa:6fff:c3e3 with SMTP id
 2adb3069b0e04-5aa87bf3730mr5758829e87.33.1781021699090; Tue, 09 Jun 2026
 09:14:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2848144.mvXUDI8C0e@rafael.j.wysocki> <agfFERWn-5b-0H24@kernel.org>
 <CAJZ5v0jQUQ85MpyPZNbLmxqaGGvsTBKsdf8gdPNmFFSpZkj4eQ@mail.gmail.com>
 <CAJZ5v0iQO_ozXQpzj4qKLegRzMURPDjJV47ynfL6OAUUg_8f4w@mail.gmail.com> <aig1IKKZYid2BQIB@kernel.org>
In-Reply-To: <aig1IKKZYid2BQIB@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 9 Jun 2026 18:14:47 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jAh2rGxUn1ajXamDH0n9-zPtnh7pos=iRC1DwWi7pi=A@mail.gmail.com>
X-Gm-Features: AVVi8CfgRKOE_cGah-O_j_VXvaNXeHm4o6yiHjO-Gj3HI89r27L6-sKEzlXGI0Y
Message-ID: <CAJZ5v0jAh2rGxUn1ajXamDH0n9-zPtnh7pos=iRC1DwWi7pi=A@mail.gmail.com>
Subject: Re: [PATCH v1] tpm_crb: Check ACPI_COMPANION() against NULL during probe
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, 
	linux-integrity@vger.kernel.org, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>, 
	Linux ACPI <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9784-lists,linux-integrity=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,gmx.de,ziepe.ca,vger.kernel.org,linux.intel.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[rafael@kernel.org,linux-integrity@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:jarkko@kernel.org,m:rafael@kernel.org,m:peterhuewe@gmx.de,m:jgg@ziepe.ca,m:linux-integrity@vger.kernel.org,m:andriy.shevchenko@linux.intel.com,m:linux-kernel@vger.kernel.org,m:linux-acpi@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-integrity@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mail.gmail.com:mid,intel.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C6AF1662921

On Tue, Jun 9, 2026 at 5:45=E2=80=AFPM Jarkko Sakkinen <jarkko@kernel.org> =
wrote:
>
> On Mon, Jun 08, 2026 at 07:35:26PM +0200, Rafael J. Wysocki wrote:
> > On Tue, May 19, 2026 at 11:01=E2=80=AFPM Rafael J. Wysocki <rafael@kern=
el.org> wrote:
> > >
> > > On Sat, May 16, 2026 at 3:15=E2=80=AFAM Jarkko Sakkinen <jarkko@kerne=
l.org> wrote:
> > > >
> > > > On Tue, May 12, 2026 at 06:16:23PM +0200, Rafael J. Wysocki wrote:
> > > > > From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> > > > >
> > > > > Every platform driver can be forced to match a device that doesn'=
t match
> > > > > its list of device IDs because of device_match_driver_override(),=
 so
> > > > > platform drivers that rely on the existence of a device's ACPI co=
mpanion
> > > > > object need to verify its presence.
> > > > >
> > > > > Accordingly, add a requisite ACPI_COMPANION() check against NULL =
to the
> > > > > tpm_crb driver.
> > > > >
> > > > > Fixes: 48fe2cddc85c ("tpm_crb: Convert ACPI driver to a platform =
one")
> > > > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > > ---
> > > > >  drivers/char/tpm/tpm_crb.c |    6 +++++-
> > > > >  1 file changed, 5 insertions(+), 1 deletion(-)
> > > > >
> > > > > --- a/drivers/char/tpm/tpm_crb.c
> > > > > +++ b/drivers/char/tpm/tpm_crb.c
> > > > > @@ -786,8 +786,8 @@ static int crb_map_pluton(struct device
> > > > >  static int crb_acpi_probe(struct platform_device *pdev)
> > > > >  {
> > > > >       struct device *dev =3D &pdev->dev;
> > > > > -     struct acpi_device *device =3D ACPI_COMPANION(dev);
> > > > >       struct acpi_table_tpm2 *buf;
> > > > > +     struct acpi_device *device;
> > > > >       struct crb_priv *priv;
> > > > >       struct tpm_chip *chip;
> > > > >       struct tpm2_crb_smc *crb_smc;
> > > > > @@ -797,6 +797,10 @@ static int crb_acpi_probe(struct platfor
> > > > >       u32 sm;
> > > > >       int rc;
> > > > >
> > > > > +     device =3D ACPI_COMPANION(dev);
> > > > > +     if (!device)
> > > > > +             return -ENODEV;
> > > > > +
> > > > >       status =3D acpi_get_table(ACPI_SIG_TPM2, 1,
> > > > >                               (struct acpi_table_header **) &buf)=
;
> > > > >       if (ACPI_FAILURE(status) || buf->header.length < sizeof(*bu=
f)) {
> > > > >
> > > > >
> > > > >
> > > >
> > > > Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> > >
> > > Thanks!
> > >
> > > So do you want me to pick up this one?
> >
> > I took the silence as consent and picked it up.  If you'd rather route
> > it differently, please let me know.
>
> OK my bad in commes, sorry. I did already pick this up and it is
> going to my next PR.

OK, I'll drop it then, thanks!

