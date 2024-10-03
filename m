Return-Path: <linux-integrity+bounces-3735-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B70F98F9D4
	for <lists+linux-integrity@lfdr.de>; Fri,  4 Oct 2024 00:25:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31DF4285DD7
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Oct 2024 22:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6D7D1AC423;
	Thu,  3 Oct 2024 22:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="m2aAqubx"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9684D824BD;
	Thu,  3 Oct 2024 22:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727994325; cv=none; b=SiuInrSO74OWzCNpGAs6gR+f9DJIPa3T4PyVJzFc8ySJ6w8Djot6k5rorGGZ0ziorx0wcGS0tevl/PIdcABtSTRskheic17dRsRU1mUP5/50P01iKx8SmyO9Ibtw1KrMjNXUM9X+DRo+dDHQyrh2RWQ6Miy4Bc0DFBhEYb11C1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727994325; c=relaxed/simple;
	bh=4K/UTe0nfvEb5KuwLzrRPHtK1qxfTPWYqgpcVKY/Cpo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=C9BaGzvukecO9s8QfEKBENaRHvoMsse3f18LAio4AwDruJ5+N2Dc7bhjM1+2wcvP0MYUxn5KAz2KgZT0P2NrzKiDjFkif1Hh2KRW7YIWyYrm/xCiGOr0yu6xlxd/ie5XzevXe9GF4rZS3nWLY7NwClUu2n2w1p9j8rrqe5kxyj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=m2aAqubx; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 493MJVRS024930;
	Thu, 3 Oct 2024 22:25:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:from:to:cc:references
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=s
	pNS1A17gSKYZlpyARm0Re2pv/fvbpkv7DVahoKFsDM=; b=m2aAqubxFutgiSDTK
	NeRQy4g9gkAjgCppqmIBrSv0FHoN6oBmgMm+TJJ9P/Jms51z8QtadpaIigEiOK2R
	ILCR/Ds18nH5D4rPeyJoE9Ec03YwzPwJjH3R2Rbjm1vDEkF8drgxbPhjEfWZ6rjW
	a0YxhhcFgvGFI6rOzxLnhA4jNRiZPAyNUTAXH2/WMR7kv3uOoLu8HmEKKN7HeHAj
	tc/BaIS3eH2DJzOZF56UiAzKyHir9E8weEKXVcOPjXiOwq+xpbZPJYO+SLDblXZm
	Yo1bbn2/p4V77OjxqZ8i+Yff9t83HBwJ+enncSv+ETp66DWK3AFCdvxFSZfe5sFY
	IO+dA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4223ya80b1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Oct 2024 22:25:16 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 493MPFws003676;
	Thu, 3 Oct 2024 22:25:16 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4223ya80ax-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Oct 2024 22:25:15 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 493M150C017899;
	Thu, 3 Oct 2024 22:25:15 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 42207j8ynq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Oct 2024 22:25:15 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 493MPE4X44499330
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 3 Oct 2024 22:25:15 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DF7D958051;
	Thu,  3 Oct 2024 22:25:14 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 76E275805E;
	Thu,  3 Oct 2024 22:25:14 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  3 Oct 2024 22:25:14 +0000 (GMT)
Message-ID: <979629af-e224-4308-a9a1-c66a60003d2d@linux.ibm.com>
Date: Thu, 3 Oct 2024 18:25:14 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] tpm: Workaround failed command reception on Infineon
 devices
From: Stefan Berger <stefanb@linux.ibm.com>
To: Jonathan McDowell <noodles@earth.li>, linux-integrity@vger.kernel.org,
        Jarkko Sakkinen <jarkko@kernel.org>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-kernel@vger.kernel.org
References: <Zv1810ZfEBEhybmg@earth.li> <Zv19Cc-oTOzv8wVO@earth.li>
 <3c9a6d63-f892-4809-b48d-5fecc3817ad9@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <3c9a6d63-f892-4809-b48d-5fecc3817ad9@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Iq5RnyTjORP4mV5apcCFt-m0bGZ-u6UD
X-Proofpoint-ORIG-GUID: -HoFQu2_rbc97xu4HxdZ4RYC7RTOpef8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-03_19,2024-10-03_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=999 lowpriorityscore=0 suspectscore=0
 adultscore=0 bulkscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410030157



On 10/3/24 5:59 PM, Stefan Berger wrote:
> 
> 
> On 10/2/24 1:04 PM, Jonathan McDowell wrote:
>> (I'm still in the process of testing this to confirm it fixes the
>> errata I've seen, but I wanted to send it out for comments to make sure
>> it's a reasonable approach.)
>>
>> Some Infineon devices have a issue where the status register will get
>> stuck with a quick REQUEST_USE / COMMAND_READY sequence. The work around
> 
> Did you tell Infineon about it? Maybe they should have a look at their 
> firmware.
> 
> What are the TPMs in your fleet doing? I heared that some TPMs 
> pre-create keys in the background once users requested a few. I would 
> try to create a few primary keys with different combination of key flags 

Actually make this child keys of primary keys:

 > tsscreateprimary
Handle 80000000
 > while :; do time tsscreate -hp 80000000 -si  -opem pubkey.pem ; cat 
pubkey.pem; done

This should give a different key every time and maybe key creation time 
goes up at some point...

> set and in different hierarchies (and flush them) to use up these 
> precreated  keys and see whether that leads to any issues with the TIS 
> responsiveness once presumably the device starts creating keys in the 
> background...
> 
>> is to retry the command submission. Add appropriate logic to do this in
> 
> I would describe it as 'retrying to set the TPM_STS_COMMAND_READY flag 
> on the TIS STS register' because you are not retring a (TPM) command 
> submission, like resubmitting a TPM2_PCR_Extend for example.
> 
> 
> 
>> the send path.
>>
>> Signed-off-by: Jonathan McDowell <noodles@meta.com>
>> ---
>>   drivers/char/tpm/tpm_tis_core.c | 24 +++++++++++++++++++-----
>>   drivers/char/tpm/tpm_tis_core.h |  1 +
>>   include/linux/tpm.h             |  1 +
>>   3 files changed, 21 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/char/tpm/tpm_tis_core.c 
>> b/drivers/char/tpm/tpm_tis_core.c
>> index f6aa0dfadb93..940abd1a868e 100644
>> --- a/drivers/char/tpm/tpm_tis_core.c
>> +++ b/drivers/char/tpm/tpm_tis_core.c
>> @@ -432,16 +432,27 @@ static int tpm_tis_recv(struct tpm_chip *chip, 
>> u8 *buf, size_t count)
>>   static int tpm_tis_send_data(struct tpm_chip *chip, const u8 *buf, 
>> size_t len)
>>   {
>>       struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
>> -    int rc, status, burstcnt;
>> +    int rc, status, burstcnt, retry;
>> +    bool status_fix = test_bit(TPM_TIS_STATUS_WORKAROUND, &priv->flags);
> 
> This should probably be moved to the top.
> int retry = status_fix ? 3 : 1;
> 
>>       size_t count = 0;
>>       bool itpm = test_bit(TPM_TIS_ITPM_WORKAROUND, &priv->flags);
>>       status = tpm_tis_status(chip);
>>       if ((status & TPM_STS_COMMAND_READY) == 0) {
>> -        tpm_tis_ready(chip);
>> -        if (wait_for_tpm_stat
>> -            (chip, TPM_STS_COMMAND_READY, chip->timeout_b,
>> -             &priv->int_queue, false) < 0) {
>> +        retry = status_fix ? 3 : 1;
>> +
>> +        while (retry > 0) {
>> +            tpm_tis_ready(chip);
>> +            if (wait_for_tpm_stat
>> +                (chip, TPM_STS_COMMAND_READY, chip->timeout_b,
>> +                 &priv->int_queue, false) >= 0) {
>> +                break;
>> +            }
>> +
>> +            retry--;
>> +        }
>> +
>> +        if (retry == 0) {
>>               rc = -ETIME;
>>               goto out_err;
>>           }
>> @@ -1147,6 +1158,9 @@ int tpm_tis_core_init(struct device *dev, struct 
>> tpm_tis_data *priv, int irq,
>>           priv->timeout_max = TIS_TIMEOUT_MAX_ATML;
>>       }
>> +    if (priv->manufacturer_id == TPM_VID_IFX)
>> +        set_bit(TPM_TIS_STATUS_WORKAROUND, &priv->flags);
>> +
>>       if (is_bsw()) {
>>           priv->ilb_base_addr = ioremap(INTEL_LEGACY_BLK_BASE_ADDR,
>>                       ILB_REMAP_SIZE);
>> diff --git a/drivers/char/tpm/tpm_tis_core.h 
>> b/drivers/char/tpm/tpm_tis_core.h
>> index 13e99cf65efe..f888da57535d 100644
>> --- a/drivers/char/tpm/tpm_tis_core.h
>> +++ b/drivers/char/tpm/tpm_tis_core.h
>> @@ -89,6 +89,7 @@ enum tpm_tis_flags {
>>       TPM_TIS_INVALID_STATUS        = 1,
>>       TPM_TIS_DEFAULT_CANCELLATION    = 2,
>>       TPM_TIS_IRQ_TESTED        = 3,
>> +    TPM_TIS_STATUS_WORKAROUND    = 4,
>>   };
>>   struct tpm_tis_data {
>> diff --git a/include/linux/tpm.h b/include/linux/tpm.h
>> index 4ee9d13749ad..5f4998626a98 100644
>> --- a/include/linux/tpm.h
>> +++ b/include/linux/tpm.h
>> @@ -272,6 +272,7 @@ enum tpm2_cc_attrs {
>>   #define TPM_VID_WINBOND  0x1050
>>   #define TPM_VID_STM      0x104A
>>   #define TPM_VID_ATML     0x1114
>> +#define TPM_VID_IFX      0x15D1
>>   enum tpm_chip_flags {
>>       TPM_CHIP_FLAG_BOOTSTRAPPED        = BIT(0),
> 

