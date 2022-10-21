Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FF65607A1C
	for <lists+linux-integrity@lfdr.de>; Fri, 21 Oct 2022 17:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbiJUPJQ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 21 Oct 2022 11:09:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbiJUPJP (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 21 Oct 2022 11:09:15 -0400
Received: from sonic316-26.consmr.mail.ne1.yahoo.com (sonic316-26.consmr.mail.ne1.yahoo.com [66.163.187.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C330526103
        for <linux-integrity@vger.kernel.org>; Fri, 21 Oct 2022 08:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1666364952; bh=5nPK+V+RCvjFoZEW5zbjeDnfOYHm+iEgYVpG3f56v4k=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=SMbHPnFflf4+sPhHobkWfp1M/Erd5ttFva+1DKZpSb+MyVOHQvpXA1gX7wVpK398jcOpCJG3F3/qQit8yTMlGGEV2PcK1iWrqwt5U3Q9n5sRJoUWm7QSUt6l2o1jszRLyEB3iUIJJvrC3uMOuNl/3dZi5RfuVCVUpyKcGr+d+R8/BZedqMdeIE9MUoExNIEOwpaiavXDAzE5eKdR2hYRWw6fXdVHYMu1RCIwOBtyCbgQNH++NMlz2S9UUoXq5dqzbPbGnvuRe0gZIrD9AYjEfrtnD8KWX+MnwftJGkO5KGdAuXxg0n2MdhQMCbg7/aAAbwyxMZfS9s5mNT7qRSanaw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1666364953; bh=/uK1CRViwXvgmXLllzd4T/LIsx1kcEn2CHHOFM/TEQt=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=Gy33Y65mHtxokFOrpKsiqgTnkd3A4KjliyCg/+TaBmjv09eiPKieWCRPOES7a+sMXOXRNSxdnoP3fi3RTBGq7vvyW+gyvkqk0WRIUkSW0/OnbitgMu2bBUINo4Kl1EnVtXV3qcYJ+8GShsJNMLlffLZ3RYFJHD3kZPksT0+aVm4ADQ3vwqWqa5k/GCZ58cxm6TtfWMpjCMQjyfDon+FOTS7wCV7V7ZE5OJWM+5PQmN0ks8GNBGrwIdq4KScvieWVPu6wcK+BMZUSRHT7proohMl9pKy2qsxojxG4DD2ESpl2mkjtQ0Gl5P7iKH2H/9pXkoHy8VchSHxvvjV9O6oa2Q==
X-YMail-OSG: eP2yAv4VM1n5IRgcq.gtnmxNtyia9zays1l_qNuu5M72xhg2a6NG4nvrFkEvK7Q
 zfFvoJlA34u5r.jFWPK4jvEYw3DMLUzC3VyFi2375QYKS1nizfDxr2Qvxu1whqb_OCH2uXGSWOke
 0TwwQRAx18ZTyHYCAFLYksVsByjrTKqH0of9qYhtpxrrVvVqhvtVr7wub_EngSuWK9zdhi9pBdHx
 rhnRfuMr8oXW5xMHysF3CGmqQoD0YJrhW_.uqN2C.h44rVzRypnwvVfc9VecAM32gV5eg_hfqKb1
 mzraOSh3_sKysHIEiL2_yQG90Bm4CEcJaqcKus4NvuU4Rs2SjvHp3o61DaVIqIjFSqNDgF54c5rU
 RhSngecyh6tXKynVV3iC5CD2Gg3Qsbkej9ef3AW14uH2v_92rxJ2iM1GZIHJvI9bOsGrO6SzTTsI
 kK4kYp0kpdOPLA4MsM0rIz.ZF3kl7PvWofny3eEeRB8aC2shH_kTQRLZVwGxE6e_.o8RDVy8fVH6
 vpi7Df.L7vabX3c_uIeJf3FyYtLw_ztnRw71s2kXwS0V8_SLRxkQCanaKvSATwqRiSZAnlHpSyLo
 WpGOaHSS4BV7e12YnFAXybejZzrlXxnDC.QYzaPe7F2oIvAq1NqABHrcaT8_UugQXXK54dZn7atN
 9ynUq9UvjcYLufvhVPPN5UYGKy7UqwrFJ_c4N7QPB9ZmDWUd8oPqDypFMy3qG2f57q3JdU2GtGOk
 gYtM1G8vjZP7bWrUOb2a2XAHs..g2YYuXrLA1IPPd5gJ6RCwsD.HxEhU7l3m9QYfPvYockdeTMAu
 ZR9Q0DevBmrKMlPuv1.LwnYfVUQUrgJwPKmltGGOlkYnM5LmVyuzbbzC3N74gojKT2RcDxsF4q7Z
 N878anZNwV893mBJQhs2rkUQXg14pnX_bCvNVH5K8Ykd4ep.bkmU9sa6HU3NVsItJNakC3DbLSjt
 fVwdK1bP1YkhmB8vCt6EvN8hACU9IGEtRsO51FW6FxN9Tm..rKxsMFUP1KcZuvZPj0dEXuOrkvug
 Gpfe6lIeJYQBY5.z4C7oMk2LP5YSr72YwT2MoRglqWYlVx0PiOrpyVUTDz1rDKbOZkhtjikMN31e
 tHda9ddIZf9BzQM7WKxfR2JVYZMwxhHVNVhRcsr3QhbXFdT0O0ruc2HT3mygIqjoH_fo2efUMo5C
 vlO_6qG_HfpLaU4Bt6CSWXlb6yBJghsvyPlSt9kSzOdtIW8.yREmg69CX9BSWF_EZGST5DanJ_tv
 hdSq0WNDQvY9.WuE96IuVmNMprXBTw6rkfZ3Xobf0BSEmYGB47RPvanYvhjhwvSCKfV55LxzhIA8
 EHKbWPXlsaOIjit5Kct9vpHlSk8Ux4BocsZV9PJRkFTXqgRqstHXIVDZM6tPLy4s9vPnazKlavz1
 Emd9XUirlMzKNSGhipgnhaqO9uNa2Ltuwz.ee4zExp_iPj6auaM7lrKmcJheXnGr2hzG8OGyOrd0
 IPIv0pArK0MwV154wvdEIjYup3.Nh7xV6.CS7bwC8WHo7eK3ow1XhcG7bx.oLNTcuLqs7W8zMGW7
 E1CWuwLOcZX_8ypQEHqYcb3tvrfv_WTQEqSNl2EFOf1A6sRFN7i7svekCgDzmVor7Whn4PoLRsJv
 TqiVBqE701n9AZ1uO8m5vg_HoF6L8Nc7kBhUZB3GY58Ao8p824YZtw_QZdDAS5cu5FDsDePJZeWd
 T4i_4ixXzbYrEAaZEBpBvn7wKLthqS7TbpjMOus62ygLLYE2DjQ8mZ3RMnduTND4.YmA5RfrxQyG
 Bj3MNwU7wWUxb8iMqvBhEHy_QryvnuBZz4GpFn1niYzW.voTQ8qZ.trvE6gMPmsfvsEHhmFgz353
 U7eqUHBET9cjfc3YzcJBgSrOuMHVu0h5yaNRA6A3WcToykmmt9EaZ8PLoyOIq.XiUqrYsPHktnlg
 cStTltoKM7ghkvrm_OOjVSJB7HOsbhokBL9gZCDERStTDsWdbS7XdMBZX6EZrFGVhbXoxWtizIBJ
 eyGwiODk.2SVLLNzMiQlOY17vbs5XARtgO.OTjRiwIMPS6knenCGMvWqVGWT9MNX11Dw6HFakXN0
 nGbTDkNCZbn0N5cryGtogSr6PWUtaLAUIXlgmsOJGcm5rzz73_AEl2UahYlqEk8J_MIc97L9axsE
 7AhavvfwLHQwgAyHLZ3CjfEXg7UTGY5Y_V7RbXJ4AUNGpWplCUsuAfhE4RBkEpzJ7Xiaq.pbqtbJ
 V6IG8s2XK82cyh_soGsltabI1tpENg77fdxs8FteOg3V1CkJ4bnFuFTeEfwpRxHr3bB02THmtI.h
 OihNrVId24Z9X7g--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.ne1.yahoo.com with HTTP; Fri, 21 Oct 2022 15:09:12 +0000
Received: by hermes--production-gq1-754cb59848-jk2dx (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 7839a2d21e18f0740fb3ec907ad162ce;
          Fri, 21 Oct 2022 15:09:08 +0000 (UTC)
Message-ID: <643437be-761b-a281-293b-6844a6d6196c@schaufler-ca.com>
Date:   Fri, 21 Oct 2022 08:09:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH 2/9] security: Move trivial IMA hooks into LSM
Content-Language: en-US
To:     "Dr. Greg" <greg@enjellic.com>, Kees Cook <keescook@chromium.org>
Cc:     Mimi Zohar <zohar@linux.ibm.com>, Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Micka?l Sala?n <mic@digikod.net>, Petr Vorel <pvorel@suse.cz>,
        Borislav Petkov <bp@suse.de>, Takashi Iwai <tiwai@suse.de>,
        Jonathan McDowell <noodles@fb.com>,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, KP Singh <kpsingh@kernel.org>,
        John Johansen <john.johansen@canonical.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        casey@schaufler-ca.com
References: <20221013222702.never.990-kees@kernel.org>
 <20221013223654.659758-2-keescook@chromium.org>
 <16e008b3709f3c85dbad1accb9fce8ddad552205.camel@linux.ibm.com>
 <202210191134.FC646AFC71@keescook> <20221021145348.GA15390@wind.enjellic.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20221021145348.GA15390@wind.enjellic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.20754 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 10/21/2022 7:53 AM, Dr. Greg wrote:
> On Wed, Oct 19, 2022 at 11:59:40AM -0700, Kees Cook wrote:
>
> Good morning, I hope the week is ending well for everyone.
>
>> On Wed, Oct 19, 2022 at 10:34:48AM -0400, Mimi Zohar wrote:
>>> The only thing trivial about making IMA and EVM LSMs is moving
>>> them to LSM hooks.  Although static files may be signed and the
>>> signatures distributed with the file data through the normal
>>> distribution mechanisms (e.g. RPM), other files cannot be signed
>>> remotely (e.g.  configuration files).  For these files, both IMA
>>> and EVM may be configured to maintain persistent file state stored
>>> as security xattrs in the form of security.ima file hashes or
>>> security.evm HMACs.  The LSM flexibility of enabling/disabling IMA
>>> or EVM on a per boot basis breaks this usage, potentially
>>> preventing subsequent boots.
>> I'm not suggesting IMA and EVM don't have specific behaviors that
>> need to be correctly integrated into the LSM infrastructure. In
>> fact, I spent a lot of time designing that infrastructure to be
>> flexible enough to deal with these kinds of things. (e.g. plumbing
>> "enablement", etc.) As I mentioned, this was more of trying to
>> provide a head-start on the conversion. I don't intend to drive this
>> -- please take whatever is useful from this example and use it. :)
>> I'm happy to help construct any missing infrastructure needed
>> (e.g. LSM_ORDER_LAST, etc).
> We are 2-3 weeks out from submitting for review and inclusion in the
> kernel, a new LSM, and an associated userspace stack, that will have a
> high degree of significance with respect to these conversations.

Oh, come on, No one likes a teaser trailer. ;)

>
>> Kees Cook
> Best wishes for a pleasant fall weekend.
>
> As always,
>
> Dr. Greg
> The Quixote Project - Flailing at the Travails of Cybersecurity
