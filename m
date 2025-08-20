Return-Path: <linux-integrity+bounces-6882-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F48AB2D1F9
	for <lists+linux-integrity@lfdr.de>; Wed, 20 Aug 2025 04:34:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A8142A63AD
	for <lists+linux-integrity@lfdr.de>; Wed, 20 Aug 2025 02:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69D2125D1E6;
	Wed, 20 Aug 2025 02:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="nLeBJWY2"
X-Original-To: linux-integrity@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E80E3C38;
	Wed, 20 Aug 2025 02:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755657245; cv=none; b=jK4BVIYRoqtg7CQ1dm5fgODj/S1CovdDHcm898klTCq5S/qlkCgZ7aaaM8nbelc1ASJjFJYxC5c1SEC0dT0l7leu0qWvczu6sRlMbcX6L7sn/a1j/xeHVewy8g+YOufuc5hBqKy1i1rbCMt+tSojNiS6hs75sHIQXe8KImF5M94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755657245; c=relaxed/simple;
	bh=+X3h4TnrVhf6EHsT3P84o1wsToV8YCq72tvSy02zTAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Su1cJeSLQJgU70rwY0GTYkjsIPSh228vhzGD7BvMPSi0Qkbf0QLOwsTrp6x1SoHIezrSkclHcwZX+xlWT40Jr/DdYD+EQIWo4gooLWdUYw2kEdLeUlYBdsmRwbhXtK44mcVSOgr/20sWd92oTT6HdhOwWMpzIoi1oEvRqd23P1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=nLeBJWY2; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=y1ZAIG759HT4OXoQdw5pPQnndkLX5MKjmdQRlmFJ9Ug=; b=nLeBJWY2LIS6dPbKblx48IwiFj
	5Fb9t/36mXHImYnz2DwyCnokR2F2dlwQlhpnum5C5bwMxAQp7sYaiMcygVNQ6n51/0kTWIe3fDsJE
	lOcEligUlSnNvBfBI3wXkTbRWALB0UcXWJijZrQhfsNMxND+PTVry/lpkTlQdBraLBsXqlqYCIauB
	8rH1zWBQjUOtH7bT+OkVNue0Cn5yj0Rl5I4j07m2h1Y2NhH+fQ+QUPGmf+pBKEFKLVPee07D5+4wp
	0rP/IhOsurafEX+y8TeSxTVDxLUjH2ktR/4+adw4T2pe2SpCo5POnxZSWGh3KWzby1D0gi/oLa5z9
	Y60jVL4Q==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1uoYOm-00FgcB-0i;
	Wed, 20 Aug 2025 10:33:57 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Wed, 20 Aug 2025 10:33:56 +0800
Date: Wed, 20 Aug 2025 10:33:56 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Lee Jones <lee@kernel.org>
Cc: Qunqin Zhao <zhaoqunqin@loongson.cn>, jarkko@kernel.org,
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
	davem@davemloft.net, linux-crypto@vger.kernel.org,
	peterhuewe@gmx.de, jgg@ziepe.ca, linux-integrity@vger.kernel.org,
	Yinggang Gu <guyinggang@loongson.cn>,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: Re: [PATCH v12 2/4] crypto: loongson - add Loongson RNG driver
 support
Message-ID: <aKU0FKgqRxTn_Zws@gondor.apana.org.au>
References: <20250705072045.1067-1-zhaoqunqin@loongson.cn>
 <20250705072045.1067-3-zhaoqunqin@loongson.cn>
 <20250819125518.GF7508@google.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819125518.GF7508@google.com>

On Tue, Aug 19, 2025 at 01:55:18PM +0100, Lee Jones wrote:
>
> This depends on the first patch in the series.
> 
> Does this one have an Ack?

I thought I had acked it already.

Acked-by: Herbert Xu <herbert@gondor.apana.org.au>

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

