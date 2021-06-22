Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C53493B025C
	for <lists+linux-integrity@lfdr.de>; Tue, 22 Jun 2021 13:06:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbhFVLJE (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 22 Jun 2021 07:09:04 -0400
Received: from foss.arm.com ([217.140.110.172]:47102 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229769AbhFVLJE (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 22 Jun 2021 07:09:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 779A231B;
        Tue, 22 Jun 2021 04:06:48 -0700 (PDT)
Received: from [10.57.9.136] (unknown [10.57.9.136])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 880143F694;
        Tue, 22 Jun 2021 04:06:46 -0700 (PDT)
Subject: Re: [PATCH v2 12/12] iommu: Do not allow IOMMU passthrough with
 Secure Launch
To:     Ross Philipson <ross.philipson@oracle.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        iommu@lists.linux-foundation.org, linux-integrity@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     dpsmith@apertussolutions.com, luto@amacapital.net,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, tglx@linutronix.de,
        trenchboot-devel@googlegroups.com
References: <1624032777-7013-1-git-send-email-ross.philipson@oracle.com>
 <1624032777-7013-13-git-send-email-ross.philipson@oracle.com>
 <53edcf0e-c094-876c-ac3d-7c9752e9ea99@arm.com>
 <34d05f0e-b24c-b8cf-c521-8b30cc1df532@oracle.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <8376f5ec-f228-0e82-a032-401f91b6aa3b@arm.com>
Date:   Tue, 22 Jun 2021 12:06:39 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <34d05f0e-b24c-b8cf-c521-8b30cc1df532@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 2021-06-21 18:51, Ross Philipson wrote:
> On 6/18/21 2:32 PM, Robin Murphy wrote:
>> On 2021-06-18 17:12, Ross Philipson wrote:
>>> The IOMMU should always be set to default translated type after
>>> the PMRs are disabled to protect the MLE from DMA.
>>>
>>> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
>>> ---
>>>    drivers/iommu/intel/iommu.c | 5 +++++
>>>    drivers/iommu/iommu.c       | 6 +++++-
>>>    2 files changed, 10 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>>> index be35284..4f0256d 100644
>>> --- a/drivers/iommu/intel/iommu.c
>>> +++ b/drivers/iommu/intel/iommu.c
>>> @@ -41,6 +41,7 @@
>>>    #include <linux/dma-direct.h>
>>>    #include <linux/crash_dump.h>
>>>    #include <linux/numa.h>
>>> +#include <linux/slaunch.h>
>>>    #include <asm/irq_remapping.h>
>>>    #include <asm/cacheflush.h>
>>>    #include <asm/iommu.h>
>>> @@ -2877,6 +2878,10 @@ static bool device_is_rmrr_locked(struct device
>>> *dev)
>>>     */
>>>    static int device_def_domain_type(struct device *dev)
>>>    {
>>> +    /* Do not allow identity domain when Secure Launch is configured */
>>> +    if (slaunch_get_flags() & SL_FLAG_ACTIVE)
>>> +        return IOMMU_DOMAIN_DMA;
>>
>> Is this specific to Intel? It seems like it could easily be done
>> commonly like the check for untrusted external devices.
> 
> It is currently Intel only but that will change. I will look into what
> you suggest.

Yeah, it's simple and unobtrusive enough that I reckon it's worth going 
straight to the common version if it's worth doing at all.

>>> +
>>>        if (dev_is_pci(dev)) {
>>>            struct pci_dev *pdev = to_pci_dev(dev);
>>>    diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>>> index 808ab70d..d49b7dd 100644
>>> --- a/drivers/iommu/iommu.c
>>> +++ b/drivers/iommu/iommu.c
>>> @@ -23,6 +23,7 @@
>>>    #include <linux/property.h>
>>>    #include <linux/fsl/mc.h>
>>>    #include <linux/module.h>
>>> +#include <linux/slaunch.h>
>>>    #include <trace/events/iommu.h>
>>>      static struct kset *iommu_group_kset;
>>> @@ -2761,7 +2762,10 @@ void iommu_set_default_passthrough(bool cmd_line)
>>>    {
>>>        if (cmd_line)
>>>            iommu_cmd_line |= IOMMU_CMD_LINE_DMA_API;
>>> -    iommu_def_domain_type = IOMMU_DOMAIN_IDENTITY;
>>> +
>>> +    /* Do not allow identity domain when Secure Launch is configured */
>>> +    if (!(slaunch_get_flags() & SL_FLAG_ACTIVE))
>>> +        iommu_def_domain_type = IOMMU_DOMAIN_IDENTITY;
>>
>> Quietly ignoring the setting and possibly leaving iommu_def_domain_type
>> uninitialised (note that 0 is not actually a usable type) doesn't seem
>> great. AFAICS this probably warrants similar treatment to the
> 
> Ok so I guess it would be better to set it to IOMMU_DOMAIN_DMA event
> though passthrough was requested. Or perhaps something more is needed here?
> 
>> mem_encrypt_active() case - there doesn't seem a great deal of value in
>> trying to save users from themselves if they care about measured boot
>> yet explicitly pass options which may compromise measured boot. If you
>> really want to go down that route there's at least the sysfs interface
>> you'd need to nobble as well, not to mention the various ways of
>> completely disabling IOMMUs...
> 
> Doing a secure launch with the kernel is not a general purpose user use
> case. A lot of work is done to secure the environment. Allowing
> passthrough mode would leave the secure launch kernel exposed to DMA. I
> think what we are trying to do here is what we intend though there may
> be a better way or perhaps it is incomplete as you suggest.

On second thoughts this is overkill anyway - if you do hook 
iommu_get_def_domain_type(), you're done (in terms of the kernel-managed 
setting, at least); it doesn't matter what iommu_def_domain_type gets 
set to if will never get used. However, since this isn't really a 
per-device thing, it might be more semantically appropriate to leave 
that alone and instead only massage the default type in 
iommu_subsys_init(), as for memory encryption.

When you say "secure the environment", what's the actual threat model 
here, i.e. who's securing what against whom? If it's a device lockdown 
type thing where the system owner wants to defend against the end user 
trying to mess with the software stack or gain access to parts they 
shouldn't, then possibly you can trust the command line, but there are 
definitely other places which need consideration. If on the other hand 
it's more about giving the end user confidence that their choice of 
software stack isn't being interfered with by a malicious host or 
external third parties, then it probably leans towards the opposite 
being true...

If the command line *is* within the threat model, consider "iommu=off" 
and/or "intel_iommu=off" for example: I don't know how PMRs work, but I 
can only imagine that that's liable to leave things either wide open, or 
blocked to the point of no DMA working at all, neither of which seems to 
be what you want. I'm guessing "intel_iommu=tboot_noforce" might have 
some relevant implications too.

>> It might be reasonable to make IOMMU_DEFAULT_PASSTHROUGH depend on
>> !SECURE_LAUNCH for clarity though.
> 
> This came from a specific request to not make disabling IOMMU modes
> build time dependent. This is because a secure launch enabled kernel can
> also be booted as a general purpose kernel in cases where this is desired.

Ah, thanks for clarifying - I was wondering about that aspect. FWIW, 
note that that wouldn't actually change any functionality - it's a 
non-default config option anyway, and users could still override it 
either way in a non-secure-launch setup - but it sounds like it might be 
effectively superfluous if you do need to make a more active runtime 
decision anyway.

Cheers,
Robin.
