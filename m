Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2F7224FE7D
	for <lists+linux-integrity@lfdr.de>; Mon, 24 Aug 2020 15:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726218AbgHXNDe (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 24 Aug 2020 09:03:34 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:18870 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726820AbgHXND3 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 24 Aug 2020 09:03:29 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07OD2Xeb094901;
        Mon, 24 Aug 2020 09:03:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=/Berv+RXYni/EpfBinvlSS7q5Og6GZMPUA3Mdr4e7C8=;
 b=HfpJdQn6BQdd8P8bPquOAqj2zw2uWBs+uEUVJrdxZzTnp4Q1ZR4ws0gUQV8I/oNuAMof
 Sd31HJe/+T0yKdU/Xbdv5kzm+oKTLrufjxuWoJQoO8XFCsaaYFz7pokhP3czRRD2/IbU
 QyokIhC7ZLEsVLcZmhyJGxVLUwjjNI3yvClnsxPPn2sDpeXet/0uk1rOICS7Jx40I0TB
 ZKtsZM8+o39LDP25SmZctx7CvPicpoNB6jne/9xxOqbDBX0owwYRt+ThsVvhCHHJHpFe
 9tPNviMNToxF1ik6o5jIMpKcEazJ4ExIp3Bbldtxt2ZItVlV82VxdXktpNd4lyBXi6R3 lg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 334b5c5nc1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Aug 2020 09:03:02 -0400
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 07OD2tAH096823;
        Mon, 24 Aug 2020 09:02:55 -0400
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 334b5c5msx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Aug 2020 09:02:54 -0400
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07OCwQTa009904;
        Mon, 24 Aug 2020 13:02:13 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma06fra.de.ibm.com with ESMTP id 332uweseew-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Aug 2020 13:02:13 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07OD0ebv33817084
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Aug 2020 13:00:40 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D1B5CAE056;
        Mon, 24 Aug 2020 13:02:10 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 582E4AE05D;
        Mon, 24 Aug 2020 13:02:09 +0000 (GMT)
Received: from sig-9-65-254-31.ibm.com (unknown [9.65.254.31])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 24 Aug 2020 13:02:09 +0000 (GMT)
Message-ID: <32ef47317871a27f24287e48a2f6ac5a7e552943.camel@linux.ibm.com>
Subject: Re: [PATCH 08/11] ima: Allow imasig requirement to be satisfied by
 EVM portable signatures
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>, mjg59@google.com
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, silviu.vlasceanu@huawei.com
Date:   Mon, 24 Aug 2020 09:02:08 -0400
In-Reply-To: <20200618160458.1579-8-roberto.sassu@huawei.com>
References: <20200618160329.1263-2-roberto.sassu@huawei.com>
         <20200618160458.1579-8-roberto.sassu@huawei.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-24_11:2020-08-24,2020-08-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 adultscore=0 spamscore=0 impostorscore=0 suspectscore=3 clxscore=1015
 phishscore=0 malwarescore=0 lowpriorityscore=0 mlxlogscore=999
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008240099
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2020-06-18 at 18:04 +0200, Roberto Sassu wrote:
> System administrators can require that all accessed files have a signature
> by specifying appraise_type=imasig in a policy rule.
> 
> Currently, only IMA signatures satisfy this requirement.

Appended signatures may also satisfy this requirement, but are not
applicable as ...

> IMA signatures
> ensure data source authentication for file content and prevent any change.
> EVM signatures instead ensure data source authentication for file metadata.
> Given that the digest or signature of the file content must be included in
> the metadata, EVM signatures provide at least the same guarantees of IMA
> signatures.

^provide the same file data guarantees of IMA signatures, as well as
providing file metadata guarantees.

> 
> This patch lets systems protected with EVM signatures pass appraisal
> verification if the appraise_type=imasig requirement is specified in the
> policy. This facilitates deployment in the scenarios where only EVM
> signatures are available.
> 
> The patch makes the following changes:
> 
> file xattr types:
> security.ima: IMA_XATTR_DIGEST/IMA_XATTR_DIGEST_NG
> security.evm: EVM_XATTR_PORTABLE_DIGSIG
> 
> execve(), mmap(), open() behavior (with appraise_type=imasig):
> before: denied (file without IMA signature, imasig requirement not met)
> after: allowed (file with EVM portable signature, imasig requirement met)
> 
> open(O_WRONLY) behavior (without appraise_type=imasig):
> before: allowed (file without IMA signature, not immutable)
> after: denied (file with EVM portable signature, immutable)
> 
> In addition, similarly to IMA signatures, this patch temporarily allows
> new files without or with incomplete metadata to be opened so that content
> can be written.
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>

After addressing the comments above and below,

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

> ---
>  security/integrity/ima/ima_appraise.c | 20 +++++++++++++-------
>  1 file changed, 13 insertions(+), 7 deletions(-)
> 
> diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
> index 21bda264fc30..9505bb390d90 100644
> --- a/security/integrity/ima/ima_appraise.c
> +++ b/security/integrity/ima/ima_appraise.c
> @@ -219,12 +219,16 @@ static int xattr_verify(enum ima_hooks func, struct integrity_iint_cache *iint,
>  		hash_start = 1;
>  		/* fall through */
>  	case IMA_XATTR_DIGEST:
> -		if (iint->flags & IMA_DIGSIG_REQUIRED) {
> -			*cause = "IMA-signature-required";
> -			*status = INTEGRITY_FAIL;
> -			break;
> +		if (*status != INTEGRITY_PASS_IMMUTABLE) {
> +			if (iint->flags & IMA_DIGSIG_REQUIRED) {
> +				*cause = "IMA-signature-required";
> +				*status = INTEGRITY_FAIL;
> +				break;
> +			}
> +			clear_bit(IMA_DIGSIG, &iint->atomic_flags);
> +		} else {
> +			set_bit(IMA_DIGSIG, &iint->atomic_flags);
>  		}
> -		clear_bit(IMA_DIGSIG, &iint->atomic_flags);
>  		if (xattr_len - sizeof(xattr_value->type) - hash_start >=
>  				iint->ima_hash->length)
>  			/*
> @@ -394,6 +398,8 @@ int ima_appraise_measurement(enum ima_hooks func,
>  		cause = "missing-HMAC";
>  		goto out;
>  	case INTEGRITY_FAIL_IMMUTABLE:
> +		set_bit(IMA_DIGSIG, &iint->atomic_flags);
> +		fallthrough;
>  	case INTEGRITY_FAIL:		/* Invalid HMAC/signature. */
>  		cause = "invalid-HMAC";
>  		goto out;
> @@ -437,9 +443,9 @@ int ima_appraise_measurement(enum ima_hooks func,
>  				status = INTEGRITY_PASS;
>  		}
>  
> -		/* Permit new files with file signatures, but without data. */
> +		/* Permit new files marked as immutable, but without data. */

This comment isn't quite right.

>  		if (inode->i_size == 0 && iint->flags & IMA_NEW_FILE &&
> -		    xattr_value && xattr_value->type == EVM_IMA_XATTR_DIGSIG) {
> +		    test_bit(IMA_DIGSIG, &iint->atomic_flags)) {
>  			status = INTEGRITY_PASS;
>  		}
>  


