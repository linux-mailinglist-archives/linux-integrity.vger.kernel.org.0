Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2FDF62F0C5
	for <lists+linux-integrity@lfdr.de>; Fri, 18 Nov 2022 10:15:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241827AbiKRJPK (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 18 Nov 2022 04:15:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241857AbiKRJO5 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 18 Nov 2022 04:14:57 -0500
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA7DF82BD4;
        Fri, 18 Nov 2022 01:14:53 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4ND9tC0d7nz9v7Hk;
        Fri, 18 Nov 2022 17:08:03 +0800 (CST)
Received: from [10.206.134.65] (unknown [10.206.134.65])
        by APP2 (Coremail) with SMTP id GxC2BwAXS_fsTHdj5+RzAA--.21752S2;
        Fri, 18 Nov 2022 10:14:29 +0100 (CET)
Message-ID: <fe16a03a-102e-b3e1-cc3f-5bad3c28fad7@huaweicloud.com>
Date:   Fri, 18 Nov 2022 10:14:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v4 3/5] security: Allow all LSMs to provide xattrs for
 inode_init_security hook
Content-Language: en-US
To:     Mimi Zohar <zohar@linux.ibm.com>, dmitry.kasatkin@gmail.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        stephen.smalley.work@gmail.com, eparis@parisplace.org,
        casey@schaufler-ca.com
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        reiserfs-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        keescook@chromium.org, nicolas.bouchinet@clip-os.org,
        Roberto Sassu <roberto.sassu@huawei.com>
References: <20221110094639.3086409-1-roberto.sassu@huaweicloud.com>
 <20221110094639.3086409-4-roberto.sassu@huaweicloud.com>
 <4c1349f670dc3c23214a5a5036e43ddaa0a7bc89.camel@linux.ibm.com>
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
In-Reply-To: <4c1349f670dc3c23214a5a5036e43ddaa0a7bc89.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: GxC2BwAXS_fsTHdj5+RzAA--.21752S2
X-Coremail-Antispam: 1UD129KBjvJXoW3GFyrAw4UtFWrGw1xJw4UCFg_yoW3Zr13pr
        WUKa1j9rn5JFy8WrySyr48u3WagrWrKF47GrsxGFyjya1qvrn7tryF9rW5CFykXrZ5Jr4v
        va1qyrsxWwn8AaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
        07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
        02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_
        WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
        CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE
        14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf
        9x07UdxhLUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAABF1jj4GVqAABsK
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 11/17/2022 5:05 PM, Mimi Zohar wrote:
> hOn Thu, 2022-11-10 at 10:46 +0100, Roberto Sassu wrote:
>> From: Roberto Sassu <roberto.sassu@huawei.com>
>>
>> Currently, security_inode_init_security() supports only one LSM providing
>> an xattr and EVM calculating the HMAC on that xattr, plus other inode
>> metadata.
>>
>> Allow all LSMs to provide one or multiple xattrs, by extending the security
>> blob reservation mechanism. Introduce the new lbs_xattr field of the
>> lsm_blob_sizes structure, so that each LSM can specify how many xattrs it
>> needs, and the LSM infrastructure knows how many xattr slots it should
>> allocate.
> 
> Perhaps supporting per LSM multiple xattrs is a nice idea, but EVM
> doesn't currently support it.  The LSM xattrs are hard coded in
> evm_config_default_xattrnames[],  based on whether the LSM is
> configured.  Additional security xattrs may be included in the
> security.evm calculation, by extending the list via
> security/integrity/evm/evm_xattrs.

EVM wouldn't notice whether it is the same LSM that provide multiple 
xattrs or multiple LSMs provided one xattr. As long as the xattr array 
contains consecutive xattrs, that would be fine. In the IMA/EVM test I 
included a test case where an LSM provides two xattrs (seems to work fine).

>> Dynamically allocate the xattrs array to be populated by LSMs with the
>> inode_init_security hook, and pass it to the latter instead of the
>> name/value/len triple.
>>
>> Since the LSM infrastructure, at initialization time, updates the number of
>> the requested xattrs provided by each LSM with a corresponding offset in
>> the security blob (in this case the xattr array), it makes straightforward
>> for an LSM to access the right position in the xattr array.
>>
>> There is still the issue that an LSM might not fill the xattr, even if it
>> requests it (legitimate case, for example it might have been loaded but not
>> initialized with a policy). Since users of the xattr array (e.g. the
>> initxattrs() callbacks) detect the end of the xattr array by checking if
>> the xattr name is NULL, not filling an xattr would cause those users to
>> stop scanning xattrs prematurely.
>>
>> Solve that issue by introducing security_check_compact_xattrs(), which does
>> a basic check of the xattr array (if the xattr name is filled, the xattr
>> value should be too, and viceversa), and compacts the xattr array by
>> removing the holes.
>>
>> An alternative solution would be to let users of the xattr array know the
>> number of elements of the xattr array, so that they don't have to check the
>> termination. However, this seems more invasive, compared to a simple move
>> of few array elements.
>>
>> Finally, adapt both SELinux and Smack to use the new definition of the
>> inode_init_security hook, and to correctly fill the designated slots in the
>> xattr array.
>>
>> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
>> ---
> 
>> diff --git a/security/security.c b/security/security.c
>> index a0e9b4ce2341..b62f192de6da 100644
>> --- a/security/security.c
>> +++ b/security/security.c
>> @@ -30,8 +30,6 @@
>>   #include <linux/msg.h>
>>   #include <net/flow.h>
>>   
>> -#define MAX_LSM_EVM_XATTR	2
>> -
>>   /* How many LSMs were built into the kernel? */
>>   #define LSM_COUNT (__end_lsm_info - __start_lsm_info)
>>   
>> @@ -210,6 +208,7 @@ static void __init lsm_set_blob_sizes(struct lsm_blob_sizes *needed)
>>   	lsm_set_blob_size(&needed->lbs_msg_msg, &blob_sizes.lbs_msg_msg);
>>   	lsm_set_blob_size(&needed->lbs_superblock, &blob_sizes.lbs_superblock);
>>   	lsm_set_blob_size(&needed->lbs_task, &blob_sizes.lbs_task);
>> +	lsm_set_blob_size(&needed->lbs_xattr, &blob_sizes.lbs_xattr);
>>   }
>>   
>>   /* Prepare LSM for initialization. */
>> @@ -346,6 +345,7 @@ static void __init ordered_lsm_init(void)
>>   	init_debug("msg_msg blob size    = %d\n", blob_sizes.lbs_msg_msg);
>>   	init_debug("superblock blob size = %d\n", blob_sizes.lbs_superblock);
>>   	init_debug("task blob size       = %d\n", blob_sizes.lbs_task);
>> +	init_debug("xattr slots          = %d\n", blob_sizes.lbs_xattr);
>>   
>>   	/*
>>   	 * Create any kmem_caches needed for blobs
>> @@ -1100,34 +1100,78 @@ static int security_initxattrs(struct inode *inode, const struct xattr *xattrs,
>>   	return 0;
>>   }
> 
>> +static int security_check_compact_xattrs(struct xattr *xattrs,
>> +					 int num_xattrs, int *checked_xattrs)
> 
> Perhaps the variable naming is off, making it difficult to read.   So
> although this is a static function, which normally doesn't require a
> comment, it's definitely needs one.

Ok, will improve it.

>> +{
>> +	int i;
>> +
>> +	for (i = *checked_xattrs; i < num_xattrs; i++) {
> 
> If the number of "checked" xattrs was kept up to date, removing the
> empty xattr gaps wouldn't require a loop.  Is the purpose of this loop
> to support multiple per LSM xattrs?

An LSM might reserve one or more xattrs, but not set it/them (for 
example because it is not initialized). In this case, removing the gaps 
is needed for all subsequent LSMs.

>> +		if ((!xattrs[i].name && xattrs[i].value) ||
>> +		    (xattrs[i].name && !xattrs[i].value))
>> +			return -EINVAL;
>> +
>> +		if (!xattrs[i].name)
>> +			continue;
>> +
>> +		if (i == *checked_xattrs) {
>> +			(*checked_xattrs)++;
>> +			continue;
>> +		}
>> +
>> +		memcpy(xattrs + (*checked_xattrs)++, xattrs + i,
>> +		       sizeof(*xattrs));
>> +		memset(xattrs + i, 0, sizeof(*xattrs));
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>>   int security_inode_init_security(struct inode *inode, struct inode *dir,
>>   				 const struct qstr *qstr,
>>   				 const initxattrs initxattrs, void *fs_data)
>>   {
>> -	struct xattr new_xattrs[MAX_LSM_EVM_XATTR + 1];
>> -	struct xattr *lsm_xattr, *evm_xattr, *xattr;
>> -	int ret = -EOPNOTSUPP;
>> +	struct security_hook_list *P;
>> +	struct xattr *new_xattrs;
>> +	struct xattr *xattr;
>> +	int ret = -EOPNOTSUPP, cur_xattrs = 0;
>>   
>>   	if (unlikely(IS_PRIVATE(inode)))
>>   		goto out_exit;
>>   
>> +	if (!blob_sizes.lbs_xattr)
>> +		goto out_exit;
>> +
>>   	if (!initxattrs ||
>>   	    (initxattrs == &security_initxattrs && !fs_data)) {
>>   		ret = call_int_hook(inode_init_security, -EOPNOTSUPP, inode,
>> -				    dir, qstr, NULL, NULL, NULL);
>> +				    dir, qstr, NULL);
>>   		goto out_exit;
>>   	}
>> -	memset(new_xattrs, 0, sizeof(new_xattrs));
>> -	lsm_xattr = new_xattrs;
>> -	ret = call_int_hook(inode_init_security, -EOPNOTSUPP, inode, dir, qstr,
>> -						&lsm_xattr->name,
>> -						&lsm_xattr->value,
>> -						&lsm_xattr->value_len);
>> -	if (ret)
>> -		goto out;
>> +	/* Allocate +1 for EVM and +1 as terminator. */
>> +	new_xattrs = kcalloc(blob_sizes.lbs_xattr + 2, sizeof(*new_xattrs),
>> +			     GFP_NOFS);
>> +	if (!new_xattrs) {
>> +		ret = -ENOMEM;
>> +		goto out_exit;
>> +	}
>> +	hlist_for_each_entry(P, &security_hook_heads.inode_init_security,
>> +			     list) {
>> +		ret = P->hook.inode_init_security(inode, dir, qstr, new_xattrs);
>> +		if (ret && ret != -EOPNOTSUPP)
>> +			goto out;
>> +		if (ret == -EOPNOTSUPP)
>> +			continue;
>> +		ret = security_check_compact_xattrs(new_xattrs,
>> +						    blob_sizes.lbs_xattr,
>> +						    &cur_xattrs);
> 
> Defining a variable named "cur_xattrs" to indicate the number of xattrs
> compressed is off.  Perhaps use cur_num_xattrs?   Similarly,
> "checked_xattrs" should be num_checked_xattrs.  Or change the existing
> num_xattrs to max_num_xattrs and rename checked_xattrs to num_xattrs.

Ok.

Thanks

Roberto

> thanks,
> 
> Mimi
> 
>> +		if (ret < 0) {
>> +			ret = -ENOMEM;
>> +			goto out;
>> +		}
>> +	}
>>   
>> -	evm_xattr = lsm_xattr + 1;
>> -	ret = evm_inode_init_security(inode, lsm_xattr, evm_xattr);
>> +	ret = evm_inode_init_security(inode, new_xattrs,
>> +				      new_xattrs + cur_xattrs);
>>   	if (ret)
>>   		goto out;
>>   	ret = initxattrs(inode, new_xattrs, fs_data);
>> @@ -1142,6 +1186,7 @@ int security_inode_init_security(struct inode *inode, struct inode *dir,
>>   			continue;
>>   		kfree(xattr->value);
>>   	}
>> +	kfree(new_xattrs);
>>   out_exit:
>>   	if (initxattrs == &security_initxattrs)
>>   		return ret;

