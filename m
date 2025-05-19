Return-Path: <linux-integrity+bounces-6250-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0529ABB7F0
	for <lists+linux-integrity@lfdr.de>; Mon, 19 May 2025 10:53:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A57143A9D87
	for <lists+linux-integrity@lfdr.de>; Mon, 19 May 2025 08:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DB6D26AAA5;
	Mon, 19 May 2025 08:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="kTCQRPtw"
X-Original-To: linux-integrity@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3396026B945;
	Mon, 19 May 2025 08:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747644756; cv=none; b=JAN7oXv4+ADndrPIvXetVMKMcpo52B/SafwAvfsZYuQaG/+BTGjhR8U2TmLhPQnLUsNORSkUj7UXqbYGoh7Ibukt+pXM5zSbgUHkjUrPk/cTehjbGQbAZhP2w9bMIseOWT2vghw6wkZZD4QzPvgb26KzJjbISbu9e30B9UXDQxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747644756; c=relaxed/simple;
	bh=o+BZPG4HTZQK5EkR2i0e4H+wb4OBpw813r8SfpCwT3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sPUctsRgkrtKgoWoHbiNZuTScMMpGp8Q9xBodQdiH0e9hl+rOaNnFjYc91X3HjF3PW6kOU+Dw2KrXgpOZw5vWqRpzeYe1mHP/8ihWmXkvzf/CfxI7DjzqkcRmoqJ3ZUGiR8wDJZcJtF7iFCGXROe0N42TeaOoOUAGGFLmnsV0Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=kTCQRPtw; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=aaNx/UBvPW/YAYr0J1BIkqiBjr95NNZeumZcA+4ymxI=; b=kTCQRPtwfuFvm9OJ3H1cm9ouO3
	y58FRaskcdaaszyHlbNuQqIlPUE2LbURQxvbh5rf42byuVpSMnNmcK4qhG2RPpGa/yV4wWUIdmPX4
	uMSHhCejCsjCFpHEiYgrYpH2f01zdUzHB1IM2DnjiaUqYcQ2zAN4nuNwCXISG8U0VPgpDPsyWNJX0
	q/Z2uM9/zLKKd6re6IM9hTg3kFmmndmoiBfdWdf612PPbs6sgowHXpqa+FYwoJ10SdxeMnOGOZhXH
	sJnmP/IQK8xGcjgjPxTLlOW1J2AZfDD6lrKlIfcxDqN3UVDdTiPWavTHVtoc8naqgrodZ28FRrvgu
	tn+a4Dpw==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1uGwEM-007B3M-2v;
	Mon, 19 May 2025 16:52:19 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Mon, 19 May 2025 16:52:18 +0800
Date: Mon, 19 May 2025 16:52:18 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Qunqin Zhao <zhaoqunqin@loongson.cn>
Cc: lee@kernel.org, davem@davemloft.net, peterhuewe@gmx.de,
	jarkko@kernel.org, linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev, linux-crypto@vger.kernel.org,
	jgg@ziepe.ca, linux-integrity@vger.kernel.org,
	pmenzel@molgen.mpg.de, Yinggang Gu <guyinggang@loongson.cn>,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: Re: [PATCH v9 2/5] crypto: loongson - add Loongson RNG driver support
Message-ID: <aCrxQqo1UYdNdt8l@gondor.apana.org.au>
References: <20250506031947.11130-1-zhaoqunqin@loongson.cn>
 <20250506031947.11130-3-zhaoqunqin@loongson.cn>
 <aCrIL_ZXL-UtaLdJ@gondor.apana.org.au>
 <96118a23-3e6c-c9d1-2135-bd7a22091f35@loongson.cn>
 <aCrqPnwr7lMJNOnL@gondor.apana.org.au>
 <9d70efaf-1d68-f8e5-d9a6-cd312fc99529@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d70efaf-1d68-f8e5-d9a6-cd312fc99529@loongson.cn>

On Mon, May 19, 2025 at 04:49:45PM +0800, Qunqin Zhao wrote:
>
> Is it fine waiting in init-callback until someone calls exit-callback?

No that's just as bad as failing.  Remember this is exposed to
user-space through af_alg.  If you make it wait it'll just appear
to hang for the user invoking this.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

