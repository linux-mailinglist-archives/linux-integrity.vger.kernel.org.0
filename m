Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3685C173154
	for <lists+linux-integrity@lfdr.de>; Fri, 28 Feb 2020 07:49:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbgB1Gth (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 28 Feb 2020 01:49:37 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:12910 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725862AbgB1Gth (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 28 Feb 2020 01:49:37 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01S6hlXR129175;
        Fri, 28 Feb 2020 01:49:32 -0500
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2yepxau1uv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Feb 2020 01:49:32 -0500
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 01S6lMdD027845;
        Fri, 28 Feb 2020 06:49:30 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma05wdc.us.ibm.com with ESMTP id 2yepv2tf16-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Feb 2020 06:49:30 +0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01S6nT4e37880238
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Feb 2020 06:49:29 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AC9A76E050;
        Fri, 28 Feb 2020 06:49:29 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 01AB56E04E;
        Fri, 28 Feb 2020 06:49:28 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri, 28 Feb 2020 06:49:28 +0000 (GMT)
Subject: Re: [PATCH v4 0/3] Enable vTPM 2.0 for the IBM vTPM driver
To:     Stefan Berger <stefanb@linux.vnet.ibm.com>,
        jarkko.sakkinen@linux.intel.com, linux-integrity@vger.kernel.org
Cc:     aik@ozlabs.ru, david@gibson.dropbear.id.au,
        linux-kernel@vger.kernel.org, nayna@linux.vnet.ibm.com,
        gcwilson@linux.ibm.com, jgg@ziepe.ca
References: <20200227220346.15976-1-stefanb@linux.vnet.ibm.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <3a94fe3f-9618-b174-54bf-e0c22e5ba249@linux.ibm.com>
Date:   Fri, 28 Feb 2020 01:49:28 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200227220346.15976-1-stefanb@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-28_01:2020-02-26,2020-02-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999
 impostorscore=0 mlxscore=0 priorityscore=1501 adultscore=0 phishscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002280057
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Jarkko,

  please ignore v4. Have a look at v5.

   Stefan

> From: Stefan Berger <stefanb@linux.ibm.com>
>
> QEMU 5.0 will support the PAPR vTPM device model for TPM 1.2 and TPM 2.0.
> This series of patches enables vTPM 2.0 support for the IBM vTPM driver.
>
> Regards,
>     Stefan
>
> - v3->v4:
>    - Dropped patch 3; getting command code attributes table in IBM driver
>
> - v2->v3:
>    - Added fixes tag to patch 2/4; the race seems to have existed
>      since the driver was first added
>    - Renamed tpm2_init to tpm2_init_commands in 3/4
>
> - v1->v2:
>    - Addressed comments to v1; added patch 3 to handle case when
>      TPM_OPS_AUTO_STARTUP is not set
>
>
>
> Stefan Berger (3):
>    tpm: of: Handle IBM,vtpm20 case when getting log parameters
>    tpm: ibmvtpm: Wait for buffer to be set before proceeding
>    tpm: ibmvtpm: Add support for TPM 2
>
>   drivers/char/tpm/eventlog/of.c |  8 +++++++-
>   drivers/char/tpm/tpm.h         |  1 +
>   drivers/char/tpm/tpm2-cmd.c    |  2 +-
>   drivers/char/tpm/tpm_ibmvtpm.c | 15 +++++++++++++++
>   drivers/char/tpm/tpm_ibmvtpm.h |  1 +
>   5 files changed, 25 insertions(+), 2 deletions(-)
>

