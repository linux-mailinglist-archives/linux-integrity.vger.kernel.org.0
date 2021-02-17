Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D12EB31E0CA
	for <lists+linux-integrity@lfdr.de>; Wed, 17 Feb 2021 21:50:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231896AbhBQUu2 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 17 Feb 2021 15:50:28 -0500
Received: from linux.microsoft.com ([13.77.154.182]:53350 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233054AbhBQUuT (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 17 Feb 2021 15:50:19 -0500
Received: from [192.168.86.31] (c-71-197-163-6.hsd1.wa.comcast.net [71.197.163.6])
        by linux.microsoft.com (Postfix) with ESMTPSA id 515C420B6C40;
        Wed, 17 Feb 2021 12:49:38 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 515C420B6C40
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1613594978;
        bh=JEJw7ZIDLehoonEVX+o45He96Q8k0AiUNARafRXyaNI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ImG941yP1svNOK4H4U+H94SxDijuOiaDy42hXfsCftkwhzjczzQ7x9qO9kohmvkBK
         nVdp+3xZdR3v5zY1dlTmdZJhUMxt8kEirskY5bwRhiaLN8hRS3MIHcENX/Az2y6XRX
         1mTGvuiL4p9coLmFc3wok7GyYGPrskGVrNAsi7KU=
Subject: Re: [PATCH v2] IMA: support for duplicate data measurement
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     tyhicks@linux.microsoft.com, sashal@kernel.org, jmorris@namei.org,
        nramas@linux.microsoft.com, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210217024649.23405-1-tusharsu@linux.microsoft.com>
 <ab197aa9719b4218ab497b55f0bc78a0dadc83dd.camel@linux.ibm.com>
 <5236e03f-9be4-f7f3-ec6c-29f00c16dc18@linux.microsoft.com>
 <bb4356d779720b8fa9c342647132cfeec938c296.camel@linux.ibm.com>
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
Message-ID: <21538a53-0174-e3b4-f1e8-ddb8cc334a79@linux.microsoft.com>
Date:   Wed, 17 Feb 2021 12:49:37 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <bb4356d779720b8fa9c342647132cfeec938c296.camel@linux.ibm.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 2021-02-17 12:39 p.m., Mimi Zohar wrote:
> On Wed, 2021-02-17 at 10:53 -0800, Tushar Sugandhi wrote:
>> Thanks for the feedback Mimi.
>> Appreciate it.
>>
>> On 2021-02-17 7:03 a.m., Mimi Zohar wrote:
>>> Hi Tushar,
>>>
>>> The Subject line could be improved.  Perhaps something like - "IMA:
>>> support for duplicate measurement records"
>>>
>> Will do.
>>
>>> On Tue, 2021-02-16 at 18:46 -0800, Tushar Sugandhi wrote:
>>>> IMA does not measure duplicate data since TPM extend is a very expensive
>>>> operation.  However, in some cases, the measurement of duplicate data
>>>> is necessary to accurately determine the current state of the system.
>>>> Eg, SELinux state changing from 'audit', to 'enforcing', and back to
>>>> 'audit' again.  In this example, currently, IMA will not measure the
>>>> last state change to 'audit'.  This limits the ability of attestation
>>>> services to accurately determine the current state of the measurements
>>>> on the system.
>>>
>>> This patch description is written from your specific usecase
>>> perspective, but it impacts file and buffer data measurements as well,
>>> not only critical data measurements.  In all of these situations, with
>>> this patch a new measurement record is added/appended to the
>>> measurement list.  Please re-write the patch description making it more
>>> generic.
>>>
>>> For example, I would start with something like, "IMA does not include
>>> duplicate file, buffer or critical data measurement records ..."
>>>
>> Agreed.
>> I will generalize the description further and send the v3 for review.
> 
> It would be good to boot with the ima_policy=tcb policy with/without
> your patch and account for the different number of measurements.   Are
> all the differences related to duplicate measurements - original file
> hash -> new file hash -> original file hash - similar to what you
> described.
> 
Thanks for the ima_policy=tcb pointer.

I tested my patch with:
  - duplicate buffer content for "measure func=CRITICAL_DATA"
  - and reading the same file twice with "measure func=FILE_CHECK 
mask=MAY_READ"

In both the above use cases, IMA is measuring the duplicate entries with 
the patch, and not measuring the duplicate entries w/o the patch.

I will test the "ima_policy=tcb" boot-scenario as you suggested, before 
posting the next version.

Thanks,
Tushar

> thanks,
> 
> Mimi
> 
