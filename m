Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1EB429A6B
	for <lists+linux-integrity@lfdr.de>; Fri, 24 May 2019 16:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404054AbfEXO5P (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 24 May 2019 10:57:15 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37322 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2403934AbfEXO5P (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 24 May 2019 10:57:15 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4OEkvea135103
        for <linux-integrity@vger.kernel.org>; Fri, 24 May 2019 10:57:14 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2spfj7a9jq-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 24 May 2019 10:57:13 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Fri, 24 May 2019 15:57:12 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 24 May 2019 15:57:08 +0100
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4OEv76r22478954
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 May 2019 14:57:07 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B26D842041;
        Fri, 24 May 2019 14:57:07 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 44B1C42047;
        Fri, 24 May 2019 14:57:06 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.111.39])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 24 May 2019 14:57:06 +0000 (GMT)
Subject: Re: [PATCH v6 1/3] Add a new ima hook ima_kexec_cmdline to measure
 cmdline args
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Prakhar Srivastava <prsriva02@gmail.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     mjg59@google.com, roberto.sassu@huawei.com, vgoyal@redhat.com
Date:   Fri, 24 May 2019 10:56:55 -0400
In-Reply-To: <20190521000645.16227-2-prsriva02@gmail.com>
References: <20190521000645.16227-1-prsriva02@gmail.com>
         <20190521000645.16227-2-prsriva02@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19052414-0016-0000-0000-0000027F1275
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19052414-0017-0000-0000-000032DC0F9A
Message-Id: <1558709815.3977.56.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-24_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905240099
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Prakhar,

On Mon, 2019-05-20 at 17:06 -0700, Prakhar Srivastava wrote:
> Currently during kexec_file_load(soft reboot) the cmdline args
> passed are not measured and the PCR values are not reset.

This patch addresses not measuring the kexec boot cmdline.  I don't
see a reason for mentioning anything about the PCR values not being
reset.  Keep it simple.

> This results in the new kernel to assume a secure boot was
> followed. The boot args used to launch the new kernel need to be
> measured and carried over to the next kernel to be used for
> attestation. IMA supports only measuring files, no functionality
> exists to measure a buffer(kexec cmdline).
> 
> This change adds a new functionality to measure buffers
> process_buffer_measurement which uses the hash of the buffer
> instead of file hash to add an entry in the ima log.
> A new ima hook ima_kexec_cmdline is also defined which calls
> into process_buffer_measurement to add the kexec_cmdline args
> to the log.
> 
> A new policy KEXEC_CMDLINE is also defined to control measuring the
> kexec_cmdline buffer.
> This patch only adds IMA_MEASURE as a supported functionality.
> 
> - A new ima hook ima_kexec_cmdline is defined to be called by the
> kexec code.
> - A new function process_buffer_measurement is defined to measure
> the buffer hash into the ima log.
> - A new func policy KEXEC_CMDLINE is defined to control the measurement.

Missing is how to verify the digest of the measurement list kexec boot
cmdline entry based on /proc/cmdline.  Everything before the "root="
in the /proc entry needs to be removed before calculating the hash.
 Please include a sample shell command.

Matthew's patch "IMA: Allow profiles to define the desired IMA
template" will require changes to this patch.  Please rebase this
patch set on top of it, once Matthew addresses the comments and re-
posts.

(Reminder: the patch description should be 70 - 75 characters.)

> 
> Signed-off-by: Prakhar Srivastava <prsriva02@gmail.com>
> ---

< snip >

> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -576,6 +576,83 @@ int ima_load_data(enum kernel_load_data_id id)
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
> +				const char *eventname, const struct cred *cred,
> +				u32 secid)
> +{
> +	int ret = 0;
> +	struct ima_template_entry *entry = NULL;
> +	struct integrity_iint_cache tmp_iint, *iint = &tmp_iint;
> +	struct ima_event_data event_data = {iint, NULL, NULL,
> +						NULL, 0, NULL};

Thiago's clean up patch initializes only specific variables, as
needed.  Please initialize event_data like:

struct ima_event_data event_data = {.iint = iint};


> +	struct {
> +		struct ima_digest_data hdr;
> +		char digest[IMA_MAX_DIGEST_SIZE];
> +	} hash;
> +	int violation = 0;
> +	int pcr = CONFIG_IMA_MEASURE_PCR_IDX;
> +	int action = 0;
> +
> +	action = ima_get_action(NULL, cred, secid, 0, KEXEC_CMDLINE, &pcr);
> +	if (!(action & IMA_MEASURE))
> +		goto out;
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
> +	ret = ima_calc_buffer_hash(buf, size, iint->ima_hash);
> +	if (ret < 0)
> +		goto out;
> +
> +	ret = ima_alloc_init_template(&event_data, &entry);
> +	if (ret < 0)
> +		goto out;
> +
> +	if (action & IMA_MEASURE)
> +		ret = ima_store_template(entry, violation, NULL, buf, pcr);
> +
> +	if (ret < 0) {
> +		ima_free_template_entry(entry);
> +	}

Remove brackets.

Mimi

> +
> +out:
> +	return;
> +}

