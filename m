Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F28F15CB07
	for <lists+linux-integrity@lfdr.de>; Thu, 13 Feb 2020 20:16:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728359AbgBMTQT (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 13 Feb 2020 14:16:19 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:9726 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727919AbgBMTQT (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 13 Feb 2020 14:16:19 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01DJ8nGR072903;
        Thu, 13 Feb 2020 14:16:15 -0500
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2y3yw9kh4f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Feb 2020 14:16:15 -0500
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 01DJFG86029223;
        Thu, 13 Feb 2020 19:16:14 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com [9.57.198.23])
        by ppma02dal.us.ibm.com with ESMTP id 2y5bc0gk0t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Feb 2020 19:16:14 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01DJGDFA52691326
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Feb 2020 19:16:13 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DB92FB2064;
        Thu, 13 Feb 2020 19:16:13 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CC1E3B205F;
        Thu, 13 Feb 2020 19:16:13 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 13 Feb 2020 19:16:13 +0000 (GMT)
Subject: Re: [PATCH 1/3] tpm: of: Handle IBM,vtpm20 case when getting log
 parameters
To:     Nayna <nayna@linux.vnet.ibm.com>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org
Cc:     aik@ozlabs.ru, david@gibson.dropbear.id.au,
        linux-kernel@vger.kernel.org, gcwilson@linux.ibm.com
References: <20200204132706.3220416-1-stefanb@linux.vnet.ibm.com>
 <20200204132706.3220416-2-stefanb@linux.vnet.ibm.com>
 <1699b8ee-34d3-1dfd-7102-7dd1b7f6b641@linux.vnet.ibm.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <f40af77b-7427-1690-6bce-745dcaea5fec@linux.ibm.com>
Date:   Thu, 13 Feb 2020 14:16:13 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <1699b8ee-34d3-1dfd-7102-7dd1b7f6b641@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-13_07:2020-02-12,2020-02-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 suspectscore=0 spamscore=0 mlxscore=0
 phishscore=0 mlxlogscore=999 priorityscore=1501 impostorscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002130135
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 2/13/20 12:46 PM, Nayna wrote:
>
> On 2/4/20 8:27 AM, Stefan Berger wrote:
>> From: Stefan Berger <stefanb@linux.ibm.com>
>>
>> A vTPM 2.0 is identified by 'IBM,vtpm20' in the 'compatible' node in
>> the device tree. Handle it in the same way as 'IBM,vtpm'.
>>
>> The vTPM 2.0's log is written in little endian format so that for this
>> aspect we can rely on existing code.
>>
>> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
>> ---
>>   drivers/char/tpm/eventlog/of.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/char/tpm/eventlog/of.c 
>> b/drivers/char/tpm/eventlog/of.c
>> index af347c190819..a9ce66d09a75 100644
>> --- a/drivers/char/tpm/eventlog/of.c
>> +++ b/drivers/char/tpm/eventlog/of.c
>> @@ -51,7 +51,8 @@ int tpm_read_log_of(struct tpm_chip *chip)
>>        * endian format. For this reason, vtpm doesn't need conversion
>>        * but physical tpm needs the conversion.
>>        */
>> -    if (of_property_match_string(np, "compatible", "IBM,vtpm") < 0) {
>> +    if (of_property_match_string(np, "compatible", "IBM,vtpm") < 0 &&
>> +        of_property_match_string(np, "compatible", "IBM,vtpm20") < 0) {
>
> How about changing this to use of_device_compatible_match() ?


I can change it.

    Stefan


