Return-Path: <linux-integrity+bounces-2509-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12F928CAF41
	for <lists+linux-integrity@lfdr.de>; Tue, 21 May 2024 15:17:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF28F1F23353
	for <lists+linux-integrity@lfdr.de>; Tue, 21 May 2024 13:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E14383D982;
	Tue, 21 May 2024 13:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qiWcp7U6"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F782F5B;
	Tue, 21 May 2024 13:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716297424; cv=none; b=WqXPSMez3yYj4T8yJqq5MqG4vNDiVgsq+7PAQnI1YXXeuqatAYiTv+kdY3vrYds/pPyecctkIfGnGYxBUAkNDTjqUGiEyS/dRBzWYpo+yRL/cgH0faOzZzDQXR4SlmWIy+RfRtyOUltYtDmWDj8Yd4YLATgaGu44orK3MwQSD44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716297424; c=relaxed/simple;
	bh=Ai2UN0LumvAanxRSQJC3Es5pR8OR/INMnpLu0uelGtQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=b0Ha9pgxTqz1PcHAKI0tY2F/S6uJOguapp2i9Az7VCwnbHGSndcbVQewDEUpn6+eD+KcNB5MY5MvwWyeoI7ogaJR47tRuq8A1f+f6Exb5wC9n7L0goodcH0ZUttGO5/Rp/PhDbbm+dFrSlk853dwdJNHkCejUItdVPkoo98fKKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qiWcp7U6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69DCFC2BD11;
	Tue, 21 May 2024 13:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716297424;
	bh=Ai2UN0LumvAanxRSQJC3Es5pR8OR/INMnpLu0uelGtQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qiWcp7U6aaRusNrCfCcYq71aaFluW10yy7PaNxi4OgrN30vHaG2yCETzFMdhFsKrp
	 u/5ZwIC7RPBou0hV3p9fnwEwSFXMAJJlyLonaYwbo+g/8+m+exzDCtF3wTOv7wsnya
	 3FhQjJ4zRTSnQ4r34CI72aDK0gwr+ZCC9qaDuYhmFPG+P2mVkuwSjDqyAHBst1dlC/
	 Cy0wUl91ydLlrPQV2m9PSbOsGyGf+7Ji0dD7V8lw8Afbq2/ehF0SIHOwKVPJSEdgAI
	 0nhRt2/sGYCvt/b1NmQX5f/neMZRwdQ/d3RM56Cw1/X4XPD2bo25E4AMEai6vMZqYA
	 4cepH/35woKBw==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 21 May 2024 16:16:59 +0300
Message-Id: <D1FCNPSEPCC0.228MKP1CG12F0@kernel.org>
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, "James Bottomley"
 <James.Bottomley@HansenPartnership.com>, "Vitor Soares" <ivitro@gmail.com>,
 <linux-integrity@vger.kernel.org>
Cc: <keyrings@vger.kernel.org>, "Peter Huewe" <peterhuewe@gmx.de>, "Jason
 Gunthorpe" <jgg@ziepe.ca>, "Mimi Zohar" <zohar@linux.ibm.com>, "David
 Howells" <dhowells@redhat.com>, "Paul Moore" <paul@paul-moore.com>, "James
 Morris" <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
 <linux-kernel@vger.kernel.org>, <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH 1/3] tpm: Disable TCG_TPM2_HMAC by default
X-Mailer: aerc 0.17.0
References: <20240519235122.3380-1-jarkko@kernel.org>
 <20240519235122.3380-2-jarkko@kernel.org>
 <850862655008f84ef0b6ecd99750e8dc395304d1.camel@gmail.com>
 <D1F4V8NMSUNZ.2VCTEKHZZ0LB@kernel.org>
 <17dc838120b56ce342c34611596c7b46dcd9ab5a.camel@HansenPartnership.com>
 <D1FCAPJSYLTS.R9VC1CXDCIHH@kernel.org>
 <D1FCJ71B0HAO.2CD8A7N7DR5DP@kernel.org>
In-Reply-To: <D1FCJ71B0HAO.2CD8A7N7DR5DP@kernel.org>

On Tue May 21, 2024 at 4:11 PM EEST, Jarkko Sakkinen wrote:
> On Tue May 21, 2024 at 4:00 PM EEST, Jarkko Sakkinen wrote:
> > On Tue May 21, 2024 at 3:33 PM EEST, James Bottomley wrote:
> > > On Tue, 2024-05-21 at 10:10 +0300, Jarkko Sakkinen wrote:
> > > > This benchmark could be done in user space using /dev/tpm0.
> > >
> > > Let's actually try that.  If you have the ibmtss installed, the comma=
nd
> > > to time primary key generation from userspace on your tpm is
> > >
> > > time tsscreateprimary -hi n -ecc nistp256
> > >
> > >
> > > And just for chuckles and grins, try it in the owner hierarchy as wel=
l
> > > (sometimes slow TPMs cache this)
> > >
> > > time tsscreateprimary -hi o -ecc nistp256
> > >
> > > And if you have tpm2 tools, the above commands should be:
> > >
> > > time tpm2_createprimary -C n -G ecc256
> > > time tpm2_createprimary -C o -G ecc256
> >
> > Thanks, I definitely want to try these in my NUC7. I can try both
> > stacks and it is pretty good test machine because it is old'ish
> > and slow ;-)
> >
> > I'm also thinking differently than when I put out this pull request.
> > I honestly think that it must be weird use case to use TPM with
> > a machine that dies with a HMAC pipe. It makes no sense to me and
> > I think we should focus on common sense here.
> >
> > I could imagine one use case: pre-production hardware that is not
> > yet in ASIC. But in that case you would probably build your kernel
> > picking exactly the right options. I mean it is only a default
> > after all.
> >
> > I think we could add this:
> >
> > 	default X86 || ARM64
> >
> > This pretty covers the spectrum where HMAC does make sense by
> > default. We can always relax it but this does not really take
> > away the legit user base from the feature.
> >
> > It would be a huge bottleneck to make HMAC also opt-in because
> > the stuff it adds makes a lot of sense when build on top. E.g.
> > the asymmetric key patch set that I sent within early week was
> > made possible by all this great work that you've done.
> >
> > So yeah, I'd like to send the above Kconfig changes, but that
> > is all I want to do this at this point.
>
> Patch is out (lore link was not yet available):
>
> https://lkml.org/lkml/2024/5/21/583

Right also: TCG_TPM is neither default in x86 defconfig. So it would
require two switches turned on to get basic TPM support ongoing. So
yeah, I think we're in a sweet spot with above patch.

BR, Jarkko

