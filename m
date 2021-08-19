Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED7283F1F86
	for <lists+linux-integrity@lfdr.de>; Thu, 19 Aug 2021 20:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbhHSSGv (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 19 Aug 2021 14:06:51 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:13799 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229465AbhHSSGv (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 19 Aug 2021 14:06:51 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17JI3ilI092633;
        Thu, 19 Aug 2021 14:06:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : date : in-reply-to : references : content-type : mime-version
 : content-transfer-encoding; s=pp1;
 bh=5pth3P/Dah6hOUYKTtkUMWClGRlC4BUNVFox6PWcb4w=;
 b=odkXabawk04Sg0eNr//feF3a8sGEN8y4ADni3lHmUPmsbF2HAcRJHxdVnXy+jBqPc+Cm
 GW4L+G6l8/ZVacbpXlB6AS0hM4sXNTfmCXwMtnX2+Abu9eORfGptdFcoLl+R6+gSMKRZ
 lkBU5CeZLoKTrg9V/7UkW8691k8wuysYvAUHoFaGkj9y35ZYfB821L4Tus/qYIS3tfy3
 AwOJMx3MXupGJX3v63tniEbdVTToa8TW8dPJ1f+y2CT4NujlMRmoQqok1gmeril0xG9p
 pSpeKDKWLv5n8pQJXX1UBlpEOAu3HFc0hOVeIUBkK1c7qPutOHMioYwDlBz2zh1QtpG0 eQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ahhqkjv6a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Aug 2021 14:06:10 -0400
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 17JI4aei101587;
        Thu, 19 Aug 2021 14:06:10 -0400
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ahhqkjv59-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Aug 2021 14:06:10 -0400
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 17JHgEEg017718;
        Thu, 19 Aug 2021 18:06:08 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma01fra.de.ibm.com with ESMTP id 3ae5f8fefu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Aug 2021 18:06:07 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 17JI2Zju59965830
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Aug 2021 18:02:35 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 664E752063;
        Thu, 19 Aug 2021 18:06:05 +0000 (GMT)
Received: from sig-9-65-206-165.ibm.com (unknown [9.65.206.165])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 8F89B52050;
        Thu, 19 Aug 2021 18:06:04 +0000 (GMT)
Message-ID: <600a9f93ca6e74621833cd9452a9dfd7b5a8d55a.camel@linux.ibm.com>
Subject: Re: [PATCH ima-evm-utils v2] Use secure heap for private keys and
 passwords
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Vitaly Chikunov <vt@altlinux.org>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Date:   Thu, 19 Aug 2021 14:06:03 -0400
In-Reply-To: <20210819021136.664597-1-vt@altlinux.org>
References: <20210819021136.664597-1-vt@altlinux.org>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: -9f9Um6XIOqwR0todiBy26lAhyPAm6NY
X-Proofpoint-ORIG-GUID: Gy3s7FAm-5tU-zTVBFTODeK80hgTlKCu
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-19_06:2021-08-17,2021-08-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 phishscore=0 mlxlogscore=999 lowpriorityscore=0 bulkscore=0 spamscore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108190105
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2021-08-19 at 05:11 +0300, Vitaly Chikunov wrote:
> After CRYPTO_secure_malloc_init OpenSSL will store private keys in
> secure heap. This facility is only available since OpenSSL_1_1_0-pre1.
> 
> Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
> ---
> Change from v1:
> - Do not use setfbuf to disable buffering as this is not proven to be
>   meaningful.
> - Use secure heap for passwords too as suggested by Mimi Zohar.
> - Fallback to OPENSSL_malloc for old OpenSSL as suggested by Mimi Zohar.
> - Simplify logic of calling CRYPTO_secure_malloc_init (call it always on
>   OpenSSL init.)
> - Should be applied after Bruno Meneguele's "evmctl: fix memory leak in
>   get_password" patch v2.

Not sure why it isn't applying with/without Bruno's v2 patch.

> 
>  src/evmctl.c | 143 ++++++++++++++++++++++++++++++++++++++++++---------
>  1 file changed, 118 insertions(+), 25 deletions(-)
> 
> diff --git a/src/evmctl.c b/src/evmctl.c

> @@ -188,7 +207,9 @@ static int bin2file(const char *file, const char *ext, const unsigned char *data
>  	return err;
>  }
> 
> -static unsigned char *file2bin(const char *file, const char *ext, int *size)
> +/* Return data in OpenSSL secure heap if 'secure' is true. */
> +static unsigned char *file2bin(const char *file, const char *ext, int *size,
> +			       int secure)
>  {
>  	FILE *fp;
>  	size_t len;
> @@ -215,7 +236,10 @@ static unsigned char *file2bin(const char *file, const char *ext, int *size)
>  	}
>  	len = stats.st_size;
> 
> -	data = malloc(len);
> +	if (secure)
> +		data = OPENSSL_secure_malloc(len);
> +	else
> +		data = malloc(len);

Without being able to apply the patch, it's hard to tell if there
should be a preparatory patch that first replaces malloc() with
OPENSSL_malloc(), and other similar changes.

thanks,

Mimi

>  	if (!data) {
>  		log_err("Failed to malloc %zu bytes: %s\n", len, name);
>  		fclose(fp);

