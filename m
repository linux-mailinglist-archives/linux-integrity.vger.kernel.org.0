Return-Path: <linux-integrity+bounces-9577-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wJxiIqqiB2rP/QIAu9opvQ
	(envelope-from <linux-integrity+bounces-9577-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Sat, 16 May 2026 00:48:10 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DCE025590BD
	for <lists+linux-integrity@lfdr.de>; Sat, 16 May 2026 00:48:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 332A73044A49
	for <lists+linux-integrity@lfdr.de>; Fri, 15 May 2026 22:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81E643F5BE4;
	Fri, 15 May 2026 22:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gnPTfJ+R"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C683EDE5D;
	Fri, 15 May 2026 22:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778884903; cv=none; b=QQuBm+njZeox9lsr2QI+sp5mpot8NDdwH2N94TKkhsb9lBCQv3eZ29t/fhFxm+d8gCyJe+0V9+NS+URHIng8f0ipopgFvcmXhV4PxqqszeSj3i4aQUeA8rQlEUodtia5jXSomH0dK+nbqIg9cLBZVW6BI4GZ2xP2KoA4RHPk4c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778884903; c=relaxed/simple;
	bh=vwnfB6OTSLu4o0gd0wwhHgrUy6uPRuAtrdwUcvsuZaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pVJ3vhcg8styPPsVistqekeXf/ixsAWqm0Z9WIwJ6v6J0xWuqlys8L67w5ecSA1e+Ef9ugJIGO0Nxzfqnee81Hv0FXQOli4XbBXZoC0PKL/I9DtMLzEn4nw7hhOCvLUehlZGxs5EE7vPmkTFP4dUFPWL8q+RnSYzfoyX4C5DmE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gnPTfJ+R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDB09C2BCB7;
	Fri, 15 May 2026 22:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778884903;
	bh=vwnfB6OTSLu4o0gd0wwhHgrUy6uPRuAtrdwUcvsuZaQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gnPTfJ+Ri9QqhNQwootlQN9lXU0FyH3/QH+2ZVwscjTCW6a6B54MV/UtcsvrtVIcU
	 sYEw1aFb9qLkfZPFrbWOcXyfNh8zJbg46f+vOV6qH/SFKheoNxFS15pB+JgYC4noom
	 zYDQ+vhNMPLDbyQm2+jOztB6raJGsnLTR6pi+5+/QkA+S63kKLc08BKRw6ZQbqm46r
	 uQQb24Ar6gaT3PIIMWuwuH1DGN+naz5ThMztbnJK8AyftW37t6tra9I/TfAq+34xt0
	 aRBFwvZYOEiPbRzuMOhm2OxDczsfVs4i5YTxwgCZLwYRbSBBAkkVWbN3fxnnE+zVwx
	 KomNgoaKPyB2A==
Date: Sat, 16 May 2026 01:41:39 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Linus Walleij <linusw@kernel.org>
Cc: linux-integrity@vger.kernel.org, stable@vger.kernel.org,
	Stefan Wahren <wahrenst@gmx.net>, Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm: tpm_tis_spi: Use wait_woken() in wait_for_tmp_stat()
Message-ID: <agehI06xyfq4SxXV@kernel.org>
References: <20260509185108.2681198-1-jarkko@kernel.org>
 <CAD++jLke5Net94=JUCJAyn5YxMx0raCWTUx+Nk6hKhcXxfU-kw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD++jLke5Net94=JUCJAyn5YxMx0raCWTUx+Nk6hKhcXxfU-kw@mail.gmail.com>
X-Rspamd-Queue-Id: DCE025590BD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9577-lists,linux-integrity=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmx.net,gmx.de,ziepe.ca];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jarkko@kernel.org,linux-integrity@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Mon, May 11, 2026 at 10:10:21AM +0200, Linus Walleij wrote:
> On Sat, May 9, 2026 at 8:51 PM Jarkko Sakkinen <jarkko@kernel.org> wrote:
> 
> > wait_event_interruptible_timeout() evaluates its condition after setting
> > the current task state to TASK_INTERRUPTIBLE.
> >
> > With CONFIG_DEBUG_ATOMIC_SLEEP this triggers a warning when the IRQ wait
> > path is used:
> >
> >     tpm_tis_status()
> >       tpm_tis_spi_read_bytes()
> >         tpm_tis_spi_transfer_full()
> >           spi_bus_lock()
> >             mutex_lock()
> >
> > Address this with the following measures:
> >
> > 1. Call wait_tpm_stat_cond() only while tasking is running.
> > 2. Use wait_woken() to wait for changes.
> >
> > Cc: stable@vger.kernel.org # v4.19+
> > Cc: Linus Walleij <linusw@kernel.org>
> > Reported-by: Stefan Wahren <wahrenst@gmx.net>
> > Closes: https://lore.kernel.org/linux-integrity/6964bec7-3dbb-453b-89ef-9b990217a8b9@gmx.net/
> > Fixes: 1a339b658d9d ("tpm_tis_spi: Pass the SPI IRQ down to the driver")
> > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> > ---
> > Linus' change only unmasked a pre-existing bug but it is the change
> > realizes it in tpm_tis_spi.
> 
> Took me a while to understand this but looks right to me!
> Reviewed-by: Linus Walleij <linusw@kernel.org>

Thank you.

> 
> Yours,
> Linus Walleij

BR, Jarkko

