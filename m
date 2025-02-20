Return-Path: <linux-integrity+bounces-4926-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FE89A3D893
	for <lists+linux-integrity@lfdr.de>; Thu, 20 Feb 2025 12:28:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30DA6420525
	for <lists+linux-integrity@lfdr.de>; Thu, 20 Feb 2025 11:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC19C1FE453;
	Thu, 20 Feb 2025 11:23:20 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAECC1F584D;
	Thu, 20 Feb 2025 11:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740050600; cv=none; b=oFGBTo32MWkemYUFh/+y0kFBigxyMKO615oDsg1VCjhXGTJpNALxH5kDgBrbGx45qxGMqSrFXj/7mPYL2qCIa2sEFIcIK3trbyvUXn8WdSpV1e6e9QcRXFGw95kZ/PPOmcyS2Pw26cxxjgZWZnYd+j4+TU/+YwPxQXqTqNadAGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740050600; c=relaxed/simple;
	bh=XJ1rfVBdFtGgkqiX+cJQ7kfGCpepKbDiOO8u/69LAOc=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=ubTZIisig3Ta+jmu5X/7zScWgq86FYLqERGrXQaJWdqLXWn1wmLnJYntdO7gRspDwDEkXn+aauNbwHkKPKbGlyJu+BFdKeAiUgTe64z6u5XcVMXzOWC5FMaFinPXHoWSu2X8GsaUlR5e/GmLpnqERPaAV2JA19gMh1sBQ9RBTqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.164])
	by gateway (Coremail) with SMTP id _____8AxGHGjELdnYDp8AA--.17810S3;
	Thu, 20 Feb 2025 19:23:15 +0800 (CST)
Received: from [10.20.42.164] (unknown [10.20.42.164])
	by front1 (Coremail) with SMTP id qMiowMDxDcehELdnODQeAA--.8092S2;
	Thu, 20 Feb 2025 19:23:15 +0800 (CST)
Subject: Re: [PATCH V3 5/6] tpm: Add a driver for Loongson TPM device
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: lee@kernel.org, herbert@gondor.apana.org.au, davem@davemloft.net,
 peterhuewe@gmx.de, linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
 linux-crypto@vger.kernel.org, jgg@ziepe.ca, linux-integrity@vger.kernel.org,
 Yinggang Gu <guyinggang@loongson.cn>
References: <20250219073350.16915-1-zhaoqunqin@loongson.cn>
 <20250219073350.16915-2-zhaoqunqin@loongson.cn> <Z7XgLNU1xXqgOBIL@kernel.org>
From: Qunqin Zhao <zhaoqunqin@loongson.cn>
Message-ID: <4e0a3b40-07b8-06bf-8814-a121308ebf69@loongson.cn>
Date: Thu, 20 Feb 2025 19:23:42 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <Z7XgLNU1xXqgOBIL@kernel.org>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:qMiowMDxDcehELdnODQeAA--.8092S2
X-CM-SenderInfo: 52kd01pxqtx0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj9xXoW7Gw17Kw1ktw4UKrWxAr4fWFX_yoWDAFc_Aa
	12yF1xJr18uFyvgw4ruw13C3W2qayqyFnxt3WjyF4v93srJ345Z3Z8urn3Jay7Zr1kAFn8
	AFnxGryfua4j9osvyTuYvTs0mTUanT9S1TB71UUUUj7qnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbDkYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_JrI_Jryl8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0
	oVCq3wAaw2AFwI0_JF0_Jw1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa02
	0Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_Wryl
	Yx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI
	0SjxkI62AI1cAE67vIY487MxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC2
	0s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr
	0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0E
	wIxGrwCI42IY6xIIjxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JV
	WxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAI
	cVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8KNt3UUUUU==


ÔÚ 2025/2/19 ÏÂÎç9:44, Jarkko Sakkinen Ð´µÀ:
>> +
>> +static const struct tpm_class_ops lsse_tpm_ops = {
>> +	.flags = TPM_OPS_AUTO_STARTUP,
>> +	.recv = tpm_ls_recv,
>> +	.send = tpm_ls_send,
>> +};
>> +
>> +static int lsse_tpm_probe(struct platform_device *pdev)
> tpm_lsse_
OK.
> +
> +static struct platform_driver lsse_tpm_driver = {
> +	.probe   = lsse_tpm_probe,
> +	.driver  = {
> +		.name  = "ls6000se-tpm",
> +	},
> +};
> +module_platform_driver(lsse_tpm_driver);
> +
> +MODULE_ALIAS("platform:ls6000se-tpm");
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Yinggang Gu <guyinggang@loongson.cn>");
> +MODULE_AUTHOR("Qunqin Zhao <zhaoqunqin@loongson.cn>");
> Remove MODULE_AUTHOR fields. Git encodes this already.

Do you mean that "modinfo" will still show the author after removing 
MODULE_AUTHOR fields?

>
>> +MODULE_DESCRIPTION("Loongson TPM driver");
>> -- 
>> 2.43.0
>>
> Prefix all with tpm_lsse instead of tpm

OK, thanks for your comments.

BR, Qunqin.

>
> BR, Jarkko


