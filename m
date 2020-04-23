Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCB781B65C6
	for <lists+linux-integrity@lfdr.de>; Thu, 23 Apr 2020 22:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbgDWUvv (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 23 Apr 2020 16:51:51 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48192 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725877AbgDWUvu (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 23 Apr 2020 16:51:50 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03NKVX4Y118732
        for <linux-integrity@vger.kernel.org>; Thu, 23 Apr 2020 16:51:49 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 30k3xuvj2x-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 23 Apr 2020 16:51:49 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Thu, 23 Apr 2020 21:51:10 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 23 Apr 2020 21:51:07 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 03NKpiSY61276258
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Apr 2020 20:51:44 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 314FCA4040;
        Thu, 23 Apr 2020 20:51:44 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 65B82A4053;
        Thu, 23 Apr 2020 20:51:43 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.178.107])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 23 Apr 2020 20:51:43 +0000 (GMT)
Subject: Re: [PATCH] ima: Allow imasig requirement to be satisfied by EVM
 portable signatures
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>, mjg59@google.com
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, silviu.vlasceanu@huawei.com
Date:   Thu, 23 Apr 2020 16:51:42 -0400
In-Reply-To: <20200421092418.25151-1-roberto.sassu@huawei.com>
References: <20200421092418.25151-1-roberto.sassu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20042320-0008-0000-0000-00000376466D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20042320-0009-0000-0000-00004A9814D5
Message-Id: <1587675102.5610.66.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-23_14:2020-04-23,2020-04-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 impostorscore=0 adultscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 malwarescore=0 mlxlogscore=999 lowpriorityscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004230148
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2020-04-21 at 11:24 +0200, Roberto Sassu wrote:
> System administrators can require that all accessed files have a signature
> by specifying appraise_type=imasig in a policy rule.
> 
> Currently, only IMA signatures satisfy this requirement. However, also EVM
> portable signatures can satisfy it. Metadata, including security.ima, are
> signed and cannot change.

Please expand this paragraph with a short comparison of the security
guarantees provided by EVM immutable, portable signatures versus ima-
sig.

> 
> This patch helps in the scenarios where system administrators want to
> enforce this restriction but only EVM portable signatures are available.

Yes, I agree it "helps", but we still need to address the ability of
setting/removing security.ima, which isn't possible with an IMA
signature.  This sounds like we need to define an immutable file hash.
 What do you think?

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
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>  security/integrity/ima/ima_appraise.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
> index a9649b04b9f1..69a6a958f811 100644
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

Nice!

Mimi

