Return-Path: <linux-integrity+bounces-2425-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 117908C72E2
	for <lists+linux-integrity@lfdr.de>; Thu, 16 May 2024 10:32:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A322CB22AAA
	for <lists+linux-integrity@lfdr.de>; Thu, 16 May 2024 08:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06A3813DDA0;
	Thu, 16 May 2024 08:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WqebH+Hi"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEAAD13DBB3;
	Thu, 16 May 2024 08:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715848325; cv=none; b=NBucBwdurKm6RVSAOmK5Ek28TT26U1+5r2RtbezUQuf0UFXASA+Q407bRjaPmzhz7GQi5KsV2BFUe16ErbbBQDE/lcD3xELwCGcbRCssscbTe8ha9iYef2rAlmgiFAH9hxqNDYdaQnjdlYA1SyyZKPra2ny3bBGC/Ajt/X36Hzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715848325; c=relaxed/simple;
	bh=EkK/fZCdkQN2rHkZszv4lDXs1TZvezudhwKaQ4nvako=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=ZPrZIL/+bCrPRGU4nuMrsEaLxzRuYSo/SDdMSStLETsmPhuWhFQ7BB0FEseimER+R7Ft/GELha5ARmSByC8Mj2OEbObIfwzjCipbzwwcwABqXNNxPFhZGfxwO3Di+5F5i62c2dfToYcCu6yQ69fDbMo4slVx2g2YCwBNJLP6IkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WqebH+Hi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16F62C32781;
	Thu, 16 May 2024 08:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715848325;
	bh=EkK/fZCdkQN2rHkZszv4lDXs1TZvezudhwKaQ4nvako=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=WqebH+HipenVS6+ON/c8ZUSFNWWLLQF5XMZL1MXRhetrXMtFE56VJCh3qwLcLU+O+
	 O/z5DbDwhIzX9bYSzjM1MMa4FxRpb8PyVkUy/V5bsZhdBeZ4QiCol5kIObGCD2OaLq
	 0nX61uZEOR7+vQC2uNibip4HUxyZ5sDb+heCKqaEshVmMK0W6FaQceDMuc3NwOgMp7
	 FXz3+EThGZBjkYUe1h9CBSmGUMtGQ+lYDRgc5kr6nD1t9KFMonAh3UPAiYVJdpDFXx
	 +VDVMAf/llHIzwuoNVXLvhaMfEFs/T5CQ6Gvkrb599+kbsv5uzv8gleIkJwKhtS7rh
	 vGiVpIyyzU6AA==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 16 May 2024 11:32:02 +0300
Message-Id: <D1AXGT9YQXFN.QWKG529CLJUG@kernel.org>
Cc: <linux-integrity@vger.kernel.org>, "James Prestwood"
 <prestwoj@gmail.com>, "David S. Miller" <davem@davemloft.net>, "open
 list:CRYPTO API" <linux-crypto@vger.kernel.org>, "open list"
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] crypto: rsa-pkcs1pad: export rsa1_asn_lookup()
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Herbert Xu" <herbert@gondor.apana.org.au>
X-Mailer: aerc 0.17.0
References: <20240515150213.32491-1-jarkko@kernel.org>
 <ZkWIFjGzB3ngUgsP@gondor.apana.org.au>
In-Reply-To: <ZkWIFjGzB3ngUgsP@gondor.apana.org.au>

On Thu May 16, 2024 at 7:14 AM EEST, Herbert Xu wrote:
> On Wed, May 15, 2024 at 06:02:10PM +0300, Jarkko Sakkinen wrote:
> > ASN.1 template is required for TPM2 asymmetric keys, as it needs to be
> > piggy-packed with the input data before applying TPM2_RSA_Decrypt. This
> > patch prepares crypto subsystem for the addition of those keys.
> >=20
> > Later rsa_lookup_asn1() can be enabled in crypto/asymmetric_keys/Kconfi=
g
> > by:
> >=20
> > 	depends on CRYPTO_RSA >=3D <TPM2 asymmetric keys>
> >=20
> > Cc: James Prestwood <prestwoj@gmail.com>
> > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> > ---
> > v2:
> > - Fix typo in the kdoc.
> > - Export also the template struct.
> > ---
> >  crypto/rsa-pkcs1pad.c         | 16 ++++++++++------
> >  include/crypto/rsa-pkcs1pad.h | 20 ++++++++++++++++++++
> >  2 files changed, 30 insertions(+), 6 deletions(-)
> >  create mode 100644 include/crypto/rsa-pkcs1pad.h
>
> Please provide a link to the patch that will make use of this.

OK, fair enough. Will be part of the full patch set.

Overally I can say that this will be used to make textbook RSA
to a proper RSA signature ASN.1 and appropriate padding. I.e.
breath new life to this patch, which has duplicate code:

https://lore.kernel.org/all/20200518172704.29608-18-prestwoj@gmail.com/

TPM2_RSA_Decrypt is exactly textbook RSA so it partially needs
the code from kernel's RSA implementation.

BR, Jarkko

