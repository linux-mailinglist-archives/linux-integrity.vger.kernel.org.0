Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4E5F4C168
	for <lists+linux-integrity@lfdr.de>; Wed, 19 Jun 2019 21:21:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbfFSTVt (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 19 Jun 2019 15:21:49 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46184 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729988AbfFSTVs (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 19 Jun 2019 15:21:48 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5JJH7El058671
        for <linux-integrity@vger.kernel.org>; Wed, 19 Jun 2019 15:21:47 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2t7rq4xvky-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 19 Jun 2019 15:21:47 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Wed, 19 Jun 2019 20:21:45 +0100
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 19 Jun 2019 20:21:42 +0100
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5JJLXqn35324182
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jun 2019 19:21:33 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5C01342056;
        Wed, 19 Jun 2019 19:21:41 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B271142042;
        Wed, 19 Jun 2019 19:21:40 +0000 (GMT)
Received: from dhcp-9-31-103-88.watson.ibm.com (unknown [9.31.103.88])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 19 Jun 2019 19:21:40 +0000 (GMT)
Subject: Re: [PATCH 1/3] IMA:Define a new hook to measure the kexec boot
 command line arguments
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Prakhar Srivastava <prsriva02@gmail.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     roberto.sassu@huawei.com
Date:   Wed, 19 Jun 2019 15:21:40 -0400
In-Reply-To: <20190617183507.14160-2-prsriva02@gmail.com>
References: <20190617183507.14160-1-prsriva02@gmail.com>
         <20190617183507.14160-2-prsriva02@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19061919-0012-0000-0000-0000032AA63D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19061919-0013-0000-0000-00002163C8AE
Message-Id: <1560972100.3975.72.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-19_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=11 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906190158
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2019-06-17 at 11:35 -0700, Prakhar Srivastava wrote:
> Currently during soft reboot(kexec_file_load) boot command line
> arguments are not measured. Define hooks needed to measure kexec
> command line arguments during soft reboot(kexec_file_load).
> 
> - A new ima hook ima_kexec_cmdline is defined to be called by the
> kexec code.
> - A new function process_buffer_measurement is defined to measure
> the buffer hash into the IMA measurement list.
> - A new func policy KEXEC_CMDLINE is defined to control the
>  measurement.[Suggested by Mimi]
> 
> Signed-off-by: Prakhar Srivastava <prsriva02@gmail.com>

With minor changes below, 
     Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

> ---

> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index af341a80118f..1e233417a7af 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -605,6 +605,80 @@ int ima_load_data(enum kernel_load_data_id id)
>  	return 0;
>  }
>  
> +/*
> + * process_buffer_measurement - Measure the buffer to ima log.
> + * @buf: pointer to the buffer that needs to be added to the log.
> + * @size: size of buffer(in bytes).
> + * @eventname: event name to be used for the buffer entry.
> + * @cred: a pointer to a credentials structure for user validation.
> + * @secid: the secid of the task to be validated.
> + *
> + * Based on policy, the buffer is measured into the ima log.
> + */
> +static void process_buffer_measurement(const void *buf, int size,
> +				       const char *eventname,
> +				       const struct cred *cred, u32 secid)
> +{
> +	int ret = 0;
> +	struct ima_template_entry *entry = NULL;
> +	struct integrity_iint_cache iint = {};
> +	struct ima_event_data event_data = {.iint = &iint };
> +	struct ima_template_desc *template_desc = NULL;
> +	struct {
> +		struct ima_digest_data hdr;
> +		char digest[IMA_MAX_DIGEST_SIZE];
> +	} hash = {};
> +	int violation = 0;
> +	int pcr = CONFIG_IMA_MEASURE_PCR_IDX;
> +	int action = 0;
> +
> +	action = ima_get_action(NULL, cred, secid, 0, KEXEC_CMDLINE, &pcr,
> +				&template_desc);
> +	if (!(action & IMA_MEASURE))
> +		goto out;

"out:" is a simple return, no freeing memory.  Just return here.

> +
> +	event_data.filename = eventname;

No need to initialize even_data.filename, here initialize it when it
is defined.

> +
> +	iint.ima_hash = &hash.hdr;
> +	iint.ima_hash->algo = ima_hash_algo;
> +	iint.ima_hash->length = hash_digest_size[ima_hash_algo];
> +
> +	ret = ima_calc_buffer_hash(buf, size, iint.ima_hash);
> +	if (ret < 0)
> +		goto out;
> +
> +	ret = ima_alloc_init_template(&event_data, &entry, template_desc);
> +	if (ret < 0)
> +		goto out;
> +
> +	if (action & IMA_MEASURE)

Why is this test needed again?

Mimi

> +		ret = ima_store_template(entry, violation, NULL, buf, pcr);
> +
> +	if (ret < 0)
> +		ima_free_template_entry(entry);
> +
> +out:
> +	return;
> +}
> +
> +/**
> + * ima_kexec_cmdline - measure kexec cmdline boot args
> + * @buf: pointer to buffer
> + * @size: size of buffer
> + *
> + * Buffers can only be measured, not appraised.
> + */
> +void ima_kexec_cmdline(const void *buf, int size)
> +{
> +	u32 secid;
> +
> +	if (buf && size != 0) {
> +		security_task_getsecid(current, &secid);
> +		process_buffer_measurement(buf, size, "kexec-cmdline",
> +					   current_cred(), secid);
> +	}
> +}
> +
>  static int __init init_ima(void)
>  {
>  	int error;
> 

