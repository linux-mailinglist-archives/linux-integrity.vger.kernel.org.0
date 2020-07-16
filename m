Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 514C6222AB4
	for <lists+linux-integrity@lfdr.de>; Thu, 16 Jul 2020 20:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729187AbgGPSPC (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 16 Jul 2020 14:15:02 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:9248 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728182AbgGPSPC (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 16 Jul 2020 14:15:02 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06GI2oeM117021;
        Thu, 16 Jul 2020 14:14:57 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32autagabg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Jul 2020 14:14:57 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06GI3YIn118461;
        Thu, 16 Jul 2020 14:14:57 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32autaga9x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Jul 2020 14:14:57 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06GI9eOD020742;
        Thu, 16 Jul 2020 18:14:54 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma02fra.de.ibm.com with ESMTP id 327527x1cf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Jul 2020 18:14:54 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06GIEqI230212406
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Jul 2020 18:14:52 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F33DF11C04C;
        Thu, 16 Jul 2020 18:14:51 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C20C511C04A;
        Thu, 16 Jul 2020 18:14:50 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.202.131])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 16 Jul 2020 18:14:50 +0000 (GMT)
Message-ID: <1594923290.12900.376.camel@linux.ibm.com>
Subject: Re: [PATCH v3 07/12] ima: Fail rule parsing when
 appraise_flag=blacklist is unsupportable
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Tyler Hicks <tyhicks@linux.microsoft.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Prakhar Srivastava <prsriva02@gmail.com>,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Nayna Jain <nayna@linux.ibm.com>
Date:   Thu, 16 Jul 2020 14:14:50 -0400
In-Reply-To: <20200709061911.954326-8-tyhicks@linux.microsoft.com>
References: <20200709061911.954326-1-tyhicks@linux.microsoft.com>
         <20200709061911.954326-8-tyhicks@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-16_08:2020-07-16,2020-07-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 suspectscore=0 mlxscore=0 phishscore=0 bulkscore=0
 impostorscore=0 mlxlogscore=999 clxscore=1015 lowpriorityscore=0
 malwarescore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2007160128
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2020-07-09 at 01:19 -0500, Tyler Hicks wrote:
> The "appraise_flag" option is only appropriate for appraise actions
> and its "blacklist" value is only appropriate when
> CONFIG_IMA_APPRAISE_MODSIG is enabled and "appraise_flag=blacklist" is
> only appropriate when "appraise_type=imasig|modsig" is also present.
> Make this clear at policy load so that IMA policy authors don't assume
> that other uses of "appraise_flag=blacklist" are supported.

The code looks correct, but this patch description could be written at
a higher level.  Perhaps it just needs to be prefixed with something
like this:

Verifying that a file hash is not blacklisted is currently only
supported for files with appended signatures (modsig).  In the future,
this might change.  For now, ...

Mimi

> 
> Fixes: 273df864cf74 ("ima: Check against blacklisted hashes for files with modsig")
> Signed-off-by: Tyler Hicks <tyhicks@linux.microsoft.com>
> Cc: Nayna Jain <nayna@linux.ibm.com>

> ---
> 
> * v3
>   - New patch
> 
>  security/integrity/ima/ima_policy.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> index 81da02071d41..9842e2e0bc6d 100644
> --- a/security/integrity/ima/ima_policy.c
> +++ b/security/integrity/ima/ima_policy.c
> @@ -1035,6 +1035,11 @@ static bool ima_validate_rule(struct ima_rule_entry *entry)
>  		return false;
>  	}
>  
> +	/* Ensure that combinations of flags are compatible with each other */
> +	if (entry->flags & IMA_CHECK_BLACKLIST &&
> +	    !(entry->flags & IMA_MODSIG_ALLOWED))
> +		return false;
> +
>  	return true;
>  }
>  
> @@ -1371,8 +1376,14 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
>  				result = -EINVAL;
>  			break;
>  		case Opt_appraise_flag:
> +			if (entry->action != APPRAISE) {
> +				result = -EINVAL;
> +				break;
> +			}
> +
>  			ima_log_string(ab, "appraise_flag", args[0].from);
> -			if (strstr(args[0].from, "blacklist"))
> +			if (IS_ENABLED(CONFIG_IMA_APPRAISE_MODSIG) &&
> +			    strstr(args[0].from, "blacklist"))
>  				entry->flags |= IMA_CHECK_BLACKLIST;
>  			break;
>  		case Opt_permit_directio:

