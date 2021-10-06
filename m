Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 529DB424A72
	for <lists+linux-integrity@lfdr.de>; Thu,  7 Oct 2021 01:18:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbhJFXUj (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 6 Oct 2021 19:20:39 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37200 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229809AbhJFXUi (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 6 Oct 2021 19:20:38 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 196LagGY024664
        for <linux-integrity@vger.kernel.org>; Wed, 6 Oct 2021 19:18:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : date : in-reply-to : references : content-type : mime-version
 : content-transfer-encoding; s=pp1;
 bh=7qR78S79BEWxtIDZ1lsKNp6S6JRHflLSiYZS4dS3t+U=;
 b=NilA4o0OTlJ6ZQipemCdZzagHOOyDparamYvt2OyK09rL+9EHQmQOCGxQLIexsgqUHGP
 hmWiHrmiZhTsAxx3Yj3PQbTwew/Ge+FkXETgLHa+K6vbBMMOknyeDX1kNZM0qVbeI67i
 EAGlN6fQCO56k0fivNZ3nXZPUjyjpkMrKB7VQeha0j+BJZAd1gwcsdTTCfWZzxVjGclL
 fL2Wnznkq3QVT2Icr4GmF9Av/xxTqaV0sBMDNh4Nov4/DhHh6oSMZtdSM2ocMP4jxahs
 sWeuCE+kXczxyi5m7ipleDBAbxT4wjb17II5LV9LErLGK8j6A/uqvn7xG4+6769DR/Ta JQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bhh5q5ga4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 06 Oct 2021 19:18:45 -0400
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 196NIiNU010548
        for <linux-integrity@vger.kernel.org>; Wed, 6 Oct 2021 19:18:44 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bhh5q5g9q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Oct 2021 19:18:44 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 196NCipm008653;
        Wed, 6 Oct 2021 23:18:42 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma06ams.nl.ibm.com with ESMTP id 3bhepctwn0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Oct 2021 23:18:42 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 196NIdbn42729824
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 6 Oct 2021 23:18:39 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A390A4C074;
        Wed,  6 Oct 2021 23:18:39 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CFAA74C075;
        Wed,  6 Oct 2021 23:18:38 +0000 (GMT)
Received: from sig-9-65-65-120.ibm.com (unknown [9.65.65.120])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  6 Oct 2021 23:18:38 +0000 (GMT)
Message-ID: <6ade3979fd113902aadf48eb97a15f86e19bf86f.camel@linux.ibm.com>
Subject: Re: [PATCH] IMA: make runtime measurement list pollable
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Daiki Ueno <dueno@redhat.com>, linux-integrity@vger.kernel.org
Date:   Wed, 06 Oct 2021 19:18:38 -0400
In-Reply-To: <20211005144414.64547-1-dueno@redhat.com>
References: <20211005144414.64547-1-dueno@redhat.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: UKXHi_IKN2PwoOAZOzacKcTn98akqhjn
X-Proofpoint-ORIG-GUID: zzcXcqYzo4IJUavJtakfycVn75n34TCz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-10-06_04,2021-10-06_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 clxscore=1015 malwarescore=0 spamscore=0 lowpriorityscore=0
 impostorscore=0 bulkscore=0 phishscore=0 suspectscore=0 mlxlogscore=999
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110060142
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Daiki,

On Tue, 2021-10-05 at 16:44 +0200, Daiki Ueno wrote:
> The IMA runtime measurement list exposed on securityfs is currently
> not pollable, so applications that incrementally verify the
> measurements have to monitor the file periodically.  This patch makes
> it possible to poll the file in a similar fashion to the sysfs files,
> i.e., POLLPRI will be signalled on any changes to the list.
> 
> Signed-off-by: Daiki Ueno <dueno@redhat.com>

With the sample code in the poll man page and without this patch, the
ascii measurement list is pollable.  I must be missing something.

> ---
> diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/ima_queue.c
> index 532da87ce519..375325dfe449 100644
> --- a/security/integrity/ima/ima_queue.c
> +++ b/security/integrity/ima/ima_queue.c
> @@ -38,6 +38,9 @@ struct ima_h_table ima_htable = {
>  	.queue[0 ... IMA_MEASURE_HTABLE_SIZE - 1] = HLIST_HEAD_INIT
>  };
>  
> +/* wait queue for polling changes in ima_htable */
> +DECLARE_WAIT_QUEUE_HEAD(ima_htable_wait);
> +
>  /* mutex protects atomicity of extending measurement list
>   * and extending the TPM PCR aggregate. Since tpm_extend can take
>   * long (and the tpm driver uses a mutex), we can't use the spinlock.
> @@ -119,6 +122,9 @@ static int ima_add_digest_entry(struct ima_template_entry *entry,
>  		binary_runtime_size = (binary_runtime_size < ULONG_MAX - size) ?
>  		     binary_runtime_size + size : ULONG_MAX;
>  	}
> +
> +	wake_up_interruptible(&ima_htable_wait);
> +
>  	return 0;
>  }
>  

The call to wake_up_interruptible() probably should not be here, but in
the caller after the TPM is extended.   With that change, you would be
able to differentiate between restoring the measurement list after
kexec and regular additional measurements.

thanks,

Mimi

