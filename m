Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E37E69B34B
	for <lists+linux-integrity@lfdr.de>; Fri, 17 Feb 2023 20:48:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbjBQTsS (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 17 Feb 2023 14:48:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjBQTsR (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 17 Feb 2023 14:48:17 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A20A4AFEA;
        Fri, 17 Feb 2023 11:48:16 -0800 (PST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31HHkoUF031019;
        Fri, 17 Feb 2023 19:47:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=Ovg0+EZ8YSVib5FriRwZoVL/giHj0F5GZrikLe08tak=;
 b=cfo23bYl/GTyrJozFIEWHsUWIyF0xDJ9/LKidbByToRVxAw71iyh5dQku0myFBt14jeJ
 urSYlBY63+u+uOdLKPnzGEr3ulk3DdHP+wcCt78nJuYRoRbEW8l8OuOWGnTlLJNC6wsX
 LxVGjOQ0NHLudVR49Al6pyrydzTOeD/ic+9cB5r55eR14RbDjmKHqUA2ImHXCgCwKyBe
 pbGDD+oxPnUQ3nzVn6WmF6B5JZjOYfZLhcCGvMO9jCr9u2FlPjEfzYNsDqzLDYwlKdMi
 H4zDFnMpGiKSq7udyPXI5S+lxAux5MKU7cpP6JY05OkHYgfV0LNTICDR4Xu8YT3q2PMe lQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3ntd3dmeq9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Feb 2023 19:47:40 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 31HJNeh6003282;
        Fri, 17 Feb 2023 19:47:39 GMT
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3ntd3dmeq1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Feb 2023 19:47:39 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31HJFR4K019914;
        Fri, 17 Feb 2023 19:47:38 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([9.208.129.114])
        by ppma04wdc.us.ibm.com (PPS) with ESMTPS id 3np2n7hfb4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Feb 2023 19:47:38 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
        by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31HJlbLo27198026
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Feb 2023 19:47:37 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5EE2358052;
        Fri, 17 Feb 2023 19:47:37 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D23005805E;
        Fri, 17 Feb 2023 19:47:35 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.25.123])
        by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 17 Feb 2023 19:47:35 +0000 (GMT)
Message-ID: <53d2f07fd19f4ab74c66d4f4f07c62d163708ecd.camel@linux.ibm.com>
Subject: Re: [PATCH v7 1/6] reiserfs: Switch to
 security_inode_init_security()
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
Date:   Fri, 17 Feb 2023 14:47:35 -0500
In-Reply-To: <20221201104125.919483-2-roberto.sassu@huaweicloud.com>
References: <20221201104125.919483-1-roberto.sassu@huaweicloud.com>
         <20221201104125.919483-2-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: sSO0GRNkZtuszZDBY91al3KPux1HTRRp
X-Proofpoint-ORIG-GUID: txMnew365E5IUFHnWfBiCPtN176C9Fkf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-17_14,2023-02-17_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 mlxscore=0 malwarescore=0 phishscore=0
 suspectscore=0 clxscore=1011 adultscore=0 priorityscore=1501
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302170171
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2022-12-01 at 11:41 +0100, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
> 
> In preparation for removing security_old_inode_init_security(), switch to
> security_inode_init_security().
> 
> Define the initxattrs callback reiserfs_initxattrs(), to populate the
> name/value/len triple in the reiserfs_security_handle() with the first
> xattr provided by LSMs. Make a copy of the xattr value, as
> security_inode_init_security() frees it.
> 
> After the call to security_inode_init_security(), remove the check for
> returning -EOPNOTSUPP, as security_inode_init_security() changes it to
> zero.
> 
> Multiple xattrs are currently not supported, as the
> reiserfs_security_handle structure is exported to user space. As a
> consequence, even if EVM is invoked, it will not provide an xattr (if it
> is not the first to set it, its xattr will be discarded; if it is the
> first, it does not have xattrs to calculate the HMAC on).
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>

Now that commit 572302af1258 ("reiserfs: Add missing calls to
reiserfs_security_free()") is upstreamed, please include a dependency
comment.

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

> ---
>  fs/reiserfs/xattr_security.c | 23 ++++++++++++++++++-----
>  1 file changed, 18 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/reiserfs/xattr_security.c b/fs/reiserfs/xattr_security.c
> index 857a65b05726..0ba96757681d 100644
> --- a/fs/reiserfs/xattr_security.c
> +++ b/fs/reiserfs/xattr_security.c
> @@ -39,6 +39,22 @@ static bool security_list(struct dentry *dentry)
>  	return !IS_PRIVATE(d_inode(dentry));
>  }
>  
> +static int
> +reiserfs_initxattrs(struct inode *inode, const struct xattr *xattr_array,
> +		    void *fs_info)
> +{
> +	struct reiserfs_security_handle *sec = fs_info;
> +
> +	sec->value = kmemdup(xattr_array->value, xattr_array->value_len,
> +			     GFP_KERNEL);
> +	if (!sec->value)
> +		return -ENOMEM;
> +
> +	sec->name = xattr_array->name;
> +	sec->length = xattr_array->value_len;
> +	return 0;
> +}
> +
>  /* Initializes the security context for a new inode and returns the number
>   * of blocks needed for the transaction. If successful, reiserfs_security
>   * must be released using reiserfs_security_free when the caller is done. */
> @@ -56,12 +72,9 @@ int reiserfs_security_init(struct inode *dir, struct inode *inode,
>  	if (IS_PRIVATE(dir))
>  		return 0;
>  
> -	error = security_old_inode_init_security(inode, dir, qstr, &sec->name,
> -						 &sec->value, &sec->length);
> +	error = security_inode_init_security(inode, dir, qstr,
> +					     &reiserfs_initxattrs, sec);
>  	if (error) {
> -		if (error == -EOPNOTSUPP)
> -			error = 0;
> -
>  		sec->name = NULL;
>  		sec->value = NULL;
>  		sec->length = 0;


