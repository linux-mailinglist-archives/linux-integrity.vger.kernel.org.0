Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A24B64B0C6
	for <lists+linux-integrity@lfdr.de>; Tue, 13 Dec 2022 09:06:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234532AbiLMIGz (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 13 Dec 2022 03:06:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234636AbiLMIGm (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 13 Dec 2022 03:06:42 -0500
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24866B1D2;
        Tue, 13 Dec 2022 00:06:40 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4NWW9t1sshz9v7cH;
        Tue, 13 Dec 2022 15:59:46 +0800 (CST)
Received: from roberto-ThinkStation-P620 (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwBnog1oMphjjUcMAA--.22467S2;
        Tue, 13 Dec 2022 09:06:11 +0100 (CET)
Message-ID: <bf05aa8c3161a799fae84a4acfc46dc54499b271.camel@huaweicloud.com>
Subject: Re: [PATCH v5 2/6] ocfs2: Switch to security_inode_init_security()
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     Mimi Zohar <zohar@linux.ibm.com>, mark@fasheh.com,
        jlbec@evilplan.org, joseph.qi@linux.alibaba.com,
        dmitry.kasatkin@gmail.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, stephen.smalley.work@gmail.com,
        eparis@parisplace.org, Casey Schaufler <casey@schaufler-ca.com>
Cc:     ocfs2-devel@oss.oracle.com, reiserfs-devel@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, keescook@chromium.org,
        nicolas.bouchinet@clip-os.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Date:   Tue, 13 Dec 2022 09:05:55 +0100
In-Reply-To: <8ca5be2f5ac0f5690a9025e5eec9fc93e8613842.camel@linux.ibm.com>
References: <20221123095202.599252-1-roberto.sassu@huaweicloud.com>
         <20221123095202.599252-3-roberto.sassu@huaweicloud.com>
         <052d91687e813110cc1e1d762ea086cc8085114a.camel@linux.ibm.com>
         <44de9254c7abf1c836142cf3262450de1912bbc0.camel@huaweicloud.com>
         <8ca5be2f5ac0f5690a9025e5eec9fc93e8613842.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: LxC2BwBnog1oMphjjUcMAA--.22467S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Ww4xZF1UAr1rurWrtw1UWrg_yoW3ur48pF
        W8KF1jkr4rJFyUWrWSqanI9an29rWrGrZrXrs3G347ZF1qkrn7tr10yr15ua4rJrW8JF10
        qw4UArsxuwn8A37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAFBF1jj4KTJgAAsF
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2022-11-29 at 08:14 -0500, Mimi Zohar wrote:
> On Thu, 2022-11-24 at 09:11 +0100, Roberto Sassu wrote:
> > On Wed, 2022-11-23 at 12:46 -0500, Mimi Zohar wrote:
> > > On Wed, 2022-11-23 at 10:51 +0100, Roberto Sassu wrote:
> > > > From: Roberto Sassu <roberto.sassu@huawei.com>
> > > > 
> > > > In preparation for removing security_old_inode_init_security(), switch to
> > > > security_inode_init_security().
> > > > 
> > > > Extend the existing ocfs2_initxattrs() to take the
> > > > ocfs2_security_xattr_info structure from fs_info, and populate the
> > > > name/value/len triple with the first xattr provided by LSMs. Supporting
> > > > multiple xattrs is not currently supported, as it requires non-trivial
> > > > changes that can be done at a later time.
> > > 
> > > ocfs2 already defines ocfs2_init_security_get() as a wrapper around
> > > calling either security_old_inode_init_security() or
> > > security_inode_init_security().  Based on "si" one or the other hook is
> > > called.  ocfs2_initxattrs is already defined.
> > > 
> > >         struct ocfs2_security_xattr_info si = {
> > >                 .name = NULL,
> > >                 .enable = 1,
> > >         };
> > > 
> > > The main difference between calling security_old_inode_init_security or
> > > security_inode_init_security() is whether or not security.evm is
> > > calculated and written.
> > 
> > Uhm, it seems unfortunately more complicated.
> > 
> > Calling security_old_inode_init_security() allows filesystems to get
> > the xattr, do some calculations (e.g. for reservation) and then write
> > the xattr.
> > 
> > The initxattrs() callback to be passed to
> > security_inode_init_security() is meant to let filesystems provide a
> > filesystem-specific way of writing the xattrs, just after LSMs provided
> > them. This seems incompatible with the old behavior, as a filesystem
> > might need to do the calculations in the middle before writing the
> > xattrs.
> > 
> > The initxattrs() callback, when security_old_inode_init_security() was
> > used, is just a way of emulating the old behavior, i.e. returning the
> > xattr to the caller.
> > 
> > It should be possible, I guess, to handle more xattrs but if the code
> > was designed to handle one, it would be better if the filesystem
> > maintainers add support for it.
> 
> Hi Mark, Joel, Joseph,
> 
> Commit 9d8f13ba3f48 ("security: new security_inode_init_security API
> adds function callback") introduced security_old_inode_init_security()
> to support reiserfs and ocfs2 a long time ago.  It was suppose to be a
> temporary fix until they moved to the new
> security_inode_init_security() hook.  ocsf2 partially migrated to
> security_inode_init_security(), but not completely.
> 
> security_old_inode_init_security() is finally going away.  Instead of
> migrating the remaining old usage to the new
> security_inode_init_security() properly, this patch simulates the
> existing usage.
> 
> Can we get some Reviewed-by, Tested-by tags or comments?

Ping.

Thanks

Roberto

> thanks,
> 
> Mimi
> 
> > > Perhaps it is time to remove the call to
> > > security_old_inode_init_security() in ocfs2_init_security_get().  We
> > > need to hear back from the ocfs2 community.  Mark?  Joel?
> > > 
> > > As noted previously this change affects mknod and symlinks.
> > > 
> > > 
> > > > As fs_info was not used before, ocfs2_initxattrs() can now handle the case
> > > > of replicating the behavior of security_old_inode_init_security(), i.e.
> > > > just obtaining the xattr, in addition to setting all xattrs provided by
> > > > LSMs.
> > > > 
> > > > Finally, modify the handling of the return value from
> > > > ocfs2_init_security_get(). As security_inode_init_security() does not
> > > > return -EOPNOTSUPP, remove this case and directly handle the error if the
> > > > return value is not zero.
> > > > 
> > > > However, the previous case of receiving -EOPNOTSUPP should be still
> > > > taken into account, as security_inode_init_security() could return zero
> > > > without setting xattrs and ocfs2 would consider it as if the xattr was set.
> > > > 
> > > > Instead, if security_inode_init_security() returned zero, look at the xattr
> > > > if it was set, and behave accordingly, i.e. set si->enable to zero to
> > > > notify to the functions following ocfs2_init_security_get() that the xattr
> > > > is not available (same as if security_old_inode_init_security() returned
> > > > -EOPNOTSUPP).
> > > > 
> > > > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > > > ---
> > > >  fs/ocfs2/namei.c | 18 ++++++------------
> > > >  fs/ocfs2/xattr.c | 30 ++++++++++++++++++++++++++----
> > > >  2 files changed, 32 insertions(+), 16 deletions(-)
> > > > 
> > > > diff --git a/fs/ocfs2/namei.c b/fs/ocfs2/namei.c
> > > > index 05f32989bad6..55fba81cd2d1 100644
> > > > --- a/fs/ocfs2/namei.c
> > > > +++ b/fs/ocfs2/namei.c
> > > > @@ -242,6 +242,7 @@ static int ocfs2_mknod(struct user_namespace *mnt_userns,
> > > >  	int want_meta = 0;
> > > >  	int xattr_credits = 0;
> > > >  	struct ocfs2_security_xattr_info si = {
> > > > +		.name = NULL,
> > > >  		.enable = 1,
> > > >  	};
> > > >  	int did_quota_inode = 0;
> > > > @@ -315,12 +316,8 @@ static int ocfs2_mknod(struct user_namespace *mnt_userns,
> > > >  	/* get security xattr */
> > > >  	status = ocfs2_init_security_get(inode, dir, &dentry->d_name, &si);
> > > >  	if (status) {
> > > > -		if (status == -EOPNOTSUPP)
> > > > -			si.enable = 0;
> > > > -		else {
> > > > -			mlog_errno(status);
> > > > -			goto leave;
> > > > -		}
> > > > +		mlog_errno(status);
> > > > +		goto leave;
> > > >  	}
> > > >  
> > > >  	/* calculate meta data/clusters for setting security and acl xattr */
> > > > @@ -1805,6 +1802,7 @@ static int ocfs2_symlink(struct user_namespace *mnt_userns,
> > > >  	int want_clusters = 0;
> > > >  	int xattr_credits = 0;
> > > >  	struct ocfs2_security_xattr_info si = {
> > > > +		.name = NULL,
> > > >  		.enable = 1,
> > > >  	};
> > > >  	int did_quota = 0, did_quota_inode = 0;
> > > > @@ -1875,12 +1873,8 @@ static int ocfs2_symlink(struct user_namespace *mnt_userns,
> > > >  	/* get security xattr */
> > > >  	status = ocfs2_init_security_get(inode, dir, &dentry->d_name, &si);
> > > >  	if (status) {
> > > > -		if (status == -EOPNOTSUPP)
> > > > -			si.enable = 0;
> > > > -		else {
> > > > -			mlog_errno(status);
> > > > -			goto bail;
> > > > -		}
> > > > +		mlog_errno(status);
> > > > +		goto bail;
> > > >  	}
> > > >  
> > > >  	/* calculate meta data/clusters for setting security xattr */
> > > > diff --git a/fs/ocfs2/xattr.c b/fs/ocfs2/xattr.c
> > > > index 95d0611c5fc7..55699c573541 100644
> > > > --- a/fs/ocfs2/xattr.c
> > > > +++ b/fs/ocfs2/xattr.c
> > > > @@ -7259,9 +7259,21 @@ static int ocfs2_xattr_security_set(const struct xattr_handler *handler,
> > > >  static int ocfs2_initxattrs(struct inode *inode, const struct xattr *xattr_array,
> > > >  		     void *fs_info)
> > > >  {
> > > > +	struct ocfs2_security_xattr_info *si = fs_info;
> > > >  	const struct xattr *xattr;
> > > >  	int err = 0;
> > > >  
> > > > +	if (si) {
> > > > +		si->value = kmemdup(xattr_array->value, xattr_array->value_len,
> > > > +				    GFP_KERNEL);
> > > > +		if (!si->value)
> > > > +			return -ENOMEM;
> > > > +
> > > > +		si->name = xattr_array->name;
> > > > +		si->value_len = xattr_array->value_len;
> > > > +		return 0;
> > > > +	}
> > > > +
> > > >  	for (xattr = xattr_array; xattr->name != NULL; xattr++) {
> > > >  		err = ocfs2_xattr_set(inode, OCFS2_XATTR_INDEX_SECURITY,
> > > >  				      xattr->name, xattr->value,
> > > > @@ -7277,13 +7289,23 @@ int ocfs2_init_security_get(struct inode *inode,
> > > >  			    const struct qstr *qstr,
> > > >  			    struct ocfs2_security_xattr_info *si)
> > > >  {
> > > > +	int ret;
> > > > +
> > > >  	/* check whether ocfs2 support feature xattr */
> > > >  	if (!ocfs2_supports_xattr(OCFS2_SB(dir->i_sb)))
> > > >  		return -EOPNOTSUPP;
> > > > -	if (si)
> > > > -		return security_old_inode_init_security(inode, dir, qstr,
> > > > -							&si->name, &si->value,
> > > > -							&si->value_len);
> > > > +	if (si) {
> > > > +		ret = security_inode_init_security(inode, dir, qstr,
> > > > +						   &ocfs2_initxattrs, si);
> > > > +		/*
> > > > +		 * security_inode_init_security() does not return -EOPNOTSUPP,
> > > > +		 * we have to check the xattr ourselves.
> > > > +		 */
> > > > +		if (!ret && !si->name)
> > > > +			si->enable = 0;
> > > > +
> > > > +		return ret;
> > > > +	}
> > > >  
> > > >  	return security_inode_init_security(inode, dir, qstr,
> > > >  					    &ocfs2_initxattrs, NULL);

