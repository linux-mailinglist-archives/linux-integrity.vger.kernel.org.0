Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E13E53F7475
	for <lists+linux-integrity@lfdr.de>; Wed, 25 Aug 2021 13:39:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239799AbhHYLkd (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 25 Aug 2021 07:40:33 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41628 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232199AbhHYLk2 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 25 Aug 2021 07:40:28 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17PBXUrg060092;
        Wed, 25 Aug 2021 07:39:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : date : in-reply-to : references : content-type : mime-version
 : content-transfer-encoding; s=pp1;
 bh=hXemy+AI8N+IIsFU/E5uooHm4euKA6Kq7/+3f5i/IOo=;
 b=geL7uMqrMZyicJpA30lJYAkoI5sCRHxR7pvBMfKm1J97zH5ACGK5+zAgsGgnDRmFdLiF
 hLRk2kGIa51D2OJFjpa8m7p27vQbApBR+K7pHAvUW3KHV5UPvnONccsgdNzXSdtiz+GP
 hWMuTsf7f5hAGGAihfk/DDXwcIerD/dHm0Z1dfI3/M1RZDDzkD5lzdrj2L5bJz/Kt9U2
 zRb1G7rJxc5WxV+/RHal6k3DOvJ06tTYRimhUXkxVpNrD8ELYchgsVHiP7D00LhB0H13
 VWvDgj7nIcvOHToXFym5RcMi58EqjJvTqiU90Bhk0pn1hA90pPQNKuiDJ3F3XWzcWFHt mA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3angn80faa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Aug 2021 07:39:38 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 17PBXelK061460;
        Wed, 25 Aug 2021 07:39:38 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3angn80f98-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Aug 2021 07:39:38 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 17PBd91u002069;
        Wed, 25 Aug 2021 11:39:35 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma03fra.de.ibm.com with ESMTP id 3ajs48duqf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Aug 2021 11:39:35 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 17PBdWO957082196
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Aug 2021 11:39:32 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9ACD211C06C;
        Wed, 25 Aug 2021 11:39:32 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5C09E11C050;
        Wed, 25 Aug 2021 11:39:31 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.60.9])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 25 Aug 2021 11:39:31 +0000 (GMT)
Message-ID: <0c5c0851cd07f861ebf79bc0ac90e57d71317985.camel@linux.ibm.com>
Subject: Re: [PATCH ima-evm-utils v3] Use secure heap for private keys and
 passwords
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Vitaly Chikunov <vt@altlinux.org>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Date:   Wed, 25 Aug 2021 07:39:30 -0400
In-Reply-To: <20210822001055.1772873-1-vt@altlinux.org>
References: <20210822001055.1772873-1-vt@altlinux.org>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: T4P4QsW4M5dmSD1E9VKEuYL01VaOacKT
X-Proofpoint-GUID: UDUgc2jvKVWR2lqeiMQpt8njP1J3ikPm
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-25_04:2021-08-25,2021-08-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 suspectscore=0 bulkscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 mlxscore=0 clxscore=1015 spamscore=0 mlxlogscore=999 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108250068
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Vitaly,

On Sun, 2021-08-22 at 03:10 +0300, Vitaly Chikunov wrote:
> After CRYPTO_secure_malloc_init OpenSSL will store private keys 

^and passwords

> in
> secure heap. This facility is only available since OpenSSL_1_1_0-pre1.
> 
> Signed-off-by: Vitaly Chikunov <vt@altlinux.org>

Initially we started out discussing ways of protecting passwords, which
this patch does.  Thank you!  I'm not sure, however, it is protecting
the private keys.  Does read_priv_pkey()  also use the secure heap or
is PEM_read_PrivateKey() already safe?

> ---
>  src/evmctl.c | 148 +++++++++++++++++++++++++++++++++++++++++----------
>  1 file changed, 121 insertions(+), 27 deletions(-)
> 
> diff --git a/src/evmctl.c b/src/evmctl.c
> 
> @@ -188,7 +207,9 @@ static int bin2file(const char *file, const char *ext, const unsigned char *data
>  	return err;
>  }
> 
> -static unsigned char *file2bin(const char *file, const char *ext, int *size)
> +/* Return data in OpenSSL secure heap if 'secure' is true. */
> +static unsigned char *file2bin(const char *file, const char *ext, int *size,
> +			       int secure)
>  {

The only caller of file2bin() that sets "secure" is evm_calc_hmac(),
but evm_calc_hmac() is a debugging tool, not meant for setting the real
security.evm xattr.

The kernel EVM HMAC key is an "encrypted" key type, which should be
based on a "trusted" key.  Neither of which are exposed to userspace
unencrypted. 

Enabling DEBUG by default was suppose to be temporary.  At this point,
should it be disabled?  As evm_calc_hmac() is only meant for debugging,
do we really care whether evm_calc_hmac() uses a secure heap or stack
for private keys or passwords?

thanks,

Mimi

>  	FILE *fp;
>  	size_t len;

