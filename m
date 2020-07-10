Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38AE921BCA2
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Jul 2020 19:54:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbgGJRys (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 10 Jul 2020 13:54:48 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:10338 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726962AbgGJRys (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 10 Jul 2020 13:54:48 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06AHWbwn141353;
        Fri, 10 Jul 2020 13:54:45 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 326bpqu93t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Jul 2020 13:54:45 -0400
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06AHoJ3C184532;
        Fri, 10 Jul 2020 13:54:44 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 326bpqu938-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Jul 2020 13:54:44 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06AHl8Uk028804;
        Fri, 10 Jul 2020 17:54:42 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma06ams.nl.ibm.com with ESMTP id 326bahrsvu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Jul 2020 17:54:42 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06AHsepD59179126
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Jul 2020 17:54:40 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 92EB442041;
        Fri, 10 Jul 2020 17:54:40 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F12A74203F;
        Fri, 10 Jul 2020 17:54:39 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.206.93])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 10 Jul 2020 17:54:39 +0000 (GMT)
Message-ID: <1594403679.14405.13.camel@linux.ibm.com>
Subject: Re: [PATCH ima-evm-utils v2 2/2] ima-evm-utils: add SM3 to
 pkey_hash_algo algorithm list
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>, vt@altlinux.org,
        linux-integrity@vger.kernel.org
Date:   Fri, 10 Jul 2020 13:54:39 -0400
In-Reply-To: <20200709033416.16845-2-tianjia.zhang@linux.alibaba.com>
References: <20200709033416.16845-1-tianjia.zhang@linux.alibaba.com>
         <20200709033416.16845-2-tianjia.zhang@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-10_13:2020-07-10,2020-07-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 clxscore=1015
 spamscore=0 suspectscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007100112
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2020-07-09 at 11:34 +0800, Tianjia Zhang wrote:
> SM3 was published by State Encryption Management Bureau, China.
> It has been well supported in the kernel and openssl.
> This patch allows SM3 to be used smoothly by specifying the
> parameter `-a sm3` or `--hashalgo sm3`.
> 
> Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
> ---
>  src/libimaevm.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/src/libimaevm.c b/src/libimaevm.c
> index b485171..b8d5769 100644
> --- a/src/libimaevm.c
> +++ b/src/libimaevm.c
> @@ -71,6 +71,7 @@ static const char *const pkey_hash_algo[PKEY_HASH__LAST] = {
>  	[PKEY_HASH_SHA384]	= "sha384",
>  	[PKEY_HASH_SHA512]	= "sha512",
>  	[PKEY_HASH_SHA224]	= "sha224",
> +	[PKEY_HASH_SM3_256]	= "sm3",
>  	[PKEY_HASH_STREEBOG_256] = "md_gost12_256",
>  	[PKEY_HASH_STREEBOG_512] = "md_gost12_512",
>  };

Sorry, I had forgotten the name in hash_info.c was recently changed
from "sm3-256" to just "sm3".

This patch set patch is now in the "next" branch.

thanks,

Mimi 
