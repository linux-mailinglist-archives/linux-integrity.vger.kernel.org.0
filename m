Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85975F8607
	for <lists+linux-integrity@lfdr.de>; Tue, 12 Nov 2019 02:26:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbfKLB0H (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 11 Nov 2019 20:26:07 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:7012 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726924AbfKLB0H (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 11 Nov 2019 20:26:07 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xAC1HKno023981;
        Mon, 11 Nov 2019 20:25:50 -0500
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2w7jpagevg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Nov 2019 20:25:50 -0500
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id xAC1JJbc027854;
        Mon, 11 Nov 2019 20:25:49 -0500
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2w7jpagevb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Nov 2019 20:25:49 -0500
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id xAC1LAHd026975;
        Tue, 12 Nov 2019 01:25:53 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma01wdc.us.ibm.com with ESMTP id 2w5n36afqv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Nov 2019 01:25:52 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xAC1PkUs50725354
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Nov 2019 01:25:46 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C1AF6AC05B;
        Tue, 12 Nov 2019 01:25:46 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AF725AC059;
        Tue, 12 Nov 2019 01:25:41 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 12 Nov 2019 01:25:41 +0000 (GMT)
Subject: Re: [PATCH v1 3/5] char: tpm: rewrite "tpm_tis_req_canceled()"
To:     amirmizi6@gmail.comg, Stefan Berger <stefanb@linux.vnet.ibm.com>,
        Eyal.Cohen@nuvoton.com, jarkko.sakkinen@linux.intel.com,
        oshrialkoby85@gmail.com, alexander.steffen@infineon.com,
        robh+dt@kernel.org, mark.rutland@arm.com, peterhuewe@gmx.de,
        jgg@ziepe.ca, arnd@arndb.de, gregkh@linuxfoundation.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, oshri.alkoby@nuvoton.com,
        tmaimon77@gmail.com, gcwilson@us.ibm.com, kgoldman@us.ibm.com,
        ayna@linux.vnet.ibm.com, Dan.Morav@nuvoton.com,
        oren.tanami@nuvoton.com, shmulik.hagar@nuvoton.com,
        amir.mizinski@nuvoton.com
References: <20191110162137.230913-1-amirmizi6@gmail.com>
 <20191110162137.230913-4-amirmizi6@gmail.com>
 <20191110180010.xyvv4gf6jiqyrac3@cantor>
From:   Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <3214005f-740b-46a8-7c0b-db96b63cd6f3@linux.ibm.com>
Date:   Mon, 11 Nov 2019 20:25:40 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191110180010.xyvv4gf6jiqyrac3@cantor>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-11-11_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1910280000 definitions=main-1911120009
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 11/10/19 1:00 PM, Jerry Snitselaar wrote:
> On Sun Nov 10 19, amirmizi6@gmail.com wrote:
>> From: Amir Mizinski <amirmizi6@gmail.com>
>>
>> using this function while read/write data resulted in aborted operation.
>> after investigating according to TCG TPM Profile (PTP) Specifications,
>> i found cancel should happen only if TPM_STS.commandReady bit is lit
>> and couldn't find a case when the current condition is valid.
>> also only cmdReady bit need to be compared instead of the full lower 
>> status register byte.
>>
>> Signed-off-by: Amir Mizinski <amirmizi6@gmail.com>
>> ---
>> drivers/char/tpm/tpm_tis_core.c | 12 +-----------
>> 1 file changed, 1 insertion(+), 11 deletions(-)
>>
>> diff --git a/drivers/char/tpm/tpm_tis_core.c 
>> b/drivers/char/tpm/tpm_tis_core.c
>> index ce7f8a1..9016f06 100644
>> --- a/drivers/char/tpm/tpm_tis_core.c
>> +++ b/drivers/char/tpm/tpm_tis_core.c
>> @@ -627,17 +627,7 @@ static int probe_itpm(struct tpm_chip *chip)
>>
>> static bool tpm_tis_req_canceled(struct tpm_chip *chip, u8 status)
>> {
>> -    struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
>> -
>> -    switch (priv->manufacturer_id) {
>> -    case TPM_VID_WINBOND:
>> -        return ((status == TPM_STS_VALID) ||
>> -            (status == (TPM_STS_VALID | TPM_STS_COMMAND_READY)));
>> -    case TPM_VID_STM:
>> -        return (status == (TPM_STS_VALID | TPM_STS_COMMAND_READY));
>
> Stefan were these cases you found that were deviating from the spec? 
> Wondering
> if dropping these will cause issues for these devices.


I believe these devices needed special handling of the status register 
as they didn't behave as the 'other' devices, so I would expect issues.

    Stefan

