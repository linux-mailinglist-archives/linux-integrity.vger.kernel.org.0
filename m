Return-Path: <linux-integrity+bounces-2445-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91B678C9098
	for <lists+linux-integrity@lfdr.de>; Sat, 18 May 2024 13:25:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09ADA281ED1
	for <lists+linux-integrity@lfdr.de>; Sat, 18 May 2024 11:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C29EE25761;
	Sat, 18 May 2024 11:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k9XAntuF"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D30208A8;
	Sat, 18 May 2024 11:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716031527; cv=none; b=dfl5Y6gNa4t1EHps7rgjOtSIQ3zCJJ2GNhMDHB9ffg98tySBcW6hhQcSjEd6EJ014OD1TUaLkdwQpovPCsQUcod2Ko1hU3QktpeFSg7ocYlS35Kyt32Iaj/aL3rjB5AvSCfocXb2U6KRfXgVh91J31w94xdNw8etc952UZV33Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716031527; c=relaxed/simple;
	bh=5FqV7Cj2SOxaN5+kcEyKDYHvv+SB1LEIMZasSmT2cHo=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=aDwhWNsFqIE75oypL+rpZMc0Z/biOu15+BEd+gUpMdAMD5Z/yGuL4m4X1gu10E8K6ma0WsPHYEWlikmdYRS8L4i9vB5P+HiOSlqicyk78E2x4gAYN2tp6rHVtOcmFN51PWwwIMisP7YC+jL7mSpVR+L8udcGXwIuu+kBWaj3NzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k9XAntuF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCED9C113CC;
	Sat, 18 May 2024 11:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716031527;
	bh=5FqV7Cj2SOxaN5+kcEyKDYHvv+SB1LEIMZasSmT2cHo=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=k9XAntuFqR//FvKAziOJHKT0riUxnVEN6nquFzWsv2Ir+JmITjV6htNabMhPrdb0r
	 xHcXsIGm9vM+uBh3aedee0w213x6LIzy0DJNUEpqwIg4Z+f75nxrK5LiSX2EGJkgEk
	 64cvmVrwk2YksCCskfsYL4t5bfaDt4yvfbOcERGH5gS3FYhWxz0UpwVt9dkqmEYu7T
	 eVjpoaH1ZctsxN+1+TByuLfGUpyp4syBp6haiuv8YPaKbtiSuJTX4uNv1lZbhHsLVj
	 +B6vanavwnA3AGVFkSWR9VRSj6dbvAr/fOGEgZR0W+CkyP54Z3hRqXIF8WpwcPXjGr
	 4FhKEmfeP6NmA==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 18 May 2024 14:25:24 +0300
Message-Id: <D1CQEN4ROQFK.1NHMZGCIL1YC5@kernel.org>
Subject: Re: SLB9670 TPM module crash
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Parthiban" <parthiban@linumiz.com>,
 <James.Bottomley@HansenPartnership.com>
Cc: <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <peterhuewe@gmx.de>, <jgg@ziepe.ca>
X-Mailer: aerc 0.17.0
References: <7955419c-ccc2-4a20-8ff5-07b119258415@linumiz.com>
In-Reply-To: <7955419c-ccc2-4a20-8ff5-07b119258415@linumiz.com>

On Sat May 18, 2024 at 2:21 PM EEST, Parthiban wrote:
> Dear James Bottomley,
>
> The following crash is observed in the current mainline kernel and I have=
 tried the
> git bisect to narrow it down. Bisect points to the below commit, which go=
t merged as
> part of [1]. I tried reverting the below commit and the TPM loads fine.
>
> commit 1b6d7f9eb150305dcb0da4f7101a8d30dcdf0497
> Author: James Bottomley <James.Bottomley@HansenPartnership.com>
> Date:   Mon Apr 29 16:28:07 2024 -0400
>
>     tpm: add session encryption protection to tpm2_get_random()
>    =20
>     If some entity is snooping the TPM bus, they can see the random
>     numbers we're extracting from the TPM and do prediction attacks
>     against their consumers.  Foil this attack by using response
>     encryption to prevent the attacker from seeing the random sequence.
>    =20
>     Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com=
>
>     Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
>     Tested-by: Jarkko Sakkinen <jarkko@kernel.org>
>     Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
>
>  drivers/char/tpm/tpm2-cmd.c | 21 +++++++++++++++++----
>  1 file changed, 17 insertions(+), 4 deletions(-)
>
> [   11.551988] tpm_tis_spi spi0.1: 2.0 TPM (device-id 0x1B, rev-id 22)
> [   11.563036] spi_master spi0: will run message pump with realtime prior=
ity


Explanation and workaround: https://lore.kernel.org/linux-integrity/D1C1KL7=
Q27P9.39BH0Z4EMBBUG@kernel.org/

James, this must be fixed by:

diff --git a/drivers/char/tpm/Kconfig b/drivers/char/tpm/Kconfig
index 7c0486e3199c..2d9e2c860ad9 100644
--- a/drivers/char/tpm/Kconfig
+++ b/drivers/char/tpm/Kconfig
@@ -34,7 +34,7 @@ if TCG_TPM

 config TCG_TPM2_HMAC
        bool "Use HMAC and encrypted transactions on the TPM bus"
-       default y
+       default n
        select CRYPTO_ECDH
        select CRYPTO_LIB_AESCFB
        select CRYPTO_LIB_SHA256

Distributors know how to enable this but given the high volumes of small
devices still with TPM, this trend needs to be cutted.

BR, Jarkko


BR, Jarkko


