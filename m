Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 541514F8CBB
	for <lists+linux-integrity@lfdr.de>; Fri,  8 Apr 2022 05:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233322AbiDHBOi (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 7 Apr 2022 21:14:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233268AbiDHBOh (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 7 Apr 2022 21:14:37 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9AA3C5B;
        Thu,  7 Apr 2022 18:12:35 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4KZKwP0q0Kz1HBcj;
        Fri,  8 Apr 2022 09:12:05 +0800 (CST)
Received: from [10.67.110.173] (10.67.110.173) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 8 Apr 2022 09:12:28 +0800
Message-ID: <2e85965d-2060-7488-85b0-3735b5e87c62@huawei.com>
Date:   Fri, 8 Apr 2022 09:12:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3 0/1] ima: fix boot command line issue
Content-Language: en-US
To:     Mimi Zohar <zohar@linux.ibm.com>, <linux-integrity@vger.kernel.org>
CC:     <dmitry.kasatkin@gmail.com>, <roberto.sassu@huawei.com>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20220407021619.146410-1-guozihua@huawei.com>
 <d4ac7695a9a2be9750c62218bb3c262d28367208.camel@linux.ibm.com>
From:   "Guozihua (Scott)" <guozihua@huawei.com>
In-Reply-To: <d4ac7695a9a2be9750c62218bb3c262d28367208.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.110.173]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500024.china.huawei.com (7.185.36.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 2022/4/7 20:46, Mimi Zohar wrote:
> On Thu, 2022-04-07 at 10:16 +0800, GUO Zihua wrote:
>> Change log:
>>    v3:
>>      Update commit message following Mimi's advice, update comments for
>>      config.
>>    v2:
>>      update commit message and subject following Mimi's advice. Remove
>>      references for CONFIG_IMA_TEMPLATE as well.
> 
> For future referece, the change log can be added after the break line
> (---) in the patch itself.  No need for a cover letter for a single
> patch.
> 
> thanks,
> 
> Mimi
> 
> 
> .

Thanks Mimi, will do this next time.

-- 
Best
GUO Zihua
