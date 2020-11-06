Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65BC12A95FD
	for <lists+linux-integrity@lfdr.de>; Fri,  6 Nov 2020 13:11:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727258AbgKFMLR (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 6 Nov 2020 07:11:17 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42342 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726317AbgKFMLR (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 6 Nov 2020 07:11:17 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0A6C1tuZ058470;
        Fri, 6 Nov 2020 07:11:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=bTgdsaXV0EvD4DnZF92Jqq7UrIodW4TVzld1IYi9XPM=;
 b=W7yDACQiXSojO9Q+33wNkbZjJ0eVExiKYww/JHkCR1AmBh7mjfwiFAp34+wb1HRyPJRx
 ntR5HWwFMhMI8SqYKsbntFoe73ees3Cbl7CMQ/asXAn36EUDfanJhss0WKaK9/3jcoGB
 VgL4/s93ER0EVAHpUw8pmDZnDVnoUEiuyCQjb7kkDKIJysYbNvbn4bw8Oo5SRul6rXGW
 Qu8KQLgrpyoWIT9yvbiv26ftsydYAvZhPa4HAATWi9/rGQuPORVJ8Gbg7X7q71bkW1hH
 uumdJb6cZ3HYs+fBqef2F5+iz9kFl5WeIqYIb+siaC00CCrdCXuJVQzgyrO54RjKo1eH EA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34mnucbv2u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 Nov 2020 07:11:11 -0500
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0A6C21Yb059071;
        Fri, 6 Nov 2020 07:11:11 -0500
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34mnucbv1f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 Nov 2020 07:11:10 -0500
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0A6Bx4hM015466;
        Fri, 6 Nov 2020 12:11:08 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04fra.de.ibm.com with ESMTP id 34h0f6uart-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 Nov 2020 12:11:08 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0A6CB61H59441418
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 6 Nov 2020 12:11:06 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 05B3642041;
        Fri,  6 Nov 2020 12:11:06 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 515B142045;
        Fri,  6 Nov 2020 12:11:02 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.77.67])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  6 Nov 2020 12:11:02 +0000 (GMT)
Message-ID: <811fbc4a6f4bd02c77518bd4196d354071145f3e.camel@linux.ibm.com>
Subject: Re: [PATCH v5 2/7] IMA: update process_buffer_measurement to
 measure buffer hash
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        stephen.smalley.work@gmail.com, casey@schaufler-ca.com,
        agk@redhat.com, snitzer@redhat.com, gmazyland@gmail.com,
        paul@paul-moore.com
Cc:     tyhicks@linux.microsoft.com, sashal@kernel.org, jmorris@namei.org,
        nramas@linux.microsoft.com, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com
Date:   Fri, 06 Nov 2020 07:11:01 -0500
In-Reply-To: <20201101222626.6111-3-tusharsu@linux.microsoft.com>
References: <20201101222626.6111-1-tusharsu@linux.microsoft.com>
         <20201101222626.6111-3-tusharsu@linux.microsoft.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-06_03:2020-11-05,2020-11-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 spamscore=0 adultscore=0 mlxlogscore=999
 priorityscore=1501 clxscore=1015 bulkscore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011060085
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Tushar,

Below inline are a few additional comments.

> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index ae5da9f3339d..4485d87c0aa5 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -787,12 +787,15 @@ int ima_post_load_data(char *buf, loff_t size,
>   * @func: IMA hook
>   * @pcr: pcr to extend the measurement
>   * @func_data: private data specific to @func, can be NULL.
> + * @measure_buf_hash: if set to true - will measure hash of the buf,
> + *                    instead of buf
>   *
>   * Based on policy, the buffer is measured into the ima log.

Both the brief and longer function descriptions need to be updated, as
well as the last argument description.  The last argument should be
limited to "measure buffer hash".  How it is used could be included in
the longer function description.  The longer function description would
include adding the buffer data or the buffer data hash to the IMA
measurement list and extending the PCR.  

For example, 
process_buffer_measurement - measure the buffer data or the buffer data
hash


>   */
>  void process_buffer_measurement(struct inode *inode, const void *buf, int size,
>  				const char *eventname, enum ima_hooks func,
> -				int pcr, const char *func_data)
> +				int pcr, const char *func_data,
> +				bool measure_buf_hash)
>  {
>  	int ret = 0;
>  	const char *audit_cause = "ENOMEM";
> @@ -807,6 +810,8 @@ void process_buffer_measurement(struct inode *inode, const void *buf, int size,
>  		struct ima_digest_data hdr;
>  		char digest[IMA_MAX_DIGEST_SIZE];
>  	} hash = {};
> +	char digest_hash[IMA_MAX_DIGEST_SIZE];
> +	int hash_len = hash_digest_size[ima_hash_algo];
>  	int violation = 0;
>  	int action = 0;
>  	u32 secid;
> @@ -855,6 +860,21 @@ void process_buffer_measurement(struct inode *inode, const void *buf, int size,
>  		goto out;
>  	}
>  
> +	if (measure_buf_hash) {
> +		memcpy(digest_hash, hash.hdr.digest, hash_len);

Instead of digest_hash and hash_len, consider naming the variables
buf_hash and buf_hashlen.

> +
> +		ret = ima_calc_buffer_hash(digest_hash,
> +					   hash_len,
> +					   iint.ima_hash);

There's no need for each variable to be on a separate line.

thanks,

Mimi

> +		if (ret < 0) {
> +			audit_cause = "measure_buf_hash_error";
> +			goto out;
> +		}
> +
> +		event_data.buf = digest_hash;
> +		event_data.buf_len = hash_len;
> +	}
> +
>  	ret = ima_alloc_init_template(&event_data, &entry, template);
>  	if (ret < 0) {
>  		audit_cause = "alloc_entry";

