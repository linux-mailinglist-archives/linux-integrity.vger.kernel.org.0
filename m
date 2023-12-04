Return-Path: <linux-integrity+bounces-331-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3D6C802AA8
	for <lists+linux-integrity@lfdr.de>; Mon,  4 Dec 2023 05:03:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9303A280C26
	for <lists+linux-integrity@lfdr.de>; Mon,  4 Dec 2023 04:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98417443D;
	Mon,  4 Dec 2023 04:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C6on9/5x"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F924435
	for <linux-integrity@vger.kernel.org>; Mon,  4 Dec 2023 04:03:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82196C433C8;
	Mon,  4 Dec 2023 04:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701662595;
	bh=BlD2kjSczsSH/ycYhVSejmca4qqJt+9gTUSthvlEfHU=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=C6on9/5xGnOuRl45vg8t4d1mrJ2HZXXaxgZs016cAd3TCToksnDqIgcIWDbuf19Br
	 J+yab7Txy5LHAqO4+lcKclqbXkY4Jb/32xhae89VB3aWuMY0NYylcT0cxLS9uK0bC2
	 OwMhvnko2tIPVPvWJ+ENOKkjG/US/+NVfpr06YpoIzIF4PooxBpaaQzgri+PBsJ1q7
	 7k+XneZ1NtpsBsobanYxw3ZL5gF40kW9HErXfmh611gpJ1pr1Z7i1sPk103V0AvZ6x
	 WBF5rO1VSBEus1gXzOpyFQGa23eKzE6gf31qIfFulbAJrhKK803hysZpTtm5JWmNPL
	 QByfAtus9aBZw==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 04 Dec 2023 06:03:11 +0200
Message-Id: <CXF91MI4A4C3.PIVZWW1SENCZ@suppilovahvero>
Cc: <linux-integrity@vger.kernel.org>, "James Bottomley"
 <jejb@linux.ibm.com>, "Mimi Zohar" <zohar@linux.ibm.com>, "David Howells"
 <dhowells@redhat.com>, "Paul Moore" <paul@paul-moore.com>, "James Morris"
 <jmorris@namei.org>
Subject: Re: [PATCH v5 8/8] KEYS: trusted: tpm2: Use struct tpm_buf for
 sized buffers
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Serge E. Hallyn" <serge@hallyn.com>
X-Mailer: aerc 0.15.2
References: <20231121223130.30824-1-jarkko@kernel.org>
 <20231121223130.30824-9-jarkko@kernel.org>
 <20231128034802.GA33794@mail.hallyn.com>
In-Reply-To: <20231128034802.GA33794@mail.hallyn.com>

On Tue Nov 28, 2023 at 5:48 AM EET, Serge E. Hallyn wrote:
> On Wed, Nov 22, 2023 at 12:31:20AM +0200, Jarkko Sakkinen wrote:
> > Take advantage of the new sized buffer (TPM2B) mode of struct tpm_buf i=
n
> > tpm2_seal_trusted(). This allows to add robustness to the command
> > construction without requiring to calculate buffer sizes manually.
> >=20
> > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> > ---
> > v3 [2023-11-21]: A boundary error check as response for the feeedback
> > from Mario Limenciello:
> > https://lore.kernel.org/linux-integrity/3f9086f6-935f-48a7-889b-c713984=
22fa1@amd.com/
> > v2: Use tpm_buf_read_*
> > ---
> >  security/keys/trusted-keys/trusted_tpm2.c | 54 +++++++++++++----------
> >  1 file changed, 31 insertions(+), 23 deletions(-)
> >=20
> > diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/=
trusted-keys/trusted_tpm2.c
> > index bc700f85f80b..97b1dfca2dba 100644
> > --- a/security/keys/trusted-keys/trusted_tpm2.c
> > +++ b/security/keys/trusted-keys/trusted_tpm2.c
> > @@ -228,8 +228,9 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
> >  		      struct trusted_key_payload *payload,
> >  		      struct trusted_key_options *options)
> >  {
> > +	off_t offset =3D TPM_HEADER_SIZE;
> > +	struct tpm_buf buf, sized;
> >  	int blob_len =3D 0;
> > -	struct tpm_buf buf;
> >  	u32 hash;
> >  	u32 flags;
> >  	int i;
> > @@ -258,6 +259,14 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
> >  		return rc;
> >  	}
> > =20
> > +	rc =3D tpm_buf_init_sized(&sized);
> > +	if (rc) {
> > +		tpm_buf_destroy(&buf);
>
> It won't really hurt, but at the moment if tpm_buf_init_sized() returns
> non-zero, then it must be returning -ENOMEM, and tpm_buf_destroy(&buf)
> is not needed, right?

It should cause corrateral damage since the rollback emits only
free_page(buf->data) and it will become NULL in the case when
tpm_buf_init_sized(). Despite that this behaviour is illegit and
the call should be removed. Thanks for the remark!

BR, Jarkko

