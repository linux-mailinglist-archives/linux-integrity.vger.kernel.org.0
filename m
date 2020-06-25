Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45B0D20A757
	for <lists+linux-integrity@lfdr.de>; Thu, 25 Jun 2020 23:18:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405851AbgFYVSt (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 25 Jun 2020 17:18:49 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59680 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404016AbgFYVSs (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 25 Jun 2020 17:18:48 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05PL20YD104080;
        Thu, 25 Jun 2020 17:18:44 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31vts12px7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Jun 2020 17:18:44 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05PL5NZC113523;
        Thu, 25 Jun 2020 17:18:43 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31vts12pwc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Jun 2020 17:18:43 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05PL4sDf028253;
        Thu, 25 Jun 2020 21:18:41 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma03ams.nl.ibm.com with ESMTP id 31uus528kd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Jun 2020 21:18:41 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 05PLIdWB46596124
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Jun 2020 21:18:39 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0CB19A4057;
        Thu, 25 Jun 2020 21:18:39 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CAC2BA4055;
        Thu, 25 Jun 2020 21:18:37 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.142.225])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 25 Jun 2020 21:18:37 +0000 (GMT)
Message-ID: <1593119917.27152.399.camel@linux.ibm.com>
Subject: Re: [PATCH 08/12] ima: Shallow copy the args_p member of
 ima_rule_entry.lsm elements
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Tyler Hicks <tyhicks@linux.microsoft.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Prakhar Srivastava <prsriva02@gmail.com>,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Date:   Thu, 25 Jun 2020 17:18:37 -0400
In-Reply-To: <20200623003236.830149-9-tyhicks@linux.microsoft.com>
References: <20200623003236.830149-1-tyhicks@linux.microsoft.com>
         <20200623003236.830149-9-tyhicks@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-25_16:2020-06-25,2020-06-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 cotscore=-2147483648
 adultscore=0 mlxscore=0 malwarescore=0 clxscore=1015 phishscore=0
 suspectscore=2 spamscore=0 impostorscore=0 priorityscore=1501
 mlxlogscore=999 lowpriorityscore=0 bulkscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006250120
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2020-06-22 at 19:32 -0500, Tyler Hicks wrote:
> The args_p member is a simple string that is allocated by
> ima_rule_init(). Shallow copy it like other non-LSM references in
> ima_rule_entry structs.
> 
> There are no longer any necessary error path cleanups to do in
> ima_lsm_copy_rule() so reference ownership from entry to nentry becomes
> easier.
> 
> Signed-off-by: Tyler Hicks <tyhicks@linux.microsoft.com>
> ---
>  security/integrity/ima/ima_policy.c | 13 ++-----------
>  1 file changed, 2 insertions(+), 11 deletions(-)
> 
> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> index e33347148aa9..e9c7d318fdd4 100644
> --- a/security/integrity/ima/ima_policy.c
> +++ b/security/integrity/ima/ima_policy.c
> @@ -306,10 +306,8 @@ static struct ima_rule_entry *ima_lsm_copy_rule(struct ima_rule_entry *entry)
>  			continue;
>  
>  		nentry->lsm[i].type = entry->lsm[i].type;
> -		nentry->lsm[i].args_p = kstrdup(entry->lsm[i].args_p,
> -						GFP_KERNEL);
> -		if (!nentry->lsm[i].args_p)
> -			goto out_err;
> +		nentry->lsm[i].args_p = entry->lsm[i].args_p;
> +		entry->lsm[i].args_p = NULL;

Nice.

>  
>  		security_filter_rule_init(nentry->lsm[i].type,
>  					  Audit_equal,
> @@ -325,13 +323,6 @@ static struct ima_rule_entry *ima_lsm_copy_rule(struct ima_rule_entry *entry)
>  	entry->keyrings = NULL;
>  	entry->template = NULL;
>  	return nentry;
> -
> -out_err:
> -	nentry->fsname = NULL;
> -	nentry->keyrings = NULL;
> -	nentry->template = NULL;
> -	ima_free_rule(nentry);
> -	return NULL;
>  }

Definitely moving ima_free_rule() to the subsequent patch makes sense.

Mimi

>  
>  static int ima_lsm_update_rule(struct ima_rule_entry *entry)

