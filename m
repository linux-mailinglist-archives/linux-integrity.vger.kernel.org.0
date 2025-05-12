Return-Path: <linux-integrity+bounces-6181-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B97BBAB36B1
	for <lists+linux-integrity@lfdr.de>; Mon, 12 May 2025 14:08:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10361189802E
	for <lists+linux-integrity@lfdr.de>; Mon, 12 May 2025 12:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A111625A2D5;
	Mon, 12 May 2025 12:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="TnRHSu2m"
X-Original-To: linux-integrity@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A76A8467;
	Mon, 12 May 2025 12:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747051647; cv=none; b=mAHsuig9Retz0tQu7LHWgcYpXQhw6KVTO9atSfdWZly1hgDfEXvCbHiaFZkd3Q0uEDn5oXQyDdbh9IfxB/wRi9lSxCsm8Cq9+t85oxVt3sghSDLCSxACIOjlgz7WXuAHb873H1YsohCnymPQbPa7X6uSamKzzIwC8iBsIr6QK/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747051647; c=relaxed/simple;
	bh=KEjnsHJTmV1Z4TWl36W98Srw4qW/9+nB64i8XHrY+8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ultg1JvPtypZpKB0hLX6+XnSV503LHPzy3wZJAloo1wp+ZAUoVcIn0rorpPZBlPBCVdtAyp+bBCCzNDkuq4/QF/V8RD6vHVDuqbpUBezYu4nocbt3uCD4E2pla2sGNMedlsbCny3nEakWFdfvCMvZKxSY/w86iMsJml+o2xCn7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=TnRHSu2m; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=Wvqa5iFzwoYyuZu2VdHRzgext+bLynWvV5+GUQyFRrY=; b=TnRHSu2mATXBeJT00uezEeqYVI
	TO5gkH+uHoW0oWdOHMPsFCukcGg3I5VR03pJLs81onR/dy+qr2yDRxlTWirhMsYfHs122uQlUtHHI
	VUl0r41DAWTb/uxoBdSx8PURa/pVywgUGIyEYMyxV3A89QcximCXjvHUlBy0SCkkRO9MfotL6NgLV
	T+rqSjIRbGBgCAePdtnfBf9qQVTywnp0olEJTLmMgfzQIO8j2yYAPuIB2DtPKZGZ1rbJC/t3UzDd3
	XSyS2UDY5PDytLKXtAEsKqNoAns5EbLthN2NlohhVzPbatOAtxVSVL5sBkX11stQsxHeeml6ratIV
	/DzNaq6g==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1uERw7-005Rw5-15;
	Mon, 12 May 2025 20:07:12 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Mon, 12 May 2025 20:07:11 +0800
Date: Mon, 12 May 2025 20:07:11 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: David Howells <dhowells@redhat.com>
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
	lkp@intel.com, keyrings@vger.kernel.org,
	Lukas Wunner <lukas@wunner.de>,
	Ignat Korchagin <ignat@cloudflare.com>,
	"David S. Miller" <davem@davemloft.net>,
	Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: Re: [v3 PATCH] KEYS: Invert FINAL_PUT bit
Message-ID: <aCHkb1CYXkIKNl4K@gondor.apana.org.au>
References: <aCHeoSBOLF-mcY7I@kernel.org>
 <aB3OsMWScE2I9DhG@gondor.apana.org.au>
 <aBccz2nJs5Asg6cN@gondor.apana.org.au>
 <202505091721.245cbe78-lkp@intel.com>
 <1960113.1747041554@warthog.procyon.org.uk>
 <2020395.1747051310@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2020395.1747051310@warthog.procyon.org.uk>

On Mon, May 12, 2025 at 01:01:50PM +0100, David Howells wrote:
>
> I can do unless Herbert wants to pass it through his tree?

I have no desire to do that :)

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

