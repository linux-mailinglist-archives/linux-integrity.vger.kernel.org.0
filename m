Return-Path: <linux-integrity+bounces-2664-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B514C8D1083
	for <lists+linux-integrity@lfdr.de>; Tue, 28 May 2024 01:18:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66E3A1F21E51
	for <lists+linux-integrity@lfdr.de>; Mon, 27 May 2024 23:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF14D41C6E;
	Mon, 27 May 2024 23:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JoYCtjY2"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980CF167260;
	Mon, 27 May 2024 23:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716851876; cv=none; b=r03mhi1YYkAgi8N9jHloEEPsbN57PLPy6YyGJdSooNOVGkQXOdZ/yHsHxN3nsPyLyMVh5kI/7Ngotas404/DwgFizfOnSSPTi4aaNIy9ZEaZjCVlYN3AXRct2mLHAtb4wSGhTVfpAw98GXnALuf5xuwHRDsu/gwIykx9dSVS+Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716851876; c=relaxed/simple;
	bh=jb/imuwe69NBobGpoWK99Ey/b4hHD1hQVzngwPMBUIc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=N7KsVGaGb9tLHhqIHCrR8xUGp7AENfspcC/8DMiCeSvxrrcgvh+7MYaJuyiZ9b2rjMGPEN0tUlsIaC268GwavrxzJbTPkYWsQdnVIPH4SPmUGm0sU9Rjk3SUsbAXq66DfCC2+egF+/XhtQQUq7qlFAcpMv6utlqsr3U2V8EEmz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JoYCtjY2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C8A7C2BBFC;
	Mon, 27 May 2024 23:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716851876;
	bh=jb/imuwe69NBobGpoWK99Ey/b4hHD1hQVzngwPMBUIc=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=JoYCtjY2R1SmQrWqUtAbU2ssn7U2SSRA47yxeSvtHCa2T8pWlp+ygcpXc0pyX/dBP
	 IYF1azGIdPvN/vFcSsGH890hBHlBBuwvY0OFTjU50vzxYRMJ9Kyn3TJLe8c+w4tTTQ
	 a+FqTc89XqGTNujet+2rVUXCCFf60zyLAIDNdE6Lg0za7o8DDAXJ20hreM+8fA3VG/
	 LhSF3C3nnIvQdLlBOdAI/wc/EVkiEWeyVQA5e7Eajx6pfYYiSyvMNDWhrjHb4WzRyc
	 xS4EfyTzMoct1ttC2RjTDgAuXpu5JSELYWHMJlRgt8SV18fVCPc8b1PbyPuE20wklS
	 PFUEMc3TQz7sg==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 28 May 2024 02:17:51 +0300
Message-Id: <D1KT71LIUIPC.33KKNF1H2SX94@kernel.org>
Cc: <keyrings@vger.kernel.org>, "Peter Huewe" <peterhuewe@gmx.de>, "Jason
 Gunthorpe" <jgg@ziepe.ca>, "Mimi Zohar" <zohar@linux.ibm.com>, "David
 Howells" <dhowells@redhat.com>, "Paul Moore" <paul@paul-moore.com>, "James
 Morris" <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
 <linux-kernel@vger.kernel.org>, <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH 1/3] tpm: Disable TCG_TPM2_HMAC by default
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "James Bottomley" <James.Bottomley@HansenPartnership.com>, "Vitor
 Soares" <ivitro@gmail.com>, <linux-integrity@vger.kernel.org>
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
In-Reply-To: <6e326fa73968839199378694d4e7cc2544326fa6.camel@HansenPartnership.com>

On Tue May 28, 2024 at 12:36 AM EEST, James Bottomley wrote:
> On Mon, 2024-05-27 at 22:53 +0300, Jarkko Sakkinen wrote:
> > On Mon May 27, 2024 at 8:57 PM EEST, James Bottomley wrote:
> > > On Mon, 2024-05-27 at 18:34 +0300, Jarkko Sakkinen wrote:
> [...]
> > > > While looking at code I started to wanted what was the reasoning
> > > > for adding *undocumented* "TPM2_OA_TMPL" in include/linux/tpm.h.
> > > > It should really be in tpm2-sessions.c and named something like
> > > > TPM2_NULL_KEY_OA or similar.
> > >=20
> > > Well, because you asked for it. I originally had all the flags
> > > spelled out and I'm not a fan of this obscurity, but you have to do
> > > stuff like this to get patches accepted:
> > >=20
> > > https://lore.kernel.org/linux-integrity/CZCKTWU6ZCC9.2UTEQPEVICYHL@su=
ppilovahvero/
> >=20
> > I still think the constant does make sense.
>
> I'm not so sure.  The TCG simply defines it as a collection of flags
> and every TPM tool set I've seen simply uses a list of flags as well.=20
> The original design was that the template would be in this one place
> and everything else would call into it.  I think the reason all
> template construction looks similar is for ease of auditing (it's easy
> to get things, particularly the flags, wrong).
>
> If it only has one use case, it should be spelled out but if someone
> else would use it then it should be in the tpm.h shared header.

It is used only in tpm2-sessions.c and for the null key so there it
should be. And it is also lacking the associated documentation. Now
both name and context it is used is lost.

BR, Jarkko

