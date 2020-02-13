Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8AC0415C9BF
	for <lists+linux-integrity@lfdr.de>; Thu, 13 Feb 2020 18:53:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727604AbgBMRxs (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 13 Feb 2020 12:53:48 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:32812 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726282AbgBMRxs (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 13 Feb 2020 12:53:48 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01DHnCIg073005;
        Thu, 13 Feb 2020 12:53:43 -0500
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2y57ashu19-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Feb 2020 12:53:43 -0500
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 01DHhOhU019239;
        Thu, 13 Feb 2020 17:53:42 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
        by ppma04dal.us.ibm.com with ESMTP id 2y1mm8rf2q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Feb 2020 17:53:42 +0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01DHreJ444696028
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Feb 2020 17:53:41 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C7E526E052;
        Thu, 13 Feb 2020 17:53:40 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 26D2E6E04C;
        Thu, 13 Feb 2020 17:53:39 +0000 (GMT)
Received: from swastik.ibm.com (unknown [9.160.122.180])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu, 13 Feb 2020 17:53:38 +0000 (GMT)
Subject: Re: [PATCH 3/3] tpm: ibmvtpm: Add support for TPM 2
To:     Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org
Cc:     aik@ozlabs.ru, david@gibson.dropbear.id.au,
        linux-kernel@vger.kernel.org, gcwilson@linux.ibm.com,
        Stefan Berger <stefanb@linux.ibm.com>
References: <20200204132706.3220416-1-stefanb@linux.vnet.ibm.com>
 <20200204132706.3220416-4-stefanb@linux.vnet.ibm.com>
From:   Nayna <nayna@linux.vnet.ibm.com>
Message-ID: <a23872ef-aa23-e6b0-4b69-602d79671d4b@linux.vnet.ibm.com>
Date:   Thu, 13 Feb 2020 12:53:38 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200204132706.3220416-4-stefanb@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-13_06:2020-02-12,2020-02-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 malwarescore=0 priorityscore=1501 suspectscore=0 mlxscore=0 spamscore=0
 phishscore=0 lowpriorityscore=0 mlxlogscore=999 impostorscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002130127
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 2/4/20 8:27 AM, Stefan Berger wrote:
> From: Stefan Berger <stefanb@linux.ibm.com>
>
> Support TPM 2 in the IBM vTPM driver. The hypervisor tells us what
> version of TPM is connected through the vio_device_id.
>
> In case a TPM 2 is found, we set the TPM_OPS_AUTO_STARTUP flag to
> have properly initialize the TPM and driver.
>
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> ---
>   drivers/char/tpm/tpm_ibmvtpm.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/char/tpm/tpm_ibmvtpm.c b/drivers/char/tpm/tpm_ibmvtpm.c
> index eee566eddb35..d479d64a65aa 100644
> --- a/drivers/char/tpm/tpm_ibmvtpm.c
> +++ b/drivers/char/tpm/tpm_ibmvtpm.c
> @@ -29,6 +29,7 @@ static const char tpm_ibmvtpm_driver_name[] = "tpm_ibmvtpm";
>
>   static const struct vio_device_id tpm_ibmvtpm_device_table[] = {
>   	{ "IBM,vtpm", "IBM,vtpm"},
> +	{ "IBM,vtpm", "IBM,vtpm20"},
>   	{ "", "" }
>   };
>   MODULE_DEVICE_TABLE(vio, tpm_ibmvtpm_device_table);
> @@ -443,7 +444,7 @@ static bool tpm_ibmvtpm_req_canceled(struct tpm_chip *chip, u8 status)
>   	return (status == 0);
>   }
>
> -static const struct tpm_class_ops tpm_ibmvtpm = {
> +static struct tpm_class_ops tpm_ibmvtpm = {
>   	.recv = tpm_ibmvtpm_recv,
>   	.send = tpm_ibmvtpm_send,
>   	.cancel = tpm_ibmvtpm_cancel,
> @@ -672,6 +673,11 @@ static int tpm_ibmvtpm_probe(struct vio_dev *vio_dev,
>   	if (rc)
>   		goto init_irq_cleanup;
>
> +	if (!strcmp(id->compat, "IBM,vtpm20")) {
> +		chip->flags |= TPM_CHIP_FLAG_TPM2;
> +		tpm_ibmvtpm.flags = TPM_OPS_AUTO_STARTUP;

TPM_OPS_AUTO_STARTUP flag isn't set for vTPM 1.2. What is different in 
case of vTPM 2.0 ?

Thanks & Regards,

      - Nayna

