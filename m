Return-Path: <linux-integrity+bounces-3172-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F8B093466C
	for <lists+linux-integrity@lfdr.de>; Thu, 18 Jul 2024 04:30:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60ECB1C213E5
	for <lists+linux-integrity@lfdr.de>; Thu, 18 Jul 2024 02:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C5222772A;
	Thu, 18 Jul 2024 02:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="QXginW3j";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="QXginW3j"
X-Original-To: linux-integrity@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA723273FD;
	Thu, 18 Jul 2024 02:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721269826; cv=none; b=h6Ccc8GcR/kBz1pH/BiUM0ZQhjBJnlbf36MUqpVAEvKQ5icz0o7gBgyOStPx4LYipAX1TeBMwt2GxGXjRYz9PfLObGwO0bIp4ecrSyyFe616sjLy4YzL1O0ncikKmk9fo9iQlwuFUUY6wqONE1DTpJl/mCRrLpJJDMT2aXYO8c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721269826; c=relaxed/simple;
	bh=hNTVYTLdzujEY50thFTQGrBZU/2pZsLxTwsVgJjbBqc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XPLc3iheIRZ1E8htKfkTZDcPXbQCGdkg9rTL3lifHdf18LIsAvibNWQFIWXKVM+6BniPOXWEGkiBya7AHw53UfepQ65mugMWMJ7PnTM2r3hGc6G9E8AsZPjpe7xbzQ88S35SZSd7N3+7Grx4WP53ojIlNhbojG6H+JSjm4wRYJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=QXginW3j; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=QXginW3j; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1721269823;
	bh=hNTVYTLdzujEY50thFTQGrBZU/2pZsLxTwsVgJjbBqc=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=QXginW3jr3aNx6rtfyqk5FGyisZAxcvjRLOJKO0XNbIHVqZH02KBr5LYgSIzwo/KH
	 WIOZRMUuVvmFW1MNObdDD5Eb/kYhT3tEtLWtThTqRzqm+wg/5ewXMOiivwvWTw57Xb
	 c5bVPgugSrI5aLsWLGPWjvvQN2prJUcV/oCPXEmI=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id CCCAB1286B94;
	Wed, 17 Jul 2024 22:30:23 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id d0i7l_oY3XoJ; Wed, 17 Jul 2024 22:30:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1721269823;
	bh=hNTVYTLdzujEY50thFTQGrBZU/2pZsLxTwsVgJjbBqc=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=QXginW3jr3aNx6rtfyqk5FGyisZAxcvjRLOJKO0XNbIHVqZH02KBr5LYgSIzwo/KH
	 WIOZRMUuVvmFW1MNObdDD5Eb/kYhT3tEtLWtThTqRzqm+wg/5ewXMOiivwvWTw57Xb
	 c5bVPgugSrI5aLsWLGPWjvvQN2prJUcV/oCPXEmI=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::db7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 3DEE71286AEB;
	Wed, 17 Jul 2024 22:30:23 -0400 (EDT)
Message-ID: <05a81f59a42c70d5c6233468206d012ba0fcdea6.camel@HansenPartnership.com>
Subject: Re: [PATCH 2/6] tpm: add policy sessions
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Jarkko Sakkinen <jarkko@kernel.org>, linux-integrity@vger.kernel.org
Cc: keyrings@vger.kernel.org
Date: Wed, 17 Jul 2024 22:30:21 -0400
In-Reply-To: <D2R0SSS449F2.1CSVCMJ39S3LB@kernel.org>
References: <20240524130459.21510-1-James.Bottomley@HansenPartnership.com>
	 <20240524130459.21510-3-James.Bottomley@HansenPartnership.com>
	 <D2QXYCVI47RK.GFOY8SNQHWW2@kernel.org>
	 <D2R0SSS449F2.1CSVCMJ39S3LB@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 2024-07-16 at 17:07 +0300, Jarkko Sakkinen wrote:
> On Tue Jul 16, 2024 at 2:53 PM EEST, Jarkko Sakkinen wrote:
> > > -       u8 name[AUTH_MAX_NAMES][2 + SHA512_DIGEST_SIZE];
> > > +       u8 name[AUTH_MAX_NAMES][2 + HASH_MAX_DIGESTSIZE];
> 
> Ouch, we definitely do not want 2-dimensional arrays. I missed this
> in the hmac review.
> 
> Why this is based on count (AUTH_MAX_NAMES) rather than space? Is
> that value from the specs?

Yes, it's based on the maximum number of session handles a command can
have.  It's architecturally defined in Trusted Platform Module Library
Part 1: Architecture chapter 18 (TPM Command/Response Structure) where
it says in 18.1 "an Authorization Area containing one to three session
structures"

Although if I look at our code we really only use a maximum of two for
all the commands the kernel does.

> You could just as well replace name and name_h with a single tpm_buf
> instance in "sized" mode and return -E2BIG from the functions that
> use it. Right, those don't return anything but void, which should be
> also fixed.

I'll look into that: it would get us out of the buf->handles spat.

James


