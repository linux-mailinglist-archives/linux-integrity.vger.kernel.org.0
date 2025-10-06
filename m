Return-Path: <linux-integrity+bounces-7380-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D2805BBE0AA
	for <lists+linux-integrity@lfdr.de>; Mon, 06 Oct 2025 14:34:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0F0704E7E55
	for <lists+linux-integrity@lfdr.de>; Mon,  6 Oct 2025 12:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73A1527F19F;
	Mon,  6 Oct 2025 12:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R68ShRWG"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4637827F19B;
	Mon,  6 Oct 2025 12:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759754041; cv=none; b=Uo7bR4F4e8KuJqOZSaP2v2N8Lb8XTrBsxej3ObE6R8BdASP1WSnmifY138ASGcL+934GVypDPLWvzs3qiuNVInCtyCICafVz9JxVcq898zYeYnNCwOHShe0F+dcMdrHD+JCFSid70BkUY6uYGl+KbUjH2pIskHyzipEDr6mwm4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759754041; c=relaxed/simple;
	bh=8VmwHQcM7eKSObwCmeLkPF9BGD08kWjJhvO+reIghP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KIJ68WM4GeyhZH9ep2qf99PMZukfxs1CHbQMvmQuZF2I/HzLi1BPNh6fu5InFtafaSl7rZ5I9KkknIf+ZgQ8FkvlHG5mrFWYJtuVNGoaQS5LtMm3UzNpXA/KvkJGINTec/5TsZGa1b+qPlp9hHRxJVfaQXe9ooCpP7AfTIy5008=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R68ShRWG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E1F2C4CEF5;
	Mon,  6 Oct 2025 12:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759754039;
	bh=8VmwHQcM7eKSObwCmeLkPF9BGD08kWjJhvO+reIghP8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R68ShRWGRLtcHqRnjUkjdkUuTgNdiOq9QZFckK/Q0EX+tST1ZM+ew1hflsio103zA
	 MGvoTgNGeukynFx7w9b7DBOz+vlDfjSCB0s7hQx8sIyr39LBW4oKMfqd8Bk+1Qjd1l
	 TXL1cmPcOQzpicV1KI8vAs12ixcKUIyFVa8WhUG+CSps9DoyK9APbsLGyMpLrVnLBe
	 JhE7/6MIalhbfWOHsK2nmvGURi1lWGh2YFXen4dtpG7gYZjyVorZrl+iEBiwinXhfR
	 3yueVN5IrQXkPT0J0In/OOFjTmUt4FTg/hHG7nfoPCOEWNZRDHjNyLGk/1fv4mF+AA
	 wQ5rlgXF7LiXA==
Date: Mon, 6 Oct 2025 15:33:56 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jonathan McDowell <noodles@meta.com>
Subject: Re: [GIT PULL] TPM DEVICE DRIVER: tpmdd-next-v6.18
Message-ID: <aOO3NKegSrUQ4ewg@kernel.org>
References: <aOKTFv1vh1cvvcLk@kernel.org>
 <CAHk-=whSe9AGigVydkwo=ewE6_GFTJ_rU=XzO=v1N1sWyfVmAw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whSe9AGigVydkwo=ewE6_GFTJ_rU=XzO=v1N1sWyfVmAw@mail.gmail.com>

On Sun, Oct 05, 2025 at 11:24:09AM -0700, Linus Torvalds wrote:
> On Sun, 5 Oct 2025 at 08:47, Jarkko Sakkinen <jarkko@kernel.org> wrote:
> >
> > and apologies for this late pull request. This pull request disables
> > TCG_TPM2_HMAC from the default configuration as it does not perform well
> > enough
> 
> So having looked more at this, not only does it disable that
> TCG_TPM2_HMAC, it does a lot of other things too.
> 
> I really am going to require a better pull request, and I have thrown
> this one away.

What I think I think it is good call.

> 
> The exclusive access looks debatable to me too. I think you should
> also require that the open was done not only with O_EXCL, but as a
> write too.
> 
> Exclusive reads do not make sense.

True, I agree with this.

After reading this email I realized also another issue with these patch
when I tested them sequentially building a VM for each commit ID.

Without "tpm: Require O_EXCL for exclusive /dev/tpm access" applied,
there's a regression: usually a daemon of some sort opens /dev/tpm0:

COMMAND      PID USER   FD   TYPE DEVICE SIZE/OFF NODE NAME
tpm2-abrm 771444  tss    5u   CHR 10,224      0t0   94 /dev/tpm0

Without top patch this leaves /dev/tpmrm0 unusuable, which is a huge
developer experience downgrade as it is nice and covenient device
to try and do things. I.e. tail patch needs to be squashed and
the whole patch set needs to be re-reviewed.

I don't know systemd source code too well, but after eading
documentation of systemd-cryptenroll, it can also use /dev/tpmrm0:

https://www.freedesktop.org/software/systemd/man/latest/systemd-cryptenroll.html

Based on this it's now like there's a breaking patch and the top
most patch fixes the bug.

And based on this I'm happy to postpone O_EXCL changes to 6.19.
Patch set just needs to be restructured better so that in-the
middle of the series patches don't break things. And also it'd
be better if this patch would be relocated as the first in the
series: "tpm: Remove tpm_find_get_ops".


> 
> Now, I certainly *hope* that nobody has /dev/tmp being world-readable,
> so it probably doesn't matter, but that new exclusive access thing is
> very different than what the code used to do, and if I read it
> correctly it will also disable the kernel doing certain operations. So
> it needs to be as limited as possible.

Not disagreeing with this.

> 
> And damn it, it needs to be *explained*. Not have a pull request where
> one single line is explained badly.

'll send tomorrow a new PR without O_EXCL patches.

As per hmac encryption, I think my decision was the right call
but cover letter did suck agreed (sorry about that).

> 
>              Linus

BR, Jarkko

