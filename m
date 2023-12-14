Return-Path: <linux-integrity+bounces-447-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E59D88133F2
	for <lists+linux-integrity@lfdr.de>; Thu, 14 Dec 2023 16:05:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F3921F2222A
	for <lists+linux-integrity@lfdr.de>; Thu, 14 Dec 2023 15:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A30015C075;
	Thu, 14 Dec 2023 15:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ENKU07zS"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE28518D;
	Thu, 14 Dec 2023 07:05:34 -0800 (PST)
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BEEKh64011902;
	Thu, 14 Dec 2023 15:04:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=CnQ9D6K8j+9V+7Ny5qvGgp4y21wkyRuwKdCuqX5clT4=;
 b=ENKU07zSPWdPX/ia5fKhd0ZpdMEHc09q3ICEecOa5vECU5CQEpW9uRGUrh/JO2ynfXEA
 QpsoPEuCjioHRjZ/nlTgsyrUsGeyoX0srCwHqupHqmL6RzvOCGD/CGMeZD+Z1d2mI0aZ
 9+KoDE14e0D08RJL40moW+sy31aMkeC3qZCTw+ZDit1WrncWo9B1AvwYHJuVrdNAbi/Z
 85AdDB3steOZ7NjkqdtmFAkqoWTrJ8uK3LlYE7lyS1hI1X2NjQV5v5h8mGr+33QIfhof
 4IKslR42odeq8HBRNsPsv+SV1Z6xwIBeFhIffd6V9XiDwKNMpnp+MsGVhjE5rmTpYIqv 4w== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3v0342t91u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Dec 2023 15:04:48 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BEEKlFg012425;
	Thu, 14 Dec 2023 15:04:47 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3v0342t90s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Dec 2023 15:04:47 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3BEEn5HH028212;
	Thu, 14 Dec 2023 15:04:45 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3uw2y01bq6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Dec 2023 15:04:45 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3BEF4jBk25494126
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Dec 2023 15:04:45 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2EDCA58056;
	Thu, 14 Dec 2023 15:04:45 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1513A58065;
	Thu, 14 Dec 2023 15:04:42 +0000 (GMT)
Received: from [9.67.23.198] (unknown [9.67.23.198])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 14 Dec 2023 15:04:41 +0000 (GMT)
Message-ID: <7b14aa01-24c2-425c-8bf3-48e5b7890b95@linux.ibm.com>
Date: Thu, 14 Dec 2023 09:04:41 -0600
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 8/8] ARM: dts: aspeed: System1: PS, sensor and more
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, joel@jms.id.au,
        andrew@codeconstruct.com.au, peterhuewe@gmx.de, jarkko@kernel.org,
        jgg@ziepe.ca, keescook@chromium.org, tony.luck@intel.com,
        gpiccoli@igalia.com, johannes.holland@infineon.com, linux@roeck-us.net,
        broonie@kernel.org
Cc: patrick.rudolph@9elements.com, vincent@vtremblay.dev,
        peteryin.openbmc@gmail.com, lakshmiy@us.ibm.com, bhelgaas@google.com,
        naresh.solanki@9elements.com, alexander.stein@ew.tq-group.com,
        festevam@denx.de, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-hardening@vger.kernel.org, geissonator@yahoo.com
References: <20231212164004.1683589-1-ninad@linux.ibm.com>
 <20231212164004.1683589-9-ninad@linux.ibm.com>
 <5b98538a-8ffe-42ec-b020-514dcfcebba3@linaro.org>
From: Ninad Palsule <ninad@linux.ibm.com>
In-Reply-To: <5b98538a-8ffe-42ec-b020-514dcfcebba3@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: n-TQSUgUvZvnK5-cY9SuRnUFBpR_mlmX
X-Proofpoint-GUID: ty9tpSxPLVfl3i-yx9m0bT9DVfWxaj8t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-14_09,2023-12-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 bulkscore=0 lowpriorityscore=0 mlxlogscore=999 spamscore=0 malwarescore=0
 impostorscore=0 adultscore=0 clxscore=1015 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312140105

Hello Krzysztof,

On 12/12/23 14:26, Krzysztof Kozlowski wrote:
> On 12/12/2023 17:40, Ninad Palsule wrote:
>> This drop adds following devices in the device tree.
>> - EEPROM/VPD
>> - Power supplies
>> - Humidity, pressure and temperature sensors.
>> - Trusted platform module(TPM) chip
>>
>> Tested:
>>      This board is tested using the simics simulator.
>>
>> Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
>> ---
> Don't mix DTS with drivers. DTS and drivers go via different subsystems
> and cannot have dependencies, so why DTS is patch #6, then driver #7 and
> now again DTS #7?
I have sent a driver patch as a separate patchset and removed it from 
this patchset.
>
>
>>   .../dts/aspeed/aspeed-bmc-ibm-system1.dts     | 76 +++++++++++++++++++
>>   1 file changed, 76 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
>> index 75562aa63701..d960b938fe8d 100644
>> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
>> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts
>> @@ -461,6 +461,11 @@ &kcs3 {
>>   &i2c0 {
>>   	status = "okay";
>>   
>> +	eeprom@50 {
>> +		compatible = "atmel,24c64";
>> +		reg = <0x50>;
>> +	};
>> +
>>   	regulator@60 {
>>   		compatible = "maxim,max8952";
>>   		reg = <0x60>;
>> @@ -655,6 +660,25 @@ pca0: pca9539@74 {
>>   
>>   &i2c2 {
>>   	status = "okay";
>> +
>> +	power-supply@58 {
>> +		compatible = "ibm,cffps";
>> +		reg = <0x58>;
>> +	};
>> +
>> +	power-supply@59 {
>> +		compatible = "ibm,cffps";
>> +		reg = <0x59>;
>> +	};
>> +
>> +	power-supply@5a {
>> +		compatible = "ibm,cffps";
>> +		reg = <0x5a>;
>> +	};
> Missing blank line

Fixed it.

Thanks for the review.

Regards,

Ninad

>
>> +	power-supply@5b {
>> +		compatible = "ibm,cffps";
>> +		reg = <0x5b>;
>> +	};
>
> Best regards,
> Krzysztof
>

