Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 341085BB16C
	for <lists+linux-integrity@lfdr.de>; Fri, 16 Sep 2022 19:05:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbiIPRFX (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 16 Sep 2022 13:05:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbiIPRFT (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 16 Sep 2022 13:05:19 -0400
Received: from sonic304-27.consmr.mail.ne1.yahoo.com (sonic304-27.consmr.mail.ne1.yahoo.com [66.163.191.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57D6432AA9
        for <linux-integrity@vger.kernel.org>; Fri, 16 Sep 2022 10:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1663347914; bh=g1U1TCuQXVzueLMImuBTzqE+VJ+3TVNeqRBztp6aiMI=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=WzEC0ZXEDEWEI0bzR/lxbMRhqTRVzzB3PcpIGKSLvMMMkJzI9ZjDGZK9m3RkLOk90l6dS9ss7qLZnEgfVt6zra2PCxS8MCEiVy+FLGUxBu03rfIroXWxkWvTsvqkmjhj5iKbWao1MzkCGIGHM6iXnOYb2koY4gJI0CvGApBUQEy9zG7QAnU0Z8zeo9wys44kJ83gK1c2TCaLrwSXqTbHWa++o0YXKwZfYfJcJHlAQaAYnp8CzOEdRr3e78Kq4ZAWl8h+XHoCCXFxso1RJj1G7K026VJHWcpQTy9gqMfyvyaoSXL+ZkbhcgCMDrzzVjDaDNLVAJjiMcHo1VXA3m4VkA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1663347914; bh=zelXIpfF+2mxzWQ1TTSNFjaFjrt3Qf6WaG/Z7cDRc3D=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=TmdILDmsovZjS2pkOtgzdC22LK2zSwzEaafwMfF4bn15UyTv2L64fFWS4ojdzOmYS70m4YFAcXjq8Qt6COHknfibS85YbQEPrqhYJgCs2kKk8Q7//VBBNyVOJoZr42C/wsbErgXqdq5rvsfS6xyyPuiiYHAwli6CB/YOiLRr2lfP71ZOpiSNnQWvZ/z4OuG2RsxrJGRHnB+wOoBI2L1QVhm7sJGzO3oCoM8kldtH3GoVajeFzfR8ll1CU24HTroBfoblEN7+y9fOrJPTOvVwNztqOH9Gz8W/ZDxRioSvl1kwTIzhs5KFZjO1yJb3JPIN+myQhOlpfiNcThk+2XRbCQ==
X-YMail-OSG: p3D10AIVM1mHdApZPrFMZpYQtknLkmpd1rnoh8EYlAotfbcgnW1LdWoP5GSJr69
 TWX9FcrO..eSPemWqOeaOUDsPDxV3c3LsmJ1o63hHA7rqC59N9z9v0VH7AlPXXM008wql7GeL_.U
 MBI0.zSyWuYoRIbPj5luBjeQaxy0ceTSU9yMui6.GYiTNchin6IlLtet2nUn.1z0vjnmkdYremi7
 EI922FtFYsd5QZUt26c9lSX4kTdr1DyPJ3reyTY4VsDARMyY3tdGU0nw9kFvJrIxTWEO2eXLFReQ
 1GFuZFbdIWzsISTI4Ez4A77rDJpY.66BvbEujt8KO7WI6sW.XFw9MblqMaAy7fZErmrV6BjOL0ML
 x7YwdreLZaMqQyEib7iZJxo0RBRgNizkUssGDB4J0a_C98eprcgzqdEBiUPSpXbh36L4dc_0W7dv
 KBMZQNmkviIYxs.FEi6Fzya7VEkhANphb4bITN6BUrFkArsuWVkiGaVEfMfQ.piuSTBbUtSiBfog
 jR0TsQ9Y532YZh0A2LLmGNVGR4FbsqtQ_OiWSr.mratSHKcAshIQabzAqiIupCw83W7UEmq_DHQc
 _qAq4FZtqXXEwhaVL1wuiimElYc2gzDCe2UZ0587m4AZa9pz4ki6l7zsSFRmXKdOGvC7yJt73_M6
 ne2O7G_6IFL_lxinAxjXV4M3dZm1WBij7XEp5dggcU95530rN7wJer9pSOJ1pomReupQsDx9URbK
 aL_N2cIBCzwQISgJ5qiyY1ArRmnrhrQynCUcicnluPli40Ou9QEVn0xwP0.hihkv3kAq21t.cLjK
 9KCjBwkOxenZ2pVl1V2MgTySdbyQ.zNdtow6WrFLXW71LlxTsveCWz2__z.OM_q.BW6aFrdWCW5h
 B2rmUZG1bjIE5anjyKAApuGc70BoVAt.0tAjkaxLPwS57q0uMYac0dA_7opvVqjY4FXUFOqU7Tdf
 fzXMbMG_f3iZIiAIebfh5KPzeMXdNyebSpG3HUIhxyXM7EfZC_0wwHx2dJbZJQiubaT56hMwW6n4
 oaysm7NrhKZkXdK9DMJDu2DP55uO7EiJwQxgXhDCdHjsWupWdmaXZEw8bL7C1nnB9FZNBwnPTaY5
 15pgNIEEfYxPtVFWGOTWBN1U26DfrSgMw3DHz0iJI3QuxGRiRxOCOMFPDDMn4kvf50Ch9n3wf_HC
 llfB2715pQmtSUw91VXfMii61hUQJeuHJ9hWzL.c_j.F6pHXkbaUp5RNSDK1EKKMQAHshAwHkJ8Z
 J3y..pQeN01XwbEOz8.q1oqVAaWmdqaznaeQ77rjqdZWSaLFI5tKo4nDURVKnYIN1Gwb7nbqOoPH
 KToVfH4OqtSrcl.vJEQolZXkj8uj0HrEAsLWuRbrHE1dh4k.aa3SyaTjq5kAMyGpgjPr1RD6mDXY
 jFlQsWmWKuzF3NLDXDoWK9aObODRS.Y0bZIH1DXQ9i0bFxjRJtwy2WyGVIZ9L9oAGIquc_IIVQW8
 MGnsbE8HjJxocyejkea7IVefKcN6HW2K48wx_xlv1ItY47raKovZoA5xacRXjeS1Fqo_T4a4Gei.
 42MKZCkNYklQ.iOzLbwTU3OtOzj5_2YGWcnCVuaeLJiYotTURM4NSF4PcJgbhd9HmWe7GrjPL_LE
 quJDeSBQJAMNjiQoHbAHylJf3LZCfl_MvkHBRU8lm8a1XvZh53u_SqFTROUY_..fz_jgTFs7_C.L
 vs_4WYAGItiGgKY81Pxl2hvg7wOaZS4P9vA7A1B6uftB3o1KyEg9gHlJuF7I1Cgqy1KnynbvKuW0
 bWY7wzoEAtuybikDupyu9rOMwl.z5VenOmdubgzuW9pfvpHUmlf.MdOZGVX7bT3dK6u6yGnpxMul
 bth1liOR29m15MOtx1czniOHM0EwIwMrE5Apl6_Q39iv7zKTpc8lQRlQYKxIiKn2.pt2OHXFwYTK
 pwERqHse5cLzvikvLa7.00ZeW6eMdHIk55lr3qWf9U7.uriPVxc2w4rZppXcbzz364n4ttdBmqOX
 YINtxZxT6fco9TshVUJBC10vWsBZNERqfL8T_B1REuadxpM7nTKO.x.yqfIIz5C43LcPkfQXTzSV
 q7UA7enAdbUdek6BHoW4wmGTPHYi.ZxJB2MUtAHIB_VeKG_8wEcCEkXE7XgjfoDHNNsaF7gBE4BA
 sqpCCakrAgac3UJ4LDbRGw5MECc5OKFZBXXHljRoxlnd8fNUqbA7zAOn4w7KEIEOTGZZ_94DXBdq
 jEaEUFXgtp_TIUxB2ep9Pfx283LF0OYeemjm_Rv0PJTxFgu1lT3KMgLxui7AEOwdn4XOBulouZTI
 P3Q--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ne1.yahoo.com with HTTP; Fri, 16 Sep 2022 17:05:14 +0000
Received: by hermes--production-ne1-544744cc75-zkxbp (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 3068443257e4cf01d6b889e5ae3c073f;
          Fri, 16 Sep 2022 17:05:11 +0000 (UTC)
Message-ID: <49617fa0-998d-1e6d-7d86-212139dff51b@schaufler-ca.com>
Date:   Fri, 16 Sep 2022 10:05:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v14 00/26] ima: Namespace IMA with audit support in IMA-ns
Content-Language: en-US
To:     Stefan Berger <stefanb@linux.ibm.com>,
        linux-integrity@vger.kernel.org
Cc:     zohar@linux.ibm.com, serge@hallyn.com, brauner@kernel.org,
        containers@lists.linux.dev, dmitry.kasatkin@gmail.com,
        ebiederm@xmission.com, krzysztof.struczynski@huawei.com,
        roberto.sassu@huawei.com, mpeters@redhat.com, lhinds@redhat.com,
        lsturman@redhat.com, puiterwi@redhat.com, jejb@linux.ibm.com,
        jamjoom@us.ibm.com, linux-kernel@vger.kernel.org,
        paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        jpenumak@redhat.com, casey@schaufler-ca.com
References: <20220915193221.1728029-1-stefanb@linux.ibm.com>
 <7234a3e5-8b3c-3ac4-2e06-c6cffa46c10e@schaufler-ca.com>
 <556b21f9-56ae-7ff6-c38a-9ca856438a66@linux.ibm.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <556b21f9-56ae-7ff6-c38a-9ca856438a66@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.20663 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 9/16/2022 3:54 AM, Stefan Berger wrote:
>
>
> On 9/15/22 20:56, Casey Schaufler wrote:
>> On 9/15/2022 12:31 PM, Stefan Berger wrote:
>>> The goal of this series of patches is to start with the namespacing of
>>> IMA and support auditing within an IMA namespace (IMA-ns) as the first
>>> step.
>>>
>>> In this series the IMA namespace is piggybacking on the user namespace
>>> and therefore an IMA namespace is created when a user namespace is
>>> created, although this is done late when SecurityFS is mounted inside
>>> a user namespace. The advantage of piggybacking on the user namespace
>>> is that the user namespace can provide the keys infrastructure that IMA
>>> appraisal support will need later on.
>>>
>>> We chose the goal of supporting auditing within an IMA namespace
>>> since it
>>> requires the least changes to IMA. Following this series, auditing
>>> within
>>> an IMA namespace can be activated by a root running the following lines
>>> that rely on a statically linked busybox to be installed on the host
>>> for
>>> execution within the minimal container environment:
>>>
>>> As root (since audit rules may now only be set by root):
>>
>> How about calling out the required capabilities? You don't need
>> to be root, you need a specific set of capabilities. It would be
>> very useful for the purposes of understanding the security value
>> of the patch set to know this.
>>
> CAP_AUDIT_WRITE?

Not everyone is going to know that. And, is it the only capability
required to make "things work"? If you call it out in the take message
people are going to have a better idea about the relationships between
IMA, audit and capabilities. That's pretty important for unprivileged
containers.


