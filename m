Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BB281FA402
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Jun 2020 01:18:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbgFOXS0 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 15 Jun 2020 19:18:26 -0400
Received: from sonic308-16.consmr.mail.ne1.yahoo.com ([66.163.187.39]:38384
        "EHLO sonic308-16.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726452AbgFOXSZ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 15 Jun 2020 19:18:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1592263104; bh=ej6oH06Vv7VqsMpOz0JTUHfGltJIWHTMPFeVVTZi45w=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=MjmEKW6YsE8434jD5w9DnaG1MkOEuQ9uUxMooyG+WoEEJOVEqSZoCCiPE1BR5DnppOKqlLo5CH50YbRo3n8smFK7kc35nLCw0+DVdMZ6ttcOQAkFG8aRkrD0W6jhAgINznhm5+EDDQUP28PLKEGusLf8y4GE7vGFOZWVky1tD2Z1rc5c3dd3lwV/TzcOi7HHs+j+fnP9RM61Tjm0mJFrNBofJTSlZ5tj+KF7qBctyp5aRG14W6NWswpv/o3XdMjgjePGuvve8i6WM2koNp21hqmQweqeHnCEVJ3UddGjIkT2z1O69yWD2OCHD82C6/N/c5d6Fx5PdqWwQdrPqtTBAA==
X-YMail-OSG: Mey0tvQVM1ltUSRdg1QaiQJELjPOAO51fM_T0XWCPycL.l4oEZcfACo6ByPpmMy
 9CtpHrqtPNAZDprsqRU4zha2Nw8_PqcWcWZ7bhoJ7Xf1gzxwscPKZLr7TgQI7l9juGU.T1UufcYs
 T_QoOxN_0Shkm9Y_uZtZK25jkPEjSDdqJHSetARDwY1sqihLdao2C_xCRxNFtiede8nKid8k6JoL
 54Ik8G6JKzlxMzJR4Za5rTQaHGmMRK9cOqGivayUnYzy44kDNneXWemWuj3ASApamLfYo7dnZEFj
 u3lCLqU6EWUFLI82IHbm4QC86W6KF0H9IjT8NdTVoeK_uTrpIyBC3pDJ7SRm1mceDxaojE1PGP8v
 CDeg9TL21ijWF99mXdHNDDHngaxlhpkmRJYLKYieFwoqlGlOUtmLDmRd0p4MQDktlboj4fXRiCbf
 FfUHLnmC5bmgLl5F4jORT4t_RFm_OdqvQ2ilMa7ven4oUXAIu3RK9BC3_pyh3pdhGVhGA_naU_7z
 UNcRsMqaSt8tFgle9O2Xy8wD3oQU7_t7rvcc_KRAGIQXygBK3yxdtaDJIkBWzQij_67TOHP_EH6K
 mqzB5Yu0E3lESBkTgPGOeUFPo50bTBIk2tMnDzd6.woUL9BbVSn3fAQX.O5WwXBGSVOcHgzxFmhT
 PbM7GDcyftBiKjnGbwhkuqey8Xx7riEuekVVDeSOu0fGnneZ.9zyZaHd3B8u2hGuUYpdfBoiFalV
 sPavpVACt8zgdgF.pReLLM_ZfshR_wSvjvkESvQJNcdcbTjflebEGVWpqIFVvicxavelxZ.ShhQG
 s8qI.oG9D6iOuV74iJW8szTTMjBLuh2UKsG8jz4reMmRMumF8Ou.2GOeQfpevg03.dlYLjrOPGE6
 _A4x_0Vc4vK8CklXdWLRzSkxNLnG.1mooz_qB2OHmd5xNI8jmEbNHNnP8m4pWwfOryizYItMuaWd
 ZOyvEI6m84njM8.HyQSn_mFaq9PTzD12eY06DZ.JP_GQcsBiolbr5qGsLULshvExr0JQC5zzQabQ
 8dnIlshr16n4Wkfq54emJdhx_szRSu_a2UURuihbCwUumDVV20ALZz4bs_ORMXCtizgX0Mm5uOnj
 rVAPNsv0uLRKcIC_NBLJetkV0rGAwtUZr5BRkUyEhqovkZ.y1fg2HdLF2JdnSl_EDqeKNqII15V9
 OQlfYcklTNq5AExAJ3184eIuGpCxRJYbaKOLZ4TnKKgMxDpylQgDI6M407LkRLwL2s0nOBcMXii4
 wy8JWSLJKVinQA8drL5Z99I_chJ7hCBDgh_ksC_KcUuD.JE1ek8WRbCX1prnRuT1d28fbsMPl7cC
 rIAcxWfwORv1BE_yTYUcLrZZ8qcQdCZowWd7d5fnVrRAg4IZWIzorEcq1aXhWnbofJWqbQEGGPaj
 ymJ9WH8_Gq_utK5bJpt87eY.0MbJf
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Mon, 15 Jun 2020 23:18:24 +0000
Received: by smtp413.mail.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID c78d901355a6253e30e491bc568c2d2b;
          Mon, 15 Jun 2020 23:18:22 +0000 (UTC)
Subject: Re: [PATCH 4/5] LSM: Define SELinux function to measure security
 state
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        Stephen Smalley <stephen.smalley@gmail.com>,
        James Morris <jmorris@namei.org>,
        linux-integrity@vger.kernel.org,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20200613024130.3356-1-nramas@linux.microsoft.com>
 <20200613024130.3356-5-nramas@linux.microsoft.com>
 <CAEjxPJ49UaZc9pc-+VN8Cx8rcdrjD6NMoLOO_zqENezobmfwVA@mail.gmail.com>
 <a9a20aa5-963e-5f49-9391-0673fdda378e@linux.microsoft.com>
 <2df1bc4f-675d-7868-de5b-1256346f982e@schaufler-ca.com>
 <1592243068.11061.155.camel@linux.ibm.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <59f3b8bf-1b61-b67e-7318-3ed251bd10bf@schaufler-ca.com>
Date:   Mon, 15 Jun 2020 16:18:22 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <1592243068.11061.155.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Mailer: WebService/1.1.16119 hermes_yahoo Apache-HttpAsyncClient/4.1.4 (Java/11.0.6)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 6/15/2020 10:44 AM, Mimi Zohar wrote:
> (Cc'ing John)
>
> On Mon, 2020-06-15 at 10:33 -0700, Casey Schaufler wrote:
>> On 6/15/2020 9:45 AM, Lakshmi Ramasubramanian wrote:
>>> On 6/15/20 4:57 AM, Stephen Smalley wrote:
>>>
>>> Hi Stephen,
>>>
>>> Thanks for reviewing the patches.
>>>
>>>>> +void security_state_change(char *lsm_name, void *state, int state_=
len)
>>>>> +{
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ima_lsm_state(lsm_name, state=
, state_len);
>>>>> +}
>>>>> +
>>>> What's the benefit of this trivial function instead of just calling
>>>> ima_lsm_state() directly?
>>> One of the feedback Casey Schaufler had given earlier was that callin=
g an IMA function directly from SELinux (or, any of the Security Modules)=
 would be a layering violation.
>> Hiding the ima_lsm_state() call doesn't address the layering.
>> The point is that SELinux code being called from IMA (or the
>> other way around) breaks the subsystem isolation. Unfortunately,
>> it isn't obvious to me how you would go about what you're doing
>> without integrating the subsystems.
> Casey, I'm not sure why you think there is a layering issue here.

I don't think there is, after further review. If the IMA code called
selinux_dosomething() directly I'd be very concerned, but calling
security_dosomething() which then calls selinux_dosomething() is fine.
If YAMA called security_dosomething() I'd be very concerned, but that's
not what's happening here.

> =C2=A0There were multiple iterations of IMA before it was upstreamed. =C2=
=A0One
> iteration had separate integrity hooks(LIM). =C2=A0Only when the IMA ca=
lls
> and the security hooks are co-located, are they combined, as requested
> by Linus.
>
> There was some AppArmour discussion about calling IMA directly, but I
> haven't heard about it in a while or seen the patch.
>
> Mimi

