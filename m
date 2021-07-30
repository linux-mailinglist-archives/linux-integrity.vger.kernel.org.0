Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CDFE3DB802
	for <lists+linux-integrity@lfdr.de>; Fri, 30 Jul 2021 13:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbhG3Lp7 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 30 Jul 2021 07:45:59 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35224 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S238649AbhG3Lp6 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 30 Jul 2021 07:45:58 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16UBZDDT176623;
        Fri, 30 Jul 2021 07:45:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=Fq7B7puweAjYOu51S7X4z6Rj3k7JPskwLajYKuwF+2M=;
 b=ZQL9sThQcIben+/12W0kVoOZcb2VMLwyo4emQpvYdKFpT8bIItVEKe0rBgOiDTlbUfmp
 /JeuuI9s3S97p/tL9Ev8Fe5sRupIma3SyLYLtE69XqKediLB7xwFrt8+Mnwy+6RR2odw
 xWjZHq1KYrt6RS046pJuDurvUTTPqNY+BCKu4AawIILUuHT1RlgiSN0MtUznU9BBAUgr
 6z4sRcFR1UXFWlckDwsinbW8qPqnvV/A1+0bbFI0lTgq3X/YNhuRfSJMIGOLItGeJXyM
 HoZyZjUGeF0UTPiFZtXBiUpGrXuoTNZZ28y9Psyq0VKptBv+uLIbHWa0sPnU1xX7YQ+M ag== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3a4gp488m6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Jul 2021 07:45:52 -0400
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 16UBZUBY176985;
        Fri, 30 Jul 2021 07:45:51 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3a4gp488m0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Jul 2021 07:45:51 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 16UBb22L027330;
        Fri, 30 Jul 2021 11:45:51 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma03dal.us.ibm.com with ESMTP id 3a235trtg1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Jul 2021 11:45:51 +0000
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 16UBjnFT24903982
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Jul 2021 11:45:49 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 349B1C6063;
        Fri, 30 Jul 2021 11:45:49 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5D99BC6066;
        Fri, 30 Jul 2021 11:45:48 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri, 30 Jul 2021 11:45:48 +0000 (GMT)
Subject: Re: [PATCH] tpm: ibmvtpm: Avoid error message when process gets
 signal while waiting
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Stefan Berger <stefanb@linux.vnet.ibm.com>, peterhuewe@gmx.de,
        jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Nayna Jain <nayna@linux.ibm.com>,
        George Wilson <gcwilson@linux.ibm.com>,
        Nageswara R Sastry <rnsastry@linux.ibm.com>
References: <20210712162505.205943-1-stefanb@linux.vnet.ibm.com>
 <20210727024225.swqy5ypcytsngpd6@kernel.org>
 <ad4011fb-fc1f-4019-9856-7d171db3255c@linux.ibm.com>
 <20210728215033.dhnekvksekalhcrn@kernel.org>
 <2add3eac-916e-5072-f62d-23c65e23fb17@linux.ibm.com>
 <20210730005744.ph7x6nme5ngtpf43@kernel.org>
From:   Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <31309ba8-fe05-d85d-b2c6-72499ef1ff17@linux.ibm.com>
Date:   Fri, 30 Jul 2021 07:45:47 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210730005744.ph7x6nme5ngtpf43@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: xuQ5202aNMLz4pNPKJhrZWth7Dkb505W
X-Proofpoint-GUID: kNJmyJkrubmA3FkrSqTkGU5qy9Fp-HKE
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-30_05:2021-07-30,2021-07-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 spamscore=0 priorityscore=1501
 mlxscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2107300073
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 7/29/21 8:57 PM, Jarkko Sakkinen wrote:
> On Thu, Jul 29, 2021 at 09:39:18AM -0400, Stefan Berger wrote:
>> On 7/28/21 5:50 PM, Jarkko Sakkinen wrote:
>>> On Mon, Jul 26, 2021 at 11:00:51PM -0400, Stefan Berger wrote:
>>>> On 7/26/21 10:42 PM, Jarkko Sakkinen wrote:
>>>>> On Mon, Jul 12, 2021 at 12:25:05PM -0400, Stefan Berger wrote:
>>>>>> From: Stefan Berger <stefanb@linux.ibm.com>
>>>>>>
>>>>>> When rngd is run as root then lots of these types of message will appear
>>>>>> in the kernel log if the TPM has been configure to provide random bytes:
>>>>>>
>>>>>> [ 7406.275163] tpm tpm0: tpm_transmit: tpm_recv: error -4
>>>>>>
>>>>>> The issue is caused by the following call that is interrupted while
>>>>>> waiting for the TPM's response.
>>>>>>
>>>>>> sig = wait_event_interruptible(ibmvtpm->wq,
>>>>>>                                   !ibmvtpm->tpm_processing_cmd);
>>>>>>
>>>>>> The solution is to use wait_event() instead.
>>>>> Why?
>>>> So it becomes uninterruptible and these error messages go away.
>>> We do not want to make a process uninterruptible. That would prevent
>>> killing it.
>> I guess we'll have to go back to this one then:
>> https://www.spinics.net/lists/linux-integrity/msg16741.html
> Makes a heck lot more sense.
>
> There's a typo in the commit message: PM_STATUS_BUSY
>
> Also the commit message lacks explanation of this change completely:
>
> @@ -690,8 +688,15 @@ static int tpm_ibmvtpm_probe(struct vio_dev *vio_dev,
>   		goto init_irq_cleanup;
>   	}
>   
> -	if (!strcmp(id->compat, "IBM,vtpm20")) {
> +
> +	if (!strcmp(id->compat, "IBM,vtpm20"))
>   		chip->flags |= TPM_CHIP_FLAG_TPM2;
> +
> +	rc = tpm_get_timeouts(chip);
> +	if (rc)
> +		goto init_irq_cleanup;
> +
> +	if (chip->flags & TPM_CHIP_FLAG_TPM2) {
>   		rc = tpm2_get_cc_attrs_tbl(chip);
>
> The last paragraph should be rewritten in imperative form.


will fix.

>
> Finally, you could simplify the fix by simply changing the type of
> tpm_processing_cmd to u8, and just set it to 'true' and 'false',
> which will set the first bit.

Are you sure? It's a bit mask we are using this with. Using 'true' for 
these type of operations doesn't sound right.

         u8 status = chip->ops->status(chip);
         if ((status & chip->ops->req_complete_mask) ==
             chip->ops->req_complete_val)

             goto out_recv;

https://elixir.bootlin.com/linux/latest/source/drivers/char/tpm/tpm-interface.c#L108

@@ -457,7 +455,7 @@ static const struct tpm_class_ops tpm_ibmvtpm = {
  	.send = tpm_ibmvtpm_send,
  	.cancel = tpm_ibmvtpm_cancel,
  	.status = tpm_ibmvtpm_status,
-	.req_complete_mask = 0,
+	.req_complete_mask = TPM_STATUS_BUSY,
  	.req_complete_val = 0,
  	.req_canceled = tpm_ibmvtpm_req_canceled,
  };


    Stefan

>
> /Jarkko
