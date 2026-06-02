Return-Path: <linux-integrity+bounces-9720-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mP0QLN06HmpriAkAu9opvQ
	(envelope-from <linux-integrity+bounces-9720-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 02 Jun 2026 04:07:25 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 13684627118
	for <lists+linux-integrity@lfdr.de>; Tue, 02 Jun 2026 04:07:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1D7DC30142AE
	for <lists+linux-integrity@lfdr.de>; Tue,  2 Jun 2026 02:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C6EA33A03F;
	Tue,  2 Jun 2026 02:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TTEiA+7l"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270AA2EAB82;
	Tue,  2 Jun 2026 02:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780365823; cv=none; b=OVDGOa0to6kiz9oXr1rX2oO9PICktyTYXN8OorCqrl5Nj4U5mcG2oEFwgmBCRpbYP8Kjz20q46fDHcXdA7dAyOvLgFbZDvMWboe9RojE+D5q28T4eC/5Tf18C7ClUTKwj+zhqMlipiUge9FgVdYqhY4dCh6ToJ9DY71tV5Lmgqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780365823; c=relaxed/simple;
	bh=dMmlCn65TA1zVd1GN1lw3C9Y5Jvs9Ky7UCvaBOIskB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HfC7AI7h388d6nyB5T8G4wWiKqit8NyraPWSqiZ9bmiYYorvSKAFnjKokEO+m49oklt/GZCXtiS1Oy2kkQPR9VIVeqYiRNMPIBUGH+KB197vbEBudcW63mp+3vs1WTtwXUDOoaX8HDdcrayuuaDD69AeX9EYwFnZKok4plfl6Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TTEiA+7l; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 448301F00893;
	Tue,  2 Jun 2026 02:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780365821;
	bh=vtysWeLzV+d3axowtSku1QYY2ccFIJO9YShwjRjZ59w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TTEiA+7lxlsRWQ5P4Ya7yjnQpp0fc0t/FEBHVp0w8y8wsK1X89TDS33onCqkvT1vk
	 CUxgGMXjf5ZnTQHAsLXfuSqMlTcilR1/gIIvUxLTNeaID9EvkDZQJfxQQLaaYETb8l
	 6bAYDM9fFWrAzAW2EmRVOToad7Vi5yaFRq+QW30rrh29c9QZuoP5JTYwGAHyEe+Md8
	 i8S/EEfQAcUETj9MntNNSM35iRrLeTpgmNvZKBV2Y3Je0hd8hnXDeadMc1SpYUR4q+
	 8yL6VOWtGZeZt+T+PcNO7R079WA+er+NDmkYN0QVJzXQMeVGsZVxpU2nQw9GLl2oUs
	 J+T/sCv1Nov9g==
Date: Tue, 2 Jun 2026 05:03:38 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
	noodles@fb.com, James.Bottomley@hansenpartnership.com,
	kernel-team@meta.com
Subject: Re: [PATCH] tpm: cap tpm_buf_append() at TPM_BUFSIZE, not PAGE_SIZE
Message-ID: <ah45-nwb_EMSf5JY@kernel.org>
References: <20260524-tpm-v1-1-2420a5977da6@debian.org>
 <ahOItgfj4k-NLAPa@kernel.org>
 <ahXijb7wF6BKrT9d@gmail.com>
 <ahoaBv3XrvKqh1dy@kernel.org>
 <ah1iBjuoinxGi7Gj@gmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ah1iBjuoinxGi7Gj@gmail.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmx.de,ziepe.ca,vger.kernel.org,fb.com,hansenpartnership.com,meta.com];
	TAGGED_FROM(0.00)[bounces-9720-lists,linux-integrity=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jarkko@kernel.org,linux-integrity@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 13684627118
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Jun 01, 2026 at 03:42:30AM -0700, Breno Leitao wrote:
> On Sat, May 30, 2026 at 01:58:14AM +0300, Jarkko Sakkinen wrote:
> > On Tue, May 26, 2026 at 07:20:31PM +0100, Breno Leitao wrote:
> > > Hello Jarkko,
> > > 
> > > On Mon, May 25, 2026 at 02:24:38AM +0000, Jarkko Sakkinen wrote:
> > > > On Sun, May 24, 2026 at 10:01:17AM -0400, Breno Leitao wrote:
> > > > > tpm_buf_append() guards against overflow of the underlying buffer by
> > > > > comparing the running length against PAGE_SIZE. Every other site in the
> > > > > TPM core uses TPM_BUFSIZE (4096) as the protocol-level cap on TPM
> > > > > command and response sizes.
> > > > > 
> > > > > On 4K-page kernels PAGE_SIZE == TPM_BUFSIZE, so the two caps coincide
> > > > > and the inconsistency is invisible. On kernels with a larger base page
> > > > > size, e.g. CONFIG_ARM64_64K_PAGES=y or 16K pages, PAGE_SIZE exceeds
> > > > > TPM_BUFSIZE.
> > > > > 
> > > > > This is a latent bug rather than user-visible bug, given most of the
> > > > > cases PAGE_SIZE = 4096. The mismatch is still worth fixing because
> > > > > future callers (e.g. the proposed TPM_BUFSIZE increase to 8 KiB, and the
> > > > > Secure Launch tpm_buf rework) rely on the overflow flag being
> > > > > authoritative.
> > > > > 
> > > > > Use TPM_BUFSIZE instead of PAGE_SIZE so the append-time check
> > > > > matches the transmit-time cap on every page size.
> > > > > 
> > > > > Signed-off-by: Breno Leitao <leitao@debian.org>
> > > > > Fixes: a74f8b36352e ("tpm: introduce tpm_buf")
> > > > > ---
> > > > 
> > > > There is no bug w/o a sympton of some sort. Not sure what the problem is here.
> > > 
> > > Sorry, there is no current problem in here, but there is inconsistency.
> > > 
> > > There isn't a real problem today, just an inconsistency and what I
> > > called a latent bug, let me justify myself.
> > > 
> > > Everywhere else in the TPM core uses TPM_BUFSIZE as the protocol cap,
> > > but this particular site uses PAGE_SIZE instead. Since PAGE_SIZE >=
> > > TPM_BUFSIZE, it doesn't cause any issue at the moment.
> > > 
> > > That said, I still think the change is worthwhile for two reasons:
> > > 
> > > 1. Consistency with the rest of the TPM core.
> > > 2. Decoupling TPM_BUFSIZE from PAGE_SIZE, so that if TPM_BUFSIZE ever
> > >    grows beyond PAGE_SIZE[1], this code won't silently break. That's what I
> > >    was referring to as a "latent bug" — though admittedly that phrasing
> > >    was probably too strong.
> > > 
> > > Link: https://lore.kernel.org/all/20260518151724.730443-6-armenon@redhat.com/ [1]
> > 
> > IMHO, if that is required for buffer chunking patch set, Arun
> > should pick it up a precursory patch but as far as mainline is
> > concerned right now, it is not broken.
> > 
> > I'm somewhat resistant to any pure cleanup patches given how
> > things are right now in the world, *unless* they are part of
> > some relevant patch set as precursory patches.
> 
> That is fair, thanks for the heads-up!

It also depends on day and time.

E.g., right now barrier is higher because LLMs get a while to flush the
secret history random bugs. Fixes to actual functional, which preferably
can be reproduced, are of course always feasible.

> 
> --breno

BR, Jarkko

