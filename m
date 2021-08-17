Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D11A3EF109
	for <lists+linux-integrity@lfdr.de>; Tue, 17 Aug 2021 19:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbhHQRqN (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 17 Aug 2021 13:46:13 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:32078 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229969AbhHQRqM (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 17 Aug 2021 13:46:12 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17HHWser186611;
        Tue, 17 Aug 2021 13:45:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=VLl0Gthmr04hgten00R1199j5jj2EekqYfsQ+PhLTlk=;
 b=aH8FtdreJTntbzBbTgPQxvsvpGHQ5w8He9iLDVGUGeuqHu4YazfS1qcLVckwpTrQowat
 OTvgcxSgUgC81nQQ1sCAZHmS8YZDI6aLLMhRyIBkAh7gi/LLIevG2FbSFdBFVZx17yMo
 1qplO6dmxGCBbguQytkXmTpb0p4S4utZXkzgo/J4Azp4puMEt/EVpDE4Us5zgcbkUXnu
 n13o7XwJfLymqQEi1bDMtkj4l9Rg2MDEHcsCwYpbkUzYQaAew/kOeP91nc/PcijxIhTd
 o2iKfw+J2eeP1r75BgbcAk0kFzHohWBQpXEGz/AtDcidnG5NQpQCUDIr++kluYeI9lBZ oA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3agg09b07c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Aug 2021 13:45:35 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 17HHY665001013;
        Tue, 17 Aug 2021 13:45:35 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3agg09b06j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Aug 2021 13:45:34 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 17HHgRHH014255;
        Tue, 17 Aug 2021 17:45:32 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03fra.de.ibm.com with ESMTP id 3agh2xg18d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Aug 2021 17:45:32 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 17HHg4tV45613330
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Aug 2021 17:42:04 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3447A11C05C;
        Tue, 17 Aug 2021 17:45:30 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5DC4D11C04A;
        Tue, 17 Aug 2021 17:45:29 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.53.55])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 17 Aug 2021 17:45:29 +0000 (GMT)
Message-ID: <94c4f4c6544035b0114c4fd4bcfabae1551b6304.camel@linux.ibm.com>
Subject: Re: [PATCH 1/1] ima: check control characters in policy file path
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Tianxing Zhang <anakinzhang96@gmail.com>
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 17 Aug 2021 13:45:28 -0400
In-Reply-To: <20210814082723.261-1-anakinzhang96@gmail.com>
References: <20210814082723.261-1-anakinzhang96@gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: TOOazUodMJFQxtWkUjUIfdqL7Toa-N8x
X-Proofpoint-GUID: NP3ER4pbxnYSw1lrRT2jokiZjyekm9xw
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-17_06:2021-08-17,2021-08-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 adultscore=0 mlxlogscore=999 phishscore=0 impostorscore=0 malwarescore=0
 priorityscore=1501 clxscore=1015 spamscore=0 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108170109
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sat, 2021-08-14 at 16:27 +0800, Tianxing Zhang wrote:
> When a policy file path contains control characters like '\r' or '\b',
> invalid error messages can be printed to overwrite system messages:
> 
> $ echo -e "/\rtest 12345678" > /sys/kernel/security/ima/policy
> 
> This patch rejects policy paths with control characters.
> 
> Signed-off-by: Tianxing Zhang <anakinzhang96@gmail.com>
> ---
>  security/integrity/ima/ima_fs.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
> index 3d8e9d5db5aa..e6daa138de89 100644
> --- a/security/integrity/ima/ima_fs.c
> +++ b/security/integrity/ima/ima_fs.c
> @@ -316,6 +316,7 @@ static ssize_t ima_write_policy(struct file *file, const char __user *buf,
>  {
>  	char *data;
>  	ssize_t result;
> +	int i;
>  
>  	if (datalen >= PAGE_SIZE)
>  		datalen = PAGE_SIZE - 1;
> @@ -331,6 +332,14 @@ static ssize_t ima_write_policy(struct file *file, const char __user *buf,
>  		goto out;
>  	}
>  
> +	for (i = 0; data[i] != '\n' && data[i] != '\0'; i++) {
> +		if (iscntrl(data[i])) {
> +			pr_err_once("file path with no control characters required\n");
> +			result = -EINVAL;
> +			goto out_free;
> +		}
> +	}
> +
>  	result = mutex_lock_interruptible(&ima_write_mutex);
>  	if (result < 0)
>  		goto out_free;

The IMA audit messages already display pathnames via
audit_log_untrustedstring().  Shouldn't any change be limited to the
ima_policy_read() code path?

thanks,

Mimi

