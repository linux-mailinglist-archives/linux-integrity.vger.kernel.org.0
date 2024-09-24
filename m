Return-Path: <linux-integrity+bounces-3677-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73C6B984916
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Sep 2024 18:07:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A82C284409
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Sep 2024 16:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D5B1AD9C6;
	Tue, 24 Sep 2024 16:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gp3Puujc"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14B51AD9C0;
	Tue, 24 Sep 2024 16:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727193914; cv=none; b=PLQ5STJDdDp5n4HQsPNL8YbsjR2snfJygDpGl41P3Ic3T39b2zYHRRQn5KZBScA0GdScw44e9PCLEeslytLqp7ZLKwoNGtOZPGt+BvTeHyIiAkxBQLLzs8YwtzLYUIy2p9JoiqubsO4ny65x/c+TaJLJ/4mJ3lOXKHipe6DEbhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727193914; c=relaxed/simple;
	bh=mZ42CM4kCLM+8EKFdf2GzoGmoR2FGfpOWwtq0wy6W8c=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=WaBmFcI9zKyyMtVrB4ufDgSNUZAGAGwprvItdO6s4rkBZ4hHccNQw7i4BryyKbPXNAN82xCd7LPoP54jNALUIebGvfMXs/L+FJn7SegZhXG5xyh8omZZVpaOmbEaUJ1O7GCYdVU2LDo4XbJF5PJy0K8OFlrXaF03berdBZGdKsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gp3Puujc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50423C4CEC7;
	Tue, 24 Sep 2024 16:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727193913;
	bh=mZ42CM4kCLM+8EKFdf2GzoGmoR2FGfpOWwtq0wy6W8c=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
	b=gp3PuujcSy8Mg1vuUsMXXyhEud0Oj/ZzFkw9tnzymjELjGIJPVJ7QCtMPWCklGpTo
	 m7eCb5C4byxIB2QislN26WrjiNkVKDpfZzIl57UqtmKE7aVR7kjD7Gf5YX15NPPc9o
	 0EeL7tA0Kx/VKBjT1dHg0KTZ8iU6u0GM33F2RbZchbSjnnP3pMrlhKQOzBK+IYgH9l
	 hPoqX6R8PxPzk47/MTWR1fg49wvHWg36GuZIV2zWs6OaHinjZCGjcJiIbWW30wc6bs
	 8epb8UDIk5KGsQdD4xIPSBNJAraq9p3Hde1Cx1MSewCGhvknC4igakNAvnZYFgQqWp
	 pMrpAn2BZk4YQ==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 24 Sep 2024 19:05:09 +0300
Message-Id: <D4EN54C1IK1R.11JD66L931PD8@kernel.org>
To: "Herbert Xu" <herbert@gondor.apana.org.au>, "Greg KH"
 <gregkh@linuxfoundation.org>
Cc: "Linux Crypto Mailing List" <linux-crypto@vger.kernel.org>, "Guangwu
 Zhang" <guazhang@redhat.com>, "Peter Huewe" <peterhuewe@gmx.de>, "Jason
 Gunthorpe" <jgg@ziepe.ca>, <linux-integrity@vger.kernel.org>, "James
 Bottomley" <James.Bottomley@hansenpartnership.com>
Subject: Re: [PATCH] hwrng: core - Add WARN_ON for buggy read return values
From: "Jarkko Sakkinen" <jarkko@kernel.org>
X-Mailer: aerc 0.18.2
References: <ZvEFQAWVgWNd9j7e@gondor.apana.org.au>
 <D4DI1M1ELFXK.2COGZN6O5HABD@kernel.org>
 <ZvE0NrOC00ojRe3t@gondor.apana.org.au>
 <D4DQJ34I5FSD.1K618VWEKI7IW@kernel.org>
 <2024092340-renovate-cornflake-4b5e@gregkh>
 <ZvHsh6by3omeYj9d@gondor.apana.org.au>
In-Reply-To: <ZvHsh6by3omeYj9d@gondor.apana.org.au>

On Tue Sep 24, 2024 at 1:32 AM EEST, Herbert Xu wrote:
> On Mon, Sep 23, 2024 at 04:48:27PM +0200, Greg KH wrote:
> >
> > Please see:
> > 	https://www.kernel.org/doc/html/latest/process/deprecated.html#bug-and=
-bug-on
> > which describes that.  We should make it more explicit that any WARN()
> > or WARN_ON() calls that can be hit by user interactions somehow, will
> > end up getting a CVE id when we fix it up to not do so.
>
> If the aformentioned WARN_ON hits, then the driver has probabaly
> already done a buffer overrun so it's a CVE anyway.

We'll see I finally got into testing this. Sorry for latencies, I'm
switching jobs and unfortunately German Post Office lost my priority
mail containing contracts (sent them from Finland to Berlin) so have
been signing, scanning etc. the whole day :-) My last week in the
current job, and next week is the first in the new job, so this
week is a bit bumpy.

BR, Jarkko

