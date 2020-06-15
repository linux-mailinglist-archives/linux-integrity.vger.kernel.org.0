Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D5701F9E92
	for <lists+linux-integrity@lfdr.de>; Mon, 15 Jun 2020 19:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731197AbgFORdJ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 15 Jun 2020 13:33:09 -0400
Received: from sonic313-15.consmr.mail.ne1.yahoo.com ([66.163.185.38]:35453
        "EHLO sonic313-15.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731233AbgFORdI (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 15 Jun 2020 13:33:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1592242387; bh=UPyxtLQjwlSDBzaEwRCuQJEKhg1c/SEcEVud4TS00Xc=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=V5pt9PEaPr3iE4Xx443MObcCBgcQES0E6rmK8L2p+Yv/ebjK5A0RxYE+gd+9L05WdO0ypLpTPPqjMk5AIWHTfevzh5+4+caSQCHkBvryI25ijY5yrwLV62MAhWbm037ggz0eocPqv3H9jQUdOxYQT2lt6tLuDDhodl8bDsRcSWQL1ZYfR77Z1yvJGrEQ8+Ioc+XzEH0UU+G0kJSCVAvGBijMx5z8ZEakNOUo1Fgjxv8pcyZh3t4pDohrG3x7XAIIR52f5WHTrgNK3lEnaiQjc6Xvk/Sz8gJvl7qDrjm+xu225yRR8KCu10Qxg2SMZvpY26S/1l8jVezO+CZ251lHlQ==
X-YMail-OSG: K2S3LYUVM1nafRcMQdRRWOsLYJIWs0i33YJRUo23xxeAp0Io.FAt.J9IPbavkHl
 UsWHThbnU.RDAWti0h5iButJ_xmk3Px5PFZbOdzdQh.3ogpwftsZ_i3dkMLV6auulnLanbw2xyeg
 9ygUesr53QJ5J1bWepPbwGnXMaxqtWRpc3V3Ngcvvp6KPgVdkO_ktkTUzCBIs16N1J2CIGQ8bRgF
 h7WYsBGz03S7vIGDu6y9SR_m7tMhnPl_q.cnpztbuqEaBRQZdzCulhY.DThCfujQKoBUQXVpNMGj
 f_gE3nVHvJPLgdoSn5wsfA7lSDYhgs5cCPAeswRhRovbTJkaLz84TfKirT81IwSQEYf72SuCVkA5
 9ja35yWTg7Ezh14jQepn5fCog3vlISgUwpdwa_x8.HyKickp7mH1sSXXz7DA4sItneV3xOYbjRKf
 SynVkHvqjh9jYr0EIHc9oIJtKecYkvGDGlps2WHG2HHOT5tDFfY_.bpCGaP.LiAYopQAoCeMEvWJ
 PAqBzHpWkSEOmVOhnP21oB3TNK8V9BFZ9hxiA9ezi6fbvTmmAZGCsRkfrp3eA.GmRR36VTaggMq5
 jxPjsSPq_woW_2ItbECBqmZiDAdzrdQcIhUaONmB6lZpASH.lWjvNXJHe6bKRKdPIzZ5aWG4DALn
 QmoClqYCJzCnME1BlIRkQ4eayHbc382.xSpGgx48i4_hXEeOnoYKRmlvcn1AysD6U6z5uL5qbgb9
 KiQFWjLLGhwMAfcAfpEulS4bCQixkHDjkPm4l7Li_dS88k19xiawfPmgn9tVmJRsrKLBJPtyBUwL
 yS.TKhNeY7PWbtwUTX4lWdp6e1TaLIb4WCwm15JrxKsIBQcdEBqZX0mro8Wh6faTfDV1Ap8SOfb2
 1T.xbtTUWjDeJ0LllbajYoCEnkP8r75VkPURVu6cy2o_Qr.OGjaU6lRKekseRHWpsygwxR4S1.8g
 8EcbFfM1e4fNUvb0xHM04ataQL_KLPnXv6nYbhwnstI1uEnMReN6feBlCQqWtuKeReduWXbEiX9X
 U_OXiH05yo5Y7vGKbnUDN4SApgFQYd08NSE3H.VuoJDFHRZahQixLIAMtTgti_p1Lc49LhYDg10Q
 tuhBvNGL8tfwdHYuhhvS9sbOe19cuLm6KWU8KXC4nmyhRFed1jDRg4g1hPPb5Fyek15bTuq5e0Zw
 eiumTH_qdO2k1qQQK9rAnIu77BAfWW8CTnbXPZkkgEusxTwE_gynaiSYGpBeEi7VeTmzuy7pGjtn
 OQhFXH3_aCgaTbWIREzWE0yViFB5T4rqtIsUoL2cnsIfJxIO0Tx8tNDkWQpg36TFx.hJVLqH8Toi
 uOVgDuonfmrdvDow1FA8EspfPX_3sYFYJAp_ogxXRWhRFEfkjf1zmwVJE7Eub4n.L58VkmKdeXM_
 QuCboJolCYLdvpVL_bANyTlVbRtA-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Mon, 15 Jun 2020 17:33:07 +0000
Received: by smtp420.mail.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 1b5a5a8942e2d8d8f6c0b1f450585ba4;
          Mon, 15 Jun 2020 17:33:06 +0000 (UTC)
Subject: Re: [PATCH 4/5] LSM: Define SELinux function to measure security
 state
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Stephen Smalley <stephen.smalley@gmail.com>,
        James Morris <jmorris@namei.org>,
        linux-integrity@vger.kernel.org,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20200613024130.3356-1-nramas@linux.microsoft.com>
 <20200613024130.3356-5-nramas@linux.microsoft.com>
 <CAEjxPJ49UaZc9pc-+VN8Cx8rcdrjD6NMoLOO_zqENezobmfwVA@mail.gmail.com>
 <a9a20aa5-963e-5f49-9391-0673fdda378e@linux.microsoft.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <2df1bc4f-675d-7868-de5b-1256346f982e@schaufler-ca.com>
Date:   Mon, 15 Jun 2020 10:33:06 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <a9a20aa5-963e-5f49-9391-0673fdda378e@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Mailer: WebService/1.1.16119 hermes_yahoo Apache-HttpAsyncClient/4.1.4 (Java/11.0.6)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 6/15/2020 9:45 AM, Lakshmi Ramasubramanian wrote:
> On 6/15/20 4:57 AM, Stephen Smalley wrote:
>
> Hi Stephen,
>
> Thanks for reviewing the patches.
>
>>> +void security_state_change(char *lsm_name, void *state, int state_le=
n)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ima_lsm_state(lsm_name, state, =
state_len);
>>> +}
>>> +
>>
>> What's the benefit of this trivial function instead of just calling
>> ima_lsm_state() directly?
>
> One of the feedback Casey Schaufler had given earlier was that calling =
an IMA function directly from SELinux (or, any of the Security Modules) w=
ould be a layering violation.

Hiding the ima_lsm_state() call doesn't address the layering.
The point is that SELinux code being called from IMA (or the
other way around) breaks the subsystem isolation. Unfortunately,
it isn't obvious to me how you would go about what you're doing
without integrating the subsystems.

>
> LSM framework (security/security.c) already calls IMA functions now (fo=
r example, ima_bprm_check() is called from security_bprm_check()). I foll=
owed the same pattern for measuring LSM data as well.
>
> Please let me know if I misunderstood Casey's comment.
>


