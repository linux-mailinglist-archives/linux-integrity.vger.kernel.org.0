Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52A3D3D7840
	for <lists+linux-integrity@lfdr.de>; Tue, 27 Jul 2021 16:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236885AbhG0ONC (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 27 Jul 2021 10:13:02 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:10316 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236934AbhG0OM7 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 27 Jul 2021 10:12:59 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16RE9lv5189867;
        Tue, 27 Jul 2021 10:12:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : date : in-reply-to : references : content-type : mime-version
 : content-transfer-encoding; s=pp1;
 bh=AxD7hRmpELRl++pxjxbd+btEMrmVkdoOaCfnv9/DpXs=;
 b=a4ENCZkBMim89ih9MCGVcv9SYsGVJ9E2wS3k3K0WfwhVAKdTpok0XKcS9v8JpBLMUk4X
 cpUar7ndjE2LZM8bZi3932BPd/Mp9AwdafGoHzCyzwybC5rH4IjouJHDLELleg0d+3c/
 9hXKtbMQ6sF+rARji7tW88Tfgs1xQeyFrannBa/fwerm62b8Eck7uVZ9pQX491qSRRIv
 8LmP6j5ZsbE41nqIpagnu7Vt+7sX82WEbq8hnmGecDFGZYVE8AaMjzBp8y999Go5Gola
 4lz7benhdrbsc5E5yoG9ImWCuKjqQfXsnFkUSZRFtzS0hmW5VVzgllSgStcqcRrh+jJv 7w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3a2k4vh7x8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Jul 2021 10:12:57 -0400
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 16RE9wPA191410;
        Tue, 27 Jul 2021 10:09:58 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3a2k4vh6qe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Jul 2021 10:09:58 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 16RE4a1H016479;
        Tue, 27 Jul 2021 14:04:36 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma02fra.de.ibm.com with ESMTP id 3a235xra14-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Jul 2021 14:04:36 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 16RE4YKJ9044270
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Jul 2021 14:04:34 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0DF7FA4053;
        Tue, 27 Jul 2021 14:04:34 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E1FB8A4059;
        Tue, 27 Jul 2021 14:04:32 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.85.52])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 27 Jul 2021 14:04:32 +0000 (GMT)
Message-ID: <c0e28c5c757907847d9cddc126784afe07dccf0f.camel@linux.ibm.com>
Subject: Re: [PATCH v3 1/4] IMA: block writes of the security.ima xattr with
 unsupported algorithms
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     THOBY Simon <Simon.THOBY@viveris.fr>,
        "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        BARVAUX Didier <Didier.BARVAUX@viveris.fr>
Date:   Tue, 27 Jul 2021 10:04:31 -0400
In-Reply-To: <20210727102307.552052-2-simon.thoby@viveris.fr>
References: <20210727102307.552052-1-simon.thoby@viveris.fr>
         <20210727102307.552052-2-simon.thoby@viveris.fr>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: bewE3LZGqHy8UhRE5R6t9SQFajJj06d-
X-Proofpoint-ORIG-GUID: s_mRXrGbbwxwnQLFEdCSfeCpwYYK8FPV
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-27_10:2021-07-27,2021-07-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 phishscore=0
 adultscore=0 mlxlogscore=999 impostorscore=0 spamscore=0 clxscore=1015
 mlxscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2107270084
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Simon,

On Tue, 2021-07-27 at 10:23 +0000, THOBY Simon wrote:
> By default, any write to the extended attributes security.ima will be
> accepted, even if the xattr value uses a hash algorithm not compiled in
> the kernel (which doesn't make sense, because the kernel wouldn't be able
> to appraise that file, as it lacks support for validating the hash).
> 
> This patch prevents such writes: only writes using hash algorithms
> available in the current kernel are now allowed. Any attempt to
> perform these writes will be denied with an audit message.
> 

Instead of "This patch", start with "Prevent".

From Documentation/process/submitting-patches.rst:
   Describe your changes in imperative mood, e.g. "make xyzzy do frotz"
   instead of "[This patch] makes xyzzy do frotz" or "[I] changed xyzzy
   to do frotz", as if you are giving orders to the codebase to change
   its behaviour.

> The idea behind this patch is that a user can disable weak hashes
> when building the kernel, and thereby prevent their use in IMA
> (these hash algorithms will not only be blocked for setxattr per
> this patch, but they also won't be allowed for measurement/appraisal
> either as the kernel isn't able to measure files hashed with them).

The motivation for this patch set is described in the cover letter,
which may be included as the merge message.  The above paragraph isn't
needed here in this particular patch description.

> Note however that CONFIG_IMA depends on CONFIG_CRYPTO_MD5 and
> CONFIG_CRYPTO_SHA1, which hampers the security benefits of this
> measure.

Unlike SHA1, which is still being used in the IMA measurement list,
there is no reason to automatically select MD5 in the Kconfig.  As a
separate patch, probably the first in this series so that it could be
backported, please remove the CRYPTO_MD5 select.  

> 
> Signed-off-by: Simon Thoby <simon.thoby@viveris.fr>
> ---
>  security/integrity/ima/ima_appraise.c | 42 +++++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
> 
> diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
> index ef9dcfce45d4..b5b11f5ec90a 100644
> --- a/security/integrity/ima/ima_appraise.c
> +++ b/security/integrity/ima/ima_appraise.c
> @@ -575,6 +575,42 @@ static void ima_reset_appraise_flags(struct inode *inode, int digsig)
>  		clear_bit(IMA_DIGSIG, &iint->atomic_flags);
>  }
>  
> +/**
> + * ima_setxattr_validate_hash_alg
> + *

"kernel-doc" has a specific format.   Please refer to the section
"Function documentation" in Documentation/doc-guide/kernel-doc.rst.

> + * Called when the user tries to write the security.ima xattr.
> + * The xattr value maps to the hash algorithm hash_alg, and this function
> + * returns whether this setxattr should be allowed, emitting an audit
> + * message if necessary.
> + */

This is called by an LSM/IMA hook.  On success return 0.  On failure,
return errno.

> +int ima_setxattr_validate_hash_alg(struct dentry *dentry,
> +				   const void *xattr_value,
> +				   size_t xattr_value_len)
> +{
> +	int res = -EACCES;
> +	char *path = NULL, *pathbuf = NULL;
> +	enum hash_algo hash_alg =
> +		ima_get_hash_algo((struct evm_ima_xattr_data *)xattr_value,
> +				  xattr_value_len);

Programmatically it is the same to define a variable and assign it on
the same line, but in this case, it might be cleaner to split it up.

> +
> +	/* disallow xattr writes with algorithms not built in the kernel */
> +	if (likely(hash_alg == ima_hash_algo
> +	    || crypto_has_alg(hash_algo_name[hash_alg], 0, 0)))
> +		return 0;
> +
> +	pathbuf = kmalloc(PATH_MAX, GFP_KERNEL);
> +	/* no memory available ? no file path for you */
> +	if (pathbuf)
> +		path = dentry_path(dentry, pathbuf, PATH_MAX);
> +
> +	integrity_audit_msg(AUDIT_INTEGRITY_DATA, d_inode(dentry),
> +		path, "collect_data", "unavailable-hash-algorithm", res, 0);
> +

The comment is applicable to integrity_audit_msg().  Why not move it
prior to integrity_audit_msg().

> +	kfree(pathbuf);
> +
> +	return res;
> +}
> +
>  int ima_inode_setxattr(struct dentry *dentry, const char *xattr_name,
>  		       const void *xattr_value, size_t xattr_value_len)
>  {
> @@ -592,6 +628,12 @@ int ima_inode_setxattr(struct dentry *dentry, const char *xattr_name,
>  		digsig = (xvalue->type == EVM_XATTR_PORTABLE_DIGSIG);
>  	}
>  	if (result == 1 || evm_revalidate_status(xattr_name)) {
> +		/* the user-supplied xattr must use an allowed hash algo */
> +		int rc = ima_setxattr_validate_hash_alg(dentry, xattr_value,
> +							xattr_value_len);

Variables should be defined at the beginning of the function.

> +		if (rc != 0)
> +			return rc;
> +

"rc" should be 0 or < 1.

thanks,

Mimi

>  		ima_reset_appraise_flags(d_backing_inode(dentry), digsig);
>  		if (result == 1)
>  			result = 0;


