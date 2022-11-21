Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8C48631D25
	for <lists+linux-integrity@lfdr.de>; Mon, 21 Nov 2022 10:46:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbiKUJqH (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 21 Nov 2022 04:46:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbiKUJqF (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 21 Nov 2022 04:46:05 -0500
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9492E13E08;
        Mon, 21 Nov 2022 01:46:03 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.228])
        by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4NG2Ql5CVtz9xGKf;
        Mon, 21 Nov 2022 17:39:11 +0800 (CST)
Received: from roberto-ThinkStation-P620 (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwCHcW65SHtjOoSBAA--.28097S2;
        Mon, 21 Nov 2022 10:45:39 +0100 (CET)
Message-ID: <aa5fa8c5f231115c58012352124df57d16a01e41.camel@huaweicloud.com>
Subject: Re: [PATCH v4 2/5] security: Rewrite
 security_old_inode_init_security()
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
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
Date:   Mon, 21 Nov 2022 10:45:19 +0100
In-Reply-To: <3dc4f389ead98972cb7d09ef285a0065decb0ad0.camel@linux.ibm.com>
References: <20221110094639.3086409-1-roberto.sassu@huaweicloud.com>
         <20221110094639.3086409-3-roberto.sassu@huaweicloud.com>
         <3dc4f389ead98972cb7d09ef285a0065decb0ad0.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: LxC2BwCHcW65SHtjOoSBAA--.28097S2
X-Coremail-Antispam: 1UD129KBjvJXoWxCry7Xw1UCFyUJr1ruFWDCFg_yoW5Kr1Dpr
        W3KF1UKrn8JF97CrWxJFnxWF4I93yfGFZrXrs5AryDAF1DCF1xtr10yry5u343JrWkJ34F
        qw4xZ3sxZrn8Z3JanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42
        xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UZ18PUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgADBF1jj4GngwACsT
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2022-11-17 at 08:03 -0500, Mimi Zohar wrote:
> Hi Roberto,
> 
> On Thu, 2022-11-10 at 10:46 +0100, Roberto Sassu wrote:
> > From: Roberto Sassu <roberto.sassu@huawei.com>
> > 
> > Rewrite security_old_inode_init_security() to call
> > security_inode_init_security() before making changes to support multiple
> > LSMs providing xattrs. Do it so that the required changes are done only in
> > one place.
> 
> Only security_inode_init_security() has support for EVM.   Making
> security_old_inode_init_security() a wrapper for
> security_inode_init_security() could result in security.evm extended
> attributes being created that previously weren't created.
> 
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

From what I see, there is no memory leak there.

> As ocfs2 already defines initxattrs, that leaves only reiserfs missing
> initxattrs().  A better, cleaner solution would be to define one.

If I understood why security_old_inode_init_security() is called
instead of security_inode_init_security(), the reason seems that the
filesystem code uses the length of the obtained xattr to make some
calculations (e.g. reserve space). The xattr is written at a later
time.

Since for reiserfs there is a plan to deprecate it, it probably
wouldn't be worth to support the creation of multiple xattrs. I would
define a callback to take the first xattr and make a copy, so that
calling security_inode_init_security() + reiserfs_initxattrs() is
equivalent to calling security_old_inode_init_security().

But then, this is what anyway I was doing with the
security_initxattrs() callback, for all callers of security_old_inode_i
nit_security().

Also, security_old_inode_init_security() is exported to kernel modules.
Maybe, it is used somewhere. So, unless we plan to remove it
completely, it should be probably be fixed to avoid multiple LSMs
successfully setting an xattr, and losing the memory of all except the
last (which this patch fixes by calling security_inode_init_security())
.

If there is still the preference, I will implement the reiserfs
callback and make a fix for security_old_inode_init_security().

Thanks

Roberto

> thanks,
> 
> Mimi
> 
> > Define the security_initxattrs() callback and pass it to
> > security_inode_init_security() as argument, to obtain the first xattr
> > provided by LSMs.
> > 
> > This behavior is a bit different from the current one. Before this patch
> > calling call_int_hook() could cause multiple LSMs to provide an xattr,
> > since call_int_hook() does not stop when an LSM returns zero. The caller of
> > security_old_inode_init_security() receives the last xattr set. The pointer
> > of the xattr value of previous LSMs is lost, causing memory leaks.
> > 
> > However, in practice, this scenario does not happen as the only in-tree
> > LSMs providing an xattr at inode creation time are SELinux and Smack, which
> > are mutually exclusive.
> > 
> > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>b

