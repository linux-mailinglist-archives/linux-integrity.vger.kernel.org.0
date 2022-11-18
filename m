Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5282662F13D
	for <lists+linux-integrity@lfdr.de>; Fri, 18 Nov 2022 10:32:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241132AbiKRJcy (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 18 Nov 2022 04:32:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233863AbiKRJcw (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 18 Nov 2022 04:32:52 -0500
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FF5617A9D;
        Fri, 18 Nov 2022 01:32:51 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4NDBHg1NzNz9v7Nl;
        Fri, 18 Nov 2022 17:26:39 +0800 (CST)
Received: from [10.206.134.65] (unknown [10.206.134.65])
        by APP2 (Coremail) with SMTP id GxC2BwCHu_chUXdj9_NzAA--.22300S2;
        Fri, 18 Nov 2022 10:32:27 +0100 (CET)
Message-ID: <2e493258-b267-b8ad-0812-53f4e9c849ae@huaweicloud.com>
Date:   Fri, 18 Nov 2022 10:32:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v4 3/5] security: Allow all LSMs to provide xattrs for
 inode_init_security hook
Content-Language: en-US
To:     Casey Schaufler <casey@schaufler-ca.com>,
        Mimi Zohar <zohar@linux.ibm.com>, dmitry.kasatkin@gmail.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        stephen.smalley.work@gmail.com, eparis@parisplace.org
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        reiserfs-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        keescook@chromium.org, nicolas.bouchinet@clip-os.org,
        Roberto Sassu <roberto.sassu@huawei.com>
References: <20221110094639.3086409-1-roberto.sassu@huaweicloud.com>
 <20221110094639.3086409-4-roberto.sassu@huaweicloud.com>
 <4c1349f670dc3c23214a5a5036e43ddaa0a7bc89.camel@linux.ibm.com>
 <026075fa-0b58-9041-0727-b75e19499356@schaufler-ca.com>
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
In-Reply-To: <026075fa-0b58-9041-0727-b75e19499356@schaufler-ca.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: GxC2BwCHu_chUXdj9_NzAA--.22300S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tFyUJF45CrWDXF1rJF48Crg_yoW8Ww45pF
        Wrta4UCrsYqF1UCFZxta18Wa43KrZ5GF4UJas5JryUAF4DXF1SqryFkF15ua48KrZ3J34q
        qrWqg343Z3s8Aa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvFb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
        07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
        02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_
        WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
        CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6Fyj6rWUJwCI42IY6I8E87Iv67AK
        xVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvj
        xUo0eHDUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAABF1jj4GV8QAAsS
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 11/17/2022 6:18 PM, Casey Schaufler wrote:
> On 11/17/2022 8:05 AM, Mimi Zohar wrote:
>> hOn Thu, 2022-11-10 at 10:46 +0100, Roberto Sassu wrote:
>>> From: Roberto Sassu <roberto.sassu@huawei.com>
>>>
>>> Currently, security_inode_init_security() supports only one LSM providing
>>> an xattr and EVM calculating the HMAC on that xattr, plus other inode
>>> metadata.
>>>
>>> Allow all LSMs to provide one or multiple xattrs, by extending the security
>>> blob reservation mechanism. Introduce the new lbs_xattr field of the
>>> lsm_blob_sizes structure, so that each LSM can specify how many xattrs it
>>> needs, and the LSM infrastructure knows how many xattr slots it should
>>> allocate.
>> Perhaps supporting per LSM multiple xattrs is a nice idea, but EVM
>> doesn't currently support it.  The LSM xattrs are hard coded in
>> evm_config_default_xattrnames[],  based on whether the LSM is
>> configured.  Additional security xattrs may be included in the
>> security.evm calculation, by extending the list via
>> security/integrity/evm/evm_xattrs.
> 
> Smack uses multiple xattrs. All file system objects have a SMACK64
> attribute, which is used for access control. A program file may have
> a SMACK64EXEC attribute, which is the label the program will run with.
> A library may have a SMACK64MMAP attribute to restrict loading. A
> directory may have a SMACK64TRANSMUTE attribute, which modifies the
> new object creation behavior.
> 
> The point being that it may be more than a "nice idea" to support
> multiple xattrs. It's not a hypothetical situation.

Ok, that means that I have to change the number of xattrs reserved by 
Smack in patch 3.

Thanks

Roberto

