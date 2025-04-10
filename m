Return-Path: <linux-integrity+bounces-5777-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D3238A84A1D
	for <lists+linux-integrity@lfdr.de>; Thu, 10 Apr 2025 18:36:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0A677B46EE
	for <lists+linux-integrity@lfdr.de>; Thu, 10 Apr 2025 16:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDC7C28C5C6;
	Thu, 10 Apr 2025 16:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sSFETOtG"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9751EFF8E;
	Thu, 10 Apr 2025 16:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744302673; cv=none; b=qMFsNvIJWsLPhzgTuH4BoKRvA2FZNbI4YvLf9351fhyoh2aPoVHAZyGLLzd/DPuwRw9G1vkOrkR55O5oW6JlUwd7fK2NnASh+iHSLzTV8ccAb+H7gdVQs+b2cZ1SMPx1iuS3UQ43k3Iibz8sru4Ny7wGiHF8+ma9jZoBcQYo0Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744302673; c=relaxed/simple;
	bh=bEIMva8Jfu96D/+FqV2I5HWsOSzlsPgVRupjZZcj+tk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WPR17hp4SCIHXC69Pxk0wqhrphYfk+aMldLp/gY3/JSmQIa65u2gLglkpv1zYjAC8sArVSfICYCTn1BBkHbZJImuA/76tfNdSmrWzzDRKYEu68dUaQFdYINXjlj7nQcvEYRm4p5f9ngeHTwZJjzNt4M4iRSkgV+JflulfwSv9Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sSFETOtG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 285ACC4CEDD;
	Thu, 10 Apr 2025 16:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744302673;
	bh=bEIMva8Jfu96D/+FqV2I5HWsOSzlsPgVRupjZZcj+tk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sSFETOtG+eTatr0XIRcTnqU187gO65vi/YNUcZmvNyV06WD8/FDtRkgsXNgf+Rn5m
	 zXcoOIAucf56EazfgWb+gpWxJNon4mQ6oDqAU3mURY556zcs9D3qIiQrs+bB/BL4Ea
	 Z9h1quwmSei4ygy8PUIoMMQNnvhOrGFX9T7XRmjUYBOW24Du9Y4Cvg9MfCl0dTPB6h
	 /mGDzdVOcmQ6P5uIeF42cuFlcckv20aRo5gZuQA7jxjdjVLWWfrYv0CW3xEvPL72In
	 wXruR3nFF77qhR9KM/FwyyG0Z/eSQ5WoPCAPIVq30b+yfYaCFFXdO/t4dxMUu/P92J
	 dGI6ZsXW1G9Xw==
Date: Thu, 10 Apr 2025 09:31:10 -0700
From: Kees Cook <kees@kernel.org>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Paul Moore <paul@paul-moore.com>, linux-security-module@vger.kernel.org,
	linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
	John Johansen <john.johansen@canonical.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>, Fan Wu <wufan@kernel.org>,
	=?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	Micah Morton <mortonm@chromium.org>,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Subject: Re: [RFC PATCH 0/29] Rework the LSM initialization
Message-ID: <202504100923.42709A64@keescook>
References: <20250409185019.238841-31-paul@paul-moore.com>
 <1c13537f-b088-464c-87ee-3e81fb909f92@schaufler-ca.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c13537f-b088-464c-87ee-3e81fb909f92@schaufler-ca.com>

On Thu, Apr 10, 2025 at 07:13:11AM -0700, Casey Schaufler wrote:
> On 4/9/2025 11:49 AM, Paul Moore wrote:
> > This is one of those patchsets that started out small and then quickly
> > expanded to what you see here.  I will warn you that some of the
> > individual patches are a bit ugly to look at, but I believe the end
> > result is much cleaner than what we have now, fixes some odd/undesirable
> > behavior on boot, and enables some new functionality.
> >
> > The most obvious changes are the extraction of the LSM notifier and
> > initialization code out of security/security.c and into their own files,
> > security/lsm_notifier.c and security/lsm_init.c.  While not strictly
> > necessary, I think we can all agree that security/security.c has grown
> > to be a bit of a mess, and these are two bits of functionality which
> > can be extracted out into their own files without too much fuss.  I
> > personally find this to be a nice quality-of-life improvement, and while
> > I'm open to keeping everything in security.c, the argument for doing so
> > is going to need to be *very* persuasive.
> 
> It's something I've considered doing as part of the stacking work,
> but that I have eschewed in the spirit of churn reduction. I've no
> problem with it.

Yeah, to be clear, I'm a fan of these refactorings. :)

> There's a lot of churn here due to unnecessary name changes. I can't
> say they're unjustified, but the patch set is bigger than it needs to
> be, and more disruptive.

If renamings are desired, sure, let's do it, but I'd love to see them
very distinctly separated from logical changes.

-- 
Kees Cook

