Return-Path: <linux-integrity+bounces-2450-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 776918C914D
	for <lists+linux-integrity@lfdr.de>; Sat, 18 May 2024 15:03:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14E901F21C06
	for <lists+linux-integrity@lfdr.de>; Sat, 18 May 2024 13:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2F7729415;
	Sat, 18 May 2024 13:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zuel/urP"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5FE1F5FA;
	Sat, 18 May 2024 13:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716037411; cv=none; b=QNaTRmb7uVEOM2cRfDySnPHVuNaCgvO1n7R+KoLbAI2QxpVbzuDpmiDqR0yoldsjPkZY9o2Yw76GarSwl0vFUz1uwqfT9NahM4JbveQtId5m5sgy+prTIpjUy6atGnOIUPCCcUdAyZbh8RTQx90U7parPleeAxydly9GP/ZxJ+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716037411; c=relaxed/simple;
	bh=ZggJadfHy1NOHs7+8mfVbZ9wI8BBKNLewZn820T/SN0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=iHOuLYY87VvlqcDf20sBR1N/D0YYZi9Lf/cP8QwCGZwY6pfVpx2eGbjXG4lV+OaqCwEP7pUlryfyAz9edan7hUMw61aWX5gnpJ+FmnHfPmWvDhSIbqNMNUOtSsPO2L4OcQ0Os3baBTqFu6F7fLFfUxvfIItfcnT7SnFtxcO/coQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zuel/urP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 064DDC113CC;
	Sat, 18 May 2024 13:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716037410;
	bh=ZggJadfHy1NOHs7+8mfVbZ9wI8BBKNLewZn820T/SN0=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=Zuel/urP9lpCRixHrKBB4PYNBACOVkPvR9+8Qwmt3+OOrUG+AzLlTcksw12tb9GHg
	 G/iFqH3SOIFw0gdvQ8wm3/d0lVYfD4yNl/JEsZtUl7TGAXMMdYuyDncVYqONDEJdyz
	 2U7yXw90iJsCdLKf4Cr//qp8+xCBfHfnpx7fUp7lJTOpsc49nsNyrieV2BvngDvdoG
	 F8qoGFwXw66UKmXD+sXUrMdkq1oj0YC5+u4YlLt4i/CegOf5eFuI+eyYvY8qRZiMJf
	 eMSCcGCIT0zIGP1BlW7wrCX2+BnKNhtNKAEfP4eVkqujaqX5/WQE8vwdSNdN8TeNU3
	 3z2bq5/tMGcWQ==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 18 May 2024 16:03:26 +0300
Message-Id: <D1CSHP8IUUBC.2MY9XKKJCQVYQ@kernel.org>
Cc: "Eric Biggers" <ebiggers@kernel.org>,
 =?utf-8?b?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>,
 "James Bottomley" <James.Bottomley@hansenpartnership.com>, "Ard Biesheuvel"
 <ardb@kernel.org>, "Linux Crypto Mailing List"
 <linux-crypto@vger.kernel.org>, <linux-integrity@vger.kernel.org>,
 <keyrings@vger.kernel.org>, <regressions@lists.linux.dev>,
 <kernel@collabora.com>
Subject: Re: [PATCH] crypto: api - Do not load modules until algapi is ready
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Herbert Xu" <herbert@gondor.apana.org.au>
X-Mailer: aerc 0.17.0
References: <0f68c283ff4bbb89b8a019d47891f798c6fff287.camel@HansenPartnership.com> <CAMj1kXHi4r8KY9GvX573kwqvLpMfX-J=K2hWiGAKkf5bnicwYQ@mail.gmail.com> <0d260c2f7a9f67ec8bd2305919636678d06000d1.camel@HansenPartnership.com> <CAMj1kXFE_R_x10BVkU+8vrMz0RHiX0+rz-ZL+w08FH2CLQHZXA@mail.gmail.com> <66ec985f3ee229135bf748f1b0874d5367a74d7f.camel@HansenPartnership.com> <dfb0d930-7cbe-46c5-be19-d132b4906ecf@notapiano> <D1C2NPOBHAHK.20O4IME8OK1FH@kernel.org> <20240518043115.GA53815@sol.localdomain> <ZkhS1zrobNwAuANI@gondor.apana.org.au> <D1CPYHVR94JS.1DIGZUQ2H3NCI@kernel.org> <Zkif-BI_OFnFbDhv@gondor.apana.org.au>
In-Reply-To: <Zkif-BI_OFnFbDhv@gondor.apana.org.au>

On Sat May 18, 2024 at 3:32 PM EEST, Herbert Xu wrote:
> On Sat, May 18, 2024 at 02:04:18PM +0300, Jarkko Sakkinen wrote:
> >
> > Right does this mean for TPM driver that a crypto API invocation not
> > having everthing needed loaded will block until this is not the case?
>
> All this does is disable module loading by the Crypto API (because
> there is no point and it may deadlock) until such a point where
> all/most drivers have finished loading.
>
> So if the algorithm is missing (which shouldn't happen because of
> Kconfig selects), then it will simply fail.
>
> Cheers,

Ok, you can add

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko

