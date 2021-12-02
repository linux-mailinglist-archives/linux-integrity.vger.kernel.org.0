Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F5DA46690D
	for <lists+linux-integrity@lfdr.de>; Thu,  2 Dec 2021 18:26:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376310AbhLBR3u (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 2 Dec 2021 12:29:50 -0500
Received: from foss.arm.com ([217.140.110.172]:38386 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1376307AbhLBR3u (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 2 Dec 2021 12:29:50 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 72E80142F;
        Thu,  2 Dec 2021 09:26:26 -0800 (PST)
Received: from [10.57.34.58] (unknown [10.57.34.58])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 350B63F73B;
        Thu,  2 Dec 2021 09:26:24 -0800 (PST)
Message-ID: <bd677501-bd65-9648-c8f5-1b90983377b5@arm.com>
Date:   Thu, 2 Dec 2021 17:26:19 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v4 04/14] Documentation/x86: Secure Launch kernel
 documentation
Content-Language: en-GB
To:     Ross Philipson <ross.philipson@oracle.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        iommu@lists.linux-foundation.org, linux-integrity@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     dpsmith@apertussolutions.com, luto@amacapital.net,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        kanth.ghatraju@oracle.com, tglx@linutronix.de,
        trenchboot-devel@googlegroups.com
References: <1630070917-9896-1-git-send-email-ross.philipson@oracle.com>
 <1630070917-9896-5-git-send-email-ross.philipson@oracle.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <1630070917-9896-5-git-send-email-ross.philipson@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 2021-08-27 14:28, Ross Philipson wrote:
[...]
> +IOMMU Configuration
> +-------------------
> +
> +When doing a Secure Launch, the IOMMU should always be enabled and the drivers
> +loaded. However, IOMMU passthrough mode should never be used. This leaves the
> +MLE completely exposed to DMA after the PMR's [2]_ are disabled. First, IOMMU
> +passthrough should be disabled by default in the build configuration::
> +
> +  "Device Drivers" -->
> +      "IOMMU Hardware Support" -->
> +          "IOMMU passthrough by default [ ]"
> +
> +This unset the Kconfig value CONFIG_IOMMU_DEFAULT_PASSTHROUGH.

Note that the config structure has now changed, and if set, passthrough 
is deselected by choosing a different default domain type.

> +In addition, passthrough must be disabled on the kernel command line when doing
> +a Secure Launch as follows::
> +
> +  iommu=nopt iommu.passthrough=0

This part is a bit silly - those options are literally aliases for the 
exact same thing, and furthermore if the config is already set as 
required then the sole effect either of them will have is to cause "(set 
by kernel command line)" to be printed. There is no value in explicitly 
overriding the default value with the default value - if anyone can 
append an additional "iommu.passthrough=1" (or "iommu=pt") to the end of 
the command line they'll still win.

Robin.
