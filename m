Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92A5824FD9A
	for <lists+linux-integrity@lfdr.de>; Mon, 24 Aug 2020 14:17:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726373AbgHXMRp (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 24 Aug 2020 08:17:45 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41802 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725906AbgHXMRn (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 24 Aug 2020 08:17:43 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07OC7I7q173083;
        Mon, 24 Aug 2020 08:17:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=s9U1KitjlBGv5BjFAx/JLfraDfkNPv5BNJT0fgLG33U=;
 b=OTWuq6CDTTyp9q+2EPxC8S5Gjj5EvSw9xeZTkwpHG6MFl+jG44b4LA2mpm8hEH7XvAQu
 T4wXPv1nftqe+4yrBkQF9X4sg8JEsVpaHCmAw0wXl7xkjLTDeLly4yETSAZRF0glMCZe
 0ENZV9L8s97EaAuw3SW+ukBqWHLp9Aln6ssWUf8Koh1Uqu8GFia/A0Y0N1L0BF61RNwF
 Q0ru5wHexAjLd3IbFQQzbDHDXZtlOaOplQ33DO9fAkDSaqjC9drLo9vWVuRLgyS37Tqw
 x6nO7/WESmAJK6CcWdUcDWbA7XFswOKBx8qnGHJaz5P1zXbMIXF8V08Hr4Tep8z+yeLY 3Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3349wsntys-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Aug 2020 08:17:35 -0400
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 07OC7aDK173611;
        Mon, 24 Aug 2020 08:17:35 -0400
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3349wsntxs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Aug 2020 08:17:34 -0400
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07OCEvTl007450;
        Mon, 24 Aug 2020 12:17:32 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma06fra.de.ibm.com with ESMTP id 332uwesdp9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Aug 2020 12:17:32 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07OCG0q713238768
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Aug 2020 12:16:00 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F13F4A406A;
        Mon, 24 Aug 2020 12:17:29 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 651AFA405F;
        Mon, 24 Aug 2020 12:17:28 +0000 (GMT)
Received: from sig-9-65-254-31.ibm.com (unknown [9.65.254.31])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 24 Aug 2020 12:17:28 +0000 (GMT)
Message-ID: <802588e6892951076babbc48aa0320032e4b1926.camel@linux.ibm.com>
Subject: Re: [PATCH 06/11] evm: Allow setxattr() and setattr() if metadata
 digest won't change
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>, mjg59@google.com
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, silviu.vlasceanu@huawei.com
Date:   Mon, 24 Aug 2020 08:17:27 -0400
In-Reply-To: <20200618160458.1579-6-roberto.sassu@huawei.com>
References: <20200618160329.1263-2-roberto.sassu@huawei.com>
         <20200618160458.1579-6-roberto.sassu@huawei.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-24_08:2020-08-24,2020-08-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 clxscore=1015 spamscore=0 lowpriorityscore=0 suspectscore=4 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008240092
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2020-06-18 at 18:04 +0200, Roberto Sassu wrote:
> If metadata are immutable, they cannot be changed. If metadata are already
> set to the final value before cp and tar restore the value from the source,
> those applications display an error even if the operation is legitimate
> (they don't change the value).

"metadata" is singular.   The first sentence would be clearer by using
the specific metadata.  What problem are you trying to solve?  It
doesn't look like you're trying to solve the problem of writing the EVM
portable signatures without an exiting HMAC.  

> 
> This patch determines whether setxattr()/setattr() change metadata and, if
> not, allows the operations even if metadata are immutable.

Doesn't setxattr/setattr always change file metadata?  Please describe
the real problem.

> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>  security/integrity/evm/evm_main.c | 72 +++++++++++++++++++++++++++++++
>  1 file changed, 72 insertions(+)
> 
> diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
> index 30072030f05d..41cc6a4aaaab 100644
> --- a/security/integrity/evm/evm_main.c
> +++ b/security/integrity/evm/evm_main.c
> @@ -18,6 +18,7 @@
>  #include <linux/integrity.h>
>  #include <linux/evm.h>
>  #include <linux/magic.h>
> +#include <linux/posix_acl_xattr.h>
>  
>  #include <crypto/hash.h>
>  #include <crypto/hash_info.h>
> @@ -305,6 +306,56 @@ static enum integrity_status evm_verify_current_integrity(struct dentry *dentry)
>  	return evm_verify_hmac(dentry, NULL, NULL, 0, NULL);
>  }
>  
> +static int evm_xattr_acl_change(struct dentry *dentry, const char *xattr_name,
> +				const void *xattr_value, size_t xattr_value_len)
> +{
> +	umode_t mode;
> +	struct posix_acl *acl = NULL, *acl_res;
> +	struct inode *inode = d_backing_inode(dentry);
> +	int rc;
> +
> +	/* UID/GID in ACL have been already converted from user to init ns */
> +	acl = posix_acl_from_xattr(&init_user_ns, xattr_value, xattr_value_len);
> +	if (!acl)
> +		return 1;
> +
> +	acl_res = acl;
> +	rc = posix_acl_update_mode(inode, &mode, &acl_res);
> +
> +	posix_acl_release(acl);
> +
> +	if (rc)
> +		return 1;
> +
> +	if (acl_res && inode->i_mode != mode)
> +		return 1;
> +
> +	return 0;
> +}
> +
> +static int evm_xattr_change(struct dentry *dentry, const char *xattr_name,
> +			    const void *xattr_value, size_t xattr_value_len)
> +{
> +	char *xattr_data = NULL;
> +	int rc = 0;
> +
> +	if (posix_xattr_acl(xattr_name))
> +		return evm_xattr_acl_change(dentry, xattr_name, xattr_value,
> +					    xattr_value_len);
> +
> +	rc = vfs_getxattr_alloc(dentry, xattr_name, &xattr_data, 0, GFP_NOFS);
> +	if (rc < 0)
> +		return 1;
> +
> +	if (rc == xattr_value_len)
> +		rc = memcmp(xattr_value, xattr_data, rc);
> +	else
> +		rc = 1;
> +
> +	kfree(xattr_data);
> +	return rc;
> +}
> +
>  /*
>   * evm_protect_xattr - protect the EVM extended attribute
>   *
> @@ -361,6 +412,10 @@ static int evm_protect_xattr(struct dentry *dentry, const char *xattr_name,
>  	if (evm_status == INTEGRITY_FAIL_IMMUTABLE)
>  		return 0;
>  
> +	if (evm_status == INTEGRITY_PASS_IMMUTABLE &&
> +	    !evm_xattr_change(dentry, xattr_name, xattr_value, xattr_value_len))
> +		return 0;
> +
>  	if (evm_status != INTEGRITY_PASS)
>  		integrity_audit_msg(AUDIT_INTEGRITY_METADATA, d_backing_inode(dentry),
>  				    dentry->d_name.name, "appraise_metadata",
> @@ -477,6 +532,19 @@ void evm_inode_post_removexattr(struct dentry *dentry, const char *xattr_name)
>  	evm_update_evmxattr(dentry, xattr_name, NULL, 0);
>  }
> 
> +static int evm_attr_change(struct dentry *dentry, struct iattr *attr)

static functions don't normally require a function comment, but in this
case it wouldn't hurt to clarify why the uid, gid, mode bits are set,
but aren't being modified.
Similarly a function comment would help with the readability of
evm_xattr_acl_change().

Mimi

> +{
> +	struct inode *inode = d_backing_inode(dentry);
> +	unsigned int ia_valid = attr->ia_valid;
> +
> +	if ((!(ia_valid & ATTR_UID) || uid_eq(attr->ia_uid, inode->i_uid)) &&
> +	    (!(ia_valid & ATTR_GID) || gid_eq(attr->ia_gid, inode->i_gid)) &&
> +	    (!(ia_valid & ATTR_MODE) || attr->ia_mode == inode->i_mode))
> +		return 0;
> +
> +	return 1;
> +}
> +
>  /**
>   * evm_inode_setattr - prevent updating an invalid EVM extended attribute
>   * @dentry: pointer to the affected dentry
> @@ -506,6 +574,10 @@ int evm_inode_setattr(struct dentry *dentry, struct iattr *attr)
>  	    (evm_status == INTEGRITY_FAIL_IMMUTABLE))
>  		return 0;
>  
> +	if (evm_status == INTEGRITY_PASS_IMMUTABLE &&
> +	    !evm_attr_change(dentry, attr))
> +		return 0;
> +
>  	integrity_audit_msg(AUDIT_INTEGRITY_METADATA, d_backing_inode(dentry),
>  			    dentry->d_name.name, "appraise_metadata",
>  			    integrity_status_msg[evm_status], -EPERM, 0);


