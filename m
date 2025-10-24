Return-Path: <linux-integrity+bounces-7525-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72C6FC07D35
	for <lists+linux-integrity@lfdr.de>; Fri, 24 Oct 2025 20:55:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 313753BD5B1
	for <lists+linux-integrity@lfdr.de>; Fri, 24 Oct 2025 18:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3341D34BA28;
	Fri, 24 Oct 2025 18:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PwipBgnB"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B57432C326;
	Fri, 24 Oct 2025 18:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761332155; cv=none; b=riZRuQM+Lo9oWUXbSnZ50cfyll4SYZ/eGGouopjdXnq+lf9NOOXvvxPJQi1jlGN+3IhzIScHh2l2ydk9fK1qkNUeYXP2dkJqCYBAd5WkbBPWR+VTG5POT3EGswSpYoTdozGVD/vQkRTsn8AWMCuLAgtYeew/fo0EG6XtB15nNKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761332155; c=relaxed/simple;
	bh=famBaXMKjGMjTdpCralBLaTsc6lnULzc0/kuaQo7X/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f+e5s8y7gRTdom190FmNPeXT+0/E4kbklogL0hJ45zxKj5i01aF9KyD2PPu0NtD6vzX13Taej23lXBCxYPrHxNOugJV9i5J62yJ3hiW7Y562cxAQNfZ6D6ttLEGAlO0RVhcVQiC6Q4GkjiOwL27wdon5cdZqjB7bgfxvOuLGuoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PwipBgnB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C863C4CEF1;
	Fri, 24 Oct 2025 18:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761332154;
	bh=famBaXMKjGMjTdpCralBLaTsc6lnULzc0/kuaQo7X/I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PwipBgnBlD/BRRpJFMHjANsn9yEE5ny9iJmLOKR4+ixQiJbNQCA3NkQcedn5bD1Q1
	 5W1+kI82nzvUI0K1kTofVR+9gNSsfASrKzs4N/ciqSyDPyAg7fyM5wlc3OYMCWsYaO
	 9Wf/JRPwN36/4bOzn9pCA4QJ9lSTFl+n2mzg7t2CXUzld7yjsmH+22qyGDHFJlyXJ9
	 K8wso4yQh1rHd0UFp11SwVT9uBaSYGDj+y2+Jv6HXXOgRuExE5p/gfeNbH7/oQX0vh
	 drYnvhGS4M4t6eOd4gwC8zH59sJ68E0qVHn/+TTV0gSVPfMgaUf9QcqhFvJJ3ynbrh
	 vS/ksEQ2Ix3bg==
Date: Fri, 24 Oct 2025 21:55:50 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Jonathan McDowell <noodles@earth.li>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/4] pm: Ensure exclusive userspace access when using
 /dev/tpm<n>
Message-ID: <aPvLtt7a7X0Y1LBI@kernel.org>
References: <cover.1758646791.git.noodles@meta.com>
 <cover.1760958898.git.noodles@meta.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1760958898.git.noodles@meta.com>

On Mon, Oct 20, 2025 at 12:30:32PM +0100, Jonathan McDowell wrote:
> I hit a problem where ~ 1% of TPM firmware upgrades were failing.
> Investigating revealed the issue was that although the upgrade tool uses
> /dev/tpm0 this does not actually prevent access via /dev/tpmrm0, nor
> internal kernel users. It *does* prevent access to others via /dev/tpm0
> 
> So the upgrade process started, the HW RNG came in to get some
> randomness in the middle, did the HMAC context dance, and confused
> everything to the point the TPM was no longer visible to the OS even
> after a reboot.
> 
> Thankfully I've been able to recover those devices, but really what I'd
> like is the ability for a userspace tool to exclusively access the TPM
> without something coming in behind it. Given the lightweight attempt at
> locking that already exists I think this was the original intention.
> 
> I've reworked this series based on feedback received.
> 
> Firstly, it's been reordered TPM sharing functionality doesn't break
> during bisection.
> 
> Secondly, the O_EXCL check has been tightend up to ensure the caller is
> also opening the device O_RDWR. Callers shouldn't really be opening the
> TPM except for reading + writing, but this should help guard against
> unexpected flags usage a bit more.
> 
> Finally, this revision keeps the prohibition on more than one user of
> /dev/tpm#, to avoid unexpected breakages for clients that expect this to
> guard against multiple invocations. A client only then needs to use
> O_EXCL if it wants to prevent *all* other access, even with
> ContextSaves, such as the firmware upgrade case.
> 
> (I've sent a separate standalone patch that allows the TPM HW RNG to be
> disabled at run time, and it's now in -next, but even with that I think
> something like this is a good idea as well.)
> 
> Jonathan McDowell (4):
>   tpm: Remove tpm_find_get_ops
>   tpm: Add O_EXCL for exclusive /dev/tpm access
>   tpm: Include /dev/tpmrm<n> when checking exclusive userspace TPM
>     access
>   tpm: Allow for exclusive TPM access when using /dev/tpm<n>
> 
>  drivers/char/tpm/tpm-chip.c       | 90 +++++++++++++++----------------
>  drivers/char/tpm/tpm-dev-common.c |  8 +--
>  drivers/char/tpm/tpm-dev.c        | 35 ++++++++++--
>  drivers/char/tpm/tpm-dev.h        |  1 +
>  drivers/char/tpm/tpm-interface.c  | 20 +++++--
>  drivers/char/tpm/tpm.h            |  3 +-
>  drivers/char/tpm/tpm2-space.c     |  5 +-
>  drivers/char/tpm/tpm_tis_core.c   |  3 +-
>  drivers/char/tpm/tpmrm-dev.c      | 20 ++++++-
>  include/linux/tpm.h               |  4 +-
>  10 files changed, 124 insertions(+), 65 deletions(-)
> 
> -- 
> 2.51.0
> 

I will put to queue with my tags but I just want to make first sure that we do not
break anything.

I'll upgrade my test suite first to have TPM 1.2 tests (which is also
needed for my own series) and run it in bunch of configurations.  And on
TPM2 I check the behavior with TSS2 daemon on / off.

I have no doubts on the code changes, and it is most importantly a
security improvement, given that "who has the access and how long" 
can be deduced for a system configuration. I just feel that with
this code change it is better to check and verify everything :-)

BR, Jarkko

