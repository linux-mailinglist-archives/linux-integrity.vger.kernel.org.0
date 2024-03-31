Return-Path: <linux-integrity+bounces-1940-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD202893227
	for <lists+linux-integrity@lfdr.de>; Sun, 31 Mar 2024 18:00:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 934A11F216AA
	for <lists+linux-integrity@lfdr.de>; Sun, 31 Mar 2024 16:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F289145335;
	Sun, 31 Mar 2024 16:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a0p89SrG"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F06144D1A;
	Sun, 31 Mar 2024 16:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711900831; cv=none; b=bnqvhcAgPKow4H6RjKW5YlMv8SxMgnEbg3iKEhSgdBZT5A4o7xlpd9ZsmPxPtMRg8JlBBYF17Wz9E1uCGr3kJ1Ca8ero9ju/7IXi4d1TrXXsvpZ+bynmcWT1U2PuvGdI90lxfAeJx9SRYOz2KZscnjQHWj3LbpgsRUAg5XOCC0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711900831; c=relaxed/simple;
	bh=7j5plQrPQqy/5yUjzicp9UkSgjWhKfMVImoBozbbatA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Zk/nlgdUDjFTFUh7YBlKDk7QTe6FwIPVQoIgKSkiuqMT+O7x8yijmf1LpxCp+1Koe7B3XxnPV9B2KcDrqM4UVB/C8I9jc3aX/i9Nd28MNYXO8pycAm00laDxz66s3NIOqWl3+yLWtXrqJXCuKUdIf3ppoX5x9ttherKyl3uY/HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a0p89SrG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E5C9C433F1;
	Sun, 31 Mar 2024 16:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711900830;
	bh=7j5plQrPQqy/5yUjzicp9UkSgjWhKfMVImoBozbbatA=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=a0p89SrGcET3Dtu44mT7XjpgTQsMnzA2/ItxBgt2rah7bRnge+rhkJnz9DxIW1/PH
	 1Qu8JuU3/N0LTlGGhwVhjM7kxYofESDouQvhJVDYKsDtlJpg7IyjegDdUsiDYXlokP
	 JwrN75DcINSiaX0iv2qCAZfUpRHVST6WswY4Uy3atdATSmUVeKxLLObngqiEWB2JDz
	 k+jX9JeMHAP06ldCN6vlyTk/GYCxJeAuQHbSDcyJUjCaxfHJZjuEGrbCfsueTtHpuN
	 B98wh3nR5mtZ9u2+34DKqB/5VGilroi8UVVoEYFWQDAdDitnLPivKpFrNYh/8hBvOJ
	 TH0djQaiiss6w==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 31 Mar 2024 19:00:27 +0300
Message-Id: <D08273C2C8HD.2QT57ZPAWPS9H@kernel.org>
Cc: <keyrings@vger.kernel.org>, "Ard Biesheuvel" <ardb@kernel.org>
Subject: Re: [PATCH v7 12/21] tpm: Add NULL primary creation
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: =?utf-8?q?Gabr=C3=ADel_Arth=C3=BAr_P=C3=A9tursson?= <gabriel@system.is>,
 "James Bottomley" <James.Bottomley@HansenPartnership.com>,
 <linux-integrity@vger.kernel.org>
X-Mailer: aerc 0.17.0
References: <20240213171334.30479-1-James.Bottomley@HansenPartnership.com>
 <20240213171334.30479-13-James.Bottomley@HansenPartnership.com>
 <05c7d10b23e74269efd720eedbb1773931b0ad46.camel@system.is>
In-Reply-To: <05c7d10b23e74269efd720eedbb1773931b0ad46.camel@system.is>

On Sat Mar 30, 2024 at 8:48 PM EET, Gabr=C3=ADel Arth=C3=BAr P=C3=A9tursson=
 wrote:
> On Tue, 2024-02-13 at 12:13 -0500, James Bottomley wrote:
> > +	/* unique: key specific; for ECC it is two points */
> > +	tpm_buf_append_u16(&template, 0);
> > +	tpm_buf_append_u16(&template, 0);
>
> Shouldn't the points be 32 bytes each in size, filled with zeros?
>
> The TCP TPM 2.0 Provisioning Guidance defines the SRK Template as a
> diff on top of Template L-2 (for ECC keys) as defined in the EK
> Credential Profile 2.0 document.
>
> Template L-2 calls for the X and Y points to be of 32 bytes each,
> filled with zeros. The Provisioning Guidance does not call for zero-
> sized points.
>
> For example, let's create an ECC Endorsement Key using the standard
> template then print its name:
>
>    tpm2_createek -G ecc -c /dev/null -u ./ek.pub
>    tpm2_loadexternal -c n -u ./ek.pub
>
> Equivalently using tpm2_createprimary:
>
>    perl -e 'print "\0"x64' | tpm2_createprimary -C e -o ./ek.pub -G ecc -=
a 'fixedtpm|fixedparent|sensitivedataorigin|adminwithpolicy|restricted|decr=
ypt' -L 837197674484b3f81a90cc8d46a5d724fd52d76e06520b64f2a1da1b331469aa -u=
 -
>    tpm2_loadexternal -c n -u ./ek.pub
>
> You'll find that the key's public modulus matches that of the EK
> Certificate imprinted by the manufacturer, indicating we got the
> template correct.
>
> To generate a standard SRK key, the TCG TPM2 Provisioning Guidance
> states we should:
>
> 	1. set userWithAuth,
> 	2. clear adminWithPolicy
> 	3. set noDA, and
> 	4. clear the authorization policy.
>
> There's no mention of alterations to the unique field.
>
> Let's also create the key in the null hierarchy:
>
>    perl -e 'print "\0"x64' | tpm2_createprimary -C n -o ./null.pub -G ecc=
 -a 'fixedtpm|fixedparent|sensitivedataorigin|userwithauth|noda|restricted|=
decrypt' -u -
>    tpm2_loadexternal -c n -u ./null.pub
>
> The name does not match the kernel's name for the null key.

Null key is not provisioned, what is the motivation here?

Not saying no, just asking for details...

There's couple of things that lack in this patch set ATM:

1. Neither kselftest additions nor not even proper testing
   instructions. Why 21 patches and zero tests? How one should
   decide when the work is "complete"?
2. I still don't know what version of QEMU I should patch to
   test corner cases from an URL, which I cannot recall :-)
   Highlights the first issue.

So for the time being the patch set is NAK just because we lack
clear definition of done here. I revisit it only when I know how
to test it.

BR, Jarkko

