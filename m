Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B3BC2A96F1
	for <lists+linux-integrity@lfdr.de>; Fri,  6 Nov 2020 14:24:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727396AbgKFNYf (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 6 Nov 2020 08:24:35 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:12354 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727287AbgKFNYf (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 6 Nov 2020 08:24:35 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0A6D3KAc045401;
        Fri, 6 Nov 2020 08:24:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=pHx2leChPrzAo4WC2IenghVznIUYtgXXGfVyOhtlw/U=;
 b=PhsbIFYfRhRbCifMPlvp61ET8lMmQMqn26XRNQyyRN67kOkrOSj78oknde0VDPW7vMAR
 NWP/WG7uI+cPXkS9QMtMUnjZ4jLYvIerlmNGmN/C7fPB1YL5ak0MW8nem9671aFo/8hJ
 Orm/UcJo7phBFjVMn0ATnldfVuqxMcZ9rx+rDMqlW7tXOxTV5++eJF2+zKx6bgRnpTEM
 DTTgzcbcRmYEZE7u7Kajod6apwv1svfVM3q5V8pWm29JVVP68Gg2JWn/9v0qrftr2XgO
 AsfqaSnPfMhDtrk9PHBxA3FmTgX08xOPWqS2D8FWRmgOHUpa5H8b03EbQm5dNz8NWCgJ PA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 34n3qr7m4p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 Nov 2020 08:24:28 -0500
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0A6DFnwV106475;
        Fri, 6 Nov 2020 08:24:27 -0500
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 34n3qr7m3m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 Nov 2020 08:24:27 -0500
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0A6DLxKn004773;
        Fri, 6 Nov 2020 13:24:25 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03ams.nl.ibm.com with ESMTP id 34hm6hdskk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 Nov 2020 13:24:25 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0A6DONFB64553234
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 6 Nov 2020 13:24:23 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 36A63AE056;
        Fri,  6 Nov 2020 13:24:23 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C6192AE051;
        Fri,  6 Nov 2020 13:24:19 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.77.67])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  6 Nov 2020 13:24:19 +0000 (GMT)
Message-ID: <1f83ec246cb6356c340b379ab00e43f0b5bba0ae.camel@linux.ibm.com>
Subject: Re: [PATCH v5 3/7] IMA: add hook to measure critical data
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        stephen.smalley.work@gmail.com, casey@schaufler-ca.com,
        agk@redhat.com, snitzer@redhat.com, gmazyland@gmail.com,
        paul@paul-moore.com
Cc:     tyhicks@linux.microsoft.com, sashal@kernel.org, jmorris@namei.org,
        nramas@linux.microsoft.com, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com
Date:   Fri, 06 Nov 2020 08:24:18 -0500
In-Reply-To: <20201101222626.6111-4-tusharsu@linux.microsoft.com>
References: <20201101222626.6111-1-tusharsu@linux.microsoft.com>
         <20201101222626.6111-4-tusharsu@linux.microsoft.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-06_04:2020-11-05,2020-11-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 impostorscore=0 adultscore=0 phishscore=0 malwarescore=0 clxscore=1015
 mlxscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011060090
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Tushar,

On Sun, 2020-11-01 at 14:26 -0800, Tushar Sugandhi wrote:
> Currently, IMA does not provide a generic function for kernel subsystems
> to measure their critical data. Examples of critical data in this context
> could be kernel in-memory r/o structures, hash of the memory structures,
> or data that represents a linux kernel subsystem state change. The 
> critical data, if accidentally or maliciously altered, can compromise
> the integrity of the system.

Start out with what IMA does do (e.g. measures files and more recently
buffer data).  Afterwards continue with kernel integrity critical data
should also be measured.  Please include a definition of kernel
integrity critical data here, as well as in the cover letter.

> 
> A generic function provided by IMA to measure critical data would enable
> various subsystems with easier and faster on-boarding to use IMA
> infrastructure and would also avoid code duplication.

By definition LSM and IMA hooks are generic with callers in appropriate
places in the kernel.   This paragraph is redundant.

> 
> Add a new IMA func CRITICAL_DATA and a corresponding IMA hook
> ima_measure_critical_data() to support measuring critical data for 
> various kernel subsystems. 

Instead of using the word "add", it would be more appropriate to use
the word "define".   Define a new IMA hook named
ima_measure_critical_data to measure kernel integrity critical data.  
Please also update the Subject line as well.  "ima: define an IMA hook
to measure kernel integrity critical data".

> 
> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> ---
> 
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index 4485d87c0aa5..6e1b11dcba53 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -921,6 +921,44 @@ void ima_kexec_cmdline(int kernel_fd, const void *buf, int size)
>  	fdput(f);
>  }
>  
> +/**
> + * ima_measure_critical_data - measure kernel subsystem data
> + * critical to integrity of the kernel

Please change this to "measure kernel integrity critical data".

> + * @event_data_source: name of the data source being measured;
> + * typically it should be the name of the kernel subsystem that is sending
> + * the data for measurement

Including "data_source" here isn't quite right.  "data source" should
only be added in the first patch which uses it, not here.   When adding
it please shorten the field description to "kernel data source".   The
longer explanation can be included in the longer function description.

> + * @event_name: name of an event from the kernel subsystem that is sending
> + * the data for measurement

As this is being passed to process_buffer_measurement(), this should be
the same or similar to the existing definition.

> + * @buf: pointer to buffer containing data to measure
> + * @buf_len: length of buffer(in bytes)
> + * @measure_buf_hash: if set to true - will measure hash of the buf,
> + *                    instead of buf

 kernel doc requires a single line.  In this case, please shorten the
argument definition to "measure buffer data or buffer data hash".   The
details can be included in the longer function description.

> + *
> + * A given kernel subsystem (event_data_source) may send
> + * data (buf) to be measured when the data or the subsystem state changes.
> + * The state/data change can be described by event_name.
> + * Examples of critical data (buf) could be kernel in-memory r/o structures,
> + * hash of the memory structures, or data that represents subsystem
> + * state change.
> + * measure_buf_hash can be used to save space, if the data being measured
> + * is too large.
> + * The data (buf) can only be measured, not appraised.
> + */

Please remove this longer function description, replacing it something
more appropriate.  The subsequent patch that introduces the "data
source" parameter would expand the description.

thanks,

Mimi

> +void ima_measure_critical_data(const char *event_data_source,
> +			       const char *event_name,
> +			       const void *buf, int buf_len,
> +			       bool measure_buf_hash)
> +{
> +	if (!event_name || !event_data_source || !buf || !buf_len) {
> +		pr_err("Invalid arguments passed to %s().\n", __func__);
> +		return;
> +	}
> +
> +	process_buffer_measurement(NULL, buf, buf_len, event_name,
> +				   CRITICAL_DATA, 0, event_data_source,
> +				   measure_buf_hash);
> +}
> +
>  static int __init init_ima(void)
>  {
>  	int error;

