Return-Path: <linux-integrity+bounces-9699-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6FFiLBAaGmo+1ggAu9opvQ
	(envelope-from <linux-integrity+bounces-9699-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Sat, 30 May 2026 00:58:24 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B68A56098C0
	for <lists+linux-integrity@lfdr.de>; Sat, 30 May 2026 00:58:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 459503006D51
	for <lists+linux-integrity@lfdr.de>; Fri, 29 May 2026 22:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30A593A960E;
	Fri, 29 May 2026 22:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LFk11Xjf"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A95B388E57;
	Fri, 29 May 2026 22:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780095499; cv=none; b=hQlTYm6QBJ7V4OZTwqau2CHIc64OvrYR5n/jaR0zw1BGJTOLWn7l4i4qXzBzkDEyQXKoL8WFUW4WdUVAmTyJGMeBjD9uBxc1tHw/3FYTVMNzqvcvQWhkqnELiAXXkPdd515wMfYIBX4RaqbYhg51wGw9Dd0qxabLzqKFC2gqfIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780095499; c=relaxed/simple;
	bh=iB2J0Xw06SbRbqeVKBvOPV58wq7Y0aJ4Xc2pQbFDnQA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xf+CYuhhrI6Fcbup4n4DGi2qeJt+QyeiD0tSx+jo+JyH1tXyryRlq1IzrsfsPQ+9hFT2PLtJIZUQwnQ8TLANn9uu7g9895pUI53BwOuIxnt6zmICurB3p0Lcb8U4R75QKjfp+eHVwc+b3hrXdbFNHNQTjQWv9bImB6c/RtB2c9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LFk11Xjf; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 26A571F00893;
	Fri, 29 May 2026 22:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780095497;
	bh=RfkcGE+0Mf3pRR6tQSy/GD20xnQzROMosDod7FLBMqI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LFk11XjfEgexSwEroSILlhNI7+nfg+AULv5pNgAIHHOOyVZIe+X11uKhdWBF1APyP
	 hxhHj+6d7XUpUyzfcpkM+5nwEdVMn82fFn3CV7mfz+1OxFj9rTLQwH8cbjiTgbqvie
	 DQYbyLc7wQB0H+Jmdg+tsJOVJlTFUDxwgLk8yq8ZrjZsBTFnUioRFoWQTGSxjmUpgY
	 Kc8abjjIvj1WgYiEYlwtV/RkfwqdfJy4Vgm/sxknqIMw6GORJuc9IGocgK/7v0BB3j
	 K+3oIWwAo21gymmpfAR/sTp5DHLc4C4SITtq5YOfkW7z4a0KsYUFQVwgX+z52LBRxx
	 KwauKm/9hIW7A==
Date: Sat, 30 May 2026 01:58:14 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
	noodles@fb.com, James.Bottomley@hansenpartnership.com,
	kernel-team@meta.com
Subject: Re: [PATCH] tpm: cap tpm_buf_append() at TPM_BUFSIZE, not PAGE_SIZE
Message-ID: <ahoaBv3XrvKqh1dy@kernel.org>
References: <20260524-tpm-v1-1-2420a5977da6@debian.org>
 <ahOItgfj4k-NLAPa@kernel.org>
 <ahXijb7wF6BKrT9d@gmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ahXijb7wF6BKrT9d@gmail.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmx.de,ziepe.ca,vger.kernel.org,fb.com,hansenpartnership.com,meta.com];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-9699-lists,linux-integrity=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jarkko@kernel.org,linux-integrity@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: B68A56098C0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 26, 2026 at 07:20:31PM +0100, Breno Leitao wrote:
> Hello Jarkko,
> 
> On Mon, May 25, 2026 at 02:24:38AM +0000, Jarkko Sakkinen wrote:
> > On Sun, May 24, 2026 at 10:01:17AM -0400, Breno Leitao wrote:
> > > tpm_buf_append() guards against overflow of the underlying buffer by
> > > comparing the running length against PAGE_SIZE. Every other site in the
> > > TPM core uses TPM_BUFSIZE (4096) as the protocol-level cap on TPM
> > > command and response sizes.
> > > 
> > > On 4K-page kernels PAGE_SIZE == TPM_BUFSIZE, so the two caps coincide
> > > and the inconsistency is invisible. On kernels with a larger base page
> > > size, e.g. CONFIG_ARM64_64K_PAGES=y or 16K pages, PAGE_SIZE exceeds
> > > TPM_BUFSIZE.
> > > 
> > > This is a latent bug rather than user-visible bug, given most of the
> > > cases PAGE_SIZE = 4096. The mismatch is still worth fixing because
> > > future callers (e.g. the proposed TPM_BUFSIZE increase to 8 KiB, and the
> > > Secure Launch tpm_buf rework) rely on the overflow flag being
> > > authoritative.
> > > 
> > > Use TPM_BUFSIZE instead of PAGE_SIZE so the append-time check
> > > matches the transmit-time cap on every page size.
> > > 
> > > Signed-off-by: Breno Leitao <leitao@debian.org>
> > > Fixes: a74f8b36352e ("tpm: introduce tpm_buf")
> > > ---
> > 
> > There is no bug w/o a sympton of some sort. Not sure what the problem is here.
> 
> Sorry, there is no current problem in here, but there is inconsistency.
> 
> There isn't a real problem today, just an inconsistency and what I
> called a latent bug, let me justify myself.
> 
> Everywhere else in the TPM core uses TPM_BUFSIZE as the protocol cap,
> but this particular site uses PAGE_SIZE instead. Since PAGE_SIZE >=
> TPM_BUFSIZE, it doesn't cause any issue at the moment.
> 
> That said, I still think the change is worthwhile for two reasons:
> 
> 1. Consistency with the rest of the TPM core.
> 2. Decoupling TPM_BUFSIZE from PAGE_SIZE, so that if TPM_BUFSIZE ever
>    grows beyond PAGE_SIZE[1], this code won't silently break. That's what I
>    was referring to as a "latent bug" — though admittedly that phrasing
>    was probably too strong.
> 
> Link: https://lore.kernel.org/all/20260518151724.730443-6-armenon@redhat.com/ [1]

IMHO, if that is required for buffer chunking patch set, Arun
should pick it up a precursory patch but as far as mainline is
concerned right now, it is not broken.

I'm somewhat resistant to any pure cleanup patches given how
things are right now in the world, *unless* they are part of
some relevant patch set as precursory patches.

> 
> Thanks for the review,
> --breno
> 
> 
> 

BR, Jarkko

