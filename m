Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5B3315ABEA
	for <lists+linux-integrity@lfdr.de>; Wed, 12 Feb 2020 16:23:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727957AbgBLPXi (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 12 Feb 2020 10:23:38 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:17976 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727698AbgBLPXi (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 12 Feb 2020 10:23:38 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01CFKkaZ021145
        for <linux-integrity@vger.kernel.org>; Wed, 12 Feb 2020 10:23:37 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2y1ubsy5uf-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 12 Feb 2020 10:23:37 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Wed, 12 Feb 2020 15:23:35 -0000
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 12 Feb 2020 15:23:31 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01CFMaOR39584252
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Feb 2020 15:22:36 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9AE024C046;
        Wed, 12 Feb 2020 15:23:30 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B18564C05C;
        Wed, 12 Feb 2020 15:23:29 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.205.134])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 12 Feb 2020 15:23:29 +0000 (GMT)
Subject: Re: [PATCH v3 0/3] IMA: improve log messages in IMA
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Tushar Sugandhi <tusharsu@linux.microsoft.com>, joe@perches.com,
        skhan@linuxfoundation.org, linux-integrity@vger.kernel.org
Cc:     sashal@kernel.org, nramas@linux.microsoft.com,
        linux-kernel@vger.kernel.org
Date:   Wed, 12 Feb 2020 10:23:29 -0500
In-Reply-To: <20200211231414.6640-1-tusharsu@linux.microsoft.com>
References: <20200211231414.6640-1-tusharsu@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 20021215-0012-0000-0000-0000038632A3
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20021215-0013-0000-0000-000021C2B28C
Message-Id: <1581521009.8515.72.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-12_08:2020-02-11,2020-02-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 priorityscore=1501 phishscore=0 adultscore=0 spamscore=0 clxscore=1015
 bulkscore=0 lowpriorityscore=0 impostorscore=0 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002120119
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Tushar,

"in IMA" is redundant in the above Subject line.

On Tue, 2020-02-11 at 15:14 -0800, Tushar Sugandhi wrote:
> Some files under IMA prefix the log statement with the respective file
> names and not with the string "ima". This is not consistent with the rest
> of the IMA files.
> 
> The function process_buffer_measurement() does not have log messages for
> failure conditions.
> 
> The #define for formatting log messages, pr_fmt, is duplicated in the
> files under security/integrity.
> 
> This patchset addresses the above issues.

The cover letter should provide a summary of the problem(s) being
addressed by the individual patches, not a repetition of the
individual patch descriptions.

Mimi

> 
> Tushar Sugandhi (3):
>   add log prefix to ima_mok.c, ima_asymmetric_keys.c, ima_queue_keys.c
>   add log message to process_buffer_measurement failure conditions
>   add module name and base name prefix to log statements
> 
>  security/integrity/digsig.c                  | 2 --
>  security/integrity/digsig_asymmetric.c       | 2 --
>  security/integrity/evm/evm_crypto.c          | 2 --
>  security/integrity/evm/evm_main.c            | 2 --
>  security/integrity/evm/evm_secfs.c           | 2 --
>  security/integrity/ima/Makefile              | 6 +++---
>  security/integrity/ima/ima_asymmetric_keys.c | 2 --
>  security/integrity/ima/ima_crypto.c          | 2 --
>  security/integrity/ima/ima_fs.c              | 2 --
>  security/integrity/ima/ima_init.c            | 2 --
>  security/integrity/ima/ima_kexec.c           | 1 -
>  security/integrity/ima/ima_main.c            | 5 +++--
>  security/integrity/ima/ima_policy.c          | 2 --
>  security/integrity/ima/ima_queue.c           | 2 --
>  security/integrity/ima/ima_queue_keys.c      | 2 --
>  security/integrity/ima/ima_template.c        | 2 --
>  security/integrity/ima/ima_template_lib.c    | 2 --
>  security/integrity/integrity.h               | 6 ++++++
>  18 files changed, 12 insertions(+), 34 deletions(-)
> 

