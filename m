Return-Path: <linux-integrity+bounces-2691-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51AD08D29CB
	for <lists+linux-integrity@lfdr.de>; Wed, 29 May 2024 03:15:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00E7A285341
	for <lists+linux-integrity@lfdr.de>; Wed, 29 May 2024 01:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45DA215A868;
	Wed, 29 May 2024 01:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kGpROf/I"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B26615A850;
	Wed, 29 May 2024 01:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716945305; cv=none; b=MZHg0un97r2vHJnYulmOqEOqvnzfD878ZoQDtChqWykJfa5klDrHmB4+AuRXH15fpPbXKdUrBvWqKPuR2oGH85mt7+V7H8pYMjkKfGXr6I/6SdUvTx+40Y/1Cl7K5W9IHFCWgprJPCgaXI2+tttYSZyv1bLQhNfm6XABdScNuXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716945305; c=relaxed/simple;
	bh=/GfoeoRReOIcuGfxqsKcE/ssX+1CbriDPv2XiapiR74=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=qENrCbMT04/mrMf2REBnQ0QKJ++W7zANR800aH2euPcxuCpRt0du9KN4fSdd5JD4E8wqTTbpzQBw7/iu2MYns0GG8zgfsp3hRhfPIlLtpUAJuPcB2QSwlVaanwQLdV5EwbEJPNTpiaX92wgIYf2ZybfPuV1m4NaPFgDaHkikez0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kGpROf/I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E412EC3277B;
	Wed, 29 May 2024 01:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716945304;
	bh=/GfoeoRReOIcuGfxqsKcE/ssX+1CbriDPv2XiapiR74=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=kGpROf/I0sN3dx/iNmVuHImgJXfDfwZBIR422JA711ML9z8bQffVQXre2gwdwVhne
	 ZTaO0t0IJPgbG+JH1ylOornajxZYDZv1o3x7eHmHZye4dYNMhEspCsnIU38YoQfJ3c
	 3EiDqEAMry/ziID4lUCX/2IEH9vk6f7ApybGt7i58uoXK4PeCcdVSrC9nI8vLltVwB
	 KFswRC1P7gWiKQnV99yMIdKjB9uhm+qrBJMAMzWP4LlO6LHhsCFoJnkZLvM3Wmmu+G
	 NzvjOjXbb5HQgRDhD5t7VlftKbs4fbA97YKmaGlKx+S2cLNo2rcFnkNQGmIpKf+U6L
	 8G6VYRd40/FLw==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 29 May 2024 04:14:58 +0300
Message-Id: <D1LQB9HGZ7JK.1VDGJVT6IPHDB@kernel.org>
Cc: <linux-integrity@vger.kernel.org>, <keyrings@vger.kernel.org>,
 <Andreas.Fuchs@infineon.com>, "James Prestwood" <prestwoj@gmail.com>,
 "David Woodhouse" <dwmw2@infradead.org>, "Eric Biggers"
 <ebiggers@kernel.org>, "James Bottomley"
 <James.Bottomley@hansenpartnership.com>, <linux-crypto@vger.kernel.org>,
 "Lennart Poettering" <lennart@poettering.net>, "David S. Miller"
 <davem@davemloft.net>, "open list" <linux-kernel@vger.kernel.org>, "David
 Howells" <dhowells@redhat.com>, "Peter Huewe" <peterhuewe@gmx.de>, "Jason
 Gunthorpe" <jgg@ziepe.ca>, "Ard Biesheuvel" <ardb@kernel.org>, "Mario
 Limonciello" <mario.limonciello@amd.com>
Subject: Re: [PATCH v7 5/5] keys: asymmetric: Add tpm2_key_ecdsa
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Stefan Berger" <stefanb@linux.ibm.com>, "Herbert Xu"
 <herbert@gondor.apana.org.au>
X-Mailer: aerc 0.17.0
References: <20240528210823.28798-1-jarkko@kernel.org>
 <20240528210823.28798-6-jarkko@kernel.org>
 <ce1d3188-046d-42c1-b8a7-17325d791ec5@linux.ibm.com>
In-Reply-To: <ce1d3188-046d-42c1-b8a7-17325d791ec5@linux.ibm.com>

On Wed May 29, 2024 at 2:15 AM EEST, Stefan Berger wrote:
> > +	ptr[TPM2_KEY_ECDSA_SIG_R_TAG] =3D 0x02; /* INTEGER */
> > +	ptr[TPM2_KEY_ECDSA_SIG_R_SIZE] =3D SHA256_DIGEST_SIZE + r_0;
>
> The size of the signature has nothing to do with the size of the hash.=20
> SHA256_DIGEST_SIZE (32) happens to match the number of bytes of a=20
> coordinate of prime256v1 / NIST p256 but should fail when you use=20
> secp521r1 / NIST p521 since then r or s may then be 66 or 67 bytes (if=20
> most sign. bit is set) long.

First remark did not go unnoticed, so thanks for both. There was not
just much to comment on it :-)

I could just replace the constant with a (range checked) variable
read from the response and overall structure woud be the same.

This will also mean that in the case of P521 also prefix byte (0x81) is
required but just for the sequence I think, not for the integers.

Finally, I need to implement p521 smoke test for testing this patch set.

One big letdown that I only now have consciously realized, is that TCG
does not have p256k1 in their algorithm repository. It is the basis for
quite a few blockchain technologies. I wonder why...

BR, Jarkko

