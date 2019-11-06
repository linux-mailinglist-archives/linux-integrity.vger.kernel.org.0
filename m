Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F114F220A
	for <lists+linux-integrity@lfdr.de>; Wed,  6 Nov 2019 23:45:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727626AbfKFWpG (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 6 Nov 2019 17:45:06 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:20716 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726912AbfKFWpG (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 6 Nov 2019 17:45:06 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xA6MggJq073572
        for <linux-integrity@vger.kernel.org>; Wed, 6 Nov 2019 17:45:05 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2w44wjcmy0-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 06 Nov 2019 17:45:05 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Wed, 6 Nov 2019 22:45:02 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 6 Nov 2019 22:45:00 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xA6MixhP55640138
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 6 Nov 2019 22:44:59 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4F376A4076;
        Wed,  6 Nov 2019 22:44:59 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 55B85A406F;
        Wed,  6 Nov 2019 22:44:58 +0000 (GMT)
Received: from dhcp-9-31-102-173.watson.ibm.com (unknown [9.31.102.173])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  6 Nov 2019 22:44:58 +0000 (GMT)
Subject: Re: [PATCH v4 01/10] IMA: Defined an IMA hook to measure keys on
 key create or update
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        dhowells@redhat.com, matthewgarrett@google.com, sashal@kernel.org,
        jamorris@linux.microsoft.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20191106190116.2578-2-nramas@linux.microsoft.com>
References: <20191106190116.2578-1-nramas@linux.microsoft.com>
         <20191106190116.2578-2-nramas@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Date:   Wed, 06 Nov 2019 17:43:09 -0500
Mime-Version: 1.0
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19110622-0012-0000-0000-000003615CB7
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19110622-0013-0000-0000-0000219CBB65
Message-Id: <1573080189.5028.313.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-11-06_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1910280000 definitions=main-1911060218
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2019-11-06 at 11:01 -0800, Lakshmi Ramasubramanian wrote:
> Asymmetric keys used for verifying file signatures or certificates
> are currently not included in the IMA measurement list.
> 
> This patch defines a new IMA hook namely ima_post_key_create_or_update()
> to measure asymmetric keys.
> 
> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> ---
>  security/integrity/ima/ima_main.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index d7e987baf127..a0e233afe876 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -721,6 +721,22 @@ void ima_kexec_cmdline(const void *buf, int size)
>  					   KEXEC_CMDLINE, 0);
>  }
>  
> +/**
> + * ima_post_key_create_or_update - measure asymmetric keys
> + * @keyring: keyring to which the key is linked to
> + * @key: created or updated key
> + * @flags: key flags
> + * @create: flag indicating whether the key was created or updated
> + *
> + * Keys can only be measured, not appraised.
> + */
> +void ima_post_key_create_or_update(struct key *keyring, struct key *key,
> +				   unsigned long flags, bool create)
> +{
> +	if ((keyring != NULL) && (key != NULL))
> +		return;

I would move the patch that defines the "keyring=" policy option prior
to this one.  Include the call to process_buffer_measurement() in this
patch.  A subsequent patch would add support to defer measuring the
key, by calling a function named something like
ima_queue_key_measurement().

Mimi

> +}
> +
>  static int __init init_ima(void)
>  {
>  	int error;

