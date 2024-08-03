Return-Path: <linux-integrity+bounces-3285-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D8D7E946B23
	for <lists+linux-integrity@lfdr.de>; Sat,  3 Aug 2024 22:44:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67C9EB21289
	for <lists+linux-integrity@lfdr.de>; Sat,  3 Aug 2024 20:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC24422F08;
	Sat,  3 Aug 2024 20:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Px6CjgRW"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DBDD111AA
	for <linux-integrity@vger.kernel.org>; Sat,  3 Aug 2024 20:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722717841; cv=none; b=XQ8bmSbugjVqs4ha4qJLcmnTROq/kYPtR7WUSyvjPm7ebX8X+Y9wBogQRatVz12HYr+s3AmWOdAZtbnsOzI6eiT7qSjvaH7bpijSW7xxjKVC1PtFSyxsM2RKTOXs3PLzJUqg8GzuRLE5myJfWGpsJzZ4Zeu8BE83I4fBz6r7iTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722717841; c=relaxed/simple;
	bh=H5WiUFuBNIinnfwXGSJOy42xcPYCXEDEbvJgpDgu3nY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=FbqZfHdQCMbecE8TYSWv4ubxdNldZXVl/33RZj95l8P4RyWxsFDaMgBTwJCPfMh1VuYUCi9UaMzCDS/aiCSbGjtxe19iKqVzvbhx6szL7LYZ8tqXtHKpem3Z4dIUKuFupj8jWjYh/V26rj5H5JjlVCO+COvcny4Tn/cWV4tjp6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Px6CjgRW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AADCEC116B1;
	Sat,  3 Aug 2024 20:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722717841;
	bh=H5WiUFuBNIinnfwXGSJOy42xcPYCXEDEbvJgpDgu3nY=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=Px6CjgRW3Aisn8Tc0gDbcDokv0rzIOux3AybrgJz/JWLKVxPHiGJPdICZWuk/aPnn
	 FK+aF2ixG9CckKJCadGoS7rHdr3OJJYgQ8xSJcsKGUlG7foFzibxSrbahokrWI7Ev6
	 FP9oIQsUXKAtrIDf+7u+FAr6TK6ixq1ocfpzR8TXFH5WlArGGpOtUGS+dWSbSWPTnN
	 /lFTgnjfJ0VzaKdNHhvEfKtZC5ah9qefQpRxZTSY8wTwguKtq5SEXfghbGYmMyUF7l
	 nOlAQbL8G4KqtnqyVtF2MiUIHo0+TH1M+NlEWKZdewHM8djJdA0KiWYxX0L0euJmhI
	 vCat545Z0R6Xw==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 03 Aug 2024 23:43:56 +0300
Message-Id: <D36KI8TC0600.1OAIM33YQYMLX@kernel.org>
Cc: <linux-integrity@vger.kernel.org>
Subject: Re: [PATCH 1/8] tss: Fix handling of TPM_RH_NULL in intel-tss
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "James Bottomley" <James.Bottomley@HansenPartnership.com>, "Jarkko
 Sakkinen" <jarkko.sakkinen@iki.fi>, <openssl-tpm2-engine@groups.io>
X-Mailer: aerc 0.18.0
References: <20240802202606.12767-1-James.Bottomley@HansenPartnership.com>
 <20240802202606.12767-2-James.Bottomley@HansenPartnership.com>
 <D36FX5RTUSEW.1LZMP91ZPPZZK@iki.fi>
 <53a91b9ebbc500e928eadf2112d3ecb5631c56c1.camel@HansenPartnership.com>
 <D36IYI5ZD4VK.2GC6CG6GIUWK9@kernel.org>
 <237c1ed926d926bfddb92a959a27543479b5f0ae.camel@HansenPartnership.com>
In-Reply-To: <237c1ed926d926bfddb92a959a27543479b5f0ae.camel@HansenPartnership.com>

On Sat Aug 3, 2024 at 10:47 PM EEST, James Bottomley wrote:
> On Sat, 2024-08-03 at 22:31 +0300, Jarkko Sakkinen wrote:
> > On Sat Aug 3, 2024 at 8:51 PM EEST, James Bottomley wrote:
> > > On Sat, 2024-08-03 at 20:08 +0300, Jarkko Sakkinen wrote:
> > > > On Fri Aug 2, 2024 at 11:25 PM EEST, James Bottomley wrote:
> > > > > Now that we're going to be using the NULL primary to salt
> > > > > sessions, the Intel TSS shim needs fixing to cope with this.=C2=
=A0
> > > > > In the Intel TSS, there are two internal handles representing
> > > > > NULL: ESYS_TR_NONE and ESYS_TR_RH_NULL.=C2=A0 We translate
> > > > > TPM_RH_NULL to ESYS_TR_NONE because
> > > >=20
> > > > Can you split this into two paragraphs.
> > > >=20
> > > > I'm lost why it has two representations.
> > >=20
> > > Well, I actually have no idea why the Intel TSS has two
> > > representations for *every* handle: an internal one (specific to
> > > the TSS) and an external one that everyone uses, like 81000001 or
> > > 40000007. As far as I can see it just adds pointless complexity to
> > > the coding.=C2=A0 The IBM TSS only has one, so for code which works w=
ith
> > > both, the shim has to transform between internal and external
> > > handle representations before sending the command onward to the
> > > Intel TSS.
> >=20
> > Is it possible to address this complexity and move into a single
> > representation? I.e. use external presentation all the way.
>
> Yes, that's what the current code does.  It began life as pure IBM TSS
> so it used what the Intel TSS would consider as all external handle
> representations.  The external to internal shift (and back) happens
> inside the TSS shim.

Ah, right, OK now I'm on page, thank you.

>
> > > Even more mysteriously the Intel TSS has three representations for
> > > the NULL handle: an internal one, an external one (40000007) and
> > > one you use for an empty session (ESYS_TR_NONE).=C2=A0 The IBM TSS us=
es
> > > TPM_RH_NULL for all three so you can't just translate from external
> > > to internal you have to know if you're using the handle for a
> > > session or a hierarchy as well.
> >=20
> > Same question applies to this too.
>
> Remember this is just fixing the Intel TSS Shim.  The fact that we have
> to use three different handles for NULL isn't visible outside the shim,
> so a consumer of these APIs just uses TPM_RH_NULL everywhere.  The fix
> is that the Intel TSS Shim was using the wrong handle for some
> operations.

OK, got it, thanks.

BR, Jarkko

