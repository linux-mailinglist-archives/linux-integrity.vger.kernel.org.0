Return-Path: <linux-integrity+bounces-7379-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 846E1BBDF0C
	for <lists+linux-integrity@lfdr.de>; Mon, 06 Oct 2025 13:58:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 150603BDC73
	for <lists+linux-integrity@lfdr.de>; Mon,  6 Oct 2025 11:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63E08226CF0;
	Mon,  6 Oct 2025 11:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YZt5lHgj"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D8B17E4;
	Mon,  6 Oct 2025 11:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759751897; cv=none; b=qOUYm48Gar5tjVSyx3DYlidULlNbjxp53zHQTETgp1JVjBwMA+KIiJTda1PirsSvnqdv+x1il/6KyZe216iEUx4xSTL6biTq15fsGyfv5Ow2ndn43wlCUAk7PA3WcCHKwIZhMyXbWsEqQCWt/wILUg3lOK0sdnHoVRoyibMkweI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759751897; c=relaxed/simple;
	bh=sXH4Zb7rRfjuXhhiwYUPzuTkel+x9N95nlxqtLz/14Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U7FlbAUhX+mAxj3r6D1iDC29dMhGhWvUrT0X8X9a+1uZKfX1jRjz1bwhvRuK/eoGZlXUhqgk0n3L0hC+KglxQKlClXQTung+iwXI4Awv+Qlh1a0HZvVUGRyHn+x7Ou7scMKfVswDpxHWDZS5nu2klrjjbLM7GvIgsZ7Z/03JPm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YZt5lHgj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B44D0C4CEF5;
	Mon,  6 Oct 2025 11:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759751897;
	bh=sXH4Zb7rRfjuXhhiwYUPzuTkel+x9N95nlxqtLz/14Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YZt5lHgjEkIazL/oeiAhnlWJJgAxIsJZew2801b/GSOdjgxjk8NiWHyu1bhcpPdgD
	 Cyr4ykkQ5sBsKdX53l7HSYOpNlcnGd+udY2VLpwGOGb2TjboRP42HDJxQVWkIUJzCt
	 obURUSK0cc/201xfH/NWh9r4STchr5jPnpkPme1bFAZt5BoNo9K8rznjE5P2yaGDuF
	 Yt8kFyqItUOtOuvXXJBgMLf6mcomAxZWQMb+qefZ8vckFVd7S8w/E4TpSDwwLI2MQS
	 aXHBVbhSdl59iESpqZXA0VZmR7TQArPJkFVQbf5ZnEpNM4leKjw7iRBlugCozme25f
	 ujyH7Zf6hnw2Q==
Date: Mon, 6 Oct 2025 14:58:13 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] TPM DEVICE DRIVER: tpmdd-next-v6.18
Message-ID: <aOOu1f1QWQNtkl6c@kernel.org>
References: <aOKTFv1vh1cvvcLk@kernel.org>
 <CAHk-=wiCWiDcLEE3YqQo78piVHpwY2iXFW--6FbmFAURtor2+w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiCWiDcLEE3YqQo78piVHpwY2iXFW--6FbmFAURtor2+w@mail.gmail.com>

On Sun, Oct 05, 2025 at 11:09:08AM -0700, Linus Torvalds wrote:
> On Sun, 5 Oct 2025 at 08:47, Jarkko Sakkinen <jarkko@kernel.org> wrote:
> >
> >      This pull request disables
> > TCG_TPM2_HMAC from the default configuration as it does not perform well
> > enough [1].
> >
> > [1] https://lore.kernel.org/linux-integrity/20250825203223.629515-1-jarkko@kernel.org/
> 
> This link is entirely useless, and doesn't explain what the problem
> was and *why* TPM2_TCG_HMAC shouldn't be on by default.
> 
> I think a much better link is
> 
>    https://lore.kernel.org/linux-integrity/20250814162252.3504279-1-cfenn@google.com/
> 
> which talks about the problems that TPM2_TCG_HMAC causes.
> 
> Which weren't just about "not performing well enough", but actually
> about how it breaks TPM entirely for some cases.

Fair enough. I'll also enumerate the issues, and also roadmap
to heal the feature.

> 
>               Linus

BR, Jarkko

