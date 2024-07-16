Return-Path: <linux-integrity+bounces-3122-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16C5993247F
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Jul 2024 12:57:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3CDB283643
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Jul 2024 10:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5908517D371;
	Tue, 16 Jul 2024 10:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hv8DaxJl"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31FA313A416;
	Tue, 16 Jul 2024 10:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721127463; cv=none; b=AxxtRZxH5Z6csMIULfE3OCrzI3rYwqOs5lB/tSUOORoKOp32H+rmVs7dIM3hsWzpb1VjTOCxliufZ1H6VmCsvqeF6uBUiyI6SeTQLe7a+30wiwXS5u/4ab3g/12DwV2ohd8+oL2FdAvbCMszJ+qLUEeOtWr44AX3LYGjlh/nLZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721127463; c=relaxed/simple;
	bh=aocP7RUGsmhvJkehNMWI/c4VBoqY60Gv7KuiloPxwhs=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=SkusTTbHVf1GphY1cAmqSOLjTVFwj67+neJsS4/gFqkaTJPiNfUgdFeTJWBtfjRLPdPaSLwa9zVqFMngiVi7vCgdQwetAv/bA2Rpdvjl60VYxv7rcTshTDEkquKzIXnCM+s2riE8iJhzPJVl4H/0aZpSP4f9L2Jm1af/6VhjXCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hv8DaxJl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A675C116B1;
	Tue, 16 Jul 2024 10:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721127462;
	bh=aocP7RUGsmhvJkehNMWI/c4VBoqY60Gv7KuiloPxwhs=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=Hv8DaxJl/t7ZHe9XvQzrSs5N487r48E/fAWYqcv2MpLjwgz7hkTDbBhCSb9GWJE7f
	 yGBiwUvOPb5bURl99TU8kA6a2mKynDAgofa0QiJp9FEw4dBg4RxGq8dofDPpA30FTu
	 hlXlMh4daX8WqIszuweEMUCQsvqD/l/bunF42v8+mxqmC7LvdGDIv94CJ5QxJDnYcp
	 7u64BU3Z0lSokZO4ffZWbGL4dI7nDkThGjRuzr/t0Nzn7iodGm+J73Zjox2ukIGCeu
	 d12qky3rIxX6PZEaXCrhV1e1CTIPAw/sd81wBp1P2EnvYvP78BgdqSaMl4/dW4dC3X
	 DntTnoKy9b22g==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 16 Jul 2024 13:57:39 +0300
Message-Id: <D2QWRJMX5UZY.3EO7G8DMPU1ZQ@kernel.org>
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

Changed to:

https://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git/comm=
it/?id=3D7dc357d343f134bf59815ff6098b93503ec8a23b

Just fixed some typos.

BR, Jarkko

