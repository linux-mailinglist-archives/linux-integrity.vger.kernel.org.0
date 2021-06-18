Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE1953AD235
	for <lists+linux-integrity@lfdr.de>; Fri, 18 Jun 2021 20:32:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbhFRSes (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 18 Jun 2021 14:34:48 -0400
Received: from foss.arm.com ([217.140.110.172]:45138 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229945AbhFRSer (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 18 Jun 2021 14:34:47 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 93B121424;
        Fri, 18 Jun 2021 11:32:34 -0700 (PDT)
Received: from [10.57.9.136] (unknown [10.57.9.136])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B0DB93F70D;
        Fri, 18 Jun 2021 11:32:32 -0700 (PDT)
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
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <53edcf0e-c094-876c-ac3d-7c9752e9ea99@arm.com>
Date:   Fri, 18 Jun 2021 19:32:27 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <1624032777-7013-13-git-send-email-ross.philipson@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 2021-06-18 17:12, Ross Philipson wrote:
> The IOMMU should always be set to default translated type after
> the PMRs are disabled to protect the MLE from DMA.
> 
> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
> ---
>   drivers/iommu/intel/iommu.c | 5 +++++
>   drivers/iommu/iommu.c       | 6 +++++-
>   2 files changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index be35284..4f0256d 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -41,6 +41,7 @@
>   #include <linux/dma-direct.h>
>   #include <linux/crash_dump.h>
>   #include <linux/numa.h>
> +#include <linux/slaunch.h>
>   #include <asm/irq_remapping.h>
>   #include <asm/cacheflush.h>
>   #include <asm/iommu.h>
> @@ -2877,6 +2878,10 @@ static bool device_is_rmrr_locked(struct device *dev)
>    */
>   static int device_def_domain_type(struct device *dev)
>   {
> +	/* Do not allow identity domain when Secure Launch is configured */
> +	if (slaunch_get_flags() & SL_FLAG_ACTIVE)
> +		return IOMMU_DOMAIN_DMA;

Is this specific to Intel? It seems like it could easily be done 
commonly like the check for untrusted external devices.

> +
>   	if (dev_is_pci(dev)) {
>   		struct pci_dev *pdev = to_pci_dev(dev);
>   
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 808ab70d..d49b7dd 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -23,6 +23,7 @@
>   #include <linux/property.h>
>   #include <linux/fsl/mc.h>
>   #include <linux/module.h>
> +#include <linux/slaunch.h>
>   #include <trace/events/iommu.h>
>   
>   static struct kset *iommu_group_kset;
> @@ -2761,7 +2762,10 @@ void iommu_set_default_passthrough(bool cmd_line)
>   {
>   	if (cmd_line)
>   		iommu_cmd_line |= IOMMU_CMD_LINE_DMA_API;
> -	iommu_def_domain_type = IOMMU_DOMAIN_IDENTITY;
> +
> +	/* Do not allow identity domain when Secure Launch is configured */
> +	if (!(slaunch_get_flags() & SL_FLAG_ACTIVE))
> +		iommu_def_domain_type = IOMMU_DOMAIN_IDENTITY;

Quietly ignoring the setting and possibly leaving iommu_def_domain_type 
uninitialised (note that 0 is not actually a usable type) doesn't seem 
great. AFAICS this probably warrants similar treatment to the 
mem_encrypt_active() case - there doesn't seem a great deal of value in 
trying to save users from themselves if they care about measured boot 
yet explicitly pass options which may compromise measured boot. If you 
really want to go down that route there's at least the sysfs interface 
you'd need to nobble as well, not to mention the various ways of 
completely disabling IOMMUs...

It might be reasonable to make IOMMU_DEFAULT_PASSTHROUGH depend on 
!SECURE_LAUNCH for clarity though.

Robin.

>   }
>   
>   void iommu_set_default_translated(bool cmd_line)
> 
