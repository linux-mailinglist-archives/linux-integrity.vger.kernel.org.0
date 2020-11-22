Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B5A02BC966
	for <lists+linux-integrity@lfdr.de>; Sun, 22 Nov 2020 21:54:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727460AbgKVUxj (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 22 Nov 2020 15:53:39 -0500
Received: from linux.microsoft.com ([13.77.154.182]:49316 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727418AbgKVUxi (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 22 Nov 2020 15:53:38 -0500
Received: from [192.168.86.31] (c-71-197-163-6.hsd1.wa.comcast.net [71.197.163.6])
        by linux.microsoft.com (Postfix) with ESMTPSA id B7AFB20B717A;
        Sun, 22 Nov 2020 12:53:36 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B7AFB20B717A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1606078417;
        bh=alE6Kb/zDgqzLgdvNjihsk5l+fJjrnYiq4iR3wkQH+k=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=gGXIdg7oo3NxBnYLTF6PEbRZvdcXdbnnlLlQ3YfDgE+wvrZM0lYR6WqM4X+tCmiPP
         EldLucw+lLJagJHWRX5TeaWcO7cM4RDF6UClTg5vO12b7cWO7BvlKuK9EQNMlEbryD
         Z/IiP2IE9CP5mW6v/DXF7UjLxi4UYMaRHDrEQGhs=
Subject: Re: [PATCH v6 0/8] IMA: support for measuring kernel integrity
 critical data
To:     Pavel Machek <pavel@ucw.cz>
Cc:     zohar@linux.ibm.com, stephen.smalley.work@gmail.com,
        casey@schaufler-ca.com, agk@redhat.com, snitzer@redhat.com,
        gmazyland@gmail.com, paul@paul-moore.com,
        tyhicks@linux.microsoft.com, sashal@kernel.org, jmorris@namei.org,
        nramas@linux.microsoft.com, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com
References: <20201119232611.30114-1-tusharsu@linux.microsoft.com>
 <20201120124657.GA31468@duo.ucw.cz>
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
Message-ID: <aadf6e35-39bc-74d4-6ca3-d708860738a5@linux.microsoft.com>
Date:   Sun, 22 Nov 2020 12:53:35 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201120124657.GA31468@duo.ucw.cz>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Thanks Pavel for looking at this series.

On 2020-11-20 4:46 a.m., Pavel Machek wrote:
> On Thu 2020-11-19 15:26:03, Tushar Sugandhi wrote:
>> Kernel integrity critical data can be defined as the in-memory kernel
>> data which if accidentally or maliciously altered, can compromise the
>> integrity of the system.
> 
> Is that an useful definition?
I will rework on the definition in the next iteration.
Meanwhile, if you have any feedback on what can we add to the
definition, that would help is.

> 
>> There are several kernel subsystems that contain integrity critical
>> data - e.g. LSMs like SELinux, or AppArmor; or device-mapper targets
>> like dm-crypt, dm-verity etc. Examples of critical data could be kernel
>> in-memory r/o structures, hash of the memory structures, or data that
>> represents a linux kernel subsystem state.
>>
>> This patch set defines a new IMA hook namely ima_measure_critical_data()
>> to measure the critical data. Kernel subsystems can use this
>> functionality, to take advantage of IMA's measuring and quoting
>> abilities - thus ultimately enabling remote attestation for the
>> subsystem specific information stored in the kernel memory.
> 
> How is it supposed to be useful?
> 
> I'm pretty sure there are critical data that are not measured by
> proposed module... and that are written under normal circumstances.
> 
The goal of this series is to introduce the IMA hook
measure_critical_data() and the necessary policies to use it; and
illustrate that use with one example (SELinux). It is not scalable to 
identify and update all the critical data sources to use the proposed
module at once.

A piecemeal approach to add more critical data measurement in subsequent
patches would be easy to implement and review.

Please let me know if you have more thoughts on this. (what critical
data you think would be useful to measure etc.)

~Tushar

> Best regards,
> 
> 									Pavel
> 
