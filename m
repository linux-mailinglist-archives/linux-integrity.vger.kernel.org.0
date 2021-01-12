Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 597632F38CE
	for <lists+linux-integrity@lfdr.de>; Tue, 12 Jan 2021 19:28:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406325AbhALSZx (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 12 Jan 2021 13:25:53 -0500
Received: from linux.microsoft.com ([13.77.154.182]:34916 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391199AbhALSZw (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 12 Jan 2021 13:25:52 -0500
Received: from [192.168.0.104] (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 7792220B6C40;
        Tue, 12 Jan 2021 10:25:11 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7792220B6C40
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1610475911;
        bh=qy3ti2dFqNqzP6FP7vg6YhFp5uWu+v5fID15lyNEIuw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=eKZLZ8Sgxg1EPb8LG5UCoPzpgpSvDYjqzZiuualeGjnsgxXxl3SherhBga/kP7ANP
         ej7DuYEWImAjRGsusPXz+nj/LZ3ydA9wQyUnhSNCZkPqhtfSDp58m6w5F6PYm1fSNe
         BbcDvx2wKTWMa/WiQNYpbpUwOJybcWnLkwIozeEg=
Subject: Re: [PATCH v10 8/8] selinux: include a consumer of the new IMA
 critical data hook
To:     Paul Moore <paul@paul-moore.com>,
        Tushar Sugandhi <tusharsu@linux.microsoft.com>
Cc:     zohar@linux.ibm.com,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        casey@schaufler-ca.com, agk@redhat.com, snitzer@redhat.com,
        gmazyland@gmail.com, tyhicks@linux.microsoft.com,
        sashal@kernel.org, James Morris <jmorris@namei.org>,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com
References: <20210108040708.8389-1-tusharsu@linux.microsoft.com>
 <20210108040708.8389-9-tusharsu@linux.microsoft.com>
 <CAHC9VhSJk0wG=WzO3bwsueiy19mMi9m6MamTrQfH8C=gXUtvGw@mail.gmail.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <1b076701-3af8-6997-82ae-7196c263a7f4@linux.microsoft.com>
Date:   Tue, 12 Jan 2021 10:25:11 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAHC9VhSJk0wG=WzO3bwsueiy19mMi9m6MamTrQfH8C=gXUtvGw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 1/12/21 8:27 AM, Paul Moore wrote:
> On Thu, Jan 7, 2021 at 11:07 PM Tushar Sugandhi
> <tusharsu@linux.microsoft.com> wrote:
>> From: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
>>
>> SELinux stores the active policy in memory, so the changes to this data
>> at runtime would have an impact on the security guarantees provided
>> by SELinux.  Measuring in-memory SELinux policy through IMA subsystem
>> provides a secure way for the attestation service to remotely validate
>> the policy contents at runtime.
>>
>> Measure the hash of the loaded policy by calling the IMA hook
>> ima_measure_critical_data().  Since the size of the loaded policy
>> can be large (several MB), measure the hash of the policy instead of
>> the entire policy to avoid bloating the IMA log entry.
>>
>> To enable SELinux data measurement, the following steps are required:
>>
>> 1, Add "ima_policy=critical_data" to the kernel command line arguments
>>     to enable measuring SELinux data at boot time.
>> For example,
>>    BOOT_IMAGE=/boot/vmlinuz-5.10.0-rc1+ root=UUID=fd643309-a5d2-4ed3-b10d-3c579a5fab2f ro nomodeset security=selinux ima_policy=critical_data
>>
>> 2, Add the following rule to /etc/ima/ima-policy
>>     measure func=CRITICAL_DATA label=selinux
>>
>> Sample measurement of the hash of SELinux policy:
>>
>> To verify the measured data with the current SELinux policy run
>> the following commands and verify the output hash values match.
>>
>>    sha256sum /sys/fs/selinux/policy | cut -d' ' -f 1
>>
>>    grep "selinux-policy-hash" /sys/kernel/security/integrity/ima/ascii_runtime_measurements | tail -1 | cut -d' ' -f 6
>>
>> Note that the actual verification of SELinux policy would require loading
>> the expected policy into an identical kernel on a pristine/known-safe
>> system and run the sha256sum /sys/kernel/selinux/policy there to get
>> the expected hash.
>>
>> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
>> Suggested-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>> Reviewed-by: Tyler Hicks <tyhicks@linux.microsoft.com>
>> ---
>>   Documentation/ABI/testing/ima_policy |  3 +-
>>   security/selinux/Makefile            |  2 +
>>   security/selinux/ima.c               | 64 ++++++++++++++++++++++++++++
>>   security/selinux/include/ima.h       | 24 +++++++++++
>>   security/selinux/include/security.h  |  3 +-
>>   security/selinux/ss/services.c       | 64 ++++++++++++++++++++++++----
>>   6 files changed, 149 insertions(+), 11 deletions(-)
>>   create mode 100644 security/selinux/ima.c
>>   create mode 100644 security/selinux/include/ima.h
> 
> I remain concerned about the possibility of bypassing a measurement by
> tampering with the time, but I appear to be the only one who is
> worried about this so I'm not going to block this patch on those
> grounds.
> 
> Acked-by: Paul Moore <paul@paul-moore.com>

Thanks Paul.

  -lakshmi

