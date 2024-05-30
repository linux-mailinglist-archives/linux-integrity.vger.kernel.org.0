Return-Path: <linux-integrity+bounces-2714-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15F1B8D4536
	for <lists+linux-integrity@lfdr.de>; Thu, 30 May 2024 08:01:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEDF21F2322F
	for <lists+linux-integrity@lfdr.de>; Thu, 30 May 2024 06:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0346714372C;
	Thu, 30 May 2024 06:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UBRp6eqv"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A635C7F;
	Thu, 30 May 2024 06:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717048883; cv=none; b=VQ3/uxPl71O00/L+RqBslCvi2/fs4TAN9q0WZnCotXxr6tXTJiDGes7jd/HRfTRnBDJCVIHmoBBonwgCopZ3ibbiNn4m9C8sM7rEmD8C7gf1oZp8KzSw1dWpNDkUsRublxPpRC+N/aE1ETrZMMdmO/PuADEdko7UiniSTF4GCsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717048883; c=relaxed/simple;
	bh=sMQhmPMrxDqBb+GMiCUWSmUfWbT6ZYt7eWULOCQH4DM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AYUz4xk7MYnx6qAHzx7SdDhLuox7ruguZNkDyijUlalHEYw1sHjATnitMGXOuy+hugr16JTKB0+w301VDTF9iqLj1EKAzNfA6fdxG9WouZf1YxgC+8sJsVGm1zj4N50RfidotHjUPoE7KM9Xge5G2QKZTDiQ2k3gxx6P9a6HZbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UBRp6eqv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E9A3C2BBFC;
	Thu, 30 May 2024 06:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717048883;
	bh=sMQhmPMrxDqBb+GMiCUWSmUfWbT6ZYt7eWULOCQH4DM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UBRp6eqvNI28qzwp3VBZgtvsj6HNY6LqJJqqMJ3gkdd1e+NoHnhowjTUJml9Zz5mr
	 xE0qa1rHiSRi52Clr720vSw5vX4kGfKkb7j54/uTuQME/7h8/yv4aSDG+BM5o2vpPE
	 Wcdev3k7FILnPoC8D4SOrnsc71JsMiXOIPrChlA81EXYJJK9QTm2VayLusgGfm906a
	 O7qnPrSxnxecjtir+BjogId3A4iY+lnb9V0SUjzE2OyfwbXNN6tm+H8Fqk031gje34
	 KcXa9IrzZtJENw/hLh6myIXWnrLuu966vCIRmpTJdMz156ZpVpkIKihdlhlVnR9Wac
	 hLKSG2T2MsKEg==
Date: Wed, 29 May 2024 23:01:20 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>, Fan Wu <wufan@linux.microsoft.com>,
	corbet@lwn.net, zohar@linux.ibm.com, jmorris@namei.org,
	serge@hallyn.com, tytso@mit.edu, axboe@kernel.dk, agk@redhat.com,
	snitzer@kernel.org, mpatocka@redhat.com, eparis@redhat.com,
	linux-doc@vger.kernel.org, linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org, fsverity@lists.linux.dev,
	linux-block@vger.kernel.org, dm-devel@lists.linux.dev,
	audit@vger.kernel.org, linux-kernel@vger.kernel.org,
	Deven Bowers <deven.desai@linux.microsoft.com>
Subject: Re: [PATCH v19 15/20] fsverity: expose verified fsverity built-in
 signatures to LSMs
Message-ID: <20240530060120.GB29189@sol.localdomain>
References: <1716583609-21790-16-git-send-email-wufan@linux.microsoft.com>
 <06bb61dc838eeff63bb5f11cea6d4b53@paul-moore.com>
 <D1MQTEW77RY8.36THC7YDK7CZO@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D1MQTEW77RY8.36THC7YDK7CZO@kernel.org>

On Thu, May 30, 2024 at 08:51:21AM +0300, Jarkko Sakkinen wrote:
> On Thu May 30, 2024 at 4:44 AM EEST, Paul Moore wrote:
> > > +	err = security_inode_setintegrity(inode,
> > > +					  LSM_INT_FSVERITY_BUILTINSIG_VALID,
> > > +					  signature,
> > > +					  le32_to_cpu(sig_size));
> >
> > I like this much better without the explicit inode cast :)
> 
> Would be nice btw if that was 'ret' or 'rc' because err is such
> a common name for exception handler alike goto-labels... Looks
> confusing just because of that :-)
> 

A lot of kernel code, including the rest of fs/verity/, uses the convention that
"0 or negative errno" return values are named 'err' (and return values that
aren't necessarily an errno are named something else).  So it's fine as-is.

- Eric

