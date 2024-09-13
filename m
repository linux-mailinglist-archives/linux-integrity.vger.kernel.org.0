Return-Path: <linux-integrity+bounces-3552-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E83977810
	for <lists+linux-integrity@lfdr.de>; Fri, 13 Sep 2024 06:46:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 096A62877FC
	for <lists+linux-integrity@lfdr.de>; Fri, 13 Sep 2024 04:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18DAC13D245;
	Fri, 13 Sep 2024 04:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="A9FV5gEh"
X-Original-To: linux-integrity@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E93637;
	Fri, 13 Sep 2024 04:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726202764; cv=none; b=A43DHDO8HErgJACkmcq/hA1wmbKPZB+Wwkprdz4TisZsaYAeAusvSnKKczOo7h+FuSYe8RGfbr5UYCEopk2RrQIzrxotUSkl0zphYqPc45QMfXXi8sWxr3MRdkPFvhOACRgCX3CFbMF3L+ToDcXKzS9b7qrj2oPPllr0vNIZb/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726202764; c=relaxed/simple;
	bh=yyoIqgIg15uCi2l4PuwWGUguQNkSR5mhnUvlu+Fg9aA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=YQDiwOmTA0MiV+DinG/55opB14cWn1IjfHpFPICzWY7C7BR9n6JIFj0QNdz/9nB207gPx6cn6Uk/DyoLHFvL+JBlwD7SFXCVQUHR/lZsgYnvf7INvg3ArN9ZvcpC9fAnmg+iCRDLGYAGstahc2/OUY7xfAfGxWU49SUkooq++qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=A9FV5gEh; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:Message-ID:Subject:Cc:To:
	From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=A0s2VVzFkU2smfywCESWrGyHM45MUn2C+xHrAF+P/h8=; b=A9FV5gEhj2Zloy+Anv1T7yTemx
	IYzsx/tLu/r3tvg25geX1t9WZhOeh6v8NgCeFMR1Tt/KgbgKrV4DeKRmgXQ/PjSWeW2Up13Y6/dOq
	ZJLDHZEUa8zcN9CwfQMY9OFCnNxtGaA2tZkFNvsCDNG1DSeGffalNAUOEgO2lQ/YTturkbLmQiJUo
	Xh4aPHoUsbbm6BOE4yDiuKbRH53voC2ZaMdb0A+uawFe/lK/s1AUDtQ5oUPHCxN58j/lJRvlqZEzi
	gDAw47uP2/0M/XuoDqoaORkdsyORyetXntZnFASOrtmy4a7yCA+BF/6GXmFuaC6yuGcvOAzrRbdOt
	1U01+KjQ==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1soy1X-0029r8-0w;
	Fri, 13 Sep 2024 12:45:25 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 13 Sep 2024 12:45:24 +0800
Date: Fri, 13 Sep 2024 12:45:24 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: dhowells@redhat.com, dwmw2@infradead.org, davem@davemloft.net,
	linux-kernel@vger.kernel.org, keyrings@vger.kernel.org,
	linux-crypto@vger.kernel.org, zohar@linux.ibm.com,
	linux-integrity@vger.kernel.org, torvalds@linux-foundation.org,
	roberto.sassu@huawei.com
Subject: Re: [PATCH v3 00/14] KEYS: Add support for PGP keys and signatures
Message-ID: <ZuPDZL_EIoS60L1a@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240911122911.1381864-1-roberto.sassu@huaweicloud.com>
X-Newsgroups: apana.lists.os.linux.cryptoapi,apana.lists.os.linux.kernel

Roberto Sassu <roberto.sassu@huaweicloud.com> wrote:
>
> For the envisioned use cases, PGP operations cannot be done in user space,
> since the consumers are in the kernel itself (Integrity Digest Cache and
> IMA). Also they cannot be done in a trusted initial ram disk, since PGP
> operations can occur also while the system is running (e.g. after software
> package installation).

Does this address Linus's objections? If not then we cannot proceed.

Personally I don't think the argument above holds water.  With
IPsec we had a similar issue of authenticating untrusted peers
using public key cryptography.  In that case we successfully
delegated the task to user-space and it is still how it works
to this day.

A user-space daemon dedicated to public key crypto seems equally
applicable to your scenario.

The original application that brought public key crypto into the
kernel was module loading.  If we really wanted to we could extend
the user-space verification to modules too and perhaps kick all
public key crypto out of the kernel.

The complexity and lack of reviewer attention in this area means
that we're more likely to introduce security holes into the kernel
with such code.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

