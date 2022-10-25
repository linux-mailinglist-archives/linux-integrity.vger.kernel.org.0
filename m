Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC7460CFF0
	for <lists+linux-integrity@lfdr.de>; Tue, 25 Oct 2022 17:06:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232167AbiJYPGT (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 25 Oct 2022 11:06:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232445AbiJYPGS (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 25 Oct 2022 11:06:18 -0400
Received: from sonic304-27.consmr.mail.ne1.yahoo.com (sonic304-27.consmr.mail.ne1.yahoo.com [66.163.191.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FCDF2CE33
        for <linux-integrity@vger.kernel.org>; Tue, 25 Oct 2022 08:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1666710375; bh=0MA12W4FOYjqK/D/Ez2MVjLRzb2dZqLn6OwhoW1C4EA=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=F84n9WiDi4t9aYSz9BYLA24J6Vve3mafkj+0Wxgk0eliy5nUrwuq3/DTvIiMmtK7Z0958INP+9NrVlVPyGG/wpJHIwd/rmZVQm0zEUqYa2MfbWksvtFnl9FU9bu2mqhawpJXfcvuJx3lef5z0BX8XBLvgD5j3yJgWgD8TSaRwT5/1TUVyz7Z9XGgRrGigzPfK674X0FG4rvFtVthgRAXB0dYqD8lIQ0lkUZh3lKTA97C5RfaC6zZayM7mBJLL9hLOO8hrP3cFtvdJrBa232QM4tpEUL8EFrOSAY2o2EHODM8/ua8HmTVc8+GX+rIzjjRdEtmt0nJ7HnlP4Fb+Y+log==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1666710375; bh=YJx5ohXx+JA/5sYnox+2BPGVUX+wC6aIi59D8hN/d/D=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=SmNs3kIJQXGFvLO/aAhVpaU+tHgJRuOC8kyjaJaVG0oP9GJvzHzG0gfUHFYruMkaOO8VeARUBtrib4/ZU2vdAB2tfMgS7A6pP/6+Q8n+XojAQk9sjqY9GdS2gy4Iv4gQJUb3KJkuAa7YOXD1FP6qp0QwPefl3t5SyJVO3OTCKdhtev7KB0uB3tMDoc6O5rQBEwGM/TazYNxLJexon6xMOfJSsm21KDmYhOBErRWhnKvSg87WADxm4P+8yIYSsTIiHjeJb/N4Tn8IBSdkQzTpHHn9TZR1O8g3GuGamPAYxHx5Gkxb/AGsaLKIqAn6wucUr2C/kTz9UAuqw4Nov/9X7g==
X-YMail-OSG: m94aZeQVM1mZecTxy87L3VWaQovIXyIkS3R8qtJTX4TV6fs62YLzeYHDWELuMEr
 iWjV3Colax6hDXcSlE.PFx_y6cYgCyjKDYIAwmfOQmn9gE_MO92cFlqN7sutToTJ7tkwtMlpM.q7
 8Gv_lB6mIjX7qSSME3FfJk1j8P2PfIB9tlpkNbdEAAEoSTiZQ1RjReURcEtI4cSzVkTvUImr76_5
 IuLMQarptoN7QIfMHA5MBiH6RVhseSxSqtDD5q2HER_CKdHL.h3MLhsG3wN9F6zKxv5Km_lB8vcl
 xGnpoPupX7yrnneEh_PDBQHzDkU08j7blHcRPpNoaxF9mm4fUjXSNaraDFIDGIOoViMsm__yk.dE
 M6Wa4W8bq8CeqlvbjXIqLHkRPZ8FqzZq_UrVAmvUTBuk3RoR8TbHuVyxUs2oBU1idEoclrmfPRc5
 uxKSKFttyB3_1F.dTp_Cz2CiA_vrKtvuShGrGFcBeE518CjSNtxcqG7ZTDKELN4uwMHCL42yl37m
 Jx2LWLRlo5v2FtAO0lrFCrpNYusWvjYgC4kF1kQKIBWvpEjhzWqfK4xn0q91T0H9LYR0zWThKK0Q
 imelGM6fQabJickqlYG1uN91YP33cpAprYACbjYhEEtn20k.NsxZ0w78InV_yyPUK9HCVRGRxHOT
 7woVZyyLxAou.xKbumYf4OdEeXl9MDUz9d7fq7WjtKEL.I1IjXGrk5D4K2EbRFY5NMvB1mRKhIBI
 md9K1VHWqUVAYq6vIIs.IXz_MwAIYjjpBG_NxEhbHdx38Q_QYEZLDoplynkGBZpHm44yv.4ERrX9
 nfW.epBa10n41d0GPInZWKOJKHeWJxjeFY0Cj1OTfdyBuEIDQHfZICT6kJwFHix6aAA0lrRjy33s
 FPYYIgsWxyfEDmi5uuqtJT9KYO4_ikRXn9gog8IY6uYr.r09jiIwdngzEpb4OWU5gNXX787m9BEu
 AREi48i7nyvxyVL9xrffKcNzUoSeKLz31r1Y2rsKcm2rNIpYsQjdCAVVoNP8B2lZHFAbHngC.pWZ
 wkHMm3k.oBbBp7K0mz.9B6If9ZN7kKLn6cL_zGDEi0egn0Yv4UzwhBaKJVgZ3sSgMJAgvjh.xA7v
 OZk6M_rLoR2P_X_cayWGRsotun4N1T1WlWdTkv60EVh6Cnxr6ozlAu_O9jvI20O_XEkIzGii5uDi
 Tq34nI6pO2w1UTeXVHKFN4JRFHK15hCjqZph6c.uayL.t5S29JAsSBb3Ahue3376IwBHL.SwUAPr
 V3Rx1CA8jb62arSIXDbL6AekwcUzehuiBhwsM8HWwTeDActDcgX8e7gxQHawIl9Nnmv1aR6iYwAi
 gFvw.DfRs7NfhfEV2L5VyUzqd8kQyEOvmYRlY4TxewmMbsO5r7dsTgizr6o4e4kh9KL_SK3prRzc
 Hx1wnWumHZHnhKC1ruyeT8JEshMm6L8enLXh86AnGSra5nJAajBG_pz0M61bBF8qSy_X0ZvX2gwO
 4QkkpODB7jGdjpMd1bAosjhJ4WxT9e7osNqUgLzOe2yJbRmvddGRg0WG1SYxNIRanZJ48pz71fdI
 CqVzRVksS.sctEArykI2tA3MK8kZLayqUuK_yfT0ZcnqR6b1wA7YoSye.Gb1o4RuUQbtD6DbKcT4
 KqmfHTKNgMlYTT_I_t1A49PQ3JMd9k_q80S1iSHoVpdKfEfVGuD5xwp.5zyT_bWIyd18Y6fMtRKN
 WSw8jf2uWRHs1rJaz0u3hMQNVwUg8UXmIabjYDZ7mjIuAPwsmOvzvRJbAm70O2v0qukuwuhLLa4e
 wC2sLwwDaYx_nTAE7GNbJG6ksBjiGFjLJfNpsFUazhl_PYYRaATc0p5HPGnE3qVa6mZytzTHlSuA
 LvdZlx74fPrW5v6i2zr868BwDOQ6TYinshrUnRndbsWiUvNKYEGoLuxOMO7AM9kdkMhiw_26Y8Sy
 xgayFb2cTSbf_IKyRzSgCnoecuvPodZs1fBJeMkGrBf8fudQ45jqMsKrMDdfrDeP.X.wnqv00A8.
 pOJnGcoqwOSU8AVn2hkdce.Veyeszb8lLCAYYFVo_BZuEQ8rgJspeDkQWlopFadfbA_1w_44OmMA
 7_HXWwgHfNUG3i78El8To95yDHjkEFf8DexzcQ_lJDaWzuKmomkVDwiMfNcSU_9TMf85W51g1H0Y
 qVdRyKVu6_ous6qbWGjnv3zSI9Wb4JZFYyhxphxMJHr0FCb9gkN0K8YpzwIqQCn.aeBAFv_8Xi0Y
 aP.Joyb.0z6V_rOX.jovRpg4Z17E_xiBNQTHsJ6oJA3yW11a5piagv0FBc5zYgBs14VBczQ--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ne1.yahoo.com with HTTP; Tue, 25 Oct 2022 15:06:15 +0000
Received: by hermes--production-gq1-754cb59848-v9h2d (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID a092f346b057c64633d3a5d015af3e76;
          Tue, 25 Oct 2022 15:06:09 +0000 (UTC)
Message-ID: <d18963ca-9c32-c360-144c-fb4a7949d20d@schaufler-ca.com>
Date:   Tue, 25 Oct 2022 08:06:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH] evm: Correct inode_init_security hooks behaviors
Content-Language: en-US
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Nicolas Bouchinet <nicolas.bouchinet@clip-os.org>
Cc:     linux-integrity@vger.kernel.org, philippe.trebuchet@ssi.gouv.fr,
        dmitry.kasatkin@gmail.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, davem@davemloft.net, lucien.xin@gmail.com,
        vgoyal@redhat.com, omosnace@redhat.com, mortonm@chromium.org,
        nicolas.bouchinet@ssi.gouv.fr, mic@digikod.net,
        cgzones@googlemail.com, linux-security-module@vger.kernel.org,
        brauner@kernel.org, keescook@chromium.org, casey@schaufler-ca.com
References: <Y1FTSIo+1x+4X0LS@archlinux>
 <5edef60c775117758ecc146f1e8b96ef1c48e3da.camel@linux.ibm.com>
 <Y1Ki8838IAicXzlb@archlinux>
 <8607d166bbd2f32f1e71e5d7ce40b937eaeb410b.camel@linux.ibm.com>
 <Y1flvA2hJn2pNSiJ@archlinux>
 <4e645d7cb3c3d8c8c9af944130eb929851d5ba2f.camel@linux.ibm.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <4e645d7cb3c3d8c8c9af944130eb929851d5ba2f.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.20754 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 10/25/2022 7:21 AM, Mimi Zohar wrote:
> On Tue, 2022-10-25 at 15:33 +0200, Nicolas Bouchinet wrote:
>>> Agreed, independently as to whether BPF defines a security xattr, if
>>> two LSMs initialize security xattrs, then this change is needed.  Are
>>> there any other examples?
>> I think that in its current state the kernel cannot load two LSM capable of xattr
>> initialization as they are all defined with the `LSM_FLAG_EXCLUSIVE` flag set.
>> But I may be unaware of other LSM in development stage.
> Casey, Paul, can we get confirmation on this?

I'm working really hard to eliminate LSM_FLAG_EXCLUSIVE. Dealing with
multiple security modules initializing security xattrs has been in the
stacking patch sets that have been in review for years now. So no,
you can't wave the problem away by pointing at LSM_FLAG_EXCLUSIVE.

>>> (nit: I understand the line size has generally been relaxed, but for
>>> IMA/EVM I would prefer it to be remain as 80 chars.)
>>>
>> No problem, will change it !
>>
>> I'll take time to run few tests with BPF and send a patch v3 with new changes.
> Since Roberto's patches will address the BPF bug(s), is this a fix for
> a real bug or a possbile future one.   Cc'ing stable might not be
> necessary.
>
> thanks,
>
> Mimi
>
