Return-Path: <linux-integrity+bounces-2424-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8448B8C70D9
	for <lists+linux-integrity@lfdr.de>; Thu, 16 May 2024 06:14:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26947B22849
	for <lists+linux-integrity@lfdr.de>; Thu, 16 May 2024 04:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 584E1C122;
	Thu, 16 May 2024 04:14:28 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7479EB667;
	Thu, 16 May 2024 04:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715832868; cv=none; b=ekIk3DWRrL+ej9vRH42XacFw5rBG3J+Fp4n0bZQruSOO3hzoGSOWe/jMuSYE6Y0yAkT5PDoCVhi6/Ajq+maA5Tk/naeJ31t+pgYpD5VXhXyZAZ1/APJ6IVXmLlxMM4izICE1xY190J/Cy2ygF7jn3y09kOUPlShPIHCjBSFxk7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715832868; c=relaxed/simple;
	bh=m0vqLRuxnXhTboukS10XEKhxUZC+tsW2wUAoxQlVv1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=roqAuyp+Qr/C3IWNWPpyTL9bQz9KqYoG/OmMglTksXXBSO/kjAaIjW7hsUoUhVvGn3SgVwe7omPi47Z3zv06VzKrwW2iCi8uEjIqiMF3D6B8atIY0s7lpWDS4vVMcgqrUXx/guRqBQyeQn+1jAGnBgpySl1//xZiMqwvVp2m5eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1s7SVR-00FkAX-1O;
	Thu, 16 May 2024 12:14:14 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Thu, 16 May 2024 12:14:14 +0800
Date: Thu, 16 May 2024 12:14:14 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-integrity@vger.kernel.org, James Prestwood <prestwoj@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	"open list:CRYPTO API" <linux-crypto@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] crypto: rsa-pkcs1pad: export rsa1_asn_lookup()
Message-ID: <ZkWIFjGzB3ngUgsP@gondor.apana.org.au>
References: <20240515150213.32491-1-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240515150213.32491-1-jarkko@kernel.org>

On Wed, May 15, 2024 at 06:02:10PM +0300, Jarkko Sakkinen wrote:
> ASN.1 template is required for TPM2 asymmetric keys, as it needs to be
> piggy-packed with the input data before applying TPM2_RSA_Decrypt. This
> patch prepares crypto subsystem for the addition of those keys.
> 
> Later rsa_lookup_asn1() can be enabled in crypto/asymmetric_keys/Kconfig
> by:
> 
> 	depends on CRYPTO_RSA >= <TPM2 asymmetric keys>
> 
> Cc: James Prestwood <prestwoj@gmail.com>
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> ---
> v2:
> - Fix typo in the kdoc.
> - Export also the template struct.
> ---
>  crypto/rsa-pkcs1pad.c         | 16 ++++++++++------
>  include/crypto/rsa-pkcs1pad.h | 20 ++++++++++++++++++++
>  2 files changed, 30 insertions(+), 6 deletions(-)
>  create mode 100644 include/crypto/rsa-pkcs1pad.h

Please provide a link to the patch that will make use of this.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

