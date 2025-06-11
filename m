Return-Path: <linux-integrity+bounces-6409-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D186DAD4FA3
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Jun 2025 11:24:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30CDC18979A1
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Jun 2025 09:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBF6A25B319;
	Wed, 11 Jun 2025 09:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="fIA1Ythm"
X-Original-To: linux-integrity@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0AE9221708;
	Wed, 11 Jun 2025 09:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749633836; cv=none; b=T9dQdChnRWuMLp23BncIUYbAhlx287gMY7LTCpUg9FlUFt2B7n0EWEklukOCPISvXI3imK4pWQa8psD6DIF5Hd2gXYpg1l+sZ7rNErKy2S8TWcOSYpGBNVEBRx/pwbbZRLqDZnUZ2WjLq9vprExhxszl+m9zem3Aap/Q+iKJ9kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749633836; c=relaxed/simple;
	bh=qKs2rXCD0kRLf2iapx2r9Tgv95LwvPC2wN8BZQGoz3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jzU3uKXagsPlkHITPNTYVuPuWKGTNTsNUbGHtn/ZnuymNJK0QihEtW7/a72VaCZsnzNhUZr5/VQcBz/1JpmQyzXnOyv461ALDugSVWq0SmQxh/zYcnd32x2HbtxFpOA0JKpeXuAQ+YbD5aLjOxAP7hY+wc1Q0Zhb6QEWralnTUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=fIA1Ythm; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=5MvjPaR0xlmnGQTOLXVKPuHYfW/FxurPRTBaqohXJ/o=; b=fIA1YthmoTPvZEC40yWITQnVfn
	lqFPz13KrKnFdT8nUh1UZc3ndvAgOfB9P7alUJPkx59jzIR2eFYFSIxbk7wTKRVUcep3NLJGJbmoN
	uGYoAG/cheINwFVkH5mXWzALvlppYwvg5BwRxOaGBbUiodeJ/hfD8h8XDl7wBd7gRGTdRie0zgGve
	4Grt9Qpp2opWJQ9T9eTU9JI60Ut+yCGz85qA6bcot7YyaFKL7lybgo1ubzAzPMvF45l0NBjMo8cFx
	dCD05c77hmS6kcH04RuKnwWNk1IVMmDUHeHBz/PCpL+TWnxwiWPzKHDdpZ1vYJfHObHrSKHTgWxtI
	au6EoLEw==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1uPHgT-00CJES-0p;
	Wed, 11 Jun 2025 17:23:50 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Wed, 11 Jun 2025 17:23:49 +0800
Date: Wed, 11 Jun 2025 17:23:49 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Qunqin Zhao <zhaoqunqin@loongson.cn>
Cc: lee@kernel.org, jarkko@kernel.org, linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev, davem@davemloft.net,
	linux-crypto@vger.kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca,
	linux-integrity@vger.kernel.org,
	Yinggang Gu <guyinggang@loongson.cn>,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: Re: [PATCH v10 2/5] crypto: loongson - add Loongson RNG driver
 support
Message-ID: <aElLJY9MnkEQx935@gondor.apana.org.au>
References: <20250528065944.4511-1-zhaoqunqin@loongson.cn>
 <20250528065944.4511-3-zhaoqunqin@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250528065944.4511-3-zhaoqunqin@loongson.cn>

On Wed, May 28, 2025 at 02:59:41PM +0800, Qunqin Zhao wrote:
>
> +	if (!rng_devices.is_init) {
> +		ret = crypto_register_rng(&loongson_rng_alg);
> +		if (ret) {
> +			dev_err(&pdev->dev, "failed to register crypto(%d)\n", ret);
> +			return ret;
> +		}
> +		INIT_LIST_HEAD(&rng_devices.list);
> +		mutex_init(&rng_devices.lock);
> +		rng_devices.is_init = true;
> +	}

This doesn't look right.  What stops two devices from both entering
this code path when is_init == false?

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

