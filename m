Return-Path: <linux-integrity+bounces-5626-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 503FFA7D366
	for <lists+linux-integrity@lfdr.de>; Mon,  7 Apr 2025 07:20:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0046B7A358D
	for <lists+linux-integrity@lfdr.de>; Mon,  7 Apr 2025 05:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 093421519B4;
	Mon,  7 Apr 2025 05:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="TDOGr6V4"
X-Original-To: linux-integrity@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FAF31459F7;
	Mon,  7 Apr 2025 05:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744003209; cv=none; b=n2Yx4ByRZTnhgLnQNKccttnkD9Ln5OGHw73wh5dRyTvbS0N8MP4MWSw2BQ+Wd5vRf69pieXVQXxgcqWZeVvaEdHA+VroD66OzK0sNwPJYVi1Yh8RAGfGPhPwriqRDbPQWssdzh3UvQOcKtlHseClaNwRhEabSQ16XDd4HeLUlY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744003209; c=relaxed/simple;
	bh=M608t4hJxr1CHtdadEVr/FC3gOZlbuF96qFTH4vDJJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=opqIh5xW5FESX2c9W9Cy5iT6xwHViZLFgtKWQQ6MQvEbWbKmRACK6vbLBrCvx2lGqie3cnpaU1O/J/zlH/cFfzO1zAOkCcBrGR4vCOyZtxtToil1naab8PjO54FqisEkH/jUxffca2AHdZOA6FpthdL1NgxaLN47swvu8ovjTqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=TDOGr6V4; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=AJenKpW75W3oexLBoSfKE/v3zcUbXiJ/Y1vTb89xR2o=; b=TDOGr6V4qs/490kGWtkyA/CFw2
	NCYEIzIEt4kYf2VRB69638cd7uEgnkdIivksle558CTnFkpEOA4yjKHJYINLAXkd0goVjB0yofBiE
	zYtIBvi78VYubekUAhMKSB7l+Cm68wUxc3NdMK3T2NOWiIfNk2/nqOWt/jTbpxFuCGsIeIg4GnEEq
	0WWDzTpT3EzWPkfxc33tHEE1xmbzNbEq4v5Jd4blfxolo/wMA9iTzHBcfvAj+IQa5kLVEHnwWtypG
	wOLiphAq4FUqBo53ALeGKpurzKZPt9AL7JdmFb9dwWJQ6sz4Tb/yk1Mca7JkJjMqAXuRoA8wdRk9X
	LiAPkpwQ==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1u1eth-00DNH0-32;
	Mon, 07 Apr 2025 13:19:50 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Mon, 07 Apr 2025 13:19:49 +0800
Date: Mon, 7 Apr 2025 13:19:49 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>,
	Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
	Guangwu Zhang <guazhang@redhat.com>,
	Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	linux-integrity@vger.kernel.org
Subject: Re: [PATCH] hwrng: core - Add WARN_ON for buggy read return values
Message-ID: <Z_NgdRHuTKP6JK--@gondor.apana.org.au>
References: <ZvEFQAWVgWNd9j7e@gondor.apana.org.au>
 <D4DI1M1ELFXK.2COGZN6O5HABD@kernel.org>
 <ZvE0NrOC00ojRe3t@gondor.apana.org.au>
 <D4DQJ34I5FSD.1K618VWEKI7IW@kernel.org>
 <2024092340-renovate-cornflake-4b5e@gregkh>
 <ZvHsh6by3omeYj9d@gondor.apana.org.au>
 <D4EN54C1IK1R.11JD66L931PD8@kernel.org>
 <D4EP817NLQY9.35RSWO8IFXRL0@kernel.org>
 <ZvX_Zj8PAXcFJPLU@gondor.apana.org.au>
 <58aa06044c8b570791a92a1a2a9062b9a477e246.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58aa06044c8b570791a92a1a2a9062b9a477e246.camel@kernel.org>

On Tue, Oct 08, 2024 at 02:28:27AM +0300, Jarkko Sakkinen wrote:
>
> I guess it is TPM2_StartAuthSession returning TPM_RC_VALUE. Probably
> James should look into this as the bus encryption code is clearly
> tripping here.

OK I've just got a confirmation from the lkp that the tpm RNG is
indeed buggy:

https://lore.kernel.org/oe-lkp/202503261331.d388f82a-lkp@intel.com/

Quoting from the kmsg:

kern  :err   : [   28.766528] tpm tpm0: A TPM error (2307) occurred start auth session
kern  :info  : [   28.775547] resctrl: L3 allocation detected
kern  :warn  : [   28.777572] ------------[ cut here ]------------
kern  :info  : [   28.780433] resctrl: MB allocation detected
kern  :warn  : [   28.785745] WARNING: CPU: 46 PID: 576 at drivers/char/hw_random/core.c:188 hwrng_fillfn+0x19c/0x1f0

...

kern  :warn  : [   28.891243] RAX: 0000000000000903 RBX: ff110001077f6760 RCX: ffa000000ecb7e57

So the return value was 0x903, way bigger than what we asked for
(0x40).

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

