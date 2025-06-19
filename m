Return-Path: <linux-integrity+bounces-6480-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4A50AE0A5F
	for <lists+linux-integrity@lfdr.de>; Thu, 19 Jun 2025 17:27:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3EE31889DFF
	for <lists+linux-integrity@lfdr.de>; Thu, 19 Jun 2025 15:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6438221FD8;
	Thu, 19 Jun 2025 15:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EMBqwIy+"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955CE21FF42;
	Thu, 19 Jun 2025 15:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750346568; cv=none; b=bkuoELhrrvs3Nz4wq/fPgzUf8JfpOv09c9Bq3XROhvmTr6WvQSOwDdYkH+bwkjGHw39QMSWVPAtqXWseEzr57mujabUgIZmnQ+KEOvlSylIYhldrJ9VBOPGAVAk0OPM6B+40Sp4U+Q3x7ep1pjRYfBW63+X4/bY0fujJ+rc9YT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750346568; c=relaxed/simple;
	bh=rq+ghcKxNrs62FsvQlCpMvvCarhKkja/qz7slFnCq6I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hM0expL39xylXSqDrCRaurD6/7Lja+ez5tD8Pl8dCdwh8IXpzKfmpgD8Dfx6napFyV4xvN0iSL0tVWrK1mq7QIz/oNjoVScl2BnL+rO+r40PvSVN5LTZLSkeH3KT6sALKRhyyaI4gusxyr7XQ4do3xUdPJNafB41lE376o1ryoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EMBqwIy+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E7BCC4CEF4;
	Thu, 19 Jun 2025 15:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750346568;
	bh=rq+ghcKxNrs62FsvQlCpMvvCarhKkja/qz7slFnCq6I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=EMBqwIy+fQ9VlRR7bhUDx6ckEJBSqONTc8CYZq0uW8Yl4ab3FAss6uo2cQaFv0t5c
	 SWPk8FjGBiSSe9eQLJ0GVDZRCUPM5xJjK8SJWihJY6A5dfhLtO+bjNgr3kpcHY6uQb
	 ugTqbkddvgNldeljl0pneNqo0m8tihLOV7RDL4aZTygBHMpKvz1dKvo8vi57dvMUYk
	 GY26Re+MvY+fsqruBRbyWpRRm7PFl2HnnQHI85kEQIgvhFbH81dGPhszU8WYyR18RD
	 7e//yffyfauemJ/DKaFClsnazXckAWUabR6y1wveCg/HppPiTSmU7UM6uBQ5YU6gD0
	 acInc3Vb+Potw==
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-606fdbd20afso1659189a12.1;
        Thu, 19 Jun 2025 08:22:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCURP3vRyvkPfxDyhrzTbCBmI1CKTT94Gkn3vPKwcDPg7RN5aBp20RSEcw7BSxdbsBvbt6cLXdPCGaN3t87N6th2@vger.kernel.org, AJvYcCWII55DJzWtqUD6hQ4BHDY4gowhLdFsGRZ44xBD1E3iNBAD5vzKNlxjv3zSEpmpoDxeNJUMCCUjvrVYhEFl@vger.kernel.org, AJvYcCWsLNBh7QpxzX01k045zVGVZL80sAw+/O8D/8J2sPbLL5ZF6gOW2uCVuavjPzCB8Hu17EJtj40bFtgwLxA=@vger.kernel.org
X-Gm-Message-State: AOJu0YweaUR7bUYGSkbpui0/1w2R+I2dq7GL49iKf0/8qYS88Lzzmn6W
	cJj1b6VxRcC+uDPn4PAjCz3cATB7UVqovwLs5T+7e/X33BWAi4H7WYqtfEBrwUsYqXxznLowMtY
	eM8qUGifZ6G8csgZU83/QGyG7XhAZmNA=
X-Google-Smtp-Source: AGHT+IG/nVaw1Dd3P/rV+iYudn3yAh1q2QcxS+ABajA8MLwVBiiIdyOKKd2SPUD6PzptoWbW6ybrC2bmoVc4KB8ow50=
X-Received: by 2002:a05:6402:7d2:b0:609:7e19:f12a with SMTP id
 4fb4d7f45d1cf-6097e19f7b7mr10598769a12.18.1750346566713; Thu, 19 Jun 2025
 08:22:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250619025138.2854-1-zhaoqunqin@loongson.cn> <20250619025138.2854-5-zhaoqunqin@loongson.cn>
In-Reply-To: <20250619025138.2854-5-zhaoqunqin@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Thu, 19 Jun 2025 23:22:32 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5cSdK+x+rGhfE-V0oE9YgCedEP8QUWS0MK_xf5-VVCaQ@mail.gmail.com>
X-Gm-Features: AX0GCFvVc2smpbzQoDmnbdF2XK312RXTLCpY1CVWU0GqSFr_hjBBYM03PZfLgMk
Message-ID: <CAAhV-H5cSdK+x+rGhfE-V0oE9YgCedEP8QUWS0MK_xf5-VVCaQ@mail.gmail.com>
Subject: Re: [PATCH v11 4/4] MAINTAINERS: Add entry for Loongson Security
 Engine drivers
To: Qunqin Zhao <zhaoqunqin@loongson.cn>
Cc: lee@kernel.org, herbert@gondor.apana.org.au, jarkko@kernel.org, 
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, davem@davemloft.net, 
	linux-crypto@vger.kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca, 
	linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 19, 2025 at 10:53=E2=80=AFAM Qunqin Zhao <zhaoqunqin@loongson.c=
n> wrote:
>
> This patch adds an entry for Loongson Security Engine drivers in the
> list of maintainers.
>
> Signed-off-by: Qunqin Zhao <zhaoqunqin@loongson.cn>
Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>


> ---
>  MAINTAINERS | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3ecb44458..23d889bca 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14152,6 +14152,15 @@ S:     Maintained
>  F:     Documentation/devicetree/bindings/pwm/loongson,ls7a-pwm.yaml
>  F:     drivers/pwm/pwm-loongson.c
>
> +LOONGSON SECURITY ENGINE DRIVERS
> +M:     Qunqin Zhao <zhaoqunqin@loongson.cn>
> +L:     linux-crypto@vger.kernel.org
> +S:     Maintained
> +F:     drivers/char/tpm_loongson.c
> +F:     drivers/crypto/loongson/
> +F:     drivers/mfd/loongson-se.c
> +F:     include/linux/mfd/loongson-se.h
> +
>  LOONGSON-2 SOC SERIES CLOCK DRIVER
>  M:     Yinbo Zhu <zhuyinbo@loongson.cn>
>  L:     linux-clk@vger.kernel.org
> --
> 2.45.2
>
>

