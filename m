Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A65A69DB7E
	for <lists+linux-integrity@lfdr.de>; Tue, 21 Feb 2023 08:52:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233271AbjBUHwp (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 21 Feb 2023 02:52:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232710AbjBUHwo (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 21 Feb 2023 02:52:44 -0500
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E19041D901;
        Mon, 20 Feb 2023 23:52:41 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4PLWWb6NyFz9v7ZD;
        Tue, 21 Feb 2023 15:44:11 +0800 (CST)
Received: from roberto-ThinkStation-P620 (unknown [10.204.63.22])
        by APP2 (Coremail) with SMTP id GxC2BwD3wlkhePRj0Cc7AQ--.55243S2;
        Tue, 21 Feb 2023 08:52:12 +0100 (CET)
Message-ID: <76f8e98bd89d19545ff84ebcac4c41853455d22b.camel@huaweicloud.com>
Subject: Re: [PATCH v7 2/6] ocfs2: Switch to security_inode_init_security()
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     Joseph Qi <joseph.qi@linux.alibaba.com>, mark@fasheh.com,
        jlbec@evilplan.org, zohar@linux.ibm.com, dmitry.kasatkin@gmail.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        stephen.smalley.work@gmail.com, eparis@parisplace.org,
        casey@schaufler-ca.com
Cc:     ocfs2-devel@oss.oracle.com, reiserfs-devel@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, keescook@chromium.org,
        nicolas.bouchinet@clip-os.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Date:   Tue, 21 Feb 2023 08:51:56 +0100
In-Reply-To: <d5180ef2-70dc-0a43-3e1b-c04d9e14ab23@linux.alibaba.com>
References: <20221201104125.919483-1-roberto.sassu@huaweicloud.com>
         <20221201104125.919483-3-roberto.sassu@huaweicloud.com>
         <6905166125130c22c244ebf234723d1587a01ae8.camel@huaweicloud.com>
         <d5180ef2-70dc-0a43-3e1b-c04d9e14ab23@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: GxC2BwD3wlkhePRj0Cc7AQ--.55243S2
X-Coremail-Antispam: 1UD129KBjvJXoWxKry7Aw1kCFW3ury5ZF1fJFb_yoWxAw4UpF
        WrtF1akF4rJFyUuryaq3WY9a1I9rWfGrZrGrs3J347ZF1q9r1ftry8Ar15ua45ZrW8JFy8
        tr4UCFsxu3Z8Ja7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42
        xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UZ18PUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAPBF1jj4WkAQADsb
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2023-02-21 at 14:45 +0800, Joseph Qi wrote:
> Hi,
> 
> Sorry for the late reply.
> 
> I don't have much background on this thread. It seems that we have to
> check EOPNOTSUPP since ocfs2_init_security_get() may return EOPNOTSUPP
> if it doesn't support extended attribute feature for backward
> compatibility.

Hi Joseph

yes, I already reintroduced the check. Thanks for having a look.

Roberto

> Other looks good. So with above comments addressed, you can add:
> Acked-by: Joseph Qi <joseph.qi@linux.alibaba.com>
> 
> On 1/10/23 4:55 PM, Roberto Sassu wrote:
> > On Thu, 2022-12-01 at 11:41 +0100, Roberto Sassu wrote:
> > > From: Roberto Sassu <roberto.sassu@huawei.com>
> > > 
> > > In preparation for removing security_old_inode_init_security(), switch to
> > > security_inode_init_security().
> > > 
> > > Extend the existing ocfs2_initxattrs() to take the
> > > ocfs2_security_xattr_info structure from fs_info, and populate the
> > > name/value/len triple with the first xattr provided by LSMs.
> > 
> > Hi Mark, Joel, Joseph
> > 
> > some time ago I sent this patch set to switch to the newer
> > function security_inode_init_security(). Almost all the other parts of
> > this patch set have been reviewed, and the patch set itself should be
> > ready to be merged.
> > 
> > I kindly ask if you could have a look at this patch and give your
> > Reviewed-by, so that Paul could take the patch set.
> > 
> > Thanks a lot!
> > 
> > Roberto
> > 
> > > As fs_info was not used before, ocfs2_initxattrs() can now handle the case
> > > of replicating the behavior of security_old_inode_init_security(), i.e.
> > > just obtaining the xattr, in addition to setting all xattrs provided by
> > > LSMs.
> > > 
> > > Supporting multiple xattrs is not currently supported where
> > > security_old_inode_init_security() was called (mknod, symlink), as it
> > > requires non-trivial changes that can be done at a later time. Like for
> > > reiserfs, even if EVM is invoked, it will not provide an xattr (if it is
> > > not the first to set it, its xattr will be discarded; if it is the first,
> > > it does not have xattrs to calculate the HMAC on).
> > > 
> > > Finally, modify the handling of the return value from
> > > ocfs2_init_security_get(). As security_inode_init_security() does not
> > > return -EOPNOTSUPP, remove this case and directly handle the error if the
> > > return value is not zero.
> > > 
> > > However, the previous case of receiving -EOPNOTSUPP should be still
> > > taken into account, as security_inode_init_security() could return zero
> > > without setting xattrs and ocfs2 would consider it as if the xattr was set.
> > > 
> > > Instead, if security_inode_init_security() returned zero, look at the xattr
> > > if it was set, and behave accordingly, i.e. set si->enable to zero to
> > > notify to the functions following ocfs2_init_security_get() that the xattr
> > > is not available (same as if security_old_inode_init_security() returned
> > > -EOPNOTSUPP).
> > > 
> > > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > > Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
> > > ---
> > >  fs/ocfs2/namei.c | 18 ++++++------------
> > >  fs/ocfs2/xattr.c | 30 ++++++++++++++++++++++++++----
> > >  2 files changed, 32 insertions(+), 16 deletions(-)
> > > 
> > > diff --git a/fs/ocfs2/namei.c b/fs/ocfs2/namei.c
> > > index 05f32989bad6..55fba81cd2d1 100644
> > > --- a/fs/ocfs2/namei.c
> > > +++ b/fs/ocfs2/namei.c
> > > @@ -242,6 +242,7 @@ static int ocfs2_mknod(struct user_namespace *mnt_userns,
> > >  	int want_meta = 0;
> > >  	int xattr_credits = 0;
> > >  	struct ocfs2_security_xattr_info si = {
> > > +		.name = NULL,
> > >  		.enable = 1,
> > >  	};
> > >  	int did_quota_inode = 0;
> > > @@ -315,12 +316,8 @@ static int ocfs2_mknod(struct user_namespace *mnt_userns,
> > >  	/* get security xattr */
> > >  	status = ocfs2_init_security_get(inode, dir, &dentry->d_name, &si);
> > >  	if (status) {
> > > -		if (status == -EOPNOTSUPP)
> > > -			si.enable = 0;
> > > -		else {
> > > -			mlog_errno(status);
> > > -			goto leave;
> > > -		}
> > > +		mlog_errno(status);
> > > +		goto leave;
> > >  	}
> > >  
> > >  	/* calculate meta data/clusters for setting security and acl xattr */
> > > @@ -1805,6 +1802,7 @@ static int ocfs2_symlink(struct user_namespace *mnt_userns,
> > >  	int want_clusters = 0;
> > >  	int xattr_credits = 0;
> > >  	struct ocfs2_security_xattr_info si = {
> > > +		.name = NULL,
> > >  		.enable = 1,
> > >  	};
> > >  	int did_quota = 0, did_quota_inode = 0;
> > > @@ -1875,12 +1873,8 @@ static int ocfs2_symlink(struct user_namespace *mnt_userns,
> > >  	/* get security xattr */
> > >  	status = ocfs2_init_security_get(inode, dir, &dentry->d_name, &si);
> > >  	if (status) {
> > > -		if (status == -EOPNOTSUPP)
> > > -			si.enable = 0;
> > > -		else {
> > > -			mlog_errno(status);
> > > -			goto bail;
> > > -		}
> > > +		mlog_errno(status);
> > > +		goto bail;
> > >  	}
> > >  
> > >  	/* calculate meta data/clusters for setting security xattr */
> > > diff --git a/fs/ocfs2/xattr.c b/fs/ocfs2/xattr.c
> > > index 95d0611c5fc7..55699c573541 100644
> > > --- a/fs/ocfs2/xattr.c
> > > +++ b/fs/ocfs2/xattr.c
> > > @@ -7259,9 +7259,21 @@ static int ocfs2_xattr_security_set(const struct xattr_handler *handler,
> > >  static int ocfs2_initxattrs(struct inode *inode, const struct xattr *xattr_array,
> > >  		     void *fs_info)
> > >  {
> > > +	struct ocfs2_security_xattr_info *si = fs_info;
> > >  	const struct xattr *xattr;
> > >  	int err = 0;
> > >  
> > > +	if (si) {
> > > +		si->value = kmemdup(xattr_array->value, xattr_array->value_len,
> > > +				    GFP_KERNEL);
> > > +		if (!si->value)
> > > +			return -ENOMEM;
> > > +
> > > +		si->name = xattr_array->name;
> > > +		si->value_len = xattr_array->value_len;
> > > +		return 0;
> > > +	}
> > > +
> > >  	for (xattr = xattr_array; xattr->name != NULL; xattr++) {
> > >  		err = ocfs2_xattr_set(inode, OCFS2_XATTR_INDEX_SECURITY,
> > >  				      xattr->name, xattr->value,
> > > @@ -7277,13 +7289,23 @@ int ocfs2_init_security_get(struct inode *inode,
> > >  			    const struct qstr *qstr,
> > >  			    struct ocfs2_security_xattr_info *si)
> > >  {
> > > +	int ret;
> > > +
> > >  	/* check whether ocfs2 support feature xattr */
> > >  	if (!ocfs2_supports_xattr(OCFS2_SB(dir->i_sb)))
> > >  		return -EOPNOTSUPP;
> > > -	if (si)
> > > -		return security_old_inode_init_security(inode, dir, qstr,
> > > -							&si->name, &si->value,
> > > -							&si->value_len);
> > > +	if (si) {
> > > +		ret = security_inode_init_security(inode, dir, qstr,
> > > +						   &ocfs2_initxattrs, si);
> > > +		/*
> > > +		 * security_inode_init_security() does not return -EOPNOTSUPP,
> > > +		 * we have to check the xattr ourselves.
> > > +		 */
> > > +		if (!ret && !si->name)
> > > +			si->enable = 0;
> > > +
> > > +		return ret;
> > > +	}
> > >  
> > >  	return security_inode_init_security(inode, dir, qstr,
> > >  					    &ocfs2_initxattrs, NULL);

