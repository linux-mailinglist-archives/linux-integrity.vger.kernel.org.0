Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBFAE6274F6
	for <lists+linux-integrity@lfdr.de>; Mon, 14 Nov 2022 04:31:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235348AbiKNDbM (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 13 Nov 2022 22:31:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235644AbiKNDbK (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 13 Nov 2022 22:31:10 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CA411583A;
        Sun, 13 Nov 2022 19:31:09 -0800 (PST)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4N9ZZk6fBszHvrS;
        Mon, 14 Nov 2022 11:30:38 +0800 (CST)
Received: from [10.67.110.173] (10.67.110.173) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 14 Nov 2022 11:31:07 +0800
Message-ID: <0d38023a-1f7f-b090-bd55-4695afcf564f@huawei.com>
Date:   Mon, 14 Nov 2022 11:31:07 +0800
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
 <38d5fd39-ead2-e954-5901-b35ef6ec96b6@huawei.com>
 <11716411-e143-ab1f-3b1e-d5d35f2a590a@huawei.com>
 <db821df65b7ff7319c657a1de65f5ba903599fc4.camel@linux.ibm.com>
 <b2949b3d-c370-8a41-fe7c-9f175abd4f71@huawei.com>
 <30ac558a35a0551f50dc49a834755beb1ab2d593.camel@linux.ibm.com>
From:   "Guozihua (Scott)" <guozihua@huawei.com>
In-Reply-To: <30ac558a35a0551f50dc49a834755beb1ab2d593.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.110.173]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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

On 2022/11/3 21:15, Mimi Zohar wrote:
> On Wed, 2022-11-02 at 09:42 +0800, Guozihua (Scott) wrote:
>>> As I only see an IMA measurement policy rule being loaded for
>>> "unlabeled_t" and not "user_home_t", should I assume that an IMA
>>> measurement rule already exists for "user_home_t"?
>>
>> There wasn't a rule for user_home_t. These scripts demonstrate that
>> during a selinux policy reload, IMA would measure files that is not in
>> the range of it's LSM based rules. Which is the issue I am trying to fix.
>>
>> In this test, we only have one rule for measuring files of type
>> unlabeled_t. However, during selinux policy reload, file of user_home_t
>> is also measured.
> 
> Thanks, Scott.  After tweaking the scripts for my system, I was able to
> reproduce the bug.  This patch set is now queued in next-integrity.
> 

Hi Mimi,

Any chance these patches would be in 6.1?
-- 
Best
GUO Zihua

