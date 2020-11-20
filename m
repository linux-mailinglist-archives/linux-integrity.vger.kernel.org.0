Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B9972BBA40
	for <lists+linux-integrity@lfdr.de>; Sat, 21 Nov 2020 00:41:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728295AbgKTXkN (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 20 Nov 2020 18:40:13 -0500
Received: from linux.microsoft.com ([13.77.154.182]:45274 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726172AbgKTXkN (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 20 Nov 2020 18:40:13 -0500
Received: from [192.168.0.104] (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 5F08E20B717A;
        Fri, 20 Nov 2020 15:40:12 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5F08E20B717A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1605915612;
        bh=pm8lF2tlf3tvdq+Us/teGujaOR41+GOwf/8B1ECpHsg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=da9adWidx/Zz4+47O33LIzwsWL9VwM9KC98pw2gZ2ojU8IL67HUEK1c4E+CCzc0X7
         NWIGEeFW8mwF+gDChkpQbRt7SLi/uhfaPIelOidwbNiixPz1yw35i+CXAwswMnSMtH
         RG+PiWZ5vm/AkFgdmseXOj5SBQEZOfAOWj3C24tU=
Subject: Re: [PATCH v6 8/8] selinux: measure state and hash of the policy
 using IMA
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        stephen.smalley.work@gmail.com, casey@schaufler-ca.com,
        agk@redhat.com, snitzer@redhat.com, gmazyland@gmail.com,
        paul@paul-moore.com
Cc:     tyhicks@linux.microsoft.com, sashal@kernel.org, jmorris@namei.org,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com
References: <20201119232611.30114-1-tusharsu@linux.microsoft.com>
 <20201119232611.30114-9-tusharsu@linux.microsoft.com>
 <4634c6c12b2452849f73ed2d5a4d168707e0ac9a.camel@linux.ibm.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <0fb07bd3-c877-ab0f-cd45-dcfbe1fec044@linux.microsoft.com>
Date:   Fri, 20 Nov 2020 15:40:11 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <4634c6c12b2452849f73ed2d5a4d168707e0ac9a.camel@linux.ibm.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 11/20/20 7:49 AM, Mimi Zohar wrote:
Hi Mimi,

> 
> On Thu, 2020-11-19 at 15:26 -0800, Tushar Sugandhi wrote:
>> From: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
>>
>> IMA measures files and buffer data such as keys, command line arguments
>> passed to the kernel on kexec system call, etc. While these measurements
>> enable monitoring and validating the integrity of the system, it is not
>> sufficient.
> 
> The above paragraph would make a good cover letter introduction.

Agreed - will add this paragraph to the cover letter as well.

> 
>> In-memory data structures maintained by various kernel
>> components store the current state and policies configured for
>> the components.
> 
> Various data structures, policies and state stored in kernel memory
> also impact the  integrity of the system.

Will update.

> 
> The 2nd paragraph could provide examples of such integrity critical
> data.

Will do.

> 
> This patch set introduces a new IMA hook named
> ima_measure_critical_data() to measure kernel integrity critical data.
> 

*Question*
I am not clear about this one - do you mean add the following line in 
the patch description for the selinux patch?

"This patch introduces the first use of the new IMA hook namely 
ima_measures_critical_data() to measure the integrity critical data for 
SELinux"

thanks,
  -lakshmi
