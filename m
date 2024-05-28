Return-Path: <linux-integrity+bounces-2687-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 59D118D2733
	for <lists+linux-integrity@lfdr.de>; Tue, 28 May 2024 23:42:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09A561F23C42
	for <lists+linux-integrity@lfdr.de>; Tue, 28 May 2024 21:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C331517BB19;
	Tue, 28 May 2024 21:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qo7rPQiW"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3806F06E;
	Tue, 28 May 2024 21:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716932534; cv=none; b=RvDPs43Cu0d6X1+WlTXR99BT+fA7I3JzwKsdVJ+/7Zsd9WUM9zmjB0RjESpJSMNyFYuInQag7qCnKbQcBqLmZL6AmUXl1nvIUuE+mcoEpIbjqIwhZUwHIUA4Jqd9wMsIdUnTXL1QIFm9ZP9HA7oIhq1Ias6nBIoHzCFnNk9Ro18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716932534; c=relaxed/simple;
	bh=fT1XyUb8dOaA5u2tXh9YwMja9Vme8HOQuPXfz4rV3/Q=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=VeWJc0osdgGJ0yiCK0287REcKdiyQubns6/uNBXnral1n6WDlHWXFfFopGp9wjeGT1qbMWENQDjC6dqy1eeT/lqS+A0mzVEahDCupwIrivvDx4n5fuN3CjJnOnaxPPOLbM2NBqWA2bkatY9rYMXCvYLP+ILOVnxjiYz60w1YGDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qo7rPQiW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15F9AC3277B;
	Tue, 28 May 2024 21:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716932534;
	bh=fT1XyUb8dOaA5u2tXh9YwMja9Vme8HOQuPXfz4rV3/Q=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=qo7rPQiW11ANRpMxlP9+Jz8jxcpnSm8ARaYhzF/M5MkXEk+VzgxYag3CEQRv+a2TR
	 HNYB5zdBaimW9VOZHkmcscYMFY/KxkNzZUC8soVNlOWHgP5cPUxet+Ajo0GIFM9wbz
	 1cV3lK4Y6gYimZStjVR+/uUkDagUavbh1nFjk0Fdsurousy8g+8oh58jL2pKFSHukB
	 Es6mNxZD/ohFjhrirfgqVMP1k6cw6k+2leBrjv4dSjK4JnzrbrhQf6uGHGwJDCCNLy
	 NINmyEsVs8tV0/pIb5DhBAB01e6iP5scHMSLfnXwM7VP0w69xaol+N7d67Wrbal1jj
	 8p0EJwTZUXvvg==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 29 May 2024 00:42:08 +0300
Message-Id: <D1LLSAS0YN47.18EIHL1KRF2UR@kernel.org>
Cc: <linux-integrity@vger.kernel.org>, <keyrings@vger.kernel.org>,
 <Andreas.Fuchs@infineon.com>, "James Prestwood" <prestwoj@gmail.com>,
 "David Woodhouse" <dwmw2@infradead.org>, "Eric Biggers"
 <ebiggers@kernel.org>, "James Bottomley"
 <James.Bottomley@hansenpartnership.com>, <linux-crypto@vger.kernel.org>,
 "Stefan Berger" <stefanb@linux.ibm.com>, "Lennart Poettering"
 <lennart@poettering.net>, "David S. Miller" <davem@davemloft.net>, "open
 list" <linux-kernel@vger.kernel.org>, "David Howells"
 <dhowells@redhat.com>, "Peter Huewe" <peterhuewe@gmx.de>, "Jason Gunthorpe"
 <jgg@ziepe.ca>, "James Bottomley" <James.Bottomley@HansenPartnership.com>,
 "Ard Biesheuvel" <ardb@kernel.org>, "Mario Limonciello"
 <mario.limonciello@amd.com>
Subject: Re: [PATCH v7 5/5] keys: asymmetric: Add tpm2_key_ecdsa
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, "Herbert Xu"
 <herbert@gondor.apana.org.au>
X-Mailer: aerc 0.17.0
References: <20240528210823.28798-1-jarkko@kernel.org>
 <20240528210823.28798-6-jarkko@kernel.org>
In-Reply-To: <20240528210823.28798-6-jarkko@kernel.org>

On Wed May 29, 2024 at 12:08 AM EEST, Jarkko Sakkinen wrote:
> +	/* Encode the ASN.1 signature: */
> +#define TPM2_KEY_ECDSA_SIG_SIZE		(2 + 2 * (2 + SHA256_DIGEST_SIZE) + r_0=
 + s_0)
> +	pr_info("sig_size=3D%d\n", TPM2_KEY_ECDSA_SIG_SIZE);
> +	ptr[0] =3D 0x30; /* SEQUENCE */
> +	ptr[1] =3D TPM2_KEY_ECDSA_SIG_SIZE - 2;
> +#define TPM2_KEY_ECDSA_SIG_R_TAG	2
> +#define TPM2_KEY_ECDSA_SIG_R_SIZE	3
> +#define TPM2_KEY_ECDSA_SIG_R_BODY	4
> +	ptr[TPM2_KEY_ECDSA_SIG_R_TAG] =3D 0x02; /* INTEGER */
> +	ptr[TPM2_KEY_ECDSA_SIG_R_SIZE] =3D SHA256_DIGEST_SIZE + r_0;
> +	ptr[TPM2_KEY_ECDSA_SIG_R_BODY] =3D 0x00; /* maybe dummy write */
> +	memcpy(&ptr[TPM2_KEY_ECDSA_SIG_R_BODY + r_0], r, SHA256_DIGEST_SIZE);
> +#define TPM2_KEY_ECDSA_SIG_S_TAG	(4 + r_0 + SHA256_DIGEST_SIZE)
> +#define TPM2_KEY_ECDSA_SIG_S_SIZE	(5 + r_0 + SHA256_DIGEST_SIZE)
> +#define TPM2_KEY_ECDSA_SIG_S_BODY	(6 + r_0 + SHA256_DIGEST_SIZE)
> +	ptr[TPM2_KEY_ECDSA_SIG_S_TAG] =3D 0x02; /* INTEGER */
> +	ptr[TPM2_KEY_ECDSA_SIG_S_SIZE] =3D SHA256_DIGEST_SIZE + s_0;
> +	ptr[TPM2_KEY_ECDSA_SIG_S_BODY] =3D 0x00; /* maybe dummy write */
> +	memcpy(&ptr[TPM2_KEY_ECDSA_SIG_S_BODY + s_0], s, SHA256_DIGEST_SIZE);
> +	ret =3D TPM2_KEY_ECDSA_SIG_SIZE;

Stefan, so this how I realized the signature encoding, thanks to
your earlier remarks [1]! I found out based on that a few glitches
and ended up with this better structured ECDSA signature encoder,
so thank you for doing that.

[1] https://lore.kernel.org/linux-crypto/b5ff9003-065f-437f-bf6b-7f1ae0a036=
4a@linux.ibm.com/

BR, Jarkko

