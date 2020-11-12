Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97D9F2B1144
	for <lists+linux-integrity@lfdr.de>; Thu, 12 Nov 2020 23:18:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727126AbgKLWSz (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 12 Nov 2020 17:18:55 -0500
Received: from linux.microsoft.com ([13.77.154.182]:57538 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbgKLWSz (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 12 Nov 2020 17:18:55 -0500
Received: from [192.168.86.31] (c-71-197-163-6.hsd1.wa.comcast.net [71.197.163.6])
        by linux.microsoft.com (Postfix) with ESMTPSA id 1615F20C2877;
        Thu, 12 Nov 2020 14:18:54 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1615F20C2877
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1605219534;
        bh=SZTIymZVSn9mjeKBmOs0GNRoIi3WBcxYT3njv0tRSkk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=EGwF2qitEbcQ+0FA/71bvbJHEjaOYKn2aP7y2OHOWyJquncZSAJWJipM7aUqEDWW/
         jnGlTuNTXM6S2xLT03aSsqMMJSQX9L+R0yHAOqTtTaMVmsi9jF1X9LBwzCRJoCY1Gg
         IUCcOdLC2Kfz/thZ+851exWq/4Ga0GCCnGFfmwwg=
Subject: Re: [PATCH v5 0/7] IMA: Infrastructure for measurement of critical
 kernel data
To:     Mimi Zohar <zohar@linux.ibm.com>, stephen.smalley.work@gmail.com,
        casey@schaufler-ca.com, agk@redhat.com, snitzer@redhat.com,
        gmazyland@gmail.com, paul@paul-moore.com
Cc:     tyhicks@linux.microsoft.com, sashal@kernel.org, jmorris@namei.org,
        nramas@linux.microsoft.com, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com
References: <20201101222626.6111-1-tusharsu@linux.microsoft.com>
 <c840953db2937296c8d77d5d3b4e1274bf990e46.camel@linux.ibm.com>
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
Message-ID: <a554b2d0-c59a-4ed8-12b8-5a1735cae9a4@linux.microsoft.com>
Date:   Thu, 12 Nov 2020 14:18:53 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <c840953db2937296c8d77d5d3b4e1274bf990e46.camel@linux.ibm.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 2020-11-04 4:31 p.m., Mimi Zohar wrote:
> Hi Tushar,
> 
> Measuring "critical kernel data" is not a new infrastructure, simply a
> new IMA hook.   Please update the above Subject line to "support for
> measuring critical kernel data".
> 
Thanks a lot. Will update.
> On Sun, 2020-11-01 at 14:26 -0800, Tushar Sugandhi wrote:
>> There are several kernel subsystems that contain critical data which if
>> accidentally or maliciously altered, can compromise the integrity of the
>> system. Examples of such subsystems would include LSMs like SELinux, or
>> AppArmor; or device-mapper targets like dm-crypt, dm-verity etc.
>> "critical data" in this context is kernel subsystem specific information
>> that is stored in kernel memory. Examples of critical data could be
>> kernel in-memory r/o structures, hash of the memory structures, or
>> data that represents a linux kernel subsystem state.
> 
> This is a bit better, but needs to be much clearer.  Please define
> "critical data", not by example, but by describing "what" critical
> kernel data is.  "There are several kernel subsystems ...."  is an
> example of "how" it would be used, not a definition.  Without a clear
> definition it will become a dumping ground for measuring anything
> anyone wants to measure.  As a result, it may be abused.
> 
Good point. I will come up with a better definition.
>>
>> This patch set defines a new IMA hook namely CRITICAL_DATA, and a
>> function ima_measure_critical_data() - to measure the critical data.
> 
> The name of the IMA hook is ima_measure_critical_data.  This is similar
> to the LSM hooks, which are prefixed with "security_".  (For a full
> list of LSM hooks, refer to lsm_hook_defs.h.)
> 
Thanks for the clarification. I will update this description.
>> Kernel subsystems can use this functionality, to take advantage of IMA's
>> measuring and quoting abilities - thus ultimately enabling remote
>> attestation for the subsystem specific information stored in the kernel
>> memory.
>>
>> The functionality is generic enough to measure the data of any kernel
>> subsystem at run-time. To ensure that only data from supported sources
>> are measured, the kernel subsystem needs to be added to a compile-time
>> list of supported sources (an "allowed list of components"). IMA
>> validates the source passed to ima_measure_critical_data() against this
>> allowed list at run-time.
> 
> Yes, this new feature is generic, but one of the main goals of IMA is
> to measure and attest to the integrity of the system, not to measure
> and attest to random things.
> 
Ok. I will update the above paragraph accordingly.
>>
>> System administrators may want to pick and choose which kernel
>> subsystem information they would want to enable for measurements,
>> quoting, and remote attestation. To enable that, a new IMA policy is
>> introduced.
> 
> ^may want to limit the critical data being measured, quoted and
> attested.
> ^ a new IMA policy condition is defined.
> 
Sounds good. Will update.
>>
>> This patch set also addresses the need for the kernel subsystems to
>> measure their data before a custom IMA policy is loaded - by providing
>> a builtin IMA policy.
> 
> ^for measuring kernel critical data early, before a custom IMA policy
> ...
> 
Sounds good. Will update.
>>
>> And lastly, the use of the overall functionality is demonstrated by
>> measuring the kernel in-memory data for one such subsystem - SeLinux.
> 
> The purpose isn't to demonstrate the "overall functionality", but to
> provide an initial caller of the new IMA hook.
> 
Fair point. Will change the description accordingly.
~Tushar

> thanks,
> 
> Mimi
> 
