Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F309820A5E7
	for <lists+linux-integrity@lfdr.de>; Thu, 25 Jun 2020 21:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406461AbgFYTdv (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 25 Jun 2020 15:33:51 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48146 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2406068AbgFYTdu (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 25 Jun 2020 15:33:50 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05PJVZGf096833;
        Thu, 25 Jun 2020 15:33:40 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 31vtt3gg8x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Jun 2020 15:33:39 -0400
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05PJWncc105143;
        Thu, 25 Jun 2020 15:33:39 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 31vtt3gg8d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Jun 2020 15:33:39 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05PJKmDr020695;
        Thu, 25 Jun 2020 19:33:37 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04ams.nl.ibm.com with ESMTP id 31uus726d2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Jun 2020 19:33:37 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 05PJXZHx9830696
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Jun 2020 19:33:35 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 939C642049;
        Thu, 25 Jun 2020 19:33:35 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AEFBD42047;
        Thu, 25 Jun 2020 19:33:33 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.142.225])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 25 Jun 2020 19:33:33 +0000 (GMT)
Message-ID: <1593113613.27152.345.camel@linux.ibm.com>
Subject: Re: [PATCH 02/12] ima: Create a function to free a rule entry
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Tyler Hicks <tyhicks@linux.microsoft.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Prakhar Srivastava <prsriva02@gmail.com>,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Date:   Thu, 25 Jun 2020 15:33:33 -0400
In-Reply-To: <20200623003236.830149-3-tyhicks@linux.microsoft.com>
References: <20200623003236.830149-1-tyhicks@linux.microsoft.com>
         <20200623003236.830149-3-tyhicks@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-25_15:2020-06-25,2020-06-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 adultscore=0 phishscore=0 suspectscore=2 mlxscore=0 mlxlogscore=999
 lowpriorityscore=0 impostorscore=0 spamscore=0 cotscore=-2147483648
 clxscore=1011 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006250113
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2020-06-22 at 19:32 -0500, Tyler Hicks wrote:
> There are several possible pieces of allocated memory in a rule entry.
> Create a function that can free all allocated memory for a given rule
> entry.
> 
> This patch introduces no functional changes but sets the groundwork for
> some memory leak fixes.
> 
> Signed-off-by: Tyler Hicks <tyhicks@linux.microsoft.com>

Having a function to release all memory associated with a policy rule
in general is a good idea.  However, in the case of the shallow copy,
we're not removing any IMA rules, just updating the LSM info.

There is an opportunity to transition from the builtin policy rules to
a custom IMA policy.  Afterwards IMA policy rules may only be
appended.

An IMA custom policy based on LSM info may be loaded prior to the LSM
policy.  These LSM based rules are inactive until the corresponding
LSM rule is loaded.  In some environments, LSM policies are loaded and
removed frequently.  The IMA rules themselves are not removed, just
the LSM info is updated to reflect the current LSM info.

> ---
>  security/integrity/ima/ima_policy.c | 33 +++++++++++++++++++++++++++--
>  1 file changed, 31 insertions(+), 2 deletions(-)
> 
> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> index 236a731492d1..1320333201c6 100644
> --- a/security/integrity/ima/ima_policy.c
> +++ b/security/integrity/ima/ima_policy.c
> @@ -261,6 +261,27 @@ static void ima_lsm_free_rule(struct ima_rule_entry *entry)
>  		security_filter_rule_free(entry->lsm[i].rule);
>  		kfree(entry->lsm[i].args_p);
>  	}
> +}
> +
> +static void ima_free_rule(struct ima_rule_entry *entry)
> +{
> +	if (!entry)
> +		return;
> +
> +	/*
> +	 * entry->template->fields may be allocated in ima_parse_rule() but that
> +	 * reference is owned by the corresponding ima_template_desc element in
> +	 * the defined_templates list and cannot be freed here
> +	 */
> +
> +	/*
> +	 * When freeing newly added ima_rule_entry members, consider if you
> +	 * need to disown any references after the shallow copy in
> +	 * ima_lsm_copy_rule()
> +	 */
> +	kfree(entry->fsname);
> +	kfree(entry->keyrings);
> +	ima_lsm_free_rule(entry);
>  	kfree(entry);
>  }
>  
> @@ -298,10 +319,18 @@ static struct ima_rule_entry *ima_lsm_copy_rule(struct ima_rule_entry *entry)
>  			pr_warn("rule for LSM \'%s\' is undefined\n",
>  				(char *)entry->lsm[i].args_p);
>  	}
> +
> +	/* Disown all references that were shallow copied */
> +	entry->fsname = NULL;
> +	entry->keyrings = NULL;
> +	entry->template = NULL;
>  	return nentry;
>  
>  out_err:
> -	ima_lsm_free_rule(nentry);
> +	nentry->fsname = NULL;
> +	nentry->keyrings = NULL;
> +	nentry->template = NULL;
> +	ima_free_rule(nentry);

>  	return NULL;
>  }
>  
> @@ -315,7 +344,7 @@ static int ima_lsm_update_rule(struct ima_rule_entry *entry)
>  
>  	list_replace_rcu(&entry->list, &nentry->list);
>  	synchronize_rcu();
> -	ima_lsm_free_rule(entry);
> +	ima_free_rule(entry);

This should only update the LSM info, nothing else.

>  
>  	return 0;
>  }

