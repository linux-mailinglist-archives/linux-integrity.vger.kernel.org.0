Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7243323CF11
	for <lists+linux-integrity@lfdr.de>; Wed,  5 Aug 2020 21:13:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728754AbgHETNb (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 5 Aug 2020 15:13:31 -0400
Received: from sonic304-27.consmr.mail.ne1.yahoo.com ([66.163.191.153]:44247
        "EHLO sonic304-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729216AbgHES0s (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 5 Aug 2020 14:26:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1596651945; bh=FOt0zwyHrJWGV8EAmJgJDEq7xIcxGCYOB9lxPGye2YQ=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=sligP+Ml+0zuo/I/JfvSiHtxUKTMcEpvND0H95NeiDHvw2DSGx1zLe+2lArdHgJMKDRDWQIktPA1qeQl0A15IDLuRv2uhxj69lX241Sx65eaJJFTuO2ubMsS/X+Pd3fV2eSfpRytARw8MoE86QP1KuWHlNSrnftOZuQH+508PPx9XvAjBofb0VuSqdQvn/gLnoKhJ/CsvRBfT6XACVqYU/pCQ9f0FhzIdcBAhz0ho0U2ZoTjvoZQLrH+Syn+l507Riw794LdT8xga0ooLTmZxS8T9YWetudDjcl6CzomiW9291uxEq4Kt+tndWJbFjhEClJ6g4atHvZYNW5WOYqfmg==
X-YMail-OSG: oN35ZiMVM1mfYW44uLsECdJwf7aD1ebBeTnN47QhSKpbA7H7q0Ta45_XoY7Kxk0
 xRjvrj75awjVybWRzEYlkQqAg45ISZEVAfMkKYDi_XF__mUx5lwC9ueVSvW_Twy.88xSKQUysr9Y
 E7brLsol0w7WOUw4yuyfX6IlxhhN7fCImvnue0cfi.rj05KqrVhqrv1FBU5BBp8gbsZU4SjqpnPY
 UdVQLQfUJzYPvvSP9X3yTyTda5.PP1goC2KLANQ18Xk_zH8ezbsTw0e6mwF455n.7AUZ6lSVQtwx
 AhALXcD0ZOkTYrxFIItbGTi5XVkwdRyZ639sUMf1lskNosHAA0OUWGETOZ3hUErwTUfoxx.3okAG
 WggPQUXdxskaPZmPUM1GP3lUcFyFkA7mK0GmeHyedUXkiBuOvaju0xfCKlfo2k10.8lDazlgvQnY
 RYczWa.58pSBZ0Eha2JLmD6yHtYawj2WbLgC0O0P9hdk3nuK2iyh0_Q3tb8X8OrELC7.zO94HAf.
 4u2bUphuWWJulV2f_voWaWwe34ebnkJ_hEu58OoG_xI9MkolsISXrzm9eWqe56tDp3AmkRJE_la0
 GthSM4.GjUd3m1VIQ5y58cHlTRzjLiF.8S2H.8W_jZqd2N4DD4sW0Ap_QT_vi39MrOil7o_u6eX9
 IlAwQzRZkGdDFU_UvbRxX6KGtCY5C4cqwJuxU3bA.wxUxZ8junCY4LHlbZguoL_ml2Ko8xCm0p7y
 lBXzF5MTevox7HjcnvlKVcolNY1PB_l8d42XNjldN.4wIO.sGfhPWURdlYn0CnOdWD40gsvKjxTJ
 2y9kznja8hJWE1z8XGwU13S7nAHC_JKrgDzYiYTtuvo.pCwir4BF9EBjQHFq4qCLRH_jhuYL868C
 u7DBHPQdFhDSD10r7Snc3bYEmoiLYAEnnLBwALxU_nOB768bcT5Ppv8Kk5Yb0TeT601.QOo5KkHD
 AvDUdu1hgNLKXvwf1zL4EfV7RHAj203PLRRHTgJYMJ8FiINWOINsvyxlsXGkkKZMg2LwiEH6VO1D
 79fHSkZRKUPGx5dJWi4x_qjN2u3C72zPeWDymvlbLhkYlphEPaKwPLyjd_vCbo5wTMAvsnl13dwQ
 YnIpL4vuo0i_Xt5SFphPU0pDe_0WnXFpl0etDBb3fYPKGBqC_KYGfj0gPpdUxc.N3ko.ScZU_iV6
 oPV1DjWZVXATDpSYk82s6k_hlgFH61VIik95J2gTxRcexi3EdmVZub5vQNjbCoTPLULut5vo.9XN
 7YzU5BpMpMHc9Qiet3.LUhNtYZnxjBR41WDdFB6TfHTkncBh0c8JftZAiKL7fMPhmQfI_kTcP5nU
 LlsKcjv8N1KPTj8tXQM4_0c_CvAnj6M44bRS8GcARpKK7z5EohGgkdnXuP40V7zrhXyk-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ne1.yahoo.com with HTTP; Wed, 5 Aug 2020 18:25:45 +0000
Received: by smtp410.mail.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID a204618d0e4212a8de77f50ea77d7c86;
          Wed, 05 Aug 2020 18:25:40 +0000 (UTC)
Subject: Re: [PATCH v6 0/4] LSM: Measure security module data
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>
Cc:     stephen.smalley.work@gmail.com, sashal@kernel.org,
        jmorris@namei.org, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20200805004331.20652-1-nramas@linux.microsoft.com>
 <f3971f35-309d-c3e5-9126-69add7ad4c11@schaufler-ca.com>
 <50587a3e-bcb5-c68e-c16c-41baf68b4d4a@linux.microsoft.com>
 <c7c168f2-e30b-d2c5-abcb-1b6919197474@schaufler-ca.com>
 <20200805154504.GB4365@sequoia>
 <69810007161e689ac817099fb1c6df21962963e4.camel@linux.ibm.com>
 <9ad079ff-1bd4-1302-e6fb-25a7396ef12f@linux.microsoft.com>
 <ecc97f59-c2cc-0b23-6199-925ba0d6358b@schaufler-ca.com>
 <50f00ace-8d46-01c2-bf0f-d5484aafd95c@linux.microsoft.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <5570a4d8-8779-6efe-b208-f7efa8ba9488@schaufler-ca.com>
Date:   Wed, 5 Aug 2020 11:25:39 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <50f00ace-8d46-01c2-bf0f-d5484aafd95c@linux.microsoft.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Mailer: WebService/1.1.16436 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo Apache-HttpAsyncClient/4.1.4 (Java/11.0.7)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 8/5/2020 11:08 AM, Lakshmi Ramasubramanian wrote:
> On 8/5/20 10:57 AM, Casey Schaufler wrote:
>> On 8/5/2020 10:25 AM, Lakshmi Ramasubramanian wrote:
>>> On 8/5/20 10:03 AM, Mimi Zohar wrote:
>>>> On Wed, 2020-08-05 at 10:45 -0500, Tyler Hicks wrote:
>>>>
>>>>> In addition to SELINUX_STATE and SELINUX_POLICY, we should also consider
>>>>> the proposed LSM_STATE and LSM_POLICY func values but require an "lsm"
>>>>> rule conditional.
>>>>>
>>>>> So the current proposed rules:
>>>>>
>>>>> ? measure func=LSM_STATE
>>>>> ? measure func=LSM_POLICY
>>>>>
>>>>> Would become:
>>>>>
>>>>> ? measure func=LSM_STATE lsm=selinux
>>>>> ? measure func=LSM_POLICY lsm=selinux
>>>>>
>>>>> The following rules would be rejected:
>>>>>
>>>>> ? measure func=LSM_STATE
>>>>> ? measure func=LSM_POLICY
>>>>> ? measure func=LSM_STATE lsm=apparmor
>>>>> ? measure func=LSM_POLICY lsm=smack
>>>>
>>>> Kees is cleaning up the firmware code which differentiated between how
>>>> firmware was loaded.?? There will be a single firmware enumeration.
>>>>
>>>> Similarly, the new IMA hook to measure critical state may be placed in
>>>> multiple places.? Is there really a need from a policy perspective for
>>>> differentiating the source of the critical state being measurind??? The
>>>> data being measured should include some identifying information.
>>>
>>> Yes Mimi - SELinux is including the identifying information in the "event name" field. Please see a sample measurement of STATE and POLICY for SELinux below:
>>>
>>> 10 e32e...5ac3 ima-buf sha256:86e8...4594 selinux-state-1595389364:287899386 696e697469616c697a65643d313b656e61626c65643d313b656e666f7263696e673d303b636865636b72657170726f743d313b6e6574776f726b5f706565725f636f6e74726f6c733d313b6f70656e5f7065726d733d313b657874656e6465645f736f636b65745f636c6173733d313b616c776179735f636865636b5f6e6574776f726b3d303b6367726f75705f7365636c6162656c3d313b6e6e705f6e6f737569645f7472616e736974696f6e3d313b67656e66735f7365636c6162656c5f73796d6c696e6b733d303
>>>
>>> 10 f4a7...9408 ima-ng sha256:8d1d...1834 selinux-policy-hash-1595389353:863934271
>>>
>>>>
>>>> I think moving away from the idea that measuring "critical" data should
>>>> be limited to LSMs, will clarify this.
>>>>
>>>
>>> Are you suggesting that instead of calling the hooks LSM_STATE and LSM_POLICY, we should keep it more generic so that it can be utilized by any subsystem to measure their "critical data"?
>>
>> Policy, state, history or whim, it should be up to the security module
>> to determine what data it cares about, and how it should be measured.
>> Smack does not keep its policy in a single blob of data, it uses lists
>> which can be modified at will. Your definition of the behavior for
>> LSM_POLICY wouldn't work for Smack. That doesn't mean that there isn't
>> a viable way to measure the Smack policy, it just means that IMA isn't
>> the place for it. If SELinux wants its data measured, SELinux should be
>> providing the mechanism to do it.
>>
>> I guess that I'm agreeing with you in part. If you want a generic measurement
>> of "critical data", you don't need to assign a type to it, you have the
>> caller (a security module, a device driver or whatever) identify itself and
>> how it is going to deal with the data. That's very different from what you've
>> done to date.
>
> Agree.
>
> Like Stephen had stated earlier, the reason we kept separate hooks (STATE and POLICY) is because the data for state is usually small and therefore we measure the entire data. Whereas, policy data is usually quite large (a few MB) and hence we measure a hash of the policy.

SELinux should determine how it wants its data measured.
SELinux, not IMA, should determine if some "critical data"
be measured in total, by its hash or as a count of policy
rules. It would be handy for IMA to supply functions to do
data blobs and hashes, but it should be up to the caller to
decide if they meet their needs.

>
> If change to a generic measurement of "critical data", at the least IMA should provide a way to measure "data" and "hash(data)".
>
> And, with the caller providing the identifying information, there would be no need to call it "LSM_STATE" or "SELINUX_STATE" or such.
>
> ?-lakshmi
>
>
