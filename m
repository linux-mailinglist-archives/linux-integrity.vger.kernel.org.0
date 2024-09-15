Return-Path: <linux-integrity+bounces-3590-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D7905979629
	for <lists+linux-integrity@lfdr.de>; Sun, 15 Sep 2024 11:31:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 558D5B21F9F
	for <lists+linux-integrity@lfdr.de>; Sun, 15 Sep 2024 09:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80C731C3F0E;
	Sun, 15 Sep 2024 09:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="Z07ZUWCD"
X-Original-To: linux-integrity@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4929F9FE;
	Sun, 15 Sep 2024 09:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726392695; cv=none; b=NJ8SiDPbAx4JGjtzKHK22igbj2qFhTVsiZl4rh30VeH9yXeh2+ngxBbTPw++//hQFBi3VTqUvT1GJXr0l3vcAhbng9W6PWoCEJwOhudHE1BZiG+jP40ScXX60F9t+l88lOa1hg9L5JdeEBF/+XEgfaV8wdZVR+/Pg3VRePOTJW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726392695; c=relaxed/simple;
	bh=yppjmLWuJ3670sLldCSPPm9d/33OxriK4GwJ9hrv0Mg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gmEYSEM1+WmYf9zLkW9L0Ox5MkhQWY7JvPv/pe2Fxboe2zmfrmEiszNiYSmCM+w93QTfvDA+Om/Y720ILK+osyK9HabwVDbyL5dJ8KC4Ia4kgUyVqL83B8Hr8MKxiC1EN2JaQ0lc4cc3oPGRy2g/KPR4cqPgESoSmcYgYdDK7mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=Z07ZUWCD; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=+eX5kV2Nmw0M6Y+JlJL5bjBjSaQL+XEI8lPe/DK8+pI=; b=Z07ZUWCDCfjii/QqB/7RFV8L4d
	VhBsg6Z6+PCpxqn6s917cG7cGWUf9jLOB+DW44IOhBQUHKAshoepC09x8bOw14B82gsUJdtmjarfU
	JBkSUlsIzyVOljZ9w6kgRwMIicn+hmqVKWsNXeAIlNRUH9bjcn5phETN8MN4leAIcCdchC0LZGXMo
	CLhyYiZ3suCOE78pufjIuR4BStYbMV9t3V/4GvZF8JLm1rRPEAtF30QFXFg6b+mLdKcA+v3+wOvOQ
	VQvTtA+eiIjhB56h8SZqJbt9x1ZgayEsM2CN2i85x82L8NSdNpaabs1eu9cCqszBYxm4brY1ni8Qg
	scfSsbAA==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1splRA-002bma-3D;
	Sun, 15 Sep 2024 17:31:11 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 15 Sep 2024 17:31:10 +0800
Date: Sun, 15 Sep 2024 17:31:10 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Roberto Sassu <roberto.sassu@huaweicloud.com>, dhowells@redhat.com,
	dwmw2@infradead.org, davem@davemloft.net,
	linux-kernel@vger.kernel.org, keyrings@vger.kernel.org,
	linux-crypto@vger.kernel.org, zohar@linux.ibm.com,
	linux-integrity@vger.kernel.org, roberto.sassu@huawei.com,
	linux-security-module@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH v3 00/14] KEYS: Add support for PGP keys and signatures
Message-ID: <ZuapXswFUxsFxjgH@gondor.apana.org.au>
References: <ZuPDZL_EIoS60L1a@gondor.apana.org.au>
 <b4a3e55650a9e9f2302cf093e5cc8e739b4ac98f.camel@huaweicloud.com>
 <CAHk-=wiU24MGO7LZ1ZZYpQJr1+CSFG9VnB0Nyy4xZSSc_Zu0rg@mail.gmail.com>
 <ZuaVzQqkwwjbUHSh@gondor.apana.org.au>
 <CAHk-=wgnG+C3fVB+dwZYi_ZEErnd_jFbrkN+xc__om3d=7optQ@mail.gmail.com>
 <ZualreC25wViRHBq@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZualreC25wViRHBq@gondor.apana.org.au>

On Sun, Sep 15, 2024 at 05:15:25PM +0800, Herbert Xu wrote:
>
> Roberto, correct me if I'm wrong but your intended use case is
> the following patch series, right?

Actually the meat of the changes is in the following series:

https://lore.kernel.org/linux-integrity/20240905150543.3766895-1-roberto.sassu@huaweicloud.com/

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

