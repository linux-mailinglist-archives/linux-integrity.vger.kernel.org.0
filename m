Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2646B4BC71
	for <lists+linux-integrity@lfdr.de>; Wed, 19 Jun 2019 17:08:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730278AbfFSPHV (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 19 Jun 2019 11:07:21 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60786 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729803AbfFSPHV (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 19 Jun 2019 11:07:21 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5JF3ES4103270
        for <linux-integrity@vger.kernel.org>; Wed, 19 Jun 2019 11:07:19 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2t7p0057au-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 19 Jun 2019 11:07:19 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Wed, 19 Jun 2019 16:07:17 +0100
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 19 Jun 2019 16:07:15 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5JF7E0l34537948
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jun 2019 15:07:14 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 846BE52052;
        Wed, 19 Jun 2019 15:07:14 +0000 (GMT)
Received: from dhcp-9-31-103-88.watson.ibm.com (unknown [9.31.103.88])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id E0C7E52050;
        Wed, 19 Jun 2019 15:07:13 +0000 (GMT)
Subject: Re: [PATCH 2/3] IMA:Define a new template field buf
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Prakhar Srivastava <prsriva02@gmail.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     roberto.sassu@huawei.com
In-Reply-To: <20190617183507.14160-3-prsriva02@gmail.com>
References: <20190617183507.14160-1-prsriva02@gmail.com>
         <20190617183507.14160-3-prsriva02@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date:   Wed, 19 Jun 2019 09:54:26 -0400
Mime-Version: 1.0
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19061915-0028-0000-0000-0000037BB7E0
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19061915-0029-0000-0000-0000243BC627
Message-Id: <1560952466.3975.40.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-19_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906190122
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2019-06-17 at 11:35 -0700, Prakhar Srivastava wrote:
> A buffer(kexec boot command line arguments) measured into IMA
> measuremnt list cannot be appraised, without already being
> aware of the buffer contents. Since hashes are non-reversible,
> raw buffer is needed for validation or regenerating hash for
> appraisal/attestation.
> 
> Add support to store/read the buffer contents in HEX.
> The kexec cmdline hash is stored in the "d-ng" field of the
> template data,it can be verified using
> sudo cat /sys/kernel/security/integrity/ima/ascii_runtime_measurements |
>   grep  kexec-cmdline | cut -d' ' -f 6 | xxd -r -p | sha256sum
> 
> - Add two new fields to ima_event_data to hold the buf and
> buf_len [Suggested by Roberto]
> - Add a new temaplte field 'buf' to be used to store/read
> the buffer data.[Suggested by Mimi]
> - Updated process_buffer_meaurement to add the buffer to
> ima_event_data. process_buffer_measurement added in
> "Define a new IMA hook to measure the boot command line
>  arguments"
> - Add a new template policy name ima-buf to represent
> 'd-ng|n-ng|buf'
> 
> Signed-off-by: Prakhar Srivastava <prsriva02@gmail.com>
> Reviewed-by: Roberto Sassu <roberto.sassu@huawei.com>
> Reviewed-by: James Morris <jamorris@linux.microsoft.com>

Thanks, looking much better.

>  
>  /* IMA template field data definition */
> diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
> index ea7d8cbf712f..83ca99d65e4b 100644
> --- a/security/integrity/ima/ima_api.c
> +++ b/security/integrity/ima/ima_api.c
> @@ -140,7 +140,7 @@ void ima_add_violation(struct file *file, const unsigned char *filename,
>  	struct ima_template_entry *entry;
>  	struct inode *inode = file_inode(file);
>  	struct ima_event_data event_data = {iint, file, filename, NULL, 0,
> -					    cause};
> +					    cause, NULL, 0};
>  	int violation = 1;
>  	int result;
>  
> @@ -296,7 +296,7 @@ void ima_store_measurement(struct integrity_iint_cache *iint,
>  	struct inode *inode = file_inode(file);
>  	struct ima_template_entry *entry;
>  	struct ima_event_data event_data = {iint, file, filename, xattr_value,
> -					    xattr_len, NULL};
> +					    xattr_len, NULL, NULL, 0};
>  	int violation = 0;
>  
>  	if (iint->measured_pcrs & (0x1 << pcr))
> diff --git a/security/integrity/ima/ima_init.c b/security/integrity/ima/ima_init.c
> index 993d0f1915ff..c8591406c0e2 100644
> --- a/security/integrity/ima/ima_init.c
> +++ b/security/integrity/ima/ima_init.c
> @@ -50,7 +50,7 @@ static int __init ima_add_boot_aggregate(void)
>  	struct ima_template_entry *entry;
>  	struct integrity_iint_cache tmp_iint, *iint = &tmp_iint;
>  	struct ima_event_data event_data = {iint, NULL, boot_aggregate_name,
> -					    NULL, 0, NULL};
> +					    NULL, 0, NULL, NULL, 0};
>  	int result = -ENOMEM;
>  	int violation = 0;
>  	struct {
> 

These changes shouldn't be necessary.  Please rebase these patches on
top of the latest next-queued-testing branch (git remote update).  "IMA: support for per
policy rule template formats" is still changing. 

Minor nit.  When re-posting the patches please update the patch titles
so that there is a space between the subsystem name and the patch
title (eg. "ima: define ...").

Mimi

