Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C17423CFA9
	for <lists+linux-integrity@lfdr.de>; Wed,  5 Aug 2020 21:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728723AbgHETXe (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 5 Aug 2020 15:23:34 -0400
Received: from sonic307-15.consmr.mail.ne1.yahoo.com ([66.163.190.38]:46037
        "EHLO sonic307-15.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728657AbgHERbT (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 5 Aug 2020 13:31:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1596648677; bh=jvxkSkOTSPyya8QAh7XMh9VDbBmnEMvd/5JFSW3wW7w=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=fLJxyoQ0Ucj0oVNgJ1rM4UO6F5l8kggbJlA+sGdfoJcr4vlI5q/42iAV7UtHQrh/oY3kmaVKJA/0Crvpf/c4iNqTLQAtqERivlNmgMe47lKK/DB2x71lilw87KRNj8ykzhrTWNEyXL8ErlIbBKSNdwbtOT9q/ikyt5KueH4wtCWWflI25uPG2Hq6Pkpsw+B9QzOfBcO4cbnQfth3jjLnmllsVjZh5osHnY0uN3QXvVGanJcCIKEN7RH2OC6EImqH9dGyoBC39E6wJyRcrVLHCMWjhsE4iB+wd7NVqkVN+aHnKk+V1ayim5vGXNfpnInEAkaaoQ/pg1GGzLYDek+qSQ==
X-YMail-OSG: pQNn7cwVM1kuAR5tTKU.VeynlGP2Sr8sFVOjP1ZFSPgyutQRgtrndCh9OpSard8
 OF0AvjfBMu4g6fshBSlG89XEg7WOTdJfx17d0BCYONAVElTfKBnK53K2oWDgZOda0AUs__XvjBm4
 m6hpcf1JqSdeigNnKZ9E6Fcyfec7724ELUlAHAEx5s3cLwP0zw_KibM52X_3bHIHv.jbhJcNMd35
 CL.FeLbN.GIkbk.xt3y47QWEw9nSDBqfI6ga0AeJkZ1WMIqoQ6d6a1YCM83KTAFzhKZBEsinsYJu
 C_L62f8SDVJOFLrKXEow5u1WXLBXiy0YlHHdbOwd4XonjfLETA48fLfoUN2xPcTSomXsUCxNFKuN
 hzysY48s6jIoPsIUah79BoOlsKhEUQkIf1t4TJX3.1rtCIGXgzp4hQSTQCg5d353biTu1BJgbqrl
 aP5vbPM1qIB1oiwxSWrczivnCydbVQ0JanmEzwWTRIldQnqYx7AZY_GET94Vgu2LH20MpQ9emk9M
 kSQjZG8gBZjfdt6a1ysgStYIDCabS3G0N6xcp8EptAcxw3Qruf4OdITjZj2S2zaF_Tt.skfdBiEH
 lAHgm.huo_1ZXUxCE9z1t._79GXkQxOBd5zQiVaW0cqSShaB3LY4F8B6_vUTWwwdLONiXJ19J4Up
 Wm31TQhynLbs7JZ68uP0QtT_XnyOhfhVy2R8pKrzP5PFxvFA_kghVA4ezXeISzW4o0KKFBMZ8Mnd
 hQkhUb3PWp95j5EfJEorKMhuE37noTgh3Th8DHifuYcOblFW2t9kzlTvdgt0D9lAZSNnCCcQLK1M
 DFOL48v0BX9ngqLh1GL2H5uPFdAIQqq5zCe7fg1Nx9UYJW_PF_aYkahieQxIFNbFmEAdfQmEB_E2
 .bW.UZR9.ymD.VmFWfxrCjgDb7voW9KI6_9oYkpeeWjq0hN2aFmdeD5y_rJwO0uSnV6G_DojYwdD
 kbh9qY.zpTtSKYx1VCH3EnvV0wimTKo_bqVjJ16q3eCoAV4HCEvFmMTiJo0qJUwuZytTjdJnPKOM
 JSXznefce69FbHCgYl9jljaGUgZLDCf8y8mlkOb1dVj2SAgl9LOZib0nrdG3SXeZLloKPqmxF.M.
 UuuM3qdiQHBOxoOB.er3adFi2oAQoewElCx.3rgVhzeuU7N8MQKOZg1Z7cFl8ihhdCJVguGdTuyX
 xq30kdJHL0OXYG57JQFIlJgWt3FMFhRY8mnYjEJoVlkgBSIiyYYLdDa97YWhwnRgILsZqwK.tLFn
 k3PNyzLH_5Twmr_etFSjeZqeFXrmxFjPxmQrIFbvY08YY55cHZFWLI.Iar6BUpjAHxet89OwO20M
 R5UwWNtxKDvK8ErTgk6ThIsZ_UaG3A5mILcwpZywf1KXOJyUbq2fasYTJ_d0MapAK34JubX4c
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ne1.yahoo.com with HTTP; Wed, 5 Aug 2020 17:31:17 +0000
Received: by smtp430.mail.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID ed7a3cd929d73e97781e8fdb08361289;
          Wed, 05 Aug 2020 17:31:15 +0000 (UTC)
Subject: Re: [PATCH v6 0/4] LSM: Measure security module data
To:     Tyler Hicks <tyhicks@linux.microsoft.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Cc:     zohar@linux.ibm.com, stephen.smalley.work@gmail.com,
        sashal@kernel.org, jmorris@namei.org,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20200805004331.20652-1-nramas@linux.microsoft.com>
 <f3971f35-309d-c3e5-9126-69add7ad4c11@schaufler-ca.com>
 <50587a3e-bcb5-c68e-c16c-41baf68b4d4a@linux.microsoft.com>
 <c7c168f2-e30b-d2c5-abcb-1b6919197474@schaufler-ca.com>
 <20200805154504.GB4365@sequoia>
 <7c7a076b-6ba7-2e8d-409a-b3b4e4738c41@linux.microsoft.com>
 <20200805161449.GC4365@sequoia>
 <ae80581d-a34c-51f4-d4f9-94c1e341fd15@linux.microsoft.com>
 <20200805163243.GD4365@sequoia>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <ed202762-d7e3-dd13-eda4-03f4e77f1e28@schaufler-ca.com>
Date:   Wed, 5 Aug 2020 10:31:14 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200805163243.GD4365@sequoia>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Mailer: WebService/1.1.16436 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo Apache-HttpAsyncClient/4.1.4 (Java/11.0.7)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 8/5/2020 9:32 AM, Tyler Hicks wrote:
> On 2020-08-05 09:21:24, Lakshmi Ramasubramanian wrote:
>> On 8/5/20 9:14 AM, Tyler Hicks wrote:
>>> On 2020-08-05 09:07:48, Lakshmi Ramasubramanian wrote:
>>>> On 8/5/20 8:45 AM, Tyler Hicks wrote:
>>>>> On 2020-08-05 08:36:40, Casey Schaufler wrote:
>>>>>> On 8/4/2020 6:14 PM, Lakshmi Ramasubramanian wrote:
>>>>>>> On 8/4/20 6:04 PM, Casey Schaufler wrote:
>>>>>>>> On 8/4/2020 5:43 PM, Lakshmi Ramasubramanian wrote:
>>>>>>>>> Critical data structures of security modules are currently not measured.
>>>>>>>>> Therefore an attestation service, for instance, would not be able to
>>>>>>>>> attest whether the security modules are always operating with the policies
>>>>>>>>> and configuration that the system administrator had setup. The policies
>>>>>>>>> and configuration for the security modules could be tampered with by
>>>>>>>>> malware by exploiting kernel vulnerabilities or modified through some
>>>>>>>>> inadvertent actions on the system. Measuring such critical data would
>>>>>>>>> enable an attestation service to better assess the state of the system.
>>>>>>>> I still wonder why you're calling this an LSM change/feature when
>>>>>>>> all the change is in IMA and SELinux. You're not putting anything
>>>>>>>> into the LSM infrastructure, not are you using the LSM infrastructure
>>>>>>>> to achieve your ends. Sure, you *could* support other security modules
>>>>>>>> using this scheme, but you have a configuration dependency on
>>>>>>>> SELinux, so that's at best going to be messy. If you want this to
>>>>>>>> be an LSM "feature" you need to use the LSM hooking mechanism.
>>>>>>>> I'm not objecting to the feature. It adds value. But as you've
>>>>>>>> implemented it it is either an IMA extension to SELinux, or an
>>>>>>>> SELiux extension to IMA. Could AppArmor add hooks for this without
>>>>>>>> changing the IMA code? It doesn't look like it to me.
>>>>>>> The check in IMA to allow the new IMA hook func LSM_STATE and LSM_POLICY when SELinux is enabled is just because SELinux is the only security module using these hooks now.
>>>>>>>
>>>>>>> To enable AppArmor, for instance, to use the new IMA hooks to measure state and policy would just require adding the check for CONFIG_SECURITY_APPARMOR. Other than that, there are no IMA changes needed to support AppArmor or other such security modules.
>>>>>> This is exactly what I'm objecting to. What if a system has both SELinux
>>>>>> and AppArmor compiled in? What if it has both enabled?
>>>>> The SELinux state and policy would be measured but the AppArmor
>>>>> state/policy would be silently ignored. This isn't ideal as the IMA
>>>>> policy author would need to read the kernel code to figure out which
>>>>> LSMs are going to be measured.
>>>> Tyler - I am not sure why AppArmor state\policy would be ignored when both
>>>> SELinux and AppArmor are enabled. Could you please clarify?
>>> I think Casey is talking about now (when AppArmor is not supported by
>>> this feature) and you're talking about the future (when AppArmor may be
>>> supported by this feature).
>> Got it - thanks for clarifying.
>>
>> But with the current code if SELinux is enabled on the system, but AppArmor
>> is not and the IMA policy contains "measure func=LSM_STATE" then the policy
>> will be rejected as "-EINVAL".
> The AppArmor policy load? Yes, the load will fail.
>
> What Casey is talking about is when SELinux and AppArmor are enabled in
> the kernel config but AppArmor is active. This scenario is true in
> distro kernels such as Ubuntu's kernel:
>
> $ grep -e CONFIG_SECURITY_SELINUX= -e CONFIG_SECURITY_APPARMOR= /boot/config-5.4.0-42-generic 
> CONFIG_SECURITY_SELINUX=y
> CONFIG_SECURITY_APPARMOR=y
> $ cat /sys/kernel/security/lsm
> lockdown,capability,yama,apparmor

Yes. This is one reason that a compile time check is inappropriate.
You also have the case with SELinux where you can unload the module.
It's deprecated, but still possible.

If you boot with SELinux compiled in, but with security=none on
the boot line you also have a case where the compile time check is
inappropriate.

> Casey also likely has LSM stacking in mind here where SELinux and
> AppArmor could both be active at the same time but the LSM stacking
> series is not yet applied.

It isn't in Linus' kernel, but is available in Ubuntu.
The audit/IMA rule selection get hairy in the multiple
security module case, but you don't need to add that
for the proposed scheme to be flawed.

>
> Tyler
>
>> So the policy author would get a feedback even now.
>> Correct me if I am wrong.
>>
>>  -lakshmi
