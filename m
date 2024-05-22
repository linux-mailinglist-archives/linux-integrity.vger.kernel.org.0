Return-Path: <linux-integrity+bounces-2559-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C2EC8CC6C5
	for <lists+linux-integrity@lfdr.de>; Wed, 22 May 2024 21:19:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4383D1F22383
	for <lists+linux-integrity@lfdr.de>; Wed, 22 May 2024 19:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 275AD1422B0;
	Wed, 22 May 2024 19:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="LpghCUQi"
X-Original-To: linux-integrity@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70CB5171C4;
	Wed, 22 May 2024 19:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716405571; cv=none; b=ohCdgJbB61oY4yD1nt0qaZNkd+N7y8UhreOV8zHIGNv3Fvh62P4EXCrPzDIXmhMcmk1eJUE7tcJc5zsmN30Yrgw6qfCrsnqcWRVa2+2kJZi2fs78A/z1OSKn/tVrCPRjtBxY/q4q2H6AnmTlPsicYBwWgofjEAEquskU+KX1SQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716405571; c=relaxed/simple;
	bh=C/0YgDW6k1jbB1xPrqr/wbppkLsmgkhghaziCcwvZtw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MNTMalnHEbr/S8/wTKmvCx2YQzTJ/dcWJI26jOdVuGARLMaj0VTDlDou2RkpkdrPKNs4PytvozMmGLHBwB5P0ugtZLoMslkmx8+sZ082DMAUKpaHCZAd+9criRGhOnX9gJxWecbve8UoYjLHws7HD0MSw246eip2aYT99CuHoRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=LpghCUQi; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1716405566;
	bh=C/0YgDW6k1jbB1xPrqr/wbppkLsmgkhghaziCcwvZtw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LpghCUQih/AE8vF9yODVNkOTn18v3eTqDAygyIa3UpmbrCByg2+5dd1GjebRLeFpg
	 /fYdmaSMULdpQjnOs3f6sE9dwDqFyDfqglIMR5ehaWz93o8qVh7AmOe+Qgc3MsODfU
	 bQSEffrPS+qtZrhvthikjbNJZpCMpL3h+0vZCSYt7auJdnO1CInvL2yJb88rUYWmmW
	 F502mJIsNERn5O4pvwEBPs2IBho8MB7y4os5vnf0NkVJQZfpwrpIzPiYJR6Dfm4oZn
	 +cveVIiVPDBrb54e9DqfsG0LTVPUUfCVX7Y+IVIM6kn/tMCfZ4id0/UDZh573sSYSj
	 PpKYOSxZ0fsIQ==
Received: from notapiano (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id DAB9D378217B;
	Wed, 22 May 2024 19:19:23 +0000 (UTC)
Date: Wed, 22 May 2024 15:19:21 -0400
From: =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Eric Biggers <ebiggers@kernel.org>, Jarkko Sakkinen <jarkko@kernel.org>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
	linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
	regressions@lists.linux.dev, kernel@collabora.com,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Tejun Heo <tj@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Kees Cook <keescook@chromium.org>
Subject: Re: [v3 PATCH] hwrng: core - Remove add_early_randomness
Message-ID: <3a6fe46c-f4cc-47a3-8ef3-ac07bde14ca1@notapiano>
References: <CAMj1kXFE_R_x10BVkU+8vrMz0RHiX0+rz-ZL+w08FH2CLQHZXA@mail.gmail.com>
 <66ec985f3ee229135bf748f1b0874d5367a74d7f.camel@HansenPartnership.com>
 <dfb0d930-7cbe-46c5-be19-d132b4906ecf@notapiano>
 <D1C2NPOBHAHK.20O4IME8OK1FH@kernel.org>
 <20240518043115.GA53815@sol.localdomain>
 <ZkhS1zrobNwAuANI@gondor.apana.org.au>
 <00bcfa65-384d-46ae-ab8b-30f12487928b@notapiano>
 <ZkwMnrTR_CbXcjWe@gondor.apana.org.au>
 <07512097-8198-4a84-b166-ef9809c2913b@notapiano>
 <Zk2Eso--FVsZ5AF3@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zk2Eso--FVsZ5AF3@gondor.apana.org.au>

On Wed, May 22, 2024 at 01:37:54PM +0800, Herbert Xu wrote:
> On Tue, May 21, 2024 at 03:37:16PM -0400, Nícolas F. R. A. Prado wrote:
> >
> > FWIW this patch fixes the warning. So feel free to add
> > 
> > Tested-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> 
> Could you please test this patch instead?
> 
> ---8<---
> A potential deadlock was reported with the config file at
> 
> https://web.archive.org/web/20240522052129/https://0x0.st/XPN_.txt
> 
> In this particular configuration, the deadlock doesn't exist because
> the warning triggered at a point before modules were even available.
> However, the deadlock can be real because any module loaded would
> invoke async_synchronize_full.
> 
> The issue is spurious for software crypto algorithms which aren't
> themselves involved in async probing.  However, it would be hard to
> avoid for a PCI crypto driver using async probing.
> 
> In this particular call trace, the problem is easily avoided because
> the only reason the module is being requested during probing is the
> add_early_randomness call in the hwrng core.  This feature is
> vestigial since there is now a kernel thread dedicated to doing
> exactly this.
> 
> So remove add_early_randomness as it is no longer needed.
> 
> Reported-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> Reported-by: Eric Biggers <ebiggers@kernel.org>
> Fixes: 1b6d7f9eb150 ("tpm: add session encryption protection to tpm2_get_random()")
> Link: https://lore.kernel.org/r/119dc5ed-f159-41be-9dda-1a056f29888d@notapiano/
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

This patch also fixes the warning.

Tested-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Thanks,
Nícolas

