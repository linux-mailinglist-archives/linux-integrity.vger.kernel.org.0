Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 952471BB64
	for <lists+linux-integrity@lfdr.de>; Mon, 13 May 2019 18:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731062AbfEMQ4w (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 13 May 2019 12:56:52 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38558 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727774AbfEMQ4w (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 13 May 2019 12:56:52 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4DGku8d129992
        for <linux-integrity@vger.kernel.org>; Mon, 13 May 2019 12:56:51 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2sfb42kqep-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 13 May 2019 12:56:51 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Mon, 13 May 2019 17:56:49 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 13 May 2019 17:56:45 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4DGui5S42074262
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 May 2019 16:56:44 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 98D054C052;
        Mon, 13 May 2019 16:56:44 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 854D54C040;
        Mon, 13 May 2019 16:56:43 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.110.120])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 13 May 2019 16:56:43 +0000 (GMT)
Subject: Re: [PATCH 1/3 v5] add a new ima hook and policy to measure the
 cmdline
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Prakhar Srivastava <prsriva02@gmail.com>,
        linux-integrity@vger.kernel.org,
        inux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     ebiederm@xmission.com, vgoyal@redhat.com, prsriva@microsoft.com
Date:   Mon, 13 May 2019 12:56:32 -0400
In-Reply-To: <20190510223744.10154-2-prsriva02@gmail.com>
References: <20190510223744.10154-1-prsriva02@gmail.com>
         <20190510223744.10154-2-prsriva02@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19051316-0028-0000-0000-0000036D385A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19051316-0029-0000-0000-0000242CC66F
Message-Id: <1557766592.4969.22.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-13_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905130115
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2019-05-10 at 15:37 -0700, Prakhar Srivastava wrote:

> +/*
> + * process_buffer_measurement - Measure the buffer passed to ima log.

"passed to ima log" is unnecessary.

> + * (Instead of using the file hash use the buffer hash).

This comment, if needed, belongs in the text description area below,
not here.

> + * @buf - The buffer that needs to be added to the log
> + * @size - size of buffer(in bytes)
> + * @eventname - event name to be used for buffer.

Missing are the other fields.

> + *
> + * The buffer passed is added to the ima log.
> + *
> + * On success return 0.
> + * On error cases surface errors from ima calls.

Only IMA-appraise returns errors to the caller.  There's no point in
returning an error.


> + */
> +static int process_buffer_measurement(const void *buf, int size,
> +				const char *eventname, const struct cred *cred,
> +				u32 secid)

This should be "static void".

> +{
> +	int ret = 0;
> +	struct ima_template_entry *entry = NULL;
> +	struct integrity_iint_cache tmp_iint, *iint = &tmp_iint;
> +	struct ima_event_data event_data = {iint, NULL, NULL,
> +						NULL, 0, NULL};
> +	struct {
> +		struct ima_digest_data hdr;
> +		char digest[IMA_MAX_DIGEST_SIZE];
> +	} hash;
> +	int violation = 0;
> +	int pcr = CONFIG_IMA_MEASURE_PCR_IDX;
> +	int action = 0;
> +
> +	action = ima_get_action(NULL, cred, secid, 0, KEXEC_CMDLINE, &pcr);
> +	if (!(action & IMA_AUDIT) && !(action & IMA_MEASURE))
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
> +	if (action & IMA_AUDIT)
> +		ima_audit_measurement(iint, event_data.filename);

The cover letter and patch description say this patch set is limited
to measuring the boot command line - IMA-measurement.
 ima_audit_measurement() adds file hashes in the audit log, which can
be used for security analytics and/or forensics.  This is part of IMA-
audit.  The call to ima_audit_measurement() is inappropriate.

Mimi


> +
> +	if (ret < 0) {
> +		ima_free_template_entry(entry);
> +		goto out;
> +	}
> +
> +out:
> +	return ret;
> +}
> +

