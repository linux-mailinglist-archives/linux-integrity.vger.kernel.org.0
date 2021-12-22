Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 497E147D933
	for <lists+linux-integrity@lfdr.de>; Wed, 22 Dec 2021 23:14:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbhLVWOD (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 22 Dec 2021 17:14:03 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55250 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229813AbhLVWOD (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 22 Dec 2021 17:14:03 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BMM1pg5007235;
        Wed, 22 Dec 2021 22:14:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=MhZv0mPQHiuDZvRQG5dC1mpk7h5pq5TOT7yS86sVm8I=;
 b=sG5x2DU5q173o+KnMMzHGq9xPqOk5gkGMkLq/J4DBwSPFVsYThxjvgnzhwneL3yZOoIH
 xb7dJuEsCSRsUEQZRJkiyYP9/L7HP0vYW6iLiSfxxnlBYTommwzmaMSDIndJ45Uao0hA
 EdZS/3bxnz52NwnhmqQpWyGufps7EYdcAFW71SZGEzSFCOcEq9qIP2l99d7Nz37j1te7
 VfLLdIC2gkz++exkypGsQ15jN1q+YeVQo6+l0x25u0eM6JAXDXDEFGPidAbyro/Tp7Vi
 oNxjLDrO48nQMIAojujA0rgLWxbgQnhTaOyRPbfwRxDajrysSVSvWIeCkMruXruaujvQ Fw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3d4cf1r5y6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Dec 2021 22:14:02 +0000
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1BMM5k7X021847;
        Wed, 22 Dec 2021 22:14:01 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3d4cf1r5y1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Dec 2021 22:14:01 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1BMMCBtt021215;
        Wed, 22 Dec 2021 22:14:00 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03ams.nl.ibm.com with ESMTP id 3d179at6ns-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Dec 2021 22:13:59 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1BMMDvtY47186334
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Dec 2021 22:13:57 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B5970AE04D;
        Wed, 22 Dec 2021 22:13:57 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 36AD4AE045;
        Wed, 22 Dec 2021 22:13:57 +0000 (GMT)
Received: from sig-9-65-95-213.ibm.com (unknown [9.65.95.213])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 22 Dec 2021 22:13:57 +0000 (GMT)
Message-ID: <31d71e1957e84d2440f41d43d2570b112e91a27b.camel@linux.ibm.com>
Subject: Re: [PATCH] ima: silence measurement list hexdump during kexec
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Bruno Meneguele <bmeneg@redhat.com>
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 22 Dec 2021 17:13:56 -0500
In-Reply-To: <20211222191623.376174-1-bmeneg@redhat.com>
References: <20211222191623.376174-1-bmeneg@redhat.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: s6cExu7CsdmG-24r9QPPh7xAdY5zAI6t
X-Proofpoint-GUID: vxIgZQKt7768fdyMZ-oS7V1gT-tm4dx_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-22_09,2021-12-22_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 malwarescore=0 lowpriorityscore=0 phishscore=0 suspectscore=0 spamscore=0
 impostorscore=0 bulkscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112220114
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Bruno,

On Wed, 2021-12-22 at 16:16 -0300, Bruno Meneguele wrote:
> The measurement list is dumped during a soft reset (kexec) through the call
> to "print_hex_dump(KERN_DEBUG, ...)", which ignores the DEBUG build flag.
> Instead, use "print_hex_dump_debug(...)", honoring the build flag.
> 
> Signed-off-by: Bruno Meneguele <bmeneg@redhat.com>

The patch description needs to at least explain why using
print_hex_dump() isn't sufficent.   Look at how print_hex_dump() is
defined.  Based on whether CONFIG_DYNAMIC_DEBUG is enabled, different
functions are used.

Mimi

> ---
>  security/integrity/ima/ima_kexec.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
> index f799cc278a9a..13753136f03f 100644
> --- a/security/integrity/ima/ima_kexec.c
> +++ b/security/integrity/ima/ima_kexec.c
> @@ -61,9 +61,9 @@ static int ima_dump_measurement_list(unsigned long *buffer_size, void **buffer,
>  	}
>  	memcpy(file.buf, &khdr, sizeof(khdr));
>  
> -	print_hex_dump(KERN_DEBUG, "ima dump: ", DUMP_PREFIX_NONE,
> -			16, 1, file.buf,
> -			file.count < 100 ? file.count : 100, true);
> +	print_hex_dump_debug("ima dump: ", DUMP_PREFIX_NONE, 16, 1,
> +			     file.buf, file.count < 100 ? file.count : 100,
> +			     true);
>  
>  	*buffer_size = file.count;
>  	*buffer = file.buf;


