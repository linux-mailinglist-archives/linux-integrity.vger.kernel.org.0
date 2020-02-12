Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0541915B385
	for <lists+linux-integrity@lfdr.de>; Wed, 12 Feb 2020 23:22:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbgBLWWl (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 12 Feb 2020 17:22:41 -0500
Received: from linux.microsoft.com ([13.77.154.182]:45106 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727564AbgBLWWl (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 12 Feb 2020 17:22:41 -0500
Received: from [10.137.112.97] (unknown [131.107.147.225])
        by linux.microsoft.com (Postfix) with ESMTPSA id 336432010ADE;
        Wed, 12 Feb 2020 14:22:40 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 336432010ADE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1581546160;
        bh=Gfu4834khvWd5NyU28yO95P+YwjE64NeIVO9DnT21f8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=WkUUywFKYC7RryjuGd40mQ/FV4j+fINQ+zFxsDHVh79zh5hEnQHdvjb3ybijJLW/d
         1JrSenIX6wU6tE+cbz5RBrdGJ7wiKCNOT2DqgsUOgKO3yXO/Blz5w5MoGc3KgDxC57
         xbYN8LDWOrpTi+8iVI8B73fAHEEyk1XpPjgTDOts=
Subject: Re: [PATCH v3 0/3] IMA: improve log messages in IMA
To:     Mimi Zohar <zohar@linux.ibm.com>, joe@perches.com,
        skhan@linuxfoundation.org, linux-integrity@vger.kernel.org
Cc:     sashal@kernel.org, nramas@linux.microsoft.com,
        linux-kernel@vger.kernel.org
References: <20200211231414.6640-1-tusharsu@linux.microsoft.com>
 <1581521009.8515.72.camel@linux.ibm.com>
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
Message-ID: <3a2b7a5e-5759-2f29-80bb-e71dda8e5cec@linux.microsoft.com>
Date:   Wed, 12 Feb 2020 14:22:39 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1581521009.8515.72.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 2020-02-12 7:23 a.m., Mimi Zohar wrote:
> Hi Tushar,
> 
> "in IMA" is redundant in the above Subject line.
> 
Thanks Mimi. I will fix it in the next iteration.

> On Tue, 2020-02-11 at 15:14 -0800, Tushar Sugandhi wrote:
>> Some files under IMA prefix the log statement with the respective file
>> names and not with the string "ima". This is not consistent with the rest
>> of the IMA files.
>>
>> The function process_buffer_measurement() does not have log messages for
>> failure conditions.
>>
>> The #define for formatting log messages, pr_fmt, is duplicated in the
>> files under security/integrity.
>>
>> This patchset addresses the above issues.
> 
> The cover letter should provide a summary of the problem(s) being
> addressed by the individual patches, not a repetition of the
> individual patch descriptions.
> 
Thanks. I will fix the cover letter description in the next iteration.

> Mimi
> 
>>
>> Tushar Sugandhi (3):
>>    add log prefix to ima_mok.c, ima_asymmetric_keys.c, ima_queue_keys.c
>>    add log message to process_buffer_measurement failure conditions
>>    add module name and base name prefix to log statements
>>
>>   security/integrity/digsig.c                  | 2 --
>>   security/integrity/digsig_asymmetric.c       | 2 --
>>   security/integrity/evm/evm_crypto.c          | 2 --
>>   security/integrity/evm/evm_main.c            | 2 --
>>   security/integrity/evm/evm_secfs.c           | 2 --
>>   security/integrity/ima/Makefile              | 6 +++---
>>   security/integrity/ima/ima_asymmetric_keys.c | 2 --
>>   security/integrity/ima/ima_crypto.c          | 2 --
>>   security/integrity/ima/ima_fs.c              | 2 --
>>   security/integrity/ima/ima_init.c            | 2 --
>>   security/integrity/ima/ima_kexec.c           | 1 -
>>   security/integrity/ima/ima_main.c            | 5 +++--
>>   security/integrity/ima/ima_policy.c          | 2 --
>>   security/integrity/ima/ima_queue.c           | 2 --
>>   security/integrity/ima/ima_queue_keys.c      | 2 --
>>   security/integrity/ima/ima_template.c        | 2 --
>>   security/integrity/ima/ima_template_lib.c    | 2 --
>>   security/integrity/integrity.h               | 6 ++++++
>>   18 files changed, 12 insertions(+), 34 deletions(-)
>>
