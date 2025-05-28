Return-Path: <linux-integrity+bounces-6322-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4EDFAC63AD
	for <lists+linux-integrity@lfdr.de>; Wed, 28 May 2025 10:07:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4155E4E0511
	for <lists+linux-integrity@lfdr.de>; Wed, 28 May 2025 08:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D75A0246796;
	Wed, 28 May 2025 08:06:47 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2F3224728C;
	Wed, 28 May 2025 08:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748419607; cv=none; b=LCfZydscWsw9ZO4NZikABE6LZjd8CjQG/2ROnVCtNeyIaAAo3D+qjJhCtO0ibNLyqGmSmgwSuzUZ7bBlCRnzoV8YDPZiQVrZX0sTEcFkd7Xhzo9fuS65qb5RchK5kseY6164qnitk0Uxj6cKtS84EWxB/+TaxHjXepqUTbY2kIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748419607; c=relaxed/simple;
	bh=Utmj1w9gpAnryKiUXD1QajcvknvGJPR2n8w8hmdFaHw=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=WV7VtxIwCtEDy9H64c7/sS0VzJJCK9+mu/f9a/LbUJFa1aT5sqVTRQfxeTC3uOL1m1Dv+8S9WM6USAwUymTmKA/Rp5EXJJjkEKWY/YE4UnkiHlI4piyB4dHgpP5DQIx+lq+PiwzCAI+m/oWCRRfsxymgEQkZ9AtiGRCd/csqsoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.164])
	by gateway (Coremail) with SMTP id _____8Bx22oRxDZo5Mb_AA--.49226S3;
	Wed, 28 May 2025 16:06:41 +0800 (CST)
Received: from [10.20.42.164] (unknown [10.20.42.164])
	by front1 (Coremail) with SMTP id qMiowMDxfRsLxDZolYv3AA--.27101S2;
	Wed, 28 May 2025 16:06:38 +0800 (CST)
Subject: Re: [PATCH v10 0/5] Add Loongson Security Engine chip driver
To: Huacai Chen <chenhuacai@kernel.org>
Cc: lee@kernel.org, herbert@gondor.apana.org.au, jarkko@kernel.org,
 linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
 davem@davemloft.net, linux-crypto@vger.kernel.org, peterhuewe@gmx.de,
 jgg@ziepe.ca, linux-integrity@vger.kernel.org
References: <20250528065944.4511-1-zhaoqunqin@loongson.cn>
 <CAAhV-H7hBksA2P+vfMbpDVnbjW1Mo09Out_wOQLgLRXPLaFCfA@mail.gmail.com>
From: Qunqin Zhao <zhaoqunqin@loongson.cn>
Message-ID: <cda7ef56-87b3-6594-c2b6-2a4f5a1b63ce@loongson.cn>
Date: Wed, 28 May 2025 16:05:39 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAAhV-H7hBksA2P+vfMbpDVnbjW1Mo09Out_wOQLgLRXPLaFCfA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:qMiowMDxfRsLxDZolYv3AA--.27101S2
X-CM-SenderInfo: 52kd01pxqtx0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoWxXF4ktFWfCry3XFyrXw18Zwc_yoW5ZF47pF
	45Ca9xCr4UJF47C3s3t34rCFyrZ3s3Jr9rKa9rXw15ur9rAa4xXrW7AFyUCFW7ZF1rGry2
	vFWxCF43uF15AacCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUPFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWU
	twAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMx
	k0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l
	4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxV
	WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI
	7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
	1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI
	42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUcpBTUUUUU


在 2025/5/28 下午3:17, Huacai Chen 写道:
> Hi, Qunqin,
>
> As I said before, why the patch "MAINTAINERS: Add entry for Loongson
> Security Module driver" is missing?

Hi, Huacai

https://lore.kernel.org/all/8e55801a-a46e-58d5-cf84-2ee8a733df9a@loongson.cn/

Thanks,

Qunqin.

>
> Huacai
>
> On Wed, May 28, 2025 at 2:59 PM Qunqin Zhao <zhaoqunqin@loongson.cn> wrote:
>> The Loongson Security Engine chip supports RNG, SM2, SM3 and SM4
>> accelerator engines. Each engine have its own DMA buffer provided
>> by the controller. The kernel cannot directly send commands to the
>> engine and must first send them to the controller, which will
>> forward them to the corresponding engine. Based on these engines,
>> TPM2 have been implemented in the chip, then let's treat TPM2 itself
>> as an engine.
>>
>> v10: mfd: Cleanned up coding style.
>>       crypto: Unlimited tfm
>>       tpm: Added error check
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
>>      Removed complete callback in all driver. Removed the concepts of
>>      "channel", "msg" and "request" as they may be confusing. Used
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
>>   drivers/char/tpm/tpm_loongson.c        |  84 ++++++++
>>   drivers/crypto/Kconfig                 |   1 +
>>   drivers/crypto/Makefile                |   1 +
>>   drivers/crypto/loongson/Kconfig        |   5 +
>>   drivers/crypto/loongson/Makefile       |   1 +
>>   drivers/crypto/loongson/loongson-rng.c | 211 +++++++++++++++++++++
>>   drivers/mfd/Kconfig                    |  11 ++
>>   drivers/mfd/Makefile                   |   2 +
>>   drivers/mfd/loongson-se.c              | 253 +++++++++++++++++++++++++
>>   include/linux/mfd/loongson-se.h        |  53 ++++++
>>   13 files changed, 641 insertions(+)
>>   create mode 100644 drivers/char/tpm/tpm_loongson.c
>>   create mode 100644 drivers/crypto/loongson/Kconfig
>>   create mode 100644 drivers/crypto/loongson/Makefile
>>   create mode 100644 drivers/crypto/loongson/loongson-rng.c
>>   create mode 100644 drivers/mfd/loongson-se.c
>>   create mode 100644 include/linux/mfd/loongson-se.h
>>
>>
>> base-commit: c89756bcf406af313d191cfe3709e7c175c5b0cd
>> --
>> 2.45.2
>>
>>


