Return-Path: <linux-integrity+bounces-6408-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 530B3AD4F7B
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Jun 2025 11:13:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE8587A32E6
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Jun 2025 09:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9127B257427;
	Wed, 11 Jun 2025 09:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="D8OgeHrj"
X-Original-To: linux-integrity@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25EA0253F08;
	Wed, 11 Jun 2025 09:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749633169; cv=none; b=s+/T2NYEZBCXhJYfTNjtOnfmdljFokJuf0BFGO9i9bRar4e4YvmwR7ow4JA9eYUv2s/B6l84TERyKSESxPOibHHdU/Ly8vcrjmqjsS2EQ/GUvz/tDnWeQXbp7GbaLD9VJpsT+VkXyxXCg7CuwMPEsnN/GG4y6hfbWo7HrdzC734=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749633169; c=relaxed/simple;
	bh=xlBoLeA27Ui6WGsh8ZmVHswrzc1rv4auLqQ9zzcn4tY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K34k0U5G5BoGEJXVWLNe8BrjVRwO6ZXwUZGFio5yO+dS3r0VOOSjj2afVCEhrqdQCMXKbydK2TOfV+TT5YdFE0eq1/gzt72F6BQmwZHusqaqyC/t7GaP4OoQ0oPRqYJwm4/zAyzFpfMZA4STd7MEcCJRDl5oS4UeU9e3RdvelMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=D8OgeHrj; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=99wMk3+pm8AzqEe+0Ig4DL/SSC/eQ1+ARzyWflo5WPY=; b=D8OgeHrjOh/CpRXMb3xgi6H05u
	XYebrImz+ffpUjbQ4D2j1z9/J20hGh2JOZA794iKUNlrLB99zxP+9PvqzdrjviXEQVq5SIxa6HI3A
	H9T9UKqEVMuD2t2+pQg6PqmXHZJSFK3LU6FgXLmCfdFBWtf5ISW3DdlB31M7fvVX/NexIUjcC/F+U
	3pO5vU1TwUSzBsC208dXxpWM3KQ2ig1Er0ZP62T4zJcN3RkQbYWmTxX4Wc/cpt2cSgH3Wdh/ddyPN
	R9BKPpT/6MYB0eDFn2DVxLZxHnOw8IkYdSP++PYYZil6TE4FLcXjJIKVPofWuyAGyKWImzyhVQSCP
	UQRXjmRQ==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1uPHVa-00CJ72-0D;
	Wed, 11 Jun 2025 17:12:35 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Wed, 11 Jun 2025 17:12:34 +0800
Date: Wed, 11 Jun 2025 17:12:34 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Paul Moore <paul@paul-moore.com>
Cc: David Howells <dhowells@redhat.com>, torvalds@linux-foundation.org,
	Jarkko Sakkinen <jarkko@kernel.org>, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-crypto@vger.kernel.org,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KEYS: Invert FINAL_PUT bit
Message-ID: <aElIgixaHGuHEnb8@gondor.apana.org.au>
References: <301015.1748434697@warthog.procyon.org.uk>
 <CAHC9VhRn=EGu4+0fYup1bGdgkzWvZYpMPXKoARJf2N+4sy9g2w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhRn=EGu4+0fYup1bGdgkzWvZYpMPXKoARJf2N+4sy9g2w@mail.gmail.com>

On Tue, Jun 10, 2025 at 08:22:59PM -0400, Paul Moore wrote:
>
> It doesn't look like this has made its way to Linus.  David or Jarkko,
> do one of you want to pick this up into a tree and send this to Linus
> properly?

I can pick it up for the next merge window.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

