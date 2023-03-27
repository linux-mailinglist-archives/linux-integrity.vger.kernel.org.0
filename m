Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1695C6C9C4A
	for <lists+linux-integrity@lfdr.de>; Mon, 27 Mar 2023 09:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232614AbjC0HhK (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 27 Mar 2023 03:37:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232456AbjC0HhI (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 27 Mar 2023 03:37:08 -0400
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3A30559A;
        Mon, 27 Mar 2023 00:36:40 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.228])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4PlPXS5Ndjz9v7Vl;
        Mon, 27 Mar 2023 15:27:20 +0800 (CST)
Received: from roberto-ThinkStation-P620 (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwAHjQhWRyFku1LSAQ--.62049S2;
        Mon, 27 Mar 2023 08:36:01 +0100 (CET)
Message-ID: <59def311993b839bb4fa623daa973a3bebb52359.camel@huaweicloud.com>
Subject: Re: [PATCH v8 4/6] security: Allow all LSMs to provide xattrs for
 inode_init_security hook
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     mark@fasheh.com, jlbec@evilplan.org, joseph.qi@linux.alibaba.com,
        zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, jmorris@namei.org,
        serge@hallyn.com, stephen.smalley.work@gmail.com,
        eparis@parisplace.org, casey@schaufler-ca.com,
        ocfs2-devel@oss.oracle.com, reiserfs-devel@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, keescook@chromium.org,
        nicolas.bouchinet@clip-os.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Date:   Mon, 27 Mar 2023 09:35:47 +0200
In-Reply-To: <CAHC9VhQuKYundB6rSTi57hxYzE7+QYzHd75M9m-TgyOddPj5Kg@mail.gmail.com>
References: <20230314081720.4158676-1-roberto.sassu@huaweicloud.com>
         <20230314081720.4158676-5-roberto.sassu@huaweicloud.com>
         <CAHC9VhTD3EyDiJs9+NQrgp84JcUs_sx8WONtRk2YYH4m1C8nVw@mail.gmail.com>
         <939e6c88662ad90b963993c4cc1b702083e74a7a.camel@huaweicloud.com>
         <CAHC9VhQuKYundB6rSTi57hxYzE7+QYzHd75M9m-TgyOddPj5Kg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwAHjQhWRyFku1LSAQ--.62049S2
X-Coremail-Antispam: 1UD129KBjvJXoW3GFyrKF13Kw1kur1Utr4UXFb_yoWDJF4kpF
        WUt3Wj9r4kJFy7GrySqa18u3WS9rWfKrW7WrnxGry7AFyqyr1xtFyFyr15uFykZr4kGF1q
        qr42yrsxu3s8AaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUk0b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42
        xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv
        6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUo0eHDUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAJBF1jj4cvOgABst
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2023-03-24 at 17:19 -0400, Paul Moore wrote:
> On Fri, Mar 24, 2023 at 6:18 AM Roberto Sassu
> <roberto.sassu@huaweicloud.com> wrote:
> > On Thu, 2023-03-23 at 20:09 -0400, Paul Moore wrote:
> > > On Tue, Mar 14, 2023 at 4:19 AM Roberto Sassu
> > > <roberto.sassu@huaweicloud.com> wrote:
> > > > From: Roberto Sassu <roberto.sassu@huawei.com>
> > > > 
> > > > Currently, security_inode_init_security() supports only one LSM providing
> > > > an xattr and EVM calculating the HMAC on that xattr, plus other inode
> > > > metadata.
> > > > 
> > > > Allow all LSMs to provide one or multiple xattrs, by extending the security
> > > > blob reservation mechanism. Introduce the new lbs_xattr field of the
> > > > lsm_blob_sizes structure, so that each LSM can specify how many xattrs it
> > > > needs, and the LSM infrastructure knows how many xattr slots it should
> > > > allocate.
> > > > 
> > > > Dynamically allocate the xattrs array to be populated by LSMs with the
> > > > inode_init_security hook, and pass it to the latter instead of the
> > > > name/value/len triple. Update the documentation accordingly, and fix the
> > > > description of the xattr name, as it is not allocated anymore.
> > > > 
> > > > Since the LSM infrastructure, at initialization time, updates the number of
> > > > the requested xattrs provided by each LSM with a corresponding offset in
> > > > the security blob (in this case the xattr array), it makes straightforward
> > > > for an LSM to access the right position in the xattr array.
> > > > 
> > > > There is still the issue that an LSM might not fill the xattr, even if it
> > > > requests it (legitimate case, for example it might have been loaded but not
> > > > initialized with a policy). Since users of the xattr array (e.g. the
> > > > initxattrs() callbacks) detect the end of the xattr array by checking if
> > > > the xattr name is NULL, not filling an xattr would cause those users to
> > > > stop scanning xattrs prematurely.
> > > > 
> > > > Solve that issue by introducing security_check_compact_filled_xattrs(),
> > > > which does a basic check of the xattr array (if the xattr name is filled,
> > > > the xattr value should be too, and viceversa), and compacts the xattr array
> > > > by removing the holes.
> > > > 
> > > > An alternative solution would be to let users of the xattr array know the
> > > > number of elements of that array, so that they don't have to check the
> > > > termination. However, this seems more invasive, compared to a simple move
> > > > of few array elements.
> > > > 
> > > > security_check_compact_filled_xattrs() also determines how many xattrs in
> > > > the xattr array have been filled. If there is none, skip
> > > > evm_inode_init_security() and initxattrs(). Skipping the former also avoids
> > > > EVM to crash the kernel, as it is expecting a filled xattr.
> > > > 
> > > > Finally, adapt both SELinux and Smack to use the new definition of the
> > > > inode_init_security hook, and to correctly fill the designated slots in the
> > > > xattr array. For Smack, reserve space for the other defined xattrs although
> > > > they are not set yet in smack_inode_init_security().
> > > > 
> > > > Reported-by: Nicolas Bouchinet <nicolas.bouchinet@clip-os.org> (EVM crash)
> > > > Link: https://lore.kernel.org/linux-integrity/Y1FTSIo+1x+4X0LS@archlinux/
> > > > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > > > Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
> > > > Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> > > > ---
> > > >  include/linux/lsm_hook_defs.h |   3 +-
> > > >  include/linux/lsm_hooks.h     |   1 +
> > > >  security/security.c           | 119 +++++++++++++++++++++++++++++-----
> > > >  security/selinux/hooks.c      |  19 ++++--
> > > >  security/smack/smack_lsm.c    |  33 ++++++----
> > > >  5 files changed, 137 insertions(+), 38 deletions(-)
> 
> ...
> 
> > > > @@ -1604,33 +1654,66 @@ int security_inode_init_security(struct inode *inode, struct inode *dir,
> > > >                                  const struct qstr *qstr,
> > > >                                  const initxattrs initxattrs, void *fs_data)
> > > >  {
> > > > -       struct xattr new_xattrs[MAX_LSM_EVM_XATTR + 1];
> > > > -       struct xattr *lsm_xattr, *evm_xattr, *xattr;
> > > > -       int ret;
> > > > +       struct security_hook_list *P;
> > > > +       struct xattr *new_xattrs;
> > > > +       struct xattr *xattr;
> > > > +       int ret = -EOPNOTSUPP, num_filled_xattrs = 0;
> > > > 
> > > >         if (unlikely(IS_PRIVATE(inode)))
> > > >                 return 0;
> > > > 
> > > > +       if (!blob_sizes.lbs_xattr)
> > > > +               return 0;
> > > > +
> > > >         if (!initxattrs)
> > > >                 return call_int_hook(inode_init_security, -EOPNOTSUPP, inode,
> > > > -                                    dir, qstr, NULL, NULL, NULL);
> > > > -       memset(new_xattrs, 0, sizeof(new_xattrs));
> > > > -       lsm_xattr = new_xattrs;
> > > > -       ret = call_int_hook(inode_init_security, -EOPNOTSUPP, inode, dir, qstr,
> > > > -                           &lsm_xattr->name,
> > > > -                           &lsm_xattr->value,
> > > > -                           &lsm_xattr->value_len);
> > > > -       if (ret)
> > > > +                                   dir, qstr, NULL);
> > > > +       /* Allocate +1 for EVM and +1 as terminator. */
> > > > +       new_xattrs = kcalloc(blob_sizes.lbs_xattr + 2, sizeof(*new_xattrs),
> > > > +                            GFP_NOFS);
> > > > +       if (!new_xattrs)
> > > > +               return -ENOMEM;
> > > > +
> > > > +       hlist_for_each_entry(P, &security_hook_heads.inode_init_security,
> > > > +                            list) {
> > > > +               ret = P->hook.inode_init_security(inode, dir, qstr, new_xattrs);
> > > > +               if (ret && ret != -EOPNOTSUPP)
> > > > +                       goto out;
> > > > +               /*
> > > > +                * As documented in lsm_hooks.h, -EOPNOTSUPP in this context
> > > > +                * means that the LSM is not willing to provide an xattr, not
> > > > +                * that it wants to signal an error. Thus, continue to invoke
> > > > +                * the remaining LSMs.
> > > > +                */
> > > > +               if (ret == -EOPNOTSUPP)
> > > > +                       continue;
> > > > +               /*
> > > > +                * As the number of xattrs reserved by LSMs is not directly
> > > > +                * available, directly use the total number blob_sizes.lbs_xattr
> > > > +                * to keep the code simple, while being not the most efficient
> > > > +                * way.
> > > > +                */
> > > 
> > > Is there a good reason why the LSM can't return the number of xattrs
> > > it is adding to the xattr array?  It seems like it should be fairly
> > > trivial for the individual LSMs to determine and it could save a lot
> > > of work.  However, given we're at v8 on this patchset I'm sure I'm
> > > missing something obvious, can you help me understand why the idea
> > > above is crazy stupid? ;)
> > 
> > Ok, I looked back at what I did for v3.
> > 
> > Moving from v3 to v4, I decided to put less burden on LSMs, and to make
> > all the processing from the LSM infrastructure side.
> 
> As a general rule I think it's a good goal to keep the LSM layer as
> small as possible; I believe it allows us to be more flexible with the
> LSMs and it keeps the LSM as simple as possible.  I mean less code,
> less bugs, amirite? ... ;)
> 
> > v3 had some safeguards to prevent some programming mistakes by LSMs,
> > which maybe made the code less understandable.
> > 
> > However, if we say we keep things as simple as possible and assume that
> > LSMs implement this correctly, we can just pass num_filled_xattrs to
> > them and they simply increment it.
> > 
> > The EVM bug should not arise (accessing xattr->name = NULL), even if
> > BPF LSM alone returns zero, due to the check of num_filled_xattrs
> > before calling evm_inode_init_security().
> > 
> > Patch 6 (at the end) will prevent the bug from arising when EVM is
> > moved to the LSM infrastructure (no num_filled_xattrs check anymore).
> > There is a loop that stops if xattr->name is NULL, so
> > evm_protected_xattr() will not be called.
> > 
> > Or, like you suggested, we just return a positive value from LSMs and
> > we keep num_filled_xattrs in security_inode_init_security().
> 
> I like the idea of individual LSMs simply reporting the number of
> xattrs they've generated instead of incrementing the num_filled_xattrs
> variable.
> 
> It seems like returning the xattr count as a positive return value
> should work just fine, leaving negative values for errors, but if you
> run into problems you can always pass the value back in a new
> parameter pointer if needed.
> 
> > > > @@ -2868,11 +2870,11 @@ static int selinux_dentry_create_files_as(struct dentry *dentry, int mode,
> > > > 
> > > >  static int selinux_inode_init_security(struct inode *inode, struct inode *dir,
> > > >                                        const struct qstr *qstr,
> > > > -                                      const char **name,
> > > > -                                      void **value, size_t *len)
> > > > +                                      struct xattr *xattrs)
> > > >  {
> > > >         const struct task_security_struct *tsec = selinux_cred(current_cred());
> > > >         struct superblock_security_struct *sbsec;
> > > > +       struct xattr *xattr = NULL;
> > > >         u32 newsid, clen;
> > > >         int rc;
> > > >         char *context;
> > > > @@ -2899,16 +2901,18 @@ static int selinux_inode_init_security(struct inode *inode, struct inode *dir,
> > > >             !(sbsec->flags & SBLABEL_MNT))
> > > >                 return -EOPNOTSUPP;
> > > > 
> > > > -       if (name)
> > > > -               *name = XATTR_SELINUX_SUFFIX;
> > > > +       if (xattrs)
> > > > +               xattr = xattrs + selinux_blob_sizes.lbs_xattr;
> > > 
> > > Please abstract that away to an inline function similar to
> > > selinux_cred(), selinux_file(), selinux_inode(), etc.
> > 
> > Ok.
> > 
> > > > +       if (xattr) {
> > > > +               xattr->name = XATTR_SELINUX_SUFFIX;
> > > 
> > > I'm guessing the xattr->name assignment is always done, regardless of
> > > if security_sid_to_context_force() is successful, due to the -EINVAL
> > > check in security_check_compact_filled_xattrs()?  If yes, it would be
> > > good to make note of that here in the code.  If not, it would be nice
> > > to move this down the function to go with the other xattr->XXX
> > > assignments, unless there is another reason for its placement that I'm
> > > missing.
> > 
> > Uhm, if an LSM returns an error, security_inode_init_security() stops
> > and does the cleanup. It should not matter if xattr->name was set.
> 
> Okay, I thought I might be missing something during the review.  Since
> there is no special reason for putting the xattr->name assignment up
> there, please move it down below with the other xattr->XXX
> assignments.

Ok, will do.

Thanks

Roberto

