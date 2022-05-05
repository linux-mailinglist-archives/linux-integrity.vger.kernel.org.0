Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08A5251B54A
	for <lists+linux-integrity@lfdr.de>; Thu,  5 May 2022 03:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235615AbiEEBjW (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 4 May 2022 21:39:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbiEEBjV (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 4 May 2022 21:39:21 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 082696175;
        Wed,  4 May 2022 18:35:43 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Ktx8l599GzhYFq;
        Thu,  5 May 2022 09:35:19 +0800 (CST)
Received: from [10.67.110.173] (10.67.110.173) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 5 May 2022 09:35:41 +0800
Message-ID: <1f40a55b-7489-5e87-3584-73e2b1948615@huawei.com>
Date:   Thu, 5 May 2022 09:35:40 +0800
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
From:   "Guozihua (Scott)" <guozihua@huawei.com>
In-Reply-To: <fbc9cda8eacc0a701d7b336bf45ecb6dfd450be9.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.110.173]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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

On 2022/4/7 22:43, Mimi Zohar wrote:
> On Thu, 2022-04-07 at 10:16 +0800, GUO Zihua wrote:
>> The original 'ima' measurement list template contains a hash, defined
>> as 20 bytes, and a null terminated pathname, limited to 255
>> characters.  Other measurement list templates permit both larger hashes
>> and longer pathnames.  When the "ima" template is configured as the
>> default, a new measurement list template (ima_template=) must be
>> specified before specifying a larger hash algorithm (ima_hash=) on the
>> boot command line.
>>
>> To avoid this boot command line ordering issue, remove the legacy "ima"
>> template configuration option, allowing it to still be specified on the
>> boot command line.
>>
>> The root cause of this issue is that during the processing of ima_hash,
>> we would try to check whether the hash algorithm is compatible with the
>> template. If the template is not set at the moment we do the check, we
>> check the algorithm against the configured default template. If the
>> default template is "ima", then we reject any hash algorithm other than
>> sha1 and md5.
>>
>> For example, if the compiled default template is "ima", and the default
>> algorithm is sha1 (which is the current default). In the cmdline, we put
>> in "ima_hash=sha256 ima_template=ima-ng". The expected behavior would be
>> that ima starts with ima-ng as the template and sha256 as the hash
>> algorithm. However, during the processing of "ima_hash=",
>> "ima_template=" has not been processed yet, and hash_setup would check
>> the configured hash algorithm against the compiled default: ima, and
>> reject sha256. So at the end, the hash algorithm that is actually used
>> will be sha1.
>>
>> With template "ima" removed from the configured default, we ensure that
>> the default tempalte would at least be "ima-ng" which allows for
>> basically any hash algorithm.
>>
>> This change would not break the algorithm compatibility checks for IMA.
>>
>> Fixes: 4286587dccd43 ("ima: add Kconfig default measurement list template")
>> Signed-off-by: GUO Zihua <guozihua@huawei.com>
> 
> thanks,
> 
> Mimi
> 
> 
> .

Hi,

Is this patch picked?

Thanks
GUO Zihua
