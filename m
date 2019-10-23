Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85E90E1C49
	for <lists+linux-integrity@lfdr.de>; Wed, 23 Oct 2019 15:21:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732484AbfJWNVf (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 23 Oct 2019 09:21:35 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35278 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2405607AbfJWNVe (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 23 Oct 2019 09:21:34 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9NDKtlX082093
        for <linux-integrity@vger.kernel.org>; Wed, 23 Oct 2019 09:21:33 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vtnj15n6a-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 23 Oct 2019 09:21:33 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Wed, 23 Oct 2019 14:21:30 +0100
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 23 Oct 2019 14:21:27 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x9NDKrEH20054288
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Oct 2019 13:20:53 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 29B6911C05B;
        Wed, 23 Oct 2019 13:21:26 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EE5F111C050;
        Wed, 23 Oct 2019 13:21:24 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.184.174])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 23 Oct 2019 13:21:24 +0000 (GMT)
Subject: Re: [PATCH v1 2/6] KEYS: ima: Refactored process_buffer_measurement
 function so that it can measure any buffer (and not just KEXEC_CMDLINE one)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        dhowells@redhat.com, casey@schaufler-ca.com, sashal@kernel.org,
        jamorris@linux.microsoft.com,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        keyrings@vger.kernel.org
Date:   Wed, 23 Oct 2019 09:21:24 -0400
In-Reply-To: <20191023001818.3684-3-nramas@linux.microsoft.com>
References: <20191023001818.3684-1-nramas@linux.microsoft.com>
         <20191023001818.3684-3-nramas@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19102313-4275-0000-0000-000003762A74
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19102313-4276-0000-0000-0000388951C0
Message-Id: <1571836884.5104.94.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-23_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910230136
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2019-10-22 at 17:18 -0700, Lakshmi Ramasubramanian wrote:

> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index 584019728660..8e965d18fb21 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -610,14 +610,14 @@ int ima_load_data(enum kernel_load_data_id id)
>   * @buf: pointer to the buffer that needs to be added to the log.
>   * @size: size of buffer(in bytes).
>   * @eventname: event name to be used for the buffer entry.
> - * @cred: a pointer to a credentials structure for user validation.
> - * @secid: the secid of the task to be validated.
> + * @pcr: pcr to extend the measurement
> + * @template_desc: template description
>   *
>   * Based on policy, the buffer is measured into the ima log.
>   */
> -static void process_buffer_measurement(const void *buf, int size,
> -				       const char *eventname,
> -				       const struct cred *cred, u32 secid)
> +void process_buffer_measurement(const void *buf, int size,
> +				const char *eventname, int pcr,
> +				struct ima_template_desc *template_desc)
>  {
>  	int ret = 0;
>  	struct ima_template_entry *entry = NULL;
> @@ -626,19 +626,11 @@ static void process_buffer_measurement(const void *buf, int size,
>  					    .filename = eventname,
>  					    .buf = buf,
>  					    .buf_len = size};
> -	struct ima_template_desc *template_desc = NULL;
>  	struct {
>  		struct ima_digest_data hdr;
>  		char digest[IMA_MAX_DIGEST_SIZE];
>  	} hash = {};
>  	int violation = 0;
> -	int pcr = CONFIG_IMA_MEASURE_PCR_IDX;
> -	int action = 0;
> -
> -	action = ima_get_action(NULL, cred, secid, 0, KEXEC_CMDLINE, &pcr,
> -				&template_desc);
> -	if (!(action & IMA_MEASURE))
> -		return;
>  
>  	iint.ima_hash = &hash.hdr;
>  	iint.ima_hash->algo = ima_hash_algo;


This patch is based on Nayna's version of this change, without any
acknowledgment.  Moving this code out of process_buffer_measurement is
going to result in code duplication.  Nayna has posted a newer version
of this patch without the code duplication.  As soon as she posts the
patch with an updated patch description, I plan on picking up that
version.

Mimi


> @@ -670,12 +662,19 @@ static void process_buffer_measurement(const void *buf, int size,
>   */
>  void ima_kexec_cmdline(const void *buf, int size)
>  {
> +	int pcr = CONFIG_IMA_MEASURE_PCR_IDX;
> +	struct ima_template_desc *template_desc = ima_template_desc_current();
> +	int action;
>  	u32 secid;
>  
>  	if (buf && size != 0) {
>  		security_task_getsecid(current, &secid);
> -		process_buffer_measurement(buf, size, "kexec-cmdline",
> -					   current_cred(), secid);
> +		action = ima_get_action(NULL, current_cred(), secid, 0,
> +					KEXEC_CMDLINE, &pcr, &template_desc);
> +		if (!(action & IMA_MEASURE))
> +			return;
> +		process_buffer_measurement(buf, size, "kexec-cmdline", pcr,
> +					   template_desc);
>  	}
>  }
>  

