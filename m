Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 419C555F4CC
	for <lists+linux-integrity@lfdr.de>; Wed, 29 Jun 2022 06:03:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbiF2EAe (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 29 Jun 2022 00:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230302AbiF2EAM (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 29 Jun 2022 00:00:12 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC2B438BC4;
        Tue, 28 Jun 2022 21:00:00 -0700 (PDT)
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4LXnlV5BjRz9sxD;
        Wed, 29 Jun 2022 11:59:18 +0800 (CST)
Received: from [10.67.110.112] (10.67.110.112) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 29 Jun 2022 11:59:59 +0800
Subject: Re: [PATCH -next] evm: Use IS_ENABLED to initialize .enabled
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Eric Biggers <ebiggers@kernel.org>
CC:     Ahmad Fatoum <a.fatoum@pengutronix.de>,
        <dmitry.kasatkin@gmail.com>, <jmorris@namei.org>,
        <serge@hallyn.com>, <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20220606101042.89638-1-xiujianfeng@huawei.com>
 <64511312-df94-c40b-689c-5fc3823e91f5@pengutronix.de>
 <812c4ee9-56f7-900a-df48-f3ca3e15542f@huawei.com>
 <5d0c291bb4a674a6733a18f9eb67cf40193732f4.camel@linux.ibm.com>
 <YrJ7x3kCTy3ZutZ/@sol.localdomain>
 <38fd40d03b030f9a60afe4445ddc0daca220e449.camel@linux.ibm.com>
From:   xiujianfeng <xiujianfeng@huawei.com>
Message-ID: <99d2b96e-c1bc-52f9-c52b-f7577f9011b3@huawei.com>
Date:   Wed, 29 Jun 2022 11:59:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <38fd40d03b030f9a60afe4445ddc0daca220e449.camel@linux.ibm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.112]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500023.china.huawei.com (7.185.36.114)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


在 2022/6/27 0:13, Mimi Zohar 写道:
> On Tue, 2022-06-21 at 19:17 -0700, Eric Biggers wrote:
>> On Tue, Jun 21, 2022 at 10:03:39AM -0400, Mimi Zohar wrote:
>>> On Tue, 2022-06-21 at 18:58 +0800, xiujianfeng wrote:
>>>> Hi, Ahmad
>>>>
>>>> 在 2022/6/7 14:06, Ahmad Fatoum 写道:
>>>>> On 06.06.22 12:10, Xiu Jianfeng wrote:
>>>>>> Use IS_ENABLED(CONFIG_XXX) instead of #ifdef/#endif statements to
>>>>>> initialize .enabled, minor simplicity improvement.
>>> The difference between using ifdef's and IS_ENABLED is when the
>>> decision is made - build time, run time.   Please update the patch
>>> description providing an explanation for needing to make the decision
>>> at run time.
>>>
>>> thanks,
>> IS_ENABLED() is a compile time constant.  So the patch looks fine to me.
> Thanks, Eric, for the clarification.
>
> As LSMs are only builtin, why the need for using IS_ENABLED as opposed
> to IS_BUILTIN?
>
> #define IS_ENABLED(option) __or(IS_BUILTIN(option), IS_MODULE(option))
>
> thanks,

I think IS_ENALBED() is a bit more generic, maybe. here is another 
example in rcutorture.c

which uses IS_ENABLED() to initialize the member in structure:

static struct rcu_torture_ops rcu_ops = {

...

.can_boost = IS_ENABLED(CONFIG_RCU_BOOST),

...

};

Do you want me to change IS_ENABLED() to IS_BUILTIN()?

>
> Mimi
>
> .
