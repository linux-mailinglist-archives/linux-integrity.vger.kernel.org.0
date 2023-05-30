Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1BBE7162C8
	for <lists+linux-integrity@lfdr.de>; Tue, 30 May 2023 15:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231966AbjE3N6i (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 30 May 2023 09:58:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232519AbjE3N6h (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 30 May 2023 09:58:37 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56AB7E8;
        Tue, 30 May 2023 06:58:35 -0700 (PDT)
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34UDoD6H003097;
        Tue, 30 May 2023 13:58:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : date : in-reply-to : references : content-type : mime-version
 : content-transfer-encoding; s=pp1;
 bh=rGG+oPY9bJ/m4dGb9PBIheOdj6gCxk4udPGdzcR3ybo=;
 b=n/LHYIO0XGq73K7CtORMpKU0h3jRSmWo5J/qEOAGWW0yTWwn9xPAuu+L30Jk52ax4ALQ
 XFIVh+kD9FovsJs4TIDhVPxiVszDugPPIYZkU44GBjrzeWFAIPO6gKWwSuMtJJ6MQScH
 5SdCWYhWeBCmv7QiFXFTqlXFX+APhONqFblBVkG3lUcvh5fr7dnrDeYOsGhjIxXocCfD
 tYt2K8EIH7dpwxgAMpVT5TNZN0+17Ci9E7b+Df+3A9/KPIWoZm3f+9B2lf+gqZajM1WN
 pYVco/9p/ennDh6kAle4wqXSzM8Np/gNWyZN/E9zYLwuWJ9CYLpsPFvEyJkFOtgnGrXi cw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qwhy1s08u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 May 2023 13:58:24 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34UDtBPI022792;
        Tue, 30 May 2023 13:58:24 GMT
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qwhy1s08h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 May 2023 13:58:24 +0000
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 34UDPKXH009542;
        Tue, 30 May 2023 13:58:23 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([9.208.129.120])
        by ppma01wdc.us.ibm.com (PPS) with ESMTPS id 3qu9g5q3ps-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 May 2023 13:58:23 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
        by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 34UDwMjY4391596
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 May 2023 13:58:22 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EE63758054;
        Tue, 30 May 2023 13:58:21 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D83B358056;
        Tue, 30 May 2023 13:58:20 +0000 (GMT)
Received: from wecm-9-67-184-149.wecm.ibm.com (unknown [9.67.184.149])
        by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 30 May 2023 13:58:20 +0000 (GMT)
Message-ID: <01739d83cf13c83e0545c6d0d661ebea5ac39b6c.camel@linux.ibm.com>
Subject: Re: [PATCH] integrity: Fix possible multiple allocation in
 integrity_inode_get()
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 30 May 2023 09:58:20 -0400
In-Reply-To: <20230530121453.10249-1-tianjia.zhang@linux.alibaba.com>
References: <20230530121453.10249-1-tianjia.zhang@linux.alibaba.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: kdruNtFI7USR8EuFpGKSawc3EYq4bV4I
X-Proofpoint-GUID: zX7zzHrxDgEGeSW-YJV5F9FnqIj723W3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-30_10,2023-05-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 mlxlogscore=458 impostorscore=0 malwarescore=0
 phishscore=0 mlxscore=0 clxscore=1015 suspectscore=0 bulkscore=0
 lowpriorityscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2304280000 definitions=main-2305300110
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Tianjia,

On Tue, 2023-05-30 at 20:14 +0800, Tianjia Zhang wrote:
> When integrity_inode_get() is querying and inserting the cache, there
> is a conditional race in the concurrent environment.
> 
> Query iint within the read-lock. If there is no result, allocate iint
> first and insert the iint cache in the write-lock protection. When the
> iint cache does not exist, and when multiple execution streams come at
> the same time, there will be a race condition, and multiple copies of
> iint will be allocated at the same time, and then put into the cache
> one by one under the write-lock protection.

Right, the race condition is the result of not properly implementing
"double-checked locking".  In this case, it first checks to see if the
iint cache record exists before taking the lock, but doesn't check
again after taking the integrity_iint_lock.

> 
> This is mainly because the red-black tree insertion does not perform
> duplicate detection. This is not the desired result, when this
> happens, the repeated allocation should be freed and the existing
> iint cache should be returned.
> 
> Fixes: bf2276d10ce5 ("ima: allocating iint improvements")
> Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
> Cc: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
> Cc: <stable@vger.kernel.org> # v3.10+
> ---
>  security/integrity/iint.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/security/integrity/iint.c b/security/integrity/iint.c
> index c73858e8c6d5..d49c843a88ee 100644
> --- a/security/integrity/iint.c
> +++ b/security/integrity/iint.c
> @@ -43,12 +43,10 @@ static struct integrity_iint_cache *__integrity_iint_find(struct inode *inode)
>  		else if (inode > iint->inode)
>  			n = n->rb_right;
>  		else
> -			break;
> +			return iint;
>  	}
> -	if (!n)
> -		return NULL;
>  
> -	return iint;
> +	return NULL;
>  }
>  
>  /*
> @@ -115,8 +113,13 @@ struct integrity_iint_cache *integrity_inode_get(struct inode *inode)
>  				     rb_node);
>  		if (inode < test_iint->inode)
>  			p = &(*p)->rb_left;
> -		else
> +		else if (inode > test_iint->inode)
>  			p = &(*p)->rb_right;
> +		else {
> +			write_unlock(&integrity_iint_lock);
> +			kmem_cache_free(iint_cache, iint);
> +			return test_iint;
> +		}
>  	}
>  
>  	iint->inode = inode;

scripts/checkpatch.pl with the -strict option complains:

CHECK: Unbalanced braces around else statement
#56: FILE: security/integrity/iint.c:118:
+		else {

total: 0 errors, 0 warnings, 1 checks, 28 lines checked

-- 
thanks,

Mimi

