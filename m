Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74214247907
	for <lists+linux-integrity@lfdr.de>; Mon, 17 Aug 2020 23:46:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728662AbgHQVqZ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 17 Aug 2020 17:46:25 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37756 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726634AbgHQVqY (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 17 Aug 2020 17:46:24 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07HLX9GS181310;
        Mon, 17 Aug 2020 17:46:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=jInUC0R0UVKQLc0/xLiIatT1sLU8hK9HLPaQ5/pxHKs=;
 b=eYpLshipE7u9UnPNF4rwelQjwsTelXdiRGCFdGO4EZv3CEYSb451LHabxnHTRC40SifB
 StFseCYeudNvGcW+28bp584UwxLlRBaeDxMwQ0FcpxLnO93yiM7XjxxyFoXumjmvL8Jm
 jQjEpT8761zZfgR6BzUPZjU2+2u2qDu3c6MXeTOpxpBW0ZIIe8Sh1Qm6W0Snh2CkzeiR
 3OLsjdANyQN5EmdICaIUZLq+M0HivHP6r60LNXa1w8Cm62ACQYj2oWIDF+ELA+/TvOvT
 +GfW0sBtOoP6rsaO/aRj3t/1doOctICBRyzET9vC0bmGuNQdLJSYejCxYFxfMAGucIZr rg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 32yy8em1vj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Aug 2020 17:46:19 -0400
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 07HLa99E193944;
        Mon, 17 Aug 2020 17:46:19 -0400
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0b-001b2d01.pphosted.com with ESMTP id 32yy8em1uy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Aug 2020 17:46:18 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07HLirNW009324;
        Mon, 17 Aug 2020 21:46:17 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma05fra.de.ibm.com with ESMTP id 32x7b81mmv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Aug 2020 21:46:17 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07HLkEWL29294974
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Aug 2020 21:46:14 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B1419A405C;
        Mon, 17 Aug 2020 21:46:14 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8DC68A405B;
        Mon, 17 Aug 2020 21:46:11 +0000 (GMT)
Received: from sig-9-65-192-88.ibm.com (unknown [9.65.192.88])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 17 Aug 2020 21:46:10 +0000 (GMT)
Message-ID: <5f12cc89c535ccfc6c3d63efa2bf716a1fdd966d.camel@linux.ibm.com>
Subject: Re: [PATCH 0/2] dm-devel:dm-crypt: infrastructure for measurement
 of DM target data using IMA
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Tushar Sugandhi <tusharsu@linux.microsoft.com>, agk@redhat.com,
        snitzer@redhat.com, gmazyland@gmail.com
Cc:     tyhicks@linux.microsoft.com, sashal@kernel.org, jmorris@namei.org,
        nramas@linux.microsoft.com, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com
Date:   Mon, 17 Aug 2020 17:46:08 -0400
In-Reply-To: <20200816210250.11506-1-tusharsu@linux.microsoft.com>
References: <20200816210250.11506-1-tusharsu@linux.microsoft.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-17_15:2020-08-17,2020-08-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 mlxscore=0 suspectscore=0 impostorscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 spamscore=0 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008170146
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sun, 2020-08-16 at 14:02 -0700, Tushar Sugandhi wrote:
> There are several device-mapper targets which contribute to verify
> the integrity of the mapped devices e.g. dm-integrity, dm-verity,
> dm-crypt etc.
> 
> But they do not use the capabilities provided by kernel integrity
> subsystem (IMA). For instance, the IMA capability that measures several
> in-memory constructs and files to detect if they have been accidentally
> or maliciously altered, both remotely and locally. IMA also has the
> capability to include these measurements in the IMA measurement list and
> use them to extend a TPM PCR so that it can be quoted.

"both remotely" refers to measurement and attestation, while "locally"
refers to integrity enforcement, based on hashes or signatures.  Is
this patch set adding both IMA-measurement and IMA-appraisal?

Mimi

>  These TPM PCR
> extend operations ensure that the tampering with the order of constructs
> being measured, and tampering with the measured constructs themselves -
> doesn't go undetected. In general, this capability is used for remote
> attestation of in-memory constructs and files of interest. As of today,
> device-mapper targets don't use the benefits of extended TPM PCR
> quotes and ultimately the benefits of remote attestation.
> 
> This series bridges this gap, so that all device-mapper targets
> could take advantage of IMA's measuring and quoting abilities - thus
> ultimately enabling remote attestation for device-mapper targets.
> 
> This series is based on the following repo/branch:
>  repo: https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git
>  branch: next-integrity
>  commit 3db0d0c276a7 ("integrity: remove redundant initialization of variable ret")
> 
> This series also has a dependency on the following patch series and
> should be applied in the following order:
>  1. https://patchwork.kernel.org/patch/11709527/
>  2. https://patchwork.kernel.org/patch/11711249/
>  3. https://patchwork.kernel.org/patch/11712729/
> 
> Tushar Sugandhi (2):
>   dm-devel: collect target data and submit to IMA to measure
>   dm-crypt: collect data and submit to DM to measure
> 
>  drivers/md/Makefile            |   1 +
>  drivers/md/dm-crypt.c          | 170 +++++++++++++++++++
>  drivers/md/dm-ima.c            | 296 +++++++++++++++++++++++++++++++++
>  include/linux/device-mapper.h  |  58 +++++++
>  security/integrity/ima/Kconfig |   2 +-
>  5 files changed, 526 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/md/dm-ima.c
> 


