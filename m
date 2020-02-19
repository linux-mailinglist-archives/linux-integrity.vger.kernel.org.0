Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33432164ED8
	for <lists+linux-integrity@lfdr.de>; Wed, 19 Feb 2020 20:23:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbgBSTXi (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 19 Feb 2020 14:23:38 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52818 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726609AbgBSTXi (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 19 Feb 2020 14:23:38 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01JJKBLw099841;
        Wed, 19 Feb 2020 14:23:33 -0500
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2y8uba9ugc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Feb 2020 14:23:32 -0500
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 01JJKMw5017166;
        Wed, 19 Feb 2020 19:23:31 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma03wdc.us.ibm.com with ESMTP id 2y6896p7j1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Feb 2020 19:23:31 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01JJNUaL48038180
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Feb 2020 19:23:30 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CD42ABE04F;
        Wed, 19 Feb 2020 19:23:30 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3D931BE054;
        Wed, 19 Feb 2020 19:23:30 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed, 19 Feb 2020 19:23:30 +0000 (GMT)
Subject: Re: [PATCH v2 0/4] Enable vTPM 2.0 for the IBM vTPM driver
To:     Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org
Cc:     aik@ozlabs.ru, david@gibson.dropbear.id.au,
        linux-kernel@vger.kernel.org, nayna@linux.vnet.ibm.com,
        gcwilson@linux.ibm.com, jgg@ziepe.ca,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
References: <20200213202329.898607-1-stefanb@linux.vnet.ibm.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <f76ce5e5-0552-bc2c-4548-ae9552d4e3ba@linux.ibm.com>
Date:   Wed, 19 Feb 2020 14:23:29 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200213202329.898607-1-stefanb@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-19_05:2020-02-19,2020-02-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 phishscore=0 adultscore=0 mlxscore=0 clxscore=1015
 impostorscore=0 lowpriorityscore=0 mlxlogscore=999 suspectscore=0
 spamscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002190147
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 2/13/20 3:23 PM, Stefan Berger wrote:
> From: Stefan Berger <stefanb@linux.ibm.com>
>
> QEMU 5.0 will support the PAPR vTPM device model for TPM 1.2 and TPM 2.0.
> This series of patches enables vTPM 2.0 support for the IBM vTPM driver.


If there are no more comments to this series, maybe Jarkko can queue it?


    Stefan


>
> Regards,
>     Stefan
>
> - v1->v2:
>    - Addressed comments to v1; added patch 3 to handle case when
>      TPM_OPS_AUTO_STARTUP is not set
>
> Stefan Berger (4):
>    tpm: of: Handle IBM,vtpm20 case when getting log parameters
>    tpm: ibmvtpm: Wait for buffer to be set before proceeding
>    tpm: Implement tpm2_init to call when TPM_OPS_AUTO_STARTUP is not set
>    tpm: ibmvtpm: Add support for TPM 2
>
>   drivers/char/tpm/eventlog/of.c   |  8 +++++++-
>   drivers/char/tpm/tpm-interface.c |  5 ++++-
>   drivers/char/tpm/tpm.h           |  1 +
>   drivers/char/tpm/tpm2-cmd.c      | 14 ++++++++++++++
>   drivers/char/tpm/tpm_ibmvtpm.c   | 15 ++++++++++++++-
>   drivers/char/tpm/tpm_ibmvtpm.h   |  1 +
>   6 files changed, 41 insertions(+), 3 deletions(-)
>

