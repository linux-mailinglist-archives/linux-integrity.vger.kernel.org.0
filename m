Return-Path: <linux-integrity+bounces-7084-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 100A3B58253
	for <lists+linux-integrity@lfdr.de>; Mon, 15 Sep 2025 18:40:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CF6B7A73C9
	for <lists+linux-integrity@lfdr.de>; Mon, 15 Sep 2025 16:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F03D4264A9E;
	Mon, 15 Sep 2025 16:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dBjRTLOP"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC0B3B1AB;
	Mon, 15 Sep 2025 16:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757954392; cv=none; b=tPWXNwlwapmxF8b/C4YpjvHKMR++21b1MI0C0NGBdMcMnx61jW1V4bw+gk4/hllKygNcUYdXQ3AWzaXhY42pQeihITdUZVhQqqiZgd2fJKZakm0mqlogz1afbnJgje2lJyswweYSgXU2UCo+4yrotEgoVg3JYWiuwkpulrnCiAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757954392; c=relaxed/simple;
	bh=Z8A8GPAQF9g0Cbu9CE2MdE4wD+Nl3g96ByVA34gWwfM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CsR9Bgc2L1NIn6mfuptImxjh9s3ZyzLIQQ3wPUT7as9OtCiFNQ/peVU1R6EMK9+oZaqRqdIuLY5JsszZi+kjO2EuD0E3JKSEyUWp6LNKyS2v5w9ntNeSwhEs14ST93+cfX27TwkyXbCB9V6OPXu0xOi7IDvzwWWbJDA7Cc4hGQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dBjRTLOP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B2A5C4CEF1;
	Mon, 15 Sep 2025 16:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757954392;
	bh=Z8A8GPAQF9g0Cbu9CE2MdE4wD+Nl3g96ByVA34gWwfM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dBjRTLOPBqCRVOsgSHyqRuHBUvho/NCwMW/RT7Nj4S+cu0W0vdIP73oOZOJOgqNNb
	 M/v5WKl0LUkIrYSznexL1Wmpw+ODkb1bIAeZpEp3kPHolgaZF/63JCvTXSREG0asSf
	 RHsohUTIxDTo+WmKbakSFr9J6m8Gkd9x27ATLJtEgqvClYD9q49RoTJn5eVL5Azgp/
	 lZfx1RMeGVPThhqNOKKRpdN/MT0FjWJSd5Z9BBgFbx6sajCeMhIDJx48d8ajw5ILqJ
	 LLZTqMGl5p5dWbxHqFl81pKdfh3VMN/iPvzVK0TFxETNyuNWBK9tu1k+WmRL5XM/dm
	 1tZQcKqh+6BRQ==
Date: Mon, 15 Sep 2025 11:39:49 -0500
From: Eric Biggers <ebiggers@kernel.org>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Jarkko Sakkinen <jarkko@kernel.org>, keyrings@vger.kernel.org,
	David Howells <dhowells@redhat.com>,
	linux-integrity@vger.kernel.org, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KEYS: encrypted: Use SHA-256 library instead of
 crypto_shash
Message-ID: <20250915163949.GF1993@quark>
References: <20250731184747.12335-1-ebiggers@kernel.org>
 <aJIKH3-fRizRV8fi@kernel.org>
 <e8fff5a1607ce2d98c5999d522202e1104f0a12d.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e8fff5a1607ce2d98c5999d522202e1104f0a12d.camel@linux.ibm.com>

On Sun, Sep 07, 2025 at 07:57:12AM -0400, Mimi Zohar wrote:
> On Tue, 2025-08-05 at 16:41 +0300, Jarkko Sakkinen wrote:
> > On Thu, Jul 31, 2025 at 11:47:47AM -0700, Eric Biggers wrote:
> > > Instead of the "sha256" crypto_shash, just use sha256().  Similarly,
> > > instead of the "hmac(sha256)" crypto_shash, just use
> > > hmac_sha256_usingrawkey().  This is simpler and faster.
> > > 
> > > Signed-off-by: Eric Biggers <ebiggers@kernel.org>
> > 
> > Yeah, fully agree.
> > 
> > Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> > 
> > David, will you pick this?
> > 
> 
> Do you want this patch being upstreamed with "[PATCH 0/2] Convert lib/digsig.c
> to SHA-1 library" patch set?
> 
> thanks,
> 
> Mimi

If someone could apply this for v6.18, that would be great.  It's
independent of my other patches.  It looks like Mimi has been taking
changes to this file most recently.  If David or Jarkko wants to take it
instead, that's fine too.  As long as someone does it.

- Eric

