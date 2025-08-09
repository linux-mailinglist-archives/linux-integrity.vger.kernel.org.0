Return-Path: <linux-integrity+bounces-6791-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49AB9B1F444
	for <lists+linux-integrity@lfdr.de>; Sat,  9 Aug 2025 12:51:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 640C456149C
	for <lists+linux-integrity@lfdr.de>; Sat,  9 Aug 2025 10:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79C5C223DF5;
	Sat,  9 Aug 2025 10:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kQCJ6a0I"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55BE72AE74
	for <linux-integrity@vger.kernel.org>; Sat,  9 Aug 2025 10:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754736713; cv=none; b=dY/Ti0PsdstHy77D0YDk2awyxOczpmDfUym5m0/S+jiKX74Xf5jZioX0MYads8RpHwUm4gcyjgtmxpx2eWiinocizWf1W/iv2Nl2zJ81vgerqX3Ys6sqt4RtwEWaCwD2b6UAsG2sHdZDJPSYl49Lga8HhWo6Md/Wak2ZTxdR+VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754736713; c=relaxed/simple;
	bh=heoXipi+SIVRkujgsQwZt/51Z+8htNCQVYSQy7a1xkw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UqYmcx6YwH7KLUqzy5FvV2bZQ+bFeQgzf4pOr6oFtyjHCCFJTVjg0NwOcmWE69vZHVv5WmaLgtrIl1zsVKFo7D1ec7XTzYyb1A3Gglxc9ft5OjLCffXb5JnUN3u0bfB4eXi8IJvE6zIVZ8m6UdpKEupHgnNN4htQe0N/zw1d+ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kQCJ6a0I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8AFFC4CEE7;
	Sat,  9 Aug 2025 10:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754736713;
	bh=heoXipi+SIVRkujgsQwZt/51Z+8htNCQVYSQy7a1xkw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kQCJ6a0INUE15jbzVa8laij2eVgdG4VJrlQ4R7yfhU/mp1/pmuI0407PsE58R0yLg
	 K6Fdt2sLcfoqR5P+pJsewul80j30m492SwKbiA4mvYEOcd9+1+0XvpT7j8snkMbccN
	 aICeQ+DAIneYpznl0S2aPItWwbQOU7h2b49OrADgf/Lfmj051ckzKmuguWVpT1Z8rr
	 kBtXsoYDg4PVNsHiCvLkAYSSnfDYOIwS3Cp5Ub9rJxEAWwwQcG7uL+7WIXRU9VGsFq
	 qaF2nFribCO9YxzYMWQ9dH2t2sqxOY2FcDypj/rOZybWOe2w2KgOHLmmEZUCArRsTM
	 i56SxSJullUWg==
Date: Sat, 9 Aug 2025 13:51:49 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Denis Aleksandrov <daleksan@redhat.com>
Cc: peterhuewe@gmx.de, jgg@ziepe.ca, linux-integrity@vger.kernel.org,
	Jan Stancek <jstancek@redhat.com>
Subject: Re: [PATCH] tpm: prevents local DOS via tpm/tpm0/ppi/*operations
Message-ID: <aJcoRcTo_PaGBbKF@kernel.org>
References: <20250702202851.33344-1-daleksan@redhat.com>
 <aGW2wabMXtdBEQxR@kernel.org>
 <CAG+gbFfKLCQND-TT8DEZ09T=Nhb39_CJfM5imv341Pen03bHjw@mail.gmail.com>
 <CAG+gbFfLP1Y=HgRfzjhT4uJ121keQ0ZKo=4saB3uqnZYyoV8JA@mail.gmail.com>
 <CAG+gbFcgfZALHCAxaMmWkNQX2sKgkc-HBJrYXdmehsqLidG_tA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG+gbFcgfZALHCAxaMmWkNQX2sKgkc-HBJrYXdmehsqLidG_tA@mail.gmail.com>

On Fri, Aug 08, 2025 at 02:32:02PM -0400, Denis Aleksandrov wrote:
> Ping.
> 
> Just checking in on this patch.
> It has received a "Reviewed-by" tag, and I was wondering if there is
> anything else needed from my side for it to be picked up.

It's my bad I'll apply this next week!

Sorry!

> 
> Thanks,
> Denis

BR, Jarkko

