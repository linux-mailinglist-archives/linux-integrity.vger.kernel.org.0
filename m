Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 984153D39BC
	for <lists+linux-integrity@lfdr.de>; Fri, 23 Jul 2021 13:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234390AbhGWLGD (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 23 Jul 2021 07:06:03 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49834 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234218AbhGWLGD (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 23 Jul 2021 07:06:03 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16NBWn8v180072;
        Fri, 23 Jul 2021 07:46:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : date : in-reply-to : references : content-type : mime-version
 : content-transfer-encoding; s=pp1;
 bh=fX/99dwXhHwxIPOtQHrE/kXLYNZC3P0kCVIX6Wps/gg=;
 b=hoI4YDGdi8wLetkBPl1wGxCL6oRJvE12YfZkbdeA+I0IgcQ21a2GPP/gdzYI0PAkdiod
 gKCJ/1JQFR7tQTLOULEcY1+l7wrURQPEkeN82yyYUFZ+tmOPC8BRqn7RcucmuHb04QdF
 XFMzLvqsWpHw2rqteSh6aBp8g8DNEiA0Pm8JzihVTval4AcOyXwCzUNjKvzjAGXFz+vD
 XGSgO5ljMIUzTFhXe2dAlUPJF//mQ7m6lvNadjcRJCfnt7QljNgWILSNAjl2B6HsTaID
 feKe4pGeCcCZ7vuGBrjzFUI+uo7fs1r3hu12afiEVMA8ijrFPYSsCOzgDSMj46DGHVrX Gw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39yv2f9jry-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Jul 2021 07:46:36 -0400
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 16NBX6H7181072;
        Fri, 23 Jul 2021 07:46:36 -0400
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39yv2f9jr0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Jul 2021 07:46:36 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 16NBhgVB025127;
        Fri, 23 Jul 2021 11:46:34 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04fra.de.ibm.com with ESMTP id 39upu89u43-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Jul 2021 11:46:33 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 16NBkVpg13500718
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 23 Jul 2021 11:46:31 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 50CBFA4053;
        Fri, 23 Jul 2021 11:46:31 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1ED81A4040;
        Fri, 23 Jul 2021 11:46:30 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.74.193])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 23 Jul 2021 11:46:29 +0000 (GMT)
Message-ID: <55a840fe14eac12a6e67a183c0a6155cd98beb72.camel@linux.ibm.com>
Subject: Re: [PATCH v2 1/3] IMA: block writes of the security.ima xattr with
 weak hash algorithms
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     THOBY Simon <Simon.THOBY@viveris.fr>,
        "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        BARVAUX Didier <Didier.BARVAUX@viveris.fr>
Date:   Fri, 23 Jul 2021 07:46:29 -0400
In-Reply-To: <20210720092404.120172-2-simon.thoby@viveris.fr>
References: <20210720092404.120172-1-simon.thoby@viveris.fr>
         <20210720092404.120172-2-simon.thoby@viveris.fr>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: KMwvYD1S9RwKEoTkQVmVqcPt7tdl4nl8
X-Proofpoint-ORIG-GUID: Q8A1sPzG9t6cVoivzyORYQxxL2RTdQse
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-23_05:2021-07-23,2021-07-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 clxscore=1015 mlxscore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107230068
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Simon,

On Tue, 2021-07-20 at 09:25 +0000, THOBY Simon wrote:
> By default, writes of the extended attributes security.ima will be
> forbidden if the xattr value uses a hash algorithm not compiled in the
> kernel. Disabling weak hashes when building the kernel will thus prevent
> their use in IMA (these hashes will not only be blocked for setxattr,
> but they won't be allowed for measurement/appraisal either as the kernel
> will obviously not be able to measure files hashed with them). Note
> however that CONFIG_IMA depends on CONFIG_CRYPTO_MD5 and
> CONFIG_CRYPTO_SHA1, so this limits the security benefits of this
> measure.
> To bypass that limitation, if secure boot is enabled on the system,
> the allowed algorithms are further restricted: only writes performed
> with the algorithm specified in the ima_hash parameter (defined at
> build-time with CONFIG_IMA_DEFAULT_HASH or overwritten with a boot
> cmdline option) are allowed.

Although the intention of this patch is to prevent writing file
signatures based on weak hash algorithms, there are two logical
changes.  Each should be a separate patch.  For example, one patch
would only allow writing security.ima signatures based on configured
hash algorithms, while the other patch would limit writing security.ima
signatures based on the IMA default hash algorithm.

Basing the decision on whether to limit the security.ima signature to
the IMA default hash algorithm based on the secure boot flag, seems
rather arbitrary.   Instead perhaps base it on whether the IMA policy
contains any new policy rule "appraise_hash" options.  A policy without
the new "appraise_hash" option would permit both writing and verifying
signatures based on any configured hash algorithm.   A policy
containing "appraise_hash", would both limit the hash algorithms
writing the security.ima signatures and verifying them.

A new builtin policy could be defined based on the new "appraise_hash"
option or simply a flag (e.g. ima_policy=).


> Signed-off-by: Simon Thoby <simon.thoby@viveris.fr>
> ---
>  security/integrity/ima/ima_appraise.c | 54 +++++++++++++++++++++++++++
>  1 file changed, 54 insertions(+)
> 
> diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
> index ef9dcfce45d4..e9a24acf25c6 100644
> --- a/security/integrity/ima/ima_appraise.c
> +++ b/security/integrity/ima/ima_appraise.c
> @@ -575,6 +575,54 @@ static void ima_reset_appraise_flags(struct inode *inode, int digsig)
>  		clear_bit(IMA_DIGSIG, &iint->atomic_flags);
>  }
>  
> +/**
> + * ima_setxattr_validate_hash_alg
> + *
> + * Called when the user tries to write the security.ima xattr.
> + * The xattr value maps to the hash algorithm hash_alg, and this function
> + * returns whether this setxattr should be allowed, emitting an audit
> + * message if necessary.
> + */
> +int ima_setxattr_validate_hash_alg(struct dentry *dentry,
> +				   const void *xattr_value,
> +				   size_t xattr_value_len)
> +{
> +	int res = -EACCES;
> +	char *path = NULL, *pathbuf = NULL;
> +	enum hash_algo hash_alg =
> +		ima_get_hash_algo((struct evm_ima_xattr_data *)xattr_value,
> +				  xattr_value_len);
> +
> +	/**

"/**" is used to indicate the start of kernel-doc comments.  Please use
the normal "/*"
comment here.

> +	 * When secure boot is enabled, only accept the IMA xattr if
> +	 * hashed with the same algorithm as defined in the ima_hash
> +	 * parameter (just like the 'ima_appraise' cmdline parameter
> +	 * is ignored if secure boot is enabled)
> +	 */
> +	if (arch_ima_get_secureboot() && hash_alg != ima_hash_algo)
> +		goto out_warn;
> +
> +	/* disallow xattr writes with algorithms not built in the kernel */
> +	if (hash_alg != ima_hash_algo
> +	    && !crypto_has_alg(hash_algo_name[hash_alg], 0, 0))
> +		goto out_warn;
> +
> +	return 0;
> +
> +out_warn:
> +	pathbuf = kmalloc(PATH_MAX, GFP_KERNEL);
> +	/* no memory available ? no file path for you */
> +	if (pathbuf)
> +		path = dentry_path(dentry, pathbuf, PATH_MAX);
> +
> +	integrity_audit_msg(AUDIT_INTEGRITY_DATA, d_inode(dentry),
> +		path, "collect_data", "forbidden-hash-algorithm", res, 0);

This function is writing security xattrs, not collecting/calculating
the file hash.  Please update the audit message.  Instead of
"forbidden", perhaps use something a little less dramatic, like
"unsupported" or even "denied".

thanks,

Mimi

> +
> +	kfree(pathbuf);
> +
> +	return res;
> +}
> +
>  int ima_inode_setxattr(struct dentry *dentry, const char *xattr_name,
>  		       const void *xattr_value, size_t xattr_value_len)
>  {
> @@ -592,6 +640,12 @@ int ima_inode_setxattr(struct dentry *dentry, const char *xattr_name,
>  		digsig = (xvalue->type == EVM_XATTR_PORTABLE_DIGSIG);
>  	}
>  	if (result == 1 || evm_revalidate_status(xattr_name)) {
> +		/* the user-supplied xattr must use an allowed hash algo */
> +		int rc = ima_setxattr_validate_hash_alg(dentry, xattr_value,
> +							xattr_value_len);
> +		if (rc != 0)
> +			return rc;
> +
>  		ima_reset_appraise_flags(d_backing_inode(dentry), digsig);
>  		if (result == 1)
>  			result = 0;


