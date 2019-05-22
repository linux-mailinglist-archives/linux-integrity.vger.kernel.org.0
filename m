Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D41A266B0
	for <lists+linux-integrity@lfdr.de>; Wed, 22 May 2019 17:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729783AbfEVPKy (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 22 May 2019 11:10:54 -0400
Received: from sonic302-8.consmr.mail.bf2.yahoo.com ([74.6.135.47]:38426 "EHLO
        sonic302-8.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729634AbfEVPKy (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 22 May 2019 11:10:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1558537852; bh=opq4TL+v22N9Y8wKhRYQl3sDZGkTeG8xWMvzbh46LcQ=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=OREk+gnfI4klg8BC201zny91ZKGWAUTQN9a2HKw5aQsiqB6CUFQ5ulEfegQBDq3ZJ5s5P/+kydsuv5EElbjri05oAAgkB/CNppyOyH8BzE1SkaawSbPR6UT7BIvn78VX/z2z/kj0Cp8r9LRtFalMRQkGXVkNCpsAy/UfkfqrCmztJgRcmwWnliTAR0hYMZIFIHYYhepgMWnsU+4emJOXmq3x26itq4j/fJ1u2QLtaC8uODx96Q0RY1Gp/gn6IVCHSM3pfSC/2OjW4gAeJpg89cmcOketYcMtRgc13tIqHIH88CxmFumFktjjYyKmhhHW4IoCqlSLjkiFOzYoIz5PqQ==
X-YMail-OSG: 8fs3MucVM1kDFL7QlCXu33hMDF.WaEKUIPVDfrqW9Xf8H1TTjo8eWXP7ZZxXpUr
 WKsOtPo24rah7YhKVVOUUrzeND5.nHW9fEArH9fV.o_0a1oWujQ6JOA6Q0sWjinvyuhStZAHEgEL
 XpWOzPyUil0enCjF7xXpsQTbrAsGFTctBliyLr.0kD2x84j9w4wTYnHgP7tOOqMXnLFN0iYQEpd8
 o.Wff3_RgvFnBinhSbD4faXnDXx6mbgt.D2b8LPDCF8_F5eQKJKvtWqhODdrg25ri_IOBz_aoLGy
 Ghfpgvu99WUatxb8iUSmwtHUKM_U6AaHrEkzpgEVMECoWkTve0WQ2RnXTeSKr_gWR3ri8kOnVdrU
 jHI_jGfRNkd1Vk7BRmuUOKOVLFaOUkeEvejBu_WJ_de2NF8fo9gl3Pc20CyJWGZbUTBAVHyn9.BV
 kgSF9RuAvPk4t_D6uzO1DChrkqiYRsOYGgtVcv2AhI2CMgJf8J3PsdmWWjv7.GjRK_6a9BsaCe_V
 6lIm4ZeTq5THM9NaTvN8.vUrvn6669j4emy7LfQykVbWbNtpEkCNyy0X6zvjZ606GeRdSlrqdSP6
 Z.zEq8XcIaM_4Bpp9tIXV_9G3giDoWNddkqkFcAs_wGYaju5eH9GMlit2E0.Pp78uzSefj4RvnUW
 bUz_95o0LCXgDqYdVYxQzMXRSYM9Bn4pSp_I1xeUiBblZ1.kTdruCpf9zYjQ4ApIMZS6UaFxDycP
 XUMfobR5r.nJkHe8KTK3k7ufycH6K1nb5T5d3785Lh_.LXxsS4IYAMWBg2ppa1N57dnNX1UWQLDQ
 48y_Svuha3IzmflLFrvQP7yXBUtGHQPXlzJqfNx8eSkIKW3ksipCLp83.7LyJT3xgIkxpQCChzgZ
 QgfSqq_52WbFp6GQJpZExHE8a4VwHBH17kNwDDlnWhdj0U2C666mTLVDDZI4cMQaqLtlh4DqHgkb
 tmZa2oYYxXVYvc7lNAD6a6sr75Hd.rJTxFkiURqBIJo6BA4jhLyJLyJexfS7p8Af4oAquM6ojARo
 EMtIRRaaS24nb0FCt85Uv24I0YKJkPwpbJpe70alf9RkK39.3OXOie.IZt9TxBJ9Buvp6tqs7cgK
 jqx1YZfOJ1Hp8hZha6lt81GbR_6KOqrkq9CCJ476.OPpnP9NOjJHCwOr0SRqThjx7ThOXckY35uM
 juquUvARQxw4gjdrYFuBy8dw4h.cs1MpnqQ68gJTUS2xNu.BAc73.o78pDvZkGupokvLXe0pWt_w
 iHlHUfMwFK1orTuH2
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.bf2.yahoo.com with HTTP; Wed, 22 May 2019 15:10:52 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO [192.168.0.103]) ([73.223.4.185])
          by smtp402.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 111ae5f9032432b78c67619613873cea;
          Wed, 22 May 2019 15:10:49 +0000 (UTC)
Subject: Re: sleep in selinux_audit_rule_init
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Janne Karhunen <janne.karhunen@gmail.com>, paul@paul-moore.com
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
References: <CAE=NcrYsfQ2ijJJMEyTFoWnFqF2qGS=B2JNsVaE8WUNcGS7D9Q@mail.gmail.com>
 <e8dcc9a2-594d-f81a-32a7-e18f591c6062@tycho.nsa.gov>
 <4a725f06-8244-8264-a911-df7ca1c66789@tycho.nsa.gov>
 <1558530022.4347.11.camel@linux.ibm.com>
 <4db98b76-8637-edf6-c7df-3e244be0f11e@tycho.nsa.gov>
 <1558533420.4347.30.camel@linux.ibm.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <a82bb6d0-1866-8e35-01e2-3f076709e08d@schaufler-ca.com>
Date:   Wed, 22 May 2019 08:10:47 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1558533420.4347.30.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 5/22/2019 6:57 AM, Mimi Zohar wrote:
> On Wed, 2019-05-22 at 09:16 -0400, Stephen Smalley wrote:
>> On 5/22/19 9:00 AM, Mimi Zohar wrote:
>>> On Wed, 2019-05-22 at 08:41 -0400, Stephen Smalley wrote:
>>>> Another potentially worrisome aspect of the current
>>>> ima_lsm_update_rules() logic is that it does a BUG_ON() if the attempt
>>>> to update the rule fails, which could occur if e.g. one had an IMA
>>>> policy rule based on a given domain/type and that domain/type were
>>>> removed from policy (e.g. via policy module removal).  Contrast with the
>>>> handling in audit_dupe_lsm_field().  The existing ima_lsm_update_rules()
>>>> logic could also yield a BUG_ON upon transient memory allocation failure.
>>> The original design was based on the assumption that SELinux labels
>>> could not be removed, only new ones could be added. ??Sounds like that
>>> isn't the case any longer.
>> That's never really been the case for SELinux; it has always been 
>> possible to reload with a policy that renders previously valid security 
>> contexts invalid.  What has changed over time is the ability of SELinux 
>> to gracefully handle the situation where a security context is rendered 
>> invalid upon a policy reload and then later restored to validity via a 
>> subsequent policy reload (e.g. removing a policy module and then 
>> re-adding it), but even that deferred mapping of contexts support has 
>> been around since 2008.
>>
>> What you are likely thinking of is the conventional practice of 
>> distributions, which is generally to not remove domains/types from their 
>> policy or to at least retain a type alias for compatibility reasons. 
>> But that's just a convention, not guaranteed by any mechanism, and users 
>> are free to remove policy modules.
> Ok. ??The question is then how should IMA handle missing domains/types.
> ??Just dropping IMA policy rules doesn't sound safe, nor does skipping
> rules in case the domains/types are restored.

Smack has a case where the subject label might never have been
seen by the system before, and hence can't be in any rules. This
can occur when a labeled packet comes from another host. Because
a subject with the star ("*") label is never allowed access to
anything, that is a convenient value to use. It is never used as
the subject label otherwise.

You could do something similar if there is a SELinux domain/type
that you can rely on being present. I fear that there may not be
any such element, but it wouldn't hurt (too much) too look.

>
> Mimi ??
>
>
