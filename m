Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 416BF745EF0
	for <lists+linux-integrity@lfdr.de>; Mon,  3 Jul 2023 16:45:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231469AbjGCOpJ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 3 Jul 2023 10:45:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231411AbjGCOpD (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 3 Jul 2023 10:45:03 -0400
Received: from sonic311-29.consmr.mail.ne1.yahoo.com (sonic311-29.consmr.mail.ne1.yahoo.com [66.163.188.210])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E781E60
        for <linux-integrity@vger.kernel.org>; Mon,  3 Jul 2023 07:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1688395446; bh=uCaRBl9/DYMlt/h9XiMx0g0xSxre1uIRlqlHZBMOfsg=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=IZzgSdredGyVvsu4w+Q4Kvs6zfUWrQiHg1g0YxPZLCHoPNU4NEP+xERM8Q3vzgorvBsrV6mWjnsisSiFky+f0Ud7JgDvcVYx8qf+rVwLW98iN3UrM6qFzYasKtNa4lDjrm0xRoga5zjC/YRNEJTG5JNP2iccsOt2Rx1FOH5UKqjA3+gelQGShZXOcsDt/cwwWNPKPaqnyv0pxjxFEK0txL1lw8W7mHHMX7DKAHPAsMS/dsH8Efd8yAH1LmCD3Ml2qb9bKh44wAQ2ojYNS1QZmrYmNcneUHEgnxug8696qp7zfw1f7uApnD1+hF+ByXCv/HxXQ9KbHY1+x1uAlixenw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1688395446; bh=LWa5SAyohjajtL+b7RuCBL8UqII61h6t5uhGvVeZfu3=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=OUhP+mN06or9Xybztc8eWtxTPv4zm4L1m86NQb9UVD1Jcc6TqdLdHG/T1CioEA05JeKGp5zO+pXtTYa/piQ17itaVKjTmYl+v/fLjS5F/YLD48/RDbT0n9YB5G/Ha7uqWYGe1SAkknqSJ7PMpPB4tkQWi4NqBr2VXBRZh3yKl7yl4A1TYcScuEpqHzTIVCFXW793342GW9Y5Gl+HSRs2J5SmYCvul1za+H8nRqtBqYdJYKI4OzvvaWrP3vgTM5Mn9ITjt1AYDUCKrKlEtqMDUmGJmQn0JqyjNTEueUjEUHuwhP2Jjuxn4DMTbGVRS7GAJ1vqYXfQqo3Iu5HM3NZRDA==
X-YMail-OSG: TEaXaS0VM1lDxHn5_Z3__e9QSBnKkLDrsYHp2NKNIzdkUb1CDre5smZnvUowRoR
 aJihC5J6QU22hOqS_ltmemBtsQQJ8XMW4iQwIRl90NKzrg2MYQkbwbwptIMw_CxPa64GHqTeBbXN
 pbheNCBiIN7CN9ZBkXDg09UlAYoB3goh.3918Xj9VGSOXtYUP7zyKExuI2BrcWO4ChXhJswjH5lG
 wPCpjIx02TL3S8wK5ge1oaUxFwOG4ZUu0PrkOCz8EfW6GmNWavCGCI2iUrFqoPlx3GwfaqEsYLWx
 Ald5sxCte4NyUXclujcPSr3R8b2hwkVrJiB.trLeypJr3N_BbB2nFdBG5YlHCiIxAM7DxyrawtFA
 dgDlFsbrCPZVmfKzuaDMMlApD55R4Z8nk34weHvUqW25m_XxpLYKwC9kTjDZYzr99xCEjSOlXhRs
 jdkm.P_XjwzcI1Ai3fbCeEL9e4NDHc1FYW3wNAXIKNSq_7I_NqCa3ZIqO7yypmlavVduVVbXsLMv
 Pk9mTWCN00Z63_EHSEY241ZaGtkSUJhg6M6s_54z0Hxexyc95VyH.p83gY2GyBlFVqaRd3nETHdM
 IwtJhM2p4beAzYRonqfbUz1IzmxaU7gQV5f5hJJZsBHR3uBIGPx4gqm2APRU4JW_xoAHrwWNyoyl
 6MEXa348e9DXi3UZAmVCmU23uj6VhKJK6jehIOC.7oip3zPi4EYVQI0Ijr48ly5ZCAc2tejK6xLn
 gWUOQuHJRamUcxEtJLDEDGFEp9W3LtVoSuASa42304vtn.PWhey85mHHHb_u1k0dbyKKB1v1Myq5
 v7zunYwOrp7rPSuY7ZZ3qp.sCy19rXBIETPZ_2uqSutbmfPoqCVb5yVJlwQeRmLUpVJHQOdZxT5_
 hik1KQ6iAl1AO4PbPaPuykUXyBrLexuO8g_5Jxc3VUjb4RAKxhxnnCAHOe4KLbnpCgCtbuJaTMFt
 s5LGTLccFgzZZFbT6ByQ13q0Eeg.XAFT1Y5Zz4cOA.WA0PgGQrS_8LWFeXN9zxa0pYJqyiG19YIa
 JoBq2iRSvH2ZYoolT9d6dbQhxrBwTn5hXQR1yOt1RGdx_odWSrXobtCJBGrUPQBzIJMWR.MqQfUM
 jHqpIw3ZLzelIChl7vEF2RBTTBswtBQy5eDb4g4cNCqQRrrPRToIK7rLxPXa1De4effkQu0q6VUA
 FL2EGJGp3QdG8LROSvR6RS6i_uOmpk17B9WUjVg5fs74jMGxbDdcwjd7sZvM5cRsDqjBXZvE9lyp
 V2emJsOcelAJjSDVwQKPiDBrOTDupwTaZuscFe9FKlsUW2z7Rc8bB.85t932ov65R9rkAjSwEQkz
 el_3.SlJRrz3oY_4.VtkKXUIJy0IUvFLpxGfDMKWFt7PK0zMAq28.dEsUC7Qbx9Y55WNifNIiqKY
 TdMdnoiSsg.VzFJh6jBxFbG8UxTsemXKMpJ1StlyBv_Zme4IqUM3pGOFFBCxKuSVRZsLod3MllAv
 6wFzfKjhfTV9_J0z5hqKyuQox8Fb8Zg7gR4QD3vUliKnH4NX1C.Sb9SIsppUiMhS1_MHUOUrHpIP
 mB5lJp1EgJ74N1CpCFJTZ5mhHXyY5ik2x2tCN32C1bk9QpS6TJJyqFAWz8Ww2iIphOoJoSVJcsFk
 CCofIgmfYKjcXWXJxPKqxpzCgZD3GzItfSAQoytyWKdBPgS6GOQ4BQy.zX5pq8kCtJ5ITDyRkryO
 ReYVh7XcrRacgjHDbl5Yqqk4CUFgWvC_APkb8OO7zoGRTIlXghE7MFwk2vOStUByanR6Z6vj7tlc
 rGn5Vu9p.dTGDtZziSgig0CZCHlHJbHH3zqg0xletU2PZtgNM7eOxgdejpid7y7jj.sAdCiuasCc
 NwGkL9_GoARthVUSEqyuuMe23re7lWp_lNnGnv.ASv9.9dk.0_A5GiPsMmOQlD1viN9SxQ5jSlyX
 OlH1bq1a5_79N178WU7KmpjpHeI0jqZ.4V6WGo3WmzbM2x40hoX4kUEYHuOUqq_fjlLVDSsp4M9r
 6F.sa5Txjz9fZLXHnAHUwkZB_Eb.OB1264St5QVsB1O7csL0yAbUUDMFYnxE3gkv7kteBFc3ZYBy
 l9tZbs6CPmlKKLYpNhv1UvkGm3jaHGtCpVgizjLB15VMc1IFX6dbhT1Aj07zG3lQ4Wt4_FxCM62j
 IYKvY_2uu4nhaWUD5KQip._crMUpM93H_nOKMJ3JoefcUw9bfmcAHdzBdaPRcjj4qzCvHMwb7aKZ
 Du0mtLAahaJyqULl2F5vOcDHO.4nNEbhoty6fa0Zp4lC7tynDRdDysFI5hg--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 45de8f03-ac25-42d6-a747-385768fa1cb5
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Mon, 3 Jul 2023 14:44:06 +0000
Received: by hermes--production-bf1-5d96b4b9f-lngg9 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 202ba4470cdcc78ac791696a012077e9;
          Mon, 03 Jul 2023 14:44:01 +0000 (UTC)
Message-ID: <2939cc00-2b8b-bf9a-45bc-b9a2d8d8def1@schaufler-ca.com>
Date:   Mon, 3 Jul 2023 07:43:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [QUESTION] Full user space process isolation?
Content-Language: en-US
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>,
        "Dr. Greg" <greg@enjellic.com>
Cc:     "Serge E. Hallyn" <serge@hallyn.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        David Howells <dhowells@redhat.com>,
        LuisChamberlain <mcgrof@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Petr Tesarik <petrtesarik@huaweicloud.com>,
        Christoph Hellwig <hch@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tejun Heo <tj@kernel.org>, linux-mm@kvack.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, keyrings@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-hardening@vger.kernel.org,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <eb31920bd00e2c921b0aa6ebed8745cb0130b0e1.camel@huaweicloud.com>
 <20230629021000.GA368825@mail.hallyn.com>
 <14599d8216f1b7520ff5f6cfb27377fa79709f13.camel@huaweicloud.com>
 <20230702175542.GA25867@wind.enjellic.com>
 <0870d82571d1075433a2b81b2953cf8b4afcd415.camel@huaweicloud.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <0870d82571d1075433a2b81b2953cf8b4afcd415.camel@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21612 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 7/3/2023 12:57 AM, Roberto Sassu wrote:
> On Sun, 2023-07-02 at 12:55 -0500, Dr. Greg wrote:
>> On Thu, Jun 29, 2023 at 10:11:26AM +0200, Roberto Sassu wrote:
>>
>> Good morning, I hope the weekend is going well for everyone, greetings
>> to Roberto and everyone copied.
>>
>>> On Wed, 2023-06-28 at 21:10 -0500, Serge E. Hallyn wrote:
>>>> On Thu, Jun 22, 2023 at 04:42:37PM +0200, Roberto Sassu wrote:
>>>>> Hi everyone
>>>>>
>>>>> I briefly discussed this topic at LSS NA 2023, but I wanted to have an
>>>>> opinion from a broader audience.
>>>>>
>>>>> In short:
>>>>>
>>>>> I wanted to execute some kernel workloads in a fully isolated user
>>>>> space process, started from a binary statically linked with klibc,
>>>>> connected to the kernel only through a pipe.
>>>>>
>>>>> I also wanted that, for the root user, tampering with that process is
>>>>> as hard as if the same code runs in kernel space.
>>>>>
>>>>> I would use the fully isolated process to parse and convert unsupported
>>>>> data formats to a supported one, after the kernel verified the
>>>> Can you give some examples here of supported and unsupported data
>>>> formats?  ext2 is supported, but we sadly don't trust the sb parser
>>>> to read a an ext2fs coming from unknown source.  So I'm not quite
>>>> clear what problem you're trying to solve.
>>> + eBPF guys (as I'm talking about eBPF)
>> If the week goes well, we will be submitting the second version of our
>> TSEM LSM for review.  It incorporates a significant number of changes
>> and enhancements, based on both initial review comments, and
>> importantly, feedback from our collaborators in the critical
>> infrastructure community.
>>
>> Just as a levelset.  TSEM provides kernel infrastructure to implement
>> security controls based on either deterministic or machine learning
>> models.  Quixote is the userspace infrastructure that enables use of
>> the TSEM kernel infrastructure.
>>
>> Based on your description Roberto, TSEM may be of assistance in
>> addressesing your issues at two different levels.
>>
>> First with respect to protection of an isolated workload.
>>
>> TSEM is inherently workload based, given that it is based on an
>> architecture that implements security modeling namespaces that a
>> process heirarchy can be placed into.  This reduces model complexity
>> and provides the implementation of very specific and targeted security
>> controls based on the needs of a proposed workload.
>>
>> The security controls are prospective rather than retrospective,
>> ie. TSEM will pro-actively block any security behaviors that are not
>> in a security model that has been defined for the workload.
>>
>> For example, with respect to the concerns you had previously mentioned
>> about ptrace.  If the security model definition does not include a
>> security state coefficient for a ptrace_traceme security event, it
>> will be disallowed, regardless of what goes on with respect to kernel
>> development, modulo of course the ptrace_traceme LSM hook being
>> discontinued.
> Hi Greg
>
> thanks for your insights.
>
> The policy is quite simple:
>
>
>      r/w  ^                             kernel space
> ----------|-----------------------------------------
>           v (pipe)                        user space
>  +-----------------+       +-----------------------+
>  | trustworthy UMD |---X---| rest of the processes |
>  +-----------------+       +-----------------------+
>
> The question was more, is the LSM infrastructure complete enough that
> the X can be really enforced?

I believe that it is. SELinux and Smack, users of the LSM infrastructure,
enforce "X". They also require netlabel for IP communications, and Smack
falls short on newer protocols, but that's not the fault of LSM.

>
> Could there be other implicit information flows that the LSM
> infrastructure is not able/does not yet mediate, that could break the
> policy above?

Sure. Every so often something pops into the kernel (e.g. io_uring)
without proper LSM integration. We try to discourage that, and correct
it when we find it.

>
> I guess TSEM could be for more elaborated security models, but in this
> case the policy is quite straithforward. Also, your TSEM would be as
> limited as mine by the LSM hooks available.
>
> Thanks
>
> Roberto
>
