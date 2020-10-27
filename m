Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB80929C217
	for <lists+linux-integrity@lfdr.de>; Tue, 27 Oct 2020 18:32:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1762182AbgJ0Rbb (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 27 Oct 2020 13:31:31 -0400
Received: from linux.microsoft.com ([13.77.154.182]:48920 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1819552AbgJ0Raa (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 27 Oct 2020 13:30:30 -0400
Received: from [192.168.86.21] (c-71-197-163-6.hsd1.wa.comcast.net [71.197.163.6])
        by linux.microsoft.com (Postfix) with ESMTPSA id EF0D620B4905;
        Tue, 27 Oct 2020 10:30:28 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com EF0D620B4905
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1603819829;
        bh=kaVk3QXkAqH4EzFU6UPEbSCWTIeXicsOu6YZLtOukDY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=UdECIVnjzFOphs0SutlHP0BOxuHYrjur3X5CnjWGPC3oxMamfcFIwkj1ZQweyrywQ
         jXvBHD1UMnzCvinMoI7WeFxJQJpXqQGUeSPgH9ZBUnvOnJ6GpvCuiuSaY/Hrgpazs1
         xzcZy2vebL4N+Ix7IaJU1+VRguBJICESG1e1sAWg=
Subject: Re: [PATCH v4 0/6] IMA: Infrastructure for measurement of critical
 kernel data
To:     Mimi Zohar <zohar@linux.ibm.com>, stephen.smalley.work@gmail.com,
        casey@schaufler-ca.com, agk@redhat.com, snitzer@redhat.com,
        gmazyland@gmail.com
Cc:     tyhicks@linux.microsoft.com, sashal@kernel.org, jmorris@namei.org,
        nramas@linux.microsoft.com, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com
References: <20200923192011.5293-1-tusharsu@linux.microsoft.com>
 <2c7da61fbeb17c577253b117829b3bd544d8cf44.camel@linux.ibm.com>
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
Message-ID: <d3bfb2ec-357a-411d-956c-0e305245f6ec@linux.microsoft.com>
Date:   Tue, 27 Oct 2020 10:30:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <2c7da61fbeb17c577253b117829b3bd544d8cf44.camel@linux.ibm.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Mimi,
Thanks a lot for your continual engagement and
providing us valuable feedback on this work.

On 2020-10-24 8:35 p.m., Mimi Zohar wrote:
> Hi Tushar,
> 
> On Wed, 2020-09-23 at 12:20 -0700, Tushar Sugandhi wrote:
>> There are several kernel components that contain critical data which if
>> accidentally or maliciously altered, can compromise the security of the
>> kernel. Example of such components would include LSMs like SELinux, or
>> AppArmor; or device-mapper targets like dm-crypt, dm-verity etc.
> 
> ^"the integrity of the system."
> 
Ok. I will revisit this cover letter again, when we post the next
version of the series. We also need to update the cover letter to
include the description for new patches to be added in this series, as
per your suggestion below. {built-in policy patch (by Lakshmi) and an
example measurement patch (SeLinux by Lakshmi)}

> This cover letter needs to be re-written from a higher perspective,
> explaining what is meant by "critical data" (e.g. kernel subsystem
> specific information only stored in kernel memory).
> 
>>
>> Many of these components do not use the capabilities provided by kernel
>> integrity subsystem (IMA), and thus they don't use the benefits of
>> extended TPM PCR quotes and ultimately the benefits of remote attestation.
> 
> True, up until recently IMA only measured files, nothing else.  Why is
> this paragraph needed?  What new information is provided?
> 
Here, I was attempting to describe the problem (what needs to be
solved), before proposing a solution below. But maybe it is not adding
value. I will get rid of the above paragraph in the next iteration.

>> This series bridges this gap, so that potential kernel components that
>> contain data critical to the security of the kernel could take advantage
>> of IMA's measuring and quoting abilities - thus ultimately enabling
>> remote attestation for their specific data.
> 
> Perhaps, something more along the lines, "This patch set defines a new
> IMA hook named ... to measure critical data."
> 
Will do.
>>
>> System administrators may want to pick and choose which kernel
>> components they would want to enable for measurements, quoting, and
>> remote attestation. To enable that, a new IMA policy is introduced.
> 
> Reverse the order of this paragraph and the following one, describing
> the new feature and only afterwards explaining how it may be
> constrained.
> 
Makes total sense. Will do.
>>
>> And lastly, the functionality is exposed through a function
>> ima_measure_critical_data(). The functionality is generic enough to
>> measure the data of any kernel component at run-time. To ensure that
>> only data from supported sources are measured, the kernel component
>> needs to be added to a compile-time list of supported sources (an
>> "allowed list of components"). IMA validates the source passed to
>> ima_measure_critical_data() against this allowed list at run-time.
> 
> This patch set must include at least one example of measuring critical
> data, before it can be upstreamed.  Tushar, please coordinate with
> Lakshmi and Raphael.
> 
Yes. I am coordinating with Lakshmi/Raphael on including one of the
examples. (SeLinux as per your feedback)

BTW, we also have one more data source (dm-crypt) currently in review,
that uses critical data measurement infrastructure to measure its kernel
in-memory data.
https://patchwork.kernel.org/patch/11844817/

Thanks again for all the help and support with the patches.

~Tushar

> thanks,
> 
> Mimi
> 
