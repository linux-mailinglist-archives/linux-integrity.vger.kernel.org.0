Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B87E347D1C
	for <lists+linux-integrity@lfdr.de>; Wed, 24 Mar 2021 16:57:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236875AbhCXP4r (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 24 Mar 2021 11:56:47 -0400
Received: from sonic315-26.consmr.mail.ne1.yahoo.com ([66.163.190.152]:36684
        "EHLO sonic315-26.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236871AbhCXP43 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 24 Mar 2021 11:56:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1616601387; bh=xDPudSfWIoFuh/WpysycoNesdJW5JHizWk7sT05DCYY=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject:Reply-To; b=WSllSLmWa3tPwJkAjkO6gbT3cZIIWCVbV13d7Tfjd8IDtU0tSJ/pN5wh5Ah8Phd+JF5gAGPvWJ25Ys1zIUiPC2s0B/g11C6s6b6oY/YTVuKkYUxLEac+yrEkIJABm+gxJWAt/4QPtMZw5TSC2ThZGxmBiXYhllAXc9ds4n3o4r/qRmzTm6wms7Q6iukAZUKuO0eSMdtsjPK4oeCJ7o1+mObaoGbipd3sUjHo+xh0gcF0G8FcBl4bpCNV4vOMMnzpIr0h5g4nNra2vI5IWTr17EX5IYlB58rg7U0K31r7zAsCm2aYGWfufk5vcmeUQGgKmnzqs0fq/H81B9UcvdteAg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1616601387; bh=wMVD1HMzTZFHBDXvVZam0kP6uyWMdHLg+JNEPtVyb1S=; h=X-Sonic-MF:Subject:To:From:Date:From:Subject; b=ZYE9Y5rzoM1IWc2Gpm4w0cVAgyMz+6fr09p/bSFctSJiX8i26oGkoyYK6yVK0E0F0HcMshDnpKnhDpIacw1+sfopBaSBnGp4d/7twdcPxc+KZn66qBd0fu1TWM5aP/4pOxtKn8aBXLOd4GpRA2PyMperWfJgAFzYhxCpuEtxVRN/+ZTZHX3cv7iu2s5448m8cOXGoQQd/KuE0bhKwV9A+IKKbt4PF3xWdzkneU8egfBTHE+6QYcuYTX/bQhTOtcmoR8l2cM0dHtV+Ll6ECjlLtN8K1zQTTmRfYn2knbKaqYo1PfIf/yd4hp8+WBjoBhE7o/gwRlAjluv+woYN6ygzw==
X-YMail-OSG: 1LZNwUMVM1n8IMot1A9vD0XTryNisJHBVUi3.K0MefinOhNJ7L2OgyjDsns80GL
 fT7vM.AP0I18z2nZ.OfoSo8oS9FM0CCgEzVN4Bv2DOw4kRKGfNZ8tMzq5YRkRTEAO1u_ptMzX9Ly
 Mn9hkQYv27HmXVALC5sC8NEe9V8u6tMqi7L_YYNlPyIpH4CfZxdGOVvq2ERh0gGwR1rw3DjGLWOu
 BVI0Ao0KcagafFEazETEccoW5g7Yy.N_vFOJqa3PW4yMOrUf.m1hbl_fHYFQCc_HpzOXt2bQvALl
 7D1hCZhkessnCj05YumPoFlWZRQo8F3oVS.jOySoRM9JVFJ7BWEwvlONbZC6SGXfksde3Ms3S6BJ
 L3Wl4yAgADR1mCEPMJclgpWAXA12k5w8EqeRUkTpqIR57IB7TM1KhHPmurcyZFgtJybmu6qnSKC5
 cnXOiBkflQYVq8KH2fitRfXRotJUpHjY.xkKKaLjUJ_g_y.PGxdgNOd8xSBds1aq6dWdhdkWkogl
 DZBeOTQxnsYrCSkL1gWCiG4SQQZSFSOOibSzFESNRZIxc99oIzDfcXxmVnC9PC1hr7Ahr0asd7RC
 P4vebO_rbS5GFfhp6ChttLwLgARhyq.EHZyM6zYAN7HQFGKFzMswwQSvwfnllH0TzLYOQEHURxFP
 RUM4yZJ8ocq_2vy4aGytmOdAjMRlsuxHHtBRRJqrJWC8U66oz1DJFzZYqfkUZrID8xq_r3MhJt6K
 .IdhhrbA4NC0Q2oSkK2bebCJzdBdN9KFjUi1b2apI6se.rQ8WeC_nwu_a7DPMixsWH7Msq_XwqHu
 spVI3pvVEBlpsm5pjvNWo5A1XMsldoz1mXAyMTQQTUcdwb87fDhxXlJ79VsEN.tzHIOSlo7.vZ7.
 pEI8c4Cojay5D9s5N44YscQlrAhy6jTPUPE.CxFPb3RuCsjG3e024A9Zo.mLK85jj3nolrmsN7gm
 uOuber51QChYiAjgEeQmd3lnFJSJGfr0eQHPpyy1LOZAvOvvfjaWfvR0dHX77RTF6bFtPPIEirzu
 649J7Ezmrv4RYEiWL4Q3OqOB6c59O3Inq8rCKvqDsHezvkLuzk_YgAZBLdWI3Nt.GO7ahYIq5xOn
 _hkaM0.Ydg2j32ZPFXAbyEHex.9Urv25jwKc29.awwpAtCdvPovYHgYSCA2.gkQWAMfVBTSmranD
 rY7hvVpgoA0D18yAWzsGlirOEnnYq8wMBfhuv5vS3v8gVnRBjJUfUjrucwZCKD4YPSrZ8U5LulM0
 4v76j4.lHDTwNGjl2dpANZ5btOu7kVldgbqjXy8GgAyXIkWfkQomha9DC_NK7gJOv5A6R4x7gPnF
 xLlpHF6evPkXY0rIu3fZT3MhHBgW9nk6hqoRSuNDkhe0QKdCwWUplmHEU69AFTqySFcSs1N3PuTt
 cvg4XGlF2BSDHkETpX8iCPHJvm_9VKLK2xBW2l3j_kquqIqImdiOEDEWlXMy9ppbrXmBfutCUBqR
 4VEBE8Am2RZBleSnAPhHcWXxVZ52yNujjtKktB3xWi61k2RhRCQzbYdhzWTW42V6A6FWkRFVsQ5s
 GceB7IiFi3tIVjZ9om_g7QhakU0gmI6h1h5f4Fe2xqiRmvOUAHFhr16rhpdYDBAIgVqCJps8F2N3
 Oj2niQz.VywmszK8ohIkaza8KOWGPaGowDL.5.q20XuLc2Jrqi9YbVlXaLNUM18IAX.7x7z9SCCv
 oAXemnVhbJYSHhx9obVgMc00VrCvI5cZsk.IOADn7zqCsA9cRsMWjiHzIc0.DUCH3tuQ3yz_mOjW
 KfP_efDauCmMZ1sllrZt6.ELvk.E5jKUqIFYYGeL2y0KmVysyst0G.x_rJFnegLJPYeC448CX0cx
 i.oRRbqwRzOXKFSFs4jDQt6fDLN9qI6KX9jCbR.90x0JZrveifs_Lk1I8DluORVYxivMgjfKIV5.
 xd0Whva7HZThEvAmTggwH9CVvq3TS3W1JWf2OdCdm.sF3IjwkR_bnklbP3414j6xZqLOGcPuauBT
 3UV8ux0phHHAB48ZPYfvfOMFqmh_nlV7afmInHX0lkws0hlyGBPDf20qGZ9hMbUh7SdY0DQHrXw9
 .auFUuk0k1S8vLpPJICtuHr1UHxGTD37T.yapD9MgxC3rMUVwv_ih85XcvfRrCIqjuD89qSOOLeR
 cWLrN647BWgcu3foz08Tyh7Ul2AdiBKFYTHCyCwqgz0NfM8zkt5eUYeR99ju5PJj1qSyG2dpx0ce
 loO80WGN52n2WZhBctJCYJ8UPporVcNUrmfRW5PIPAvSTV2wQZHucyBk8wnnbSJeBrnAGGDJhbED
 bpXutUFMRN_S17Ns_4YaPEZq9VCpFv4M4uXtZAEB4oEltMG_4XiGtD_wfq3Nw38Zqsbg5JpxnPKr
 w47_xIkbE8aBdXuDuvWeR6NHAgT34yutqOIpkBPPAdQXjTlxhcwC5psJ0CSusXXPkxT1LmE9LndA
 Ot3sBXw2wLmdzIs.ZAZt.vazA003BqD6WmA5i3GHEXSrfzSyestuH0VWPNC8HIJwGMuiILRIfus0
 impb3VDPN8.qmM2Gvt0mf75T6gpIXriJsbV439EPQGhbTAHsE5OoltSVJa7fts5ZeHOeMUMCQH3b
 O343LJmqdsYOUXv3_0xN6Pwi5EkB.I.7DfLvDdeXQ0pxh8l3WQNiuqggago65.mSvwB1RQXNmcTI
 vk4NIWfaYTvI.IGYOVPlp_xjLavGzOJsxmDLorBPoHOcWkVMT7BR7Vj20pFIE5i4DGK8UTIu0KM8
 CxLWvY8r0u8f0A5I2E7PQaHaQAhsaBOKpkkukmL1rxqWOv4LJtfB7.R9vy.G3a1W2Hi5hCXyCjA9
 j0E8kVgmr_B5wSu3P2RECvXn7J05KB600Z_uJzG1IhQ_TMZrH9NbGxvAVby4K1HzAB0_BMoJPN4.
 9iv.wfN_6l7.36vUb98tjoWAb66E3BLrG6SWtuI9OFcMFrRGJT4bInEIo1Mrar4UJRFttSi44wHF
 31Yapveycro0jTMqG.IeXUDPLqK8FV4wKFLBnCtsiIbqu3YRuGJxVrgKB7avWNvcNUus9288oZ4z
 YkxDvB9oLlbhQRcmUOS4.HS9lxB8XJ7BRyhM1fYWODP1.LosDP6EiuVXSZtqeint0UA9cPdAeURu
 .WgbMXPh88SF.EehSEM6gev2Ntx4jQwOz5KFFuw9q2TFAB56s1qFQSMr76XF93A--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.ne1.yahoo.com with HTTP; Wed, 24 Mar 2021 15:56:27 +0000
Received: by smtp418.mail.bf1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 0b0bffea6e5e1e961d0e75e227349197;
          Wed, 24 Mar 2021 15:56:21 +0000 (UTC)
Subject: Re: [RFC PATCH 2/2] integrity: double check iint_cache was
 initialized
To:     Dmitry Vyukov <dvyukov@google.com>,
        Mimi Zohar <zohar@linux.ibm.com>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-integrity@vger.kernel.org, James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Eric Biggers <ebiggers@kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20210319200358.22816-1-zohar@linux.ibm.com>
 <8450c80a-104a-3f36-0963-0ae8fa69e0f2@i-love.sakura.ne.jp>
 <CACT4Y+bvakfNhVs29QvbY6Z8Pw0zmAUKGWM-DD5DcPZW5ny90A@mail.gmail.com>
 <1a2245c6-3cab-7085-83d3-55b083619303@i-love.sakura.ne.jp>
 <8039976be3df9bd07374fe4f1931b8ce28b89dab.camel@linux.ibm.com>
 <cde00350-2a18-1759-d53b-2e7489b6cc0e@i-love.sakura.ne.jp>
 <8a8763a7-eeeb-3578-d50c-c15919fbe1f9@i-love.sakura.ne.jp>
 <3ed2004413e0ac07c7bd6f10294d6b6fac6fdbf3.camel@linux.ibm.com>
 <cc01e7b7-d685-289c-a792-fc76fabba807@i-love.sakura.ne.jp>
 <721b4f8d38b014babb0f4ae829d76014bbf7734e.camel@linux.ibm.com>
 <0a0c5cc5-0e1b-ef01-60c4-5247af2124f4@i-love.sakura.ne.jp>
 <37aeaf361bfbd800e29db761f5160f2ce1869298.camel@linux.ibm.com>
 <05ca20d0-9596-152e-4da2-1ffe28c52055@i-love.sakura.ne.jp>
 <CACT4Y+Y+wzPytH7hMAn3O6zT0p2D4UyQwDbuKbUqc4REzPECkw@mail.gmail.com>
 <ca2b63a47c2910072397d41448c46293750456f7.camel@linux.ibm.com>
 <CACT4Y+YatH2MHMh5s1KJtb-5w-RvmZPtQyRZqpVk=YP=HJYMkg@mail.gmail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <cff37d9a-67a4-773b-6a56-313a369f4a11@schaufler-ca.com>
Date:   Wed, 24 Mar 2021 08:56:18 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CACT4Y+YatH2MHMh5s1KJtb-5w-RvmZPtQyRZqpVk=YP=HJYMkg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Mailer: WebService/1.1.17936 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo Apache-HttpAsyncClient/4.1.4 (Java/11.0.9.1)
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 3/24/2021 4:58 AM, Dmitry Vyukov wrote:
> On Wed, Mar 24, 2021 at 12:49 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
>> On Wed, 2021-03-24 at 12:37 +0100, Dmitry Vyukov wrote:
>>> On Wed, Mar 24, 2021 at 12:21 PM Tetsuo Handa
>>> <penguin-kernel@i-love.sakura.ne.jp> wrote:
>>>> On 2021/03/24 20:10, Mimi Zohar wrote:
>>>>> On Wed, 2021-03-24 at 19:10 +0900, Tetsuo Handa wrote:
>>>>>> On 2021/03/24 1:13, Mimi Zohar wrote:
>>>>>>> On Wed, 2021-03-24 at 00:14 +0900, Tetsuo Handa wrote:
>>>>>>>> On 2021/03/23 23:47, Mimi Zohar wrote:
>>>>>>>>> Initially I also questioned making "integrity" an LSM.  Perhaps it's
>>>>>>>>> time to reconsider.   For now, it makes sense to just fix the NULL
>>>>>>>>> pointer dereferencing.
>>>>>>>> Do we think calling panic() as "fix the NULL pointer dereferencing" ?
>>>>>>> Not supplying "integrity" as an "lsm=" option is a user error.  There
>>>>>>> are only two options - allow or deny the caller to proceed.   If the
>>>>>>> user is expecting the integrity subsystem to be properly working,
>>>>>>> returning a NULL and allowing the system to boot (RFC patch version)
>>>>>>> does not make sense.   Better to fail early.
>>>>>> What does the "user" mean? Those who load the vmlinux?
>>>>>> Only the "root" user (so called administrators)?
>>>>>> Any users including other than "root" user?
>>>>>>
>>>>>> If the user means those who load the vmlinux, that user is explicitly asking
>>>>>> for disabling "integrity" for some reason. In that case, it is a bug if
>>>>>> booting with "integrity" disabled is impossible.
>>>>>>
>>>>>> If the user means something other than those who load the vmlinux,
>>>>>> is there a possibility that that user (especially non "root" users) is
>>>>>> allowed to try to use "integrity" ? If processes other than global init
>>>>>> process can try to use "integrity", wouldn't it be a DoS attack vector?
>>>>>> Please explain in the descripotion why calling panic() does not cause
>>>>>> DoS attack vector.
>>>>> User in this case, is anyone rebooting the system and is intentionally
>>>>> changing the default values, dropping the "integrity" option on the
>>>>> boot command line.
>>>> OK. Then, I expect that the system boots instead of calling panic().
>>>> That user is explicitly asking for disabling "integrity" for some reason.
>>> That was actually my intention. The prebuilt kernel that I use for
>>> things has all LSMs enabled, but then I needed to try some workload
>>> with only 1 specific LSM, so I gave a different lsm= argument.
>> IMA/EVM is dependent on "integrity".  Was your intention to also
>> disable IMA and EVM?
> I think, yes... or not sure. I was trying to test a bug that requires
> a different major LSM and all minor LSMs are presumably irrelevant. I
> dropped existing lsm= arg and added something like lsm=apparmor.

This is the legacy case that security= supports. If you specify
security=apparmor you will get all the "minor" LSMs you have compiled
in and the "major" LSM you've specified, AppArmor in this case. This
is exactly the behavior you used to get before lsm= was introduced.

>
>> If so, when disabling "integrity", don't load an
>> IMA policy.
> I don't really know what this means. I guess it simply comes from the
> image? If so, there was no easy way to avoid loading.
