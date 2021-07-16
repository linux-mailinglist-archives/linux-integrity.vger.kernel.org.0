Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DB063CBAA2
	for <lists+linux-integrity@lfdr.de>; Fri, 16 Jul 2021 18:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbhGPQmv (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 16 Jul 2021 12:42:51 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:31344 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229498AbhGPQmv (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 16 Jul 2021 12:42:51 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16GGX38d165010;
        Fri, 16 Jul 2021 12:39:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : date : in-reply-to : references : content-type : mime-version
 : content-transfer-encoding; s=pp1;
 bh=e5+gpo78Yg46j1JWVrHppMRQMSchnwa0M/qpYVC+64o=;
 b=ISYSJIqNUadjTr9OBGKVeDgITEt8RmKPpqBSRfH1YvoT9/knNFAqP5/W/Owx4Ez/m4iy
 a3lVq1RQK6kSgnRqqKI+eahs0zICmGqooiJVOoTxuepKkTa+ogCsdCS+bSQ0RP9JxajW
 0JlWrMvU0L8z5lDZsho91tjyPODIYbBFDarkD6Vmp908bVguPanyeyf4cdl+d3+S8+PD
 rjwgv1kz96CEzV7Nv5M0BkMdtfsCJFQCA7S3RpiUNugxK7Fg2lGWUQ4F0WQLBt18OahR
 o+8GIgliyUYggBycFWsTf/6qRL4H4CWxFY1RIeiM1LGjbiXwFSHqzi+AgEZg1FcU/IES bw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 39ud1fhek7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Jul 2021 12:39:52 -0400
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 16GGXHpn165602;
        Fri, 16 Jul 2021 12:39:52 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 39ud1fheju-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Jul 2021 12:39:52 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 16GGXMvc015990;
        Fri, 16 Jul 2021 16:39:50 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04ams.nl.ibm.com with ESMTP id 39q368au3q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Jul 2021 16:39:49 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 16GGdl8622675852
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Jul 2021 16:39:47 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 36D1442042;
        Fri, 16 Jul 2021 16:39:47 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D94E942041;
        Fri, 16 Jul 2021 16:39:45 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.55.33])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 16 Jul 2021 16:39:45 +0000 (GMT)
Message-ID: <f7c05b2618125cb0887ee0302c1197a8c8f49864.camel@linux.ibm.com>
Subject: Re: [PATCH ima-evm-utils v5] ima-evm-utils: Support SM2/3 algorithm
 for sign and verify
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>,
        Petr Vorel <pvorel@suse.cz>, Vitaly Chikunov <vt@altlinux.org>,
        Stefan Berger <stefanb@linux.ibm.com>,
        linux-integrity@vger.kernel.org,
        Jia Zhang <zhang.jia@linux.alibaba.com>,
        "YiLin . Li" <YiLin.Li@linux.alibaba.com>
Date:   Fri, 16 Jul 2021 12:39:45 -0400
In-Reply-To: <20210716092237.17153-1-tianjia.zhang@linux.alibaba.com>
References: <20210716092237.17153-1-tianjia.zhang@linux.alibaba.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 8ZjV9U4PrhthTEJEBhywA6CYzQQ-zdG2
X-Proofpoint-ORIG-GUID: GlWLHqr5SgPUkKwElDFTzmXUvTNOp9Gc
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-16_06:2021-07-16,2021-07-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 clxscore=1015 priorityscore=1501 mlxlogscore=999 phishscore=0
 suspectscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107160101
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Tianjia,

On Fri, 2021-07-16 at 17:22 +0800, Tianjia Zhang wrote:
> diff --git a/.github/workflows/ci.yml b/.github/workflows/ci.yml
> index 088c041..17407ff 100644
> --- a/.github/workflows/ci.yml
> +++ b/.github/workflows/ci.yml
> @@ -17,6 +17,7 @@ jobs:
>                ARCH: i386
>                TSS: tpm2-tss
>                VARIANT: i386
> +              OPENSSL3: true
>  
>            # cross compilation builds
>            - container: "debian:stable"
> @@ -51,6 +52,7 @@ jobs:
>              env:
>                CC: clang
>                TSS: ibmtss
> +              OPENSSL3: true

I haven't had a chance to look at the entire patch, but defining
OPENSSL3 kind of stood out.  Just as "CC" and "TSS" are generic, I'd
prefer something more generic here.   In the past there was a request
to support Libressl, which never materialized.

thanks,

Mimi

