Return-Path: <linux-integrity+bounces-1947-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63A25893B28
	for <lists+linux-integrity@lfdr.de>; Mon,  1 Apr 2024 14:57:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00C641F21BFC
	for <lists+linux-integrity@lfdr.de>; Mon,  1 Apr 2024 12:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5AB42A1C0;
	Mon,  1 Apr 2024 12:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nNWxs89d"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA6C21A0C;
	Mon,  1 Apr 2024 12:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711976246; cv=none; b=nmazU7stpQB5GJqxSiJLAPtcmqyIfnqJoKlRBpg6kxDnoTDecynT9yE6xMClIH9vAbjrWghWB4EFJWoBibmIs2QjAP3LmoMUJ/6N9O+vP+iEtJp7zxsfctNgHrR6oFWM1ErLwhB0KYZ0YAT1EjlpKlGnE0klAh1mTqoAmFsxAtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711976246; c=relaxed/simple;
	bh=gpOFSkLnqzB3ioyi0XC96FzcBU/X4d1xrYS8Qc2h4Jw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=TFAgJLXo6O7Dho3q3ysEv41ZTW7oEeOGVOEUFCNrXkHbCn8Ywz9LQpi1Omkub9KHpAJKY/tq49hqZczTDMCJQNmpaFnCWnacb6kraNfPqb8KLf6cPvVM6mrggMJWzcKjPPsm4seHHwOox1GsTY9ffHg3zMqI8QBghG87BedZdOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nNWxs89d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF95DC433F1;
	Mon,  1 Apr 2024 12:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711976246;
	bh=gpOFSkLnqzB3ioyi0XC96FzcBU/X4d1xrYS8Qc2h4Jw=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=nNWxs89dn6spYlKmu52vsv4hTKtSyvEHlnp33uNmkC1SsxjK3zohuQFM9d1R5aEsV
	 GMhu+UFbjKV5XHJvFzngiDD3zvHxrbEh/nJd4G6CSTpqZuqXtO3uNWnTNNKYseqdeP
	 JZivGVmjRnh8B1CB33K5Xsrqc3/tvLCz/WEEfOnjEkGSN48tGhTImcvU+LWRjZQW68
	 4M6wDr8lQ/rJVhQe22AYmZjryKhBPxaj56HXIAAXLh7bmbkQwsZboyoG94XGqpw2i/
	 qRKQ45ggK2RFMa5uibmrTaRFi9405YXfeIsztAYnPweq2LIAeXDyalew9jnO22LeU+
	 EPwWxS/BXxx2g==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 01 Apr 2024 15:57:22 +0300
Message-Id: <D08SXGNWN4PG.8KW3OIV7WTIK@kernel.org>
Subject: Re: [PATCH v7 12/21] tpm: Add NULL primary creation
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: =?utf-8?q?Gabr=C3=ADel_Arth=C3=BAr_P=C3=A9tursson?= <gabriel@system.is>,
 "James Bottomley" <James.Bottomley@HansenPartnership.com>,
 <linux-integrity@vger.kernel.org>
Cc: <keyrings@vger.kernel.org>, "Ard Biesheuvel" <ardb@kernel.org>
X-Mailer: aerc 0.17.0
References: <20240213171334.30479-1-James.Bottomley@HansenPartnership.com>
 <20240213171334.30479-13-James.Bottomley@HansenPartnership.com>
 <05c7d10b23e74269efd720eedbb1773931b0ad46.camel@system.is>
 <D08273C2C8HD.2QT57ZPAWPS9H@kernel.org>
 <ea2a3a9a2bea2f1af5565ed32e9584caee2fbecf.camel@system.is>
In-Reply-To: <ea2a3a9a2bea2f1af5565ed32e9584caee2fbecf.camel@system.is>

On Sun Mar 31, 2024 at 7:52 PM EEST, Gabr=C3=ADel Arth=C3=BAr P=C3=A9tursso=
n wrote:
> On Sun, 2024-03-31 at 19:00 +0300, Jarkko Sakkinen wrote:
> > Null key is not provisioned, what is the motivation here?
>
> The terms here, to create a key and to provision a key, are almost
> interchangeable. The latter merely implies the additional step of
> saving the key to NVRAM and making it available through a persistent
> handle.
>
> The template, aside from defining what kind of key we want to create,
> is fed into the TPM's KDF used to generate the key. Different template,
> different key.
>
> Userspace will want to recreate the same key the kernel has, thus must
> use the same template. Which template shall be used then?

I don't disagree with you, nor did when sending the first response :-)

Downstream seems to break that guide tho. E.g. Ubuntu uses 0x80100001
NV index for storage key unsealing the key slot with PCR values. I did
some time ago a quick VM install of Ubuntu just to see how it uses TPM2.

I got:

$ sudo tpm2_getcap handles-persistent
- 0x81000001
- 0x81010001

0x81010001 is according to provisioning guide EK handle but Ubuntu uses
it for completely different purpose.

What I would like to understand when it comes to the provisioning guide
is how important it is in reality? I have no information at this point
is e.g. systemd-boot going to follow it but would like to know.


>
> +	/*
> +	 * create the template.  Note: in order for userspace to
> +	 * verify the security of the system, it will have to create
> +	 * and certify this NULL primary, meaning all the template
> +	 * parameters will have to be identical, so conform exactly to
> +	 * the TCG TPM v2.0 Provisioning Guidance for the SRK ECC
> +	 * key
> +	 */
>
> The TPM specifications have a standardized set of templates for the
> Endorsement Keys, and a recommendation on a template to
> create/provision the shared SRK.
>
> Why not use that one then, above something else? We are required to use
> a template for key generation after all, might as well pick the one
> most fitting from the standards.
>
> That's at least my understanding of the author's motivation.

Yeah, not necessarily disagree with this or I'm somewhat aligned to this
view. Ubuntu's architecture confuses me so would like to understand the
magnitude of the provisioning guide.

>
> > So for the time being the patch set is NAK just because we lack
> > clear definition of done here. I revisit it only when I know how
> > to test it.
>
> I want to note that I'm not affiliated with the patches' author. I'm
> merely an outside observer who has taken interest in the proposed
> changes. Wanted to share my thoughts.

BR, Jarkko

