Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E482962F075
	for <lists+linux-integrity@lfdr.de>; Fri, 18 Nov 2022 10:05:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241294AbiKRJFS (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 18 Nov 2022 04:05:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231534AbiKRJFS (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 18 Nov 2022 04:05:18 -0500
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0A671143;
        Fri, 18 Nov 2022 01:05:15 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.229])
        by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4ND9gq5qwgz9v7Z1;
        Fri, 18 Nov 2022 16:59:03 +0800 (CST)
Received: from [10.206.134.65] (unknown [10.206.134.65])
        by APP1 (Coremail) with SMTP id LxC2BwBHMW6oSndjv7Z0AA--.22042S2;
        Fri, 18 Nov 2022 10:04:51 +0100 (CET)
Message-ID: <5758e5c4-9c8b-4492-3ecd-ba6607fc2899@huaweicloud.com>
Date:   Fri, 18 Nov 2022 10:04:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v4 2/5] security: Rewrite
 security_old_inode_init_security()
Content-Language: en-US
To:     Mimi Zohar <zohar@linux.ibm.com>, dmitry.kasatkin@gmail.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        stephen.smalley.work@gmail.com, eparis@parisplace.org,
        casey@schaufler-ca.com
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        reiserfs-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        keescook@chromium.org, nicolas.bouchinet@clip-os.org,
        Roberto Sassu <roberto.sassu@huawei.com>,
        ocfs2-devel@oss.oracle.com
References: <20221110094639.3086409-1-roberto.sassu@huaweicloud.com>
 <20221110094639.3086409-3-roberto.sassu@huaweicloud.com>
 <3dc4f389ead98972cb7d09ef285a0065decb0ad0.camel@linux.ibm.com>
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
In-Reply-To: <3dc4f389ead98972cb7d09ef285a0065decb0ad0.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: LxC2BwBHMW6oSndjv7Z0AA--.22042S2
X-Coremail-Antispam: 1UD129KBjvJXoWxCry7Xw15Zr18Zw4fWF17Jrb_yoW5Jw48pF
        W2kF1DKrs8JF97CrZ7trnrWF4xKayrGrZrXws3Ary7ZFn8CFn7tr40yry3Ca43GrW8J34F
        qw43Z343Zrn8Z3JanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
        07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
        02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_
        WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
        CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE
        14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf
        9x07UZ18PUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAABF1jj4GVFAACs1
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 11/17/2022 2:03 PM, Mimi Zohar wrote:
> Hi Roberto,
> 
> On Thu, 2022-11-10 at 10:46 +0100, Roberto Sassu wrote:
>> From: Roberto Sassu <roberto.sassu@huawei.com>
>>
>> Rewrite security_old_inode_init_security() to call
>> security_inode_init_security() before making changes to support multiple
>> LSMs providing xattrs. Do it so that the required changes are done only in
>> one place.
> 
> Only security_inode_init_security() has support for EVM.   Making
> security_old_inode_init_security() a wrapper for
> security_inode_init_security() could result in security.evm extended
> attributes being created that previously weren't created.

Hi Mimi

yes, I thought about this problem. In fact, it should not matter too 
much. Since security_old_inode_init_security() supports setting only one 
xattr: if there is an LSM xattr, that one will be set, and the EVM one 
will be discarded; if there is no LSM xattr, EVM would not add one.

> In fact ocfs2 defines ocfs2_init_security_get() as a wrapper for both
> the old and new inode_init_security calls based on the caller's
> preference.   Only mknod and symlink seem to use the old function.
> Wondering why do they differentiate between callers?  (Cc'ing the ocfs2
> mailing list as they're affected by this change.)
> 
> "[PATCH v4 1/5] reiserfs: Add missing calls to
> reiserfs_security_free()"  fixed a memory leak.  I couldn't tell if
> there was a similar memory leak in ocfs2, the only other user of
> security_old_inode_init_security().

Will look into it.

> As ocfs2 already defines initxattrs, that leaves only reiserfs missing
> initxattrs().  A better, cleaner solution would be to define one.

Yes, great idea!

Thanks

Roberto

> thanks,
> 
> Mimi
> 
>>
>> Define the security_initxattrs() callback and pass it to
>> security_inode_init_security() as argument, to obtain the first xattr
>> provided by LSMs.
>>
>> This behavior is a bit different from the current one. Before this patch
>> calling call_int_hook() could cause multiple LSMs to provide an xattr,
>> since call_int_hook() does not stop when an LSM returns zero. The caller of
>> security_old_inode_init_security() receives the last xattr set. The pointer
>> of the xattr value of previous LSMs is lost, causing memory leaks.
>>
>> However, in practice, this scenario does not happen as the only in-tree
>> LSMs providing an xattr at inode creation time are SELinux and Smack, which
>> are mutually exclusive.
>>
>> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>b

