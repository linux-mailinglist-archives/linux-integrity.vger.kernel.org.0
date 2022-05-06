Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AD6151CE3B
	for <lists+linux-integrity@lfdr.de>; Fri,  6 May 2022 04:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387929AbiEFBfc (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 5 May 2022 21:35:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232969AbiEFBfc (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 5 May 2022 21:35:32 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87BE51EEC7;
        Thu,  5 May 2022 18:31:49 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4KvY0v3h5Rz1JBmh;
        Fri,  6 May 2022 09:30:39 +0800 (CST)
Received: from [10.67.110.173] (10.67.110.173) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 6 May 2022 09:31:44 +0800
Message-ID: <b0937969-a915-b018-64a8-15cac392bf71@huawei.com>
Date:   Fri, 6 May 2022 09:31:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v3 1/1] ima: remove the IMA_TEMPLATE Kconfig option
Content-Language: en-US
To:     Mimi Zohar <zohar@linux.ibm.com>, <linux-integrity@vger.kernel.org>
CC:     <dmitry.kasatkin@gmail.com>, <roberto.sassu@huawei.com>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20220407021619.146410-1-guozihua@huawei.com>
 <20220407021619.146410-2-guozihua@huawei.com>
 <fbc9cda8eacc0a701d7b336bf45ecb6dfd450be9.camel@linux.ibm.com>
 <1f40a55b-7489-5e87-3584-73e2b1948615@huawei.com>
 <f7d8ebad78e184dd391b920f72ed7a49d3e14aa3.camel@linux.ibm.com>
From:   "Guozihua (Scott)" <guozihua@huawei.com>
In-Reply-To: <f7d8ebad78e184dd391b920f72ed7a49d3e14aa3.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.110.173]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500024.china.huawei.com (7.185.36.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 2022/5/5 20:39, Mimi Zohar wrote:
> On Thu, 2022-05-05 at 09:35 +0800, Guozihua (Scott) wrote:
>> Hi,
>>
>> Is this patch picked?
> 
> Yes, the patch is queued in next-integrity, which feeds into linux-
> next.  For the future, you can check
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git.
> 
Thanks Mimi!

-- 
Best
GUO Zihua
