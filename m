Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B46523CF54
	for <lists+linux-integrity@lfdr.de>; Wed,  5 Aug 2020 21:20:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728527AbgHETTe (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 5 Aug 2020 15:19:34 -0400
Received: from sonic314-26.consmr.mail.ne1.yahoo.com ([66.163.189.152]:41860
        "EHLO sonic314-26.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729065AbgHER5v (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 5 Aug 2020 13:57:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1596650251; bh=XgCG8lcnjxIeORNmuwc0TYv7CRCaev7O3WlPBRfqpr0=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=WnD7xdKb4N2f5LuWbzmSMX1np7tmR9/d6cH08D39mWyn2seWWdzLcNNfNdrjTcApHP+kNA9XldW9GeU/Kj/UzWPU8MZ5/Z2Ry0+28lBY1kWmJby9QWq+EV8z0eCeJC5aJzTmL6KNctba3e+IFrfgQNsc71AP2JKX/gVKmfZoxI5sLQ56gwSmR9tLXhMvs/GBoglMHoWUWjecgljhx1zXhGDMHzyt0VNXFC7mYqy9VT8CqF7XFcb/ru/PgaMkQHbBfOkBW3b64h+LDnRCdlUMdhnj5QmoZwsPrVS7QdTj9CGoiqgPk/dOJgts4mRO1B5ewH+nrD6PFWyXBZMSzWfH+w==
X-YMail-OSG: EcG99zoVM1l1r3Qoo_WGiePhQymKAFr8EMIUs.I4BAUfEQngK_EOiRChwqsdXOA
 QrqFyH9yoITKqXafD_kI.5oH8hvz1MEJ.0jykx3RLzlmKDwmgd8HmmB6Vn9PWWmzkve6yl6Gr.1r
 MgcgK9tLWJSEWB4Qw5v867YyN_NDCAtnw8qdp1PDosvbCsu283G6GmGz8Y3TeRils9VfsCAa8W3a
 P63REHjlUMn9dN46zE6MMUno4h8KM.O7iF4ovjYUlfaiMwvBH3Q3NT56PTDhPsdIbwGGD6JlDJoU
 RsfEvQLLXdOYnOpUaxn235XBciPVCkHDLBSUHxOvHJnr9OxhU9IY_XbjOsFGhrWoJ5OMD6yIHV.O
 ORuVO.1ysn4F3pb3I9iVSciSkFdKbca8wvL6im_cA8KbWnq4R0oKK7GOdu0XexhKrrBRF7qFcNQv
 QRLMaPmBlvG9o53ta5jcR15g_W0X4jjYBdbuQO3ybuaYLLeR26LW2sC.xcuec6IV93u2fOOwZ0Bl
 dCX5ZpiiDGaYpeX04xEhcmP0cC77Hbh6GU.D7FuOOAmPUTnXOPEBLTysd54Mo0VZLDwmz57h2qu5
 iwojtdI.O9d7dO6xQ2FYHGlXagQmrDbaKaKVWfnixfPeHDb8.wSmfWpzwJLK8s9GATiuEw7tDHOi
 m5xDZSSk5xWTS2vjzYra0Mdm2uQG6KKrH0D_rUlz5T2UCgBX8hIjn2WznDiZt0wEk9GiCNtOr8QM
 ivK6oTEnri7xTw1GFodpXyvf.wGvA5kYgKZ0WCT7QtYZSU04gZCmCwDCEg4FUDgwGmhq4BtyshLt
 IqAPChrMF5s2yn7C43Y0vMcjagFLN7bHP7cGm6LkemYmuSC56DgG5gFaOcy2JWdGMGCumVtKcPXd
 kB3NKxkrr3S71tnACRqiHxYmHejg1SYF0Vd0TSfljmJXd9aGPTx28T7Faix134NpyyB5qjecDxZu
 dChhNcW6VODl.bRRKQh_M4x45gaEmCy5bCj6NE6wcAFn6XjtbYeEcQoE3TpOUzhoFEiVg3FxUmmf
 6LNl9rWGb.Ox_1AIrLs2rmZ6BNNDjPKI7jEQGAo3XqR1QQN355976YvwoJ.VEl9oKzblFxE27szh
 BlFNnvccB8oSNuY8nHeBFtO1C2QNU2MdtsrCgzVK9F9lY8aXbSx7bGp_9yxG8U9rpXxXkRHt1vvz
 fhsF8QD9zSWVc1_3mytV1kNTO4uAO4dqueKq7m5OrTrwylBfXSncJQdTLJml1UDd2nxWNjcuecc5
 A3XmpwkEnsy4aToKbQOia11QaQUnG2ZbEVfqzXGhy80NzXHnqUzn.pcvaITpdhoRaaQrQoF6s.qI
 XaTAP_qsLC3m70HKWjNNuSH2asF6aDuQT8KMEXhXXJ.Crqtf0iQx7SO4D64WDgUP246nXhh0-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ne1.yahoo.com with HTTP; Wed, 5 Aug 2020 17:57:31 +0000
Received: by smtp405.mail.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 434318a9e6d32e1fab30c48ef80acc72;
          Wed, 05 Aug 2020 17:57:26 +0000 (UTC)
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
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <ecc97f59-c2cc-0b23-6199-925ba0d6358b@schaufler-ca.com>
Date:   Wed, 5 Aug 2020 10:57:25 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <9ad079ff-1bd4-1302-e6fb-25a7396ef12f@linux.microsoft.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Mailer: WebService/1.1.16436 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo Apache-HttpAsyncClient/4.1.4 (Java/11.0.7)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 8/5/2020 10:25 AM, Lakshmi Ramasubramanian wrote:
> On 8/5/20 10:03 AM, Mimi Zohar wrote:
>> On Wed, 2020-08-05 at 10:45 -0500, Tyler Hicks wrote:
>>
>>> In addition to SELINUX_STATE and SELINUX_POLICY, we should also consider
>>> the proposed LSM_STATE and LSM_POLICY func values but require an "lsm"
>>> rule conditional.
>>>
>>> So the current proposed rules:
>>>
>>> ? measure func=LSM_STATE
>>> ? measure func=LSM_POLICY
>>>
>>> Would become:
>>>
>>> ? measure func=LSM_STATE lsm=selinux
>>> ? measure func=LSM_POLICY lsm=selinux
>>>
>>> The following rules would be rejected:
>>>
>>> ? measure func=LSM_STATE
>>> ? measure func=LSM_POLICY
>>> ? measure func=LSM_STATE lsm=apparmor
>>> ? measure func=LSM_POLICY lsm=smack
>>
>> Kees is cleaning up the firmware code which differentiated between how
>> firmware was loaded.?? There will be a single firmware enumeration.
>>
>> Similarly, the new IMA hook to measure critical state may be placed in
>> multiple places.? Is there really a need from a policy perspective for
>> differentiating the source of the critical state being measurind??? The
>> data being measured should include some identifying information.
>
> Yes Mimi - SELinux is including the identifying information in the "event name" field. Please see a sample measurement of STATE and POLICY for SELinux below:
>
> 10 e32e...5ac3 ima-buf sha256:86e8...4594 selinux-state-1595389364:287899386 696e697469616c697a65643d313b656e61626c65643d313b656e666f7263696e673d303b636865636b72657170726f743d313b6e6574776f726b5f706565725f636f6e74726f6c733d313b6f70656e5f7065726d733d313b657874656e6465645f736f636b65745f636c6173733d313b616c776179735f636865636b5f6e6574776f726b3d303b6367726f75705f7365636c6162656c3d313b6e6e705f6e6f737569645f7472616e736974696f6e3d313b67656e66735f7365636c6162656c5f73796d6c696e6b733d303
>
> 10 f4a7...9408 ima-ng sha256:8d1d...1834 selinux-policy-hash-1595389353:863934271
>
>>
>> I think moving away from the idea that measuring "critical" data should
>> be limited to LSMs, will clarify this.
>>
>
> Are you suggesting that instead of calling the hooks LSM_STATE and LSM_POLICY, we should keep it more generic so that it can be utilized by any subsystem to measure their "critical data"?

Policy, state, history or whim, it should be up to the security module
to determine what data it cares about, and how it should be measured.
Smack does not keep its policy in a single blob of data, it uses lists
which can be modified at will. Your definition of the behavior for
LSM_POLICY wouldn't work for Smack. That doesn't mean that there isn't
a viable way to measure the Smack policy, it just means that IMA isn't
the place for it. If SELinux wants its data measured, SELinux should be
providing the mechanism to do it.

I guess that I'm agreeing with you in part. If you want a generic measurement
of "critical data", you don't need to assign a type to it, you have the
caller (a security module, a device driver or whatever) identify itself and
how it is going to deal with the data. That's very different from what you've
done to date.

>
> I think that is a good idea.
>
> ?-lakshmi
