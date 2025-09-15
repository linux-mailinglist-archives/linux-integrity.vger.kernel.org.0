Return-Path: <linux-integrity+bounces-7086-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70797B58454
	for <lists+linux-integrity@lfdr.de>; Mon, 15 Sep 2025 20:16:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F12D01AA11A7
	for <lists+linux-integrity@lfdr.de>; Mon, 15 Sep 2025 18:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0348F21FF26;
	Mon, 15 Sep 2025 18:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rNMDsYc+"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46551E51EC;
	Mon, 15 Sep 2025 18:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757960193; cv=none; b=o+IO2yRI58K/hySnq9N1jKa8I3Gd1NGhu6eOaPSkpqAJW7LeYHgEryYY56qFAJcj0esBHXMTe5JjrPb4mGwGKxQdPcc5otLEVS7MN4R83p2pVzc/GJ68RX5Wd/BXVSr5P1M7MbliPApnxylBmaTH4CfZzWC37M6K/ilqDiHdt74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757960193; c=relaxed/simple;
	bh=VRl/CmbCbalaTrdIPZ+G9ZHaZWrzBwmSCJ6/X7SgXR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ckjx1j2jdkrN4W7RevG5eoxAh1Xpz0Fs/tRMLSa8fbycO5n7y+h4s6C7hv5fdFkb7Go/sjjN6/AH0Pabq4EZCmrQcqUuJFA9mOq+z5A1aalXMmEaXfu0F854ZH7ZQiRHJvVR/Tzv48TrBoCeNS8NnQZbGTmgr0pVqFwhdqtvqdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rNMDsYc+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACA67C4CEFA;
	Mon, 15 Sep 2025 18:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757960192;
	bh=VRl/CmbCbalaTrdIPZ+G9ZHaZWrzBwmSCJ6/X7SgXR0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rNMDsYc+iKHhlj2InEo4fd0/M7jJoU622P5ezNFnbm3Coc0uo/KQv34ZPvZijuVmh
	 2NlTA56OOYUL7Nd1INCycFBCxHxuWBdeFVtnwl4vJndc+EX/Rta3WNLFQ7SbODXMH1
	 9N0vtoLlatlhCuhAgiWXt9YKwQEaoBT8XUkrXadYzr2qo+iNz9A1zFNb3xgPHCiKqb
	 jSMjQamQLmHdJvCMz8eYUwu4dWuzAROkLofxbbGIKLd6QnTs4s6gr5TFgV6FZconXr
	 oXvlYXBEJ+/lWIfOb7etJolSQapmh2ydXnX2Pzany/WDBC1WlEI5gJLxDqRguvnYJ0
	 OG7nZhczPdpow==
Date: Mon, 15 Sep 2025 21:16:27 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Mimi Zohar <zohar@linux.ibm.com>, keyrings@vger.kernel.org,
	David Howells <dhowells@redhat.com>,
	linux-integrity@vger.kernel.org, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KEYS: encrypted: Use SHA-256 library instead of
 crypto_shash
Message-ID: <aMhX-6jTkaLo-HsG@kernel.org>
References: <20250731184747.12335-1-ebiggers@kernel.org>
 <aJIKH3-fRizRV8fi@kernel.org>
 <e8fff5a1607ce2d98c5999d522202e1104f0a12d.camel@linux.ibm.com>
 <20250915163949.GF1993@quark>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915163949.GF1993@quark>

On Mon, Sep 15, 2025 at 11:39:49AM -0500, Eric Biggers wrote:
> On Sun, Sep 07, 2025 at 07:57:12AM -0400, Mimi Zohar wrote:
> > On Tue, 2025-08-05 at 16:41 +0300, Jarkko Sakkinen wrote:
> > > On Thu, Jul 31, 2025 at 11:47:47AM -0700, Eric Biggers wrote:
> > > > Instead of the "sha256" crypto_shash, just use sha256().  Similarly,
> > > > instead of the "hmac(sha256)" crypto_shash, just use
> > > > hmac_sha256_usingrawkey().  This is simpler and faster.
> > > > 
> > > > Signed-off-by: Eric Biggers <ebiggers@kernel.org>
> > > 
> > > Yeah, fully agree.
> > > 
> > > Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> > > 
> > > David, will you pick this?
> > > 
> > 
> > Do you want this patch being upstreamed with "[PATCH 0/2] Convert lib/digsig.c
> > to SHA-1 library" patch set?
> > 
> > thanks,
> > 
> > Mimi
> 
> If someone could apply this for v6.18, that would be great.  It's
> independent of my other patches.  It looks like Mimi has been taking
> changes to this file most recently.  If David or Jarkko wants to take it
> instead, that's fine too.  As long as someone does it.

I did it and I'm sorry that I didn't do this earlier!

df8f189a0d3e (HEAD -> next, origin/next) KEYS: encrypted: Use SHA-256 library instead of crypto_shash
72f6cd8ad0db (origin/master, origin/HEAD, master) tpm: Use HMAC-SHA256 library instead of open-coded HMAC

Somehow my head did ticks after applying patch below and thought that
everything is ok :-) I actually had plan to apply this one too but now
it is there ready for PR.

> 
> - Eric

BR, Jarkko

