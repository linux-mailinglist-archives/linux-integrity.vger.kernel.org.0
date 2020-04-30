Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EC621C0B12
	for <lists+linux-integrity@lfdr.de>; Fri,  1 May 2020 01:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbgD3Xrz (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 30 Apr 2020 19:47:55 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44492 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726562AbgD3Xry (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 30 Apr 2020 19:47:54 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03UNX6iE087849;
        Thu, 30 Apr 2020 19:47:51 -0400
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30r7md1nda-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Apr 2020 19:47:50 -0400
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 03UNdfeE032515;
        Thu, 30 Apr 2020 23:47:49 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma02wdc.us.ibm.com with ESMTP id 30mcu71c9h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Apr 2020 23:47:49 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 03UNlnZ755443940
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Apr 2020 23:47:49 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 024C4112062;
        Thu, 30 Apr 2020 23:47:49 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B313C112063;
        Thu, 30 Apr 2020 23:47:48 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 30 Apr 2020 23:47:48 +0000 (GMT)
Subject: Re: [PATCH v4 1/2] acpi: Extend TPM2 ACPI table with missing log
 fields
To:     rafael@kernel.org, linux-integrity@vger.kernel.org,
        jarkko.sakkinen@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-security-module@vger.kernel.org
References: <20200402225140.922789-1-stefanb@linux.vnet.ibm.com>
 <20200402225140.922789-2-stefanb@linux.vnet.ibm.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <982e60e5-c36d-d983-1add-f8914fccdba6@linux.ibm.com>
Date:   Thu, 30 Apr 2020 19:47:48 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200402225140.922789-2-stefanb@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-30_13:2020-04-30,2020-04-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 mlxlogscore=999
 priorityscore=1501 suspectscore=0 clxscore=1011 phishscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004300173
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Rafael,

   can you ACK this patch?

Regards,
    Stefan
> From: Stefan Berger <stefanb@linux.ibm.com>
>
> Recent extensions of the TPM2 ACPI table added 3 more fields
> including 12 bytes of start method specific parameters and Log Area
> Minimum Length (u32) and Log Area Start Address (u64). So, we extend
> the existing structure with these fields to allow non-UEFI systems
> to access the TPM2's log.
>
> The specification that has the new fields is the following:
>    TCG ACPI Specification
>    Family "1.2" and "2.0"
>    Version 1.2, Revision 8
>
> Adapt all existing table size calculations to use
> offsetof(struct acpi_table_tpm2, start_method_specific)
> [where start_method_specific is a newly added field]
> rather than sizeof(struct acpi_table_tpm2) so that the addition
> of the new fields does not affect current systems that may not
> have them.
>
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> Cc: linux-acpi@vger.kernel.org
> ---
>   drivers/char/tpm/tpm_crb.c | 13 ++++++++++---
>   drivers/char/tpm/tpm_tis.c |  4 +++-
>   include/acpi/actbl3.h      |  5 +++--
>   3 files changed, 16 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c
> index a9dcf31eadd2..0565aa5482f9 100644
> --- a/drivers/char/tpm/tpm_crb.c
> +++ b/drivers/char/tpm/tpm_crb.c
> @@ -669,7 +669,9 @@ static int crb_acpi_add(struct acpi_device *device)
>   
>   	status = acpi_get_table(ACPI_SIG_TPM2, 1,
>   				(struct acpi_table_header **) &buf);
> -	if (ACPI_FAILURE(status) || buf->header.length < sizeof(*buf)) {
> +	if (ACPI_FAILURE(status) || buf->header.length <
> +			offsetof(struct acpi_table_tpm2,
> +				 start_method_specific)) {
>   		dev_err(dev, FW_BUG "failed to get TPM2 ACPI table\n");
>   		return -EINVAL;
>   	}
> @@ -684,14 +686,19 @@ static int crb_acpi_add(struct acpi_device *device)
>   		return -ENOMEM;
>   
>   	if (sm == ACPI_TPM2_COMMAND_BUFFER_WITH_ARM_SMC) {
> -		if (buf->header.length < (sizeof(*buf) + sizeof(*crb_smc))) {
> +		if (buf->header.length <
> +			(offsetof(struct acpi_table_tpm2,
> +				  start_method_specific) +
> +			 sizeof(*crb_smc))) {
>   			dev_err(dev,
>   				FW_BUG "TPM2 ACPI table has wrong size %u for start method type %d\n",
>   				buf->header.length,
>   				ACPI_TPM2_COMMAND_BUFFER_WITH_ARM_SMC);
>   			return -EINVAL;
>   		}
> -		crb_smc = ACPI_ADD_PTR(struct tpm2_crb_smc, buf, sizeof(*buf));
> +		crb_smc = ACPI_ADD_PTR(struct tpm2_crb_smc, buf,
> +			   offsetof(struct acpi_table_tpm2,
> +				    start_method_specific));
>   		priv->smc_func_id = crb_smc->smc_func_id;
>   	}
>   
> diff --git a/drivers/char/tpm/tpm_tis.c b/drivers/char/tpm/tpm_tis.c
> index e7df342a317d..a80f36860bac 100644
> --- a/drivers/char/tpm/tpm_tis.c
> +++ b/drivers/char/tpm/tpm_tis.c
> @@ -111,7 +111,9 @@ static int check_acpi_tpm2(struct device *dev)
>   	 */
>   	st =
>   	    acpi_get_table(ACPI_SIG_TPM2, 1, (struct acpi_table_header **)&tbl);
> -	if (ACPI_FAILURE(st) || tbl->header.length < sizeof(*tbl)) {
> +	if (ACPI_FAILURE(st) || tbl->header.length <
> +			offsetof(struct acpi_table_tpm2,
> +				 start_method_specific)) {
>   		dev_err(dev, FW_BUG "failed to get TPM2 ACPI table\n");
>   		return -EINVAL;
>   	}
> diff --git a/include/acpi/actbl3.h b/include/acpi/actbl3.h
> index 2bf3baf819bb..b6118c67af0c 100644
> --- a/include/acpi/actbl3.h
> +++ b/include/acpi/actbl3.h
> @@ -411,8 +411,9 @@ struct acpi_table_tpm2 {
>   	u16 reserved;
>   	u64 control_address;
>   	u32 start_method;
> -
> -	/* Platform-specific data follows */
> +	u8  start_method_specific[12];
> +	u32 log_area_minimum_length;		/* optional */
> +	u64 log_area_start_address;		/* optional */
>   };
>   
>   /* Values for start_method above */


