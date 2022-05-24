Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA25E532064
	for <lists+linux-integrity@lfdr.de>; Tue, 24 May 2022 03:50:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232788AbiEXBuu (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 23 May 2022 21:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232783AbiEXBus (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 23 May 2022 21:50:48 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D91373797;
        Mon, 23 May 2022 18:50:47 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4L6cZg4bQgzjWy7;
        Tue, 24 May 2022 09:49:47 +0800 (CST)
Received: from [10.67.110.173] (10.67.110.173) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 24 May 2022 09:50:45 +0800
Message-ID: <eff46c7a-fc9d-637e-764c-22abc9eedf65@huawei.com>
Date:   Tue, 24 May 2022 09:50:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v2] keys: Use struct_size and size_add helper with alloc
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>
CC:     <linux-integrity@vger.kernel.org>, <zohar@linux.ibm.com>,
        <dhowells@redhat.com>, <keyrings@vger.kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
References: <20220523014155.27840-1-guozihua@huawei.com>
 <YovrxNMktll1Q61T@kernel.org>
From:   "Guozihua (Scott)" <guozihua@huawei.com>
In-Reply-To: <YovrxNMktll1Q61T@kernel.org>
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

Thanks for the feedback Jarkko.

Including Gustavo in the CC list as they are the maintainer of the 
corresponding KSPP issue.

On 2022/5/24 4:17, Jarkko Sakkinen wrote:
> On Mon, May 23, 2022 at 09:41:55AM +0800, GUO Zihua wrote:
>> Use struct_size helper for calculating size of flexible struct, following
>> the best practice.
>>
>> Reference: https://lore.kernel.org/all/CAHk-=wiGWjxs7EVUpccZEi6esvjpHJdgHQ=vtUeJ5crL62hx9A@mail.gmail.com/
>>
>> Note: HASH_SIZE here is a SHA256_DIGEST_SIZE whoes value is 32, so
>> adding 1 should be fine here.
>>
>> Signed-off-by: GUO Zihua <guozihua@huawei.com>
> 
> Instead
> 
> """
> Link: https://lore.kernel.org/all/CAHk-=wiGWjxs7EVUpccZEi6esvjpHJdgHQ=vtUeJ5crL62hx9A@mail.gmail.com/
> Signed-off-by: GUO Zihua <guozihua@huawei.com>
> """
> 
> You should split this into two patches as said in
> https://www.kernel.org/doc/html/latest/process/submitting-patches.html#separate-your-changes
> 
> Also these are bug fixes and the commit message does not contain
> any description of the issue, e.g.

Thing is, it's not fixing any bug per se. It's a cleanup patch, updating 
codes calculating size of a variable-sized structure to the best 
practice. Should I still separate the patch in this case.
> 
> """
> When issuing
> 
> CF='-Wflexible-array-sizeof' make C=2 security/keys/encrypted-keys/encrypted.o
> 
> the following is observed:
> 
> security/keys/encrypted-keys/encrypted.c:670:28: warning: using sizeof on a flexible structure
> security/keys/encrypted-keys/encrypted.c: note: in included file:
> """
> 
> And then explain why struct_size() addresses this issue, and provide
> Fixes tag.

Struct_size is a macro that make use of sizeof under the hood. So 
struct_size does not actually address these warnings. However, the usage 
of struct_size for calculating size of variable-sized structure is 
suggested by Linus as the best pratice.
> 
>>
>> ---
>>
>> v2:
>>      Update the commit message, removing the part about "potential issue"
>>      following Jarkko's suggestion.
>>
>> ---
>>   security/keys/encrypted-keys/encrypted.c | 7 +++++--
>>   security/keys/user_defined.c             | 2 +-
>>   2 files changed, 6 insertions(+), 3 deletions(-)
>>
>> diff --git a/security/keys/encrypted-keys/encrypted.c b/security/keys/encrypted-keys/encrypted.c
>> index e05cfc2e49ae..37349580e855 100644
>> --- a/security/keys/encrypted-keys/encrypted.c
>> +++ b/security/keys/encrypted-keys/encrypted.c
>> @@ -613,6 +613,7 @@ static struct encrypted_key_payload *encrypted_key_alloc(struct key *key,
>>   	long dlen;
>>   	int i;
>>   	int ret;
>> +	size_t epayload_datalen = 0;
>>   
>>   	ret = kstrtol(datalen, 10, &dlen);
>>   	if (ret < 0 || dlen < MIN_DATA_SIZE || dlen > MAX_DATA_SIZE)
>> @@ -667,8 +668,10 @@ static struct encrypted_key_payload *encrypted_key_alloc(struct key *key,
>>   	if (ret < 0)
>>   		return ERR_PTR(ret);
>>   
>> -	epayload = kzalloc(sizeof(*epayload) + payload_datalen +
>> -			   datablob_len + HASH_SIZE + 1, GFP_KERNEL);
>> +	epayload_datalen = size_add(payload_datalen, datablob_len);
>> +	epayload_datalen = size_add(epayload_datalen, HASH_SIZE + 1);
>> +	epayload = kzalloc(struct_size(epayload, payload_data,
>> +				epayload_datalen), GFP_KERNEL);
>>   	if (!epayload)
>>   		return ERR_PTR(-ENOMEM);
>>   
>> diff --git a/security/keys/user_defined.c b/security/keys/user_defined.c
>> index 749e2a4dcb13..334fed36e9f3 100644
>> --- a/security/keys/user_defined.c
>> +++ b/security/keys/user_defined.c
>> @@ -64,7 +64,7 @@ int user_preparse(struct key_preparsed_payload *prep)
>>   	if (datalen <= 0 || datalen > 32767 || !prep->data)
>>   		return -EINVAL;
>>   
>> -	upayload = kmalloc(sizeof(*upayload) + datalen, GFP_KERNEL);
>> +	upayload = kmalloc(struct_size(upayload, data, datalen), GFP_KERNEL);
>>   	if (!upayload)
>>   		return -ENOMEM;
>>   
>> -- 
>> 2.36.0
>>
> 
> BR, Jarkko
> .


-- 
Best
GUO Zihua
