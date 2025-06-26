Return-Path: <linux-integrity+bounces-6560-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 487F0AEA9AE
	for <lists+linux-integrity@lfdr.de>; Fri, 27 Jun 2025 00:33:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C187556341F
	for <lists+linux-integrity@lfdr.de>; Thu, 26 Jun 2025 22:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C323A21ABA4;
	Thu, 26 Jun 2025 22:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iq8E9cXE"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 926A82F1FC9;
	Thu, 26 Jun 2025 22:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750977188; cv=none; b=C2MYXC6Z/Mx1psnB7XmyerkjQWRBp/TXafAlv62qWEgnRVcS2B0y6lV83MIPGHBi6eq2kU6FoZbQdy8WJORT4BzunnMRbXUfRZAxhy2X7lKk5uw3mkz+pR3FvQvVXQBG4j8XwTj/Yew9dkdntCBUButg7pSpkqCtD4jO3qeIZ7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750977188; c=relaxed/simple;
	bh=oYEdw6H3I4g+axHYIfU1xMFRXCvU8uB8d1u0c0O3u2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LRUMmxldsQ3t3itqmSuTcBdW5nHLzbv5izfpF/hcSRpHpsJ4/0ZktybPDgDWYouI5PupLt6Mue4gMBXw5vnkwpJaTok+J2TMyVcN5QEjRMNoINVAc8YdyRtYf5kcKxq5qPbWwhnv7EraL5qegtZLyO1tZTMYYLKFh76O1Hp2Bgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iq8E9cXE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFAC0C4CEEB;
	Thu, 26 Jun 2025 22:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750977188;
	bh=oYEdw6H3I4g+axHYIfU1xMFRXCvU8uB8d1u0c0O3u2c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Iq8E9cXEGHuglNY/d27sdNwpBv5ZwCg/+z79mTAUM+uovm+evzPKmyaDQyDjfHPEp
	 IP0qN2Xhip7DHA+YJMcxsC0bWG76/qOn0H8sh/96jJc6G5LKh1+3ZcIO1xytnw4zLu
	 MO9BgufVyOXJ/mhvLPgkbEp11WBBGR9xXpEE4djy9GxfGti66Y3jhokh4D+boyjeYE
	 EUGgdJhVbQQtlqxV0/oDWvgWjZQLSWmEGt6M2DgKc2lHPlfww4d8vBGqn78+jc9+H7
	 PVy2+Hpw8YwEsX9ySlcKNrTGTxtOmD+7ALETgMrZS7HcXf+ylLoNN6AB7Up/MIYgkn
	 e0bcrrIR5RLPg==
Date: Fri, 27 Jun 2025 01:33:04 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-kernel@vger.kernel.org, keyrings@vger.kernel.org,
	Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>,
	Peter Huewe <peterhuewe@gmx.de>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	"open list:TPM DEVICE DRIVER" <linux-integrity@vger.kernel.org>,
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH] tpm: Create cleanup class for tpm_buf
Message-ID: <aF3KoHdo6dY6nYbw@kernel.org>
References: <20250625213757.1236570-1-jarkko@kernel.org>
 <20250626144915.GD213144@ziepe.ca>
 <aF2QbDmxzGJS903j@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aF2QbDmxzGJS903j@kernel.org>

On Thu, Jun 26, 2025 at 09:24:48PM +0300, Jarkko Sakkinen wrote:
> > At least I would add the class and drop the tpm_buf_destroy() as one
> > patch, and another would be to cleanup any empty gotos.
> > 
> > Also, I think the style guide for cleanup.h is to not use the
> > variable block, so it should be more like:
> > 
> > CLASS(tpm_buf, buf)();
> > if (!tpm_buf)
> >    return -ENOMEM;
> > 
> > AFAICT, but that seems to be some kind of tribal knowledge.
> 
> This was improved in v2 :-) If you have some proposal how you'd
> liked that version to be splitted, please give feedback.

After a bit of thought, II could split v2 e.g., into to the following
list of patches (a draft, along the lines):

1. Prepare internals for API changes.
2. Implement tpm_buf_alloc().
3. Implement CLASS_TPM_BUF() macro.
4. Changes for tpm{1,2}-cmd.c.
6. Changes for tpm2-sessions.c.
7. Changes for tpm2-space.c.
8. Changes for trusted_tpm{1,2}.c
9. Remove stuff left w/o a call site.

It's pretty good exercise for v2 actually as it is already somewhat
functional code. By doing this split this update will get already
reasonably well verified.

I should also probably emphasize the motivation better in the next
version.  Especially with multiple tpm_buf instances in the same
function scope, things do something are messy to backtrack. In addition,
this complexity might cap the motivation for someone to contribute a
useful feature.

I don't really have even followed Linus' opinions in this topic per se
I personally just think that since I have a measured argument for this.
I got with that and talk with Linus if he wants to bring it up :-)

BR, Jarkko

