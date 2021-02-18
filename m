Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FEE431F20D
	for <lists+linux-integrity@lfdr.de>; Thu, 18 Feb 2021 23:07:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbhBRWFz (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 18 Feb 2021 17:05:55 -0500
Received: from linux.microsoft.com ([13.77.154.182]:40292 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbhBRWFz (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 18 Feb 2021 17:05:55 -0500
Received: from [192.168.86.31] (c-71-197-163-6.hsd1.wa.comcast.net [71.197.163.6])
        by linux.microsoft.com (Postfix) with ESMTPSA id 761D720B6C40;
        Thu, 18 Feb 2021 14:05:13 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 761D720B6C40
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1613685913;
        bh=iEhDQLoIk23OnuNoJgQfmHzfz5ExgtOc2F57YuZszSQ=;
        h=Subject:From:To:Cc:References:Date:In-Reply-To:From;
        b=B84+FYV5f+2zn0nr54Gppsw7P7e62d5QiDTR80sHToH6PpHpOKiCwZB8lQni/Y2Oa
         XzLUOBaXQ/EX98118Hd/LhyWgJlExu6Uh/ZgLJ+WwUcpRIBqFH5ZenjYJfR/4CkJsL
         kYFoeROt+mNr9WcAOEoRps7ucr6SlWa61ML9YGX4=
Subject: Re: [PATCH v2] IMA: support for duplicate data measurement
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     tyhicks@linux.microsoft.com, sashal@kernel.org, jmorris@namei.org,
        nramas@linux.microsoft.com, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210217024649.23405-1-tusharsu@linux.microsoft.com>
 <ab197aa9719b4218ab497b55f0bc78a0dadc83dd.camel@linux.ibm.com>
 <5236e03f-9be4-f7f3-ec6c-29f00c16dc18@linux.microsoft.com>
 <bb4356d779720b8fa9c342647132cfeec938c296.camel@linux.ibm.com>
 <21538a53-0174-e3b4-f1e8-ddb8cc334a79@linux.microsoft.com>
Message-ID: <6c2d2242-119c-2a8a-8062-6326fed6a45d@linux.microsoft.com>
Date:   Thu, 18 Feb 2021 14:05:12 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <21538a53-0174-e3b4-f1e8-ddb8cc334a79@linux.microsoft.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Mimi,

On 2021-02-17 12:49 p.m., Tushar Sugandhi wrote:
> 
> 
> On 2021-02-17 12:39 p.m., Mimi Zohar wrote:
>> On Wed, 2021-02-17 at 10:53 -0800, Tushar Sugandhi wrote:
>>> Thanks for the feedback Mimi.
>>> Appreciate it.
>>>
>>> On 2021-02-17 7:03 a.m., Mimi Zohar wrote:
>>>> Hi Tushar,
>>>>
>>>> The Subject line could be improved.  Perhaps something like - "IMA:
>>>> support for duplicate measurement records"
>>>>
>>> Will do.
>>>
>>>> On Tue, 2021-02-16 at 18:46 -0800, Tushar Sugandhi wrote:
>>>>> IMA does not measure duplicate data since TPM extend is a very 
>>>>> expensive
>>>>> operation.  However, in some cases, the measurement of duplicate data
>>>>> is necessary to accurately determine the current state of the system.
>>>>> Eg, SELinux state changing from 'audit', to 'enforcing', and back to
>>>>> 'audit' again.  In this example, currently, IMA will not measure the
>>>>> last state change to 'audit'.  This limits the ability of attestation
>>>>> services to accurately determine the current state of the measurements
>>>>> on the system.
>>>>
>>>> This patch description is written from your specific usecase
>>>> perspective, but it impacts file and buffer data measurements as well,
>>>> not only critical data measurements.  In all of these situations, with
>>>> this patch a new measurement record is added/appended to the
>>>> measurement list.  Please re-write the patch description making it more
>>>> generic.
>>>>
>>>> For example, I would start with something like, "IMA does not include
>>>> duplicate file, buffer or critical data measurement records ..."
>>>>
>>> Agreed.
>>> I will generalize the description further and send the v3 for review.
>>
>> It would be good to boot with the ima_policy=tcb policy with/without
>> your patch and account for the different number of measurements.   Are
>> all the differences related to duplicate measurements - original file
>> hash -> new file hash -> original file hash - similar to what you
>> described.
>>
> Thanks for the ima_policy=tcb pointer.
> 
> I tested my patch with:
>   - duplicate buffer content for "measure func=CRITICAL_DATA"
>   - and reading the same file twice with "measure func=FILE_CHECK 
> mask=MAY_READ"
> 
> In both the above use cases, IMA is measuring the duplicate entries with 
> the patch, and not measuring the duplicate entries w/o the patch.
> 
> I will test the "ima_policy=tcb" boot-scenario as you suggested, before 
> posting the next version.
> 

I booted the system with "ima_policy=tcb" policy with/without my patch.
I also removed /etc/ima/ima-policy for testing these use-cases.
(so that it wouldn't override the policy generated by boot param 
"ima_policy=tcb").

I double checked the contents of the kernel policy:
#cat /sys/kernel/security/integrity/ima/policy
     dont_measure fsmagic=0x9fa0
     dont_measure fsmagic=0x62656572
     dont_measure fsmagic=0x64626720
     dont_measure fsmagic=0x1021994
     dont_measure fsmagic=0x1cd1
     dont_measure fsmagic=0x42494e4d
     dont_measure fsmagic=0x73636673
     dont_measure fsmagic=0xf97cff8c
     dont_measure fsmagic=0x43415d53
     dont_measure fsmagic=0x27e0eb
     dont_measure fsmagic=0x63677270
     dont_measure fsmagic=0x6e736673
     dont_measure fsmagic=0xde5e81e4
     measure func=MMAP_CHECK mask=MAY_EXEC
     measure func=BPRM_CHECK mask=MAY_EXEC
     measure func=FILE_CHECK mask=^MAY_READ euid=0
     measure func=FILE_CHECK mask=^MAY_READ uid=0
     measure func=MODULE_CHECK
     measure func=FIRMWARE_CHECK
     measure func=POLICY_CHECK

And then I compared the contents of the ascii_runtime_measurements with 
and without my patch.

And here are my findings:

(1) Files like systemd-udevd, x2go_sessions etc. get measured multiple
     times with the CONFIG_IMA_DISABLE_HTABLE=y.
     They only get measured once with the config "=n".

     10 668df8723f5a1f57a0afe3b50d44054d66363f3e ima-ng 
sha1:51f66e82421b93b21ad1e0a25e5efa4155c6a8e0 /lib/systemd/systemd-udevd
     10 668df8723f5a1f57a0afe3b50d44054d66363f3e ima-ng 
sha1:51f66e82421b93b21ad1e0a25e5efa4155c6a8e0 /lib/systemd/systemd-udevd

(2) There are lot more instances of /tmp/<random> measurement records
     with the CONFIG_IMA_DISABLE_HTABLE=y.
     Eg,

     10 33515851cfee4acbf24de9482ff018d33def1083 ima-ng 
sha1:da39a3ee5e6b4b0d3255bfef95601890afd80709 /tmp/oUWCVeypLR
     10 9d1dc0e1e54ee2e16308a824fc5780bd21b38208 ima-ng 
sha1:da39a3ee5e6b4b0d3255bfef95601890afd80709 /tmp/etX8dy7qqy
     10 8643a5543179b86c02d7e3e01e16b3bd2f8dbb9f ima-ng 
sha1:da39a3ee5e6b4b0d3255bfef95601890afd80709 /tmp/I4zTWEuyMf
     10 56e9547a4ed39036d2e790cfad78b467aa979e32 ima-ng 
sha1:da39a3ee5e6b4b0d3255bfef95601890afd80709 /tmp/Lh5wDm6_Ep

I believe both the observations are consistent with the expected outcome 
of the patch.

Please let me know if I should test any other scenario.

I will shortly post the v3 patch with updates to description and title 
as you suggested.

Thanks,
Tushar

> Thanks,
> Tushar
> 
>> thanks,
>>
>> Mimi
>>
