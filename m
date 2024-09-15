Return-Path: <linux-integrity+bounces-3587-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC1B1979555
	for <lists+linux-integrity@lfdr.de>; Sun, 15 Sep 2024 10:09:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 849191F23483
	for <lists+linux-integrity@lfdr.de>; Sun, 15 Sep 2024 08:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 183AF768FC;
	Sun, 15 Sep 2024 08:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="Q56alLRj"
X-Original-To: linux-integrity@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A443EA83;
	Sun, 15 Sep 2024 08:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726387703; cv=none; b=tMrWIeIA+t2byC1Zz6i0M9Q6laWV4tOAjYa7pyzT9cXAkW082du56YOqFTQbB8XCvhYC6lxa8ZdrsQVhshMIkL5YWrNluRMRE7wYjtdmGkbWy9hSLcEbbq6aK5fslJXJG9kXck5aYcQrRpdR1vxrPmDnm0hmk70Wub7F2nitN9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726387703; c=relaxed/simple;
	bh=r92Bf7xVtngzQHui2J95febW1US8tRSTwQNcYBrkL8M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dFLp3pQ/4jwjBGRMsLeAa3fpiqFTpfcQiT+t5w0JIb/5qmhXoJQtngl5mjfcPZHhTSVFeQsvcaFo9IPAOsHux6hyIyRzawkIONSFFOtuPir4eQF1tHc91PcVOoRFx8Hd7CxvI3p+I0yQrvHRmqBXUGONq+YDxbNWNxsBYTKWk2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=Q56alLRj; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=tmmYr7AUv+WyGTIFQO0zZ+SlHsGUZCWusRU4ymvvKec=; b=Q56alLRjfdJQXvhTz2ZuTxLFO8
	We8liIyQouHmCyvHCuGoRb7A05ROGYXAryVOwBFAxpNQ0iQGkpG/wwko8gELPjeHr7z6zg20yv1AX
	vKDiUIMRpTfgJ8uuzzmcH4NnS8/cWz7PAVGgaLru/HJQd9x/Hl9aZHBW7PFymF/nuPdMU1BElNw6y
	4+HqKlMNnKu8HAZhTti4biUrKiMo7ESvnyNsg08kIIVGtzmHsh03+j4MrDui2fv/KjX3O2BhkBEfd
	IzYeGm48EnzjqhyAfdlGETMnymHBCkpinpIHiTegHRrbE1V8hSIqb6OhqQed6OyOAgxd7+DB5Yx6I
	N6dkNamA==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1spk8N-002b6A-1N;
	Sun, 15 Sep 2024 16:07:42 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 15 Sep 2024 16:07:41 +0800
Date: Sun, 15 Sep 2024 16:07:41 +0800
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
Message-ID: <ZuaVzQqkwwjbUHSh@gondor.apana.org.au>
References: <ZuPDZL_EIoS60L1a@gondor.apana.org.au>
 <b4a3e55650a9e9f2302cf093e5cc8e739b4ac98f.camel@huaweicloud.com>
 <CAHk-=wiU24MGO7LZ1ZZYpQJr1+CSFG9VnB0Nyy4xZSSc_Zu0rg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiU24MGO7LZ1ZZYpQJr1+CSFG9VnB0Nyy4xZSSc_Zu0rg@mail.gmail.com>

On Sun, Sep 15, 2024 at 09:11:04AM +0200, Linus Torvalds wrote:
>
> So honestly, just the series adding pgp key verification I have no
> objection to. The use case where some firmware uses pgp to validate
> allowed keys in EFI variables etc sounds like a "ok, then we need to
> parse them".

The use-case for EFI variables appears to be invalid:

https://lore.kernel.org/all/CAMj1kXH8nWtAzX+9xc2tLyy5d0w==JNQCMJBAbL=LdcF+XrYkw@mail.gmail.com/

> The objections I had were against the whole "start doing policy in
> kernel", with what sounded like actually parsing and unpacking rpm
> contents and verifying them with a pgp key. *That* still sounds like a
> disaster to me, and is the part that made me go "why isn't that done
> in user space together with then generating the fsverifty
> information"?

If the aformentioned EFI use-case is bogus, then distro package
verification is going to be the only application for PGP keys in
the kernel.  

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

