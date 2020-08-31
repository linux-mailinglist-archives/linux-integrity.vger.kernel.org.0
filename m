Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37246258107
	for <lists+linux-integrity@lfdr.de>; Mon, 31 Aug 2020 20:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729674AbgHaSYJ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 31 Aug 2020 14:24:09 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:25912 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729581AbgHaSYJ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 31 Aug 2020 14:24:09 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07VI1k9e192199;
        Mon, 31 Aug 2020 14:24:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=P7mHsXAaOECT9cWfKNbj36oJwWhrX5fDV7JR8XC5aM0=;
 b=CPkddEgE29Ium4MTNJrwP5X6OWpYv1nYvTsni5xZl7PcCEzd6xQwDNtUedTBzrp0H+nc
 v8L6HJ8SjF0brR6Ddqom78bML3RSH4UcMCriDUxhgGpxKZMIASf/m8yH1kYcJFOZcxya
 dI8jRFK8XQzgBKIh7rX/aVO5FZ48TKHa+AQrtxnGL2vNF92pQwHcEFLAr1D6vGhKd/Pw
 GiSJcpOba6q7dB0mM0enqkzjcXtWx1vT2Ry5SZFn2GfoXXSdk+sn7O7s9O+ZqC7yGxj5
 XnlU8LNHayxVSNyAj9Mu53651BQcP2muK8fTEsltEuosFBcznOrST8jiMeXCJ3fA4Z9d GA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33953et7um-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Aug 2020 14:24:04 -0400
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 07VIK7lW043560;
        Mon, 31 Aug 2020 14:24:04 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33953et7tr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Aug 2020 14:24:03 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07VICxG7004273;
        Mon, 31 Aug 2020 18:24:02 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma06ams.nl.ibm.com with ESMTP id 337e9gtew2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Aug 2020 18:24:01 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07VINxPl31850954
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Aug 2020 18:23:59 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9E2A1A4040;
        Mon, 31 Aug 2020 18:23:59 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0F86CA4053;
        Mon, 31 Aug 2020 18:23:56 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.2.129])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 31 Aug 2020 18:23:55 +0000 (GMT)
Message-ID: <6c80bdad49c72fa58b5a9fb7ce2d20c8cabe1324.camel@linux.ibm.com>
Subject: Re: [PATCH v3 5/6] IMA: add hook to measure critical data from
 kernel components
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        stephen.smalley.work@gmail.com, casey@schaufler-ca.com,
        agk@redhat.com, snitzer@redhat.com, gmazyland@gmail.com
Cc:     tyhicks@linux.microsoft.com, sashal@kernel.org, jmorris@namei.org,
        nramas@linux.microsoft.com, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com
Date:   Mon, 31 Aug 2020 14:23:55 -0400
In-Reply-To: <20200828015704.6629-6-tusharsu@linux.microsoft.com>
References: <20200828015704.6629-1-tusharsu@linux.microsoft.com>
         <20200828015704.6629-6-tusharsu@linux.microsoft.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-31_08:2020-08-31,2020-08-31 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 mlxscore=0 bulkscore=0 mlxlogscore=999 lowpriorityscore=0
 malwarescore=0 adultscore=0 phishscore=0 clxscore=1015 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008310104
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index 52cbbc1f7ea2..a889bf40cb7e 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -869,6 +869,30 @@ void ima_kexec_cmdline(int kernel_fd, const void *buf, int size)
>  	fdput(f);
>  }
>  
> +/**
> + * ima_measure_critical_data - measure critical data
> + * @event_name: name for the given data
> + * @event_data_source: name of the event data source
> + * @buf: pointer to buffer containing data to measure
> + * @buf_len: length of buffer(in bytes)
> + * @measure_buf_hash: if set to true - will measure hash of the buf,
> + *                    instead of buf
> + *
> + * Buffers can only be measured, not appraised.
> + */
> +int ima_measure_critical_data(const char *event_name,
> +			      const char *event_data_source,
> +			      const void *buf, int buf_len,
> +			      bool measure_buf_hash)
> +{
> +	if (!event_name || !event_data_source || !buf || !buf_len)
> +		return -EINVAL;
> +
> +	return process_buffer_measurement(NULL, buf, buf_len, event_name,
> +					  CRITICAL_DATA, 0, event_data_source,
> +					  measure_buf_hash);

This is exactly what I'm concerned about.  Failure to measure data may
be audited, but should never fail.

Mimi

> +}


