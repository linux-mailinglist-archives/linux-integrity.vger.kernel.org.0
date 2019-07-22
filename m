Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B4B270B3C
	for <lists+linux-integrity@lfdr.de>; Mon, 22 Jul 2019 23:23:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731366AbfGVVXW (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 22 Jul 2019 17:23:22 -0400
Received: from sonic311-30.consmr.mail.gq1.yahoo.com ([98.137.65.211]:42859
        "EHLO sonic311-30.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731284AbfGVVXW (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 22 Jul 2019 17:23:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1563830600; bh=j0fHxuiHGkjVX0UiqNPd/ZL1UEvV0U83iudYzrh5mGU=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=tj9CbR7T6hs19ma8KyplWykr+xXHemjZ1g0yO7IdcExVISShcLW9U9QECoH1Q7Z2/jYkSOMSUtQL9f9mPKCXyzDuHcXo3gyn6lhr1CBas/aUCo86lOxAuOg0JMBbcIFmV+nOx+y8lgCJoDcxnmn2VMgiJ35OfJN5Df9gx/0Ij/GkT1FKIswFlP5ArTaSLQsZ9BobfGbpBo8xUiGxNIJ2kjgn+QZqm19MQ/9RSh8USmNQo91VArIPARGwCL8S1OcuB+4EufrQaMNOguyHQtnFBsfE7P/JRE/eibu3378EOPuPN/c1G4byLfPG3tP4TaCqkfkFMB3nBkQf4LMSqkHFEQ==
X-YMail-OSG: ufwvJ0IVM1nO6Ha1DElyPiC8aCFCQPjhpKdMnmtDDdaFMIW6UOx4DvxzxYzoAiZ
 JMqPUc3qG4ei09bgvF45vVOVSJlQq4_CUhYltW7ER.g8QTxZ2NqEiRPEc3r8_iP0doi81PX2VCTD
 r_og52OXs8CvPTfcyAV6.4sh0qyqjaifLchRNLFaMkhhP.HsLygX119QcSC9PnZEPpJTSht5z6kR
 6KwOVg_WS1xtPK0bO93SqN1m3HSWaaZbgalTiTmAzAW4s.a0adJYilMcYdb_Pxn.nIo1iIRXOI7G
 akYgp2.prN62XMnGWEw1YWiWkzYYkKaa0PAkbQFR5TdT.NSc5d0KhvSpLy1soK3u1lNaOzgNo1tm
 09j69Dp6nGe0YnPm04q7ZoGBTLNdYDP4bA9W9gc8Eez92PmTGpeVeFRhFwefDV7EcwY0cp_e_pjx
 SbB6SLDxQ5F0GmdeZBSv64qbA9zOcIWSNpzu30sqd49xSwkRhtcqhsBj6okzJYs4NPAT1cTggH4n
 jw2o34aiWgFfIox_Mm8OnNXp.z0uoweMCbJg_kHQHCzJ9ThyEoM2xwQkftRao5cwC3pLyQ.0f.uA
 N44HJTIF6mzJDf4394ATutygT8l588SmHEigdHaJAJmv5wItSVsPSInHkYuOVrFnY_NA01qJlJKc
 KHirVKL0yT0ETg54RUV2GoqMrBrEkNeJjBZRzoHRcbfl8vkPvCiAjIZ4Ky9cElvAt1XGXGyQ4sFf
 hYHjOTQrJxyrY_3uLfDzl0qGFIUDkCEO9Kzbwrr.D_F1uSenDmUIvhzOjz222IY6IqdV1CfFertQ
 THTDpM.Z1BxgDWJZ.CPoBGLUQKqEgI2.3kzcD4jdduurmWQo3FvPt0B2b9dXw.dn1_yft0Sw57K0
 2e.MgRhE1pprhd0r5gM3XqNl2LYecTJEQ0ytUN8nxH25aW86Cnvjt9nEiMP7DTLULSPWat6WXH_H
 09y0DTgTQYVQecsFvp.mDt4h_KL.eGXGPgE769mqOqwPuFcrWVfzMeEsJtqFWTEwIXY1uuaF900j
 Ir2T1Bp9V9c2xnZ7t3GTgR_4ezJdpjwlwiHcpoFFF5n_0De36JZsYd3_x7GevO_3vUTKzpbOQqZy
 RCiKGVnY7yfk_aEav5x_7pmoNMQdGhmxsGv3xFtitmwSHmoHUl3E1a2uBpMAYfEk_B_xjot7vgiG
 X7rqfLB1d1Mq.jHeJrCoMZ8iywU5B2Z9SLajgcFhfxbExvLc1uSnZ_JJ79rbYEUUNphjd2JbG37k
 gJuDYq.7vQM051LwUmGVp
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.gq1.yahoo.com with HTTP; Mon, 22 Jul 2019 21:23:20 +0000
Received: by smtp407.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 042937cc9a6e94bdae96c4890f3ecb90;
          Mon, 22 Jul 2019 21:23:16 +0000 (UTC)
Subject: Re: SMACK and keys
To:     Martin Townsend <mtownsend1973@gmail.com>
Cc:     linux-integrity@vger.kernel.org, casey@schaufler-ca.com
References: <CABatt_yn_yjw-MOUnrPDyg-ZQd1AjaHkcJKxNBo8STC9o2EGrw@mail.gmail.com>
 <165e3170-9b5a-7c75-9a9b-265ede62f55e@schaufler-ca.com>
 <CABatt_yS9m0nkqSzh_LwSDfc8wuubkXgiOxd6kgVKWuNjbFKuA@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Openpgp: preference=signencrypt
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <36c9e956-b821-0fb6-5a38-93285d341916@schaufler-ca.com>
Date:   Mon, 22 Jul 2019 14:23:18 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CABatt_yS9m0nkqSzh_LwSDfc8wuubkXgiOxd6kgVKWuNjbFKuA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 7/22/2019 1:19 PM, Martin Townsend wrote:
> Hi Casey
>
> Thank you for the swift reply.
>
> On Mon, Jul 22, 2019 at 5:25 PM Casey Schaufler <casey@schaufler-ca.com=
> wrote:
>> On 7/22/2019 1:03 AM, Martin Townsend wrote:
>>> Hi,
>>>
>>> One of our developers has reported the following audit log entry when=

>>> trying to add a key to the kernel's keyring when SMACK is enabled:
>>>
>>> Jul  9 09:33:23 mach-cw-rnet-ppm-1840 user.notice kernel: audit:
>>> type=3D1400 audit(1562664803.960:12): lsm=3DSMACK fn=3Dsmack_key_perm=
ission
>>> action=3Ddenied subject=3D"programmingapp" object=3D"_" requested=3Dw=
 pid=3D905
>>> comm=3D"programmingapp" key_serial=3D98475196 key_desc=3D"_ses"
>> The Smack label on a key is set when the key is created,
>> and is set to the label of the process that created it.
> I'll have to check but I thought that the programmingapp process from
> the audit message above was trying to create the key, the dev team
> were reporting that the add_key syscall was failing the SMACK access
> check.  This raises another question, we currently compile in several
> root Certificates into the kernel, would these get a SMACK label? and
> if so would this be '_'?

Yes, that could easily be what's happening here.

What does a "compiled in" certificate look like?

>>> I had a quick look through the code in smack_lsm.c but can't see how
>>> I'm supposed to set a SMACK label for keys or keyrings.  Is it
>>> possible and if so how?
>> There is currently no way to change the Smack label on a key.
>>
>>> We are running a 4.9 Kernel with not much
>>> chance of upgrading as it's a vendor kernel (linux-imx).  As it's an
>>> embedded system we are happy to hard code the SMACK labels into the
>>> kernel if this is possible?
>> In smack_key_alloc() change
>>
>>         key->security =3D skp;
>>
>> to
>>         key->security =3D &smack_known_star;
>>
>> and all keys will have the star ("*") label, which
>> grants everyone access to them. Not the best solution
>> long term, but it should get you by.
> They are currently adding a rule 'programmingapp _ rw' so I think this
> would be an upgrade :)
> Could I go one further and have something like?
> #ifdef CONFIG_KEYS
>
> +static struct smack_known smack_known_keymaster =3D {
> + .smk_known =3D "keymaster",
> + .smk_secid =3D 9,
> +};
> +
>  /**
>   * smack_key_alloc - Set the key security blob
>   * @key: object
> @@ -4327,9 +4332,7 @@ static void smack_inet_csk_clone(struct sock *sk,=

>  static int smack_key_alloc(struct key *key, const struct cred *cred,
>      unsigned long flags)
>  {
> - struct smack_known *skp =3D smk_of_task(cred->security);
> -
> - key->security =3D skp;
> + key->security =3D &smack_known_keymaster;
>   return 0;
>  }
>
> or is this just asking for trouble

That would be even better. Be sure to add smack_known_keymaster
to the list of known labels, just like smack_known_floor and
friends are.

>>> or is it set to '_' by design and we
>>> should add the key whilst the process is a privileged state before th=
e
>>> SMACK label for the process has been set?
>> If you can run the program that creates the key with a label
>> other than floor ("_"), perhaps "keymaster", the key would be
>> labeled keymaster, and you could create access rules like
> I will get some more information on how they are creating the keys as
> I thought the process creating the keys was labelled "programmingapp"
> so the key in theory should be labelled "programmingapp".  And looking
> at the smack_key_alloc function mentioned previously it definitely
> looks like it should have.  I'll see if I can get them to create some
> test code and debug why this isn't happening.
> Thanks again for your help.
>
>>         programmingapp keymaster rw
>>
>>
>>> Many Thanks,
>>> Martin.

