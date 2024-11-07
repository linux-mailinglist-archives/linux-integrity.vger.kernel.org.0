Return-Path: <linux-integrity+bounces-4051-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE199BFE6E
	for <lists+linux-integrity@lfdr.de>; Thu,  7 Nov 2024 07:27:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DFBE1C21333
	for <lists+linux-integrity@lfdr.de>; Thu,  7 Nov 2024 06:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE3F51940B3;
	Thu,  7 Nov 2024 06:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EteNGDSl"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC53A193438;
	Thu,  7 Nov 2024 06:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730960856; cv=none; b=qxYD3TQBN1dDeY33sCGqTrCsKznEJ+f4smSsFBdyJT7j8DQomeBwNiL7T8ZBKL4hcZVkMzzuldLlmZZ86dL7i1i1yBfry9L7DCI4UbTEeRf1fK0UMhxtkb8UPY+vMJE7gDVk9pbzLc4greJ3/Q4WbhgIuckxkr0gx47uXbsnj6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730960856; c=relaxed/simple;
	bh=ePaKo9POa9Nnh3ax5o5Nzq+17bXHqcRpczkyYKPRuQM=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=or6/ycdheLBKK82sy2cb4ExJvZYZmQ8btfQPbdenbIAlfPoGW5EuEMkdbcL25MBN7uW1QilLZ7M1juBVbJ0DMbAerwEk79FQlpCtp04J8lJHDvvlBzH9PRuAfTD9fNwhrg3HM/g9Gd2a/Hf8ioFe5lD5jkyyS19oEQRUDeH6Pt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EteNGDSl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6089C4CECC;
	Thu,  7 Nov 2024 06:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730960856;
	bh=ePaKo9POa9Nnh3ax5o5Nzq+17bXHqcRpczkyYKPRuQM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EteNGDSlmgqXBjx+KrA/xZIuURupViFJfUJh3VuVOOYcurVsNtn0DrbN+LDeY1WFP
	 +FCemYyaPY6QRoSKVEOskqseyI70JA4L5rH7ZyotytAZBwUOvieukFJ47VPfykXZC6
	 Gl3IW6T7wxqo+lu39mQCEKaF/jAel2e/K2vYmiry95Mm7w/zNhbZGTS0R1UZDMr/5C
	 bna3toj9gQQQQWkJ6zggQEBaO6oTOzmKBFioZCr4jT9gUYbKMJYetceVOQ7WDr4Jol
	 NeFe6wEcIyei+lMfvtnfQ04NgaLpyUybY93rCwR0R2SeuQ308KuCgcX42sm9/Etd9B
	 cLtwbuS6YGpkg==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 07 Nov 2024 08:27:32 +0200
Message-Id: <D5FQETQOFXXC.36JDXUU5521P@kernel.org>
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, "Mimi Zohar"
 <zohar@linux.ibm.com>, <linux-integrity@vger.kernel.org>, "Jonathan Corbet"
 <corbet@lwn.net>, "Peter Huewe" <peterhuewe@gmx.de>, "Jason Gunthorpe"
 <jgg@ziepe.ca>, "James Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: "Roberto Sassu" <roberto.sassu@huawei.com>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tpm: Opt-in in disable PCR encryption on TPM2 chips
X-Mailer: aerc 0.18.2
References: <20241107004708.108667-1-jarkko@kernel.org>
 <D5FJ9VCD1JBL.22MQYQHUYJLJ8@kernel.org>
 <b510e556621e3826dd6df043fde817192b9f12ea.camel@linux.ibm.com>
 <D5FQC7G8OUAO.1A449Z8ADEA0E@kernel.org>
In-Reply-To: <D5FQC7G8OUAO.1A449Z8ADEA0E@kernel.org>

On Thu Nov 7, 2024 at 8:24 AM EET, Jarkko Sakkinen wrote:
> On Thu Nov 7, 2024 at 4:48 AM EET, Mimi Zohar wrote:
> > On Thu, 2024-11-07 at 02:51 +0200, Jarkko Sakkinen wrote:
> > > On Thu Nov 7, 2024 at 2:47 AM EET, Jarkko Sakkinen wrote:
> > > > From: Mimi Zohar <zohar@linux.ibm.com>
> > > >=20
> > > > The initial encrypted HMAC session feature added TPM bus encryption=
 to
> > > > various in-kernel TPM operations. This can cause performance bottle=
necks
> > > > with IMA, as it heavily utilizes PCR extend operations.
> >
> > The patch Subject line and problem description aren't quite right.  In =
the case
> > of TPM pcr_extend, the session isn't being encrypted, only HMAC'ed.  Ac=
cording
> > to James, it's the HMAC itself that is causing the performance degradat=
ion. I
> > would remove the word "encrypted" throughout.
>
> I have to say I disagree with that. Encryption is the feature we get
> with HMAC and is more understandable for most. HMAC is implemnetation
> detail.

Sorry my bad. In the case of PCR extend SA_ENCRYPT is not passed.

Well, that underlines my point tbh :-) I cannot know from HMAC
whether it is encrypte or not, can I?

I.e. open for any other word than encrypted or HMAC because other
is wrong and other provides zero information content.

BR, Jarkko

