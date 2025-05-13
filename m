Return-Path: <linux-integrity+bounces-6186-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5BE1AB4C80
	for <lists+linux-integrity@lfdr.de>; Tue, 13 May 2025 09:12:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25B5A3BDB45
	for <lists+linux-integrity@lfdr.de>; Tue, 13 May 2025 07:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B01971E885A;
	Tue, 13 May 2025 07:12:42 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00CCA1C28E;
	Tue, 13 May 2025 07:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747120362; cv=none; b=QEqUVD2qWaFRyjQpLuI9X1pwTO/rY92e77uRJv0WRQf1jStamAqu80A1x2NgE7hE5Lbb+7CC7dsClpIPvx96KOaQd/T1ghtMMc4Cmkf9thtnY7BEkZ06kQ5XxO0GX/dsY342hXntSu3jYyuPMVKA+FXNvTbgAiot0+1xb+cmPx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747120362; c=relaxed/simple;
	bh=C5gMTCFYqUliZlVx/tFArqRF+j/MUdX1dUf54hkcFyg=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=obWX3NwEvLe+85OTINIIDXZqGJzCNrq1TFS0coeZ9nZMoZ5nF25kYvFGR7MoWPooTSA2VYj5ilVVetMGiPAHrxMogL7m3BZ6ADGeRx2CbSvr1jdtZ5sjococQXG1y2kJGPONQpIAbdAXSB5tFoouXMwG4U8YIByd5miDw/eN7ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.164])
	by gateway (Coremail) with SMTP id _____8CxvnLd8CJoJYLjAA--.43990S3;
	Tue, 13 May 2025 15:12:29 +0800 (CST)
Received: from [10.20.42.164] (unknown [10.20.42.164])
	by front1 (Coremail) with SMTP id qMiowMAxHsfZ8CJo8E_NAA--.54217S2;
	Tue, 13 May 2025 15:12:27 +0800 (CST)
Subject: Re: [PATCH v9 0/5] Add Loongson Security Engine chip driver
To: Huacai Chen <chenhuacai@kernel.org>
Cc: lee@kernel.org, herbert@gondor.apana.org.au, davem@davemloft.net,
 peterhuewe@gmx.de, jarkko@kernel.org, linux-kernel@vger.kernel.org,
 loongarch@lists.linux.dev, linux-crypto@vger.kernel.org, jgg@ziepe.ca,
 linux-integrity@vger.kernel.org, pmenzel@molgen.mpg.de
References: <20250506031947.11130-1-zhaoqunqin@loongson.cn>
 <CAAhV-H58WqEnqG3gJ1iJMrVaJ-okPJweLYwS1odJx4zAP41XpA@mail.gmail.com>
From: Qunqin Zhao <zhaoqunqin@loongson.cn>
Message-ID: <8e55801a-a46e-58d5-cf84-2ee8a733df9a@loongson.cn>
Date: Tue, 13 May 2025 15:12:05 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAAhV-H58WqEnqG3gJ1iJMrVaJ-okPJweLYwS1odJx4zAP41XpA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:qMiowMAxHsfZ8CJo8E_NAA--.54217S2
X-CM-SenderInfo: 52kd01pxqtx0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoWxAF4DKF17Gr13AFW5Gry3Awc_yoW5Zr43pF
	45Cay5Cr4UJr47C3s3t34UCFy5Z3s3Jr9Fga9Fqw15ur9xAa47XrW7CFy7CFW7ZF1rGry2
	vFZ7CF43u3W5AacCm3ZEXasCq-sJn29KB7ZKAUJUUUU3529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUPYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1ln4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2
	x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1D
	McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7
	I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCF
	x2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14v26r
	1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij
	64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr
	0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF
	0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07j5o7tUUUUU=


在 2025/5/11 下午5:34, Huacai Chen 写道:
> Hi, Qunqin,
>
> Where is the 2nd patch in V7?

Hi, Huacai

I added "loongson se. c" and "loongson se. h" to the LOONGSON CRYPTO 
DRIVER entry.

or should i add a separate entry for the mfd driver as done in v7?

Thanks for your comments,

Qunqin.

>
> Huacai
>
> On Tue, May 6, 2025 at 12:33 PM Qunqin Zhao <zhaoqunqin@loongson.cn> wrote:
>> The Loongson Security Engine chip supports RNG, SM2, SM3 and SM4
>> accelerator engines. Each engine have its own DMA buffer provided
>> by the controller. The kernel cannot directly send commands to the
>> engine and must first send them to the controller, which will
>> forward them to the corresponding engine. Based on these engines,
>> TPM2 have been implemented in the chip, then let's treat TPM2 itself
>> as an engine.
>>
>> v9: Moved the base driver back to drivers/mfd. Cleanned up coding style.
>>
>> v8: Like Lee said, the base driver goes beyond MFD scope. Since these
>>      are all encryption related drivers and SM2, SM3, and SM4 drivers
>>      will be added to the crypto subsystem in the future, the base driver
>>      need to be changed when adding these drivers. Therefore, it may be
>>      more appropriate to place the base driver within the crypto
>>      subsystem.
>>
>>      Removed complete callback in all drivers. Removed the concepts of
>>      "channel", "msg" and "request" as they may be confusing. Used the
>>      concepts of "egnine" and "command" may be better.
>>
>> v7: Addressed Huacai's comments.
>>
>> v6: mfd :MFD_LS6000SE -> MFD_LOONGSON_SE,  ls6000se.c -> loongson-se.c
>>
>>      crypto :CRYPTO_DEV_LS6000SE_RNG -> CRYPTO_DEV_LOONGSON_RNG,
>>      ls6000se-rng.c ->loongson-rng.c
>>
>>      tpm: TCG_LSSE -> TCG_LOONGSON, tpm_lsse.c ->tpm_loongson.c
>>
>> v5: Registered "ls6000se-rng" device in mfd driver
>>
>> Qunqin Zhao (5):
>>    mfd: Add support for Loongson Security Engine chip controller
>>    crypto: loongson - add Loongson RNG driver support
>>    MAINTAINERS: Add entry for Loongson crypto driver
>>    tpm: Add a driver for Loongson TPM device
>>    MAINTAINERS: Add tpm_loongson.c to LOONGSON CRYPTO DRIVER entry
>>
>>   MAINTAINERS                            |   9 +
>>   drivers/char/tpm/Kconfig               |   9 +
>>   drivers/char/tpm/Makefile              |   1 +
>>   drivers/char/tpm/tpm_loongson.c        |  78 ++++++++
>>   drivers/crypto/Kconfig                 |   1 +
>>   drivers/crypto/Makefile                |   1 +
>>   drivers/crypto/loongson/Kconfig        |   5 +
>>   drivers/crypto/loongson/Makefile       |   1 +
>>   drivers/crypto/loongson/loongson-rng.c | 197 +++++++++++++++++++++
>>   drivers/mfd/Kconfig                    |  11 ++
>>   drivers/mfd/Makefile                   |   2 +
>>   drivers/mfd/loongson-se.c              | 235 +++++++++++++++++++++++++
>>   include/linux/mfd/loongson-se.h        |  52 ++++++
>>   13 files changed, 602 insertions(+)
>>   create mode 100644 drivers/char/tpm/tpm_loongson.c
>>   create mode 100644 drivers/crypto/loongson/Kconfig
>>   create mode 100644 drivers/crypto/loongson/Makefile
>>   create mode 100644 drivers/crypto/loongson/loongson-rng.c
>>   create mode 100644 drivers/mfd/loongson-se.c
>>   create mode 100644 include/linux/mfd/loongson-se.h
>>
>>
>> base-commit: 92a09c47464d040866cf2b4cd052bc60555185fb
>> --
>> 2.45.2
>>
>>


