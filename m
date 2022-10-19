Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BE99603A7C
	for <lists+linux-integrity@lfdr.de>; Wed, 19 Oct 2022 09:18:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbiJSHSf (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 19 Oct 2022 03:18:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbiJSHSb (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 19 Oct 2022 03:18:31 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A956C7696D;
        Wed, 19 Oct 2022 00:18:30 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Mshm92Zd0z1P71B;
        Wed, 19 Oct 2022 15:13:45 +0800 (CST)
Received: from [10.67.110.173] (10.67.110.173) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 19 Oct 2022 15:17:58 +0800
Message-ID: <38d5fd39-ead2-e954-5901-b35ef6ec96b6@huawei.com>
Date:   Wed, 19 Oct 2022 15:17:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v5 2/2] ima: Handle -ESTALE returned by
 ima_filter_rule_match()
Content-Language: en-US
To:     Mimi Zohar <zohar@linux.ibm.com>, <dmitry.kasatkin@gmail.com>,
        <paul@paul-moore.com>, <jmorris@namei.org>, <serge@hallyn.com>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        Janne Karhunen <janne.karhunen@gmail.com>,
        Roberto Sassu <roberto.sassu@huawei.com>
References: <20220921125804.59490-1-guozihua@huawei.com>
 <20220921125804.59490-3-guozihua@huawei.com>
 <ce948f9e5639345026679b31a818cc12a247ce60.camel@linux.ibm.com>
 <77c9c86b-85a6-aa87-e084-59a70bb47167@huawei.com>
 <f321c638bf5572088a8c5e4d7027c3a797bdd568.camel@linux.ibm.com>
 <7ac3e330-e77c-95d8-7d3b-29e243b57251@huawei.com>
 <5e304b17fe709d2b2f30b991d5ffc4711d27a075.camel@linux.ibm.com>
 <2f032b6c-ecf2-5a41-dc38-e6ab0a2d7885@huawei.com>
 <90f8940cff5eeef7917e2b11a07e41b32b207ffa.camel@linux.ibm.com>
From:   "Guozihua (Scott)" <guozihua@huawei.com>
In-Reply-To: <90f8940cff5eeef7917e2b11a07e41b32b207ffa.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.110.173]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500024.china.huawei.com (7.185.36.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 2022/10/19 9:07, Mimi Zohar wrote:
> On Tue, 2022-10-18 at 16:43 +0800, Guozihua (Scott) wrote:
>> On 2022/9/28 22:11, Mimi Zohar wrote:
>>>
>>> After reviewing this patch set again, the code looks fine.  The commit
>>> message is still a bit off, but I've pushed the patch set out to next-
>>> integrity-testing, waiting for some Reviewed-by/Tested-by tags.
>>>
>>
>> Hi Mimi,
>>
>> How's this patch going? I see Roberto is replying with a Reviewed-by.
> 
> I'd really like to see a "Tested-by" tag as well.
> 
> Are you able to force the scenario?
> 

It's a race condition which could be hard to reproduce easily and in a 
stable manner. I'll give it a try.
-- 
Best
GUO Zihua

