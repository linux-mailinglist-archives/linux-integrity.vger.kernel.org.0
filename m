Return-Path: <linux-integrity+bounces-9783-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Z2BEBoY8KGoIAwMAu9opvQ
	(envelope-from <linux-integrity+bounces-9783-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 09 Jun 2026 18:17:10 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DCC46623E3
	for <lists+linux-integrity@lfdr.de>; Tue, 09 Jun 2026 18:17:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=HYU3B7nl;
	spf=pass (mail.lfdr.de: domain of "linux-integrity+bounces-9783-lists+linux-integrity=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-integrity+bounces-9783-lists+linux-integrity=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D9C0F316017C
	for <lists+linux-integrity@lfdr.de>; Tue,  9 Jun 2026 15:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A93C36EAB9;
	Tue,  9 Jun 2026 15:45:41 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ACD236D9E8;
	Tue,  9 Jun 2026 15:45:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781019941; cv=none; b=UVCYPWBDrDu4LEbpmTK0Fy5zBlUabg/lUJdV2XU3/3NpX8dIwPQcUU3OKBLiG5IzdhUPbBkzxx8IEYETgYE8zsGuzIk6vbYbHQMe1Qa/nWpYbyFFcfUr2qwFxXjIkEnRveCtYkcJLZKCpcc51DCBh85Epkogp6MwrBmCxnKupd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781019941; c=relaxed/simple;
	bh=d00WZ7n4qiROgFaKT1MqmkwSYlrH5OGbyudYllffNhI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CxE3aKPRJV74k7WPHvWbaqFSoMmOQ8rfMb7Dq5qQe20W9sBomM4V7+CJpQnC/8ep4mGSCEIRT2JDxtTKZiKILhoX1ZRKgaUVEU5MV5EPBUTbtjyUh2nLPRlxvWVA7VfkDfcM92tZ8AcZhg9V1d1sSW6zigC8mAH0btAX//XAK/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HYU3B7nl; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 2CDC21F00899;
	Tue,  9 Jun 2026 15:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781019939;
	bh=rkoRNjuCtCuZgM1S2mfY+RwDxl51UaHcMP/HJiUpPAI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HYU3B7nlj5/hkultzgeFuZ2vm582UXZCg+GFvueu+hiD4hoFr+zddZvXv7uq7ksgr
	 mL7lIVJ/ZCFYXJjnDYVrIq6idrFDT0D7vOd7sYgLXGJgm/dAD29wm2/ZkiQTNJgnaG
	 TC1I+TZwJTxN9/tGFu+E2gPD1ydjTX/pOWoSoFbBO2rggp6vhaICx65jWWFCeLp0B3
	 FpjpTUN2eiiJ5nUpfmKJVtpD227aSJWZBKtbs2kpkn2xGQVUohESC3Xi7kc3Ypj4cp
	 4PTjOiGoEsi3wm0SaUNClrU66pF3ml2rxBdrZWRr97LKVISY4swkXZk7L4Xwbsi907
	 2r7geH+eBvW8Q==
Date: Tue, 9 Jun 2026 18:45:36 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	linux-integrity@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux ACPI <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v1] tpm_crb: Check ACPI_COMPANION() against NULL during
 probe
Message-ID: <aig1IKKZYid2BQIB@kernel.org>
References: <2848144.mvXUDI8C0e@rafael.j.wysocki>
 <agfFERWn-5b-0H24@kernel.org>
 <CAJZ5v0jQUQ85MpyPZNbLmxqaGGvsTBKsdf8gdPNmFFSpZkj4eQ@mail.gmail.com>
 <CAJZ5v0iQO_ozXQpzj4qKLegRzMURPDjJV47ynfL6OAUUg_8f4w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0iQO_ozXQpzj4qKLegRzMURPDjJV47ynfL6OAUUg_8f4w@mail.gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9783-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:rafael@kernel.org,m:peterhuewe@gmx.de,m:jgg@ziepe.ca,m:linux-integrity@vger.kernel.org,m:andriy.shevchenko@linux.intel.com,m:linux-kernel@vger.kernel.org,m:linux-acpi@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jarkko@kernel.org,linux-integrity@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmx.de,ziepe.ca,vger.kernel.org,linux.intel.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jarkko@kernel.org,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[linux-integrity];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5DCC46623E3

On Mon, Jun 08, 2026 at 07:35:26PM +0200, Rafael J. Wysocki wrote:
> On Tue, May 19, 2026 at 11:01 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Sat, May 16, 2026 at 3:15 AM Jarkko Sakkinen <jarkko@kernel.org> wrote:
> > >
> > > On Tue, May 12, 2026 at 06:16:23PM +0200, Rafael J. Wysocki wrote:
> > > > From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> > > >
> > > > Every platform driver can be forced to match a device that doesn't match
> > > > its list of device IDs because of device_match_driver_override(), so
> > > > platform drivers that rely on the existence of a device's ACPI companion
> > > > object need to verify its presence.
> > > >
> > > > Accordingly, add a requisite ACPI_COMPANION() check against NULL to the
> > > > tpm_crb driver.
> > > >
> > > > Fixes: 48fe2cddc85c ("tpm_crb: Convert ACPI driver to a platform one")
> > > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > ---
> > > >  drivers/char/tpm/tpm_crb.c |    6 +++++-
> > > >  1 file changed, 5 insertions(+), 1 deletion(-)
> > > >
> > > > --- a/drivers/char/tpm/tpm_crb.c
> > > > +++ b/drivers/char/tpm/tpm_crb.c
> > > > @@ -786,8 +786,8 @@ static int crb_map_pluton(struct device
> > > >  static int crb_acpi_probe(struct platform_device *pdev)
> > > >  {
> > > >       struct device *dev = &pdev->dev;
> > > > -     struct acpi_device *device = ACPI_COMPANION(dev);
> > > >       struct acpi_table_tpm2 *buf;
> > > > +     struct acpi_device *device;
> > > >       struct crb_priv *priv;
> > > >       struct tpm_chip *chip;
> > > >       struct tpm2_crb_smc *crb_smc;
> > > > @@ -797,6 +797,10 @@ static int crb_acpi_probe(struct platfor
> > > >       u32 sm;
> > > >       int rc;
> > > >
> > > > +     device = ACPI_COMPANION(dev);
> > > > +     if (!device)
> > > > +             return -ENODEV;
> > > > +
> > > >       status = acpi_get_table(ACPI_SIG_TPM2, 1,
> > > >                               (struct acpi_table_header **) &buf);
> > > >       if (ACPI_FAILURE(status) || buf->header.length < sizeof(*buf)) {
> > > >
> > > >
> > > >
> > >
> > > Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> >
> > Thanks!
> >
> > So do you want me to pick up this one?
> 
> I took the silence as consent and picked it up.  If you'd rather route
> it differently, please let me know.

OK my bad in commes, sorry. I did already pick this up and it is
going to my next PR. 

> 
> Thanks!

BR, Jarkko

