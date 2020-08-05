Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6970A23CC31
	for <lists+linux-integrity@lfdr.de>; Wed,  5 Aug 2020 18:29:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726402AbgHEQ3N (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 5 Aug 2020 12:29:13 -0400
Received: from sonic307-15.consmr.mail.ne1.yahoo.com ([66.163.190.38]:42714
        "EHLO sonic307-15.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727001AbgHEQ03 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 5 Aug 2020 12:26:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1596644748; bh=1cU3wjJlOPvRuw2818Qutqs4mQWnaGRISNeePAjFogU=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=HeJ8bZXaFWiKJIzzL3gho1AU0tgiQ1e+Kb08in02P1pufoU7rhEns/aCYmNdCZAHT4DQBoS4Cr3I8K9oxvyjxLE9gG2ed/JjWYEyiJcFEpUziw0XGGP0cuWqHvVvdTHKUoko0LrzjqtZtH8Dd7J57tZ4BodEutf0BKR6TYcd90I/3lBq5Rj6w1NLuNAzhFQm3Yn74yb/YdsG3vN1Z+OpIsg9ISa+Qc71AQS0ZkVNA2cDmJOefm7AuBtmrDG7LjBtVg4RCoaD+T0jWWAysaCkUdueq68berw3vBnA7mcncCyJhYXYz6L1cY67fKjYgZQqdaR+qzmPmR/1XMeuMozf3g==
X-YMail-OSG: iMtRnVsVM1nBFaQ4NlnavoaLZ.x_8bBSps_sPqYvR6j1jlYcZJRhJZp65eLXgdE
 q9ApMJrEobSvGXllUAQTERK4waFhlfC6Mw18jWRv3d4F3t_mwWDayC8PJA1Aj8dUzUjY.G1iHHsr
 E5PU7woRCZ25BLBBFU_fCg21.oa.KU6.xTeDQsUOPd0R38DzROYXZai7oGC8j7RfILJodifwka4a
 9.DH1xziHMKmGpcT1UA4RkuIPvCXwQYmDqcE1JzzWD3.IiMX.tGfAnfROeYFRooiuQnG1K4BVioT
 Tpgnv0eB4m76wEOdOnrhNMk.Yjb9swgY74lxanI5peFxYoTo2BywAn4zsR0ukS2eseA3nTQdSLLF
 lLafs4oEPPUwKKCFesH1XAzOEUH2TFiDCnPIHGi9_6MT9rN1FNN_cwJ__4VSbt8tQOpeQ3w3sHwX
 FaLPA7A_UtFPgw46T8PahKmjre0uyB2vklwCgwIanUt0GzDLCjYPkzoBkkj0tjnaYEXybt_nevxn
 xrh1L9Usez8iRMlr_O0hD.D5qulo.Dp5r3ry2UQ_Z2m1S6M.g5tsbAaoms3XhMkW6JEmdN2UpD2V
 QMDaiBQSIjE8tEIpk6gsZplzC5Z0EnIaPhcOxxJYfhr7f1KvSBOdqNW.aFnUR7JEyXkTzm3dHR.K
 M45tNrYI2FWF4fcfLDswyAoM82xogimHXTsnvN3eDQ7EVitTcSn4DcWlWy1zhs_VORG1oiYw8K6B
 66NkLqxPZqAhep4hRanKfuGSXjeYsS4funYv80RXiqEyYCXFuTHXi4kVqzoS9Ao.51miCllCOLbs
 W8IZKld99Ngl4NxhQ6yiihJRJE.3r4nyXMVrKxJ17WncVYJRm_Olq4GWGlC_odAqZ096jFP1adYp
 0eruq27ZgLFCqO0SG.cUnyximRlQPkETs6VvApCn9knzzt.cnpL94y2HeYYUsmhbnC4d1fLwLRr9
 itaS6XiJsbwKiXz0rJmJ1FYUUbRLRALK5AOLNHQ9zIzs7KiiPY6Mrf2LwhFOnqw2ZRcaCAtfq1wD
 L6Gzi36AkigAhdhYsma7_4Y7hG2JkN6k9_n9rggASFmj0DIFEMwBzyMR9HyeSc2VHDUNx3avC1a0
 ZAmtg2kAdPOIhb4jxJvHZRuMYBcGKhiqmpsnCwSA3YlMFnH8Neq82OO_Y7yMtNxhnQzBABRIBlVk
 UIyvHfLpuWx0X6cvEHrZB1MSQCM74nc3dLUkNAGExhF5JyLLB8eEeqyuDECr5jm50itdW0Gx1eaw
 yliYZaSh2ALhZNFHOdo1Jv3S.9k6bFq39_YTMU1K.VzS2b7ThUAFaWbbNiYHkNQKZQ6jFzG.B0bm
 JvjuabJA.mNyuekH95nCF46Y6YV2sWp4cQzG0g2sv21s9IlM5iyXoNtqsuA--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ne1.yahoo.com with HTTP; Wed, 5 Aug 2020 16:25:48 +0000
Received: by smtp417.mail.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 05f98be0901e51aef2f5e5eae571f525;
          Wed, 05 Aug 2020 15:36:40 +0000 (UTC)
Subject: Re: [PATCH v6 0/4] LSM: Measure security module data
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        zohar@linux.ibm.com, stephen.smalley.work@gmail.com
Cc:     tyhicks@linux.microsoft.com, sashal@kernel.org, jmorris@namei.org,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20200805004331.20652-1-nramas@linux.microsoft.com>
 <f3971f35-309d-c3e5-9126-69add7ad4c11@schaufler-ca.com>
 <50587a3e-bcb5-c68e-c16c-41baf68b4d4a@linux.microsoft.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <c7c168f2-e30b-d2c5-abcb-1b6919197474@schaufler-ca.com>
Date:   Wed, 5 Aug 2020 08:36:40 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <50587a3e-bcb5-c68e-c16c-41baf68b4d4a@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Mailer: WebService/1.1.16436 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo Apache-HttpAsyncClient/4.1.4 (Java/11.0.7)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 8/4/2020 6:14 PM, Lakshmi Ramasubramanian wrote:
> On 8/4/20 6:04 PM, Casey Schaufler wrote:
>> On 8/4/2020 5:43 PM, Lakshmi Ramasubramanian wrote:
>>> Critical data structures of security modules are currently not measured.
>>> Therefore an attestation service, for instance, would not be able to
>>> attest whether the security modules are always operating with the policies
>>> and configuration that the system administrator had setup. The policies
>>> and configuration for the security modules could be tampered with by
>>> malware by exploiting kernel vulnerabilities or modified through some
>>> inadvertent actions on the system. Measuring such critical data would
>>> enable an attestation service to better assess the state of the system.
>>
>> I still wonder why you're calling this an LSM change/feature when
>> all the change is in IMA and SELinux. You're not putting anything
>> into the LSM infrastructure, not are you using the LSM infrastructure
>> to achieve your ends. Sure, you *could* support other security modules
>> using this scheme, but you have a configuration dependency on
>> SELinux, so that's at best going to be messy. If you want this to
>> be an LSM "feature" you need to use the LSM hooking mechanism.
>
>>
>> I'm not objecting to the feature. It adds value. But as you've
>> implemented it it is either an IMA extension to SELinux, or an
>> SELiux extension to IMA. Could AppArmor add hooks for this without
>> changing the IMA code? It doesn't look like it to me.
>
> The check in IMA to allow the new IMA hook func LSM_STATE and LSM_POLICY when SELinux is enabled is just because SELinux is the only security module using these hooks now.
>
> To enable AppArmor, for instance, to use the new IMA hooks to measure state and policy would just require adding the check for CONFIG_SECURITY_APPARMOR. Other than that, there are no IMA changes needed to support AppArmor or other such security modules.

This is exactly what I'm objecting to. What if a system has both SELinux
and AppArmor compiled in? What if it has both enabled?

>
> Please see Patch 1/4
>
> +            else if (IS_ENABLED(CONFIG_SECURITY_SELINUX) &&
> +                 strcmp(args[0].from, "LSM_STATE") == 0)
> +                entry->func = LSM_STATE;
> +            else if (IS_ENABLED(CONFIG_SECURITY_SELINUX) &&
> +                 strcmp(args[0].from, "LSM_POLICY") == 0)
> +                entry->func = LSM_POLICY;
>
> And, if early boot measurement is needed for AppArmor the following change in IMA's Kconfig
>
> Patch 4/4
>
> +config IMA_QUEUE_EARLY_BOOT_DATA
>      bool
> +    depends on SECURITY_SELINUX || (IMA_MEASURE_ASYMMETRIC_KEYS && SYSTEM_TRUSTED_KEYRING)
>      default y
>
> If you think calling this an "LSM feature" is not appropriate, please suggest a better phrase.

In the code above you are under CONFIG_SECURITY_SELINUX.
I would suggest that it's an SELinux feature, so you should
be using SELINUX_STATE and SELINUX_POLICY, as I suggested
before. Just because SELinux has state and policy to measure
doesn't mean that a different module might not have other data,
such as history, that should be covered as well.

I realize that IMA already has compile time dependencies to
determine which xattrs to measure. There's no reason that
the xattr list couldn't be determined at boot time, with
each security module providing the XATTR_NAME values it
uses.

>
> But like I said above, with minimal change in IMA other security modules can be supported to measure STATE and POLICY data.
>
>  -lakshmi
>
>
