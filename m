Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A7A1467ABE
	for <lists+linux-integrity@lfdr.de>; Fri,  3 Dec 2021 17:03:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239741AbhLCQHN (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 3 Dec 2021 11:07:13 -0500
Received: from foss.arm.com ([217.140.110.172]:50900 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234430AbhLCQHN (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 3 Dec 2021 11:07:13 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 15C941435;
        Fri,  3 Dec 2021 08:03:49 -0800 (PST)
Received: from [10.57.34.58] (unknown [10.57.34.58])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0810B3F73B;
        Fri,  3 Dec 2021 08:03:46 -0800 (PST)
Message-ID: <7ee55288-209f-8f19-ef69-27e2a5448473@arm.com>
Date:   Fri, 3 Dec 2021 16:03:42 +0000
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
 <bd677501-bd65-9648-c8f5-1b90983377b5@arm.com>
 <6713b6b2-3c6d-8318-ee9e-e1746f02a3a5@oracle.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <6713b6b2-3c6d-8318-ee9e-e1746f02a3a5@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 2021-12-03 15:47, Ross Philipson wrote:
> On 12/2/21 12:26, Robin Murphy wrote:
>> On 2021-08-27 14:28, Ross Philipson wrote:
>> [...]
>>> +IOMMU Configuration
>>> +-------------------
>>> +
>>> +When doing a Secure Launch, the IOMMU should always be enabled and
>>> the drivers
>>> +loaded. However, IOMMU passthrough mode should never be used. This
>>> leaves the
>>> +MLE completely exposed to DMA after the PMR's [2]_ are disabled.
>>> First, IOMMU
>>> +passthrough should be disabled by default in the build configuration::
>>> +
>>> +  "Device Drivers" -->
>>> +      "IOMMU Hardware Support" -->
>>> +          "IOMMU passthrough by default [ ]"
>>> +
>>> +This unset the Kconfig value CONFIG_IOMMU_DEFAULT_PASSTHROUGH.
>>
>> Note that the config structure has now changed, and if set, passthrough
>> is deselected by choosing a different default domain type.
> 
> Thanks for the heads up. We will have to modify this for how things
> exist today.
> 
>>
>>> +In addition, passthrough must be disabled on the kernel command line
>>> when doing
>>> +a Secure Launch as follows::
>>> +
>>> +  iommu=nopt iommu.passthrough=0
>>
>> This part is a bit silly - those options are literally aliases for the
>> exact same thing, and furthermore if the config is already set as
>> required then the sole effect either of them will have is to cause "(set
>> by kernel command line)" to be printed. There is no value in explicitly
>> overriding the default value with the default value - if anyone can
>> append an additional "iommu.passthrough=1" (or "iommu=pt") to the end of
>> the command line they'll still win.
> 
> I feel like when we worked on this, it was still important to set those
> values. This could have been in an older kernel version. We will go back
> and verify what you are saying here and adjust the documentation
> accordingly.
> 
> As to anyone just adding values to the command line, that is why the
> command line is part of the DRTM measurements.

Yeah, I had a vague memory that that was the case - basically if you can 
trust the command line as much as the config then it's definitely 
redundant to pass an option for this (see iommu_subsys_init() - it's now 
all plumbed through iommu_def_domain_type), and if you can't then 
passing them is futile anyway.

Cheers,
Robin.
