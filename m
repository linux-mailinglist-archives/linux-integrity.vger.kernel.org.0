Return-Path: <linux-integrity+bounces-436-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C25DB811CCF
	for <lists+linux-integrity@lfdr.de>; Wed, 13 Dec 2023 19:39:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DA90B20FA7
	for <lists+linux-integrity@lfdr.de>; Wed, 13 Dec 2023 18:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9171835EF5;
	Wed, 13 Dec 2023 18:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lW/icCEX"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E83DBD;
	Wed, 13 Dec 2023 10:39:38 -0800 (PST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BDIGSU5031388;
	Wed, 13 Dec 2023 18:36:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=0f3eS2dKAg8fw7ia5UFHTP28ocE3TQ9LjwcT23r6pfM=;
 b=lW/icCEXESFZaYr1QCrwQh6OSm78r80I+o62gx7b+YTjdV61hHFi4y4C/L1YiLg+q3g3
 HAsGt3kfmccvSbcQCee/VL6wdc47zMA6kM9gQnr/wCIvhYiItK1S3pKZWVwc30/wxmxv
 KvpxJBLXZfvcSlUH7APBD9O/zUBCBB0rQ4y3koIf1CCvr0xQD3Snnfwp+PNqVJyKCV6E
 hzNW495m0LetMsKGRWFJCmbtRI++Z7dyIpVVgHRWSIvowbg2dqNNozYrAEBrMF2PokxJ
 NN0NervjqMD2QwArQUSpvSd09GK9ce/odq72A/vcEWE1k73x7/l6gTh1ZBB570Uvx3kA VA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uyeahq9g6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Dec 2023 18:36:53 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BDIUVVw017657;
	Wed, 13 Dec 2023 18:36:53 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uyeahq9fe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Dec 2023 18:36:53 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3BDGogMG012588;
	Wed, 13 Dec 2023 18:36:51 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3uw3jp2xpf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Dec 2023 18:36:51 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3BDIao8F40698204
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Dec 2023 18:36:50 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3ED6958054;
	Wed, 13 Dec 2023 18:36:50 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F147158056;
	Wed, 13 Dec 2023 18:36:48 +0000 (GMT)
Received: from [9.24.12.86] (unknown [9.24.12.86])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 13 Dec 2023 18:36:48 +0000 (GMT)
Message-ID: <6e1a7f5d-c15f-4938-893b-0aa77ef9fcfc@linux.ibm.com>
Date: Wed, 13 Dec 2023 12:36:48 -0600
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/8] dt-bindings: arm: aspeed: add IBM system1-bmc
Content-Language: en-US
To: Jarkko Sakkinen <jarkko@kernel.org>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, joel@jms.id.au,
        andrew@codeconstruct.com.au, peterhuewe@gmx.de, jgg@ziepe.ca,
        keescook@chromium.org, tony.luck@intel.com, gpiccoli@igalia.com,
        johannes.holland@infineon.com, linux@roeck-us.net, broonie@kernel.org
Cc: patrick.rudolph@9elements.com, vincent@vtremblay.dev,
        peteryin.openbmc@gmail.com, lakshmiy@us.ibm.com, bhelgaas@google.com,
        naresh.solanki@9elements.com, alexander.stein@ew.tq-group.com,
        festevam@denx.de, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-hardening@vger.kernel.org, geissonator@yahoo.com
References: <20231212164004.1683589-1-ninad@linux.ibm.com>
 <20231212164004.1683589-2-ninad@linux.ibm.com>
 <CXNEVH8BZUJT.1UHVUI66SZMTE@suppilovahvero>
From: Ninad Palsule <ninad@linux.ibm.com>
In-Reply-To: <CXNEVH8BZUJT.1UHVUI66SZMTE@suppilovahvero>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 5kq0bIMe7CgVmBlyTgG4FKZr25jLiE3U
X-Proofpoint-GUID: klWOiAxxw_I9AuxkGpEXwLWNyobuFlN9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-13_12,2023-12-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 mlxscore=0 spamscore=0 lowpriorityscore=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 impostorscore=0 priorityscore=1501 clxscore=1015
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312130133

Hello Jarkko,

On 12/13/23 12:18, Jarkko Sakkinen wrote:
> On Tue Dec 12, 2023 at 6:39 PM EET, Ninad Palsule wrote:
>> Document the new compatibles used on IBM system1-bmc
>>
>> Tested:
> this not very useful line :-) (nit)
>
>>      This board is tested using the simics simulator.
> Just leave this (w/o indentation)

Based on Conor's suggestion, I have removed both lines.

Thanks for the review.

Thanks & Regards,

Ninad

>
>> Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
>> ---
>>   Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
>>   Documentation/devicetree/bindings/trivial-devices.yaml   | 2 ++
>>   2 files changed, 3 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
>> index 6f7543463d89..ebebe14c42aa 100644
>> --- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
>> +++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
>> @@ -85,6 +85,7 @@ properties:
>>                 - facebook,yosemite4-bmc
>>                 - ibm,everest-bmc
>>                 - ibm,rainier-bmc
>> +              - ibm,system1-bmc
>>                 - ibm,tacoma-bmc
>>                 - inventec,starscream-bmc
>>                 - inventec,transformer-bmc
>> diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
>> index 441b55723675..b12a60d2eb0f 100644
>> --- a/Documentation/devicetree/bindings/trivial-devices.yaml
>> +++ b/Documentation/devicetree/bindings/trivial-devices.yaml
>> @@ -135,6 +135,8 @@ properties:
>>             - ibm,cffps1
>>               # IBM Common Form Factor Power Supply Versions 2
>>             - ibm,cffps2
>> +            # Infineon barometric pressure and temperature sensor
>> +          - infineon,dps310
>>               # Infineon IR36021 digital POL buck controller
>>             - infineon,ir36021
>>               # Infineon IR38060 Voltage Regulator
> BR, Jarkko

