Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (unknown [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8F7D3E46B2
	for <lists+linux-integrity@lfdr.de>; Mon,  9 Aug 2021 15:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232658AbhHINcs (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 9 Aug 2021 09:32:48 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:16930 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233117AbhHINcp (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 9 Aug 2021 09:32:45 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 179DGRYV146282;
        Mon, 9 Aug 2021 09:32:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : date : in-reply-to : references : content-type : mime-version
 : content-transfer-encoding; s=pp1;
 bh=JSll5j++tkOXW0hOklELWEuekNtHWso2hYhu83dQkl4=;
 b=Hu0aE6gz18qBoYokUDpfOFRzNh/FNcAbvT0OakbHM/ykA5vJSb151eShbh5eQOJpXkH0
 867aNiIsk0lAyjofy9khpzQcGhSsUQR5KNiQXVk7r05IJIMogx1quHQBFP5DyBJHNkC+
 hPRJHWDdNEktGVw4xf99k5J0yoy0sb4yiH3dYYdiFk5TWwturNFCV6J4MwJSCTZrRaXc
 ME0ov/Q4wR6BSh+xbD3Au0dKwtpzxQjCF5FqAf7dCDbJXq8hkAhLobUPWkNQWpEX04PC
 8h4rljRm/zH5K+QfgECevFuY6U4EY0dobQSKtFd5BeVM1XBxhebGdiK5WBiNFH76iJZD qA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ab1j86p0m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 Aug 2021 09:32:25 -0400
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 179DGrDu152396;
        Mon, 9 Aug 2021 09:32:24 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ab1j86nym-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 Aug 2021 09:32:24 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 179CwZCe025553;
        Mon, 9 Aug 2021 13:32:22 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma04ams.nl.ibm.com with ESMTP id 3a9ht8v1ae-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 Aug 2021 13:32:22 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 179DWKL541943412
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 9 Aug 2021 13:32:20 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DEFA04205E;
        Mon,  9 Aug 2021 13:32:19 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 13C0B42049;
        Mon,  9 Aug 2021 13:32:19 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.60.170])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  9 Aug 2021 13:32:18 +0000 (GMT)
Message-ID: <db487c583531be1b929d5233c3934b2b4e9f1395.camel@linux.ibm.com>
Subject: Re: [PATCH v6 2/5] IMA: block writes of the security.ima xattr with
 unsupported algorithms
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     THOBY Simon <Simon.THOBY@viveris.fr>,
        "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        BARVAUX Didier <Didier.BARVAUX@viveris.fr>
Date:   Mon, 09 Aug 2021 09:32:18 -0400
In-Reply-To: <20210804092010.350372-3-simon.thoby@viveris.fr>
References: <20210804092010.350372-1-simon.thoby@viveris.fr>
         <20210804092010.350372-3-simon.thoby@viveris.fr>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: r2HGZPZ9yrN_SFf4okNuZhJI6Ac_L7B5
X-Proofpoint-ORIG-GUID: LG3wROC7IHkLNYurtjEEFzvwbQXR6Utv
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-09_04:2021-08-06,2021-08-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1015 impostorscore=0 suspectscore=0 mlxlogscore=999
 lowpriorityscore=0 malwarescore=0 adultscore=0 phishscore=0 mlxscore=0
 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108090099
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2021-08-04 at 09:20 +0000, THOBY Simon wrote:
> By default, writes to the extended attributes security.ima will be
> allowed even if the hash algorithm used for the xattr is not compiled
> in the kernel (which does not make sense because the kernel would not
> be able to appraise that file as it lacks support for validating the
> hash).
> 
> Prevent writes to the security.ima xattr if the hash algorithm used is
> not available in the current kernel. Lo an audit message if such an
> operation is attempted.

Both "log" and "audit" can be used as verbs.   Perhaps update the first
line to be "Prevent and audit writes...", making the last line
unnecessary.

> 
> Signed-off-by: Simon Thoby <simon.thoby@viveris.fr>
> ---
>  security/integrity/ima/ima.h          |  2 +-
>  security/integrity/ima/ima_appraise.c | 49 ++++++++++++++++++++++++++-
>  2 files changed, 49 insertions(+), 2 deletions(-)
> 
> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> index 2f4c20b16ad7..829478dabeeb 100644
> --- a/security/integrity/ima/ima.h
> +++ b/security/integrity/ima/ima.h
> @@ -319,7 +319,7 @@ int ima_must_appraise(struct user_namespace *mnt_userns, struct inode *inode,
>  void ima_update_xattr(struct integrity_iint_cache *iint, struct file *file);
>  enum integrity_status ima_get_cache_status(struct integrity_iint_cache *iint,
>  					   enum ima_hooks func);
> -enum hash_algo ima_get_hash_algo(struct evm_ima_xattr_data *xattr_value,
> +enum hash_algo ima_get_hash_algo(const struct evm_ima_xattr_data *xattr_value,
>  				 int xattr_len);
>  int ima_read_xattr(struct dentry *dentry,
>  		   struct evm_ima_xattr_data **xattr_value);
> diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
> index 63bec42c353f..ed1a98f6ee19 100644
> --- a/security/integrity/ima/ima_appraise.c
> +++ b/security/integrity/ima/ima_appraise.c
> @@ -171,7 +171,7 @@ static void ima_cache_flags(struct integrity_iint_cache *iint,
>  	}
>  }
>  
> -enum hash_algo ima_get_hash_algo(struct evm_ima_xattr_data *xattr_value,
> +enum hash_algo ima_get_hash_algo(const struct evm_ima_xattr_data *xattr_value,
>  				 int xattr_len)
>  {
>  	struct signature_v2_hdr *sig;
> @@ -575,6 +575,51 @@ static void ima_reset_appraise_flags(struct inode *inode, int digsig)
>  		clear_bit(IMA_DIGSIG, &iint->atomic_flags);
>  }
>  
> +/**

Just a reminder, static functions don't require kernel-doc.

> + * validate_hash_algo() - Block setxattr with invalid digests

The digest might be valid, but the algorithm is unsupported.  Perhaps
"Block setxattr with unsupported hash algorithms" would be more
accurate.

> + * @dentry: object being setxattr()'ed

^object of the setxattr()

> + * @xattr_value: value supplied by userland for the xattr

userland supplied xattr value

> + * @xattr_value_len: length of xattr_value
> + *
> + * Context: called when the user tries to write the security.ima xattr.

Hm, "context" is probably unnecessary.

From here:
> + * The xattr value is mapped to some hash algorithm, and this algorithm
> + * must be built in the kernel for the setxattr to be allowed.
> + *
> + * Emit an audit message when the algorithm is invalid.
> + *

to here: is the longer summary, which would be before the "Context:" if
it is defined.

> + * Return: 0 on success, else an error.
> + */
> +static int validate_hash_algo(struct dentry *dentry,
> +				   const struct evm_ima_xattr_data *xattr_value,
> +				   size_t xattr_value_len)
> +{
> +	int result = 0;
> +	char *path = NULL, *pathbuf = NULL;
> +	enum hash_algo xattr_hash_algo;
> +
> +	xattr_hash_algo = ima_get_hash_algo(xattr_value, xattr_value_len);
> +
> +	if (likely(xattr_hash_algo == ima_hash_algo ||
> +		   crypto_has_alg(hash_algo_name[xattr_hash_algo], 0, 0)))
> +		return result;
> +
> +	result = -EACCES;

Unless there is a common function exit, I would just hard code the
return value.
> +
> +	pathbuf = kmalloc(PATH_MAX, GFP_KERNEL);
> +	if (!pathbuf)
> +		return result;
> +
> +	path = dentry_path(dentry, pathbuf, PATH_MAX);
> +
> +	integrity_audit_msg(AUDIT_INTEGRITY_DATA, d_inode(dentry), path,
> +			    "collect_data", "unavailable-hash-algorithm",
> +			    result, 0);
> +
> +	kfree(pathbuf);
> +
> +	return result;
> +}
> +
>  int ima_inode_setxattr(struct dentry *dentry, const char *xattr_name,
>  		       const void *xattr_value, size_t xattr_value_len)
>  {
> @@ -595,6 +640,8 @@ int ima_inode_setxattr(struct dentry *dentry, const char *xattr_name,
>  		ima_reset_appraise_flags(d_backing_inode(dentry), digsig);
>  		if (result == 1)
>  			result = 0;
> +
> +		result = validate_hash_algo(dentry, xvalue, xattr_value_len);

On failure to validate the hash algorithm, the file will unnecessarily
be re-verified.  Only on success the appraise flags should be reset.

thanks,

Mimi

>  	}
>  	return result;
>  }


