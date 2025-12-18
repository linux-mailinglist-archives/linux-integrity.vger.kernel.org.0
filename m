Return-Path: <linux-integrity+bounces-8111-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C1830CCA9FD
	for <lists+linux-integrity@lfdr.de>; Thu, 18 Dec 2025 08:23:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7CC6E300F884
	for <lists+linux-integrity@lfdr.de>; Thu, 18 Dec 2025 07:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39D54330B37;
	Thu, 18 Dec 2025 07:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hFvxQjnf"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3AF330D42
	for <linux-integrity@vger.kernel.org>; Thu, 18 Dec 2025 07:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766042505; cv=none; b=Z9IIEBfYi/dQXN8kOilKcd+AzjvHuYwem1iK2ZMZORXLtLkriPXXSuxdIW2ba2UElqj85xpFaHHjOXA2FalgJ7uI0LhdBgoOJzw2ur9OBNoY/47Shvhu7wyBJ2PC4QM1IYhLSyzHjbK2/H3CIspFbku+UPpDLjrUS+HN6Ph7+co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766042505; c=relaxed/simple;
	bh=oRDVeoSH7AN/+1EKf418Edx8/qjw/FEB71Hmt8IhBro=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZJIgjNSkw0GtzsmS9npIIzbqR8oui5jz8TiEx4oxdpltIm0jWJjiAp8qZwDci1J0cH8nKC36Gln1hyvOlsPnKS6gYxZq7hi2esqB0RdpfiJj/Ry3gkgMB0fWHg5nS1VCPW1XnxpVlXEFOS4RgtNLwJ2oNvwDDyh2mlsQ++JAzD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hFvxQjnf; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-6575e760f06so92081eaf.0
        for <linux-integrity@vger.kernel.org>; Wed, 17 Dec 2025 23:21:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1766042501; x=1766647301; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u95c9TyT1XdaOnIyGBwMeLSiKMNJeuqg+7XxBfANtKE=;
        b=hFvxQjnfCf2CUAqy40N2AHyq5MIDA0GgC5LKgr2+oJWxzVnQ/H2BlDj/PRT3fjn6YS
         6uoMn7+YEL0+8O2LkRt30f+/2R5PDahttu121Fq4t7CeI0ECWbcDX44yZNP52rNK3/eA
         fPojzuLnONspq5CUtSTCNO3/tkNye7HZkr84BB+Y/ocSOeYeJ03l/SmFCJB5qTJptZdQ
         RbLfAkSfM0ummJWRnc7E8aYHqgmwBJNI/c/pFs/M401mDi2bS0euznuCTV9DcKpXnQ1t
         H/xEDBrHcjuX6fA2f9gHgqEpAJVqBMy72GfMnDPZoRbg6fOFBpJbmBiSpijWbwGJ9Uu8
         +Vxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766042501; x=1766647301;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=u95c9TyT1XdaOnIyGBwMeLSiKMNJeuqg+7XxBfANtKE=;
        b=eceurG8wm0X9qEnmA+DHFU7BJusaH7qbz/v3dZbuymOhHOZMqGSH9h4903WKEfXUIK
         Ihu4UkEUGRMZYvczG6eW4RhyhV86yFqi/rQKplWY9qtWIprNOVzd/1aXYq9ULfKFlbvb
         LMLxNrKgdqtUykGdJpnTEtqo55upXDV5u1poN6Me5xDB9d9i0wi0RYeUMNieL30Ags5x
         bQhp9L6fd+t+QmCiK/WLpF8kQdhllWQNNAj9lCtFQl0+mHmk6tZ1K2HMtynoJqR/VJ05
         /kQ/74Xzw5+lhLyeKmjqTfSfuQ4vDvkoqPFErA4XBBPV1YJCjKKOyXlEfW71mn2sJS2e
         uIDA==
X-Forwarded-Encrypted: i=1; AJvYcCX7ZYqiJZMTfB0I7uiB8ASlDToNyFSQvNTa6lsrMRbyztqoyaNN1dmDvzn5vIDfzh9/oxuRr9LhOrvq8SASQ3A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvUoMeutijS1/7YKvu7JaRRswkp/8GVhtvRuPh/oVvKvG4AYvl
	7CxaX8fSvfucSEoV5F6UWZu9H5PIhc7i1S9xJgExm/pZ6ydq8rZKm+VL5EP6Y9w2XI1vi8r80qc
	Vh768cusuduolNntyVMtSRXiXx3qInhc8o0KSEqU3Lg==
X-Gm-Gg: AY/fxX6mqm+FYT9E9imdYoYwwW6GKHc9U504RHu9e7njD+hYHN61wvC1n8aXPH0qOn9
	TH39wA5EhCHD2vd2DMMQ24YVhwmt8tTN69Z9YObx4lsabFhRQ0AxhP9zJCWKuEFuiXwgNO9OCAI
	pdeCpEXnSW4JGlBOTByo3zaUm/QYcE3JcJpQJiA+R1nMKnGcbWsf4vfs8RiVPHIlnKXWB78UIAj
	0LEd0nPtR5mbJzBRM/JU1DT68v0EnDsZlchi/D93WJ+B8JthgBROwB2fDMR9np5uiVjnPdgQ8up
	iEXYBr8zQ3Y/Rkb3N9qsxfdnKQ==
X-Google-Smtp-Source: AGHT+IHdzsrnh67Z+uk7sg0iAMocZMySikku48EGz5g7L5MG+hq7iSRlseyY2l5vM8LHePwozU/hD6rMNUuAq73AgFc=
X-Received: by 2002:a05:6820:828:b0:65c:f41b:7119 with SMTP id
 006d021491bc7-65cf41b750emr1784992eaf.5.1766042500598; Wed, 17 Dec 2025
 23:21:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1765791463.git.u.kleine-koenig@baylibre.com>
In-Reply-To: <cover.1765791463.git.u.kleine-koenig@baylibre.com>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Thu, 18 Dec 2025 08:21:27 +0100
X-Gm-Features: AQt7F2r_j21Nqcv1IzhOT6jk9UPtvnwA1D3etXiTv5WveGJRYXXMC9qqoGF_Yc4
Message-ID: <CAHUa44FrDZbvRvfN8obf80_k=Eqxe9YxHpjaE5jU7nkxPUwfag@mail.gmail.com>
Subject: Re: [PATCH v2 00/17] tee: Use bus callbacks instead of driver callbacks
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Sumit Garg <sumit.garg@kernel.org>, 
	Olivia Mackall <olivia@selenic.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	=?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Ard Biesheuvel <ardb@kernel.org>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Sumit Garg <sumit.garg@oss.qualcomm.com>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Jan Kiszka <jan.kiszka@siemens.com>, 
	Sudeep Holla <sudeep.holla@arm.com>, Christophe JAILLET <christophe.jaillet@wanadoo.fr>, 
	=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>, 
	Michael Chan <michael.chan@broadcom.com>, Pavan Chebbi <pavan.chebbi@broadcom.com>, 
	James Bottomley <James.Bottomley@hansenpartnership.com>, Jarkko Sakkinen <jarkko@kernel.org>, 
	Mimi Zohar <zohar@linux.ibm.com>, David Howells <dhowells@redhat.com>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Peter Huewe <peterhuewe@gmx.de>, op-tee@lists.trustedfirmware.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-crypto@vger.kernel.org, linux-rtc@vger.kernel.org, 
	linux-efi@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, 
	Cristian Marussi <cristian.marussi@arm.com>, arm-scmi@vger.kernel.org, 
	linux-mips@vger.kernel.org, netdev@vger.kernel.org, 
	linux-integrity@vger.kernel.org, keyrings@vger.kernel.org, 
	linux-security-module@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Dec 15, 2025 at 3:17=E2=80=AFPM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@baylibre.com> wrote:
>
> Hello,
>
> the objective of this series is to make tee driver stop using callbacks
> in struct device_driver. These were superseded by bus methods in 2006
> (commit 594c8281f905 ("[PATCH] Add bus_type probe, remove, shutdown
> methods.")) but nobody cared to convert all subsystems accordingly.
>
> Here the tee drivers are converted. The first commit is somewhat
> unrelated, but simplifies the conversion (and the drivers). It
> introduces driver registration helpers that care about setting the bus
> and owner. (The latter is missing in all drivers, so by using these
> helpers the drivers become more correct.)
>
> v1 of this series is available at
> https://lore.kernel.org/all/cover.1765472125.git.u.kleine-koenig@baylibre=
.com
>
> Changes since v1:
>
>  - rebase to v6.19-rc1 (no conflicts)
>  - add tags received so far
>  - fix whitespace issues pointed out by Sumit Garg
>  - fix shutdown callback to shutdown and not remove
>
> As already noted in v1's cover letter, this series should go in during a
> single merge window as there are runtime warnings when the series is
> only applied partially. Sumit Garg suggested to apply the whole series
> via Jens Wiklander's tree.
> If this is done the dependencies in this series are honored, in case the
> plan changes: Patches #4 - #17 depend on the first two.
>
> Note this series is only build tested.
>
> Uwe Kleine-K=C3=B6nig (17):
>   tee: Add some helpers to reduce boilerplate for tee client drivers
>   tee: Add probe, remove and shutdown bus callbacks to tee_client_driver
>   tee: Adapt documentation to cover recent additions
>   hwrng: optee - Make use of module_tee_client_driver()
>   hwrng: optee - Make use of tee bus methods
>   rtc: optee: Migrate to use tee specific driver registration function
>   rtc: optee: Make use of tee bus methods
>   efi: stmm: Make use of module_tee_client_driver()
>   efi: stmm: Make use of tee bus methods
>   firmware: arm_scmi: optee: Make use of module_tee_client_driver()
>   firmware: arm_scmi: Make use of tee bus methods
>   firmware: tee_bnxt: Make use of module_tee_client_driver()
>   firmware: tee_bnxt: Make use of tee bus methods
>   KEYS: trusted: Migrate to use tee specific driver registration
>     function
>   KEYS: trusted: Make use of tee bus methods
>   tpm/tpm_ftpm_tee: Make use of tee specific driver registration
>   tpm/tpm_ftpm_tee: Make use of tee bus methods
>
>  Documentation/driver-api/tee.rst             | 18 +----
>  drivers/char/hw_random/optee-rng.c           | 26 ++----
>  drivers/char/tpm/tpm_ftpm_tee.c              | 31 +++++---
>  drivers/firmware/arm_scmi/transports/optee.c | 32 +++-----
>  drivers/firmware/broadcom/tee_bnxt_fw.c      | 30 ++-----
>  drivers/firmware/efi/stmm/tee_stmm_efi.c     | 25 ++----
>  drivers/rtc/rtc-optee.c                      | 27 ++-----
>  drivers/tee/tee_core.c                       | 84 ++++++++++++++++++++
>  include/linux/tee_drv.h                      | 12 +++
>  security/keys/trusted-keys/trusted_tee.c     | 17 ++--
>  10 files changed, 164 insertions(+), 138 deletions(-)
>
> base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
> --
> 2.47.3
>

Thank you for the nice cleanup, Uwe.

I've applied patch 1-3 to the branch tee_bus_callback_for_6.20 in my
tree at https://git.kernel.org/pub/scm/linux/kernel/git/jenswi/linux-tee.gi=
t/

The branch is based on v6.19-rc1, and I'll try to keep it stable for
others to depend on, if needed. Let's see if we can agree on taking
the remaining patches via that branch.

Cheers,
Jens

