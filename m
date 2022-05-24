Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC38A532076
	for <lists+linux-integrity@lfdr.de>; Tue, 24 May 2022 03:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232561AbiEXB6a (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 23 May 2022 21:58:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232572AbiEXB62 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 23 May 2022 21:58:28 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E483C7C147;
        Mon, 23 May 2022 18:58:27 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4L6ckx0ZrKzfbMN;
        Tue, 24 May 2022 09:56:57 +0800 (CST)
Received: from [10.67.110.173] (10.67.110.173) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 24 May 2022 09:58:25 +0800
Message-ID: <7c5cc1eb-5248-3207-92e8-e23752ab01fb@huawei.com>
Date:   Tue, 24 May 2022 09:58:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] keys: Use struct_size and size_add helper with alloc
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>
CC:     <linux-integrity@vger.kernel.org>, <zohar@linux.ibm.com>,
        <dhowells@redhat.com>, <keyrings@vger.kernel.org>
References: <20220519024702.215223-1-guozihua@huawei.com>
 <YoatVbXu5g6f7gD7@iki.fi> <0563f30f-f5c5-f202-9091-a8ce095057e5@huawei.com>
 <YovnVMxsd2aZ9hF8@kernel.org>
From:   "Guozihua (Scott)" <guozihua@huawei.com>
In-Reply-To: <YovnVMxsd2aZ9hF8@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.110.173]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500024.china.huawei.com (7.185.36.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 2022/5/24 3:58, Jarkko Sakkinen wrote:
> On Fri, May 20, 2022 at 03:35:09PM +0800, Guozihua (Scott) wrote:
>> On 2022/5/20 4:49, Jarkko Sakkinen wrote:
>>> On Thu, May 19, 2022 at 10:47:02AM +0800, GUO Zihua wrote:
>>>> Use struct_size helper for calculating size of flexible struct to avoid
>>>> potential issues and improve readibility. Use size_add to calculate
>>>> addition of size to prevent potential issues.
>>>
>>> What issues? Please explicitly state the issues.
>>>
>>> BR, Jarkko
>>> .
>>
>> Hi Jarkko,
>>
>> This is a clean-up/optimization patch mostly focuses on readability and no
>> actual issue is observed at the moment.
> 
> But the commit message is talking about potential issues.
> 
> BR, Jarkko
> .
Thanks Jarkko.

Yes, and it should be considered wrong. I've sent a v2 patch addressing 
this.

-- 
Best
GUO Zihua
