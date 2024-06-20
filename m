Return-Path: <linux-integrity+bounces-2880-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2670090FA39
	for <lists+linux-integrity@lfdr.de>; Thu, 20 Jun 2024 02:23:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9DEF2824DB
	for <lists+linux-integrity@lfdr.de>; Thu, 20 Jun 2024 00:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D6E4EBE;
	Thu, 20 Jun 2024 00:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hrJMVA0I"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6C0803;
	Thu, 20 Jun 2024 00:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718843005; cv=none; b=JZg/Wyz5m1QeD45kJ/q/uqsGTdm9gIaDveq0pj8bu3+RwpV+QTWvnEJ4xUFUCRwZvGtLlC1U+4kG2+JmqOisHyozon3qB4VNYSyn+vHrmOE6oRnJyX2cqJqtNR5sPGDlkUYIyE1Pz2HBSYJJS9//n6Fu87NmuiBJZQZeyEo2yRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718843005; c=relaxed/simple;
	bh=d3OtyHiPBpAMHwkS1fY/T/elpykN7rWfV3gkhyA4qlg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=JJWdzY9FwjYIcc7xHZGaoGTKTw6iV4/amRB6gedIOaTvH+0S1BPhl43aOrd/KlsN+VIBPvxdwHUqzqx1E0e8ZubGx1A0rZk4ILN5pkGn5QaSAHhikNizPjN5eHVPTNNgcVdi6biwBJCsk7fxUZGUiWczbCvcft/FxM435OGP3oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hrJMVA0I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15DBEC2BBFC;
	Thu, 20 Jun 2024 00:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718843005;
	bh=d3OtyHiPBpAMHwkS1fY/T/elpykN7rWfV3gkhyA4qlg=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=hrJMVA0Iyyo086AWTeUgF0nVYPfiRRPwHmUHW35Wvej3TptCGqS28OwaqHP7mQz6a
	 ZnsksPur7IqB1TZbgl42LikHrbWjRBpY8vTtv5bKX14+zznQZTVAqE/OevE1EM2oxL
	 d0rVOolq7soiBzO4ZQp3HaUjq7jWo9RyyljleElchwVy9w2DG6u/sRi+LyEDsl1K44
	 gsG3yK0QbyD8VR+fZTRhXHB4asoVF9DbbbQX0DxBv+jbq0g474YmGqFEvr5AIfPV1R
	 ScMCL9vkicJOm+Jst3nkJmcJCaXsmVj0FUIYWzmpPYgErS4whvgK1g9hEfyU5Nemy6
	 1kp00BWuEk5Ow==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 20 Jun 2024 03:23:20 +0300
Message-Id: <D24EZPFV6DBS.1LZVHIVPITE83@kernel.org>
Cc: <linux-integrity@vger.kernel.org>, <keyrings@vger.kernel.org>,
 <Andreas.Fuchs@infineon.com>, "James Prestwood" <prestwoj@gmail.com>,
 "David Woodhouse" <dwmw2@infradead.org>, "Eric Biggers"
 <ebiggers@kernel.org>, "James Bottomley"
 <James.Bottomley@hansenpartnership.com>, <linux-crypto@vger.kernel.org>,
 "Stefan Berger" <stefanb@linux.ibm.com>, "Lennart Poettering"
 <lennart@poettering.net>, "David S. Miller" <davem@davemloft.net>, "open
 list" <linux-kernel@vger.kernel.org>, "David Howells"
 <dhowells@redhat.com>, "Ard Biesheuvel" <ardb@kernel.org>, "Mario
 Limonciello" <mario.limonciello@amd.com>
Subject: Re: [PATCH v7 4/5] keys: asymmetric: Add tpm2_key_rsa
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Herbert Xu" <herbert@gondor.apana.org.au>
X-Mailer: aerc 0.17.0
References: <20240528210823.28798-1-jarkko@kernel.org>
 <20240528210823.28798-5-jarkko@kernel.org>
 <ZmLnyp9j_QoPgj7W@gondor.apana.org.au>
In-Reply-To: <ZmLnyp9j_QoPgj7W@gondor.apana.org.au>

On Fri Jun 7, 2024 at 1:58 PM EEST, Herbert Xu wrote:
> On Wed, May 29, 2024 at 12:08:09AM +0300, Jarkko Sakkinen wrote:
> >
> > +/*
> > + * Sign operation is an encryption using the TPM's private key. With R=
SA the
> > + * only difference between encryption and decryption is where the padd=
ing goes.
> > + * Since own padding can be used, TPM2_RSA_Decrypt can be repurposed t=
o do
> > + * encryption.
> > + */
> > +static int tpm2_key_rsa_sign(struct tpm_chip *chip, struct tpm2_key *k=
ey,
> > +			     struct kernel_pkey_params *params,
> > +			     const void *in, void *out)
> > +{
> > +	const off_t o =3D key->priv_len + 2 + sizeof(*key->desc);
> > +	const struct tpm2_rsa_parms *p =3D
> > +		(const struct tpm2_rsa_parms *)&key->data[o];
> > +	const u16 mod_size =3D be16_to_cpu(p->modulus_size);
> > +	const struct rsa_asn1_template *asn1;
> > +	u32 in_len =3D params->in_len;
> > +	void *asn1_wrapped =3D NULL;
> > +	u8 *padded;
> > +	int ret;
> > +
> > +	if (strcmp(params->encoding, "pkcs1") !=3D 0) {
> > +		ret =3D -ENOPKG;
> > +		goto err;
> > +	}
> > +
> > +	if (params->hash_algo) {
> > +		asn1 =3D rsa_lookup_asn1(params->hash_algo);
>
> Could you please explain why this can't be done through pkcs1pad
> instead of going to raw RSA?

Sorry was away couple of weeks from here. I replace this with TPM2_Sign
as is done already in the ECDSA module, so I guess that is a "yes".

BR, Jarkko

