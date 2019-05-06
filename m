Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05A761495F
	for <lists+linux-integrity@lfdr.de>; Mon,  6 May 2019 14:13:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbfEFMNh (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 6 May 2019 08:13:37 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56598 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726128AbfEFMNh (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 6 May 2019 08:13:37 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x46C2PcC004095
        for <linux-integrity@vger.kernel.org>; Mon, 6 May 2019 08:13:37 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2samgerpa6-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 06 May 2019 08:13:36 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Mon, 6 May 2019 13:13:34 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 6 May 2019 13:13:30 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x46CDTbh57933890
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 May 2019 12:13:29 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2D4395204F;
        Mon,  6 May 2019 12:13:29 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.95.145])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 16FAF5205A;
        Mon,  6 May 2019 12:13:27 +0000 (GMT)
Subject: Re: [PATCH 1/5 v4] added a new ima policy func buffer_check, and
 ima hook to measure the buffer hash into ima
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Prakhar Srivastava <prsriva02@gmail.com>,
        linux-integrity@vger.kernel.org,
        linux-secuirty-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     ebiederm@xmission.com, vgoyal@redhat.com, nayna@linux.ibm.com,
        nramas@microsoft.com, prsriva@microsoft.com
Date:   Mon, 06 May 2019 08:13:17 -0400
In-Reply-To: <20190503222523.6294-2-prsriva02@gmail.com>
References: <20190503222523.6294-1-prsriva02@gmail.com>
         <20190503222523.6294-2-prsriva02@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19050612-0028-0000-0000-0000036AD0E2
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19050612-0029-0000-0000-0000242A458D
Message-Id: <1557144797.14288.93.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-06_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905060107
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2019-05-03 at 15:25 -0700, Prakhar Srivastava wrote:
> From: Prakhar Srivastava <prsriva02@gmail.com>
> 
> This change adds a new ima policy func buffer_check, and ima hook to
>  measure the buffer hash into ima log.

This patch description says "what" you're during without the
motivation.  Please write an appropriate patch description, starting
with some background information.  Refer to section "2) Describe your
changes" of Documentation/process/submitting-patches.rst.

<snip>

> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index 357edd140c09..3db3f3966ac7 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -576,6 +576,95 @@ int ima_load_data(enum kernel_load_data_id id)
>  	return 0;
>  }
>  
> +/*
> + * process_buffer_measurement - Measure the buffer passed to ima log.
> + * (Instead of using the file hash the buffer hash is used).
> + * @buff - The buffer that needs to be added to the log

"buf" with a single 'f' is the commonly used variable name.

> + * @size - size of buffer(in bytes)
> + * @eventname - this is eventname used for the various buffers
> + * that can be measured.

This patch set introduces measuring the boot command line.  There
aren't any other buffers being measured.  Please remove the reference
to other buffers.

> + *
> + * The buffer passed is added to the ima logs.
> + * If the sig template is used, then the sig field contains the buffer.

It doesn't look like this particular patch adds the boot command line
string to the measurement list sig field.  Please remove this comment.

I've previously said you can't overload the sig field for storing the
boot command line string.  Please define a new template field.

> + *
> + * On success return 0.
> + * On error cases surface errors from ima calls.
> + */
> +static int process_buffer_measurement(const void *buff, int size,
> +				const char *eventname, const struct cred *cred,
> +				u32 secid)
> +{
> +	int ret = -EINVAL;
> +	struct ima_template_entry *entry = NULL;
> +	struct integrity_iint_cache tmp_iint, *iint = &tmp_iint;
> +	struct ima_event_data event_data = {iint, NULL, NULL,
> +					    NULL, 0, NULL};
> +	struct {
> +		struct ima_digest_data hdr;
> +		char digest[IMA_MAX_DIGEST_SIZE];
> +	} hash;
> +	int violation = 0;
> +	int pcr = CONFIG_IMA_MEASURE_PCR_IDX;
> +
> +	if (!buff || size ==  0 || !eventname)
> +		goto err_out;

There is only one caller to this function.  This can never happen.
 Please remove this test.

> +
> +	if (ima_get_action(NULL, cred, secid, 0, BUFFER_CHECK, &pcr)
> +		!= IMA_MEASURE)
> +		goto err_out;

The IMA policy defines what should and shouldn't be measured.  Not
having a rule to measure the boot command line can not be considered
an error.

> +
> +	memset(iint, 0, sizeof(*iint));
> +	memset(&hash, 0, sizeof(hash));
> +
> +	event_data.filename = eventname;
> +
> +	iint->ima_hash = &hash.hdr;
> +	iint->ima_hash->algo = ima_hash_algo;
> +	iint->ima_hash->length = hash_digest_size[ima_hash_algo];
> +
> +	ret = ima_calc_buffer_hash(buff, size, iint->ima_hash);
> +	if (ret < 0)
> +		goto err_out;
> +
> +	ret = ima_alloc_init_template(&event_data, &entry);
> +	if (ret < 0)
> +		goto err_out;
> +
> +	ret = ima_store_template(entry, violation, NULL,
> +					buff, pcr);
> +	if (ret < 0) {
> +		ima_free_template_entry(entry);
> +		goto err_out;
> +	}
> +
> +	return 0;
> +
> +err_out:
> +	pr_err("Error in adding buffer measure: %d\n", ret);
> +	return ret;

Please remove.


> +}
> +
> +/**
> + * ima_buffer_check - based on policy, collect & store buffer measurement
> + * @buf: pointer to buffer
> + * @size: size of buffer
> + * @eventname: event name identifier
> + *
> + * Buffers can only be measured, not appraised.  The buffer identifier
> + * is used as the measurement list entry name (eg. boot_cmdline).
> + */
> +void ima_buffer_check(const void *buf, int size, const char *eventname)
> +{
> +	u32 secid;
> +
> +	if (buf && size != 0 && eventname) {
> +		security_task_getsecid(current, &secid);
> +		process_buffer_measurement(buf, size, eventname,
> +				current_cred(), secid);
> +	}
> +}
> +
> +
>  static int __init init_ima(void)
>  {
>  	int error;
> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> index e0cc323f948f..b12551ed191c 100644
> --- a/security/integrity/ima/ima_policy.c
> +++ b/security/integrity/ima/ima_policy.c
> @@ -291,6 +291,12 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
>  {
>  	int i;
>  
> +	// Incase of BUFFER_CHECK, Inode is NULL

Comments use the /* ... */ syntax.  Please refer to section "8)
Commenting" of Documentation/process/coding-style.rst.

Mimi

> +	if (!inode) {
> +		if ((rule->flags & IMA_FUNC) && (rule->func == func))
> +			return true;
> +		return false;
> +	}
>  	if ((rule->flags & IMA_FUNC) &&
>  	    (rule->func != func && func != POST_SETATTR))
>  		return false;

