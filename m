Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ACD2636789
	for <lists+linux-integrity@lfdr.de>; Wed, 23 Nov 2022 18:47:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239220AbiKWRrR (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 23 Nov 2022 12:47:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239184AbiKWRrQ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 23 Nov 2022 12:47:16 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 842748DA40;
        Wed, 23 Nov 2022 09:47:15 -0800 (PST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ANHH9kE001552;
        Wed, 23 Nov 2022 17:46:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=VOvq9Sif0jOsBGBmaU8mrfW2vyYy0h6JoSd/AjbT9Ks=;
 b=Kk+tU5NXDLYJ0DJR0jE+smWMyPHYav7Cq4zcJ1t2TeMgRij6GDXjVb5pP+IfHi9peMfU
 1025N6XWkyMOoi1EQuKNUbR0TpPV+M6nah8zC0taJ6qJjBvWZGPlpfwOb31rSYjlzuQn
 LMmmdPz7xRtLCy3AHWEOEQiDoxeqE+H9XuYtWuqPfb6npwNXbhNLOucRadqo5JiAASTW
 fZ9txdOic9kZmjoG713yjmUibP7lVnPQMyRrpxmQGYkabsxmqWBB4f+yWQ3Yxy7knwif
 3QcJnzr1pU5oxvLdgqPMobtuBgXArn8QlxKFPjS2ixuES+sDF0Rv1z/be6iupJ+uzBwo qQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3m0ytbebwx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Nov 2022 17:46:47 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2ANFsKoT002146;
        Wed, 23 Nov 2022 17:46:46 GMT
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3m0ytbebwe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Nov 2022 17:46:46 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2ANHZcZH020151;
        Wed, 23 Nov 2022 17:46:45 GMT
Received: from b03cxnp07027.gho.boulder.ibm.com (b03cxnp07027.gho.boulder.ibm.com [9.17.130.14])
        by ppma03dal.us.ibm.com with ESMTP id 3kxpsakata-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Nov 2022 17:46:45 +0000
Received: from smtpav06.dal12v.mail.ibm.com ([9.208.128.130])
        by b03cxnp07027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2ANHkiAo64750018
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Nov 2022 17:46:44 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B32E25805E;
        Wed, 23 Nov 2022 17:46:43 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 19EFF58055;
        Wed, 23 Nov 2022 17:46:42 +0000 (GMT)
Received: from sig-9-77-136-225.ibm.com (unknown [9.77.136.225])
        by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 23 Nov 2022 17:46:42 +0000 (GMT)
Message-ID: <052d91687e813110cc1e1d762ea086cc8085114a.camel@linux.ibm.com>
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
Date:   Wed, 23 Nov 2022 12:46:41 -0500
In-Reply-To: <20221123095202.599252-3-roberto.sassu@huaweicloud.com>
References: <20221123095202.599252-1-roberto.sassu@huaweicloud.com>
         <20221123095202.599252-3-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: LowqJc8EUSLn8wXkT86SS7MXD5C61WyH
X-Proofpoint-GUID: 3a74IJhshYsPx_7snIfh2sln3Rs7dXCP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-23_10,2022-11-23_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 impostorscore=0 mlxscore=0 lowpriorityscore=0 mlxlogscore=999 adultscore=0
 clxscore=1015 malwarescore=0 spamscore=0 priorityscore=1501 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211230129
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2022-11-23 at 10:51 +0100, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
> 
> In preparation for removing security_old_inode_init_security(), switch to
> security_inode_init_security().
> 
> Extend the existing ocfs2_initxattrs() to take the
> ocfs2_security_xattr_info structure from fs_info, and populate the
> name/value/len triple with the first xattr provided by LSMs. Supporting
> multiple xattrs is not currently supported, as it requires non-trivial
> changes that can be done at a later time.

ocfs2 already defines ocfs2_init_security_get() as a wrapper around
calling either security_old_inode_init_security() or
security_inode_init_security().  Based on "si" one or the other hook is
called.  ocfs2_initxattrs is already defined.

        struct ocfs2_security_xattr_info si = {
                .name = NULL,
                .enable = 1,
        };

The main difference between calling security_old_inode_init_security or
security_inode_init_security() is whether or not security.evm is
calculated and written.

Perhaps it is time to remove the call to
security_old_inode_init_security() in ocfs2_init_security_get().  We
need to hear back from the ocfs2 community.  Mark?  Joel?

As noted previously this change affects mknod and symlinks.

Mimi

> 
> As fs_info was not used before, ocfs2_initxattrs() can now handle the case
> of replicating the behavior of security_old_inode_init_security(), i.e.
> just obtaining the xattr, in addition to setting all xattrs provided by
> LSMs.
> 
> Finally, modify the handling of the return value from
> ocfs2_init_security_get(). As security_inode_init_security() does not
> return -EOPNOTSUPP, remove this case and directly handle the error if the
> return value is not zero.
> 
> However, the previous case of receiving -EOPNOTSUPP should be still
> taken into account, as security_inode_init_security() could return zero
> without setting xattrs and ocfs2 would consider it as if the xattr was set.
> 
> Instead, if security_inode_init_security() returned zero, look at the xattr
> if it was set, and behave accordingly, i.e. set si->enable to zero to
> notify to the functions following ocfs2_init_security_get() that the xattr
> is not available (same as if security_old_inode_init_security() returned
> -EOPNOTSUPP).
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>  fs/ocfs2/namei.c | 18 ++++++------------
>  fs/ocfs2/xattr.c | 30 ++++++++++++++++++++++++++----
>  2 files changed, 32 insertions(+), 16 deletions(-)
> 
> diff --git a/fs/ocfs2/namei.c b/fs/ocfs2/namei.c
> index 05f32989bad6..55fba81cd2d1 100644
> --- a/fs/ocfs2/namei.c
> +++ b/fs/ocfs2/namei.c
> @@ -242,6 +242,7 @@ static int ocfs2_mknod(struct user_namespace *mnt_userns,
>  	int want_meta = 0;
>  	int xattr_credits = 0;
>  	struct ocfs2_security_xattr_info si = {
> +		.name = NULL,
>  		.enable = 1,
>  	};
>  	int did_quota_inode = 0;
> @@ -315,12 +316,8 @@ static int ocfs2_mknod(struct user_namespace *mnt_userns,
>  	/* get security xattr */
>  	status = ocfs2_init_security_get(inode, dir, &dentry->d_name, &si);
>  	if (status) {
> -		if (status == -EOPNOTSUPP)
> -			si.enable = 0;
> -		else {
> -			mlog_errno(status);
> -			goto leave;
> -		}
> +		mlog_errno(status);
> +		goto leave;
>  	}
>  
>  	/* calculate meta data/clusters for setting security and acl xattr */
> @@ -1805,6 +1802,7 @@ static int ocfs2_symlink(struct user_namespace *mnt_userns,
>  	int want_clusters = 0;
>  	int xattr_credits = 0;
>  	struct ocfs2_security_xattr_info si = {
> +		.name = NULL,
>  		.enable = 1,
>  	};
>  	int did_quota = 0, did_quota_inode = 0;
> @@ -1875,12 +1873,8 @@ static int ocfs2_symlink(struct user_namespace *mnt_userns,
>  	/* get security xattr */
>  	status = ocfs2_init_security_get(inode, dir, &dentry->d_name, &si);
>  	if (status) {
> -		if (status == -EOPNOTSUPP)
> -			si.enable = 0;
> -		else {
> -			mlog_errno(status);
> -			goto bail;
> -		}
> +		mlog_errno(status);
> +		goto bail;
>  	}
>  
>  	/* calculate meta data/clusters for setting security xattr */
> diff --git a/fs/ocfs2/xattr.c b/fs/ocfs2/xattr.c
> index 95d0611c5fc7..55699c573541 100644
> --- a/fs/ocfs2/xattr.c
> +++ b/fs/ocfs2/xattr.c
> @@ -7259,9 +7259,21 @@ static int ocfs2_xattr_security_set(const struct xattr_handler *handler,
>  static int ocfs2_initxattrs(struct inode *inode, const struct xattr *xattr_array,
>  		     void *fs_info)
>  {
> +	struct ocfs2_security_xattr_info *si = fs_info;
>  	const struct xattr *xattr;
>  	int err = 0;
>  
> +	if (si) {
> +		si->value = kmemdup(xattr_array->value, xattr_array->value_len,
> +				    GFP_KERNEL);
> +		if (!si->value)
> +			return -ENOMEM;
> +
> +		si->name = xattr_array->name;
> +		si->value_len = xattr_array->value_len;
> +		return 0;
> +	}
> +
>  	for (xattr = xattr_array; xattr->name != NULL; xattr++) {
>  		err = ocfs2_xattr_set(inode, OCFS2_XATTR_INDEX_SECURITY,
>  				      xattr->name, xattr->value,
> @@ -7277,13 +7289,23 @@ int ocfs2_init_security_get(struct inode *inode,
>  			    const struct qstr *qstr,
>  			    struct ocfs2_security_xattr_info *si)
>  {
> +	int ret;
> +
>  	/* check whether ocfs2 support feature xattr */
>  	if (!ocfs2_supports_xattr(OCFS2_SB(dir->i_sb)))
>  		return -EOPNOTSUPP;
> -	if (si)
> -		return security_old_inode_init_security(inode, dir, qstr,
> -							&si->name, &si->value,
> -							&si->value_len);
> +	if (si) {
> +		ret = security_inode_init_security(inode, dir, qstr,
> +						   &ocfs2_initxattrs, si);
> +		/*
> +		 * security_inode_init_security() does not return -EOPNOTSUPP,
> +		 * we have to check the xattr ourselves.
> +		 */
> +		if (!ret && !si->name)
> +			si->enable = 0;
> +
> +		return ret;
> +	}
>  
>  	return security_inode_init_security(inode, dir, qstr,
>  					    &ocfs2_initxattrs, NULL);


