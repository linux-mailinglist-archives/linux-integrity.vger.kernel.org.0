Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40B3454716F
	for <lists+linux-integrity@lfdr.de>; Sat, 11 Jun 2022 04:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349068AbiFKCiN (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 10 Jun 2022 22:38:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346449AbiFKCiL (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 10 Jun 2022 22:38:11 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5445326065D;
        Fri, 10 Jun 2022 19:38:10 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LKhmX1MWxzjXNV;
        Sat, 11 Jun 2022 10:36:44 +0800 (CST)
Received: from [10.67.110.173] (10.67.110.173) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 11 Jun 2022 10:38:08 +0800
Message-ID: <2df1631b-3c3c-be97-0e93-a1ade05828c2@huawei.com>
Date:   Sat, 11 Jun 2022 10:38:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH -next] Revert "evm: Fix memleak in init_desc"
Content-Language: en-US
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Xiu Jianfeng <xiujianfeng@huawei.com>,
        <dmitry.kasatkin@gmail.com>, <jmorris@namei.org>,
        <serge@hallyn.com>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20220527111726.195825-1-xiujianfeng@huawei.com>
 <5842536c5c2bde1e3c2840f7e877becc3282b47c.camel@linux.ibm.com>
From:   "Guozihua (Scott)" <guozihua@huawei.com>
In-Reply-To: <5842536c5c2bde1e3c2840f7e877becc3282b47c.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.110.173]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500024.china.huawei.com (7.185.36.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 2022/6/10 22:20, Mimi Zohar wrote:
> On Fri, 2022-05-27 at 19:17 +0800, Xiu Jianfeng wrote:
>> This reverts commit ccf11dbaa07b328fa469415c362d33459c140a37.
>>
>> Commit ccf11dbaa07b ("evm: Fix memleak in init_desc") said there is
>> memleak in init_desc. That may be incorrect, as we can see, tmp_tfm is
>> saved in one of the two global variables hmac_tfm ohr evm_tfm[hash_algo],
>> then if init_desc is called next time, there is no need to alloc tfm
>> again, so in the error path of kmalloc desc or crypto_shash_init(desc),
>> It is not a problem without freeing tmp_tfm.
>>
>> And also that commit did not reset the global variable to NULL after
>> freeing tmp_tfm and this makes *tfm a dangling pointer which may cause a
>> UAF issue.
>>
>> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
> 
> Agreed, thanks.  This was first reported by Guozihua (Scott) <
> guozihua@huawei.com>.  If neither you nor Scott object, I'll add his
> Reported-by tag.
> 
> thanks,
> 
> Mimi
> 
> .

Good for me.

-- 
Best
GUO Zihua
