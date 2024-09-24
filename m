Return-Path: <linux-integrity+bounces-3689-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DD2B984AC2
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Sep 2024 20:14:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBD451F229F4
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Sep 2024 18:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64CCB1AC8B3;
	Tue, 24 Sep 2024 18:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oXwAE6cO"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8F21AC8AC;
	Tue, 24 Sep 2024 18:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727201636; cv=none; b=OM48sbxkMZ9T13hnRVO1REsaBZtpJX/5ISZGileeiN3IaXiebJHdlMUWbytOKflYzsdHzJIdCQVF+f+51A3T0vboOiAN0P4iSWG61Lc15iAkaLnbMAzKeXPd8CE+oMQgIumLi0EJ8V2spQETAlW1NAWojnxuHMdibfcz+wU++cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727201636; c=relaxed/simple;
	bh=OCs5Cqpje9S80KFQv8p9Oyg1vEGfixvfhJk33BIA/Yo=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=VmcfKcFri66xA4e08f57pbNpSAprzVhUc73a+doQ58yNoQsdsx48C9LczbNaLdzk6QFRcHzclFR9yIgcJ+mTIueqUj0pUwhSc5a4WMbVylVkY7GSUf5GPW/b62ITQEFuFh0AGn4URbSo1XP8cCO2vDUhL3cqRJI19QJ6udAJ2WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oXwAE6cO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A363CC4CECF;
	Tue, 24 Sep 2024 18:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727201636;
	bh=OCs5Cqpje9S80KFQv8p9Oyg1vEGfixvfhJk33BIA/Yo=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
	b=oXwAE6cOdDZMZ72nGMSAI/qrKVqOOjIrZgljPNUpSl+bNiJH3H9S5aDjXxztfnHNt
	 m9PlQjwNItAKrFXWKQfIX2opxvrVOP3Z0W3Rmy7fwXRbnrORUImnHCBA2/OyFqzZsU
	 EuGd6OsAkpqLmK1Co1k+1B9ceYWwLNWHfUSxtI6iHnJZ1tuQuljHZJs4lmO2t1kD4N
	 PPQYTVeaqgNEI7fhTgdwkGfKKpml2AiCcJp+F1oQzDXyclppznJ0lR54TLHdjkrsi4
	 0TfjWryYYaMzNapt2zsQUpv7Um1U/0Stwf6gFxQYWJTIv2LteGUGGL0lwvNdZTmeEn
	 XWxtcCMqDbkaQ==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 24 Sep 2024 21:13:52 +0300
Message-Id: <D4EPVO0KWRLK.2RQK9L93QM4VB@kernel.org>
To: "James Bottomley" <James.Bottomley@HansenPartnership.com>,
 <linux-integrity@vger.kernel.org>
Cc: <roberto.sassu@huawei.com>, <mapengyu@gmail.com>,
 <stable@vger.kernel.org>, "Mimi Zohar" <zohar@linux.ibm.com>, "David
 Howells" <dhowells@redhat.com>, "Paul Moore" <paul@paul-moore.com>, "James
 Morris" <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, "Peter
 Huewe" <peterhuewe@gmx.de>, "Jason Gunthorpe" <jgg@ziepe.ca>,
 <keyrings@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 4/5] tpm: Allocate chip->auth in
 tpm2_start_auth_session()
From: "Jarkko Sakkinen" <jarkko@kernel.org>
X-Mailer: aerc 0.18.2
References: <20240921120811.1264985-1-jarkko@kernel.org>
 <20240921120811.1264985-5-jarkko@kernel.org>
 <12e17497239dd9b47059b03a0273e2d995371278.camel@HansenPartnership.com>
In-Reply-To: <12e17497239dd9b47059b03a0273e2d995371278.camel@HansenPartnership.com>

On Tue Sep 24, 2024 at 4:33 PM EEST, James Bottomley wrote:
> On Sat, 2024-09-21 at 15:08 +0300, Jarkko Sakkinen wrote:
> > Move allocation of chip->auth to tpm2_start_auth_session() so that
> > the field can be used as flag to tell whether auth session is active
> > or not.
> >=20
> > Cc: stable@vger.kernel.org=C2=A0# v6.10+
> > Fixes: 699e3efd6c64 ("tpm: Add HMAC session start and end functions")
> > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> > ---
> > v5:
> > - No changes.
> > v4:
> > - Change to bug.
> > v3:
> > - No changes.
> > v2:
> > - A new patch.
> > ---
> > =C2=A0drivers/char/tpm/tpm2-sessions.c | 43 +++++++++++++++++++--------=
---
> > --
> > =C2=A01 file changed, 25 insertions(+), 18 deletions(-)
> >=20
> > diff --git a/drivers/char/tpm/tpm2-sessions.c
> > b/drivers/char/tpm/tpm2-sessions.c
> > index 1aef5b1f9c90..a8d3d5d52178 100644
> > --- a/drivers/char/tpm/tpm2-sessions.c
> > +++ b/drivers/char/tpm/tpm2-sessions.c
> > @@ -484,7 +484,8 @@ static void tpm2_KDFe(u8 z[EC_PT_SZ], const char
> > *str, u8 *pt_u, u8 *pt_v,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0sha256_final(&sctx, out=
);
> > =C2=A0}
> > =C2=A0
> > -static void tpm_buf_append_salt(struct tpm_buf *buf, struct tpm_chip
> > *chip)
> > +static void tpm_buf_append_salt(struct tpm_buf *buf, struct tpm_chip
> > *chip,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct tpm2_auth *auth)
>
> This addition of auth as an argument is a bit unnecessary.  You can set
> chip->auth before calling this and it will all function.  Since there's
> no error leg in tpm2_start_auth_session unless the session creation
> itself fails and the guarantee of the ops lock is single threading this
> chip->auth can be nulled again in that error leg.
>
> If you want to keep the flow proposed in the patch, the change from how
> it works now to how it works with this patch needs documenting in the
> change log

I checked this through and have to disagree with it. We don't want
to set chip->auth before the whole start auth session is successful

BR, Jarkko

