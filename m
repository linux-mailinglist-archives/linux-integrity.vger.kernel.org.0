Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 783E92F8242
	for <lists+linux-integrity@lfdr.de>; Fri, 15 Jan 2021 18:28:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728310AbhAOR1k (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 15 Jan 2021 12:27:40 -0500
Received: from linux.microsoft.com ([13.77.154.182]:55854 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725818AbhAOR1k (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 15 Jan 2021 12:27:40 -0500
Received: from [192.168.86.31] (c-71-197-163-6.hsd1.wa.comcast.net [71.197.163.6])
        by linux.microsoft.com (Postfix) with ESMTPSA id C7DDE20B7192;
        Fri, 15 Jan 2021 09:26:58 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C7DDE20B7192
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1610731619;
        bh=+VJnsF4kFMO6bAfGl4TRzpeiil80GFM1LYOrc/fFgg4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=GcDkztX85xILiONq+dpyAyykK0sFFW73ywn6s2xpmwl+hgv6cCI5ts1pRJpXdOIUf
         WJ8NdCyON6431Nmj0nJTdrsP53FIjNu/ynst/WTe54A0goPkQX95QdQJZKN3f1ulUi
         djxo3L4EWQJu9LE92YwHmOGZg1RKdfNDumLiUWvc=
Subject: Re: [PATCH v10 0/8] IMA: support for measuring kernel integrity
 critical data
To:     Mimi Zohar <zohar@linux.ibm.com>, stephen.smalley.work@gmail.com,
        casey@schaufler-ca.com, agk@redhat.com, snitzer@redhat.com,
        gmazyland@gmail.com, paul@paul-moore.com
Cc:     tyhicks@linux.microsoft.com, sashal@kernel.org, jmorris@namei.org,
        nramas@linux.microsoft.com, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com
References: <20210108040708.8389-1-tusharsu@linux.microsoft.com>
 <5189c15054885863b1b5cb86a43bec09725d8650.camel@linux.ibm.com>
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
Message-ID: <e3deb1a0-a624-f85f-e2d2-3206fa609b64@linux.microsoft.com>
Date:   Fri, 15 Jan 2021 09:26:58 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <5189c15054885863b1b5cb86a43bec09725d8650.camel@linux.ibm.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 2021-01-15 4:54 a.m., Mimi Zohar wrote:
> On Thu, 2021-01-07 at 20:07 -0800, Tushar Sugandhi wrote:
>> IMA measures files and buffer data such as keys, command-line arguments
>> passed to the kernel on kexec system call, etc.  While these measurements
>> are necessary for monitoring and validating the integrity of the system,
>> they are not sufficient.  Various data structures, policies, and states
>> stored in kernel memory also impact the integrity of the system.
>> Several kernel subsystems contain such integrity critical data -
>> e.g.  LSMs like SELinux, AppArmor etc.  or device-mapper targets like
>> dm-crypt, dm-verity, dm-integrity etc.  These kernel subsystems help
>> protect the integrity of a system.  Their integrity critical data is not
>> expected to change frequently during run-time.  Some of these structures
>> cannot be defined as __ro_after_init, because they are initialized later.
>>
>> For a given system, various external services/infrastructure tools
>> (including the attestation service) interact with it - both during the
>> setup and during rest of the system run-time.  They share sensitive data
>> and/or execute critical workload on that system.  The external services
>> may want to verify the current run-time state of the relevant kernel
>> subsystems before fully trusting the system with business critical
>> data/workload.  For instance, verifying that SELinux is in "enforce" mode
>> along with the expected policy, disks are encrypted with a certain
>> configuration, secure boot is enabled etc.
>>
>> This series provides the necessary IMA functionality for kernel
>> subsystems to ensure their configuration can be measured:
>>    - by kernel subsystems themselves,
>>    - in a tamper resistant way,
>>    - and re-measured - triggered on state/configuration change.
>>
>> This patch set:
>>    - defines a new IMA hook ima_measure_critical_data() to measure
>>      integrity critical data,
>>    - limits the critical data being measured based on a label,
>>    - defines a builtin critical data measurement policy,
>>    - and includes an SELinux consumer of the new IMA critical data hook.
> 
> Thanks Tushar, Lakshmi.  This patch set is queued in the next-
> integrity-testing branch.
> 
> Mimi
> 
Hello Mimi, Paul, Stephen, Tyler,
Thanks a lot for reviewing this series and providing all the valuable 
feedback over the last few months.

We really really appreciate it.

Thanks,
Tushar
