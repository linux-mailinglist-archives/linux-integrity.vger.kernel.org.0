Return-Path: <linux-integrity+bounces-2451-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6531A8C9155
	for <lists+linux-integrity@lfdr.de>; Sat, 18 May 2024 15:08:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 966801C20F5C
	for <lists+linux-integrity@lfdr.de>; Sat, 18 May 2024 13:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 028013A1DA;
	Sat, 18 May 2024 13:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="HgykhyYp";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="HgykhyYp"
X-Original-To: linux-integrity@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C6C32C60;
	Sat, 18 May 2024 13:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716037680; cv=none; b=i9LOGWJ0JyXpDhWXfBWZy0ulBeUvFkUrNfD3xRV/5aL7dae5EOFxG6FauLyp4KZ40GvJRKdWDFL4DPqoZGEvLuK6EqTctMTIaKlWo3IPPGSS8cTOkso1XEErj9Zf9kZO0OF2U/Ps3PXNNR/CMIAejAIcTaIShiPQ1hbSw+vBY8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716037680; c=relaxed/simple;
	bh=Qf9Qwpx/MU8nA0UDjxSlvV9op3yi9qax6HPjVmnv/6c=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=sgFefjTca6xkHak+Puqp2/3aS0rxdyutI3lrBGBliPYvtGS9qiSqK3E0oMPATSJZAaKd6qtWugJn8qLPOCOPp9sZpWBLMU4aGRnhJ4yFm4bP4R4DYjPRI7iVb1y6nPI8lKXqy9VYB/OwHr9UTc2fSxRkYc2DDdcUCfy3sB+mG4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=HgykhyYp; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=HgykhyYp; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1716037678;
	bh=Qf9Qwpx/MU8nA0UDjxSlvV9op3yi9qax6HPjVmnv/6c=;
	h=Date:From:To:Subject:In-Reply-To:References:Message-ID:From;
	b=HgykhyYpXYkU3vdXxHkNLuDXeK6DldzWZkFjnLdi/Z+joYO19EfbVnY6ErTXDeYNN
	 VLgd0kokEDk+d9FDfiqQNcbatvqrb96ijTQkTxAyAgJJKFSn3yG0aNQJV2a5VtMxdV
	 JmloHbEJvUPLmsYWncs2IhGW3r7dws/UY6s2uK5I=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 954AF1287275;
	Sat, 18 May 2024 09:07:58 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id djlfKy_s9EQE; Sat, 18 May 2024 09:07:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1716037678;
	bh=Qf9Qwpx/MU8nA0UDjxSlvV9op3yi9qax6HPjVmnv/6c=;
	h=Date:From:To:Subject:In-Reply-To:References:Message-ID:From;
	b=HgykhyYpXYkU3vdXxHkNLuDXeK6DldzWZkFjnLdi/Z+joYO19EfbVnY6ErTXDeYNN
	 VLgd0kokEDk+d9FDfiqQNcbatvqrb96ijTQkTxAyAgJJKFSn3yG0aNQJV2a5VtMxdV
	 JmloHbEJvUPLmsYWncs2IhGW3r7dws/UY6s2uK5I=
Received: from [IPv6:::1] (unknown [IPv6:2607:fb91:1dc2:86d0:8b7e:3b6d:e5db:1254])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 145A11287272;
	Sat, 18 May 2024 09:07:57 -0400 (EDT)
Date: Sat, 18 May 2024 06:07:39 -0700
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Herbert Xu <herbert@gondor.apana.org.au>, Jarkko Sakkinen <jarkko@kernel.org>
CC: Eric Biggers <ebiggers@kernel.org>,
 =?ISO-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>,
 Ard Biesheuvel <ardb@kernel.org>,
 Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
 linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
 regressions@lists.linux.dev, kernel@collabora.com
Subject: Re: [PATCH] crypto: api - Do not load modules until algapi is ready
User-Agent: K-9 Mail for Android
In-Reply-To: <Zkif-BI_OFnFbDhv@gondor.apana.org.au>
References: <0f68c283ff4bbb89b8a019d47891f798c6fff287.camel@HansenPartnership.com> <CAMj1kXHi4r8KY9GvX573kwqvLpMfX-J=K2hWiGAKkf5bnicwYQ@mail.gmail.com> <0d260c2f7a9f67ec8bd2305919636678d06000d1.camel@HansenPartnership.com> <CAMj1kXFE_R_x10BVkU+8vrMz0RHiX0+rz-ZL+w08FH2CLQHZXA@mail.gmail.com> <66ec985f3ee229135bf748f1b0874d5367a74d7f.camel@HansenPartnership.com> <dfb0d930-7cbe-46c5-be19-d132b4906ecf@notapiano> <D1C2NPOBHAHK.20O4IME8OK1FH@kernel.org> <20240518043115.GA53815@sol.localdomain> <ZkhS1zrobNwAuANI@gondor.apana.org.au> <D1CPYHVR94JS.1DIGZUQ2H3NCI@kernel.org> <Zkif-BI_OFnFbDhv@gondor.apana.org.au>
Message-ID: <3A150785-8EE3-4B53-9E71-4DE49C6751B0@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On May 18, 2024 5:32:56 AM PDT, Herbert Xu <herbert@gondor=2Eapana=2Eorg=2E=
au> wrote:
>On Sat, May 18, 2024 at 02:04:18PM +0300, Jarkko Sakkinen wrote:
>>
>> Right does this mean for TPM driver that a crypto API invocation not
>> having everthing needed loaded will block until this is not the case?
>
>All this does is disable module loading by the Crypto API (because
>there is no point and it may deadlock) until such a point where
>all/most drivers have finished loading=2E
>
>So if the algorithm is missing (which shouldn't happen because of
>Kconfig selects), then it will simply fail=2E

I have a curiosity question: if Eric is right and it's looking for an opti=
onal hmac accelerator module, why don't I see this?  The only real config d=
ifference between what I tested and what Nicholas did is he's arm and I'm x=
86=2E

James

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E

