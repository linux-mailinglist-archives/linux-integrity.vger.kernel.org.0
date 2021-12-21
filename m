Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25E2947C11B
	for <lists+linux-integrity@lfdr.de>; Tue, 21 Dec 2021 15:01:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234656AbhLUOBZ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 21 Dec 2021 09:01:25 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:24518 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229453AbhLUOBY (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 21 Dec 2021 09:01:24 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BLDe0Cd007258;
        Tue, 21 Dec 2021 14:01:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=Y2f1JQNiS0TkECCmHkDm6yIUjMCDTlb5T57vxkzTkfw=;
 b=NzgLPNLHcmIx4YuA5k/SH/RKRK1Z7XuLM1O63eg/eZpzQGqQCw7ni63kJTvpUKWTxcDj
 CaZZOoqzz8IfKk9oknUJ8FrKL9/PC0pG16viZOobfPRMzDxs9yrEzybyZ59quOwQ0Azt
 ULy+VwhwTRdbCqnRO1fX3m9TED82UW0s8nM2uPEH5gJfuzfXfQA/kCIJPUCixmqzmokn
 nkBZZ2Gbm0Xks3Ln3bOTT3mpf4twdjvoZwr3GkvG4CQ9h0v2KB3UWuUpkGF4LnQw0j4o
 b/PfjsfkgjYzbfedX83Z/ontygBgH0zyPqPwSuRtKEeHsOAqhxq89QSNFz1vsaNWGb39 EA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3d3g0u8emv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Dec 2021 14:01:14 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1BLDehno008320;
        Tue, 21 Dec 2021 14:01:14 GMT
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3d3g0u8emf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Dec 2021 14:01:14 +0000
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1BLDwHRb012382;
        Tue, 21 Dec 2021 14:01:13 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by ppma02wdc.us.ibm.com with ESMTP id 3d179ahx1r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Dec 2021 14:01:13 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1BLE19dV11075864
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Dec 2021 14:01:09 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9ED297805C;
        Tue, 21 Dec 2021 14:01:09 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CB41878098;
        Tue, 21 Dec 2021 14:01:07 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 21 Dec 2021 14:01:07 +0000 (GMT)
Message-ID: <8b0c9683-d29b-38a2-8dfe-8f47db6544f2@linux.ibm.com>
Date:   Tue, 21 Dec 2021 09:01:06 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] tpm: Fix kexec crash due to access to ops NULL pointer
 (powerpc)
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     peterhuewe@gmx.de, linux-integrity@vger.kernel.org, jgg@ziepe.ca,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, pavrampu@in.ibm.com,
        Korrapati.Likhitha@ibm.com, gcwilson@us.ibm.com
References: <20211212012804.1555661-1-stefanb@linux.ibm.com>
 <YcGUoJCtmqfCWER0@iki.fi>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <YcGUoJCtmqfCWER0@iki.fi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: YHJNSFTPngVAQ5P_j1u33_1jnTL2ToE9
X-Proofpoint-ORIG-GUID: RMqKfdeYynsKsm3JE-UXzhEFk2o4fXi2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-21_04,2021-12-21_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 mlxlogscore=999 spamscore=0 mlxscore=0 clxscore=1015
 impostorscore=0 bulkscore=0 suspectscore=0 priorityscore=1501 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112210065
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 12/21/21 03:47, Jarkko Sakkinen wrote:
> On Sat, Dec 11, 2021 at 08:28:04PM -0500, Stefan Berger wrote:
>> Fix the following crash on kexec by checking chip->ops for a NULL pointer
>> in tpm_chip_start() and returning an error code if this is the case.
>>
>> BUG: Kernel NULL pointer dereference on read at 0x00000060
>> Faulting instruction address: 0xc00000000099a06c
>> Oops: Kernel access of bad area, sig: 11 [#1]
>> ...
>> NIP [c00000000099a06c] tpm_chip_start+0x2c/0x140
>>   LR [c00000000099a808] tpm_chip_unregister+0x108/0x170
>> Call Trace:
>> [c0000000188bfa00] [c000000002b03930] fw_devlink_strict+0x0/0x8 (unreliable)
>> [c0000000188bfa30] [c00000000099a808] tpm_chip_unregister+0x108/0x170
>> [c0000000188bfa70] [c0000000009a3874] tpm_ibmvtpm_remove+0x34/0x130
>> [c0000000188bfae0] [c000000000110dbc] vio_bus_remove+0x5c/0xb0
>> [c0000000188bfb20] [c0000000009bc154] device_shutdown+0x1d4/0x3a8
>> [c0000000188bfbc0] [c000000000196e14] kernel_restart_prepare+0x54/0x70
>>
>> The referenced patch below introduced a function to shut down the VIO bus.
>> The bus shutdown now calls tpm_del_char_device (via tpm_chip_unregister)
>> after a call to tpm_class_shutdown, which already set chip->ops to NULL.
>> The crash occurrs when tpm_del_char_device calls tpm_chip_start with the
>> chip->ops NULL pointer.
>>
>> Fixes: 39d0099f9439 ("powerpc/pseries: Add shutdown() to vio_driver and vio_bus")
>> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
>> ---
>>   drivers/char/tpm/tpm-chip.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
>> index ddaeceb7e109..cca1bde296ee 100644
>> --- a/drivers/char/tpm/tpm-chip.c
>> +++ b/drivers/char/tpm/tpm-chip.c
>> @@ -101,6 +101,9 @@ int tpm_chip_start(struct tpm_chip *chip)
>>   {
>>   	int ret;
>>   
>> +	if (!chip->ops)
>> +		return -EINVAL;
> This triggers to all drivers, not just tpm_ibmvtpm, i.e. the fix has
> side-effects.

What are those side-effects?

   Stefan

>
> /Jarkko
>
