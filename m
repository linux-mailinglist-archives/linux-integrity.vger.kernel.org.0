Return-Path: <linux-integrity+bounces-9576-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uHy5ICCiB2rP/QIAu9opvQ
	(envelope-from <linux-integrity+bounces-9576-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Sat, 16 May 2026 00:45:52 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DA91655904F
	for <lists+linux-integrity@lfdr.de>; Sat, 16 May 2026 00:45:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0B7E1301C8A5
	for <lists+linux-integrity@lfdr.de>; Fri, 15 May 2026 22:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3C2D3F5BCD;
	Fri, 15 May 2026 22:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qeRGSwgS"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0FDE269D18;
	Fri, 15 May 2026 22:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778884855; cv=none; b=twNJweHQ2iRWhRisec0of5hc8xcwYVNCtiRKjyn7u6gsTh2fZMa2W01ls9k073M1Ex+VHEa+JT2gWk72iHtk+AhIDxM5/u9HvLQw/S6R29gOE+dfA/jljMoNZHBYpyxm1XKcYjs6xK4y2sUitg9c1Pz6klBb5qmd78TMrVoxPLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778884855; c=relaxed/simple;
	bh=oKW8SVtlRlDC6HKqECroaZVGw6PlF1g6ITx07c0USDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o714buVWUplWVGLLJ+UdQIxyBOuV2gcH0Qx1A2yU+B9drd+Y+zVYhuf9taRMB242bmFBSHofGJIRUfw86prnQE21uPhVaauDUIAekAZRDz1z4syhwb+mmIY1rZ9a5E+O6jFvM2wgIp6EFcx67G7sMS2VHTqzjxsmPGD4pMTVobE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qeRGSwgS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8445C2BCB7;
	Fri, 15 May 2026 22:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778884855;
	bh=oKW8SVtlRlDC6HKqECroaZVGw6PlF1g6ITx07c0USDQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qeRGSwgSLJ7+OHBaNKWIznnZj2qQ5ZT09ycG5cMR23yjm3gP0nOmKf4umli5pnOqL
	 mtmhBUuPSoynD1C+VOA0zWzxN8hkThItnnchJdPtK2Y7hg01osd6bDkBPYnpb8H3Lc
	 zco9NqeLALs8QjkSrCrXL9QDXJyNrfZMQSAOpVuCf0QzS2KmC2i7zYKaGyao1fw3NN
	 BPtPqpEN15cBD8R94WDVNNqdqZ6E8kE9uaGYjVi+vtzdhqkOFbWgtAZp+Agke4kTv5
	 OyEmlnstSr5daZnpgfa36sxFWApl6UuvVfU2FOrdOP09ab7TYfmvQLuzUTko+X/VO9
	 rTGEGhLqocV7g==
Date: Sat, 16 May 2026 01:40:51 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Stefan Wahren <wahrenst@gmx.net>
Cc: linux-integrity@vger.kernel.org, stable@vger.kernel.org,
	Linus Walleij <linusw@kernel.org>, Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm: tpm_tis_spi: Use wait_woken() in wait_for_tmp_stat()
Message-ID: <ageg87skNHEzLFlU@kernel.org>
References: <20260509185108.2681198-1-jarkko@kernel.org>
 <033c013e-8b32-4459-9dc9-255232d1d2d7@gmx.net>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <033c013e-8b32-4459-9dc9-255232d1d2d7@gmx.net>
X-Rspamd-Queue-Id: DA91655904F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,gmx.de,ziepe.ca];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9576-lists,linux-integrity=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_TO(0.00)[gmx.net];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jarkko@kernel.org,linux-integrity@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Sun, May 10, 2026 at 10:45:52PM +0200, Stefan Wahren wrote:
> Am 09.05.26 um 20:51 schrieb Jarkko Sakkinen:
> > wait_event_interruptible_timeout() evaluates its condition after setting
> > the current task state to TASK_INTERRUPTIBLE.
> > 
> > With CONFIG_DEBUG_ATOMIC_SLEEP this triggers a warning when the IRQ wait
> > path is used:
> > 
> >      tpm_tis_status()
> >        tpm_tis_spi_read_bytes()
> >          tpm_tis_spi_transfer_full()
> >            spi_bus_lock()
> >              mutex_lock()
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
> > 
> The issue isn't reproducible anymore. Thanks
> 
> Tested-by: Stefan Wahren <wahrenst@gmx.net>

Thank you.

BR, Jarkko

