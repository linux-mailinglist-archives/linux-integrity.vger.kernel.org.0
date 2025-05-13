Return-Path: <linux-integrity+bounces-6187-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E53ABAB4C98
	for <lists+linux-integrity@lfdr.de>; Tue, 13 May 2025 09:21:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 450B13AD648
	for <lists+linux-integrity@lfdr.de>; Tue, 13 May 2025 07:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 697181F03CF;
	Tue, 13 May 2025 07:21:10 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D3111EFF89;
	Tue, 13 May 2025 07:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747120870; cv=none; b=PghFV6n9ecT+lxk1/z4Loe4XwOkxJUbwqt7482qn2RsTv5Nxe5OK7E1DiVXFohxGTR+NlorWQpRhLdGxqvFODJiZd4opaJl4ZIytnuj1pqThU3JHdYYNrwHWEeWfGhaEAfZc7YLgIgkWNoWXOcpMVZbcAPhoDVD00h+K8OGDF/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747120870; c=relaxed/simple;
	bh=yj51drKVlwDLsjkAZzJZty2Bp0QzpA0GLqtNmCscr4w=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=ZJCLWxsq5DYLupBSPK9s/fWV/Y7V99dt4jW19+4rnxZGPG9NefWg+8VuiYbg1PXhQJo11Zwxb/kE2PZV0WQsh3D4lbTN+0Unbna0pNEj6JzyFTZcYbtir9yWGn+FaHXOQ7l3GAGGyO4vAeIQNXd+w02pA6gGdqQJ5eoIQkA4tuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.164])
	by gateway (Coremail) with SMTP id _____8DxbKzg8iJojobjAA--.43654S3;
	Tue, 13 May 2025 15:21:04 +0800 (CST)
Received: from [10.20.42.164] (unknown [10.20.42.164])
	by front1 (Coremail) with SMTP id qMiowMAxjhvc8iJon1XNAA--.17820S2;
	Tue, 13 May 2025 15:21:02 +0800 (CST)
Subject: Re: [PATCH v9 4/5] tpm: Add a driver for Loongson TPM device
To: jarkko@kernel.org, Stefano Garzarella <sgarzare@redhat.com>
Cc: lee@kernel.org, herbert@gondor.apana.org.au, davem@davemloft.net,
 peterhuewe@gmx.de, linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
 linux-crypto@vger.kernel.org, jgg@ziepe.ca, linux-integrity@vger.kernel.org,
 pmenzel@molgen.mpg.de, Yinggang Gu <guyinggang@loongson.cn>,
 Huacai Chen <chenhuacai@loongson.cn>
References: <20250506031947.11130-1-zhaoqunqin@loongson.cn>
 <20250506031947.11130-5-zhaoqunqin@loongson.cn>
From: Qunqin Zhao <zhaoqunqin@loongson.cn>
Message-ID: <e5f868d2-295d-b1ab-904a-9e5c032037f0@loongson.cn>
Date: Tue, 13 May 2025 15:20:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250506031947.11130-5-zhaoqunqin@loongson.cn>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:qMiowMAxjhvc8iJon1XNAA--.17820S2
X-CM-SenderInfo: 52kd01pxqtx0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7uF1UJFyruFW3Gw15Kw1ktFc_yoW8ArykpF
	WfAa1UCF45Ar1UCws8JrW5A3ya9r93Gr1Dua9Fy347GF1DA3s5G34Uurn7Xw18Ar4DGr1I
	gFWkuF4093WqkFXCm3ZEXasCq-sJn29KB7ZKAUJUUUUf529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUPYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1ln4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2
	x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5
	McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7
	I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCF
	x2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14v26r
	1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij
	64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr
	0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF
	0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jz5lbUUUUU=


Hi, Jarkko and Stefano

ÔÚ 2025/5/6 ÉÏÎç11:19, Qunqin Zhao Ð´µÀ:
> Loongson Security Engine supports random number generation, hash,
> symmetric encryption and asymmetric encryption. Based on these
> encryption functions, TPM2 have been implemented in the Loongson
> Security Engine firmware. This driver is responsible for copying data
> into the memory visible to the firmware and receiving data from the
> firmware.
>
> Co-developed-by: Yinggang Gu <guyinggang@loongson.cn>
> Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
> Signed-off-by: Qunqin Zhao <zhaoqunqin@loongson.cn>
> Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> ---
> v9: "tpm_loongson_driver" --> "tpm_loongson"
>      "depends on CRYPTO_DEV_LOONGSON_SE" --> "depends on MFD_LOONGSON_SE"
>
...
> +static int tpm_loongson_recv(struct tpm_chip *chip, u8 *buf, size_t count)
> +{
> +	struct loongson_se_engine *tpm_engine = dev_get_drvdata(&chip->dev);
> +	struct tpm_loongson_cmd *cmd_ret = tpm_engine->command_ret;

if (cmd_ret->data_len > count)
         return -EIO;

> +
> +	memcpy(buf, tpm_engine->data_buffer, cmd_ret->data_len);
> +
> +	return cmd_ret->data_len;
> +}
> +
> +static int tpm_loongson_send(struct tpm_chip *chip, u8 *buf, size_t count)
> +{
> +	struct loongson_se_engine *tpm_engine = dev_get_drvdata(&chip->dev);
> +	struct tpm_loongson_cmd *cmd = tpm_engine->command;
> +
if (count > tpm_engine->buffer_size)

         return -E2BIG;

> +	cmd->data_len = count;
> +	memcpy(tpm_engine->data_buffer, buf, count);
> +
> +	return loongson_se_send_engine_cmd(tpm_engine);
> +}

Thanks for your comments,

Qunqin.


