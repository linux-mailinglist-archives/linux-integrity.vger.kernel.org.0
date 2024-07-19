Return-Path: <linux-integrity+bounces-3203-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DFB693787A
	for <lists+linux-integrity@lfdr.de>; Fri, 19 Jul 2024 15:27:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46E372810C3
	for <lists+linux-integrity@lfdr.de>; Fri, 19 Jul 2024 13:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 314DD14372D;
	Fri, 19 Jul 2024 13:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ltCQJ0X0"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A465142642;
	Fri, 19 Jul 2024 13:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721395586; cv=none; b=AAAX949ZA46+LyX4BQVgOAFEVDMMpQZGmbW2BQmB4TJ4FaDGpmc/DyhMXxEEl0U9z4Dl3kt9i92CS6W+rp2CLaG88GY+AZELEIqFSRDbJquDU+4x8eIgerjCBorPtF4mfyZE+9bRTuknX7rD7UIRMvzN9Pu15L4rfihnYZxTPyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721395586; c=relaxed/simple;
	bh=68yt5A153ilfN6Bw2zQNNbc3FwxdTtR1iBe2Pp/r+cY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FeWXBC8wm61FKCVrtQQzdJCj++i2SGiYAcA1AtrTbXOPZCaKMkjoTY5QW4GKhCfNWCar+Kkd5Q1wBesAGjKStj4J8gS9lb7FhFxnyJFFy7UwbcDvts5YhYuOpsulKEECTl3iw6FlXlYXQL0+RwjjvT0RAVLeEi5/9YOKVpLipuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ltCQJ0X0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4692DC32782;
	Fri, 19 Jul 2024 13:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721395585;
	bh=68yt5A153ilfN6Bw2zQNNbc3FwxdTtR1iBe2Pp/r+cY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=ltCQJ0X0Xo706pE1V5BeNu9xh8c64w2bNwAoeA5W7UTJCBReZ6djZVfWo/emJQ9hQ
	 8+aGoxXHKJhIdQlT7ktBNwLNMzLf+QmVXKBm34lJFiLWO6gyo3vBqIJ1QU0hihFgpI
	 C4iuc43UNn2BqAvjCtPDrNcXbe9A0NeyyOd2SBL04aPNr/MOtXFvVyOh90hlLou8q6
	 /aTOpGvfQU7LzEuWUxXDqEsaCH7VQZDGywkPyR3nfP0Ow+2/RnW3+KY2uLxOdpGJyo
	 1BmoNPwF66ZhoXMiNssI8AcTg/e573l3X94xOxuEvAIZNOGCkQL8pImU/CDIICZkkA
	 XZ18V2uK/EFRw==
Message-ID: <ed2617e276271cc33261053da12aff9995e710d7.camel@kernel.org>
Subject: Re: [PATCH 2/6] tpm: add policy sessions
From: Jarkko Sakkinen <jarkko@kernel.org>
To: James Bottomley <James.Bottomley@HansenPartnership.com>, 
	linux-integrity@vger.kernel.org
Cc: keyrings@vger.kernel.org
Date: Fri, 19 Jul 2024 16:26:21 +0300
In-Reply-To: <6d5c4d26ec6b993ce3dd8e24fd22d0a4dfca021d.camel@kernel.org>
References: <20240524130459.21510-1-James.Bottomley@HansenPartnership.com>
	 <20240524130459.21510-3-James.Bottomley@HansenPartnership.com>
	 <D2QXYCVI47RK.GFOY8SNQHWW2@kernel.org>
	 <D2R0SSS449F2.1CSVCMJ39S3LB@kernel.org>
	 <05a81f59a42c70d5c6233468206d012ba0fcdea6.camel@HansenPartnership.com>
	 <6d5c4d26ec6b993ce3dd8e24fd22d0a4dfca021d.camel@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 (3.52.3-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-07-19 at 16:21 +0300, Jarkko Sakkinen wrote:
> On Wed, 2024-07-17 at 22:30 -0400, James Bottomley wrote:
> > On Tue, 2024-07-16 at 17:07 +0300, Jarkko Sakkinen wrote:
> > > On Tue Jul 16, 2024 at 2:53 PM EEST, Jarkko Sakkinen wrote:
> > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u8 name[AUTH_MAX_NAMES=
][2 + SHA512_DIGEST_SIZE];
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u8 name[AUTH_MAX_NAMES=
][2 + HASH_MAX_DIGESTSIZE];
> > >=20
> > > Ouch, we definitely do not want 2-dimensional arrays. I missed this
> > > in the hmac review.
> > >=20
> > > Why this is based on count (AUTH_MAX_NAMES) rather than space? Is
> > > that value from the specs?
> >=20
> > Yes, it's based on the maximum number of session handles a command can
> > have.=C2=A0 It's architecturally defined in Trusted Platform Module Lib=
rary
> > Part 1: Architecture chapter 18 (TPM Command/Response Structure) where
> > it says in 18.1 "an Authorization Area containing one to three session
> > structures"
> >=20
> > Although if I look at our code we really only use a maximum of two for
> > all the commands the kernel does.
> >=20
> > > You could just as well replace name and name_h with a single tpm_buf
> > > instance in "sized" mode and return -E2BIG from the functions that
> > > use it. Right, those don't return anything but void, which should be
> > > also fixed.
> >=20
> > I'll look into that: it would get us out of the buf->handles spat.
>=20
>=20
> Also one thing I recalled after reviewing this: when updating
> any of the exported functions:
>=20
> 1. Try to scope patch per function. Obviously when sanely
> =C2=A0=C2=A0 possible but at least goal should be this granularity.
> 2. It would make sense to take the documentation from header
> =C2=A0=C2=A0 and kdoc and merge them into a single entity.
>=20
> This way I think it would be more digestable and easier both
> test and review.


My philosophy here is like for any other new feature:

1. The first version can be messier, and all the issues I've complained abo=
ut
   (mostly because I came from holiday to fix them) are kind of part of the
   job.
2. The second version or supplemental feature should make the code base
   cleaner than it was before it existed.

So I kind of see the second iteration also a chance fix all the glitches
and rough corners. I don't think anything was done "wrong" durign the
first iteration, now it is just easier to reflect some of the choices.

BR, Jarkko

