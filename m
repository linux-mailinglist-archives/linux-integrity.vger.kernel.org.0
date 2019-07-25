Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02BDA75844
	for <lists+linux-integrity@lfdr.de>; Thu, 25 Jul 2019 21:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbfGYTo3 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 25 Jul 2019 15:44:29 -0400
Received: from sonic316-12.consmr.mail.gq1.yahoo.com ([98.137.69.36]:35267
        "EHLO sonic316-12.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726251AbfGYTo3 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 25 Jul 2019 15:44:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1564083867; bh=viU3v59tbm0K7D8mwWUxMRQV+1UTSDsYdoIrKz175P4=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=FC6YA2PSZbbqheQDqRF10PRuzGCh8gPUS8j6eydX5MEyoyJfw85GcvKd2PfQ9CighqZPIQ5oUuLBBt3S2C7rPURejyri1UlIKQLFdUq0VYMYn4d8H1kql3H5MTLRc0wiXjY4Yi8eMpz4POsAW00DcsAu9NmWeTHjnkq5Fwdgy+5jFP1Dia20OID3y5MJeJRrhQrGAOHlXL6epDkbLVxPPGvPEKJUjcxApnaDFUcCQ1T1W0oYUOQ6x6CUFQEbar67RgJ6E+eFsKWpv37xczzOI0F+2Ng7LUsbQGnTTAw4+xlVQl1EKUAPGh+6IxSjftd1UN7lIfDVDfiyQZFBNj6WRA==
X-YMail-OSG: ZGaPdJMVM1l_jM3MvTIhVscIZbxESqng6ysYwo.vpKviAnsuf795HURdh4sJ3VV
 ZMBLJPwZpmtFOkxqh1IMuGRapRDC9lRo6VoqKjrmErK_Zfh__tUO3Uys25Zf21T1DQvDVKhQciip
 MRqia3.wIsKcvqdWF9whPxiPL99EBNOHH4oiNy_BL9o1BKGCMuBokKHzsrusF5TweaOsthyBqvmv
 ynXlj2XEhrzMLKSEHZi3vmgc7.2_QticeAQNCxjTPVumaQ26Wn1vzHClS0N9xXroEXfYLmB8EuIF
 _xoyLcsvWh8ZfdIQnQMHNRb0mQPwIV3L9dsC_mjJyxLyheMjCyZGYqfrlSacqdSEtLb.LlaUuGsW
 hJd3fGRnwq5fuZV2oEK1W4eCYNSnUULozJ8sWd_yX8UeiCS9EICN0oSz9RzFRlY_jas8dQA2NpLP
 VRprY8qUq2xPHtwZZ1Ot3l8eAvYDKIK8DqYYARuY8iuGznGpzSylelK2m4.kzoOr9C6gcUIoLign
 wwyLleJ6UyWdYNJp.p0iVu0zH82pggB5zNLr0qwsHeexOHHOyEVQQP2SmoPcH4.YU6dqEYsHXIuX
 1hsvho3C3Udycfipw3_rSkp.TUV3qdlnM.BvK2fNX0uwSYg5duEqgA72ICf.oxG5_zdi5zQKX10e
 Tm3tzqa5R_.JlKwkHLca1RPeTS6IiAqnTxrLbjWNdY_p6Vzhox0N68FhvAT5dWd7nTw3OKpsqwvd
 TItW0vo5qBFgl.H6Rbx_mddmT_XnBZ6PkMzH18uOUKWo0hk1PO7x7UdfRcNs2NQmsWLWn3PZfxG0
 XJyI6Dm3AyBl6tBaWgmx3pfu1Nyp2ehjd91o0MZxy1PQOYkPW3R4oosSwQlx38y3EnofgK7Rfl.o
 9tlK5AJCKpz2cM9ohIj7AxHUaPbcWAVq_LC4iZQa_2lueJyrqtIz4Cs0GFeJ3uyNhQ19AfnxG7ol
 ekA9YNDLTxNqJbIY8HHEdtxyFtvWsvKvxeggzPhgDYBiydJHdebKuv5IAxkvUEO6mRR__ErWprnf
 FvFLNNlXEnYQyy9j0vyGwkhL1yGqCMG6Wp6BYwzA3hOQbLDhhzck1DGaAfaRTOgZLFp3o42og2Xf
 vC4wpN_3u.OGt1113Ql3k6VqGptcXNlDjiKCxyhC.oLk0.MlLzzw8zifpQMxX.9gvyPQsa9R1epa
 2eQEWFSbtP3LqSrwo8FBJRT8M4d8.fEAtQ76Vd9mArlXrPEo3TTmfkBcN593GjnQRJboxuo7MHR7
 ZiRcBB5I1TiUuOxaUlq7t5A--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.gq1.yahoo.com with HTTP; Thu, 25 Jul 2019 19:44:27 +0000
Received: by smtp418.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 3faaa6cdfba1f9dafd393a64ca0281b1;
          Thu, 25 Jul 2019 19:44:25 +0000 (UTC)
Subject: Re: SMACK and keys
To:     Martin Townsend <mtownsend1973@gmail.com>
Cc:     linux-integrity@vger.kernel.org,
        "SMACK-discuss@lists.01.org" <SMACK-discuss@lists.01.org>,
        casey@schaufler-ca.com
References: <CABatt_yn_yjw-MOUnrPDyg-ZQd1AjaHkcJKxNBo8STC9o2EGrw@mail.gmail.com>
 <165e3170-9b5a-7c75-9a9b-265ede62f55e@schaufler-ca.com>
 <CABatt_yS9m0nkqSzh_LwSDfc8wuubkXgiOxd6kgVKWuNjbFKuA@mail.gmail.com>
 <36c9e956-b821-0fb6-5a38-93285d341916@schaufler-ca.com>
 <CABatt_wPccEg=xpb16K-XDHXOzvbwVapNTE_XhWbQBghJNYZFg@mail.gmail.com>
 <CABatt_zcFXOFYqLBcaZzuMewKp9EmqnUtsGB8H9gr14ui4xB8w@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Openpgp: preference=signencrypt
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <459451d7-d946-9c9d-9e7b-3ebd710fd479@schaufler-ca.com>
Date:   Thu, 25 Jul 2019 12:44:25 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CABatt_zcFXOFYqLBcaZzuMewKp9EmqnUtsGB8H9gr14ui4xB8w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 7/25/2019 8:07 AM, Martin Townsend wrote:
> On Mon, Jul 22, 2019 at 10:35 PM Martin Townsend
> <mtownsend1973@gmail.com> wrote:

I'm adding the smack-discuss list to the thread.

>> On Mon, Jul 22, 2019 at 10:23 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>>> On 7/22/2019 1:19 PM, Martin Townsend wrote:
>>>> Hi Casey
>>>>
>>>> Thank you for the swift reply.
>>>>
>>>> On Mon, Jul 22, 2019 at 5:25 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>>>>> On 7/22/2019 1:03 AM, Martin Townsend wrote:
>>>>>> Hi,
>>>>>>
>>>>>> One of our developers has reported the following audit log entry when
>>>>>> trying to add a key to the kernel's keyring when SMACK is enabled:
>>>>>>
>>>>>> Jul  9 09:33:23 mach-cw-rnet-ppm-1840 user.notice kernel: audit:
>>>>>> type=1400 audit(1562664803.960:12): lsm=SMACK fn=smack_key_permission
>>>>>> action=denied subject="programmingapp" object="_" requested=w pid=905
>>>>>> comm="programmingapp" key_serial=98475196 key_desc="_ses"

Why does programmingapp need write access to the key "_ses" ?
Knowing this may help identify options.

>>>>> The Smack label on a key is set when the key is created,
>>>>> and is set to the label of the process that created it.
>>>> I'll have to check but I thought that the programmingapp process from
>>>> the audit message above was trying to create the key, the dev team
>>>> were reporting that the add_key syscall was failing the SMACK access
>>>> check.  This raises another question, we currently compile in several
>>>> root Certificates into the kernel, would these get a SMACK label? and
>>>> if so would this be '_'?
>>> Yes, that could easily be what's happening here.
>>>
>>> What does a "compiled in" certificate look like?
>> It's a PEM file of concatenated certificates that you copy into the
>> certs directory I think and then set the following in the kernel
>> configuration (in this example we have a file called
>> builtin-trusted.pem)
>> CONFIG_SYSTEM_TRUSTED_KEYRING=y
>> CONFIG_SYSTEM_TRUSTED_KEYS="certs/builtin-trusted.pem"
>>
>> I'm assuming that the public keys contained in the certificates are
>> added to the kernels trusted keying automatically during boot.
>>
>>>>>> I had a quick look through the code in smack_lsm.c but can't see how
>>>>>> I'm supposed to set a SMACK label for keys or keyrings.  Is it
>>>>>> possible and if so how?
>>>>> There is currently no way to change the Smack label on a key.
>>>>>
>>>>>> We are running a 4.9 Kernel with not much
>>>>>> chance of upgrading as it's a vendor kernel (linux-imx).  As it's an
>>>>>> embedded system we are happy to hard code the SMACK labels into the
>>>>>> kernel if this is possible?
>>>>> In smack_key_alloc() change
>>>>>
>>>>>         key->security = skp;
>>>>>
>>>>> to
>>>>>         key->security = &smack_known_star;
>>>>>
>>>>> and all keys will have the star ("*") label, which
>>>>> grants everyone access to them. Not the best solution
>>>>> long term, but it should get you by.
>>>> They are currently adding a rule 'programmingapp _ rw' so I think this
>>>> would be an upgrade :)
>>>> Could I go one further and have something like?
>>>> #ifdef CONFIG_KEYS
>>>>
>>>> +static struct smack_known smack_known_keymaster = {
>>>> + .smk_known = "keymaster",
>>>> + .smk_secid = 9,
>>>> +};
>>>> +
>>>>  /**
>>>>   * smack_key_alloc - Set the key security blob
>>>>   * @key: object
>>>> @@ -4327,9 +4332,7 @@ static void smack_inet_csk_clone(struct sock *sk,
>>>>  static int smack_key_alloc(struct key *key, const struct cred *cred,
>>>>      unsigned long flags)
>>>>  {
>>>> - struct smack_known *skp = smk_of_task(cred->security);
>>>> -
>>>> - key->security = skp;
>>>> + key->security = &smack_known_keymaster;
>>>>   return 0;
>>>>  }
>>>>
>>>> or is this just asking for trouble
>>> That would be even better. Be sure to add smack_known_keymaster
>>> to the list of known labels, just like smack_known_floor and
>>> friends are.
>> Thank you, I didn't spot that.
>>
>>>>>> or is it set to '_' by design and we
>>>>>> should add the key whilst the process is a privileged state before the
>>>>>> SMACK label for the process has been set?
>>>>> If you can run the program that creates the key with a label
>>>>> other than floor ("_"), perhaps "keymaster", the key would be
>>>>> labeled keymaster, and you could create access rules like
>>>> I will get some more information on how they are creating the keys as
>>>> I thought the process creating the keys was labelled "programmingapp"
>>>> so the key in theory should be labelled "programmingapp".  And looking
>>>> at the smack_key_alloc function mentioned previously it definitely
>>>> looks like it should have.  I'll see if I can get them to create some
>>>> test code and debug why this isn't happening.
>>>> Thanks again for your help.
>>>>
>>>>>         programmingapp keymaster rw
>>>>>
>>>>>
>>>>>> Many Thanks,
>>>>>> Martin.
> I created the keymaster label for all keys and I also had to add a
> rule of "_ keymaster rw" so that the kernel could setup the built-in
> trusted keyring and it boots fine but then we are seeing lots of
> processes failing with what looks like integrity checks and then
> messages like
>
> Jul 19 10:11:15 mach-cw-rnet-ppm-1840 audit[1572]: AVC lsm=SMACK
> fn=smack_key_permission action=denied subject="ubihealthd"
> object="keymaster" labels_differ pid=1572 comm="(ihealthd)"
> key_serial=20092166 key_desc=".ima_blacklist"
>
> Jul 19 10:11:15 mach-cw-rnet-ppm-1840 audit[1572]: AVC lsm=SMACK
> fn=smack_key_permission action=denied subject="ubihealthd"
> object="keymaster" labels_differ pid=1572 comm="(ihealthd)"
> key_serial=694943947 key_desc=".evm"

Again, what is ubihealthd doing that it needs access to keys?

>
> so I'm guessing that this means with my change I would have to give
> every process that reads the root filesystem a rule for keymaster as
> the main root filesystem is signed with IMA/EVM.  The default of '_'
> I'm guessing would have the same effect and we would have to create a
> rule for floor for every process?  I'm not sure what to do next except
> if we can somehow identify the ima/evm key and give this the '*'
> label.  For the moment we are going to assign all keys '*' so we can
> proceed.  I just thought I would report our findings and wondered if
> anyone had any ideas?
