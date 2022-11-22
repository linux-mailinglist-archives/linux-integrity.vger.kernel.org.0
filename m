Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3346633728
	for <lists+linux-integrity@lfdr.de>; Tue, 22 Nov 2022 09:31:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232917AbiKVIa7 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 22 Nov 2022 03:30:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232920AbiKVIad (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 22 Nov 2022 03:30:33 -0500
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17EE7326E1;
        Tue, 22 Nov 2022 00:30:20 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.229])
        by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4NGcjY6PrXz9xFYG;
        Tue, 22 Nov 2022 16:24:01 +0800 (CST)
Received: from roberto-ThinkStation-P620 (unknown [10.204.63.22])
        by APP2 (Coremail) with SMTP id GxC2BwAnDvp5iHxjEJiEAA--.54837S2;
        Tue, 22 Nov 2022 09:29:56 +0100 (CET)
Message-ID: <339eff96ebcd4c7ecba2ed56751fd2636fa52f73.camel@huaweicloud.com>
Subject: Re: [PATCH v4 2/5] security: Rewrite
 security_old_inode_init_security()
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     Paul Moore <paul@paul-moore.com>, Mimi Zohar <zohar@linux.ibm.com>
Cc:     dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com,
        stephen.smalley.work@gmail.com, eparis@parisplace.org,
        casey@schaufler-ca.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        reiserfs-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        keescook@chromium.org, nicolas.bouchinet@clip-os.org,
        Roberto Sassu <roberto.sassu@huawei.com>,
        ocfs2-devel@oss.oracle.com
Date:   Tue, 22 Nov 2022 09:29:40 +0100
In-Reply-To: <CAHC9VhTvcgOjXAH51Vnk66kEjXfjUS2aJjXjJmU-rwLT53vWPw@mail.gmail.com>
References: <20221110094639.3086409-1-roberto.sassu@huaweicloud.com>
         <20221110094639.3086409-3-roberto.sassu@huaweicloud.com>
         <3dc4f389ead98972cb7d09ef285a0065decb0ad0.camel@linux.ibm.com>
         <aa5fa8c5f231115c58012352124df57d16a01e41.camel@huaweicloud.com>
         <7812899531b2bd936b25fde8fc2f1c2a6080b2bd.camel@linux.ibm.com>
         <CAHC9VhTvcgOjXAH51Vnk66kEjXfjUS2aJjXjJmU-rwLT53vWPw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: GxC2BwAnDvp5iHxjEJiEAA--.54837S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXF4rArykWFWxtF17tF4Dtwb_yoW5XFWrpr
        WfKF1UKrn5JFWDCr4xtwsxWF4Ig3yfGFZxXrn5GrWUAr1DCF1xKr4jyF13u345JrWkJ3y0
        qw4xZ3y3Zrn8AwUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUk0b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42
        xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv
        6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUFDGOUUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAEBF1jj4WyCQABsP
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2022-11-21 at 18:55 -0500, Paul Moore wrote:
> On Mon, Nov 21, 2022 at 3:54 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
> > On Mon, 2022-11-21 at 10:45 +0100, Roberto Sassu wrote:
> > > > As ocfs2 already defines initxattrs, that leaves only reiserfs missing
> > > > initxattrs().  A better, cleaner solution would be to define one.
> > > 
> > > If I understood why security_old_inode_init_security() is called
> > > instead of security_inode_init_security(), the reason seems that the
> > > filesystem code uses the length of the obtained xattr to make some
> > > calculations (e.g. reserve space). The xattr is written at a later
> > > time.
> > > 
> > > Since for reiserfs there is a plan to deprecate it, it probably
> > > wouldn't be worth to support the creation of multiple xattrs. I would
> > > define a callback to take the first xattr and make a copy, so that
> > > calling security_inode_init_security() + reiserfs_initxattrs() is
> > > equivalent to calling security_old_inode_init_security().
> 
> FWIW, reiserfs isn't going to be removed until 2025, I'm hopeful we
> can remove the IMA/EVM special cases before then :)

Well, we are not that far...

> > > But then, this is what anyway I was doing with the
> > > security_initxattrs() callback, for all callers of security_old_inode_i
> > > nit_security().
> > > 
> > > Also, security_old_inode_init_security() is exported to kernel modules.
> > > Maybe, it is used somewhere. So, unless we plan to remove it
> > > completely, it should be probably be fixed to avoid multiple LSMs
> > > successfully setting an xattr, and losing the memory of all except the
> > > last (which this patch fixes by calling security_inode_init_security()).
> 
> I would much rather remove security_old_inode_init_security() then
> worry about what out-of-tree modules might be using it.  Hopefully we
> can resolve the ocfs2 usage and get ocfs2 exclusively on the new hook
> without too much trouble, which means all we have left is reiserfs ...
> how difficult would you expect the conversion to be for reiserfs?

Ok for removing security_old_inode_init_security().

For reiserfs, I guess maintaining the current behavior of setting only
one xattr should be easy. For multiple xattrs, I need to understand
exactly how many blocks need to be reserved.

> > > If there is still the preference, I will implement the reiserfs
> > > callback and make a fix for security_old_inode_init_security().
> > 
> > There's no sense in doing both, as the purpose of defining a reiserfs
> > initxattrs function was to clean up this code making it more readable.

The fix for security_old_inode_init_security(), stopping at the first
LSM returning zero, was to avoid the memory leak. Will not be needed if
the function is removed.

Roberto

