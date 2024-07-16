Return-Path: <linux-integrity+bounces-3118-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 936FB9323BA
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Jul 2024 12:15:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DAE01C22A4C
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Jul 2024 10:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E3B057888;
	Tue, 16 Jul 2024 10:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="lMgeDqUs";
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="b4ReaF9y"
X-Original-To: linux-integrity@vger.kernel.org
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58D5198832;
	Tue, 16 Jul 2024 10:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721124914; cv=pass; b=NdU358SKhisv0N0voY5p1ep6VnzAil6YmTz/3TKa6VA1dN/jkAwUjcl+Cc5WeZSJRL6OX8MAugqQ2t7ruF+YylYBi3S+LW4XRmh4NekpsrggRxYYD1RrE3lncaCHv4Fbh+0p+QocFNLl4U/uvX1YSQKUlhche8pEEHtGHtGduUM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721124914; c=relaxed/simple;
	bh=qjgFpWpR5+BHvJKoHx4VOD2XEZQxafJHmKAcxjKa2h4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=XlCThdG+Na1e3e3o90A+JMZxjA17Mzlj1Zil49JzUguLfBfw1ngo+XOtAZQquvtBUMG4dex5aEjwwT0jQr36CYFa58qVw3U02TzOpSTFModSfOov5FN9XA0r6wF+AUlTru3IpZTTvDkQV//R4AN3B0MgqEf1ab1mqoM9b7NviPo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=lMgeDqUs; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=b4ReaF9y; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Received: from meesny.iki.fi (meesny.iki.fi [IPv6:2001:67c:2b0:1c1::201])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lahtoruutu.iki.fi (Postfix) with ESMTPS id 4WNZVZ0tBTz49PyZ;
	Tue, 16 Jul 2024 13:07:02 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1721124422;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EdoOS1Vx+qVFB1EZYjKbADIDpN3WKdD3NXCzP1l8TEc=;
	b=lMgeDqUsqGBQfbQ5ls0Fd7+95WDR0Nv57O8qhkGrg2Dp8JbxzSs0glBo4OfK0XgH0RJcN4
	ZEneYeu1DfoZ/eu2OKCRehzXsytLB1ocjZHH3EhLQ2LLE7lRKXXa6BKxyYYpY29ZACHNmp
	lnEHlPk08CTZSjzPr7l1/D/zXCiUgVdCzEPY7YDIwK4RoaviMpD9cCnFjMmaLCVcF+4r9T
	0LjR2CoQljGEI41ffDOdhz0uesJde2jYObujIvdHEXHw1eOMMYIKiVVqo9Nuydcqr6UBP/
	ZHWosDXOB7DDTOXzWbneNvyRM0mG2KS+963Chet+mY+apR9iYrvsFkZ+c1TA+g==
Received: from localhost (83-245-197-232.elisa-laajakaista.fi [83.245.197.232])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sakkinen)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4WNZVL6DdKzyT2;
	Tue, 16 Jul 2024 13:06:49 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1721124413;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EdoOS1Vx+qVFB1EZYjKbADIDpN3WKdD3NXCzP1l8TEc=;
	b=b4ReaF9y8dRqV59aja1fjnq0qUGK8jKtKo4rGLbkq6SYT7dUdSNJ5xHMkTNP8By/g4aOW5
	QgaLyxrm4t8gP/m50pLB4kVuzjK+cOaovfagPrgmnXVnX7Q8EoQq6F6c7L4vPcq0hPPRms
	LfA+OgdkNoiD4z1woGIgSr1MvXS6rNE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1721124413;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EdoOS1Vx+qVFB1EZYjKbADIDpN3WKdD3NXCzP1l8TEc=;
	b=qqVfNR58AMWIU9S1I8LbK7x47ttvNaOp2BVSr03w76oRvu537Lq5/pj+2kOQeaME/N4DGm
	sHGWaAuAImJKxnoluQxu9A9ZpK4+Y2kP+SvxywdO039lWZ5CK/oKLMkexk0oR+P04f8C9t
	LwQNiHCkbxWHdyY73B39B88Atu7xNqE=
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1721124413; a=rsa-sha256; cv=none;
	b=bcrJbs+z2VvEPuakv3T2Q07ItztVLO/4lg4IHlWAeDPVB1Xfq3BccIFufL7W1sO7kzQhQN
	4084IFC+Y3tIXoZVxngQ7co34FCeSGsZcTsUltWG4R8BT/Ztun77AUTbrZ1pWpOW99goVr
	M66E9SqG6394+HaMJjkdg/epoCx/Bo8=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=sakkinen smtp.mailfrom=jarkko.sakkinen@iki.fi
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 16 Jul 2024 13:06:49 +0300
Message-Id: <D2QVOMDX6BJW.3GCX7CFZL4KSF@iki.fi>
Cc: <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Hao
 Ge" <gehao@kylinos.cn>
Subject: Re: [PATCH] tpm: Move dereference after NULL check in
 tpm_buf_check_hmac_response
From: "Jarkko Sakkinen" <jarkko.sakkinen@iki.fi>
To: "James Bottomley" <James.Bottomley@HansenPartnership.com>, "Jarkko
 Sakkinen" <jarkko@kernel.org>, "Hao Ge" <hao.ge@linux.dev>,
 <peterhuewe@gmx.de>, <jgg@ziepe.ca>
X-Mailer: aerc 0.17.0
References: <20240709023337.102509-1-hao.ge@linux.dev>
 <D2Q2Q4R8BZ4Q.2QZF7NM3RE9B8@kernel.org>
 <f6ab30f39a14550b6fc111feb83b2657006b8b8c.camel@HansenPartnership.com>
In-Reply-To: <f6ab30f39a14550b6fc111feb83b2657006b8b8c.camel@HansenPartnership.com>

On Mon Jul 15, 2024 at 2:52 PM EEST, James Bottomley wrote:
> On Mon, 2024-07-15 at 14:25 +0300, Jarkko Sakkinen wrote:
> > On Tue Jul 9, 2024 at 5:33 AM EEST, Hao Ge wrote:
> > > From: Hao Ge <gehao@kylinos.cn>
> > >=20
> > > We shouldn't dereference "auth" until after we have checked that it
> > > is
> > > non-NULL.
> > >=20
> > > Fixes: 7ca110f2679b ("tpm: Address !chip->auth in
> > > tpm_buf_append_hmac_session*()")
> > > Signed-off-by: Hao Ge <gehao@kylinos.cn>
> >=20
> > Also lacking:
> >=20
> > Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> > Closes:
> > https://lore.kernel.org/linux-integrity/3b1755a9-b12f-42fc-b26d-de2fe4e=
13ec2@stanley.mountain/T/#u
> >=20
> > What is happening here is that my commit exposed pre-existing bug to
> > static analysis but it did not introduce a new regression.
>
> Actually, it didn't.  The previous design was sessions were config
> determined and either auth would be non-NULL or attach would fail.  You
> chose with this series to make auth the indicator of whether sessions
> should be used, and before this auth could not be NULL so no bug
> existed.

Not on at least one driver, which does not call tpm2_sessions_init().

What do you exactly mean by design? It is first time I hear anyone to
claim that validating pointer is an alternative design.

Before my fixes:

int tpm_buf_check_hmac_response(struct tpm_chip *chip, struct tpm_buf *buf,
				int rc)
{
	struct tpm_header *head =3D (struct tpm_header *)buf->data;
	struct tpm2_auth *auth =3D chip->auth;
I.e.

Fixes: 1085b8276bb4 ("tpm: Add the rest of the session HMAC API")

Even in the current master there is still inline function that when HMAC
is disable:

static inline int tpm_buf_check_hmac_response(struct tpm_chip *chip,
					      struct tpm_buf *buf,
					      int rc)
{
	return rc;
}

>
> Consider also the fidelity of the Fixes tag for stable: this commit
> needs backporting with 7ca110f2679b and Fixes should identify that
>
> James

I'd suggest for you to focus fixing issue and not complaining about
irrelevant stuff.

And I'd suggest IBM to do better job next time as a company, and test
at least with your own hardware before sending anything.

BR, Jarkko

