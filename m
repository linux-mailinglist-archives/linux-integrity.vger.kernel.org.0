Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08F6C2097B2
	for <lists+linux-integrity@lfdr.de>; Thu, 25 Jun 2020 02:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388685AbgFYAid (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 24 Jun 2020 20:38:33 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:9206 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388467AbgFYAic (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 24 Jun 2020 20:38:32 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05P02JlT004460;
        Wed, 24 Jun 2020 20:38:27 -0400
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31uwyhcamq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Jun 2020 20:38:27 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05P0ZfGW032385;
        Thu, 25 Jun 2020 00:38:26 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma02dal.us.ibm.com with ESMTP id 31uurt1tst-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Jun 2020 00:38:26 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 05P0cQkT55509314
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Jun 2020 00:38:26 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E21DC112065;
        Thu, 25 Jun 2020 00:38:25 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DCD4C112064;
        Thu, 25 Jun 2020 00:38:25 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 25 Jun 2020 00:38:25 +0000 (GMT)
Subject: Re: [PATCH v5 1/2] acpi: Extend TPM2 ACPI table with missing log
 fields
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        Jiandi An <anjiandi@codeaurora.org>
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-security-module@vger.kernel.org,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
References: <20200623120636.1453470-1-stefanb@linux.vnet.ibm.com>
 <20200623120636.1453470-2-stefanb@linux.vnet.ibm.com>
 <20200625000021.GC21758@linux.intel.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <9d94c704-5774-ceeb-e4f3-010f74ffe37b@linux.ibm.com>
Date:   Wed, 24 Jun 2020 20:38:25 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200625000021.GC21758@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-24_16:2020-06-24,2020-06-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 cotscore=-2147483648
 spamscore=0 phishscore=0 suspectscore=0 bulkscore=0 impostorscore=0
 mlxscore=0 mlxlogscore=999 lowpriorityscore=0 malwarescore=0 adultscore=0
 clxscore=1011 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006240152
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 6/24/20 8:00 PM, Jarkko Sakkinen wrote:
> On Tue, Jun 23, 2020 at 08:06:35AM -0400, Stefan Berger wrote:
>> From: Stefan Berger <stefanb@linux.ibm.com>
>>
>> Recent extensions of the TPM2 ACPI table added 3 more fields
>> including 12 bytes of start method specific parameters and Log Area
>> Minimum Length (u32) and Log Area Start Address (u64). So, we extend
>> the existing structure with these fields to allow non-UEFI systems
>> to access the TPM2's log.
>>
>> The specification that has the new fields is the following:
>>    TCG ACPI Specification
>>    Family "1.2" and "2.0"
>>    Version 1.2, Revision 8
>>
>> Adapt all existing table size calculations to use
>> offsetof(struct acpi_table_tpm2, start_method_specific)
>> [where start_method_specific is a newly added field]
>> rather than sizeof(struct acpi_table_tpm2) so that the addition
>> of the new fields does not affect current systems that may not
>> have them.
>>
> I found at least one regression from this patch. Please remove my
> reviewed-by comment form the next version.
>
> Should have:
>
>    Link: https://trustedcomputinggroup.org/wp-content/uploads/TCG_ACPIGeneralSpecification_v1.20_r8.pdf
>
> Please, add this.
>
>> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
>> Cc: linux-acpi@vger.kernel.org
>> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
>> ---
>>   drivers/char/tpm/tpm_crb.c | 13 ++++++++++---
>>   drivers/char/tpm/tpm_tis.c |  4 +++-
>>   include/acpi/actbl3.h      |  5 +++--
>>   3 files changed, 16 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c
>> index a9dcf31eadd2..0565aa5482f9 100644
>> --- a/drivers/char/tpm/tpm_crb.c
>> +++ b/drivers/char/tpm/tpm_crb.c
>> @@ -669,7 +669,9 @@ static int crb_acpi_add(struct acpi_device *device)
>>   
>>   	status = acpi_get_table(ACPI_SIG_TPM2, 1,
>>   				(struct acpi_table_header **) &buf);
>> -	if (ACPI_FAILURE(status) || buf->header.length < sizeof(*buf)) {
>> +	if (ACPI_FAILURE(status) || buf->header.length <
>> +			offsetof(struct acpi_table_tpm2,
>> +				 start_method_specific)) {
>>   		dev_err(dev, FW_BUG "failed to get TPM2 ACPI table\n");
>>   		return -EINVAL;
>>   	}
>> @@ -684,14 +686,19 @@ static int crb_acpi_add(struct acpi_device *device)
>>   		return -ENOMEM;
>>   
>>   	if (sm == ACPI_TPM2_COMMAND_BUFFER_WITH_ARM_SMC) {
>> -		if (buf->header.length < (sizeof(*buf) + sizeof(*crb_smc))) {
>> +		if (buf->header.length <
>> +			(offsetof(struct acpi_table_tpm2,
>> +				  start_method_specific) +
> Should be
>
>    offsetof(struct acpti_table_tpm2, log_area_minimum_length)


The old code had sizeof(*buf) with buf being 'struct acpi_table_tpm2' 
and that was equivalent to offsetof(struct acpi_table_tpm2, 
start_method_specific) since 'start_method_specific' is the first new 
field that we are adding right here. Also see 3rd paragraph in the patch 
description. The replacement rule described there should apply to all 
sizeof() calculations on 'struct acpi_table_tpm2.'

I'll address the other issues.


    Stefan


