Return-Path: <linux-integrity+bounces-2443-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 384058C9084
	for <lists+linux-integrity@lfdr.de>; Sat, 18 May 2024 13:04:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CBD41C20DB7
	for <lists+linux-integrity@lfdr.de>; Sat, 18 May 2024 11:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 839FB208D1;
	Sat, 18 May 2024 11:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nXmJ2jLo"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C8A1B95B;
	Sat, 18 May 2024 11:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716030263; cv=none; b=UfOFMH2L7ZzC3uM98jMF5d+ho0M4yg4St37bJpJ+VA+SF+iEguB//BLA7+en0WqJj9+Te8kPu6nHgjf63jZVkOXdun2tSXMENWXQI/TtTgH1/RUzrM4r9Yv1DdmXyNkegjaH/BNAup4i01nSakmX5n2q8rCUem5Yymr9v6fUegk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716030263; c=relaxed/simple;
	bh=rYsvq9af1ElTO55bIIOmCkL8EzQiQvpxZzQSooTJeao=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=FqJ5xwrfujvMkL2uH71h9hJqoyu3ZYe7evkj7FbZWqXOszdy8aZteRn6u/PBMdwuvJDAunroCbwZ95OSA+QWAzLkqLk6DwEpFpWnOt9M2KCOWgFwFrC5VbRiIitQaVjtSYgMw//YH9coiyrGmHbhSXKdO+7Hy+vGeahZVc/IBYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nXmJ2jLo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F06A6C113CC;
	Sat, 18 May 2024 11:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716030263;
	bh=rYsvq9af1ElTO55bIIOmCkL8EzQiQvpxZzQSooTJeao=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=nXmJ2jLoQyJEokvaO+wsoUaYyZ3TABkEIV47lr3GOirywjGFltECefkJM+BalDP7j
	 j4Mkhx529MULMgRY6w8XoYc6KyDT9IchSdaL7TCOiGF4qLk0tvuR7lT/7M+Vojn+Nc
	 sjcDUlRMQN2oM+yrzBpxZmfURKoK6grYHBp0pQw/FWVe8ySo+M96aM/ZCDRIOywiED
	 S3PSe3gLaHyUHzjZYFbzNV1LaNg7CONlCjgugPAjNl562mqZyBwMC42ax6PwaOzsA3
	 MUzgHlXmHvJ4uF7cDetMzkfogvcvrqmxTAN3gwIM63HsTwxBAxDdoHDn8xUQ6SraUb
	 clT8lyNLnaCXA==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 18 May 2024 14:04:18 +0300
Message-Id: <D1CPYHVR94JS.1DIGZUQ2H3NCI@kernel.org>
Cc: =?utf-8?b?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>,
 "James Bottomley" <James.Bottomley@hansenpartnership.com>, "Ard Biesheuvel"
 <ardb@kernel.org>, "Linux Crypto Mailing List"
 <linux-crypto@vger.kernel.org>, <linux-integrity@vger.kernel.org>,
 <keyrings@vger.kernel.org>, <regressions@lists.linux.dev>,
 <kernel@collabora.com>
Subject: Re: [PATCH] crypto: api - Do not load modules until algapi is ready
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Herbert Xu" <herbert@gondor.apana.org.au>, "Eric Biggers"
 <ebiggers@kernel.org>
X-Mailer: aerc 0.17.0
References: <20240429202811.13643-19-James.Bottomley@HansenPartnership.com>
 <119dc5ed-f159-41be-9dda-1a056f29888d@notapiano>
 <0f68c283ff4bbb89b8a019d47891f798c6fff287.camel@HansenPartnership.com>
 <CAMj1kXHi4r8KY9GvX573kwqvLpMfX-J=K2hWiGAKkf5bnicwYQ@mail.gmail.com>
 <0d260c2f7a9f67ec8bd2305919636678d06000d1.camel@HansenPartnership.com>
 <CAMj1kXFE_R_x10BVkU+8vrMz0RHiX0+rz-ZL+w08FH2CLQHZXA@mail.gmail.com>
 <66ec985f3ee229135bf748f1b0874d5367a74d7f.camel@HansenPartnership.com>
 <dfb0d930-7cbe-46c5-be19-d132b4906ecf@notapiano>
 <D1C2NPOBHAHK.20O4IME8OK1FH@kernel.org>
 <20240518043115.GA53815@sol.localdomain>
 <ZkhS1zrobNwAuANI@gondor.apana.org.au>
In-Reply-To: <ZkhS1zrobNwAuANI@gondor.apana.org.au>

On Sat May 18, 2024 at 10:03 AM EEST, Herbert Xu wrote:
> When the Crypto API is built into the kernel, it may be invoked
> during system initialisation before modules can be loaded.  Ensure
> that it doesn't load modules if this is the case by checking
> crypto_boot_test_finished().
>
> Add a call to wait_for_device_probe so that the drivers that may
> call into the Crypto API have finished probing.
>
> Reported-by: N=C3=ADcolas F. R. A. Prado" <nfraprado@collabora.com>
> Reported-by: Eric Biggers <ebiggers@kernel.org>
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

Right does this mean for TPM driver that a crypto API invocation not
having everthing needed loaded will block until this is not the case?

BR, Jarkko

