Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 989E86373C3
	for <lists+linux-integrity@lfdr.de>; Thu, 24 Nov 2022 09:19:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbiKXITU (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 24 Nov 2022 03:19:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbiKXITF (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 24 Nov 2022 03:19:05 -0500
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2533101DB;
        Thu, 24 Nov 2022 00:18:34 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.229])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4NHrLL4Zc5z9xFVr;
        Thu, 24 Nov 2022 16:11:38 +0800 (CST)
Received: from roberto-ThinkStation-P620 (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwB3Y3CzKH9jAWuOAA--.29469S2;
        Thu, 24 Nov 2022 09:18:06 +0100 (CET)
Message-ID: <bb63eba9a9f24558f4a1acd9bf012b59b5c6e98e.camel@huaweicloud.com>
Subject: Re: [PATCH v6 4/6] security: Allow all LSMs to provide xattrs for
 inode_init_security hook
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     Mimi Zohar <zohar@linux.ibm.com>, mark@fasheh.com,
        jlbec@evilplan.org, joseph.qi@linux.alibaba.com,
        dmitry.kasatkin@gmail.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, stephen.smalley.work@gmail.com,
        eparis@parisplace.org, casey@schaufler-ca.com
Cc:     ocfs2-devel@oss.oracle.com, reiserfs-devel@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, keescook@chromium.org,
        nicolas.bouchinet@clip-os.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Date:   Thu, 24 Nov 2022 09:17:51 +0100
In-Reply-To: <13350b79f708cb089e2ff2ee5cead52bafb10982.camel@linux.ibm.com>
References: <20221123154712.752074-1-roberto.sassu@huaweicloud.com>
         <20221123154712.752074-5-roberto.sassu@huaweicloud.com>
         <13350b79f708cb089e2ff2ee5cead52bafb10982.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: LxC2BwB3Y3CzKH9jAWuOAA--.29469S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWF4rKw17Ar4UKF18JryxXwb_yoW5AF1rpF
        W8t3WDuF15JFyUWryFvr4Y9w4SkFy5GrWDG3srGFy2yFyDCrn3tryavF1Yka98ZrWkJr1v
        vayjyr1DWwn8J37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUk0b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42
        xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv
        6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUo0eHDUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAGBF1jj4XQZgABsA
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2022-11-23 at 20:14 -0500, Mimi Zohar wrote:
> Hi Roberto,
> 
> On Wed, 2022-11-23 at 16:47 +0100, Roberto Sassu wrote:
> >  int security_inode_init_security(struct inode *inode, struct inode *dir,
> >                                  const struct qstr *qstr,
> >                                  const initxattrs initxattrs, void *fs_data)
> >  {
> > -       struct xattr new_xattrs[MAX_LSM_EVM_XATTR + 1];
> > -       struct xattr *lsm_xattr, *evm_xattr, *xattr;
> > -       int ret;
> > +       struct security_hook_list *P;
> > +       struct xattr *new_xattrs;
> > +       struct xattr *xattr;
> > +       int ret = -EOPNOTSUPP, num_filled_xattrs = 0;
> >  
> >         if (unlikely(IS_PRIVATE(inode)))
> >                 return 0;
> >  
> > +       if (!blob_sizes.lbs_xattr)
> > +               return 0;
> > +
> >         if (!initxattrs)
> >                 return call_int_hook(inode_init_security, -EOPNOTSUPP, inode,
> > -                                    dir, qstr, NULL, NULL, NULL);
> > -       memset(new_xattrs, 0, sizeof(new_xattrs));
> > -       lsm_xattr = new_xattrs;
> > -       ret = call_int_hook(inode_init_security, -EOPNOTSUPP, inode, dir, qstr,
> > -                                               &lsm_xattr->name,
> > -                                               &lsm_xattr->value,
> > -                                               &lsm_xattr->value_len);
> > -       if (ret)
> > +                                   dir, qstr, NULL);
> > +       /* Allocate +1 for EVM and +1 as terminator. */
> > +       new_xattrs = kcalloc(blob_sizes.lbs_xattr + 2, sizeof(*new_xattrs),
> > +                            GFP_NOFS);
> > +       if (!new_xattrs)
> > +               return -ENOMEM;
> > +
> > +       hlist_for_each_entry(P, &security_hook_heads.inode_init_security,
> > +                            list) {
> > +               ret = P->hook.inode_init_security(inode, dir, qstr, new_xattrs);
> > +               if (ret && ret != -EOPNOTSUPP)
> > +                       goto out;
> > +               if (ret == -EOPNOTSUPP)
> > +                       continue;
> 
> In this context, -EOPNOTSUPP originally signified that the filesystem
> does not support writing xattrs.  Writing any xattr would fail. 
> Returning -ENODATA for no LSM xattr(s) data would seem to be more
> appropriate than -EOPNOTSUPP.

Hi Mimi

I thought about adding new return values. Currently only -EOPNOTSUPP
and -ENOMEM are expected as errors.

However, changing the conventions would mean revisiting the LSMs code
and ensuring that they follow the new conventions.

I would be more in favor of not touching it.

Thanks

Roberto

> thanks,
> 
> Mimi
> 
> > +               /*
> > +                * As the number of xattrs reserved by LSMs is not directly
> > +                * available, directly use the total number blob_sizes.lbs_xattr
> > +                * to keep the code simple, while being not the most efficient
> > +                * way.
> > +                */
> > +               ret = security_check_compact_filled_xattrs(new_xattrs,
> > +                                                          blob_sizes.lbs_xattr,
> > +                                                          &num_filled_xattrs);
> > +               if (ret < 0) {
> > +                       ret = -ENOMEM;
> > +                       goto out;
> > +               }
> > +       }
> > +
> > +       if (!num_filled_xattrs)
> >                 goto out;
> >  
> > -       evm_xattr = lsm_xattr + 1;
> > -       ret = evm_inode_init_security(inode, lsm_xattr, evm_xattr);
> > +       ret = evm_inode_init_security(inode, new_xattrs,
> > +                                     new_xattrs + num_filled_xattrs);
> >         if (ret)
> >                 goto out;
> >         ret = initxattrs(inode, new_xattrs, fs_data);
> >  out:
> >         for (xattr = new_xattrs; xattr->value != NULL; xattr++)
> >                 kfree(xattr->value);
> > +       kfree(new_xattrs);
> >         return (ret == -EOPNOTSUPP) ? 0 : ret;
> >  }
> b

