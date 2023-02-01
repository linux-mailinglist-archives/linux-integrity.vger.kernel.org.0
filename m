Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D00D6685FDE
	for <lists+linux-integrity@lfdr.de>; Wed,  1 Feb 2023 07:42:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbjBAGmZ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 1 Feb 2023 01:42:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjBAGmY (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 1 Feb 2023 01:42:24 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3800D144B9;
        Tue, 31 Jan 2023 22:42:23 -0800 (PST)
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4P6C373FcVz16MpL;
        Wed,  1 Feb 2023 14:40:19 +0800 (CST)
Received: from [10.67.110.112] (10.67.110.112) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Wed, 1 Feb 2023 14:42:21 +0800
Message-ID: <701ef534-f716-efa4-15bc-f69b45e11bf7@huawei.com>
Date:   Wed, 1 Feb 2023 14:42:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH -next] evm: Use __vfs_setxattr() to update security.evm
To:     Mimi Zohar <zohar@linux.ibm.com>,
        "Guozihua (Scott)" <guozihua@huawei.com>,
        <dmitry.kasatkin@gmail.com>, <paul@paul-moore.com>,
        <jmorris@namei.org>, <serge@hallyn.com>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20221228030248.94285-1-xiujianfeng@huawei.com>
 <3c34c1e8c74722110e5d7e87146b090791734916.camel@linux.ibm.com>
 <f90bd732-a3a0-80b5-07ce-386500b12968@huawei.com>
 <1c7d861a143106e56cfe382d1ab6c293fa43aff1.camel@linux.ibm.com>
Content-Language: en-US
From:   xiujianfeng <xiujianfeng@huawei.com>
In-Reply-To: <1c7d861a143106e56cfe382d1ab6c293fa43aff1.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.110.112]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500023.china.huawei.com (7.185.36.114)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi,

On 2023/1/31 19:31, Mimi Zohar wrote:
> On Mon, 2023-01-30 at 09:53 +0800, Guozihua (Scott) wrote:
>> On 2023/1/19 5:45, Mimi Zohar wrote:
>>> On Wed, 2022-12-28 at 11:02 +0800, Xiu Jianfeng wrote:
>>>> Currently it uses __vfs_setxattr_noperm() to update "security.evm",
>>>> however there are two lsm hooks(inode_post_setxattr and inode_setsecurity)
>>>> being called inside this function, which don't make any sense for xattr
>>>> "security.evm", because the handlers of these two hooks, such as selinux
>>>> and smack, only care about their own xattr.
>>>
>>> Updating the security.ima hash triggers re-calculating and writing the
>>> security.evm HMAC.  Refer to evm_inode_post_setxattr().
>>
>> Hi Mimi,
>>
>> I believe what Jianfeng is trying to do is to avoid re-triggering
>> security_inode_post_setxattr if we are updating security.evm. I can't
>> think of any other xattr that could "absorb" security.evm.
> 
> I understand.  Comments below ...
>>>
>>>>
>>>> On the other hand, there is a literally rather than actually cyclical
>>>> callchain as follows:
>>>> security_inode_post_setxattr
>>>>   ->evm_inode_post_setxattr
>>>>     ->evm_update_evmxattr
>>>>       ->__vfs_setxattr_noperm
>>>>         ->security_inode_post_setxattr
>>>>
>>>> So use __vfs_setxattr() to update "security.evm".
>>>>
>>>> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
>>>> ---
>>>>  security/integrity/evm/evm_crypto.c   | 7 +++----
>>>>  security/integrity/ima/ima_appraise.c | 8 ++++----
>>>>  2 files changed, 7 insertions(+), 8 deletions(-)
>>>>
>>>> diff --git a/security/integrity/evm/evm_crypto.c b/security/integrity/evm/evm_crypto.c
>>>> index fa5ff13fa8c9..d8275dfa49ef 100644
>>>> --- a/security/integrity/evm/evm_crypto.c
>>>> +++ b/security/integrity/evm/evm_crypto.c
>>>> @@ -376,10 +376,9 @@ int evm_update_evmxattr(struct dentry *dentry, const char *xattr_name,
>>>>  			   xattr_value_len, &data);
>>>>  	if (rc == 0) {
>>>>  		data.hdr.xattr.sha1.type = EVM_XATTR_HMAC;
>>>> -		rc = __vfs_setxattr_noperm(&init_user_ns, dentry,
>>>> -					   XATTR_NAME_EVM,
>>>> -					   &data.hdr.xattr.data[1],
>>>> -					   SHA1_DIGEST_SIZE + 1, 0);
>>>> +		rc = __vfs_setxattr(&init_user_ns, dentry, d_inode(dentry),
>>>> +				    XATTR_NAME_EVM, &data.hdr.xattr.data[1],
>>>> +				    SHA1_DIGEST_SIZE + 1, 0);
> 
> Although __vfs_setxattr_noperm() doesn't do any permission checking, it
> does other things - make sure the filesystem supports writing xattrs,
> calls fsnotify_xattr().
> 
>>>>  	} else if (rc == -ENODATA && (inode->i_opflags & IOP_XATTR)) {
>>>>  		rc = __vfs_removexattr(&init_user_ns, dentry, XATTR_NAME_EVM);
>>>>  	}
>>>> diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
>>>> index ee6f7e237f2e..d2de9dc6c345 100644
>>>> --- a/security/integrity/ima/ima_appraise.c
>>>> +++ b/security/integrity/ima/ima_appraise.c
>>>> @@ -98,10 +98,10 @@ static int ima_fix_xattr(struct dentry *dentry,
>>>>  		iint->ima_hash->xattr.ng.type = IMA_XATTR_DIGEST_NG;
>>>>  		iint->ima_hash->xattr.ng.algo = algo;
>>>>  	}
>>>> -	rc = __vfs_setxattr_noperm(&init_user_ns, dentry, XATTR_NAME_IMA,
>>>> -				   &iint->ima_hash->xattr.data[offset],
>>>> -				   (sizeof(iint->ima_hash->xattr) - offset) +
>>>> -				   iint->ima_hash->length, 0);
>>>> +	rc = __vfs_setxattr(&init_user_ns, dentry, d_inode(dentry),
>>>> +			    XATTR_NAME_IMA, &iint->ima_hash->xattr.data[offset],
>>>> +			    (sizeof(iint->ima_hash->xattr) - offset) +
>>>> +			    iint->ima_hash->length, 0);
> 
> To clarify, ima_fix_xattr() is either directly called when in "fix"
> mode or from ima_update_xattr().  With this change, the recalculated
> file hash would be written to security.ima, but security.evm would not
> be updated.

Thanks for you explanation, I will drop this patch.

> 
>>>>  	return rc;
>>>>  }
> 
