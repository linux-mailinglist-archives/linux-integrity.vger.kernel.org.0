Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 804A5210052
	for <lists+linux-integrity@lfdr.de>; Wed,  1 Jul 2020 01:07:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726142AbgF3XHr (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 30 Jun 2020 19:07:47 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:13602 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725791AbgF3XHr (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 30 Jun 2020 19:07:47 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05UN3KfM018224;
        Tue, 30 Jun 2020 19:07:36 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3204s1bj33-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Jun 2020 19:07:36 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05UN7ZPj033337;
        Tue, 30 Jun 2020 19:07:35 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3204s1bj26-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Jun 2020 19:07:35 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05UN5YoD022861;
        Tue, 30 Jun 2020 23:07:33 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03ams.nl.ibm.com with ESMTP id 31wwr8c7ka-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Jun 2020 23:07:33 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 05UN7UGr42139754
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Jun 2020 23:07:31 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DF3334203F;
        Tue, 30 Jun 2020 23:07:30 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D19BD4204C;
        Tue, 30 Jun 2020 23:07:29 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.162.223])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 30 Jun 2020 23:07:29 +0000 (GMT)
Message-ID: <1593558449.5057.12.camel@linux.ibm.com>
Subject: Re: [PATCH v2 09/11] ima: Move validation of the keyrings
 conditional into ima_validate_rule()
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Tyler Hicks <tyhicks@linux.microsoft.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Prakhar Srivastava <prsriva02@gmail.com>,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Date:   Tue, 30 Jun 2020 19:07:29 -0400
In-Reply-To: <20200626223900.253615-10-tyhicks@linux.microsoft.com>
References: <20200626223900.253615-1-tyhicks@linux.microsoft.com>
         <20200626223900.253615-10-tyhicks@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-06-30_06:2020-06-30,2020-06-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 spamscore=0 mlxscore=0 cotscore=-2147483648 suspectscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 clxscore=1015 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006300159
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2020-06-26 at 17:38 -0500, Tyler Hicks wrote:
> Use ima_validate_rule() to ensure that the combination of a hook
> function and the keyrings conditional is valid and that the keyrings
> conditional is not specified without an explicit KEY_CHECK func
> conditional. This is a code cleanup and has no user-facing change.
> 
> Signed-off-by: Tyler Hicks <tyhicks@linux.microsoft.com>
> ---
> 
> * v2
>   - Allowed IMA_DIGSIG_REQUIRED, IMA_PERMIT_DIRECTIO,
>     IMA_MODSIG_ALLOWED, and IMA_CHECK_BLACKLIST conditionals to be
>     present in the rule entry flags for non-buffer hook functions.
> 
>  security/integrity/ima/ima_policy.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> index 8cdca2399d59..43d49ad958fb 100644
> --- a/security/integrity/ima/ima_policy.c
> +++ b/security/integrity/ima/ima_policy.c
> @@ -1000,6 +1000,15 @@ static bool ima_validate_rule(struct ima_rule_entry *entry)
>  		case KEXEC_KERNEL_CHECK:
>  		case KEXEC_INITRAMFS_CHECK:
>  		case POLICY_CHECK:
> +			if (entry->flags & ~(IMA_FUNC | IMA_MASK | IMA_FSMAGIC |
> +					     IMA_UID | IMA_FOWNER | IMA_FSUUID |
> +					     IMA_INMASK | IMA_EUID | IMA_PCR |
> +					     IMA_FSNAME | IMA_DIGSIG_REQUIRED |
> +					     IMA_PERMIT_DIRECTIO |
> +					     IMA_MODSIG_ALLOWED |
> +					     IMA_CHECK_BLACKLIST))

Other than KEYRINGS, this patch should continue to behave the same.
 However, this list gives the impressions that all of these flags are
permitted on all of the above flags, which isn't true.

For example, both IMA_MODSIG_ALLOWED & IMA_CHECK_BLACKLIST are limited
to appended signatures, meaning KERNEL_CHECK and KEXEC_KERNEL_CHECK.
 Both should only be allowed on APPRAISE action rules.

IMA_PCR should be limited to MEASURE action rules.

IMA_DIGSIG_REQUIRED should be limited to APPRAISE action rules.

> +				return false;
> +
>  			break;
>  		case KEXEC_CMDLINE:
>  			if (entry->action & ~(MEASURE | DONT_MEASURE))
> @@ -1027,7 +1036,8 @@ static bool ima_validate_rule(struct ima_rule_entry *entry)
>  		default:
>  			return false;
>  		}
> -	}
> +	} else if (entry->flags & IMA_KEYRINGS)
> +		return false;

IMA_MODSIG_ALLOWED and IMA_CHECK_BLACKLIST need to be added here as
well.

Mimi

>  
>  	return true;
>  }
> @@ -1209,7 +1219,6 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
>  			keyrings_len = strlen(args[0].from) + 1;
>  
>  			if ((entry->keyrings) ||
> -			    (entry->func != KEY_CHECK) ||
>  			    (keyrings_len < 2)) {
>  				result = -EINVAL;
>  				break;

