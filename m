Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CFEC62F12F
	for <lists+linux-integrity@lfdr.de>; Fri, 18 Nov 2022 10:30:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241933AbiKRJaw (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 18 Nov 2022 04:30:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241743AbiKRJau (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 18 Nov 2022 04:30:50 -0500
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E6B0720BC;
        Fri, 18 Nov 2022 01:30:48 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.228])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4NDBDZ2npSz9v7Nd;
        Fri, 18 Nov 2022 17:23:58 +0800 (CST)
Received: from [10.206.134.65] (unknown [10.206.134.65])
        by APP1 (Coremail) with SMTP id LxC2BwDHsW6mUHdjeM10AA--.22459S2;
        Fri, 18 Nov 2022 10:30:25 +0100 (CET)
Message-ID: <6e4da6d6-5a0c-98ba-9841-07a316f8631e@huaweicloud.com>
Date:   Fri, 18 Nov 2022 10:30:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v4 4/5] evm: Align evm_inode_init_security() definition
 with LSM infrastructure
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
 <20221110094639.3086409-5-roberto.sassu@huaweicloud.com>
 <5ff23992ab249af4fd5ef967691f8986c5898583.camel@linux.ibm.com>
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
In-Reply-To: <5ff23992ab249af4fd5ef967691f8986c5898583.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: LxC2BwDHsW6mUHdjeM10AA--.22459S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXF4xGF4kWF1Uuw13Kr4xtFb_yoW5uw15pF
        W5Ga4jkrs5JFyjkrySyF48u3yS93yfGrW5trn8GryUAa90grn3trWIgF45ua4rWrWDC3WF
        qr4ay3s3Z3Z8A3JanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAABF1jj4WV4QAAsF
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 11/17/2022 6:07 PM, Mimi Zohar wrote:
> On Thu, 2022-11-10 at 10:46 +0100, Roberto Sassu wrote:
>> From: Roberto Sassu <roberto.sassu@huawei.com>
>>
>> Change the evm_inode_init_security() definition to align with the LSM
>> infrastructure, in preparation for moving IMA and EVM to that
>> infrastructure.
>>
>> This requires passing only the xattr array allocated by
>> security_inode_init_security(), instead of the first LSM xattr and the
>> place where the EVM xattr should be filled.
>>
>> It also requires positioning after the last filled xattr (by checking the
>> xattr name), since the beginning of the xattr array is given.
> 
> Perhaps combine this sentence to the previous paragraph and start the
> sentence with
> "In lieu of passing the EVM xattr, ..."

Ok.

>> If EVM is moved to the LSM infrastructure, it will use the xattr
>> reservation mechanism too, i.e. it positions itself in the xattr array with
>> the offset given by the LSM infrastructure.
> 
> The LSM infrastructure will need to support EVM as the last LSM.  Is
> there a reason for including this comment in this patch description.

The idea is to first make EVM work like other LSMs, and then add 
limitations that are EVM-specific.

As a regular LSM, EVM could be placed anywhere in the list of LSMs. This 
would mean that whenever EVM is called, it will process xattrs that are 
set by previous LSMs, not the subsequent ones.

What we would need to do EVM-specific is that EVM is the last in the 
list of LSMs, to ensure that all xattrs are protected.

>> Finally, make evm_inode_init_security() return value compatible with the
>> inode_init_security hook conventions, i.e. return -EOPNOTSUPP if it is not
>> setting an xattr.
> 
>> EVM is a bit tricky, because xattrs is both an input and an output. If it
>> was just output, EVM should have returned zero if xattrs is NULL. But,
>> since xattrs is also input, EVM is unable to do its calculations, so return
>> -EOPNOTSUPP and handle this error in security_inode_init_security().
>>
>> Don't change the return value in the inline function
>> evm_inode_init_security() in include/linux/evm.h, as the function will be
>> removed if EVM is moved to the LSM infrastructure.
>>
>> Last note, this patch does not fix a possible crash if the xattr array is
>> empty (due to calling evm_protected_xattr() with a NULL argument). It will
>> be fixed with 'evm: Support multiple LSMs providing an xattr', as it will
>> first ensure that the xattr name is not NULL before calling
>> evm_protected_xattr().
> 
>  From my reading of the code, although there might be multiple LSM
> xattrs, this patch only includes the first LSM xattr in the security
> EVM calculation.  So it only checks the first xattr's name.  Support
> for including multiple LSM xattrs in the EVM hmac calculation is added
> in the subsequent patch.

I tried to include in this patch just the function definition change and 
keep the existing behavior.

The problem is trying to access xattr->name at the beginning of 
evm_inode_init_security().

That would disappear in patch 5, where there is a loop checking 
xattr->value first. Patch 3 disallows combination of NULL name - !NULL 
value and !NULL name - NULL value. Not sure if the latter is correct 
(empty xattr?). Will check what callers do.

Roberto

> thanks,
> 
> Mimi
> 
>>
>> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>

