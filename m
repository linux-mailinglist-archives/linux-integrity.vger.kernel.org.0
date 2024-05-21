Return-Path: <linux-integrity+bounces-2517-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C95E8CB0F0
	for <lists+linux-integrity@lfdr.de>; Tue, 21 May 2024 17:02:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 053381F22AFA
	for <lists+linux-integrity@lfdr.de>; Tue, 21 May 2024 15:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E4D97F7C1;
	Tue, 21 May 2024 15:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TTeC6O+M"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA5477F2F;
	Tue, 21 May 2024 15:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716303761; cv=none; b=JG0Nx/JucnjggJ/Px0PAwqxiENOireo8kQvMIwI8qGt8oiD2MgTDk7sjZMWSM8KCDt4lqJmcmiTHPfeTVCoclrYBK1mG5+OEEQ+mxyA1cQtTR8LxQfwo+Jn0RiJpSoLa5zofgR143j6vt2pSaCD39djsFYQSXrZP2/ZYN/IqsA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716303761; c=relaxed/simple;
	bh=TrukoGqXcpRIafRLbSMOzVg8Pdtim25TWLGDNcDwlYM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=O7Y9iVCWNpKxtkC+xEcBb9Q0SZxpqudyP2VoaiMbL5G1XrpFnvFUFDieSYOfMjxQ3PN2MN89vdn8jkasiKadOGsfsYlv0fvb3ha+rs7UKcOWIvSZZcHkw2inMt7qD2mhFbhMb8yGowQ/DFqtCzcmTkXlIqPbkRAsTbJGTGRCcJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TTeC6O+M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86518C2BD11;
	Tue, 21 May 2024 15:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716303761;
	bh=TrukoGqXcpRIafRLbSMOzVg8Pdtim25TWLGDNcDwlYM=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=TTeC6O+MOwWsJyFkTSAWYQR3ts/39okiVETpfCzMBPNEws3YSZkpAzN1i7QcBfS1e
	 /tyAIM/as55a9TkHc3CRyKmib9hpup6BnKCrR+8f73XbPI8c0kwLJa8AqyLp6tn7wx
	 AKn5so2ZgrtfKDdbeXJRUV6knoxNI+jwkNLSTELBYIFmvqY8UxJZ+qaGVzqImEjKkZ
	 efcDmBmm9V6FQgLWtwdIw7jPpu3JsMyeR2jMCudktlYKzcC31HdiSUqMcaUbvJZU/A
	 ZpZSeI1L10ZCFoCNi5KOZDfo9J3oV3OW9NPF/JFV1pK11jA4WOYAh3iBvsbUehiV7K
	 QjNWXbRHnWe1Q==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 21 May 2024 18:02:36 +0300
Message-Id: <D1FEWL5L476W.14JEX8FGU79V5@kernel.org>
Cc: <keyrings@vger.kernel.org>, "Peter Huewe" <peterhuewe@gmx.de>, "Jason
 Gunthorpe" <jgg@ziepe.ca>, "Mimi Zohar" <zohar@linux.ibm.com>, "David
 Howells" <dhowells@redhat.com>, "Paul Moore" <paul@paul-moore.com>, "James
 Morris" <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
 <linux-kernel@vger.kernel.org>, <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH] tpm: enable HMAC encryption for only x86-64 and aarch64
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "James Bottomley" <James.Bottomley@HansenPartnership.com>,
 <linux-integrity@vger.kernel.org>
X-Mailer: aerc 0.17.0
References: <20240521130921.15028-1-jarkko@kernel.org>
 <236606947b691049c650bdf82c37324084662147.camel@HansenPartnership.com>
 <D1FDMULT5YRK.GZOPJ9FZ325R@kernel.org>
 <854fa2e1634eb116b979dab499243e40917c637c.camel@HansenPartnership.com>
 <D1FE58VX0KL4.70F6U9Y6HPQC@kernel.org>
 <D1FEC6TB7660.2XD9X21W46X7V@kernel.org>
 <0da89df455617f4dc1c7fdb8890e3219cfce4f7b.camel@HansenPartnership.com>
In-Reply-To: <0da89df455617f4dc1c7fdb8890e3219cfce4f7b.camel@HansenPartnership.com>

On Tue May 21, 2024 at 5:56 PM EEST, James Bottomley wrote:
> On Tue, 2024-05-21 at 17:35 +0300, Jarkko Sakkinen wrote:
> > On Tue May 21, 2024 at 5:26 PM EEST, Jarkko Sakkinen wrote:
> > > On Tue May 21, 2024 at 5:13 PM EEST, James Bottomley wrote:
> > > > On Tue, 2024-05-21 at 17:02 +0300, Jarkko Sakkinen wrote:
> > > > > Secondly, it also roots to the null key if a parent is not
> > > > > given. So it covers all the basic features of the HMAC patch
> > > > > set.
> > > >=20
> > > > I don't think that can work.=C2=A0 The key file would be wrapped to
> > > > the parent and the null seed (and hence the wrapping) changes
> > > > with every reboot.=C2=A0 If you want a permanent key, it has to be =
in
> > > > one of the accessible permanent hierarchies (storage ideally or
> > > > endorsement).
> > >=20
> > > I'm fully aware that null seed is randomized per power cycle.
>
> OK, as long as this gets documented, I'm OK with it
>
> > > The fallback was inherited from James Prestwood's original code and
> > > I decided to keep it as a testing feature, and also to test HMAC
> > > changes.
> > >=20
> > > If you look at the testing transcript in the cover letter, it
> > > should beobvious that a primary key is created in my basic test.
> >=20
> > I think what could be done to it in v3 would be to return -EOPNOTSUPP
> > if parent is not defined. I.e. rationale here is that this way the
> > empty option is still usable for something in future kernel releases.
>
> You can absolutely have null derived parent keys (I use them for
> testing as well).  However, the spec says the parent handle in that
> case should be TPM_RH_NULL (i.e. 0x40000007) not zero:
>
> https://www.hansenpartnership.com/draft-bottomley-tpm2-keys.html#name-par=
ent

Yep. I somehow recalled that it replaced 0x0 with RH_NULL but it
actually checked whether the handle is RH_NULL and then loaded
the null key if that was the case.

BR, Jarkko

