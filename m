Return-Path: <linux-integrity+bounces-347-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98D6E8040A7
	for <lists+linux-integrity@lfdr.de>; Mon,  4 Dec 2023 22:02:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA4A81C20B7B
	for <lists+linux-integrity@lfdr.de>; Mon,  4 Dec 2023 21:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1C4035EF6;
	Mon,  4 Dec 2023 21:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NTVLhAeq"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50855AA;
	Mon,  4 Dec 2023 13:02:29 -0800 (PST)
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B4KNJnw006283;
	Mon, 4 Dec 2023 21:02:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=aDsstBekkK8i5nwlSEPvo8tJuyO9DlWlyaFELKH92ww=;
 b=NTVLhAeqLTRUIe+b4DFo8JHomH/ikg+kqbMqIcXF4B8Bs3Yt/Pdo7d7HeooK8i3ciR8j
 1lwULW/BHoGw6s48b9v37oKUDxk3QLoIL6FO0viTRCA/oE9JwkjhjJyoYXrns33CcHyI
 1T94V8CkWnLO815tj9qK858G3XIQmsRgB5SZLCIIQhMJ2+LF0NPN1hKC8dkXstrjt5FW
 fxJOSGHexsxtqXg8hgR6Q23PbMNLvzN60PDuBkQfRmmoOT7iObKOUOfGK5vw4vLC8n5v
 WCYPCQ4kdcptYw8AB3FaMYMLI/inYDvxBEu6brIzc7dUIKgFx1bShMriqXCHH7+Ryp2W mQ== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3usnrsh31h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Dec 2023 21:02:21 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3B4KYPo1031636;
	Mon, 4 Dec 2023 21:02:21 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3urv8dqe7v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Dec 2023 21:02:21 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3B4L2Kxk37028182
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 4 Dec 2023 21:02:20 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 58AC358061;
	Mon,  4 Dec 2023 21:02:20 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E343858057;
	Mon,  4 Dec 2023 21:02:19 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  4 Dec 2023 21:02:19 +0000 (GMT)
Message-ID: <99abf64b-10af-4a24-ac12-117141798956@linux.ibm.com>
Date: Mon, 4 Dec 2023 16:02:19 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/13] add integrity and security to TPM2 transactions
Content-Language: en-US
To: James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-integrity@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>, keyrings@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>
References: <20230403214003.32093-1-James.Bottomley@HansenPartnership.com>
 <1d8de077-9dd3-432e-90de-0a5b7dafcd75@linux.ibm.com>
 <a56dfd99262b31db06713f6f0b6ff2ba58c2fa4b.camel@HansenPartnership.com>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <a56dfd99262b31db06713f6f0b6ff2ba58c2fa4b.camel@HansenPartnership.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: -exuosMOuciGEQQdVjtF8Z9p7DPMOQTY
X-Proofpoint-ORIG-GUID: -exuosMOuciGEQQdVjtF8Z9p7DPMOQTY
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-04_19,2023-12-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1015 impostorscore=0 malwarescore=0 suspectscore=0 phishscore=0
 mlxlogscore=848 adultscore=0 mlxscore=0 spamscore=0 lowpriorityscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2312040164



On 12/4/23 14:24, James Bottomley wrote:
> On Mon, 2023-12-04 at 13:56 -0500, Stefan Berger wrote:
>>
>>
>> On 4/3/23 17:39, James Bottomley wrote:
>>> The interest in securing the TPM against interposers, both active
>>> and
>>> passive has risen to fever pitch with the demonstration of key
>>> recovery against windows bitlocker:
>>>
>>> https://dolosgroup.io/blog/2021/7/9/from-stolen-laptop-to-inside-the-company-network
>>>
>>> And subsequently the same attack being successful against all the
>>> Linux TPM based security solutions:
>>>
>>> https://www.secura.com/blog/tpm-sniffing-attacks-against-non-bitlocker-targets
>>>
>>> The attacks fall into two categories:
>>>
>>> 1. Passive Interposers, which sit on the bus and merely observe
>>> 2. Active Interposers, which try to manipulate TPM transactions on
>>> the
>>>      bus using man in the middle and packet stealing to create TPM
>>> state the interposer owner desires.
>>
>> I think this is another capability of an interposer that should be
>> mentioned here, unless technically not possible but I would not know
>> why:
>>
>> 3. Active Interposers that send their own commands to the TPM to for
>> example cause DoS attacks.
>>
>> If we protect PCR extensions now and the interposer can send his own
>> PCR extensions and the TPM 2 accepts them (TPM doesn't have a mode to
>> reject unprotected commands in general), why protect the PCR
>> extensions from IMA then?
> 
> Well the PCRs are world writable in a standard system, so anyone with
> access, i.e. anyone in the tpm group, can arbitrarily extend them and
> destroy the replay.  So I ignored this because while an interposer can
> do this, you don't have to be an interposer to cause log replay
> disruption like this.

Presumably the folks in the tpm group are trusted while the interpose is 
not.

> 
> The actual threat to PCR extends from an interposer is silent discards
> where the attacker seeks to fake the log after the fact to match a
> quote they've discarded a suspicious event from.  Thus the HMAC check

Well, it's not that simple to fake the log unless you are root and then 
all bets are off when it comes to sending commands to the TPM.

> is actually the return one, which allows the kernel to know the write
> succeeded.
> 
> James
> 

