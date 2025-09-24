Return-Path: <linux-integrity+bounces-7272-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 256A5B9AFE6
	for <lists+linux-integrity@lfdr.de>; Wed, 24 Sep 2025 19:16:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBCF94C52CD
	for <lists+linux-integrity@lfdr.de>; Wed, 24 Sep 2025 17:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F8E81D63C5;
	Wed, 24 Sep 2025 17:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oE7dcWvC"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4D0224B05;
	Wed, 24 Sep 2025 17:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758734196; cv=none; b=itIAv5HbuJobGhn5OGslFWzAZjJyeSic1RZ855s3ssnWBG62py/GhZqgJoa2jIGpq4MZ4ca1C6BLroeUSi51yVH1AKJApIUkX1+BUY7jsy9WF5ftTYdnZrxliZ4cx7XC74Hb7/ZG+TBRx9Xhq2BPSQCMkS6kdbzrGQGm1+hrl9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758734196; c=relaxed/simple;
	bh=lEhcHT+GrPoamgWs/Z/rFoiQb6e/JArqL6YHh7ayXys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ajrpocKI7TWxiSvj1NaSD+ZmBX9X4nXw6aN88+RgNVlkriMEHGw/xrGkI9QupbH7B7LC1Up2dWTvKv+be3oAjCnHhkOIIFXtY8Q9iRhI2Tntvj7vyTGQJvXk4Y50br/XaKO5HYctaen+0Sgj4XjhUoqWScljCbnwDyj91xlnKE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oE7dcWvC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A915C4CEE7;
	Wed, 24 Sep 2025 17:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758734195;
	bh=lEhcHT+GrPoamgWs/Z/rFoiQb6e/JArqL6YHh7ayXys=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oE7dcWvCg8iDR9ekCrTmkehY+ppxDF6YAm2sPDYi+I5UdpT7N+hp6il02++zKZu3p
	 K15FV79aEUYEGp7aIJRI4s87YCBrwLzYucQNo9IIJ2eqHhKO7yX04YpNHGB+wSrdk4
	 FJUXhEVJWj7/Wxl5gnbEB6kLQtQBSrxAugQ9pmJ1+kSUkmRVSc8GCQbAeIfVtL9a0i
	 vjLgfcCmF+YkemE7YHlP2W9fp9SETv6X09F7wuhijpUSEDoC42/kLPCZoJY9DNfXRr
	 Ojxvdrte+vD91lNf0Wgom/pb+2/nRKi+ARG84HFfcqPX6f6zwvQYm1/U3wBHq+MYj9
	 +RzgkE72Ux9YQ==
Date: Wed, 24 Sep 2025 20:16:31 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Jonathan McDowell <noodles@earth.li>
Cc: linux-integrity@vger.kernel.org,
	Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>,
	Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:KEYS/KEYRINGS" <keyrings@vger.kernel.org>,
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH 1/4] tpm: Use -EPERM as fallback error code in
 tpm_ret_to_err
Message-ID: <aNQnb93PiaJ80jEY@kernel.org>
References: <20250922164318.3540792-1-jarkko@kernel.org>
 <20250922164318.3540792-2-jarkko@kernel.org>
 <aNOsoVOZPXns6WB2@earth.li>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aNOsoVOZPXns6WB2@earth.li>

On Wed, Sep 24, 2025 at 09:32:33AM +0100, Jonathan McDowell wrote:
> On Mon, Sep 22, 2025 at 07:43:14PM +0300, Jarkko Sakkinen wrote:
> > From: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
> > 
> > Using -EFAULT here was not the best idea for tpm_ret_to_err as the fallback
> > error code as it is no concise with trusted keys.
> > 
> > Change the fallback as -EPERM, process TPM_RC_HASH also in tpm_ret_to_err,
> > and by these changes make the helper applicable for trusted keys.
> > 
> > Fixes: 539fbab37881 ("tpm: Mask TPM RC in tpm2_start_auth_session()")
> > Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
> > ---
> > include/linux/tpm.h                       |  9 +++++---
> > security/keys/trusted-keys/trusted_tpm2.c | 26 ++++++-----------------
> > 2 files changed, 13 insertions(+), 22 deletions(-)
> > 
> > diff --git a/include/linux/tpm.h b/include/linux/tpm.h
> > index dc0338a783f3..667d290789ca 100644
> > --- a/include/linux/tpm.h
> > +++ b/include/linux/tpm.h
> > @@ -449,13 +449,16 @@ static inline ssize_t tpm_ret_to_err(ssize_t ret)
> > 	if (ret < 0)
> > 		return ret;
> > 
> > -	switch (tpm2_rc_value(ret)) {
> > -	case TPM2_RC_SUCCESS:
> > +	if (!ret)
> > 		return 0;
> 
> Fold this into the check above to get:
> 
> 	if (ret <= 0)
> 
> ?

This is really a glitch in this patch, and I think following what
Stefano suggested is the right call:

https://lore.kernel.org/linux-integrity/tnxfamnvxoanaihka3em7ktmzkervoea43zn2l3mqxvnuivb6n@p5nn34vns3zf/

I.e., a random change to something that was not broken in the first
place :-) Never a good idea (not even in microscale), except something
super cosmetic like maybe grouping constants and stylistic stuff like
that.

BR, Jarkko

