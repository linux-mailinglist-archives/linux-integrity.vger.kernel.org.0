Return-Path: <linux-integrity+bounces-3589-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E552E97961F
	for <lists+linux-integrity@lfdr.de>; Sun, 15 Sep 2024 11:16:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8A6A281F98
	for <lists+linux-integrity@lfdr.de>; Sun, 15 Sep 2024 09:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEFDC1C4604;
	Sun, 15 Sep 2024 09:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="q/NcMNKM"
X-Original-To: linux-integrity@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68FB2198A03;
	Sun, 15 Sep 2024 09:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726391769; cv=none; b=g97WLYl0W5tZFzqbBPYaQXSOdKRugugjTlLUCWcZk8FVTtt8RGC6bMtCmI5eIrZNyckuClrvE7xX++I5jT9eDSvKNl4VXzMwowhFJxfIiaZk2WXvGF9lxDBYQeIkLckzobc2zwZF64W/MIH8pXLmbnw0XbiOZXwfByaH/wMX3gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726391769; c=relaxed/simple;
	bh=ET7pk3ktMsIJXoyB4EtALp5wAErV+ZXY2YQcO9+O2Vw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F2Ob2g+PnqlESImIhmXJuhTsJDJ2i2q5Mw4FvFRhSjJ+ywkq0zOgM6EknOaC3g60MDos2gk20Ya/DLK0r13IvzSTEq7FzDTv+HXaI8IkPr2NtL5pQr/1ORhh4goIB5wnUngOKkij7CKW10c8MvyFq4NYYyRyGNgz5Z1Psa+n7xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=q/NcMNKM; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=Yvxu77mKMadwj+nJKyK3lHmuRQEqDZ8tD9FJrJgQs2g=; b=q/NcMNKMSUzk5TbUgKIgE3dBYk
	4dvuFfvoTSTtN0wRJij2EQKOyYVUQyUXqmA7RKDJxEMYOqNCZ5I8LsyWMBwylQNY9EuYkSAcY0irW
	z6Z/+kbJWRpWr/1cv9oHyKmONGbEPTe8UZXfa3OBhvLbFxj/1py+iDZn/fvaNj7QmTlfsdBOfDVem
	s8vnPRlfeqYkhzr1AgxqknfqeM200GQLaQneY9sLHxrciEcPH8KJ3xlI9EVyNEjTOhzVwo/N9F6Yx
	DFlNRvJ+UFbKSNpEt+HpBiCtp9KtUkXS3iuPPaLBe/HcYlL+/JIp3Y4x8xipVN0MY13Tu01DRqub/
	/6VwRleg==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1splBv-002bhN-1o;
	Sun, 15 Sep 2024 17:15:26 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 15 Sep 2024 17:15:25 +0800
Date: Sun, 15 Sep 2024 17:15:25 +0800
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
Message-ID: <ZualreC25wViRHBq@gondor.apana.org.au>
References: <ZuPDZL_EIoS60L1a@gondor.apana.org.au>
 <b4a3e55650a9e9f2302cf093e5cc8e739b4ac98f.camel@huaweicloud.com>
 <CAHk-=wiU24MGO7LZ1ZZYpQJr1+CSFG9VnB0Nyy4xZSSc_Zu0rg@mail.gmail.com>
 <ZuaVzQqkwwjbUHSh@gondor.apana.org.au>
 <CAHk-=wgnG+C3fVB+dwZYi_ZEErnd_jFbrkN+xc__om3d=7optQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgnG+C3fVB+dwZYi_ZEErnd_jFbrkN+xc__om3d=7optQ@mail.gmail.com>

On Sun, Sep 15, 2024 at 10:40:15AM +0200, Linus Torvalds wrote:
> 
> So I haven't actually seen _that_ series, but as mentioned it does
> smell pretty conceptually broken to me.
> 
> But hey, code talks, bullshit walks. People can most certainly try to
> convince me.

Roberto, correct me if I'm wrong but your intended use case is
the following patch series, right?

https://lore.kernel.org/linux-integrity/20240905152512.3781098-1-roberto.sassu@huaweicloud.com/

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

