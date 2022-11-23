Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 871B9635FE9
	for <lists+linux-integrity@lfdr.de>; Wed, 23 Nov 2022 14:33:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238737AbiKWNbn (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 23 Nov 2022 08:31:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238210AbiKWNbO (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 23 Nov 2022 08:31:14 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D8F156D7D;
        Wed, 23 Nov 2022 05:13:04 -0800 (PST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ANAe6IK026900;
        Wed, 23 Nov 2022 13:12:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=9PXQukpxuogl+8l31b8WwhvCbvp+U7J+XqCX2qkFTGE=;
 b=ieoJPpTfsIcCtPXvKSpUqs6UfKHqFjLGBdXPXTWDX9kLITBSJQkI4eRL/YTgUx19nMG0
 7IYmKhlPfE4sk2o655ekHeTIY2y+rO2ctE5x6TTSJwzN2cOjMzhD+w17h7wZvS+naXgu
 /i+CRkTTazmTk+kVp4j3A8srGQsMSirQVZ3JWj14Zouvh67riSn+ZBFCgNW5510Wzt09
 a1HuV8vZlRlg2fyXyq2EI8RgJ0V/p37IKFRUL3xmAUxOdDkG7APYRuD+dq2TzV2Mhl1l
 x6ZB8GXBgIWfrB9hQQRG/KfqEj0P+1Un1P1nJQRZGzw6QlXcLGtioBIccPxENfZIgxDR yw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3m10bmdkks-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Nov 2022 13:12:34 +0000
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2ANCfQfW022844;
        Wed, 23 Nov 2022 13:12:33 GMT
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3m10bmdkjt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Nov 2022 13:12:33 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2AND5alC023180;
        Wed, 23 Nov 2022 13:12:32 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com [9.57.198.23])
        by ppma03dal.us.ibm.com with ESMTP id 3kxpsahg5y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Nov 2022 13:12:32 +0000
Received: from smtpav06.wdc07v.mail.ibm.com ([9.208.128.115])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2ANDCUm0590518
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Nov 2022 13:12:31 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A7C8458054;
        Wed, 23 Nov 2022 13:12:30 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1EF205804E;
        Wed, 23 Nov 2022 13:12:28 +0000 (GMT)
Received: from sig-9-77-136-225.ibm.com (unknown [9.77.136.225])
        by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 23 Nov 2022 13:12:28 +0000 (GMT)
Message-ID: <c5cea3cad1eaf79c29e91e9ecf8e8b7dcee2ce2c.camel@linux.ibm.com>
Subject: Re: [PATCH v5 1/6] reiserfs: Switch to
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
Date:   Wed, 23 Nov 2022 08:12:27 -0500
In-Reply-To: <20221123095202.599252-2-roberto.sassu@huaweicloud.com>
References: <20221123095202.599252-1-roberto.sassu@huaweicloud.com>
         <20221123095202.599252-2-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: HWsORPoDyF1vNBqDC9P4hNJ3cn8uMOKU
X-Proofpoint-GUID: YBNNnLZ7uTDIZ5ugeSf2R6ADJAMFSScw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-23_07,2022-11-23_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 phishscore=0 spamscore=0 mlxscore=0
 adultscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2210170000 definitions=main-2211230097
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
> Define the initxattrs callback reiserfs_initxattrs(), to populate the
> name/value/len triple in the reiserfs_security_handle() with the first
> xattr provided by LSMs. Multiple xattrs are currently not supported, as the
> reiserfs_security_handle structure is exported to user space.

The security_old_inode_init_security() hook doesn't support EVM. 
Missing from this patch description is whether the move to the
security_inode_init_security() hook changes security.evm.  FYI, I'm not
suggesting it should.  Please update the patch description accordingly.

Mimi

> 
> In reiserfs_initxattrs(), make a copy of the first xattr value, as
> security_inode_init_security() frees it.
> 
> After the call to security_inode_init_security(), remove the check for
> returning -EOPNOTSUPP, as security_inode_init_security() changes it to
> zero.
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
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


