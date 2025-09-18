Return-Path: <linux-integrity+bounces-7147-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B08EFB82948
	for <lists+linux-integrity@lfdr.de>; Thu, 18 Sep 2025 03:55:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE73D4A4D58
	for <lists+linux-integrity@lfdr.de>; Thu, 18 Sep 2025 01:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8BCF245006;
	Thu, 18 Sep 2025 01:52:04 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50446244687;
	Thu, 18 Sep 2025 01:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758160324; cv=none; b=mG1M+3EQ1gk2VNNZmvxwC+yMl5xBBLWn/kQEIi/DWcX4y93D7LgeGnLdL5IOS5I/m1iRoD7jNHOZJI5Bz7G1hzjA7FFe/l78uL0IWkyDKfvaQp4nln+UvkTlOCkhPsF64kVUwevlj7XwVLl9MjrFrhtreC1XaBU3Y0QjW8ppgeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758160324; c=relaxed/simple;
	bh=MO7T3GO9RRyPbOuPAvDYY2zuVb5iqHfGA/bXBNhw/Xs=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=u9fllpmCLCH45ZThJzqHc5GTXrOvBNq3m91O+KhfSPC1c5TndjfA3eg1XzE3rSFlvB2lbWAzNTVWmdwqVxylzyYhIwIj4RFlLCDWgDZitXlLAxpDjefId1rgPWawY3TkGJhaOW0j2Ki1/sZekP6UByBbD5pLBB+81dwn43CXIOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.164])
	by gateway (Coremail) with SMTP id _____8Axjr_AZctoZp4LAA--.23655S3;
	Thu, 18 Sep 2025 09:52:00 +0800 (CST)
Received: from [10.20.42.164] (unknown [10.20.42.164])
	by front1 (Coremail) with SMTP id qMiowJDx7sG9ZctorKicAA--.43670S2;
	Thu, 18 Sep 2025 09:52:00 +0800 (CST)
Subject: Re: [PATCH] tpm: loongson: Add bufsiz parameter to
 tpm_loongson_send()
To: Nathan Chancellor <nathan@kernel.org>
Cc: Lee Jones <lee@kernel.org>, Yinggang Gu <guyinggang@loongson.cn>,
 Huacai Chen <chenhuacai@kernel.org>, Peter Huewe <peterhuewe@gmx.de>,
 Jarkko Sakkinen <jarkko@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250917-tpm-loongson-add-bufsiz-v1-1-972a75c0aab2@kernel.org>
From: Qunqin Zhao <zhaoqunqin@loongson.cn>
Message-ID: <02d279b6-a330-9167-8980-6732690861fa@loongson.cn>
Date: Thu, 18 Sep 2025 09:50:51 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250917-tpm-loongson-add-bufsiz-v1-1-972a75c0aab2@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:qMiowJDx7sG9ZctorKicAA--.43670S2
X-CM-SenderInfo: 52kd01pxqtx0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoWxCr1DJF1UKF48ArWrJF4rXrc_yoW5Gr43pF
	W7C34Du3yYyr48CrnxArWDCF17XrW3XFy2ya97J347JFyDt34fWFWUGFWUWr43ur18KF1j
	qrZ5KF15XF1j9rcCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
	xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v2
	6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67
	vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
	wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc4
	0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AK
	xVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr
	1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU7MmhUUUU
	U


在 2025/9/18 上午1:09, Nathan Chancellor 写道:
> Commit 5c83b07df9c5 ("tpm: Add a driver for Loongson TPM device") has a
> semantic conflict with commit 07d8004d6fb9 ("tpm: add bufsiz parameter
> in the .send callback"), as the former change was developed against a
> tree without the latter change. This results in a build error:
>
>    drivers/char/tpm/tpm_loongson.c:48:17: error: initialization of 'int (*)(struct tpm_chip *, u8 *, size_t,  size_t)' {aka 'int (*)(struct tpm_chip *, unsigned char *, long unsigned int,  long unsigned int)'} from incompatible pointer type 'int (*)(struct tpm_chip *, u8 *, size_t)' {aka 'int (*)(struct tpm_chip *, unsigned char *, long unsigned int)'} [-Wincompatible-pointer-types]
>       48 |         .send = tpm_loongson_send,
>          |                 ^~~~~~~~~~~~~~~~~
>    drivers/char/tpm/tpm_loongson.c:48:17: note: (near initialization for 'tpm_loongson_ops.send')
>    drivers/char/tpm/tpm_loongson.c:31:12: note: 'tpm_loongson_send' declared here
>       31 | static int tpm_loongson_send(struct tpm_chip *chip, u8 *buf, size_t count)
>          |            ^~~~~~~~~~~~~~~~~
>
> Add the expected bufsiz parameter to tpm_loongson_send() to resolve the
> error.

This means a lot. Thanks

Best regards,

Qunqin.

>
> Fixes: 5c83b07df9c5 ("tpm: Add a driver for Loongson TPM device")
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
> This is in Lee's ib-mfd-char-crypto-6.18 [1] so he will need to take it
> but I have CC'd the TPM folks as an FYI.
>
> [1]: https://lore.kernel.org/20250902124205.GL2163762@google.com/
> ---
>   drivers/char/tpm/tpm_loongson.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/char/tpm/tpm_loongson.c b/drivers/char/tpm/tpm_loongson.c
> index a4ec23639911..9e50250763d1 100644
> --- a/drivers/char/tpm/tpm_loongson.c
> +++ b/drivers/char/tpm/tpm_loongson.c
> @@ -28,7 +28,7 @@ static int tpm_loongson_recv(struct tpm_chip *chip, u8 *buf, size_t count)
>   	return cmd_ret->data_len;
>   }
>   
> -static int tpm_loongson_send(struct tpm_chip *chip, u8 *buf, size_t count)
> +static int tpm_loongson_send(struct tpm_chip *chip, u8 *buf, size_t bufsiz, size_t count)
>   {
>   	struct loongson_se_engine *tpm_engine = dev_get_drvdata(&chip->dev);
>   	struct tpm_loongson_cmd *cmd = tpm_engine->command;
>
> ---
> base-commit: 74fddd5fbab879a7d039d9fb49af923927a64811
> change-id: 20250917-tpm-loongson-add-bufsiz-e43f60016cca
>
> Best regards,
> --
> Nathan Chancellor <nathan@kernel.org>
>


