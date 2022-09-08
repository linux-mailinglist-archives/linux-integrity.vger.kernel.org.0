Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 084D15B1FAB
	for <lists+linux-integrity@lfdr.de>; Thu,  8 Sep 2022 15:53:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232089AbiIHNx3 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 8 Sep 2022 09:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232080AbiIHNx0 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 8 Sep 2022 09:53:26 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF20BF6523;
        Thu,  8 Sep 2022 06:53:24 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 288DMxpS000795;
        Thu, 8 Sep 2022 13:53:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=wLkC1EXLCw7gLrIzepWgXVx08s2SChuL1iXe8/1DdMY=;
 b=Lx0/q6xGb4oMFGn+kFAyBJGHN2Cyo0E371QEvXW2jAfdJEoM5otki709ROAooV++D5he
 xFZU5Tl4Kh2gepaMCvqghrZiCszFLpUn3WdMbmx2kuSq1GZlFzhXZejvgtAoUxMrOaFq
 B0/Muf+ppggR0C05BsO4NoDDAlHlRNkpLctVjeMXkQyPE05S8qEpcllSIvuPxUKelgfY
 /zOxOnNNlEQ5Tf0azCnjB1OrWI8aWoKA2w/xlOsdmAyTC2G1w6s9GZ+nHutpnzoCiUYG
 piihAyQCOEHqIQM4Leo23dGYuWhFfc/Iwr70KWjeniteiVunWeEB0ITE5Fj9emM2CjCx Iw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jfh7v9dyj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Sep 2022 13:53:18 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 288DO5cJ008549;
        Thu, 8 Sep 2022 13:53:18 GMT
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jfh7v9dx9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Sep 2022 13:53:18 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 288DpbfX022788;
        Thu, 8 Sep 2022 13:53:17 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by ppma04dal.us.ibm.com with ESMTP id 3jbxja8pmj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Sep 2022 13:53:16 +0000
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 288DrFvg60817698
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 8 Sep 2022 13:53:15 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 707416A04D;
        Thu,  8 Sep 2022 13:53:15 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8DA7B6A047;
        Thu,  8 Sep 2022 13:53:14 +0000 (GMT)
Received: from [9.65.226.72] (unknown [9.65.226.72])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu,  8 Sep 2022 13:53:14 +0000 (GMT)
Message-ID: <1a20cd56-cc6f-d1c3-2e9d-c6b1fe278959@linux.ibm.com>
Date:   Thu, 8 Sep 2022 08:53:14 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH] tpm: Add flag to use default cancellation policy
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        peterhuewe@gmx.de, jarkko@kernel.or, jgg@ziepe.ca, joel@jms.id.au,
        Alexander.Steffen@infineon.com
References: <20220907164317.80617-1-eajames@linux.ibm.com>
 <Yxl8CJBZiROgqhd6@kernel.org>
From:   Eddie James <eajames@linux.ibm.com>
In-Reply-To: <Yxl8CJBZiROgqhd6@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: vitQInUQL_uAZmHdbnuVwSgpQrPHv9tI
X-Proofpoint-ORIG-GUID: nVWtswKn9nlTWnB7e7X32l90FjeUy9yk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-08_08,2022-09-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 malwarescore=0 suspectscore=0 priorityscore=1501 adultscore=0
 clxscore=1011 impostorscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209080049
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 9/8/22 00:22, Jarkko Sakkinen wrote:
> On Wed, Sep 07, 2022 at 11:43:17AM -0500, Eddie James wrote:
>> The check for cancelled request depends on the VID of the chip, but
>> some chips share VID which shouldn't share their cancellation
>> behavior. This is the case for the Nuvoton NPCT75X, which should use
>> the default cancellation check, not the Winbond one.
>> To avoid changing the existing behavior, add a new flag to indicate
>> that the chip should use the default cancellation check and set it
>> for the I2C TPM2 TIS driver.
>>
>> Signed-off-by: Eddie James <eajames@linux.ibm.com>
>> ---
>>   drivers/char/tpm/tpm_tis_core.c | 18 ++++++++++--------
>>   drivers/char/tpm/tpm_tis_core.h |  1 +
>>   drivers/char/tpm/tpm_tis_i2c.c  |  1 +
>>   3 files changed, 12 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
>> index 757623bacfd5..175e75337395 100644
>> --- a/drivers/char/tpm/tpm_tis_core.c
>> +++ b/drivers/char/tpm/tpm_tis_core.c
>> @@ -682,15 +682,17 @@ static bool tpm_tis_req_canceled(struct tpm_chip *chip, u8 status)
>>   {
>>   	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
>>   
>> -	switch (priv->manufacturer_id) {
>> -	case TPM_VID_WINBOND:
>> -		return ((status == TPM_STS_VALID) ||
>> -			(status == (TPM_STS_VALID | TPM_STS_COMMAND_READY)));
>> -	case TPM_VID_STM:
>> -		return (status == (TPM_STS_VALID | TPM_STS_COMMAND_READY));
>> -	default:
>> -		return (status == TPM_STS_COMMAND_READY);
>> +	if (!test_bit(TPM_TIS_DEFAULT_CANCELLATION, &priv->flags)) {
>> +		switch (priv->manufacturer_id) {
>> +		case TPM_VID_WINBOND:
>> +			return ((status == TPM_STS_VALID) ||
>> +				(status == (TPM_STS_VALID | TPM_STS_COMMAND_READY)));
>> +		case TPM_VID_STM:
>> +			return (status == (TPM_STS_VALID | TPM_STS_COMMAND_READY));
>> +		}
> Why there is no default: ?


Well I didn't want to duplicate the line "status == 
TPM_STS_COMMAND_READY" in the default case and for the flagged case. So 
now the switch just falls through for default. I can add default: break 
instead


>
>>   	}
>> +
>> +	return status == TPM_STS_COMMAND_READY;
>>   }
>>   
>>   static irqreturn_t tis_int_handler(int dummy, void *dev_id)
>> diff --git a/drivers/char/tpm/tpm_tis_core.h b/drivers/char/tpm/tpm_tis_core.h
>> index 66a5a13cd1df..b68479e0de10 100644
>> --- a/drivers/char/tpm/tpm_tis_core.h
>> +++ b/drivers/char/tpm/tpm_tis_core.h
>> @@ -86,6 +86,7 @@ enum tis_defaults {
>>   enum tpm_tis_flags {
>>   	TPM_TIS_ITPM_WORKAROUND		= BIT(0),
>>   	TPM_TIS_INVALID_STATUS		= BIT(1),
>> +	TPM_TIS_DEFAULT_CANCELLATION	= BIT(2),
>>   };
>>   
>>   struct tpm_tis_data {
>> diff --git a/drivers/char/tpm/tpm_tis_i2c.c b/drivers/char/tpm/tpm_tis_i2c.c
>> index 0692510dfcab..6722588e0217 100644
>> --- a/drivers/char/tpm/tpm_tis_i2c.c
>> +++ b/drivers/char/tpm/tpm_tis_i2c.c
>> @@ -329,6 +329,7 @@ static int tpm_tis_i2c_probe(struct i2c_client *dev,
>>   	if (!phy->io_buf)
>>   		return -ENOMEM;
>>   
>> +	set_bit(TPM_TIS_DEFAULT_CANCELLATION, &phy->priv.flags);
> What if you just zeroed manufacturer ID?


It's already zero there, and gets set to the VID as part of the core 
init function.


Thanks,

Eddie


>
>>   	phy->i2c_client = dev;
>>   
>>   	/* must precede all communication with the tpm */
>> -- 
>> 2.31.1
>>
> BR, Jarkko
