Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 530671F1835
	for <lists+linux-integrity@lfdr.de>; Mon,  8 Jun 2020 13:53:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729549AbgFHLxA (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 8 Jun 2020 07:53:00 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:1314 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729535AbgFHLxA (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 8 Jun 2020 07:53:00 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 058BWOKU100710;
        Mon, 8 Jun 2020 07:52:57 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 31g59rbqjp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Jun 2020 07:52:57 -0400
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 058BWJgl100209;
        Mon, 8 Jun 2020 07:52:57 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 31g59rbqj1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Jun 2020 07:52:56 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 058BjE7m014959;
        Mon, 8 Jun 2020 11:52:55 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03ams.nl.ibm.com with ESMTP id 31g2s7uvm7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Jun 2020 11:52:55 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 058Bqr3X6685134
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 8 Jun 2020 11:52:53 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 02110A405B;
        Mon,  8 Jun 2020 11:52:53 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5CF67A4051;
        Mon,  8 Jun 2020 11:52:52 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.178.150])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  8 Jun 2020 11:52:52 +0000 (GMT)
Message-ID: <1591617171.4638.33.camel@linux.ibm.com>
Subject: Re: [PATCH v2] IMA: Add audit log for failure conditions
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        paul@paul-moore.com
Cc:     linux-integrity@vger.kernel.org, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org
Date:   Mon, 08 Jun 2020 07:52:51 -0400
In-Reply-To: <20200607221449.2837-1-nramas@linux.microsoft.com>
References: <20200607221449.2837-1-nramas@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-08_07:2020-06-08,2020-06-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 impostorscore=0 clxscore=1015 adultscore=0 spamscore=0 phishscore=0
 malwarescore=0 mlxlogscore=999 cotscore=-2147483648 bulkscore=0
 suspectscore=2 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006080084
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Lakshmi,

On Sun, 2020-06-07 at 15:14 -0700, Lakshmi Ramasubramanian wrote:
> The final log statement in process_buffer_measurement() for failure
> condition is at debug level. This does not log the message unless
> the system log level is raised which would significantly increase
> the messages in the system log. Change this log message to an audit
> message for better triaging failures in the function.
> 
> ima_alloc_key_entry() does not log a message for failure condition.
> Add an audit message for failure condition in this function.
> 
> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>

Audit messages should be at a higher level.  For example,
"hashing_error", "collect_data", "invalid_pcr".  In the "invalid_pcr"
case, the audit log contains the reason - "ToMToU" or "open_writers" -
as to why the measurement list doesn't match the PCR.

Here you would want "measuring_keys", "measuring_boot_cmdline" with
the reason it failed, not the function name
"process_buffer_measurement".

Userspace needs to be aware of the new audit messages.  Maybe include
samples of them in the cover letter.

thanks,

Mimi

> ---
>  security/integrity/ima/ima_main.c       | 17 ++++++++++++-----
>  security/integrity/ima/ima_queue_keys.c |  4 ++++
>  2 files changed, 16 insertions(+), 5 deletions(-)
> 
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index 800fb3bba418..1225198fceb1 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -739,6 +739,7 @@ void process_buffer_measurement(const void *buf, int size,
>  				int pcr, const char *keyring)
>  {
>  	int ret = 0;
> +	const char *audit_cause = "ENOMEM";
>  	struct ima_template_entry *entry = NULL;
>  	struct integrity_iint_cache iint = {};
>  	struct ima_event_data event_data = {.iint = &iint,
> @@ -793,21 +794,27 @@ void process_buffer_measurement(const void *buf, int size,
>  	iint.ima_hash->length = hash_digest_size[ima_hash_algo];
>  
>  	ret = ima_calc_buffer_hash(buf, size, iint.ima_hash);
> -	if (ret < 0)
> +	if (ret < 0) {
> +		audit_cause = "calc_buffer_hash";
>  		goto out;
> +	}
>  
>  	ret = ima_alloc_init_template(&event_data, &entry, template);
> -	if (ret < 0)
> +	if (ret < 0) {
> +		audit_cause = "alloc_init_template";
>  		goto out;
> +	}
>  
>  	ret = ima_store_template(entry, violation, NULL, buf, pcr);
> -
> -	if (ret < 0)
> +	if (ret < 0) {
> +		audit_cause = "store_template";
>  		ima_free_template_entry(entry);
> +	}
>  
>  out:
>  	if (ret < 0)
> -		pr_devel("%s: failed, result: %d\n", __func__, ret);
> +		integrity_audit_msg(AUDIT_INTEGRITY_PCR, NULL, eventname,
> +				    __func__, audit_cause, ret, 0);
>  
>  	return;
>  }
> diff --git a/security/integrity/ima/ima_queue_keys.c b/security/integrity/ima/ima_queue_keys.c
> index cb3e3f501593..fa606ce68f87 100644
> --- a/security/integrity/ima/ima_queue_keys.c
> +++ b/security/integrity/ima/ima_queue_keys.c
> @@ -68,6 +68,7 @@ static struct ima_key_entry *ima_alloc_key_entry(struct key *keyring,
>  						 size_t payload_len)
>  {
>  	int rc = 0;
> +	const char *audit_cause = "ENOMEM";
>  	struct ima_key_entry *entry;
>  
>  	entry = kzalloc(sizeof(*entry), GFP_KERNEL);
> @@ -88,6 +89,9 @@ static struct ima_key_entry *ima_alloc_key_entry(struct key *keyring,
>  
>  out:
>  	if (rc) {
> +		integrity_audit_msg(AUDIT_INTEGRITY_PCR, NULL,
> +				    keyring->description, __func__,
> +				    audit_cause, rc, 0);
>  		ima_free_key_entry(entry);
>  		entry = NULL;
>  	}

