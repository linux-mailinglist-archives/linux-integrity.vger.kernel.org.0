Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54DBA15B398
	for <lists+linux-integrity@lfdr.de>; Wed, 12 Feb 2020 23:25:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727947AbgBLWZU (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 12 Feb 2020 17:25:20 -0500
Received: from linux.microsoft.com ([13.77.154.182]:46070 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727564AbgBLWZU (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 12 Feb 2020 17:25:20 -0500
Received: from [10.137.112.97] (unknown [131.107.147.225])
        by linux.microsoft.com (Postfix) with ESMTPSA id 601FE20B9C02;
        Wed, 12 Feb 2020 14:25:19 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 601FE20B9C02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1581546319;
        bh=EK492kUpferPtd3ir32dLEL2sG+uHfaicrUji4e0uDo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=pCKkrMlySrkSHXPiF1TAQtj9W/1MGhSzjq6QV0x6wLdndbAs/krqJT63bgwl9X56r
         iBQoAIiDKhRvVlSmallft66lsgoRw5bY3UWHSAzGTA5lZi6h5oR8uIGxZhEcm94gPI
         nyr3s15WlQLhYLpQTDSTYR3IgxVJu2vL+NNJVhCA=
Subject: Re: [PATCH v3 1/3] IMA: Update KBUILD_MODNAME for IMA files to ima
To:     Mimi Zohar <zohar@linux.ibm.com>, joe@perches.com,
        skhan@linuxfoundation.org, linux-integrity@vger.kernel.org
Cc:     sashal@kernel.org, nramas@linux.microsoft.com,
        linux-kernel@vger.kernel.org
References: <20200211231414.6640-1-tusharsu@linux.microsoft.com>
 <20200211231414.6640-2-tusharsu@linux.microsoft.com>
 <1581518950.8515.51.camel@linux.ibm.com>
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
Message-ID: <a3cbb918-887a-4534-144b-7a392d766bdb@linux.microsoft.com>
Date:   Wed, 12 Feb 2020 14:25:19 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1581518950.8515.51.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 2020-02-12 6:49 a.m., Mimi Zohar wrote:
> On Tue, 2020-02-11 at 15:14 -0800, Tushar Sugandhi wrote:
>> Log statements from ima_mok.c, ima_asymmetric_keys.c, and
>> ima_queue_keys.c are prefixed with the respective file names
>> and not with the string "ima".
> 
> Before listing the specific filenames, the patch description should
> provide a generic explanation of the problem.  For example, the kernel
> Makefile "obj-$CONFIG_XXXX" specifies object files which may be built
> as loadable kernel modules[1].
> 
Thanks Mimi. I will update the patch description in the next iteration.


> Mimi
> 
> [1] Refer to Documentation/kbuild/makefiles.rst
> 
>>
>> This change fixes the log statement prefix to be consistent with the rest
>> of the IMA files.
>>
>> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
>> Reviewed-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
>> ---
>>   security/integrity/ima/Makefile | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/security/integrity/ima/Makefile b/security/integrity/ima/Makefile
>> index 064a256f8725..67dabca670e2 100644
>> --- a/security/integrity/ima/Makefile
>> +++ b/security/integrity/ima/Makefile
>> @@ -11,6 +11,6 @@ ima-y := ima_fs.o ima_queue.o ima_init.o ima_main.o ima_crypto.o ima_api.o \
>>   ima-$(CONFIG_IMA_APPRAISE) += ima_appraise.o
>>   ima-$(CONFIG_IMA_APPRAISE_MODSIG) += ima_modsig.o
>>   ima-$(CONFIG_HAVE_IMA_KEXEC) += ima_kexec.o
>> -obj-$(CONFIG_IMA_BLACKLIST_KEYRING) += ima_mok.o
>> -obj-$(CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS) += ima_asymmetric_keys.o
>> -obj-$(CONFIG_IMA_QUEUE_EARLY_BOOT_KEYS) += ima_queue_keys.o
>> +ima-$(CONFIG_IMA_BLACKLIST_KEYRING) += ima_mok.o
>> +ima-$(CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS) += ima_asymmetric_keys.o
>> +ima-$(CONFIG_IMA_QUEUE_EARLY_BOOT_KEYS) += ima_queue_keys.o
