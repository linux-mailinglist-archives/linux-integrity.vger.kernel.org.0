Return-Path: <linux-integrity+bounces-3121-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82A2C932429
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Jul 2024 12:35:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B449D1C21D0E
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Jul 2024 10:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C90731953A8;
	Tue, 16 Jul 2024 10:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="biZCTbj5"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC4913A416;
	Tue, 16 Jul 2024 10:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721126104; cv=none; b=GJIS2jJbiReCt6QSuGcRVD8kR2XI20z78kWJaGHX/rUwNOLZyO/ZT3w/OkVDsOE0CCvmVClk0mp+fqELZbHhe3+QXG/KEyrDUZpDubM4WKkKzKfQfTeZT0vf7UP9q0BCqOOrDktYcIt6+1Dyxw6TsFyR8tNDhHEadw94wZ79Rcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721126104; c=relaxed/simple;
	bh=eJiqRuQmKJQERR+6BcHrH8SKSeh06gC7Eg3zdfByhkE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=U7dtqac3MvOd69MG+5SnafrpS0pBIwWvzUUytDNhlYlJFdWwzQRE5I9ys5h3Y33kWvRITFwlMnaxFnngSjAc4MvgJuQ6s7uryz7DNzmZWSz2See4e10IXkF42e9soPLZQTEmH7pC/bizMEjepGAwMUlKf3nlNvJ/navZuE1zXaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=biZCTbj5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA283C4AF09;
	Tue, 16 Jul 2024 10:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721126104;
	bh=eJiqRuQmKJQERR+6BcHrH8SKSeh06gC7Eg3zdfByhkE=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=biZCTbj53KTpBTYWVA3UfY97jOkdKmSD+6P697g36IOo7Xed3us/4WGo/x3ij17ie
	 sl+/kn2NIv0qilmtYTt/bKB2LLxUe/I82JqGdPwNhI3Bwk/uPeRCJpv+2e7XD2l/Hv
	 QPQo1D+Ssz3XdDZfV7Ssjtv5BAgt8slXm/RCzPVqTVYMbskufInsBbMsELN8hYdEUb
	 MQHJtBKZv3akDPy1Kumy4r+FqwyHhVhh6S2rR8fo7nDLSrpf3xb+rbsTEI4m40yZYu
	 VnfZ+D1olP1eJ2WVouQ6Vq0VOqTy9sBf8mg4nj7Fk1jDltzP3gQf1EIHrW1iowj+2/
	 B/st0BF/aQ7SA==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 16 Jul 2024 13:35:01 +0300
Message-Id: <D2QWA7IQG4EB.3QT4BMDQ75I3U@kernel.org>
Cc: <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Hao
 Ge" <gehao@kylinos.cn>
Subject: Re: [PATCH] tpm: Move dereference after NULL check in
 tpm_buf_check_hmac_response
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, "Hao Ge" <hao.ge@linux.dev>,
 <peterhuewe@gmx.de>, <jgg@ziepe.ca>
X-Mailer: aerc 0.17.0
References: <20240709023337.102509-1-hao.ge@linux.dev>
 <D2QW8VSPX777.34R28W8GVXKMS@kernel.org>
In-Reply-To: <D2QW8VSPX777.34R28W8GVXKMS@kernel.org>

On Tue Jul 16, 2024 at 1:33 PM EEST, Jarkko Sakkinen wrote:
> On Tue Jul 9, 2024 at 5:33 AM EEST, Hao Ge wrote:
> > From: Hao Ge <gehao@kylinos.cn>
> >
> > We shouldn't dereference "auth" until after we have checked that it is
> > non-NULL.
> >
> > Fixes: 7ca110f2679b ("tpm: Address !chip->auth in tpm_buf_append_hmac_s=
ession*()")
> > Signed-off-by: Hao Ge <gehao@kylinos.cn>
> > ---
> >  drivers/char/tpm/tpm2-sessions.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-s=
essions.c
> > index 2281d55df545..d3521aadd43e 100644
> > --- a/drivers/char/tpm/tpm2-sessions.c
> > +++ b/drivers/char/tpm/tpm2-sessions.c
> > @@ -746,15 +746,16 @@ int tpm_buf_check_hmac_response(struct tpm_chip *=
chip, struct tpm_buf *buf,
> >  	struct tpm2_auth *auth =3D chip->auth;
> >  	off_t offset_s, offset_p;
> >  	u8 rphash[SHA256_DIGEST_SIZE];
> > -	u32 attrs;
> > +	u32 attrs, cc;
> >  	struct sha256_state sctx;
> >  	u16 tag =3D be16_to_cpu(head->tag);
> > -	u32 cc =3D be32_to_cpu(auth->ordinal);
> >  	int parm_len, len, i, handles;
> > =20
> >  	if (!auth)
> >  		return rc;
> > =20
> > +	cc =3D be32_to_cpu(auth->ordinal);
> > +
> >  	if (auth->session >=3D TPM_HEADER_SIZE) {
> >  		WARN(1, "tpm session not filled correctly\n");
> >  		goto out;
>
> Please check:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git/co=
mmit/?id=3D72d6e06ed101e31e943937e42053fc690dc75cfe
>
> It is exactly this except commit message is tuned. And please denote
> that I'm on holiday ;-)
>
> If that works for you, I can put it to my -rc PR.
>
> Thank you.

Again because of holiday I failed to notice that my 6.11 PR's were
accepted and since it is only Tue, I'm sure I squeeze one commit PR
still -rc1, if a quick response.

BR, Jarkko

