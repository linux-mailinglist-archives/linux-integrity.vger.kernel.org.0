Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C0792F6BB8
	for <lists+linux-integrity@lfdr.de>; Thu, 14 Jan 2021 21:05:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730256AbhANUCI (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 14 Jan 2021 15:02:08 -0500
Received: from linux.microsoft.com ([13.77.154.182]:60802 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729249AbhANUCI (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 14 Jan 2021 15:02:08 -0500
Received: from [192.168.0.104] (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 5DECF20B6C40;
        Thu, 14 Jan 2021 12:01:27 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5DECF20B6C40
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1610654487;
        bh=Kv9kA9hyCrmK+ukDmZ0hqeRpgOqREfsVmhG/uF3QqmQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=qfD6W4Blr3Xs9NTKINaaLofPVakW4k7UKe2ummHWz0zZjqFhiOFZyEOvB3gsO7F5x
         qG2qJoiG8nDARMycZDhUHBe2HYAr4diUOU5hJQVQoswqR1a2+aJdq+BLEmL7JkVfe2
         +nfpkes7s5Wbm5q3m290ttDgem/iPkbAZBrz2mec=
Subject: Re: [PATCH] selinux: include a consumer of the new IMA critical data
 hook
To:     Tyler Hicks <tyhicks@linux.microsoft.com>,
        Paul Moore <paul@paul-moore.com>
Cc:     zohar@linux.ibm.com,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        tusharsu@linux.microsoft.com, casey@schaufler-ca.com,
        agk@redhat.com, snitzer@redhat.com, gmazyland@gmail.com,
        sashal@kernel.org, James Morris <jmorris@namei.org>,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210114191522.4001-1-nramas@linux.microsoft.com>
 <CAHC9VhQ5PEvZggtijta3EbWY5HEmfs6phmBWdQXk451yBRXQpA@mail.gmail.com>
 <20210114195813.GA81268@sequoia>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <276c70ac-0d12-88f8-2d75-c88e68ef8490@linux.microsoft.com>
Date:   Thu, 14 Jan 2021 12:01:26 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210114195813.GA81268@sequoia>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 1/14/21 11:58 AM, Tyler Hicks wrote:
> On 2021-01-14 14:29:09, Paul Moore wrote:
>> On Thu, Jan 14, 2021 at 2:15 PM Lakshmi Ramasubramanian
>> <nramas@linux.microsoft.com> wrote:
>>>
>>> SELinux stores the active policy in memory, so the changes to this data
>>> at runtime would have an impact on the security guarantees provided
>>> by SELinux.  Measuring in-memory SELinux policy through IMA subsystem
>>> provides a secure way for the attestation service to remotely validate
>>> the policy contents at runtime.
>>>
>>> Measure the hash of the loaded policy by calling the IMA hook
>>> ima_measure_critical_data().  Since the size of the loaded policy
>>> can be large (several MB), measure the hash of the policy instead of
>>> the entire policy to avoid bloating the IMA log entry.
>>>
>>> To enable SELinux data measurement, the following steps are required:
>>>
>>> 1, Add "ima_policy=critical_data" to the kernel command line arguments
>>>     to enable measuring SELinux data at boot time.
>>> For example,
>>>    BOOT_IMAGE=/boot/vmlinuz-5.10.0-rc1+ root=UUID=fd643309-a5d2-4ed3-b10d-3c579a5fab2f ro nomodeset security=selinux ima_policy=critical_data
>>>
>>> 2, Add the following rule to /etc/ima/ima-policy
>>>     measure func=CRITICAL_DATA label=selinux
>>>
>>> Sample measurement of the hash of SELinux policy:
>>>
>>> To verify the measured data with the current SELinux policy run
>>> the following commands and verify the output hash values match.
>>>
>>>    sha256sum /sys/fs/selinux/policy | cut -d' ' -f 1
>>>
>>>    grep "selinux-policy-hash" /sys/kernel/security/integrity/ima/ascii_runtime_measurements | tail -1 | cut -d' ' -f 6
>>>
>>> Note that the actual verification of SELinux policy would require loading
>>> the expected policy into an identical kernel on a pristine/known-safe
>>> system and run the sha256sum /sys/kernel/selinux/policy there to get
>>> the expected hash.
>>>
>>> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
>>> Suggested-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>>> Acked-by: Paul Moore <paul@paul-moore.com>
>>> Reviewed-by: Tyler Hicks <tyhicks@linux.microsoft.com>
>>> ---
>>>   Documentation/ABI/testing/ima_policy |  3 +-
>>>   security/selinux/Makefile            |  2 +
>>>   security/selinux/ima.c               | 44 +++++++++++++++++++
>>>   security/selinux/include/ima.h       | 24 +++++++++++
>>>   security/selinux/include/security.h  |  3 +-
>>>   security/selinux/ss/services.c       | 64 ++++++++++++++++++++++++----
>>>   6 files changed, 129 insertions(+), 11 deletions(-)
>>>   create mode 100644 security/selinux/ima.c
>>>   create mode 100644 security/selinux/include/ima.h
>>
>> I think this has changed enough that keeping the "Acked-by" and
>> "Reviewed-by" tags is probably not a good choice.  I took a quick look
>> and this still looks okay from a SELinux perspective, I'll leave Mimi
>> to comment on it from a IMA perspective.

Thanks for reviewing the change Paul.

>>
>> Unless Tyler has reviewed this version prior to your posting, it might
>> be a good idea to remove his "Reviewed-by" unless he has a chance to
>> look this over again before it is merged.
> 
> Thanks for calling this out. I hadn't reviewed it prior to the posting
> but I was keeping an eye on the thread.
> 
> This new revision still looks good to me and I like the idea of
> controlling re-measurements via policy. So,
> 
>   Reviewed-by: Tyler Hicks <tyhicks@linux.microsoft.com>

Thanks for the quick response Tyler.

  -lakshmi

