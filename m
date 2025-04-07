Return-Path: <linux-integrity+bounces-5625-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48442A7D2C8
	for <lists+linux-integrity@lfdr.de>; Mon,  7 Apr 2025 06:04:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01C64188C352
	for <lists+linux-integrity@lfdr.de>; Mon,  7 Apr 2025 04:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95B65213254;
	Mon,  7 Apr 2025 04:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="az52eJGC"
X-Original-To: linux-integrity@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40E2288A5;
	Mon,  7 Apr 2025 04:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743998658; cv=none; b=ftDWYt8HagxtAiYDfumBQmNu79njeD6pcHS0ZwHypecjuJR6fzmGzg1B7PDDe6kqSGXcr1YqBui554fVz7A+OiYpQfTthybQvKP9aIELh/1/69mKsI9hZdrCWdkgL/FPKXxYxqNnNMZsVq7ZD+Z+WIKrudgKEclkRqCNj12xlZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743998658; c=relaxed/simple;
	bh=VM/og/6XH+FOo7D67EndDs1WE/rzLn8BFLNpxXdlQIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fLcPZ5DewdUeZSA9XQZWYckLXq2Nf/JDFiGmrSGk62atruArshyZyQRwXoiVNEPyogvz72XVDeRSKp98i36WDFyZa6GdbEmk9CQ7Hs4ihvYy1vqJv5xoFhYpSQl1dyERH/8Y+4GAIioruGfnjhzQ04FL4UeV7srT/8cYVzIFvWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=az52eJGC; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=ba762y6cM1tm8SLlWPO9vBwiqhYzKrzCmC+4ExJ9nuM=; b=az52eJGCie8uw57DU3q+ZJXBUP
	kil8pJ3KG2x7dxer5cBr6od6JB+/QHiDBDYr04482hX2kyUb6Fx20RjI4DEk+2cGl/wdbm8Dcfvmm
	J4sdzVWLKvNzHkikL7hdB76P5Q6pK09C+dJz9214TVdRyqtcXpmPZQjKPVDQXyxFQo6S2xDRA0clR
	9wmOZm9fTMqJWKzSuFQr3P34xH9gZMkY55LU9kuSZVBjsJwXYaYLXc4se5Ytfn1SeY7W4DkjZ280a
	yjS/jkmTjOvr8YF7xKM5LKCMw3mzSSPXet6Rqk3Hes7Qdo7Ee7DYtTCcsaqKcd/H3o79xkumW6U1J
	8cXVv+Wg==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1u1diL-00DMUa-31;
	Mon, 07 Apr 2025 12:04:03 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Mon, 07 Apr 2025 12:04:01 +0800
Date: Mon, 7 Apr 2025 12:04:01 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Qunqin Zhao <zhaoqunqin@loongson.cn>
Cc: lee@kernel.org, davem@davemloft.net, peterhuewe@gmx.de,
	jarkko@kernel.org, linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev, linux-crypto@vger.kernel.org,
	jgg@ziepe.ca, linux-integrity@vger.kernel.org,
	pmenzel@molgen.mpg.de, Yinggang Gu <guyinggang@loongson.cn>,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: Re: [PATCH v7 3/6] crypto: loongson - add Loongson RNG driver support
Message-ID: <Z_NOsSBRWUEToa7_@gondor.apana.org.au>
References: <20250403024645.4427-1-zhaoqunqin@loongson.cn>
 <20250403024645.4427-4-zhaoqunqin@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250403024645.4427-4-zhaoqunqin@loongson.cn>

On Thu, Apr 03, 2025 at 10:46:42AM +0800, Qunqin Zhao wrote:
> Loongson's Random Number Generator is found inside Loongson security
> engine.

Is this a hardware RNG or a pseudo RNG? If it's pseudo, it should
provide a means of reseeding.

If it's a hardware RNG it should register with hwrng.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

