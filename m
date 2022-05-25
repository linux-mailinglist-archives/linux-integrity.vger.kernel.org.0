Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 712125334F9
	for <lists+linux-integrity@lfdr.de>; Wed, 25 May 2022 03:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241131AbiEYBuW (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 24 May 2022 21:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235156AbiEYBuU (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 24 May 2022 21:50:20 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE34E15823;
        Tue, 24 May 2022 18:50:18 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4L7DW24HjLzgYGk;
        Wed, 25 May 2022 09:48:46 +0800 (CST)
Received: from [10.67.110.173] (10.67.110.173) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 25 May 2022 09:50:16 +0800
Message-ID: <61ffe974-8e15-6682-d53a-90df89dcb28a@huawei.com>
Date:   Wed, 25 May 2022 09:50:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [RESEND] evm: Refector struct evm_xattr
Content-Language: en-US
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
CC:     <linux-integrity@vger.kernel.org>, <zohar@linux.ibm.com>,
        <dmitry.kasatkin@gmail.com>, <linux-hardening@vger.kernel.org>
References: <20220518011439.184809-1-guozihua@huawei.com>
 <20220518051326.GB16144@embeddedor>
From:   "Guozihua (Scott)" <guozihua@huawei.com>
In-Reply-To: <20220518051326.GB16144@embeddedor>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.110.173]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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

On 2022/5/18 13:13, Gustavo A. R. Silva wrote:
> On Wed, May 18, 2022 at 09:14:39AM +0800, GUO Zihua wrote:
>> struct evm_xattr is only used for EVM_XATTR_HMAC type evm digest and is
>> glued together one flexible array and one fixed length array. The
>> original intention seems to be shortening the code as the "data" field
>> would always be a SHA1 digest.
>>
>> This implementation is not complying with GCC's specification about
>> flexible array and spars yield the following warning:
> 
> The sparse warning has nothing to do with any GCC specification. It's
> perfectly fine to apply the sizeof operator to a struct-with-flex-array.
> However, it might be suspicious if the intention is to also get the
> _dynamic_ size of the flexible array, because in that case the size of
> the flex array is always zero. See the example below:
> 
> 	struct foo {
> 		uint8_t len;
> 		struct boo data[];
> 	};
> 
> 	sizeof(struct foo) == 1
> 
> Also, you sent this patch twice in the last 24 hours. Give the maintainers
> time to review your patch (usually a couple of weeks) before resending it.
> 
>>
>> security/integrity/evm/evm_main.c:852:30: warning: using sizeof on a flexible
>> structure
>> security/integrity/evm/evm_main.c:862:32: warning: using sizeof on a flexible
>> structure
> 
> Regarding the warnings above, please take a look at my response to your
> other patch (the same applies in this case). :)
> 
> Thanks
> --
> Gustavo
> 
>>
>> Fix it by:
>> 1. Remove struct evm_xattr and use struct evm_ima_xattr_data directly.
>> 2. Get array size with struct_size instead of sizeof.
>>
>> Reference: https://github.com/KSPP/linux/issues/174
>>
>> Fixes: 6be5cc5246f80 ("evm: add support for different security.evm data types")
>> Signed-off-by: GUO Zihua <guozihua@huawei.com>
>> ---
>>   security/integrity/evm/evm_main.c | 14 ++++++++------
>>   security/integrity/integrity.h    |  6 ------
>>   2 files changed, 8 insertions(+), 12 deletions(-)
>>
>> diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
>> index 7d87772f0ce6..f2c4501a287a 100644
>> --- a/security/integrity/evm/evm_main.c
>> +++ b/security/integrity/evm/evm_main.c
>> @@ -211,7 +211,8 @@ static enum integrity_status evm_verify_hmac(struct dentry *dentry,
>>   	/* check value type */
>>   	switch (xattr_data->type) {
>>   	case EVM_XATTR_HMAC:
>> -		if (xattr_len != sizeof(struct evm_xattr)) {
>> +		if (xattr_len != struct_size(*xattr_data, data,
>> +					     SHA1_DIGEST_SIZE)) {
>>   			evm_status = INTEGRITY_FAIL;
>>   			goto out;
>>   		}
>> @@ -842,24 +843,25 @@ int evm_inode_init_security(struct inode *inode,
>>   				 const struct xattr *lsm_xattr,
>>   				 struct xattr *evm_xattr)
>>   {
>> -	struct evm_xattr *xattr_data;
>> +	struct evm_ima_xattr_data *xattr_data;
>>   	int rc;
>>   
>>   	if (!(evm_initialized & EVM_INIT_HMAC) ||
>>   	    !evm_protected_xattr(lsm_xattr->name))
>>   		return 0;
>>   
>> -	xattr_data = kzalloc(sizeof(*xattr_data), GFP_NOFS);
>> +	xattr_data = kzalloc(struct_size(*xattr_data, data,
>> +			     SHA1_DIGEST_SIZE), GFP_NOFS);
>>   	if (!xattr_data)
>>   		return -ENOMEM;
>>   
>> -	xattr_data->data.type = EVM_XATTR_HMAC;
>> -	rc = evm_init_hmac(inode, lsm_xattr, xattr_data->digest);
>> +	xattr_data->type = EVM_XATTR_HMAC;
>> +	rc = evm_init_hmac(inode, lsm_xattr, xattr_data->data);
>>   	if (rc < 0)
>>   		goto out;
>>   
>>   	evm_xattr->value = xattr_data;
>> -	evm_xattr->value_len = sizeof(*xattr_data);
>> +	evm_xattr->value_len = struct_size(*xattr_data, data, SHA1_DIGEST_SIZE);
>>   	evm_xattr->name = XATTR_EVM_SUFFIX;
>>   	return 0;
>>   out:
>> diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
>> index 3510e413ea17..91b16d620dd9 100644
>> --- a/security/integrity/integrity.h
>> +++ b/security/integrity/integrity.h
>> @@ -86,12 +86,6 @@ struct evm_ima_xattr_data {
>>   	u8 data[];
>>   } __packed;
>>   
>> -/* Only used in the EVM HMAC code. */
>> -struct evm_xattr {
>> -	struct evm_ima_xattr_data data;
>> -	u8 digest[SHA1_DIGEST_SIZE];
>> -} __packed;
>> -
>>   #define IMA_MAX_DIGEST_SIZE	64
>>   
>>   struct ima_digest_data {
>> -- 
>> 2.36.0
>>
> .
Thanks Gustavo!

I'm still pretty new to the community so your feedback is much appreciated!

-- 
Best
GUO Zihua
