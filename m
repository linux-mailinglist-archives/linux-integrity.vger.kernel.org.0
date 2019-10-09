Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4EBA1D1A0B
	for <lists+linux-integrity@lfdr.de>; Wed,  9 Oct 2019 22:49:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731134AbfJIUtL (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 9 Oct 2019 16:49:11 -0400
Received: from linux.microsoft.com ([13.77.154.182]:53156 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728804AbfJIUtK (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 9 Oct 2019 16:49:10 -0400
Received: from [10.200.156.146] (unknown [167.220.2.18])
        by linux.microsoft.com (Postfix) with ESMTPSA id 9792520B71C6;
        Wed,  9 Oct 2019 13:49:09 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9792520B71C6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1570654149;
        bh=R1XYwLvD2iwGBu/tSvMiVcIj6u8j47QQ6okMOZpNB7U=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=DKXLDx2TpAjvOkCcLD+fMOQ+UmAKk9f0J4PKC6kqYILap7MQfAxBIF2iiDgV4XJLq
         GWrcnyuAANdZF6aJ12FQZieemm+kz1XCRB86ccPD2aAux00sIXbYcxnvl7Jf912bkQ
         R+9ELrLAIdqH9L7Ny8K/E71UScCwE4MURLnjvU3Y=
Subject: Re: [PATCH v2 1/2] Add support for arm64 to carry ima measurement log
 in kexec_file_load
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-integrity@vger.kernel.org, kexec@lists.infradead.org,
        arnd@arndb.de, jean-philippe@linaro.org, allison@lohutok.net,
        kristina.martsenko@arm.org, yamada.masahiro@socionext.com,
        duwe@lst.de, mark.rutland@arm.com, tglx@linutronix.de,
        takahiro.akashi@linaro.org, james.morse@arm.org,
        catalin.marinas@arm.com, sboyd@kernel.org, bauerman@linux.ibm.com,
        zohar@linux.ibm.com
References: <20191007185943.1828-1-prsriva@linux.microsoft.com>
 <20191007185943.1828-2-prsriva@linux.microsoft.com>
 <20191008212224.GC1396@sasha-vm>
From:   prsriva <prsriva@linux.microsoft.com>
Message-ID: <b4ca20f8-dc8c-7266-de54-8062cf6ac8e3@linux.microsoft.com>
Date:   Wed, 9 Oct 2019 13:49:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191008212224.GC1396@sasha-vm>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 10/8/19 2:22 PM, Sasha Levin wrote:
> On Mon, Oct 07, 2019 at 11:59:42AM -0700, Prakhar Srivastava wrote:
>> During kexec_file_load, carrying forward the ima measurement log allows
>> a verifying party to get the entire runtime event log since the last
>> full reboot since that is when PCRs were last reset.
>>
>> Signed-off-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
>> ---
>> arch/Kconfig                           |   6 +-
>> arch/arm64/include/asm/ima.h           |  24 +++
>> arch/arm64/include/asm/kexec.h         |   5 +
>> arch/arm64/kernel/Makefile             |   3 +-
>> arch/arm64/kernel/ima_kexec.c          |  78 ++++++++++
>> arch/arm64/kernel/machine_kexec_file.c |   6 +
>> drivers/of/Kconfig                     |   6 +
>> drivers/of/Makefile                    |   1 +
>> drivers/of/of_ima.c                    | 204 +++++++++++++++++++++++++
>> include/linux/of.h                     |  31 ++++
>> 10 files changed, 362 insertions(+), 2 deletions(-)
>> create mode 100644 arch/arm64/include/asm/ima.h
>> create mode 100644 arch/arm64/kernel/ima_kexec.c
>> create mode 100644 drivers/of/of_ima.c
>>
>> diff --git a/arch/Kconfig b/arch/Kconfig
>> index a7b57dd42c26..d53e1596c5b1 100644
>> --- a/arch/Kconfig
>> +++ b/arch/Kconfig
>> @@ -19,7 +19,11 @@ config KEXEC_CORE
>>     bool
>>
>> config HAVE_IMA_KEXEC
>> -    bool
>> +    bool "Carry over IMA measurement log during kexec_file_load() 
>> syscall"
>> +    depends on KEXEC_FILE
>> +    help
>> +      Select this option to carry over IMA measurement log during
>> +      kexec_file_load.
> 
> This change looks very wrong: HAVE_* config symbols are used to indicate
> the availability of certain arch specific capability, rather than act as
> a config option. How does this work with CONFIG_IMA_KEXEC ?
> 
Thanks for pointing this out. My attempt was to move this out of arch 
dependent config. I will fix the CONFIG.

> Also, please, at the very least verify that basic functionality works on
> the architectures we have access to. Trying it on x86:
> 

Let me fix the build issues for other archs.
I have tested these changes for arm64.

> $ make allmodconfig
> scripts/kconfig/conf  --allmodconfig Kconfig
> #
> # No change to .config
> #
> $ make
>   CALL    scripts/checksyscalls.sh
>   CALL    scripts/atomic/check-atomics.sh
>   DESCEND  objtool
>   CC      security/integrity/ima/ima_fs.o
> In file included from security/integrity/ima/ima_fs.c:26:
> security/integrity/ima/ima.h:28:10: fatal error: asm/ima.h: No such file 
> or directory
> #include <asm/ima.h>
>           ^~~~~~~~~~~
> compilation terminated.
> make[3]: *** [scripts/Makefile.build:266: 
> security/integrity/ima/ima_fs.o] Error 1
> make[2]: *** [scripts/Makefile.build:509: security/integrity/ima] Error 2
> make[1]: *** [scripts/Makefile.build:509: security/integrity] Error 2
> make: *** [Makefile:1649: security] Error 2
> 
> -- 
> Thanks,
> Sasha
