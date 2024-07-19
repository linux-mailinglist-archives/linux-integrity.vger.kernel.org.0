Return-Path: <linux-integrity+bounces-3202-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9F24937859
	for <lists+linux-integrity@lfdr.de>; Fri, 19 Jul 2024 15:21:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79B191F229A8
	for <lists+linux-integrity@lfdr.de>; Fri, 19 Jul 2024 13:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F373823A6;
	Fri, 19 Jul 2024 13:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TVnOlqp4"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBECA10E6;
	Fri, 19 Jul 2024 13:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721395289; cv=none; b=YgKH/rarXsmAv54wgz8LeoHSUmR2TTIQTe82cGppxUY7dlwQDmw5M0YaXhdCrRsqFDHTKBPBj1kNVQ0hdAcSRik3ern+EmFWOSEOujwfMREcpHUvbx3FINg/3mEgMqMMw8vEp0V4pN7y4s6xdRS5vUmT0/IprXSWGT8VA85UCy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721395289; c=relaxed/simple;
	bh=EM2tEqdKkqIXL3sxGAlMp/LTkKe4VjwL840QikS3KC0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=REMXQ1ZyYM9LX+yVUJd+vN8oaenCLAyQ6M/uI898bfnIsbkjC6IWXHJj6lkxyZPbTaN5hsyQ0IL553ebyAvnbgYzizQQPFoccu1wnLLnOelzq2IaELohhmQ80xPCLBK1RjknT4UmxB1or/hJ6/HHXPZt7/eLDyTg1IdiOmKmLu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TVnOlqp4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 651A9C32782;
	Fri, 19 Jul 2024 13:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721395288;
	bh=EM2tEqdKkqIXL3sxGAlMp/LTkKe4VjwL840QikS3KC0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=TVnOlqp43HaDS2jV1WnCJdoTjtMV3Xb/MQDQSRmjazLkKaBB1vJo9O1bXOPNOt87h
	 bZc9uMorwO3I8yYBLBvY0fdYx8c61HsVeQIRMpdDItrLfrDuADD+oiGJLlOXuAufYK
	 VD1reCHvE2Pq/UtoQxU6zIZr/XuxGH55pezNXOBsAkX8jj4ebek6UZBd8+6nTJYLhN
	 DAuwDHx4amRe7USmN+cL205P7gB939CM74+36jXJuc/9AOUMHUOXT5ffkcucmVCC01
	 P97u+Fs1gng9/LFbKBLDbeC9uo6bUGiLn1jj2y7tT7gjgOXwWqA7V/2rnMwPl65xwc
	 HznsNtzTZ+ilA==
Message-ID: <6d5c4d26ec6b993ce3dd8e24fd22d0a4dfca021d.camel@kernel.org>
Subject: Re: [PATCH 2/6] tpm: add policy sessions
From: Jarkko Sakkinen <jarkko@kernel.org>
To: James Bottomley <James.Bottomley@HansenPartnership.com>, 
	linux-integrity@vger.kernel.org
Cc: keyrings@vger.kernel.org
Date: Fri, 19 Jul 2024 16:21:25 +0300
In-Reply-To: <05a81f59a42c70d5c6233468206d012ba0fcdea6.camel@HansenPartnership.com>
References: <20240524130459.21510-1-James.Bottomley@HansenPartnership.com>
	 <20240524130459.21510-3-James.Bottomley@HansenPartnership.com>
	 <D2QXYCVI47RK.GFOY8SNQHWW2@kernel.org>
	 <D2R0SSS449F2.1CSVCMJ39S3LB@kernel.org>
	 <05a81f59a42c70d5c6233468206d012ba0fcdea6.camel@HansenPartnership.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 (3.52.3-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-07-17 at 22:30 -0400, James Bottomley wrote:
> On Tue, 2024-07-16 at 17:07 +0300, Jarkko Sakkinen wrote:
> > On Tue Jul 16, 2024 at 2:53 PM EEST, Jarkko Sakkinen wrote:
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u8 name[AUTH_MAX_NAMES][=
2 + SHA512_DIGEST_SIZE];
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u8 name[AUTH_MAX_NAMES][=
2 + HASH_MAX_DIGESTSIZE];
> >=20
> > Ouch, we definitely do not want 2-dimensional arrays. I missed this
> > in the hmac review.
> >=20
> > Why this is based on count (AUTH_MAX_NAMES) rather than space? Is
> > that value from the specs?
>=20
> Yes, it's based on the maximum number of session handles a command can
> have.=C2=A0 It's architecturally defined in Trusted Platform Module Libra=
ry
> Part 1: Architecture chapter 18 (TPM Command/Response Structure) where
> it says in 18.1 "an Authorization Area containing one to three session
> structures"
>=20
> Although if I look at our code we really only use a maximum of two for
> all the commands the kernel does.
>=20
> > You could just as well replace name and name_h with a single tpm_buf
> > instance in "sized" mode and return -E2BIG from the functions that
> > use it. Right, those don't return anything but void, which should be
> > also fixed.
>=20
> I'll look into that: it would get us out of the buf->handles spat.


Also one thing I recalled after reviewing this: when updating
any of the exported functions:

1. Try to scope patch per function. Obviously when sanely
   possible but at least goal should be this granularity.
2. It would make sense to take the documentation from header
   and kdoc and merge them into a single entity.

This way I think it would be more digestable and easier both
test and review.

BR, Jarkko

