Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A664D23D21F
	for <lists+linux-integrity@lfdr.de>; Wed,  5 Aug 2020 22:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729714AbgHEUJO (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 5 Aug 2020 16:09:14 -0400
Received: from linux.microsoft.com ([13.77.154.182]:44774 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726344AbgHEQce (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 5 Aug 2020 12:32:34 -0400
Received: from [192.168.0.104] (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 33C1D20B4916;
        Wed,  5 Aug 2020 09:21:25 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 33C1D20B4916
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1596644485;
        bh=GzAsE7yIveqCecXCvd87U4xE2Iv3TtxhwzS/oH7sMZQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=tAdrgRN+aiLODwPD2Pu1t/IPAMRAiJp2U3MWvDjOQx4AmOIgoovl6hWOOeVMDJtJt
         srJScwliKGlB05ubxJW3Wzi7YO2eKzS+pomSQSUqJxynjqI9F3S5cW+JA1RfOPWOoS
         r5NxUGUp0TBH7UejIn8B1uTkrKsu2u62Nak4Higk=
Subject: Re: [PATCH v6 0/4] LSM: Measure security module data
To:     Tyler Hicks <tyhicks@linux.microsoft.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>, zohar@linux.ibm.com,
        stephen.smalley.work@gmail.com, sashal@kernel.org,
        jmorris@namei.org, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200805004331.20652-1-nramas@linux.microsoft.com>
 <f3971f35-309d-c3e5-9126-69add7ad4c11@schaufler-ca.com>
 <50587a3e-bcb5-c68e-c16c-41baf68b4d4a@linux.microsoft.com>
 <c7c168f2-e30b-d2c5-abcb-1b6919197474@schaufler-ca.com>
 <20200805154504.GB4365@sequoia>
 <7c7a076b-6ba7-2e8d-409a-b3b4e4738c41@linux.microsoft.com>
 <20200805161449.GC4365@sequoia>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <ae80581d-a34c-51f4-d4f9-94c1e341fd15@linux.microsoft.com>
Date:   Wed, 5 Aug 2020 09:21:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200805161449.GC4365@sequoia>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 8/5/20 9:14 AM, Tyler Hicks wrote:
> On 2020-08-05 09:07:48, Lakshmi Ramasubramanian wrote:
>> On 8/5/20 8:45 AM, Tyler Hicks wrote:
>>> On 2020-08-05 08:36:40, Casey Schaufler wrote:
>>>> On 8/4/2020 6:14 PM, Lakshmi Ramasubramanian wrote:
>>>>> On 8/4/20 6:04 PM, Casey Schaufler wrote:
>>>>>> On 8/4/2020 5:43 PM, Lakshmi Ramasubramanian wrote:
>>>>>>> Critical data structures of security modules are currently not measured.
>>>>>>> Therefore an attestation service, for instance, would not be able to
>>>>>>> attest whether the security modules are always operating with the policies
>>>>>>> and configuration that the system administrator had setup. The policies
>>>>>>> and configuration for the security modules could be tampered with by
>>>>>>> malware by exploiting kernel vulnerabilities or modified through some
>>>>>>> inadvertent actions on the system. Measuring such critical data would
>>>>>>> enable an attestation service to better assess the state of the system.
>>>>>>
>>>>>> I still wonder why you're calling this an LSM change/feature when
>>>>>> all the change is in IMA and SELinux. You're not putting anything
>>>>>> into the LSM infrastructure, not are you using the LSM infrastructure
>>>>>> to achieve your ends. Sure, you *could* support other security modules
>>>>>> using this scheme, but you have a configuration dependency on
>>>>>> SELinux, so that's at best going to be messy. If you want this to
>>>>>> be an LSM "feature" you need to use the LSM hooking mechanism.
>>>>>
>>>>>>
>>>>>> I'm not objecting to the feature. It adds value. But as you've
>>>>>> implemented it it is either an IMA extension to SELinux, or an
>>>>>> SELiux extension to IMA. Could AppArmor add hooks for this without
>>>>>> changing the IMA code? It doesn't look like it to me.
>>>>>
>>>>> The check in IMA to allow the new IMA hook func LSM_STATE and LSM_POLICY when SELinux is enabled is just because SELinux is the only security module using these hooks now.
>>>>>
>>>>> To enable AppArmor, for instance, to use the new IMA hooks to measure state and policy would just require adding the check for CONFIG_SECURITY_APPARMOR. Other than that, there are no IMA changes needed to support AppArmor or other such security modules.
>>>>
>>>> This is exactly what I'm objecting to. What if a system has both SELinux
>>>> and AppArmor compiled in? What if it has both enabled?
>>>
>>> The SELinux state and policy would be measured but the AppArmor
>>> state/policy would be silently ignored. This isn't ideal as the IMA
>>> policy author would need to read the kernel code to figure out which
>>> LSMs are going to be measured.
>>
>> Tyler - I am not sure why AppArmor state\policy would be ignored when both
>> SELinux and AppArmor are enabled. Could you please clarify?
> 
> I think Casey is talking about now (when AppArmor is not supported by
> this feature) and you're talking about the future (when AppArmor may be
> supported by this feature).

Got it - thanks for clarifying.

But with the current code if SELinux is enabled on the system, but 
AppArmor is not and the IMA policy contains "measure func=LSM_STATE" 
then the policy will be rejected as "-EINVAL".
So the policy author would get a feedback even now.
Correct me if I am wrong.

  -lakshmi
