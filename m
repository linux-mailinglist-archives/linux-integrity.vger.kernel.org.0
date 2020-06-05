Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F22E1F000E
	for <lists+linux-integrity@lfdr.de>; Fri,  5 Jun 2020 20:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728175AbgFESqc (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 5 Jun 2020 14:46:32 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:62166 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728129AbgFESqb (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 5 Jun 2020 14:46:31 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 055IWlAX122783;
        Fri, 5 Jun 2020 14:46:29 -0400
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31fjmfj308-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 05 Jun 2020 14:46:28 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 055IjoFO022049;
        Fri, 5 Jun 2020 18:46:25 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04fra.de.ibm.com with ESMTP id 31f2q411bj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 05 Jun 2020 18:46:25 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 055Ij8xN62390710
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 5 Jun 2020 18:45:08 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7E1E442041;
        Fri,  5 Jun 2020 18:46:23 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9F1EE4204C;
        Fri,  5 Jun 2020 18:46:22 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.181.45])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  5 Jun 2020 18:46:22 +0000 (GMT)
Message-ID: <1591382782.5816.36.camel@linux.ibm.com>
Subject: Re: [PATCH] IMA: Add log statements for failure conditions
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        linux-integrity@vger.kernel.org
Cc:     tusharsu@linux.microsoft.com, linux-kernel@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>
Date:   Fri, 05 Jun 2020 14:46:22 -0400
In-Reply-To: <20200604163243.2575-1-nramas@linux.microsoft.com>
References: <20200604163243.2575-1-nramas@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-05_05:2020-06-04,2020-06-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=2
 cotscore=-2147483648 priorityscore=1501 spamscore=0 mlxlogscore=999
 phishscore=0 clxscore=1011 malwarescore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006050137
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

[Cc'ing Paul Moore]

Hi Lakshmi,

On Thu, 2020-06-04 at 09:32 -0700, Lakshmi Ramasubramanian wrote:
> The final log statement in process_buffer_measurement() for failure
> condition is at debug level. This does not log the message unless
> the system log level is raised which would significantly increase
> the messages in the system log. Change this log message to error level,
> and add eventname and ima_hooks enum to the message for better triaging
> failures in the function.
> 
> ima_alloc_key_entry() does not log a message for failure condition.
> Add an error message for failure condition in this function.
> 
> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>

These messages should probably be turned into audit messages.  Look at
integerity_audit_msg().

Mimi

> ---
>  security/integrity/ima/ima_main.c       | 3 ++-
>  security/integrity/ima/ima_queue_keys.c | 2 ++
>  2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index 9d0abedeae77..3b371f31597b 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -756,7 +756,8 @@ void process_buffer_measurement(const void *buf, int size,
>  
>  out:
>  	if (ret < 0)
> -		pr_devel("%s: failed, result: %d\n", __func__, ret);
> +		pr_err("%s failed. eventname: %s, func: %d, result: %d\n",
> +		       __func__, eventname, func, ret);
>  
>  	return;
>  }
> diff --git a/security/integrity/ima/ima_queue_keys.c b/security/integrity/ima/ima_queue_keys.c
> index cb3e3f501593..e51d0eb08d8a 100644
> --- a/security/integrity/ima/ima_queue_keys.c
> +++ b/security/integrity/ima/ima_queue_keys.c
> @@ -88,6 +88,8 @@ static struct ima_key_entry *ima_alloc_key_entry(struct key *keyring,
>  
>  out:
>  	if (rc) {
> +		pr_err("%s failed. keyring: %s, result: %d\n",
> +		       __func__, keyring->description, rc);
>  		ima_free_key_entry(entry);
>  		entry = NULL;
>  	}

