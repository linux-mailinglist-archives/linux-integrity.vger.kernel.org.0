Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6E0469C225
	for <lists+linux-integrity@lfdr.de>; Sun, 19 Feb 2023 20:42:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231372AbjBSTmv (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 19 Feb 2023 14:42:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231370AbjBSTmv (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 19 Feb 2023 14:42:51 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F34C1733;
        Sun, 19 Feb 2023 11:42:49 -0800 (PST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31JHeYuK026969;
        Sun, 19 Feb 2023 19:41:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=s63DfqR4NiC3QZGz8yhFyKSMoul9bYlY7/ahn77RpF4=;
 b=LbScWa+/jpKBo4XSMLSlaXfty+s6n+EDSLfluGUo9+gnmcsIlrU60INox9/lcZY2PA0Y
 hLUj2vm/woxrkwlXp9aPJyZcZLhHCe47gKAnzahmfx+2llFIMZQg/xWAAYljYpqXzIrT
 +s4CyusDNGasMpUZhNdevGPBnkjLMu+uZb4hg0iWwMgW6+FfMZVy2/DA6Xvrsql2vXHf
 /q+69TaoJ2Zwff4Mq2xQ7lYYPndr/6dzTThx2p3UCW5fVIS55gkIxwOkYUaIojQdToQ1
 GvT/pl9rfqLZBqfElAXk5BI6+RUM6FeLNE1iDfgE3m2ysyPmmE5WAsBqCekdw1U8RskP /w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nuqgu2713-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 19 Feb 2023 19:41:59 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 31JJUQSq006336;
        Sun, 19 Feb 2023 19:41:58 GMT
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nuqgu270v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 19 Feb 2023 19:41:58 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31JID6dU004503;
        Sun, 19 Feb 2023 19:41:57 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([9.208.129.114])
        by ppma04wdc.us.ibm.com (PPS) with ESMTPS id 3ntpa6s3gf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 19 Feb 2023 19:41:56 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
        by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31JJftRA28836592
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 19 Feb 2023 19:41:55 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 542625805E;
        Sun, 19 Feb 2023 19:41:55 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D87D058052;
        Sun, 19 Feb 2023 19:41:53 +0000 (GMT)
Received: from sig-9-65-218-178.ibm.com (unknown [9.65.218.178])
        by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Sun, 19 Feb 2023 19:41:53 +0000 (GMT)
Message-ID: <b7b4eeb060d1f662f990b3ebb3848fa4ab7e8c97.camel@linux.ibm.com>
Subject: Re: [PATCH v7 5/6] evm: Align evm_inode_init_security() definition
 with LSM infrastructure
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
Date:   Sun, 19 Feb 2023 14:41:47 -0500
In-Reply-To: <20221201104125.919483-6-roberto.sassu@huaweicloud.com>
References: <20221201104125.919483-1-roberto.sassu@huaweicloud.com>
         <20221201104125.919483-6-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: PIqnX7MkcDx9MSQ9O8jwB2A5iVhfTruB
X-Proofpoint-ORIG-GUID: L6hFSedEGdzOEMGH9xja22553RiA3L3r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-19_12,2023-02-17_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 mlxscore=0 clxscore=1015 mlxlogscore=999 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302190186
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2022-12-01 at 11:41 +0100, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
> 
> Change the evm_inode_init_security() definition to align with the LSM
> infrastructure. Keep the existing behavior of including in the HMAC
> calculation only the first xattr provided by LSMs.
> 
> Changing the evm_inode_init_security() definition requires passing only the
> xattr array allocated by security_inode_init_security(), instead of the
> first LSM xattr and the place where the EVM xattr should be filled. In lieu
> of passing the EVM xattr, EVM must position itself after the last filled
> xattr (by checking the xattr name), since only the beginning of the xattr
> array is given.
> 
> Finally, make evm_inode_init_security() return value compatible with the
> inode_init_security hook conventions, i.e. return -EOPNOTSUPP if it is not
> setting an xattr.
> 
> EVM is a bit tricky, because xattrs is both an input and an output. If it
> was just output, EVM should have returned zero if xattrs is NULL. But,
> since xattrs is also input, EVM is unable to do its calculations, so return
> -EOPNOTSUPP and handle this error in security_inode_init_security().
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>

One comment below, otherwise,
Reviewed-by: Mimi  Zohar <zohar@linux.ibm.com>


> ---
>  include/linux/evm.h               | 12 ++++++------
>  security/integrity/evm/evm_main.c | 20 +++++++++++++-------
>  security/security.c               |  5 ++---
>  3 files changed, 21 insertions(+), 16 deletions(-)
> 
> diff --git a/include/linux/evm.h b/include/linux/evm.h
> index aa63e0b3c0a2..3bb2ae9fe098 100644
> --- a/include/linux/evm.h
> +++ b/include/linux/evm.h
> @@ -35,9 +35,9 @@ extern int evm_inode_removexattr(struct user_namespace *mnt_userns,
>  				 struct dentry *dentry, const char *xattr_name);
>  extern void evm_inode_post_removexattr(struct dentry *dentry,
>  				       const char *xattr_name);
> -extern int evm_inode_init_security(struct inode *inode,
> -				   const struct xattr *xattr_array,
> -				   struct xattr *evm);
> +extern int evm_inode_init_security(struct inode *inode, struct inode *dir,
> +				   const struct qstr *qstr,
> +				   struct xattr *xattrs);
>  extern bool evm_revalidate_status(const char *xattr_name);
>  extern int evm_protected_xattr_if_enabled(const char *req_xattr_name);
>  extern int evm_read_protected_xattrs(struct dentry *dentry, u8 *buffer,
> @@ -108,9 +108,9 @@ static inline void evm_inode_post_removexattr(struct dentry *dentry,
>  	return;
>  }
>  
> -static inline int evm_inode_init_security(struct inode *inode,
> -					  const struct xattr *xattr_array,
> -					  struct xattr *evm)
> +static inline int evm_inode_init_security(struct inode *inode, struct inode *dir,
> +					  const struct qstr *qstr,
> +					  struct xattr *xattrs)
>  {
>  	return 0;
>  }
> diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
> index 23d484e05e6f..0a312cafb7de 100644
> --- a/security/integrity/evm/evm_main.c
> +++ b/security/integrity/evm/evm_main.c
> @@ -845,23 +845,29 @@ void evm_inode_post_setattr(struct dentry *dentry, int ia_valid)
>  /*
>   * evm_inode_init_security - initializes security.evm HMAC value
>   */
> -int evm_inode_init_security(struct inode *inode,
> -				 const struct xattr *lsm_xattr,
> -				 struct xattr *evm_xattr)
> +int evm_inode_init_security(struct inode *inode, struct inode *dir,
> +			    const struct qstr *qstr,
> +			    struct xattr *xattrs)
>  {
>  	struct evm_xattr *xattr_data;
> +	struct xattr *xattr, *evm_xattr;
>  	int rc;
>  
> -	if (!(evm_initialized & EVM_INIT_HMAC) ||
> -	    !evm_protected_xattr(lsm_xattr->name))
> -		return 0;
> +	if (!(evm_initialized & EVM_INIT_HMAC) || !xattrs ||
> +	    !evm_protected_xattr(xattrs->name))
> +		return -EOPNOTSUPP;
> +
> +	for (xattr = xattrs; xattr->value != NULL; xattr++)
> +		;

security_inode_init_security() already contains a comment for
allocating +2 extra space.   Adding a similar comment here to explain
why walking the xattrs like this is safe would be nice.

> +
> +	evm_xattr = xattr;
>  
>  	xattr_data = kzalloc(sizeof(*xattr_data), GFP_NOFS);
>  	if (!xattr_data)
>  		return -ENOMEM;
>  
>  	xattr_data->data.type = EVM_XATTR_HMAC;
> -	rc = evm_init_hmac(inode, lsm_xattr, xattr_data->digest);
> +	rc = evm_init_hmac(inode, xattrs, xattr_data->digest);
>  	if (rc < 0)
>  		goto out;
>  
> diff --git a/security/security.c b/security/security.c
> index 36804609caaa..44ce579daec1 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -1190,9 +1190,8 @@ int security_inode_init_security(struct inode *inode, struct inode *dir,
>  	if (!num_filled_xattrs)
>  		goto out;
>  
> -	ret = evm_inode_init_security(inode, new_xattrs,
> -				      new_xattrs + num_filled_xattrs);
> -	if (ret)
> +	ret = evm_inode_init_security(inode, dir, qstr, new_xattrs);
> +	if (ret && ret != -EOPNOTSUPP)
>  		goto out;
>  	ret = initxattrs(inode, new_xattrs, fs_data);
>  out:


