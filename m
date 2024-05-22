Return-Path: <linux-integrity+bounces-2553-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2D108CC2D5
	for <lists+linux-integrity@lfdr.de>; Wed, 22 May 2024 16:11:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 084DD1C2225F
	for <lists+linux-integrity@lfdr.de>; Wed, 22 May 2024 14:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7AF814198E;
	Wed, 22 May 2024 14:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G3D4etXP"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B699C1411FE;
	Wed, 22 May 2024 14:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716387076; cv=none; b=cb3lM0J7REiJaNsK9Rq9/ySBwy5AefrVB1Tniz/Qfq88E56V4yzF5kRVMiHxiBB0RtWhh/9ee39zfrEab91gnbgZ3KpN+Fh/knxaVRN0yM15xN+0t0Pe3vikagfgAGAb36l6yH7PHwJjGG5hdP92p7ZYv/7R7odUY5z8P1d01ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716387076; c=relaxed/simple;
	bh=i0uNCMea2P5BSrMwzAs+tJozqiJ606o60R2EKj2hu44=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=F42bRz4mrlC2g1taABeyJeJBGhvmqnlR9ciC4iejLLVOS7P0icfpRPa2Jr1yv9oJineQBf3AI5enl1Mya4/WBT/sjuhiHrAI23RRK0NI4csWsbv7TZS8DXsoVm2v0qsSDSwUCrvgdM/H8Ga03BJrbdzK0QMeLQgHZIfVEsmSOlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G3D4etXP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F04A3C2BD11;
	Wed, 22 May 2024 14:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716387076;
	bh=i0uNCMea2P5BSrMwzAs+tJozqiJ606o60R2EKj2hu44=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=G3D4etXP/vF/2KJdFfmuTxVq5JGIfI7gl3yMi+Vj1ne87GfOojtifT9QRPoR22DRu
	 qx+cmGkuq7mHAvotUUsikOeYBpHP/nRQLGHxxz5ijte94Wf0GWN1O1pFe9/AniRWlK
	 +Ss+PVi6FKOjpGpOj2R2P9Q6rEFQ9apDURqoEtrpKB2AnWyPNPzIpP+sro4v1iCjcb
	 lj9CEk8r/C3Z9CLDJngISvuoBjhrTBj1SJ8D4HgCGMAOav45foaRiPY0ohRwCsZFpV
	 VANFrPufEX41rRgmQNFvtpJ0XiRdXsO+sNNBAdnqR4XAFQTaeSNLy1Lnj+Rv+kftcA
	 zT0hUMe31U5YQ==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 22 May 2024 17:11:11 +0300
Message-Id: <D1G8FRJFBBAO.X8CAFK3K34VJ@kernel.org>
Cc: <keyrings@vger.kernel.org>, "Peter Huewe" <peterhuewe@gmx.de>, "Jason
 Gunthorpe" <jgg@ziepe.ca>, "Mimi Zohar" <zohar@linux.ibm.com>, "David
 Howells" <dhowells@redhat.com>, "Paul Moore" <paul@paul-moore.com>, "James
 Morris" <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
 <linux-kernel@vger.kernel.org>, <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH 1/3] tpm: Disable TCG_TPM2_HMAC by default
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Vitor Soares" <ivitro@gmail.com>, "James Bottomley"
 <James.Bottomley@HansenPartnership.com>, <linux-integrity@vger.kernel.org>
X-Mailer: aerc 0.17.0
References: <20240519235122.3380-1-jarkko@kernel.org>
 <20240519235122.3380-2-jarkko@kernel.org>
 <850862655008f84ef0b6ecd99750e8dc395304d1.camel@gmail.com>
 <D1F4V8NMSUNZ.2VCTEKHZZ0LB@kernel.org>
 <17dc838120b56ce342c34611596c7b46dcd9ab5a.camel@HansenPartnership.com>
 <2dd8d49516ec9c7cb8c1182b5b8537b1e82d7067.camel@gmail.com>
 <D1G5O2Z86E4W.2DHG4QZE2W2JG@kernel.org>
 <56e52200bd9ede6bcdcc907d24bd4a3e0dddd24f.camel@gmail.com>
In-Reply-To: <56e52200bd9ede6bcdcc907d24bd4a3e0dddd24f.camel@gmail.com>

On Wed May 22, 2024 at 4:17 PM EEST, Vitor Soares wrote:
> > 1. What is the aarch64 platform you are using?
>
> I was testing this on the Toradex Verdin iMX8MM SoM.
>
> > 2. What kind of TPM you are using and how is it connect?
>
> TPM device is the ATTPM20P connect through the SPI at speed of 36 MHz.
> The bus is shared with a CAN controller (MCP251xFD), so both mues work to=
gether.
>
> The dts looks like:
> tpm1: tpm@1 {
>         compatible =3D "atmel,attpm20p", "tcg,tpm_tis-spi";
>         interrupts-extended =3D <&gpio1 7 IRQ_TYPE_LEVEL_LOW>;
>         pinctrl-0 =3D <&pinctrl_can2_int>;
>         pinctrl-names =3D "default";
>         reg =3D <1>;
>         spi-max-frequency =3D <36000000>;
> };

Thank you, this exactly what I was looking for. Don't expect any
improvement to the situation before rc1 is out. It is better to
investigate the situation a bit first.

E.g. some people test with fTPM TEE so this was pretty essential
to know that it is a chip going through.

For tpm_crb we should actually disable HMAC at some point. It is
essentially a performance regression for it.

BR, Jarkko

