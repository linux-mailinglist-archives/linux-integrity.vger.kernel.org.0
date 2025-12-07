Return-Path: <linux-integrity+bounces-7839-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D3038CAB326
	for <lists+linux-integrity@lfdr.de>; Sun, 07 Dec 2025 10:28:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4E8003070142
	for <lists+linux-integrity@lfdr.de>; Sun,  7 Dec 2025 09:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CC6E29C327;
	Sun,  7 Dec 2025 09:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e1V0L+hs"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3641B3595B;
	Sun,  7 Dec 2025 09:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765099694; cv=none; b=KaFgLEgI707QbeSGECrZ0zGBYZh6l8C9qjvj5TxvN1nBDEN4UiBBl93VLuA39VQwd2SYY2cKDkoIyg/n34oEx18v9KJwaBdoEwFbzjkzOtE414giPWLjRoF9axtE9W7aG7P5MqjmYSMmglss7pXMLR2+IAkLB8a6LiE2ly6gUr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765099694; c=relaxed/simple;
	bh=rPz7c1YZMbGdsnfn5HwL4Vr7D5oMoajQPy04lk5p4oo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nJnOEGWQb+ZquCDteaPXNrHub20ADlI4gEhxRCbBWsenBnB22+lkzQERvp2dhhUbWh6JiqjAP/STr2OEW9rBVW5GzPtPCr/VE1c3IK2OSlsYS8cASCrqlv+PmUEkRG6oe9hcxGLCxKLQfdzVLjTPOGzMenCkvxX59rmiBxc8g0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e1V0L+hs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A28EC4CEFB;
	Sun,  7 Dec 2025 09:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765099693;
	bh=rPz7c1YZMbGdsnfn5HwL4Vr7D5oMoajQPy04lk5p4oo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e1V0L+hsit9zqKJTtHRmKVtcqlabhvA9GAtWkfG/M/eI2qrbQl59zoahxZzbi03YC
	 MDvde7zHEySJtn4eJwNuL53E+D5yTRPCN2tL5tgKEQ8W4IIuspx0LO9Ht73hmaIFgt
	 D2gpdnL0OBjiqs+dp2i9/sTF5HdDM3EfLuOtjMVCoWYEg8Fe+qXtLp+hEEtUmyI+oY
	 7VK0GdA/T9ZlVl0PYFzn6XS3GhRI6UDceXPbh0FS1Hzjgsf4qxgY2xalBKr8FECm5l
	 tEu6C4RF1JE02mRjlJbbtgWSAZuFiDObBTf0A+JAzLipaLAtzYu9tcEZT9bSzeI8/D
	 5WO1gD5AJfq+w==
Date: Sun, 7 Dec 2025 11:28:09 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: linux-integrity@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>, Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:KEYS-TRUSTED" <keyrings@vger.kernel.org>,
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH] KEYS: trusted: Re-orchestrate tpm2_read_public() calls
Message-ID: <aTVIqfXSdcu1Wd8p@kernel.org>
References: <20251204223128.435109-1-jarkko@kernel.org>
 <aTIXOr3rpI9xufTl@kernel.org>
 <aTIsFJobEyISTO_y@kernel.org>
 <89d90617ba9b7a5eff1d5fad6bb9773033d3c18c.camel@HansenPartnership.com>
 <aTVGiubK5EKitM9u@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aTVGiubK5EKitM9u@kernel.org>

On Sun, Dec 07, 2025 at 11:19:10AM +0200, Jarkko Sakkinen wrote:
> On Sun, Dec 07, 2025 at 03:33:17PM +0900, James Bottomley wrote:
> > On Fri, 2025-12-05 at 02:49 +0200, Jarkko Sakkinen wrote:
> > > On Fri, Dec 05, 2025 at 01:20:30AM +0200, Jarkko Sakkinen wrote:
> > > > On Fri, Dec 05, 2025 at 12:31:27AM +0200, Jarkko Sakkinen wrote:
> > > > > tpm2_load_cmd() and tpm2_unseal_cmd() use the same parent, and
> > > > > calls to
> > > > > tpm_buf_append_name() cause the exact same TPM2_ReadPublic
> > > > > command to be
> > > > > sent to the chip, causing unnecessary traffic.
> > > > > 
> > > > > 1. Export tpm2_read_public in order to make it callable from
> > > > > 'trusted_tpm2'.
> > > > > 2. Re-orchestrate tpm2_seal_trusted() and tpm2_unseal_trusted()
> > > > > in order to
> > > > >    halve the name resolutions required:
> > > > > 2a. Move tpm2_read_public() calls into trusted_tpm2.
> > > > > 2b. Pass TPM name to tpm_buf_append_name().
> > > > > 2c. Rework tpm_buf_append_name() to use the pre-resolved name.
> > > > > 
> > > > > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> > > > 
> > > > If ASN.1 blob would contain also name of the parent then zero
> > > > tpm2_read_public() calls would be required i.e., the main
> > > > bottleneck here inherits from the limitations of the file format
> > > > itself.
> > > 
> > > Along the lines of attached patch.
> > 
> > Well firstly [6] is already being taken by the creation data proposal,
> > so this would introduce an incompatibility between the kernel and the
> > spec, but secondly, if you want something like this in the spec before
> > it goes to the IETF you really need to propose it now.
> 
> What is the mailing list for the working group, or is this still
> unclear as of today?
> 
> > 
> > The problem with this particular addition is that it would be Linux
> > Kernel specific.  All the current TSSs already do a cached read public
> > under the covers when they add the session wrappings so the user facing
> > API they expose has nowhere to insert (or easily extract) a name field
> > and thus TSS based implementations would have no incentive to either
> > output or consume this field.  That's not to say the standard can't
> > have additions for crazy or niche use cases (that's what the rsaParent
> > flag is: a one off to support a niche SUSE use case) but it would be
> > hard to persuade user implementations to do this so the kernel would
> > have to interoperate with the case where it didn't exist anyway.
> 
> It is just matter of conditionally calling tpm2_read_public(). Not
> a big deal.
> 
> > 
> > The standard use today is with permanent handles for parents, where the
> > parent is created on the fly, so the name is actually returned from
> > TPM2_CreatePrimary for this use case.  It should be a simple matter to
> > bring the kernel implementation up to doing this as well.
> 
> Intercepting TPM2_CreatePrimary does not provide full coverage, as
> it does not address persistent keys, which kernel interface does
> support.

It also weaker solution in the sense that it lacks support for secondary
keys as parents.

Name digest is universal as it scales primary keys, secondary keys both
persistent and transient.

I'm not really sure why we should use TSS implementations as reference
for anything in this space. We always want to support "superset' because
it actually creates innovation and distruption to the pre-existing
science.

BR, Jarkko



