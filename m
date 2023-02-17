Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E95A069B4CD
	for <lists+linux-integrity@lfdr.de>; Fri, 17 Feb 2023 22:30:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbjBQVa4 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 17 Feb 2023 16:30:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbjBQVaz (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 17 Feb 2023 16:30:55 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 773951114D;
        Fri, 17 Feb 2023 13:30:53 -0800 (PST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31HKZR5K025011;
        Fri, 17 Feb 2023 21:30:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=p/r/IgDm87Tg50qN8UcTg7CPY96iXbCv375Crz/M9t8=;
 b=hwsp6o0/xjemUyCbC8CTAJ7kd1mJfGycAfAEPeECkMijMai4WQNGrsyibonjkY+Re3JM
 lsaA8h2iummAqJOlzs4ESOPgy2VyHwqZBq2D1yFptWO/KErFEAexndt+tfFpLBVoB23F
 cQ2S2Wx/D9i9rfPlwt1SCer+mNf2cakL3lSz9/teqduzNAZWqL1p6a3a10P3ruE2P28c
 XNHr1V2bQUAy56K50OHTYndlDz6odQqYgrkRn7c1Yz0bwwUndfhrE62qIpGkabphWQOo
 l/KBDN1cCLyZJjNczAFz6rtYcAXcytShLc+rMx3AKHeUOgdZOV5o3ZYfcu/6arkMDIBe WA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3ntd3dpfq7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Feb 2023 21:30:24 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 31HLQ74E016133;
        Fri, 17 Feb 2023 21:30:23 GMT
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3ntd3dpfpq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Feb 2023 21:30:23 +0000
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31HKPon8016541;
        Fri, 17 Feb 2023 21:30:22 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([9.208.129.120])
        by ppma01wdc.us.ibm.com (PPS) with ESMTPS id 3np2n79rqr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Feb 2023 21:30:22 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
        by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31HLULZT3539568
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Feb 2023 21:30:21 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C70B45805B;
        Fri, 17 Feb 2023 21:30:21 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 44F1B58055;
        Fri, 17 Feb 2023 21:30:19 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.25.123])
        by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 17 Feb 2023 21:30:19 +0000 (GMT)
Message-ID: <aaeee7490cfee1b2163a3c9c894294aaf13e100c.camel@linux.ibm.com>
Subject: Re: [PATCH v7 2/6] ocfs2: Switch to security_inode_init_security()
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>, mark@fasheh.com,
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
Date:   Fri, 17 Feb 2023 16:30:15 -0500
In-Reply-To: <a20a6d84d8e682fbff546b80eda75a1918d7c108.camel@linux.ibm.com>
References: <20221201104125.919483-1-roberto.sassu@huaweicloud.com>
         <20221201104125.919483-3-roberto.sassu@huaweicloud.com>
         <a20a6d84d8e682fbff546b80eda75a1918d7c108.camel@linux.ibm.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: GksIPGug5-2bMPWHC3PpHKYwxPW86-Ac
X-Proofpoint-ORIG-GUID: uq2Z_zXEcPhRvQoV9G7RakzlHiyE5IFf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-17_14,2023-02-17_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 mlxscore=0 malwarescore=0 phishscore=0
 suspectscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302170185
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2023-02-17 at 14:51 -0500, Mimi Zohar wrote:
> On Thu, 2022-12-01 at 11:41 +0100, Roberto Sassu wrote:
> > From: Roberto Sassu <roberto.sassu@huawei.com>
> > 
> > In preparation for removing security_old_inode_init_security(), switch to
> > security_inode_init_security().
> > 
> > Extend the existing ocfs2_initxattrs() to take the
> > ocfs2_security_xattr_info structure from fs_info, and populate the
> > name/value/len triple with the first xattr provided by LSMs.
> > 
> > As fs_info was not used before, ocfs2_initxattrs() can now handle the case
> > of replicating the behavior of security_old_inode_init_security(), i.e.
> > just obtaining the xattr, in addition to setting all xattrs provided by
> > LSMs.
> > 
> > Supporting multiple xattrs is not currently supported where
> > security_old_inode_init_security() was called (mknod, symlink), as it
> > requires non-trivial changes that can be done at a later time. Like for
> > reiserfs, even if EVM is invoked, it will not provide an xattr (if it is
> > not the first to set it, its xattr will be discarded; if it is the first,
> > it does not have xattrs to calculate the HMAC on).
> > 
> > Finally, modify the handling of the return value from
> > ocfs2_init_security_get(). As security_inode_init_security() does not
> > return -EOPNOTSUPP, remove this case and directly handle the error if the
> > return value is not zero.
> > 
> > However, the previous case of receiving -EOPNOTSUPP should be still
> > taken into account, as security_inode_init_security() could return zero
> > without setting xattrs and ocfs2 would consider it as if the xattr was set.
> > 
> > Instead, if security_inode_init_security() returned zero, look at the xattr
> > if it was set, and behave accordingly, i.e. set si->enable to zero to
> > notify to the functions following ocfs2_init_security_get() that the xattr
> > is not available (same as if security_old_inode_init_security() returned
> > -EOPNOTSUPP).
> > 
> > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
> 
> My previous review missed a couple of concerns.
> 
> > ---
> >  fs/ocfs2/namei.c | 18 ++++++------------
> >  fs/ocfs2/xattr.c | 30 ++++++++++++++++++++++++++----
> >  2 files changed, 32 insertions(+), 16 deletions(-)
> > 
> > diff --git a/fs/ocfs2/namei.c b/fs/ocfs2/namei.c
> > index 05f32989bad6..55fba81cd2d1 100644
> > --- a/fs/ocfs2/namei.c
> > +++ b/fs/ocfs2/namei.c
> > @@ -242,6 +242,7 @@ static int ocfs2_mknod(struct user_namespace *mnt_userns,
> >  	int want_meta = 0;
> >  	int xattr_credits = 0;
> >  	struct ocfs2_security_xattr_info si = {
> > +		.name = NULL,
> >  		.enable = 1,
> >  	};
> >  	int did_quota_inode = 0;
> > @@ -315,12 +316,8 @@ static int ocfs2_mknod(struct user_namespace *mnt_userns,
> >  	/* get security xattr */
> >  	status = ocfs2_init_security_get(inode, dir, &dentry->d_name, &si);
> >  	if (status) {
> > -		if (status == -EOPNOTSUPP)
> > -			si.enable = 0;
> > -		else {
> > -			mlog_errno(status);
> > -			goto leave;
> > -		}
> 
> Although security_inode_init_security() does not return -EOPNOTSUPP, 
> ocfs2_init_security_get() could.  Refer to commit 8154da3d2114 ("ocfs2:
> Add incompatible flag for extended attribute").   It was added as a
> temporary solution back in 2008, so it is highly unlikely that it is
> still needed.
> 
> > +		mlog_errno(status);
> > +		goto leave;
> 
> Without the -EOPNOTSUPP test, ocfs2_mknod() would not create the inode;
> and similarly ocfs2_symlink(), below, would not create the symlink.  It
> would be safer not to remove the -EOPNOTSUPP test.
> 
> >  	}
> >  
> >  	/* calculate meta data/clusters for setting security and acl xattr */
> > @@ -1805,6 +1802,7 @@ static int ocfs2_symlink(struct user_namespace *mnt_userns,
> >  	int want_clusters = 0;
> >  	int xattr_credits = 0;
> >  	struct ocfs2_security_xattr_info si = {
> > +		.name = NULL,
> >  		.enable = 1,
> >  	};
> >  	int did_quota = 0, did_quota_inode = 0;
> > @@ -1875,12 +1873,8 @@ static int ocfs2_symlink(struct user_namespace *mnt_userns,
> >  	/* get security xattr */
> >  	status = ocfs2_init_security_get(inode, dir, &dentry->d_name, &si);
> >  	if (status) {
> > -		if (status == -EOPNOTSUPP)
> > -			si.enable = 0;
> > -		else {
> > -			mlog_errno(status);
> > -			goto bail;
> > -		}
> > +		mlog_errno(status);
> > +		goto bail;
> >  	}
> >  
> >  	/* calculate meta data/clusters for setting security xattr */
> > diff --git a/fs/ocfs2/xattr.c b/fs/ocfs2/xattr.c
> > index 95d0611c5fc7..55699c573541 100644
> > --- a/fs/ocfs2/xattr.c
> > +++ b/fs/ocfs2/xattr.c
> > @@ -7259,9 +7259,21 @@ static int ocfs2_xattr_security_set(const struct xattr_handler *handler,
> >  static int ocfs2_initxattrs(struct inode *inode, const struct xattr *xattr_array,
> >  		     void *fs_info)
> >  {
> > +	struct ocfs2_security_xattr_info *si = fs_info;
> >  	const struct xattr *xattr;
> >  	int err = 0;
> >  
> > +	if (si) {
> > +		si->value = kmemdup(xattr_array->value, xattr_array->value_len,
> > +				    GFP_KERNEL);
> > +		if (!si->value)
> > +			return -ENOMEM;
> > +
> > +		si->name = xattr_array->name;
> > +		si->value_len = xattr_array->value_len;
> > +		return 0;
> > +	}
> > +
> >  	for (xattr = xattr_array; xattr->name != NULL; xattr++) {
> >  		err = ocfs2_xattr_set(inode, OCFS2_XATTR_INDEX_SECURITY,
> >  				      xattr->name, xattr->value,
> > @@ -7277,13 +7289,23 @@ int ocfs2_init_security_get(struct inode *inode,
> >  			    const struct qstr *qstr,
> >  			    struct ocfs2_security_xattr_info *si)
> >  {
> > +	int ret;
> > +
> >  	/* check whether ocfs2 support feature xattr */
> >  	if (!ocfs2_supports_xattr(OCFS2_SB(dir->i_sb)))
> >  		return -EOPNOTSUPP;
> > -	if (si)
> > -		return security_old_inode_init_security(inode, dir, qstr,
> > -							&si->name, &si->value,
> > -							&si->value_len);
> > +	if (si) {
> > +		ret = security_inode_init_security(inode, dir, qstr,
> > +						   &ocfs2_initxattrs, si);
> 
> The "if (unlikely(IS_PRIVATE(inode))"  test exists in both
> security_old_inode_init_security() and security_inode_init_security(),
> but return different values.  In the former case, it returns
> -EOPNOTSUPP.  In the latter case, it returns 0.  The question is
> whether or not we need to be concerned about private inodes on ocfs2.  
> If private inodes on ocfs2 are possible, then ocsf2_mknod() or
> ocfs2_symlink() would fail to create the inode or symlink.

Correction, previously when returning -EOPNOTSUPP for private inodes,
xattrs would not be wrriten.  By returning 0 without setting si->enable 
to 0, xattrs will be written.
 
> 
> > +		/*
> > +		 * security_inode_init_security() does not return -EOPNOTSUPP,
> > +		 * we have to check the xattr ourselves.
> > +		 */
> > +		if (!ret && !si->name)
> > +			si->enable = 0;
> > +
> > +		return ret;
> > +	}
> >  
> >  	return security_inode_init_security(inode, dir, qstr,
> >  					    &ocfs2_initxattrs, NULL);
> 

-- 
thanks,

Mimi

