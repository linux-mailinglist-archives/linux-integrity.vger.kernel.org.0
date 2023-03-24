Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00FDE6C7EB6
	for <lists+linux-integrity@lfdr.de>; Fri, 24 Mar 2023 14:26:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231945AbjCXN0Q (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 24 Mar 2023 09:26:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231872AbjCXN0P (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 24 Mar 2023 09:26:15 -0400
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8A6222037;
        Fri, 24 Mar 2023 06:26:08 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4PjjQY4ds5z9xHN6;
        Fri, 24 Mar 2023 21:16:21 +0800 (CST)
Received: from roberto-ThinkStation-P620 (unknown [10.204.63.22])
        by APP2 (Coremail) with SMTP id GxC2BwDnr1bEpB1kWo3EAQ--.55675S2;
        Fri, 24 Mar 2023 14:25:37 +0100 (CET)
Message-ID: <ffc86b3907f7b87d3c568ae62bea3cdb3275be4e.camel@huaweicloud.com>
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
Date:   Fri, 24 Mar 2023 14:25:21 +0100
In-Reply-To: <939e6c88662ad90b963993c4cc1b702083e74a7a.camel@huaweicloud.com>
References: <20230314081720.4158676-1-roberto.sassu@huaweicloud.com>
         <20230314081720.4158676-5-roberto.sassu@huaweicloud.com>
         <CAHC9VhTD3EyDiJs9+NQrgp84JcUs_sx8WONtRk2YYH4m1C8nVw@mail.gmail.com>
         <939e6c88662ad90b963993c4cc1b702083e74a7a.camel@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GxC2BwDnr1bEpB1kWo3EAQ--.55675S2
X-Coremail-Antispam: 1UD129KBjvAXoWfJr43Gr1DCF4DCF43Gw4DArb_yoW8Cw4rZo
        WfJwsrJa18try3JrW5u3s7JFZruayrWr4rAr4jvr45A3Waqa4UCw13Xa1xXFZrWFyrKF48
        K348Aa40vrWqqFn3n29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
        AaLaJ3UjIYCTnIWjp_UUUYU7kC6x804xWl14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK
        8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4
        AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF
        7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26r4j6r4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI
        7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
        Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY
        6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6x
        AIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv
        6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUFDGOUUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAGBF1jj4chwgAAsV
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2023-03-24 at 11:18 +0100, Roberto Sassu wrote:
> On Thu, 2023-03-23 at 20:09 -0400, Paul Moore wrote:
> > On Tue, Mar 14, 2023 at 4:19 AM Roberto Sassu
> > <roberto.sassu@huaweicloud.com> wrote:
> > > From: Roberto Sassu <roberto.sassu@huawei.com>
> > > 
> > > Currently, security_inode_init_security() supports only one LSM providing
> > > an xattr and EVM calculating the HMAC on that xattr, plus other inode
> > > metadata.
> > > 
> > > Allow all LSMs to provide one or multiple xattrs, by extending the security
> > > blob reservation mechanism. Introduce the new lbs_xattr field of the
> > > lsm_blob_sizes structure, so that each LSM can specify how many xattrs it
> > > needs, and the LSM infrastructure knows how many xattr slots it should
> > > allocate.
> > > 
> > > Dynamically allocate the xattrs array to be populated by LSMs with the
> > > inode_init_security hook, and pass it to the latter instead of the
> > > name/value/len triple. Update the documentation accordingly, and fix the
> > > description of the xattr name, as it is not allocated anymore.
> > > 
> > > Since the LSM infrastructure, at initialization time, updates the number of
> > > the requested xattrs provided by each LSM with a corresponding offset in
> > > the security blob (in this case the xattr array), it makes straightforward
> > > for an LSM to access the right position in the xattr array.
> > > 
> > > There is still the issue that an LSM might not fill the xattr, even if it
> > > requests it (legitimate case, for example it might have been loaded but not
> > > initialized with a policy). Since users of the xattr array (e.g. the
> > > initxattrs() callbacks) detect the end of the xattr array by checking if
> > > the xattr name is NULL, not filling an xattr would cause those users to
> > > stop scanning xattrs prematurely.
> > > 
> > > Solve that issue by introducing security_check_compact_filled_xattrs(),
> > > which does a basic check of the xattr array (if the xattr name is filled,
> > > the xattr value should be too, and viceversa), and compacts the xattr array
> > > by removing the holes.
> > > 
> > > An alternative solution would be to let users of the xattr array know the
> > > number of elements of that array, so that they don't have to check the
> > > termination. However, this seems more invasive, compared to a simple move
> > > of few array elements.
> > > 
> > > security_check_compact_filled_xattrs() also determines how many xattrs in
> > > the xattr array have been filled. If there is none, skip
> > > evm_inode_init_security() and initxattrs(). Skipping the former also avoids
> > > EVM to crash the kernel, as it is expecting a filled xattr.
> > > 
> > > Finally, adapt both SELinux and Smack to use the new definition of the
> > > inode_init_security hook, and to correctly fill the designated slots in the
> > > xattr array. For Smack, reserve space for the other defined xattrs although
> > > they are not set yet in smack_inode_init_security().
> > > 
> > > Reported-by: Nicolas Bouchinet <nicolas.bouchinet@clip-os.org> (EVM crash)
> > > Link: https://lore.kernel.org/linux-integrity/Y1FTSIo+1x+4X0LS@archlinux/
> > > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > > Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
> > > Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> > > ---
> > >  include/linux/lsm_hook_defs.h |   3 +-
> > >  include/linux/lsm_hooks.h     |   1 +
> > >  security/security.c           | 119 +++++++++++++++++++++++++++++-----
> > >  security/selinux/hooks.c      |  19 ++++--
> > >  security/smack/smack_lsm.c    |  33 ++++++----
> > >  5 files changed, 137 insertions(+), 38 deletions(-)
> > > 
> > > diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
> > > index 6bb55e61e8e..b814955ae70 100644
> > > --- a/include/linux/lsm_hook_defs.h
> > > +++ b/include/linux/lsm_hook_defs.h
> > > @@ -112,8 +112,7 @@ LSM_HOOK(int, 0, path_notify, const struct path *path, u64 mask,
> > >  LSM_HOOK(int, 0, inode_alloc_security, struct inode *inode)
> > >  LSM_HOOK(void, LSM_RET_VOID, inode_free_security, struct inode *inode)
> > >  LSM_HOOK(int, 0, inode_init_security, struct inode *inode,
> > > -        struct inode *dir, const struct qstr *qstr, const char **name,
> > > -        void **value, size_t *len)
> > > +        struct inode *dir, const struct qstr *qstr, struct xattr *xattrs)
> > >  LSM_HOOK(int, 0, inode_init_security_anon, struct inode *inode,
> > >          const struct qstr *name, const struct inode *context_inode)
> > >  LSM_HOOK(int, 0, inode_create, struct inode *dir, struct dentry *dentry,
> > > diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> > > index c2be66c669a..75a2f85b49d 100644
> > > --- a/include/linux/lsm_hooks.h
> > > +++ b/include/linux/lsm_hooks.h
> > > @@ -63,6 +63,7 @@ struct lsm_blob_sizes {
> > >         int     lbs_ipc;
> > >         int     lbs_msg_msg;
> > >         int     lbs_task;
> > > +       int     lbs_xattr; /* number of xattr slots in new_xattrs array */
> > 
> > No need for the comment, we don't do it for the other fields.
> > 
> > >  };
> > > 
> > >  /*
> > > diff --git a/security/security.c b/security/security.c
> > > index f4170efcddd..f1f5f62f7fa 100644
> > > --- a/security/security.c
> > > +++ b/security/security.c
> > > @@ -1579,6 +1579,52 @@ int security_dentry_create_files_as(struct dentry *dentry, int mode,
> > >  }
> > >  EXPORT_SYMBOL(security_dentry_create_files_as);
> > > 
> > > +/**
> > > + * security_check_compact_filled_xattrs - check xattrs and make array contiguous
> > > + * @xattrs: xattr array filled by LSMs
> > > + * @num_xattrs: length of xattr array
> > > + * @num_filled_xattrs: number of already processed xattrs
> > > + *
> > > + * Ensure that each xattr slot is correctly filled and close the gaps in the
> > > + * xattr array if an LSM didn't provide an xattr for which it asked space
> > > + * (legitimate case, it might have been loaded but not initialized). An LSM
> > > + * might request space in the xattr array for one or multiple xattrs. The LSM
> > > + * infrastructure ensures that all requests by LSMs are satisfied.
> > > + *
> > > + * Track the number of filled xattrs in @num_filled_xattrs, so that it is easy
> > > + * to determine whether the currently processed xattr is fine in its position
> > > + * (if all previous xattrs were filled) or it should be moved after the last
> > > + * filled xattr.
> > > + *
> > > + * Return: zero if all xattrs are valid, -EINVAL otherwise.
> > > + */
> > > +static int security_check_compact_filled_xattrs(struct xattr *xattrs,
> > > +                                               int num_xattrs,
> > > +                                               int *num_filled_xattrs)
> > 
> > That is one long name :)
> > 
> > Since you're making some other changes to this patch, can you rename
> > this to security_xattr_compact() or something like that?
> 
> Yes, definitely!
> 
> > > +{
> > > +       int i;
> > > +
> > > +       for (i = *num_filled_xattrs; i < num_xattrs; i++) {
> > > +               if ((!xattrs[i].name && xattrs[i].value) ||
> > > +                   (xattrs[i].name && !xattrs[i].value))
> > > +                       return -EINVAL;
> > > +
> > > +               if (!xattrs[i].name)
> > > +                       continue;
> > > +
> > > +               if (i == *num_filled_xattrs) {
> > > +                       (*num_filled_xattrs)++;
> > > +                       continue;
> > > +               }
> > > +
> > > +               memcpy(xattrs + (*num_filled_xattrs)++, xattrs + i,
> > > +                      sizeof(*xattrs));
> > > +               memset(xattrs + i, 0, sizeof(*xattrs));
> > > +       }
> > > +
> > > +       return 0;
> > > +}
> > > +
> > >  /**
> > >   * security_inode_init_security() - Initialize an inode's LSM context
> > >   * @inode: the inode
> > > @@ -1591,9 +1637,13 @@ EXPORT_SYMBOL(security_dentry_create_files_as);
> > >   * created inode and set up the incore security field for the new inode.  This
> > >   * hook is called by the fs code as part of the inode creation transaction and
> > >   * provides for atomic labeling of the inode, unlike the post_create/mkdir/...
> > > - * hooks called by the VFS.  The hook function is expected to allocate the name
> > > - * and value via kmalloc, with the caller being responsible for calling kfree
> > > - * after using them.  If the security module does not use security attributes
> > > + * hooks called by the VFS.  The hook function is expected to populate the
> > > + * @xattrs array, depending on how many xattrs have been specified by the
> > > + * security module in the lbs_xattr field of the lsm_blob_sizes structure.  For
> > > + * each array element, the hook function is expected to set ->name to the
> > > + * attribute name suffix (e.g. selinux), to allocate ->value (will be freed by
> > > + * the caller) and set it to the attribute value, to set ->value_len to the
> > > + * length of the value.  If the security module does not use security attributes
> > >   * or does not wish to put a security attribute on this particular inode, then
> > >   * it should return -EOPNOTSUPP to skip this processing.
> > >   *
> > > @@ -1604,33 +1654,66 @@ int security_inode_init_security(struct inode *inode, struct inode *dir,
> > >                                  const struct qstr *qstr,
> > >                                  const initxattrs initxattrs, void *fs_data)
> > >  {
> > > -       struct xattr new_xattrs[MAX_LSM_EVM_XATTR + 1];
> > > -       struct xattr *lsm_xattr, *evm_xattr, *xattr;
> > > -       int ret;
> > > +       struct security_hook_list *P;
> > > +       struct xattr *new_xattrs;
> > > +       struct xattr *xattr;
> > > +       int ret = -EOPNOTSUPP, num_filled_xattrs = 0;
> > > 
> > >         if (unlikely(IS_PRIVATE(inode)))
> > >                 return 0;
> > > 
> > > +       if (!blob_sizes.lbs_xattr)
> > > +               return 0;
> > > +
> > >         if (!initxattrs)
> > >                 return call_int_hook(inode_init_security, -EOPNOTSUPP, inode,
> > > -                                    dir, qstr, NULL, NULL, NULL);
> > > -       memset(new_xattrs, 0, sizeof(new_xattrs));
> > > -       lsm_xattr = new_xattrs;
> > > -       ret = call_int_hook(inode_init_security, -EOPNOTSUPP, inode, dir, qstr,
> > > -                           &lsm_xattr->name,
> > > -                           &lsm_xattr->value,
> > > -                           &lsm_xattr->value_len);
> > > -       if (ret)
> > > +                                   dir, qstr, NULL);
> > > +       /* Allocate +1 for EVM and +1 as terminator. */
> > > +       new_xattrs = kcalloc(blob_sizes.lbs_xattr + 2, sizeof(*new_xattrs),
> > > +                            GFP_NOFS);
> > > +       if (!new_xattrs)
> > > +               return -ENOMEM;
> > > +
> > > +       hlist_for_each_entry(P, &security_hook_heads.inode_init_security,
> > > +                            list) {
> > > +               ret = P->hook.inode_init_security(inode, dir, qstr, new_xattrs);
> > > +               if (ret && ret != -EOPNOTSUPP)
> > > +                       goto out;
> > > +               /*
> > > +                * As documented in lsm_hooks.h, -EOPNOTSUPP in this context
> > > +                * means that the LSM is not willing to provide an xattr, not
> > > +                * that it wants to signal an error. Thus, continue to invoke
> > > +                * the remaining LSMs.
> > > +                */
> > > +               if (ret == -EOPNOTSUPP)
> > > +                       continue;
> > > +               /*
> > > +                * As the number of xattrs reserved by LSMs is not directly
> > > +                * available, directly use the total number blob_sizes.lbs_xattr
> > > +                * to keep the code simple, while being not the most efficient
> > > +                * way.
> > > +                */
> > 
> > Is there a good reason why the LSM can't return the number of xattrs
> > it is adding to the xattr array?  It seems like it should be fairly
> > trivial for the individual LSMs to determine and it could save a lot
> > of work.  However, given we're at v8 on this patchset I'm sure I'm
> > missing something obvious, can you help me understand why the idea
> > above is crazy stupid? ;)

Much simple answer. Yes, LSMs could return the number of xattrs set,
but security_check_compact_filled_xattrs() also needs to know from
which offset (the lbs_xattr of each LSM) it should start compacting.

Example: suppose that you have three LSMs with:

LSM#1: lbs_xattr 1
LSM#2: lbs_xattr 2 (disabled)
LSM#3: lbs_xattr 1

The current compaction interval is: already compacted xattrs - end of
new_xattr array.

When the security_inode_init_security() loop calls LSM#3, the
compaction interval is: 1 - 2 (LSM#2 returns 0), which clearly isn't
right. The correct compaction interval should be: 3 - 4.

Going to the end of new_xattrs is an approximation, but it ensures
that security_check_compact_filled_xattrs() reaches the xattr set by
LSM#3.

The alternative I was mentioning of passing num_filled_xattrs to LSMs
goes again in the direction of doing on-the-fly compaction, while LSMs
are more familiar with using the lbs_* fields.

I suggest to keep this part as it is, if you agree.

Thanks

Roberto

> Ok, I looked back at what I did for v3.
> 
> Moving from v3 to v4, I decided to put less burden on LSMs, and to make
> all the processing from the LSM infrastructure side.
> 
> v3 had some safeguards to prevent some programming mistakes by LSMs,
> which maybe made the code less understandable.
> 
> However, if we say we keep things as simple as possible and assume that
> LSMs implement this correctly, we can just pass num_filled_xattrs to
> them and they simply increment it.
> 
> The EVM bug should not arise (accessing xattr->name = NULL), even if
> BPF LSM alone returns zero, due to the check of num_filled_xattrs
> before calling evm_inode_init_security().
> 
> Patch 6 (at the end) will prevent the bug from arising when EVM is
> moved to the LSM infrastructure (no num_filled_xattrs check anymore).
> There is a loop that stops if xattr->name is NULL, so
> evm_protected_xattr() will not be called.
> 
> Or, like you suggested, we just return a positive value from LSMs and
> we keep num_filled_xattrs in security_inode_init_security().
> 
> Ok, I'll go for your proposal.
> 
> > > +               ret = security_check_compact_filled_xattrs(new_xattrs,
> > > +                                                          blob_sizes.lbs_xattr,
> > > +                                                          &num_filled_xattrs);
> > > +               if (ret < 0) {
> > > +                       ret = -ENOMEM;
> > > +                       goto out;
> > > +               }
> > > +       }
> > > +
> > > +       if (!num_filled_xattrs)
> > >                 goto out;
> > > 
> > > -       evm_xattr = lsm_xattr + 1;
> > > -       ret = evm_inode_init_security(inode, lsm_xattr, evm_xattr);
> > > +       ret = evm_inode_init_security(inode, new_xattrs,
> > > +                                     new_xattrs + num_filled_xattrs);
> > >         if (ret)
> > >                 goto out;
> > >         ret = initxattrs(inode, new_xattrs, fs_data);
> > >  out:
> > >         for (xattr = new_xattrs; xattr->value != NULL; xattr++)
> > >                 kfree(xattr->value);
> > > +       kfree(new_xattrs);
> > >         return (ret == -EOPNOTSUPP) ? 0 : ret;
> > >  }
> > >  EXPORT_SYMBOL(security_inode_init_security);
> > > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > > index 9a5bdfc2131..3e4308dd336 100644
> > > --- a/security/selinux/hooks.c
> > > +++ b/security/selinux/hooks.c
> > > @@ -104,6 +104,8 @@
> > >  #include "audit.h"
> > >  #include "avc_ss.h"
> > > 
> > > +#define SELINUX_INODE_INIT_XATTRS 1
> > > +
> > >  struct selinux_state selinux_state;
> > > 
> > >  /* SECMARK reference count */
> > > @@ -2868,11 +2870,11 @@ static int selinux_dentry_create_files_as(struct dentry *dentry, int mode,
> > > 
> > >  static int selinux_inode_init_security(struct inode *inode, struct inode *dir,
> > >                                        const struct qstr *qstr,
> > > -                                      const char **name,
> > > -                                      void **value, size_t *len)
> > > +                                      struct xattr *xattrs)
> > >  {
> > >         const struct task_security_struct *tsec = selinux_cred(current_cred());
> > >         struct superblock_security_struct *sbsec;
> > > +       struct xattr *xattr = NULL;
> > >         u32 newsid, clen;
> > >         int rc;
> > >         char *context;
> > > @@ -2899,16 +2901,18 @@ static int selinux_inode_init_security(struct inode *inode, struct inode *dir,
> > >             !(sbsec->flags & SBLABEL_MNT))
> > >                 return -EOPNOTSUPP;
> > > 
> > > -       if (name)
> > > -               *name = XATTR_SELINUX_SUFFIX;
> > > +       if (xattrs)
> > > +               xattr = xattrs + selinux_blob_sizes.lbs_xattr;
> > 
> > Please abstract that away to an inline function similar to
> > selinux_cred(), selinux_file(), selinux_inode(), etc.
> 
> Ok.
> 
> > > +       if (xattr) {
> > > +               xattr->name = XATTR_SELINUX_SUFFIX;
> > 
> > I'm guessing the xattr->name assignment is always done, regardless of
> > if security_sid_to_context_force() is successful, due to the -EINVAL
> > check in security_check_compact_filled_xattrs()?  If yes, it would be
> > good to make note of that here in the code.  If not, it would be nice
> > to move this down the function to go with the other xattr->XXX
> > assignments, unless there is another reason for its placement that I'm
> > missing.
> 
> Uhm, if an LSM returns an error, security_inode_init_security() stops
> and does the cleanup. It should not matter if xattr->name was set.
> 
> Thanks
> 
> Roberto
> 
> > > -       if (value && len) {
> > >                 rc = security_sid_to_context_force(&selinux_state, newsid,
> > >                                                    &context, &clen);
> > >                 if (rc)
> > >                         return rc;
> > > -               *value = context;
> > > -               *len = clen;
> > > +               xattr->value = context;
> > > +               xattr->value_len = clen;
> > >         }
> > > 
> > >         return 0;
> > > @@ -6918,6 +6922,7 @@ struct lsm_blob_sizes selinux_blob_sizes __lsm_ro_after_init = {
> > >         .lbs_ipc = sizeof(struct ipc_security_struct),
> > >         .lbs_msg_msg = sizeof(struct msg_security_struct),
> > >         .lbs_superblock = sizeof(struct superblock_security_struct),
> > > +       .lbs_xattr = SELINUX_INODE_INIT_XATTRS,
> > >  };
> > > 
> > >  #ifdef CONFIG_PERF_EVENTS
> > > diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> > > index cfcbb748da2..c8cf8df268b 100644
> > > --- a/security/smack/smack_lsm.c
> > > +++ b/security/smack/smack_lsm.c
> > > @@ -52,6 +52,15 @@
> > >  #define SMK_RECEIVING  1
> > >  #define SMK_SENDING    2
> > > 
> > > +/*
> > > + * Smack uses multiple xattrs.
> > > + * SMACK64 - for access control, SMACK64EXEC - label for the program,
> > > + * SMACK64MMAP - controls library loading,
> > > + * SMACK64TRANSMUTE - label initialization,
> > > + * Not saved on files - SMACK64IPIN and SMACK64IPOUT
> > > + */
> > > +#define SMACK_INODE_INIT_XATTRS 4
> > > +
> > >  #ifdef SMACK_IPV6_PORT_LABELING
> > >  static DEFINE_MUTEX(smack_ipv6_lock);
> > >  static LIST_HEAD(smk_ipv6_port_list);
> > > @@ -939,26 +948,27 @@ static int smack_inode_alloc_security(struct inode *inode)
> > >   * @inode: the newly created inode
> > >   * @dir: containing directory object
> > >   * @qstr: unused
> > > - * @name: where to put the attribute name
> > > - * @value: where to put the attribute value
> > > - * @len: where to put the length of the attribute
> > > + * @xattrs: where to put the attributes
> > >   *
> > >   * Returns 0 if it all works out, -ENOMEM if there's no memory
> > >   */
> > >  static int smack_inode_init_security(struct inode *inode, struct inode *dir,
> > > -                                    const struct qstr *qstr, const char **name,
> > > -                                    void **value, size_t *len)
> > > +                                    const struct qstr *qstr,
> > > +                                    struct xattr *xattrs)
> > >  {
> > >         struct inode_smack *issp = smack_inode(inode);
> > >         struct smack_known *skp = smk_of_current();
> > >         struct smack_known *isp = smk_of_inode(inode);
> > >         struct smack_known *dsp = smk_of_inode(dir);
> > > +       struct xattr *xattr = NULL;
> > >         int may;
> > > 
> > > -       if (name)
> > > -               *name = XATTR_SMACK_SUFFIX;
> > > +       if (xattrs)
> > > +               xattr = xattrs + smack_blob_sizes.lbs_xattr;
> > > +
> > > +       if (xattr) {
> > > +               xattr->name = XATTR_SMACK_SUFFIX;
> > > 
> > > -       if (value && len) {
> > >                 rcu_read_lock();
> > >                 may = smk_access_entry(skp->smk_known, dsp->smk_known,
> > >                                        &skp->smk_rules);
> > > @@ -976,11 +986,11 @@ static int smack_inode_init_security(struct inode *inode, struct inode *dir,
> > >                         issp->smk_flags |= SMK_INODE_CHANGED;
> > >                 }
> > > 
> > > -               *value = kstrdup(isp->smk_known, GFP_NOFS);
> > > -               if (*value == NULL)
> > > +               xattr->value = kstrdup(isp->smk_known, GFP_NOFS);
> > > +               if (xattr->value == NULL)
> > >                         return -ENOMEM;
> > > 
> > > -               *len = strlen(isp->smk_known);
> > > +               xattr->value_len = strlen(isp->smk_known);
> > >         }
> > > 
> > >         return 0;
> > > @@ -4854,6 +4864,7 @@ struct lsm_blob_sizes smack_blob_sizes __lsm_ro_after_init = {
> > >         .lbs_ipc = sizeof(struct smack_known *),
> > >         .lbs_msg_msg = sizeof(struct smack_known *),
> > >         .lbs_superblock = sizeof(struct superblock_smack),
> > > +       .lbs_xattr = SMACK_INODE_INIT_XATTRS,
> > >  };
> > > 
> > >  static struct security_hook_list smack_hooks[] __lsm_ro_after_init = {
> > > --
> > > 2.25.1

