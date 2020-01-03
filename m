Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC5F312FB26
	for <lists+linux-integrity@lfdr.de>; Fri,  3 Jan 2020 18:11:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728055AbgACRLf (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 3 Jan 2020 12:11:35 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43348 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728048AbgACRLf (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 3 Jan 2020 12:11:35 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 003H7NVX010609
        for <linux-integrity@vger.kernel.org>; Fri, 3 Jan 2020 12:11:34 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2xa48m94rc-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 03 Jan 2020 12:11:34 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Fri, 3 Jan 2020 17:11:32 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 3 Jan 2020 17:11:29 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 003HBSWx35913866
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 3 Jan 2020 17:11:28 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5E3C94C046;
        Fri,  3 Jan 2020 17:11:28 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7C4694C040;
        Fri,  3 Jan 2020 17:11:27 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.194.89])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  3 Jan 2020 17:11:27 +0000 (GMT)
Subject: Re: [PATCH] ima: Add a space after printing a LSM rule for
 readability
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     clayc@hpe.com, linux-kernel@vger.kernel.org
Cc:     linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, dmitry.kasatkin@gmail.com,
        jmorris@namei.org, serge@hallyn.com
Date:   Fri, 03 Jan 2020 12:11:27 -0500
In-Reply-To: <1578037863-7102-1-git-send-email-clayc@hpe.com>
References: <1578037863-7102-1-git-send-email-clayc@hpe.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20010317-0012-0000-0000-0000037A4312
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20010317-0013-0000-0000-000021B65728
Message-Id: <1578071487.5152.13.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2020-01-03_05:2020-01-02,2020-01-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 spamscore=0 mlxscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 adultscore=0 phishscore=0
 bulkscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1910280000 definitions=main-2001030157
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2020-01-03 at 15:51 +0800, clayc@hpe.com wrote:
> From: Clay Chang <clayc@hpe.com>

Normally this "From" line is only seen when the sender isn't the patch
author.  Any ideas what happened? 

> 
> When reading ima_policy from securityfs, there is a missing
> space between output string of LSM rules.
> 
> Signed-off-by: Clay Chang <clayc@hpe.com>

Good catch!  IMA policy rules based on LSM labels are used to
constrain which files are in policy.  Normally a single LSM label is
enough (e.g. dont_measure obj_type=auditd_log_t).  Could you include
in this patch description a use case where multiple LSM labels are
needed?

thanks,

Mimi

> ---
>  security/integrity/ima/ima_policy.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> index ef8dfd47c7e3..1a266e4f99bc 100644
> --- a/security/integrity/ima/ima_policy.c
> +++ b/security/integrity/ima/ima_policy.c
> @@ -1496,6 +1496,7 @@ int ima_policy_show(struct seq_file *m, void *v)
>  					   (char *)entry->lsm[i].args_p);
>  				break;
>  			}
> +			seq_puts(m, " ");
>  		}
>  	}
>  	if (entry->template)

