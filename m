Return-Path: <linux-integrity+bounces-9707-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IHAjFXdkHWqwaAkAu9opvQ
	(envelope-from <linux-integrity+bounces-9707-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Mon, 01 Jun 2026 12:52:39 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CDE9161DE84
	for <lists+linux-integrity@lfdr.de>; Mon, 01 Jun 2026 12:52:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A321C300A8D2
	for <lists+linux-integrity@lfdr.de>; Mon,  1 Jun 2026 10:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A42C0395273;
	Mon,  1 Jun 2026 10:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="npQg5wl3"
X-Original-To: linux-integrity@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD2D39A7FE;
	Mon,  1 Jun 2026 10:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780310565; cv=none; b=J7EDJfsxpMPHl+xEvT9n+NKw5KuKMlXIHhbyG4YleoJzTjSiUERoB1XnkADkGbG2rmAF95PhIPjurBWjjYGG4udnMVo5iCNHb+J3kRlRoue2DbHAgoSZGYUxvqVkQ2D+KxBv/oedc6Txx0baE6ZLGmJ6MbrXtC64qTqDvI9w6rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780310565; c=relaxed/simple;
	bh=BzPoBDq85kONcQEf2VaTvDHmK57q23PeMeJagIpZobg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ufHgCd10phbLn71o0hL+YpuU6wdj1glestSxJQRpLfi55+5fSD5bXLhcHnxvJ4IsYQb8YzBP9BKngBXK62QopXaupwWXznJDZm0rvYlZplw+CYE5DmcO1Wc/ji6C6TW4ZEewK2ui0JoGtM8lp2KjtwkVJXB0JrtGqV7USi79Ebo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=npQg5wl3; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Reply-To:Content-ID:Content-Description;
	bh=jw+0QfqJ2c4u5LKDBSXDfHJXQWIS0ls5rgStUs2LxpU=; b=npQg5wl3CGmmMzztFfgZ0e4kyi
	+uAtCF2sLyFVvWaLuZOM28GjjydQVsq9q1/SMGsoAp2Cf7EmdiZBX9muQgCOTSIi2k9E+BZFH/JAw
	jZoHzh56BJQEjLWQG86vIYdkPxiuIFnW6mR/h4/MGEF2vWaGgf1mZG21uKIaShQUFyeXmA5mJR2fK
	1AfC7azAvCOYQu2zX3+Ymnkcwx4KIR3dsg6nfm1S3fN1IW04lFAwY/OQI3hdeUqi81XthtLaKToZe
	JbVVmrvCUEFGm22NocoVfO1qMlXZ0TMpXCNw5wWxQJFOVTS3bKUmrOdCUq5VRhlwwxrC6pgHdY2CM
	au8U+JQA==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wU06M-0027Qe-2B;
	Mon, 01 Jun 2026 10:42:35 +0000
Date: Mon, 1 Jun 2026 03:42:30 -0700
From: Breno Leitao <leitao@debian.org>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, 
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, noodles@fb.com, 
	James.Bottomley@hansenpartnership.com, kernel-team@meta.com
Subject: Re: [PATCH] tpm: cap tpm_buf_append() at TPM_BUFSIZE, not PAGE_SIZE
Message-ID: <ah1iBjuoinxGi7Gj@gmail.com>
References: <20260524-tpm-v1-1-2420a5977da6@debian.org>
 <ahOItgfj4k-NLAPa@kernel.org>
 <ahXijb7wF6BKrT9d@gmail.com>
 <ahoaBv3XrvKqh1dy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ahoaBv3XrvKqh1dy@kernel.org>
X-Debian-User: leitao
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9707-lists,linux-integrity=lfdr.de];
	FREEMAIL_CC(0.00)[gmx.de,ziepe.ca,vger.kernel.org,fb.com,hansenpartnership.com,meta.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[debian.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,linux-integrity@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: CDE9161DE84
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, May 30, 2026 at 01:58:14AM +0300, Jarkko Sakkinen wrote:
> On Tue, May 26, 2026 at 07:20:31PM +0100, Breno Leitao wrote:
> > Hello Jarkko,
> > 
> > On Mon, May 25, 2026 at 02:24:38AM +0000, Jarkko Sakkinen wrote:
> > > On Sun, May 24, 2026 at 10:01:17AM -0400, Breno Leitao wrote:
> > > > tpm_buf_append() guards against overflow of the underlying buffer by
> > > > comparing the running length against PAGE_SIZE. Every other site in the
> > > > TPM core uses TPM_BUFSIZE (4096) as the protocol-level cap on TPM
> > > > command and response sizes.
> > > > 
> > > > On 4K-page kernels PAGE_SIZE == TPM_BUFSIZE, so the two caps coincide
> > > > and the inconsistency is invisible. On kernels with a larger base page
> > > > size, e.g. CONFIG_ARM64_64K_PAGES=y or 16K pages, PAGE_SIZE exceeds
> > > > TPM_BUFSIZE.
> > > > 
> > > > This is a latent bug rather than user-visible bug, given most of the
> > > > cases PAGE_SIZE = 4096. The mismatch is still worth fixing because
> > > > future callers (e.g. the proposed TPM_BUFSIZE increase to 8 KiB, and the
> > > > Secure Launch tpm_buf rework) rely on the overflow flag being
> > > > authoritative.
> > > > 
> > > > Use TPM_BUFSIZE instead of PAGE_SIZE so the append-time check
> > > > matches the transmit-time cap on every page size.
> > > > 
> > > > Signed-off-by: Breno Leitao <leitao@debian.org>
> > > > Fixes: a74f8b36352e ("tpm: introduce tpm_buf")
> > > > ---
> > > 
> > > There is no bug w/o a sympton of some sort. Not sure what the problem is here.
> > 
> > Sorry, there is no current problem in here, but there is inconsistency.
> > 
> > There isn't a real problem today, just an inconsistency and what I
> > called a latent bug, let me justify myself.
> > 
> > Everywhere else in the TPM core uses TPM_BUFSIZE as the protocol cap,
> > but this particular site uses PAGE_SIZE instead. Since PAGE_SIZE >=
> > TPM_BUFSIZE, it doesn't cause any issue at the moment.
> > 
> > That said, I still think the change is worthwhile for two reasons:
> > 
> > 1. Consistency with the rest of the TPM core.
> > 2. Decoupling TPM_BUFSIZE from PAGE_SIZE, so that if TPM_BUFSIZE ever
> >    grows beyond PAGE_SIZE[1], this code won't silently break. That's what I
> >    was referring to as a "latent bug" — though admittedly that phrasing
> >    was probably too strong.
> > 
> > Link: https://lore.kernel.org/all/20260518151724.730443-6-armenon@redhat.com/ [1]
> 
> IMHO, if that is required for buffer chunking patch set, Arun
> should pick it up a precursory patch but as far as mainline is
> concerned right now, it is not broken.
> 
> I'm somewhat resistant to any pure cleanup patches given how
> things are right now in the world, *unless* they are part of
> some relevant patch set as precursory patches.

That is fair, thanks for the heads-up!

--breno

