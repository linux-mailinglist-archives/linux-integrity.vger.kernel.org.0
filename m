Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D56A63C0CF
	for <lists+linux-integrity@lfdr.de>; Tue, 29 Nov 2022 14:16:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234145AbiK2NQW (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 29 Nov 2022 08:16:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233756AbiK2NPl (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 29 Nov 2022 08:15:41 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39E2E62077;
        Tue, 29 Nov 2022 05:15:35 -0800 (PST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ATCu9no004117;
        Tue, 29 Nov 2022 13:14:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=y/kKapuMNDnSVXnnqDIkkqYme+g/37hqRusGVTeU+po=;
 b=FsyPM2c/w0ag8TufqpFvr7Qwa9h+oC8pufbt5LYRrEknaHXlSVnEyhXAC1C5PoU7WrZO
 PCO3tCJ+5pK/cZ1h6QI99DOyNXTuKQLPaSrKaSaQpPfgIoVQplUcm12A8HYDR5K0X5ru
 49uWnW3vWzc+MK3R3xIUGj8aX5FC/UxG3WGOFrNj/Sidrakbs1vfiweazquSZUsEwN5y
 OlK6Yq7YNyWPW94Xu6E6aG6heLpTQl9FLoNrPzHdvpA2XgwQBkfCfa2dNxkmk2jq7Bqs
 xIiEjGd30NxPu+8lOrBqjmGOgcAb2z2WcspX/LkfjGyXYszwE8oS1pi7al7FKwtVupCB vA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3m5ebuf42g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Nov 2022 13:14:54 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2ATCMCvT029911;
        Tue, 29 Nov 2022 13:14:54 GMT
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3m5ebuf41f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Nov 2022 13:14:54 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2ATD5FeV007569;
        Tue, 29 Nov 2022 13:14:52 GMT
Received: from b03cxnp07027.gho.boulder.ibm.com (b03cxnp07027.gho.boulder.ibm.com [9.17.130.14])
        by ppma04wdc.us.ibm.com with ESMTP id 3m3ae9mngh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Nov 2022 13:14:52 +0000
Received: from smtpav06.dal12v.mail.ibm.com ([9.208.128.130])
        by b03cxnp07027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2ATDEpL417957484
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Nov 2022 13:14:51 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 564CF5805F;
        Tue, 29 Nov 2022 13:14:51 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 25D5758055;
        Tue, 29 Nov 2022 13:14:50 +0000 (GMT)
Received: from sig-9-77-136-107.ibm.com (unknown [9.77.136.107])
        by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 29 Nov 2022 13:14:50 +0000 (GMT)
Message-ID: <8ca5be2f5ac0f5690a9025e5eec9fc93e8613842.camel@linux.ibm.com>
Subject: Re: [PATCH v5 2/6] ocfs2: Switch to security_inode_init_security()
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>, mark@fasheh.com,
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
Date:   Tue, 29 Nov 2022 08:14:49 -0500
In-Reply-To: <44de9254c7abf1c836142cf3262450de1912bbc0.camel@huaweicloud.com>
References: <20221123095202.599252-1-roberto.sassu@huaweicloud.com>
         <20221123095202.599252-3-roberto.sassu@huaweicloud.com>
         <052d91687e813110cc1e1d762ea086cc8085114a.camel@linux.ibm.com>
         <44de9254c7abf1c836142cf3262450de1912bbc0.camel@huaweicloud.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: QGbtXPbEFoG0899_hHmsbOkIQfTtrwsP
X-Proofpoint-ORIG-GUID: rangmDOPJv7jxK-nMBZGxuD7vDRvxvY6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-29_08,2022-11-29_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=999 lowpriorityscore=0 spamscore=0 clxscore=1015 mlxscore=0
 impostorscore=0 adultscore=0 bulkscore=0 suspectscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211290076
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2022-11-24 at 09:11 +0100, Roberto Sassu wrote:
> On Wed, 2022-11-23 at 12:46 -0500, Mimi Zohar wrote:
> > On Wed, 2022-11-23 at 10:51 +0100, Roberto Sassu wrote:
> > > From: Roberto Sassu <roberto.sassu@huawei.com>
> > > 
> > > In preparation for removing security_old_inode_init_security(), switch to
> > > security_inode_init_security().
> > > 
> > > Extend the existing ocfs2_initxattrs() to take the
> > > ocfs2_security_xattr_info structure from fs_info, and populate the
> > > name/value/len triple with the first xattr provided by LSMs. Supporting
> > > multiple xattrs is not currently supported, as it requires non-trivial
> > > changes that can be done at a later time.
> > 
> > ocfs2 already defines ocfs2_init_security_get() as a wrapper around
> > calling either security_old_inode_init_security() or
> > security_inode_init_security().  Based on "si" one or the other hook is
> > called.  ocfs2_initxattrs is already defined.
> > 
> >         struct ocfs2_security_xattr_info si = {
> >                 .name = NULL,
> >                 .enable = 1,
> >         };
> > 
> > The main difference between calling security_old_inode_init_security or
> > security_inode_init_security() is whether or not security.evm is
> > calculated and written.
> 
> Uhm, it seems unfortunately more complicated.
> 
> Calling security_old_inode_init_security() allows filesystems to get
> the xattr, do some calculations (e.g. for reservation) and then write
> the xattr.
> 
> The initxattrs() callback to be passed to
> security_inode_init_security() is meant to let filesystems provide a
> filesystem-specific way of writing the xattrs, just after LSMs provided
> them. This seems incompatible with the old behavior, as a filesystem
> might need to do the calculations in the middle before writing the
> xattrs.
> 
> The initxattrs() callback, when security_old_inode_init_security() was
> used, is just a way of emulating the old behavior, i.e. returning the
> xattr to the caller.
> 
> It should be possible, I guess, to handle more xattrs but if the code
> was designed to handle one, it would be better if the filesystem
> maintainers add support for it.

Hi Mark, Joel, Joseph,

Commit 9d8f13ba3f48 ("security: new security_inode_init_security API
adds function callback") introduced security_old_inode_init_security()
to support reiserfs and ocfs2 a long time ago.  It was suppose to be a
temporary fix until they moved to the new
security_inode_init_security() hook.  ocsf2 partially migrated to
security_inode_init_security(), but not completely.

security_old_inode_init_security() is finally going away.  Instead of
migrating the remaining old usage to the new
security_inode_init_security() properly, this patch simulates the
existing usage.

Can we get some Reviewed-by, Tested-by tags or comments?

thanks,

Mimi

> 
> > Perhaps it is time to remove the call to
> > security_old_inode_init_security() in ocfs2_init_security_get().  We
> > need to hear back from the ocfs2 community.  Mark?  Joel?
> > 
> > As noted previously this change affects mknod and symlinks.
> > 
> > 
> > > As fs_info was not used before, ocfs2_initxattrs() can now handle the case
> > > of replicating the behavior of security_old_inode_init_security(), i.e.
> > > just obtaining the xattr, in addition to setting all xattrs provided by
> > > LSMs.
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
> 


