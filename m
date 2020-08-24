Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5962E24FD95
	for <lists+linux-integrity@lfdr.de>; Mon, 24 Aug 2020 14:17:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726745AbgHXMRB (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 24 Aug 2020 08:17:01 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38624 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725926AbgHXMRB (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 24 Aug 2020 08:17:01 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07OC2JxU170604;
        Mon, 24 Aug 2020 08:16:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=Bg0WLrlYN9jhyP3hCsaLTQu6WFeJYajorGgTzYt62GY=;
 b=WG16afBiCwBRZmRPDI5UjKhqhcK7buPeUHjKvrV0hbgQWlUvL6bDxSJjZktKFxIhIFdJ
 SIr9JPWKiGGLL4p+M1ndNxAonxSEtBXy6lPVkMCCqFGDD5WjDo9PyTQ9g+D+x7OXqRES
 cP+GW4LuAxxaBEQaO72Rg3L3IRSIqAj7Cf1TG2nrguTX+lohx/vWCDxDIAVeQvN1fZ0D
 cE3t22IyQRxT9E56+q2nXHw/BB1xI1FFyEOc2RdU9tNHi4zE6p+8toGjfg76J+Ax/g1a
 SEUUbxEj9NwSDuKGSeAOYAi5M01wGhyMaJSBwMalUksnDs1pPT6nFtLbUY/FsSH5H4k0 7Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3345epwc70-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Aug 2020 08:16:53 -0400
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 07OC5Jku182787;
        Mon, 24 Aug 2020 08:16:53 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3345epwc5s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Aug 2020 08:16:53 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07OCEpcY004551;
        Mon, 24 Aug 2020 12:16:51 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma02fra.de.ibm.com with ESMTP id 332ujrsdwu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Aug 2020 12:16:51 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07OCFITU59900298
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Aug 2020 12:15:18 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A70B811C052;
        Mon, 24 Aug 2020 12:16:48 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3C5EB11C054;
        Mon, 24 Aug 2020 12:16:47 +0000 (GMT)
Received: from sig-9-65-254-31.ibm.com (unknown [9.65.254.31])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 24 Aug 2020 12:16:47 +0000 (GMT)
Message-ID: <1cf3da122f4bbf9fef9abfb8fa3ce21f23bb47e5.camel@linux.ibm.com>
Subject: Re: [PATCH 05/11] evm: Allow xattr/attr operations for portable
 signatures if check fails
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>, mjg59@google.com
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 24 Aug 2020 08:16:46 -0400
In-Reply-To: <20200618160133.937-5-roberto.sassu@huawei.com>
References: <20200618160133.937-1-roberto.sassu@huawei.com>
         <20200618160133.937-5-roberto.sassu@huawei.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-24_08:2020-08-24,2020-08-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=999 adultscore=0 lowpriorityscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 suspectscore=4 priorityscore=1501 clxscore=1015
 phishscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008240092
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2020-06-18 at 18:01 +0200, Roberto Sassu wrote:
> If files with portable signatures are copied from one location to another
> or are extracted from an archive, verification can temporarily fail until
> all xattrs/attrs are set in the destination. Portable signatures are the
> only ones that can be moved to different files, as they don't depend on
> system-specific information such as the inode generation.

^Only portable signatures may be moved or copied from one file to
another, as they ...  Instead portable signatures must include
"security.ima".

> Unlike other security.evm types, portable signatures

^, EVM portable signatures are also immutable.  They

>  can never be replaced
> even if an xattr/attr operation is granted, as once evm_update_evmxattr()
> detects this type, it returns without updating the HMAC. Thus, it wouldn't
> be a problem to allow those operations so that verification passes on the
> destination after all xattrs/attrs are copied.

This needs to be reworded a bit.
> 
> This patch first introduces a new integrity status called
> INTEGRITY_FAIL_IMMUTABLE, that allows callers of
> evm_verify_current_integrity() to detect that a portable signature didn't
> pass verification and then adds an exception in evm_protect_xattr() and
> evm_inode_setattr() for this status and returns 0 instead of -EPERM.
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>

After this patch, nothing prevents modifying the xattrs after all of
them are in place and the signature verification would be successful. 
(Ok, that is being addressed in subsequent patches.)

> ---
>  include/linux/integrity.h             |  1 +
>  security/integrity/evm/evm_main.c     | 25 ++++++++++++++++++++-----
>  security/integrity/ima/ima_appraise.c |  1 +
>  3 files changed, 22 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/integrity.h b/include/linux/integrity.h
> index 2271939c5c31..2ea0f2f65ab6 100644
> --- a/include/linux/integrity.h
> +++ b/include/linux/integrity.h
> @@ -13,6 +13,7 @@ enum integrity_status {
>  	INTEGRITY_PASS = 0,
>  	INTEGRITY_PASS_IMMUTABLE,
>  	INTEGRITY_FAIL,
> +	INTEGRITY_FAIL_IMMUTABLE,
>  	INTEGRITY_NOLABEL,
>  	INTEGRITY_NOXATTRS,
>  	INTEGRITY_UNKNOWN,
> diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
> index 4e9f5e8b21d5..30072030f05d 100644
> --- a/security/integrity/evm/evm_main.c
> +++ b/security/integrity/evm/evm_main.c
> @@ -27,7 +27,8 @@
>  int evm_initialized;
>  
>  static const char * const integrity_status_msg[] = {
> -	"pass", "pass_immutable", "fail", "no_label", "no_xattrs", "unknown"
> +	"pass", "pass_immutable", "fail", "fail_immutable", "no_label",
> +	"no_xattrs", "unknown"
>  };
>  int evm_hmac_attrs;
>  
> @@ -134,7 +135,7 @@ static enum integrity_status evm_verify_hmac(struct dentry *dentry,
>  	enum integrity_status evm_status = INTEGRITY_PASS;
>  	struct evm_digest digest;
>  	struct inode *inode;
> -	int rc, xattr_len;
> +	int rc, xattr_len, evm_immutable = 0;
>  
>  	if (iint && (iint->evm_status == INTEGRITY_PASS ||
>  		     iint->evm_status == INTEGRITY_PASS_IMMUTABLE))
> @@ -179,8 +180,10 @@ static enum integrity_status evm_verify_hmac(struct dentry *dentry,
>  		if (rc)
>  			rc = -EINVAL;
>  		break;
> -	case EVM_IMA_XATTR_DIGSIG:
>  	case EVM_XATTR_PORTABLE_DIGSIG:
> +		evm_immutable = 1;
> +		fallthrough;
> +	case EVM_IMA_XATTR_DIGSIG:
>  		/* accept xattr with non-empty signature field */
>  		if (xattr_len <= sizeof(struct signature_v2_hdr)) {
>  			evm_status = INTEGRITY_FAIL;
> @@ -219,7 +222,8 @@ static enum integrity_status evm_verify_hmac(struct dentry *dentry,
>  
>  	if (rc)
>  		evm_status = (rc == -ENODATA) ?
> -				INTEGRITY_NOXATTRS : INTEGRITY_FAIL;
> +				INTEGRITY_NOXATTRS : evm_immutable ?
> +				INTEGRITY_FAIL_IMMUTABLE : INTEGRITY_FAIL;

Embedded ternary operator should be replaced with normal C syntax.

>  out:
>  	if (iint)
>  		iint->evm_status = evm_status;
> @@ -351,6 +355,12 @@ static int evm_protect_xattr(struct dentry *dentry, const char *xattr_name,
>  				    -EPERM, 0);
>  	}
>  out:
> +	/* It is safe to allow fail_immutable, portable signatures can never be
> +	 * updated
> +	 */

Replace "It" with "Writing other xattrs".   Writing other xattrs is
safe for portable signatures, as portable signatures are immutable and
...."

> +	if (evm_status == INTEGRITY_FAIL_IMMUTABLE)
> +		return 0;
> +
>  	if (evm_status != INTEGRITY_PASS)
>  		integrity_audit_msg(AUDIT_INTEGRITY_METADATA, d_backing_inode(dentry),
>  				    dentry->d_name.name, "appraise_metadata",
> @@ -488,9 +498,14 @@ int evm_inode_setattr(struct dentry *dentry, struct iattr *attr)
>  	if (!(ia_valid & (ATTR_MODE | ATTR_UID | ATTR_GID)))
>  		return 0;
>  	evm_status = evm_verify_current_integrity(dentry);
> +	/* It is safe to allow fail_immutable, portable signatures can never
> +	 * be updated
> +	 */

Replace "It" with what is safe.

Mimi

>  	if ((evm_status == INTEGRITY_PASS) ||
> -	    (evm_status == INTEGRITY_NOXATTRS))
> +	    (evm_status == INTEGRITY_NOXATTRS) ||
> +	    (evm_status == INTEGRITY_FAIL_IMMUTABLE))
>  		return 0;
> +
>  	integrity_audit_msg(AUDIT_INTEGRITY_METADATA, d_backing_inode(dentry),
>  			    dentry->d_name.name, "appraise_metadata",
>  			    integrity_status_msg[evm_status], -EPERM, 0);
> diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
> index a9649b04b9f1..21bda264fc30 100644
> --- a/security/integrity/ima/ima_appraise.c
> +++ b/security/integrity/ima/ima_appraise.c
> @@ -393,6 +393,7 @@ int ima_appraise_measurement(enum ima_hooks func,
>  	case INTEGRITY_NOLABEL:		/* No security.evm xattr. */
>  		cause = "missing-HMAC";
>  		goto out;
> +	case INTEGRITY_FAIL_IMMUTABLE:
>  	case INTEGRITY_FAIL:		/* Invalid HMAC/signature. */
>  		cause = "invalid-HMAC";
>  		goto out;


