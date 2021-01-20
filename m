Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD9E92FC9B8
	for <lists+linux-integrity@lfdr.de>; Wed, 20 Jan 2021 05:07:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbhATEFZ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 19 Jan 2021 23:05:25 -0500
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:53985 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731536AbhATEFK (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 19 Jan 2021 23:05:10 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UMIdHZ._1611115429;
Received: from 30.25.183.227(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0UMIdHZ._1611115429)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 20 Jan 2021 12:03:50 +0800
Subject: Re: [PATCH] tpm/tpm_tis: Fix variable reset during IRQ probing
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia Zhang <zhang.jia@linux.alibaba.com>
References: <20210113120021.59045-1-tianjia.zhang@linux.alibaba.com>
 <X/+xr/L+m2k5fObZ@kernel.org>
 <44c35c27-0cd4-e451-1b9c-d6fe48e58e51@linux.alibaba.com>
 <YAFfIqaohjneVCO6@kernel.org>
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Message-ID: <60b7bb82-c762-cf67-6b73-7ecb2a0f1085@linux.alibaba.com>
Date:   Wed, 20 Jan 2021 12:03:49 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <YAFfIqaohjneVCO6@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 1/15/21 5:23 PM, Jarkko Sakkinen wrote:
> On Thu, Jan 14, 2021 at 12:12:16PM +0800, Tianjia Zhang wrote:
>>
>>
>> On 1/14/21 10:51 AM, Jarkko Sakkinen wrote:
>>> On Wed, Jan 13, 2021 at 08:00:21PM +0800, Tianjia Zhang wrote:
>>>> In tpm_tis_core_init(), tpm2_probe() will be called first, this
>>>> function will eventually call tpm_tis_send(), and then
>>>> tpm_tis_probe_irq_single() will detect whether the interrupt is
>>>> normal, mainly the installation interrupted, set `priv->irq_tested`
>>>> to false. The logic will eventually be executed to tpm_tis_send()
>>>> to trigger an interrupt.
>>>>
>>>> There is currently such a scenario, which will cause the IRQ probe
>>>> code to never be executed, so that the TPM device is in polling
>>>> mode: after setting irq_tested to false, an interrupt occurs
>>>> between entering the ttpm_tis_send() function, and the interrupt
>>>> will be first set irq_tested to true will cause the IRQ probe code
>>>> to never be executed.
>>>
>>> Can you describe the scenario more detail?
>>>
>>
>> The problematic scenario we encountered is like this. The following figure
>> shows the execution flow of tpm_tis_core_init(). An interrupt occurred
>> before the IRQ probe. This interrupt was caused by tpm2_probe(), but it was
>> triggered before the IRQ probe was executed, and the interrupt handler would
>> set irq_tested to true, so the IRQ probe code can never execute, that is,
>> the code marked 2 in the figure will never happen.
> 
> TPM_INT_ENABLE is cleared on reset [*].
> 
> [*] Section 5.9.1
>      https://trustedcomputinggroup.org/resource/pc-client-work-group-pc-client-specific-tpm-interface-specification-tis/
> 
> /Jarkko
> 

Hi,

I got it, this seems to be a firmware issue. Thanks for your reply.

Best regards,
Tianjia
