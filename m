Return-Path: <linux-integrity+bounces-2254-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6EC18B6342
	for <lists+linux-integrity@lfdr.de>; Mon, 29 Apr 2024 22:11:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E2DE1F21709
	for <lists+linux-integrity@lfdr.de>; Mon, 29 Apr 2024 20:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00BD3140E58;
	Mon, 29 Apr 2024 20:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="dvH8zzod";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="dvH8zzod"
X-Original-To: linux-integrity@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979111119B;
	Mon, 29 Apr 2024 20:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714421479; cv=none; b=qxP8q2wTiSC5+ZKgMWO38q7xP/hHwP+pNuFooBrQoPXrpfl2l3oW4/fsCzwr6BUE4yFzrvDHj5SnNGLsa8yJpwxclPJlWL4abrBhO1MjqozQ3F6ANXxLtKwaFxkEKozOxoTkNJXyCAxZEMHpBSvYi9+mhki+9IxI2wQZ4k9jwko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714421479; c=relaxed/simple;
	bh=LxYS/LEMgPZVV5gL1nfwpjboBE+qfudbGiJaBGTPoAA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=odAdbN79zoZVVICwaOFep/tV4StXgS1SV1vowppvXN7JvNiT+fIbCWKBBCcOhgTVtuy+2/zlcsbnmzC2x6ojflN2lM/EqMvSSToMjv4MiY+LYvOeUzCPxR2rc1zadk6vIzGKFCGjhYNK/Kb8JWgSEJ6x/BK8Rd0AHX7Gfv2n3dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=dvH8zzod; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=dvH8zzod; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1714421477;
	bh=LxYS/LEMgPZVV5gL1nfwpjboBE+qfudbGiJaBGTPoAA=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=dvH8zzodGLsvEVn/5b6+kcXjjtyDtcN9rXwh4tGEMjiCQQeE/DZs5HP3gJ9IAJaYy
	 62LUeq44yRv3CBqI5cTVtnmmB7lw4s9s2xHYA4h5/ib8Ir8WYihaRJx+rGY/QcLnsN
	 Wnw77o7YhgdG9outikXiyz8miCPgFq1T9xAZ7vrY=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 0004B1280977;
	Mon, 29 Apr 2024 16:11:17 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id hoUY50OVzr2l; Mon, 29 Apr 2024 16:11:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1714421477;
	bh=LxYS/LEMgPZVV5gL1nfwpjboBE+qfudbGiJaBGTPoAA=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=dvH8zzodGLsvEVn/5b6+kcXjjtyDtcN9rXwh4tGEMjiCQQeE/DZs5HP3gJ9IAJaYy
	 62LUeq44yRv3CBqI5cTVtnmmB7lw4s9s2xHYA4h5/ib8Ir8WYihaRJx+rGY/QcLnsN
	 Wnw77o7YhgdG9outikXiyz8miCPgFq1T9xAZ7vrY=
Received: from [IPv6:2601:5c4:4302:c21::a774] (unknown [IPv6:2601:5c4:4302:c21::a774])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 61DAC1280728;
	Mon, 29 Apr 2024 16:11:17 -0400 (EDT)
Message-ID: <51592b2cee56a2d7c2f42f5d04384174e65020e0.camel@HansenPartnership.com>
Subject: Re: [PATCH v7 13/21] tpm: Add HMAC session start and end functions
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Jarkko Sakkinen <jarkko@kernel.org>, linux-integrity@vger.kernel.org
Cc: keyrings@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 29 Apr 2024 16:11:16 -0400
In-Reply-To: <CZCMCMKGO4VZ.1Y7FUSYH48DUR@suppilovahvero>
References: <20240213171334.30479-1-James.Bottomley@HansenPartnership.com>
	 <20240213171334.30479-14-James.Bottomley@HansenPartnership.com>
	 <CZCMCMKGO4VZ.1Y7FUSYH48DUR@suppilovahvero>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 2024-02-23 at 19:02 +0200, Jarkko Sakkinen wrote:
> On Tue Feb 13, 2024 at 7:13 PM EET, James Bottomley wrote:
[...]
> >  static int tpm2_parse_create_primary(struct tpm_chip *chip, struct
> > tpm_buf *buf,
> >                                      u32 *nullkey)
>                 
> 
> What if this was simply tpm2_create_primary?

It would cause a massive code block surrounded by an if, which would
make the function somewhat less readable.

James


