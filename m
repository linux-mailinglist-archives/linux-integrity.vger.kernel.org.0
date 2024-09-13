Return-Path: <linux-integrity+bounces-3554-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F35AB977BC0
	for <lists+linux-integrity@lfdr.de>; Fri, 13 Sep 2024 11:00:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38C8B1C21DBE
	for <lists+linux-integrity@lfdr.de>; Fri, 13 Sep 2024 09:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C2FC1BD4FF;
	Fri, 13 Sep 2024 09:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="nNSGyQU8"
X-Original-To: linux-integrity@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8065D80B;
	Fri, 13 Sep 2024 09:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726218047; cv=none; b=PVoK63lrWno2lcu/+Vfg2i/4/WnvxqMhX1ExCa//qkutaUD+uIM1WkkQM2h/KcUc3h9/zNv0GXxf7fBFY+JImmNkI+6s9sCcPNuylaV3yTtQIR2AhtjKIZ3RgGzAHauI3S451aSce+QXdNvRyrQmbo1Qsdml9jugnqI+TOphn00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726218047; c=relaxed/simple;
	bh=9mwIPwycXYHl62D/Pxz4s9W4RXPDCPT8rj1Dc6NWpT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iKa//rXlHqXsEeO/mhcdbf0Kg7w6D7tVrl2eTWISgNaUIlzQues5F5ClPW6EopEEkeYtiqbW8TeIhAgxh77m2TwnzFl+SdAFr9kYGRi4ozjWGikEQB+YUewhDkGh3tfgUtNlfm902UkD2mMymrnfG+0JNipM1ZtFUVa0Nu+WezI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=nNSGyQU8; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=CXayANdcDzJbMK17VtTXzWOx42S2gU6Wscove87433E=; b=nNSGyQU8+aBaLQuObtYnyCHjIe
	a73fgw1TGGfEOW0tWCrWDpxhe2U6nAsuPzYDXFlFSOAY0X7krSAjLo+1kJzijEeIAQq+yRvekNNhn
	NBXLLMuA5DC7Uxix6+LwP2pJxTpqp/4Cbe8k0rvP7CFJbG7KLuzoB5S/Lruqu9cn8GZIRascFZ807
	/rv/SOAi9FZnJeoAg72CMicOXJZQRDVDwmDrRYIju5zHNd7y6jU3V6QlZpvobi6rp9q26JG1ju0U/
	guMYikBaMF9DLhmXk+prSWGDE3eUBF8JJ2rxx00ogOh+uk2xhb+dGfnxRjEUrWTaCTeOV/FRJ6NC9
	jZ7M2EOg==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1sp209-002CSQ-1H;
	Fri, 13 Sep 2024 17:00:16 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 13 Sep 2024 17:00:15 +0800
Date: Fri, 13 Sep 2024 17:00:15 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: dhowells@redhat.com, dwmw2@infradead.org, davem@davemloft.net,
	linux-kernel@vger.kernel.org, keyrings@vger.kernel.org,
	linux-crypto@vger.kernel.org, zohar@linux.ibm.com,
	linux-integrity@vger.kernel.org, torvalds@linux-foundation.org,
	roberto.sassu@huawei.com, linux-security-module@vger.kernel.org
Subject: Re: [PATCH v3 00/14] KEYS: Add support for PGP keys and signatures
Message-ID: <ZuP_H2V60PlrCz4x@gondor.apana.org.au>
References: <ZuPDZL_EIoS60L1a@gondor.apana.org.au>
 <b4a3e55650a9e9f2302cf093e5cc8e739b4ac98f.camel@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b4a3e55650a9e9f2302cf093e5cc8e739b4ac98f.camel@huaweicloud.com>

On Fri, Sep 13, 2024 at 10:30:11AM +0200, Roberto Sassu wrote:
>
> The second problem is, assuming that the task is verified through other
> means other than PGP (but again, we are still relying on the public
> crypto functionality to be performed by the kernel, for this to work),
> that I didn't get a confirmation that user space can have equivalent
> isolation guarantees as the kernel:
> 
> https://lore.kernel.org/linux-integrity/eb31920bd00e2c921b0aa6ebed8745cb0130b0e1.camel@huaweicloud.com/
> 
> 
> Please, keep in mind that I already proposed what you suggested:
> 
> https://lore.kernel.org/linux-kernel/20230317145240.363908-1-roberto.sassu@huaweicloud.com/#r
> 
> 
> After discussing with some kernel developers, the outcome was that a
> better choice would be to put the code in the kernel, if I want
> reasonable tamperproof guarantees.

Where is this discussion? I clicked through the two links above
and everyone seems to agree that putting it in user-space is a good
idea.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

