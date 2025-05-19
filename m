Return-Path: <linux-integrity+bounces-6248-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13D13ABB712
	for <lists+linux-integrity@lfdr.de>; Mon, 19 May 2025 10:22:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B06D4162645
	for <lists+linux-integrity@lfdr.de>; Mon, 19 May 2025 08:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23359269816;
	Mon, 19 May 2025 08:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="QbUzQJfI"
X-Original-To: linux-integrity@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 268BF61FCE;
	Mon, 19 May 2025 08:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747642965; cv=none; b=FwhtyGaQL9A4JyFyseo30P2fQ+Y8rLHOxcmQRoWqCFmVUWD8BnrQ65hOPpdPk1OPbZrjl5Xs2gVlbWzGgr2S7k9mxwgnsGEX3nFKgRednWPx/411/9Mhs0fRTHskoxHVOfjX5B7OfDsRwEY/kn/7B+0V1CyZ/YFSbJRlFYmf/Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747642965; c=relaxed/simple;
	bh=fOARuwJzXYeYMDLcDBKObUTcV6ulRKBuIUklxVxYFl0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ohdkcfu+N/4hfjR/Jew+iRr9iv822+Wy14dYzpqY5mVGE5KCFzhSIL5NwRFLAXFAN0X6HgXemVkVVMxrGqhzausGur5ppTiUZz5MbrB0l+vaLo8vGwrxsrW2baT35DMHT97lUZiRsalKoHqWrlkjGoxWeAvC5zBwn0miN+fVN6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=QbUzQJfI; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=K14uVw/25ceXFLFWjceKuc5mfUTfV5FjYiooNcf+w8c=; b=QbUzQJfI+vRCpnbQj4U3KOVX2W
	oRfgSQsNURewOz5oH13CVb6wKChRl3Pj04ybzFDBHkfNT/6c7UPnyZ7gBLqJ0vwAlnxQfwFBibwcC
	ZMtSOlQoTn7OQ3gclw7L7TOehBeN4nCGNrcvFyetnL119YjLluha1IsWZw/0ADxYtmh+4jBeJw/4h
	90l78l4KlZNRVHACgSbesjFZl71k4xqoZLmD6WxIGiMj7Rw7mhW9BWZsO4geSjJkDa3Kloa3Ana2/
	ApiIseSHcdWKfTTdxbLRD3clAXPa57rNEF+Ykbnx7UxUbs+xrupBgj2plYQxN8n6b4wTaC6yaFJza
	GCdXIfjA==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1uGvlO-007AAf-21;
	Mon, 19 May 2025 16:22:23 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Mon, 19 May 2025 16:22:22 +0800
Date: Mon, 19 May 2025 16:22:22 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Qunqin Zhao <zhaoqunqin@loongson.cn>
Cc: lee@kernel.org, davem@davemloft.net, peterhuewe@gmx.de,
	jarkko@kernel.org, linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev, linux-crypto@vger.kernel.org,
	jgg@ziepe.ca, linux-integrity@vger.kernel.org,
	pmenzel@molgen.mpg.de, Yinggang Gu <guyinggang@loongson.cn>,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: Re: [PATCH v9 2/5] crypto: loongson - add Loongson RNG driver support
Message-ID: <aCrqPnwr7lMJNOnL@gondor.apana.org.au>
References: <20250506031947.11130-1-zhaoqunqin@loongson.cn>
 <20250506031947.11130-3-zhaoqunqin@loongson.cn>
 <aCrIL_ZXL-UtaLdJ@gondor.apana.org.au>
 <96118a23-3e6c-c9d1-2135-bd7a22091f35@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <96118a23-3e6c-c9d1-2135-bd7a22091f35@loongson.cn>

On Mon, May 19, 2025 at 04:13:14PM +0800, Qunqin Zhao wrote:
>
> Then the HISI TRNG driver isn't a right demo?

Yes the hisi trng looks wrong too.

> This can also avoid concurrent access to a device, otherwise i need to
> 
> add mutex_lock/unlock in generate and seed callback.

Randomly failing the tfm allocation is not a solution to resource
control :)

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

