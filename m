Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2492D74B332
	for <lists+linux-integrity@lfdr.de>; Fri,  7 Jul 2023 16:43:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232966AbjGGOn1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 7 Jul 2023 10:43:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233087AbjGGOn0 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 7 Jul 2023 10:43:26 -0400
Received: from frasgout11.his.huawei.com (unknown [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43E891FE9;
        Fri,  7 Jul 2023 07:43:21 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4QyG7k5q1bz9xGgg;
        Fri,  7 Jul 2023 22:32:18 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
        by APP2 (Coremail) with SMTP id GxC2BwDnt15iJKhkVoAxBA--.59537S2;
        Fri, 07 Jul 2023 15:42:55 +0100 (CET)
Message-ID: <ceba64a94906550cd9d9b93e395c6e379cb028f0.camel@huaweicloud.com>
Subject: Re: [PATCH v12 1/4] security: Allow all LSMs to provide xattrs for
 inode_init_security hook
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     Paul Moore <paul@paul-moore.com>,
        Roberto Sassu <roberto.sassu@huawei.com>
Cc:     "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "serge@hallyn.com" <serge@hallyn.com>,
        "stephen.smalley.work@gmail.com" <stephen.smalley.work@gmail.com>,
        "eparis@parisplace.org" <eparis@parisplace.org>,
        "casey@schaufler-ca.com" <casey@schaufler-ca.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "selinux@vger.kernel.org" <selinux@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "kpsingh@kernel.org" <kpsingh@kernel.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "nicolas.bouchinet@clip-os.org" <nicolas.bouchinet@clip-os.org>
Date:   Fri, 07 Jul 2023 16:42:39 +0200
In-Reply-To: <CAHC9VhQGWWQgA9DBpq+q4XQerbN0SXAB8RG94G8uMD0-J968xA@mail.gmail.com>
References: <20230610075738.3273764-2-roberto.sassu@huaweicloud.com>
         <1c8c612d99e202a61e6a6ecf50d4cace.paul@paul-moore.com>
         <8fd08063bc6b4325b9785052d02da9f2@huawei.com>
         <CAHC9VhQGWWQgA9DBpq+q4XQerbN0SXAB8RG94G8uMD0-J968xA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-CM-TRANSID: GxC2BwDnt15iJKhkVoAxBA--.59537S2
X-Coremail-Antispam: 1UD129KBjvJXoWxuF4rJF4fXFW8XrW8CrW3ZFb_yoW5trW3pF
        W3J3Wjkrn5JFWfAr9ayw48u3WS93yrGr4UXr9xtw1UZas0gr1xJr1jkr1ruFykXrWkGFnY
        qry7Xr9xurn8A37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQALBF1jj5AApQAAsK
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        PDS_RDNS_DYNAMIC_FP,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2023-07-07 at 10:34 -0400, Paul Moore wrote:
> On Fri, Jul 7, 2023 at 2:49 AM Roberto Sassu <roberto.sassu@huawei.com> wrote:
> > > From: Paul Moore [mailto:paul@paul-moore.com]
> > > Sent: Friday, July 7, 2023 3:44 AM
> > > On Jun 10, 2023 Roberto Sassu <roberto.sassu@huaweicloud.com> wrote:
> > > > 
> > > > Currently, the LSM infrastructure supports only one LSM providing an xattr
> > > > and EVM calculating the HMAC on that xattr, plus other inode metadata.
> > > > 
> > > > Allow all LSMs to provide one or multiple xattrs, by extending the security
> > > > blob reservation mechanism. Introduce the new lbs_xattr_count field of the
> > > > lsm_blob_sizes structure, so that each LSM can specify how many xattrs it
> > > > needs, and the LSM infrastructure knows how many xattr slots it should
> > > > allocate.
> > > > 
> > > > Modify the inode_init_security hook definition, by passing the full
> > > > xattr array allocated in security_inode_init_security(), and the current
> > > > number of xattr slots in that array filled by LSMs. The first parameter
> > > > would allow EVM to access and calculate the HMAC on xattrs supplied by
> > > > other LSMs, the second to not leave gaps in the xattr array, when an LSM
> > > > requested but did not provide xattrs (e.g. if it is not initialized).
> > > > 
> > > > Introduce lsm_get_xattr_slot(), which LSMs can call as many times as the
> > > > number specified in the lbs_xattr_count field of the lsm_blob_sizes
> > > > structure. During each call, lsm_get_xattr_slot() increments the number of
> > > > filled xattrs, so that at the next invocation it returns the next xattr
> > > > slot to fill.
> > > > 
> > > > Cleanup security_inode_init_security(). Unify the !initxattrs and
> > > > initxattrs case by simply not allocating the new_xattrs array in the
> > > > former. Update the documentation to reflect the changes, and fix the
> > > > description of the xattr name, as it is not allocated anymore.
> > > > 
> > > > Adapt both SELinux and Smack to use the new definition of the
> > > > inode_init_security hook, and to call lsm_get_xattr_slot() to obtain and
> > > > fill the reserved slots in the xattr array.
> > > > 
> > > > Move the xattr->name assignment after the xattr->value one, so that it is
> > > > done only in case of successful memory allocation.
> > > > 
> > > > Finally, change the default return value of the inode_init_security hook
> > > > from zero to -EOPNOTSUPP, so that BPF LSM correctly follows the hook
> > > > conventions.
> > > > 
> > > > Reported-by: Nicolas Bouchinet <nicolas.bouchinet@clip-os.org>
> > > > Link: https://lore.kernel.org/linux-integrity/Y1FTSIo+1x+4X0LS@archlinux/
> > > > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > > > ---
> > > >  include/linux/lsm_hook_defs.h |  6 +--
> > > >  include/linux/lsm_hooks.h     | 20 ++++++++++
> > > >  security/security.c           | 71 +++++++++++++++++++++++------------
> > > >  security/selinux/hooks.c      | 17 +++++----
> > > >  security/smack/smack_lsm.c    | 25 ++++++------
> > > >  5 files changed, 92 insertions(+), 47 deletions(-)
> > > 
> > > Two *very* small suggestions below, but I can make those during the
> > > merge if you are okay with that Roberto?
> > 
> > Hi Paul
> > 
> > yes, sure, I'm ok with them. Please make them during the merge.
> 
> Great, I'll queue this up for merging once the merge window closes.
> I'll send confirmation once it's done but just a heads-up that things
> might be a little delayed next week.

Ok, no problem.

Thanks!

Roberto

