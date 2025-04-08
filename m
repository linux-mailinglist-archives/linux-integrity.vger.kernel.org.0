Return-Path: <linux-integrity+bounces-5668-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27DA0A8054C
	for <lists+linux-integrity@lfdr.de>; Tue,  8 Apr 2025 14:16:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87AD11B67EFD
	for <lists+linux-integrity@lfdr.de>; Tue,  8 Apr 2025 12:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD9C32698AE;
	Tue,  8 Apr 2025 12:08:57 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A59F226A0E9;
	Tue,  8 Apr 2025 12:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744114137; cv=none; b=DTy9xZuPkCUkvoWxjN6jCM/lmXXulNrUJimZnbZQdn6MNUJFmY+LD6w2O2KsHkRjSuW2CvveGXLCeYUl86RMCc5gsmE3bC/HKAc0i/hA9PsEi7PFeXCPQOkKqskRuuDAtZS86PnEjq/Gb7QajejxfpUKRcuz5VT0M6lVFj7Pqes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744114137; c=relaxed/simple;
	bh=PFJ0Oher4XMf7LWfkkhNCuILRJAh2NbdlLwyTvLnBQY=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=kZbADaz+6jY5EJJsS9zu+DREtz6CU0OIKGSYFvMrcm/VdYsikmK3ySh1l1fnIpi3y5T4eVRu3PEGubG6d/XAVkYWwvMp0oPjroJPX2FFvVtJvdRDpopEO0EPw6xuPlGxAL2dwmXBMKHNU0dEX5Djq/MTKSPZGxv1mMgODGVV7P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.164])
	by gateway (Coremail) with SMTP id _____8CxieDTEfVnzye1AA--.60672S3;
	Tue, 08 Apr 2025 20:08:51 +0800 (CST)
Received: from [10.20.42.164] (unknown [10.20.42.164])
	by front1 (Coremail) with SMTP id qMiowMCxvMbPEfVnxbB0AA--.35291S2;
	Tue, 08 Apr 2025 20:08:50 +0800 (CST)
Subject: Re: [PATCH v7 3/6] crypto: loongson - add Loongson RNG driver support
To: Huacai Chen <chenhuacai@kernel.org>
Cc: lee@kernel.org, herbert@gondor.apana.org.au, davem@davemloft.net,
 peterhuewe@gmx.de, jarkko@kernel.org, linux-kernel@vger.kernel.org,
 loongarch@lists.linux.dev, linux-crypto@vger.kernel.org, jgg@ziepe.ca,
 linux-integrity@vger.kernel.org, pmenzel@molgen.mpg.de,
 Yinggang Gu <guyinggang@loongson.cn>, Huacai Chen <chenhuacai@loongson.cn>
References: <20250403024645.4427-1-zhaoqunqin@loongson.cn>
 <20250403024645.4427-4-zhaoqunqin@loongson.cn>
 <CAAhV-H45vYe3Brgy=0_+ciTjcJ-+x3zwoeY-ym20o5PGGxvJCw@mail.gmail.com>
From: Qunqin Zhao <zhaoqunqin@loongson.cn>
Message-ID: <fbe5329a-8583-34e6-c138-492c83364e70@loongson.cn>
Date: Tue, 8 Apr 2025 20:07:41 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAAhV-H45vYe3Brgy=0_+ciTjcJ-+x3zwoeY-ym20o5PGGxvJCw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:qMiowMCxvMbPEfVnxbB0AA--.35291S2
X-CM-SenderInfo: 52kd01pxqtx0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoWxGr1DZrW8Gw4ftF13JFWrWFX_yoWrGw4fpF
	s8CayrCr4UJF12k3say343CFyrZ3sa9r9rKFW2qw1Uur9Fy3WkZrZrCFyUAFsrArWkGryj
	qFZ7uayjkF15GagCm3ZEXasCq-sJn29KB7ZKAUJUUUU3529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUPYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1ln4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2
	x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5
	McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7
	I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCF
	x2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUtVW8ZwC20s026c02F40E14v26r
	1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij
	64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr
	0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF
	0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jz5lbUUUUU=


在 2025/4/6 下午5:05, Huacai Chen 写道:
> Hi, Qunqin,
>
> On Thu, Apr 3, 2025 at 10:46 AM Qunqin Zhao <zhaoqunqin@loongson.cn> wrote:
>> Loongson's Random Number Generator is found inside Loongson security
>> engine.
>>
>> Co-developed-by: Yinggang Gu <guyinggang@loongson.cn>
>> Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
>> Signed-off-by: Qunqin Zhao <zhaoqunqin@loongson.cn>
>> Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
>> ---
>> v7: Change the lsrng_ prefix to loongson_rng_
>> v6: Replace all "ls6000se" with "loongson"
>> v2-v5: None
>>
>>   drivers/crypto/Kconfig                 |   1 +
>>   drivers/crypto/Makefile                |   1 +
>>   drivers/crypto/loongson/Kconfig        |   6 +
>>   drivers/crypto/loongson/Makefile       |   2 +
>>   drivers/crypto/loongson/loongson-rng.c | 190 +++++++++++++++++++++++++
>>   5 files changed, 200 insertions(+)
>>   create mode 100644 drivers/crypto/loongson/Kconfig
>>   create mode 100644 drivers/crypto/loongson/Makefile
>>   create mode 100644 drivers/crypto/loongson/loongson-rng.c
>>
>> diff --git a/drivers/crypto/Kconfig b/drivers/crypto/Kconfig
>> index 19ab145f9..567ed81b0 100644
>> --- a/drivers/crypto/Kconfig
>> +++ b/drivers/crypto/Kconfig
>> @@ -855,5 +855,6 @@ config CRYPTO_DEV_SA2UL
>>
>>   source "drivers/crypto/aspeed/Kconfig"
>>   source "drivers/crypto/starfive/Kconfig"
>> +source "drivers/crypto/loongson/Kconfig"
>>
>>   endif # CRYPTO_HW
>> diff --git a/drivers/crypto/Makefile b/drivers/crypto/Makefile
>> index fef18ffdb..643c3710b 100644
>> --- a/drivers/crypto/Makefile
>> +++ b/drivers/crypto/Makefile
>> @@ -50,3 +50,4 @@ obj-y += hisilicon/
>>   obj-$(CONFIG_CRYPTO_DEV_AMLOGIC_GXL) += amlogic/
>>   obj-y += intel/
>>   obj-y += starfive/
>> +obj-y += loongson/
>> diff --git a/drivers/crypto/loongson/Kconfig b/drivers/crypto/loongson/Kconfig
>> new file mode 100644
>> index 000000000..4368701ad
>> --- /dev/null
>> +++ b/drivers/crypto/loongson/Kconfig
>> @@ -0,0 +1,6 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +config CRYPTO_DEV_LOONGSON_RNG
>> +        tristate "Support for Loongson RNG Driver"
>> +        depends on MFD_LOONGSON_SE
>> +        help
>> +          Support for Loongson RNG Driver.
>> diff --git a/drivers/crypto/loongson/Makefile b/drivers/crypto/loongson/Makefile
>> new file mode 100644
>> index 000000000..b8b013c86
>> --- /dev/null
>> +++ b/drivers/crypto/loongson/Makefile
>> @@ -0,0 +1,2 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +obj-$(CONFIG_CRYPTO_DEV_LOONGSON_RNG)  += loongson-rng.o
>> diff --git a/drivers/crypto/loongson/loongson-rng.c b/drivers/crypto/loongson/loongson-rng.c
>> new file mode 100644
>> index 000000000..307014992
>> --- /dev/null
>> +++ b/drivers/crypto/loongson/loongson-rng.c
>> @@ -0,0 +1,190 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/* Copyright (c) 2019 HiSilicon Limited. */
>> +/* Copyright (c) 2025 Loongson Technology Corporation Limited. */
>> +
>> +#include <linux/crypto.h>
>> +#include <linux/err.h>
>> +#include <linux/hw_random.h>
>> +#include <linux/io.h>
>> +#include <linux/iopoll.h>
>> +#include <linux/kernel.h>
>> +#include <linux/list.h>
>> +#include <linux/mfd/loongson-se.h>
>> +#include <linux/module.h>
>> +#include <linux/mutex.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/random.h>
>> +#include <crypto/internal/rng.h>
>> +
>> +struct loongson_rng_list {
>> +       struct mutex lock;
>> +       struct list_head list;
>> +       int is_init;
>> +};
>> +
>> +struct lsrng {
>> +       bool is_used;
>> +       struct se_channel *se_ch;
>> +       struct list_head list;
>> +       struct completion rng_completion;
>> +};
> Since there are other comments that should be addressed, you can
> rename lsrng to loongson_rng to keep consistency.

OK, thanks

Qunqin.


