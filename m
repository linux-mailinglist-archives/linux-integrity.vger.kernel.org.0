Return-Path: <linux-integrity+bounces-2666-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46CB78D114F
	for <lists+linux-integrity@lfdr.de>; Tue, 28 May 2024 03:04:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBA04282F2E
	for <lists+linux-integrity@lfdr.de>; Tue, 28 May 2024 01:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0DFB4C97;
	Tue, 28 May 2024 01:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bj8TL3c7"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6FB440C;
	Tue, 28 May 2024 01:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716858291; cv=none; b=Q4cvg2cYHaxOL3USUopcXRhNxY6a47CEk8JlCX7qWdIDoDqDjQfFw3pvRAqc9dqy/BWKOmeeeWquGH7sBjSFMPIWPwF6pxWqfcjTyGeP+CgH9kkKsYd7ZhCGUk/5CVJeYsrF0ZykaWQU7Pz7zxkPYqib9AFejLjy9l3skJvRiFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716858291; c=relaxed/simple;
	bh=qZlH0JcmLnCyYE61CvEUo4pP7ZBqe/u61TKZW88QL/8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=WVuxu0YtLujd0BwDlmWsOs3VTmlDb7YbxzGkec64REqKOHLQa1ZuhsRK7yfFa7sCmNN/rRhI8lRO7V5CC1MwBJO2DuhSI285yCHC5VVfC8nn9WMH8oxexkO/0fziaiT0X9zPOvlDQuKkyvkA79NnJfS8r/B0I8ByDpckpL+w1mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bj8TL3c7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31833C2BBFC;
	Tue, 28 May 2024 01:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716858290;
	bh=qZlH0JcmLnCyYE61CvEUo4pP7ZBqe/u61TKZW88QL/8=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=Bj8TL3c7I0dCwYpRnHDCDUKgREXu4VqC69qnr8x2IZXlUX3HW+BUCW5165BbsKRkY
	 SqfcHojlyjt4ZoA+lcLFswjMCDpkEB08JJVTMNAm71j8QhWQnXBtQFDUQ/Bf6FKiBV
	 FE6YmtUC4gXRHC7b9ERBuiSQxAKhrlEhOQYm06Fkd2HBatptYAzYmAXDp379/zsZMu
	 pd2NmqxMoHuhx87x4GVogg6pBZB0XmTsdjJ6fCQIfqjU2kBPxVfq/LfKmllBZYwrfx
	 L8JJwo8BsC7rsAuInlaPWx12swf1Xkn53PZimdVN4+g7Xz1bub8ebNV9/hwRyydLj7
	 IQaPMC1H/gk4w==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 28 May 2024 04:04:46 +0300
Message-Id: <D1KVGWCV0E4G.2IA48UYCUED67@kernel.org>
Subject: Re: [PATCH 1/3] tpm: Disable TCG_TPM2_HMAC by default
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "James Bottomley" <James.Bottomley@HansenPartnership.com>, "Vitor
 Soares" <ivitro@gmail.com>, <linux-integrity@vger.kernel.org>
Cc: <keyrings@vger.kernel.org>, "Peter Huewe" <peterhuewe@gmx.de>, "Jason
 Gunthorpe" <jgg@ziepe.ca>, "Mimi Zohar" <zohar@linux.ibm.com>, "David
 Howells" <dhowells@redhat.com>, "Paul Moore" <paul@paul-moore.com>, "James
 Morris" <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
 <linux-kernel@vger.kernel.org>, <linux-security-module@vger.kernel.org>
X-Mailer: aerc 0.17.0
References: <20240519235122.3380-1-jarkko@kernel.org>
 <20240519235122.3380-2-jarkko@kernel.org>
 <850862655008f84ef0b6ecd99750e8dc395304d1.camel@gmail.com>
 <D1F4V8NMSUNZ.2VCTEKHZZ0LB@kernel.org>
 <17dc838120b56ce342c34611596c7b46dcd9ab5a.camel@HansenPartnership.com>
 <2dd8d49516ec9c7cb8c1182b5b8537b1e82d7067.camel@gmail.com>
 <17a5dcd7aceb356587ef7c8f45b0f6359b2d2a91.camel@HansenPartnership.com>
 <D1G8HOCIDWTC.2ERVA0CYHLY0B@kernel.org>
 <0c12c9ea10aa97e246230fc33e6b35c571102b48.camel@gmail.com>
 <D1GAZSIOZVWW.2UZBFHASIG21U@kernel.org>
 <3e4bbd0f0fe9f57fd7555a3775e8d71031c0d6c5.camel@gmail.com>
 <D1KIFPNBNGKH.IJKFRXH8WINU@kernel.org>
 <D1KINAE5E2MH.729CM4ABV5VN@kernel.org>
 <D1KIV2Q682XH.1GCPYWMFZ8B6J@kernel.org>
 <D1KJBXOPFWT7.1F14BWQJO29FC@kernel.org>
 <ddbeb8111f48a8ddb0b8fca248dff6cc9d7079b2.camel@HansenPartnership.com>
 <D1KOUVENRY80.2NXQW3P1K6Z2R@kernel.org>
 <6e326fa73968839199378694d4e7cc2544326fa6.camel@HansenPartnership.com>
 <D1KT71LIUIPC.33KKNF1H2SX94@kernel.org>
 <439c3a66a995429f6c8603640477580e17d03104.camel@HansenPartnership.com>
In-Reply-To: <439c3a66a995429f6c8603640477580e17d03104.camel@HansenPartnership.com>

On Tue May 28, 2024 at 2:44 AM EEST, James Bottomley wrote:
> On Tue, 2024-05-28 at 02:17 +0300, Jarkko Sakkinen wrote:
> > On Tue May 28, 2024 at 12:36 AM EEST, James Bottomley wrote:
> > > On Mon, 2024-05-27 at 22:53 +0300, Jarkko Sakkinen wrote:
> > > > On Mon May 27, 2024 at 8:57 PM EEST, James Bottomley wrote:
> > > > > On Mon, 2024-05-27 at 18:34 +0300, Jarkko Sakkinen wrote:
> > > [...]
> > > > > > While looking at code I started to wanted what was the
> > > > > > reasoning for adding *undocumented* "TPM2_OA_TMPL" in
> > > > > > include/linux/tpm.h.It should really be in tpm2-sessions.c
> > > > > > and named something like TPM2_NULL_KEY_OA or similar.
> > > > >=20
> > > > > Well, because you asked for it. I originally had all the flags
> > > > > spelled out and I'm not a fan of this obscurity, but you have
> > > > > to do stuff like this to get patches accepted:
> > > > >=20
> > > > > https://lore.kernel.org/linux-integrity/CZCKTWU6ZCC9.2UTEQPEVICYH=
L@suppilovahvero/
> > > >=20
> > > > I still think the constant does make sense.
> > >=20
> > > I'm not so sure.=C2=A0 The TCG simply defines it as a collection of
> > > flags and every TPM tool set I've seen simply uses a list of flags
> > > as well.  The original design was that the template would be in
> > > this one place and everything else would call into it.=C2=A0 I think =
the
> > > reason all template construction looks similar is for ease of
> > > auditing (it's easy to get things, particularly the flags, wrong).
> > >=20
> > > If it only has one use case, it should be spelled out but if
> > > someone else would use it then it should be in the tpm.h shared
> > > header.
> >=20
> > It is used only in tpm2-sessions.c and for the null key so there it
> > should be. And it is also lacking the associated documentation. Now
> > both name and context it is used is lost.
>
> The comment above the whole thing says what it is and where it comes
> from:
>
> 	/*
> 	 * create the template.  Note: in order for userspace to
> 	 * verify the security of the system, it will have to create
> 	 * and certify this NULL primary, meaning all the template
> 	 * parameters will have to be identical, so conform exactly to
> 	 * the TCG TPM v2.0 Provisioning Guidance for the SRK ECC
> 	 * key H template (H has zero size unique points)
> 	 */
>
> If we put the broken out flags back it's all fully documented.

Not the most productive conclusion when refusing to follow properly a
trivial request in the review feedback tbh.

BR, Jarkko

