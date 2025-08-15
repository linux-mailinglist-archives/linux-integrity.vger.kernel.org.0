Return-Path: <linux-integrity+bounces-6858-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 081E9B283CB
	for <lists+linux-integrity@lfdr.de>; Fri, 15 Aug 2025 18:28:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63BF2AA2F06
	for <lists+linux-integrity@lfdr.de>; Fri, 15 Aug 2025 16:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D31F9308F31;
	Fri, 15 Aug 2025 16:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="cMeR2TD0"
X-Original-To: linux-integrity@vger.kernel.org
Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1961C1DFE0B;
	Fri, 15 Aug 2025 16:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755275237; cv=pass; b=JeefXaMfH612/Cmvl1wn91A4GFWE2huaXxuCvEDO8UeWCxiEcy0nUMs+LGav7wZPozNImKkXXuX4xHulJ8a5SDOlsN0O7fPcNrzC63UWjKrNvLQ6wTjod82p9zx4G5iJKQo952IPQqqaAXNnnb4tExCEILGZVFpVZZ/L19S6leE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755275237; c=relaxed/simple;
	bh=5+XdDs12ulOZnLkEewrv0XuNVeWQDZjkx1K9KDii/rw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FDOujGocNexIsm+dOGQxXxbffSMHNkAyAibBsZ27SOu2DacOWN5xOMuGsDrpzH6n3VEFWHmBbbTZJpqnJ8XLLwPv6d3D56g2tprPMSROoRETejFYKdJDRj5OYKCohs5gHEKm/0jBnCwa20jJVgIC+QL3kuPq32NUJjszclwAxYY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=cMeR2TD0; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Received: from localhost (n5z527m3mjwy6a3pz6x-1.v6.elisa-mobile.fi [IPv6:2001:999:588:5309:51e8:edee:be54:a969])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sakkinen)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4c3SDq2zLzzyTF;
	Fri, 15 Aug 2025 19:27:06 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1755275232;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YrIPZUVKQzC45FOrz+Jtwamu4m4kCvCmJAWTeS2TERY=;
	b=cMeR2TD0mA8KlyVM8jm6/idtLXURzEDPuzJzQPi5XNAzGAGj/qOOjqPcq7VWWuCTPh5joR
	FqaQ6X1RsT4OaBqbUO2vD+LfVjzSU2KjTobfCilOElMF+f61E2oscOVz1dv2YeU3pgkVKt
	gQSd9ix2P/9nMtqprWSJNgVCT+aY1d8=
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1755275232; a=rsa-sha256; cv=none;
	b=T+JkRrDy0+EYwQyap1w+LjE+XPzdhh/EDvvfKqEl3e2udOsMdga/Z8owY7ohDs9sJwSV3T
	kiQJfbKNOAjQGtrDcooPGmSWjIFdRpNgDtY5fqEdUFqkwQiueBvTDCqqMlLEKYcO56t1SC
	g/8OoAXhCt707ctb2DrIjmhbK4pv2+8=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=sakkinen smtp.mailfrom=jarkko.sakkinen@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1755275232;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YrIPZUVKQzC45FOrz+Jtwamu4m4kCvCmJAWTeS2TERY=;
	b=bRCtcVt523f7Kty0FXCD006Q+XxCs2sLVV7XD1M+lU9po1Jx345QmBHF/Nr6d/A0oSDN7s
	c4TbAMbIVRbZqRjD52xqlME3RTezyJZ/pjd8PDYAXLYQyHCEs7jLZR7s55Gn9hRbsJSivJ
	cSmV565IQYWF6a+7R0DKbeA3zcerT78=
Date: Fri, 15 Aug 2025 19:26:51 +0300
From: Jarkko Sakkinen <jarkko.sakkinen@iki.fi>
To: Chris Fenner <cfenn@google.com>
Cc: Jarkko Sakkinen <jarkko@kernel.org>, Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm: Disable TCG_TPM2_HMAC by default
Message-ID: <aJ9fy_sO6tza9qLF@iki.fi>
References: <20250814162252.3504279-1-cfenn@google.com>
 <aJ8iNLwlf4PAC0h1@kernel.org>
 <CAMigqh1RTVzz0ffY8M3mZuc7NDaBKpMmCU4q0LuNyM2eAi+NFg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMigqh1RTVzz0ffY8M3mZuc7NDaBKpMmCU4q0LuNyM2eAi+NFg@mail.gmail.com>

On Fri, Aug 15, 2025 at 08:45:06AM -0700, Chris Fenner wrote:
> I have a Linux machine with a standard off-the-shelf Infineon SLB9670
> TPM. Without the session salting, each PCR extension takes just 4-5
> ms. With session salting, it takes:
> * 30ms to load the null key from its context blob
> * 108ms to start the auth session and extend the PCR inside it
> * 1ms to flush the null key
> 
> for an overhead of about 2880%. Depending on the configuration of the
> kernel/IMA and how many PCR measurements it's making, this could add
> up to a good chunk of time and explain reports like [3] where people
> are noting that turning this feature on adds minutes to or triples the
> boot time.

I'll with shoot another proposal. Let's delete null primary creation
code and add a parameter 'tpm.integrity_handle', which will refers to
persistent primary handle:

1. It simplifies the code considerably.
2. It makes whole a lot more sense especially given that there's
   ambiguity with the key. This comes from earlier off-list
   discussion where you made this argument, and I'll buy that.
   I.e. even if we could certify null primary we cannot certify
   it is "unambiguousness".
3. Update tpm-security documentation accordingly.

I think this might be "the long-term fix" that could be done right noW.

BR, Jarkko

