Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 539C83D7F4A
	for <lists+linux-integrity@lfdr.de>; Tue, 27 Jul 2021 22:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbhG0Uct (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 27 Jul 2021 16:32:49 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:11744 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230409AbhG0Ucs (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 27 Jul 2021 16:32:48 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16RKEb5I194607;
        Tue, 27 Jul 2021 16:32:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=nzCAotyL82lcoHt2FnIA/iz5lVb1ff3wV2QbhAo5vYI=;
 b=BnSoGsLoVCKbeBtJT4ndpywIGujbBDBu9+FF+pLwPKP+BbPM2ttmc9ZYtSIIOG8rjE0H
 d2+Rcpxm+53G5Jn+nK6MhT7zJUEIbRRBYTvdUcH0diVGUHUD4N7UAHoeo6g3/Yu4fomZ
 IPJqSDo3+IItEUQNcSlf8zOPabo/kE6Z/e1qdmR1yKYVllz2+4fazgx3f5A6N46pyDm/
 jMfx59EB+tWJW+2McATO32e/uExONilBe5K9UTE5p6bP2HlPYbN7UhMXjApTXrS8gyg/
 RAp0S6+E0ssHMOs9hRz5ivM+RBpUmAWHRcHAHc4iBoHU8YkRdAMD1GHNXTfj0pnfVelp fA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3a2s0mreju-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Jul 2021 16:32:47 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 16RKEwsE195215;
        Tue, 27 Jul 2021 16:32:46 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3a2s0mrej9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Jul 2021 16:32:46 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 16RKG6aD030141;
        Tue, 27 Jul 2021 20:32:44 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03fra.de.ibm.com with ESMTP id 3a235krdyq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Jul 2021 20:32:44 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 16RKWfwE14942696
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Jul 2021 20:32:41 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5B76352057;
        Tue, 27 Jul 2021 20:32:41 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.85.52])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 0C87652065;
        Tue, 27 Jul 2021 20:32:39 +0000 (GMT)
Message-ID: <5a3a35b5f20fb17f7430046b0378e05f1dffa098.camel@linux.ibm.com>
Subject: Re: [PATCH v4 2/5] IMA: block writes of the security.ima xattr with
 unsupported algorithms
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     THOBY Simon <Simon.THOBY@viveris.fr>,
        "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        BARVAUX Didier <Didier.BARVAUX@viveris.fr>
Cc:     Paul Moore <paul@paul-moore.com>
Date:   Tue, 27 Jul 2021 16:32:39 -0400
In-Reply-To: <20210727163330.790010-3-simon.thoby@viveris.fr>
References: <20210727163330.790010-1-simon.thoby@viveris.fr>
         <20210727163330.790010-3-simon.thoby@viveris.fr>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: n5p9tw2VNRHncsndOHvhCtnS_c2Ip4HX
X-Proofpoint-ORIG-GUID: wxZYMZw6c4sLVW9t7gbNy23fFopWpOUn
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-27_13:2021-07-27,2021-07-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 mlxlogscore=999
 priorityscore=1501 bulkscore=0 phishscore=0 spamscore=0 suspectscore=0
 malwarescore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2107270118
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

[Cc'ing Paul Moore]

Hi Simon,

On Tue, 2021-07-27 at 16:33 +0000, THOBY Simon wrote:
> By default, any write to the extended attributes security.ima will be
> accepted, even if the xattr value uses a hash algorithm not compiled in
> the kernel (which doesn't make sense, because the kernel wouldn't be able
> to appraise that file, as it lacks support for validating the hash).
> 
> Prevent such writes: only writes using hash algorithms
> available in the current kernel are now allowed. Any attempt to
> perform these writes will be denied with an audit message.
> 
> Note however that CONFIG_IMA depends on CONFIG_CRYPTO_SHA1, which
> somewhat hampers the security benefits of this measure (but MD4 and
> MD5 can be disabled, which is already a significant improvement).
> 
> Signed-off-by: Simon Thoby <simon.thoby@viveris.fr>
> ---
>  security/integrity/ima/ima_appraise.c | 51 ++++++++++++++++++++++++++-
>  1 file changed, 50 insertions(+), 1 deletion(-)
> 
> diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
> index ef9dcfce45d4..989da2fbf496 100644
> --- a/security/integrity/ima/ima_appraise.c
> +++ b/security/integrity/ima/ima_appraise.c
> @@ -575,12 +575,55 @@ static void ima_reset_appraise_flags(struct inode *inode, int digsig)
>  		clear_bit(IMA_DIGSIG, &iint->atomic_flags);
>  }
>  
> +/**
> + * ima_setxattr_validate_hash_alg() - Block setxattr with invalid digests
> + * @dentry: file being altered

There isn't a one to one mapping betwen dentry and "file".   Perhaps
something like used in  __vfs_setxattr_locked:

*  @dentry: object to perform setxattr on

> + * @xattr_value: value supplied by userland for the xattr
> + * @xattr_value_len: length of xattr_value
> + *
> + * Context: called when the user tries to write the security.ima xattr.
> + * The xattr value is mapped to some hash algorithm, and this algorithm
> + * must be built in the kernel for the setxattr to be allowed.
> + *
> + * Emit an audit message when the algorithm is invalid.
> + *
> + * Return: 0 on success, else an error.
> + */
> +int ima_setxattr_validate_hash_alg(struct dentry *dentry,
> +				   const void *xattr_value,
> +				   size_t xattr_value_len)

Should this be static?  If it is a local function, then it doesn't
really need to be prefixed with "ima_".  It could even be trimmed to
validate_hash_algo().

> +{
> +	int res = -EACCES;

I know there isn't any variable naming consistency.  The original code
used rc.  Subsequently it was replaced with result or ret.  Let's not
introduce yet another variable name here.

> +	char *path = NULL, *pathbuf = NULL;
> +	enum hash_algo dentry_hash;
> +
> +	dentry_hash = ima_get_hash_algo((struct evm_ima_xattr_data *)xattr_value,
> +				     xattr_value_len);

The hash algorithm is extracted from the xattr_value.  Perhaps rename
the variable to xattr_hash, xattr_hash_algo, or simply hash_algo?

> +
> +	if (likely(dentry_hash == ima_hash_algo
> +	    || crypto_has_alg(hash_algo_name[dentry_hash], 0, 0)))
> +		return 0;
> +
> +	pathbuf = kmalloc(PATH_MAX, GFP_KERNEL);
> +	/* no memory available ? no file path for you */

The comment here is unnecessary.  Avoid or limit comments inside a
function.  Refer to the section "8) Commenting" in
Documentation/process/coding-style.rst

> +	if (pathbuf)
> +		path = dentry_path(dentry, pathbuf, PATH_MAX);
> +
> +	/* disallow xattr writes with algorithms not built in the kernel */
> +	integrity_audit_msg(AUDIT_INTEGRITY_DATA, d_inode(dentry),
> +		path, "collect_data", "unavailable-hash-algorithm", res, 0);

This will emit an audit message without the filename when !path.  Is
this what you intended?

Now that this patch set is getting closer, examples of each new type of
audit message needs to be provided to the audit mailing list.  Paul,
any suggestions as to how/when to provide them?

> +
> +	kfree(pathbuf);
> +
> +	return res;
> +}
> +
>  int ima_inode_setxattr(struct dentry *dentry, const char *xattr_name,
>  		       const void *xattr_value, size_t xattr_value_len)
>  {
>  	const struct evm_ima_xattr_data *xvalue = xattr_value;
>  	int digsig = 0;
> -	int result;
> +	int result, rc;
>  
>  	result = ima_protect_xattr(dentry, xattr_name, xattr_value,
>  				   xattr_value_len);
> @@ -592,6 +635,12 @@ int ima_inode_setxattr(struct dentry *dentry, const char *xattr_name,
>  		digsig = (xvalue->type == EVM_XATTR_PORTABLE_DIGSIG);
>  	}
>  	if (result == 1 || evm_revalidate_status(xattr_name)) {
> +		/* the user-supplied xattr must use an allowed hash algo */

With a function name containing "validate_hash_alg", this comment is
unnecessary.

thanks,

Mimi

> +		rc = ima_setxattr_validate_hash_alg(dentry, xattr_value,
> +							xattr_value_len);
> +		if (!rc)
> +			return rc;
> +
>  		ima_reset_appraise_flags(d_backing_inode(dentry), digsig);
>  		if (result == 1)
>  			result = 0;


