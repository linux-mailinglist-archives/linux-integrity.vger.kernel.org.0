Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0851652C352
	for <lists+linux-integrity@lfdr.de>; Wed, 18 May 2022 21:28:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241964AbiERT0p (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 18 May 2022 15:26:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241962AbiERT0o (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 18 May 2022 15:26:44 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67B6C3969C;
        Wed, 18 May 2022 12:26:43 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24IJC4um000631;
        Wed, 18 May 2022 19:26:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=0fMn5fcB8WBRcgKZhrh/fmqe4B2CE1yWRHyP0K9nFUE=;
 b=d5Hw3Ux6clt7+X8qJL+wWkhc8kyJWI02/p47nu4FtHdwKc5z6DYhh032c/gETITbK7/v
 4OsweJXUjKPYnc8Cgy7Bf6LNVCN3pERdYoTSNAG6WUdv5R9fD2KUD5ulFLKgRYkdRm9/
 NeCQ5wTQU9vOSmF+Vd8UrX6blP8MwGz6JGDFvtAMPoikazVe4qgifg1EItdGNMFmuKrJ
 QuKu3hmt9TB+aRSb/ED8onCLcURcHaGcZNDocsq5hRn1muEx5FxnK4Df9G4g4xaQifJf
 RF3tv65X425+S6SiEahypbe+qu2xMhNsHCXgCivO/MWIlFOOH3YCqe+FcCWDP+Q+dEMA cA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g56rb09kh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 May 2022 19:26:37 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 24IJFlJs012622;
        Wed, 18 May 2022 19:26:37 GMT
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g56rb09k3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 May 2022 19:26:37 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24IJMpdO012327;
        Wed, 18 May 2022 19:26:36 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma04wdc.us.ibm.com with ESMTP id 3g4wp5bbsx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 May 2022 19:26:36 +0000
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24IJQZaU30212370
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 May 2022 19:26:35 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 256D0C6055;
        Wed, 18 May 2022 19:26:35 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A3087C6059;
        Wed, 18 May 2022 19:26:34 +0000 (GMT)
Received: from [9.211.84.41] (unknown [9.211.84.41])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed, 18 May 2022 19:26:34 +0000 (GMT)
Message-ID: <e5327191-50c5-85b5-6c01-3f43cffc142b@linux.vnet.ibm.com>
Date:   Wed, 18 May 2022 15:26:34 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH] tpm: sleep at least <...> ms in tpm_msleep()
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Johannes Holland <johannes.holland@infineon.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca
References: <20220510112902.23213-1-johannes.holland@infineon.com>
 <YnvTSqRgYkWu0qgp@kernel.org>
 <99541f08e8b554dea59334005cafb0af978f9a05.camel@linux.ibm.com>
 <eb9ef8aeab4c0284028c013a2c86b248719a46ae.camel@HansenPartnership.com>
 <YoKQchfJ//FUws7i@kernel.org>
From:   Nayna <nayna@linux.vnet.ibm.com>
In-Reply-To: <YoKQchfJ//FUws7i@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: W2-w1RYqYKLES2lZ4X-4HgpuJmeqtaTu
X-Proofpoint-GUID: xFsCr7f6tHpE9XZGLchG5KdWriWfSirK
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-18_06,2022-05-17_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 mlxlogscore=999 adultscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 mlxscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205180110
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 5/16/22 13:57, Jarkko Sakkinen wrote:
> On Thu, May 12, 2022 at 08:32:55AM -0400, James Bottomley wrote:
>> On Thu, 2022-05-12 at 08:21 -0400, Mimi Zohar wrote:
>>> On Wed, 2022-05-11 at 18:16 +0300, Jarkko Sakkinen wrote:
>>>> On Tue, May 10, 2022 at 01:29:03PM +0200, Johannes Holland wrote:
>>>>> To comply with protocol requirements, minimum polling times must
>>>>> often
>>>>> be adhered to. Therefore, a macro like tpm_msleep() should sleep
>>>>> at
>>>>> least the given amount of time (not up to the given period). Have
>>>>> tpm_msleep() sleep at least the given number of milliseconds.
>>>>>
>>>>> Signed-off-by: Johannes Holland <johannes.holland@infineon.com>
>>>>> ---
>>>>>   drivers/char/tpm/tpm.h | 4 ++--
>>>>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
>>>>> index 2163c6ee0d36..0971b55fffe3 100644
>>>>> --- a/drivers/char/tpm/tpm.h
>>>>> +++ b/drivers/char/tpm/tpm.h
>>>>> @@ -185,8 +185,8 @@ int tpm_pm_resume(struct device *dev);
>>>>>   
>>>>>   static inline void tpm_msleep(unsigned int delay_msec)
>>>>>   {
>>>>> -	usleep_range((delay_msec * 1000) - TPM_TIMEOUT_RANGE_US,
>>>>> -		     delay_msec * 1000);
>>>>> +	usleep_range(delay_msec * 1000, (delay_msec * 1000)
>>>>> +		     + TPM_TIMEOUT_RANGE_US);
>>>>>   };
>>>>>   
>>>>>   int tpm_chip_start(struct tpm_chip *chip);
>>>>> -- 
>>>>> 2.34.1
>>>>>
>>>> For this I would really like to hear a 2nd opinion from Nayna and
>>>> Mimi.
>>> This patch reverts commit 5ef924d9e2e8 ("tpm: use tpm_msleep() value
>>> as max delay").    Are you experiencing TPM issues that require it?
>> I am:
>>
>> https://lore.kernel.org/linux-integrity/1531328689.3260.8.camel@HansenPartnership.com/
>>
>> I'm about 24h into a soak test of the patch with no TPM failure so far.
>> I think it probably needs to run another 24h just to be sure, but it
>> does seem the theory is sound (my TPM gets annoyed by being poked too
>> soon) so reverting 5ef924d9e2e8 looks to be the correct action.  The
>> only other ways I've found to fix this are either revert the
>> usleep_range patch altogether or increase the timings:
>>
>> https://lore.kernel.org/linux-integrity/1531329074.3260.9.camel@HansenPartnership.com/
>>
>> Which obviously pushes the min past whatever issue my TPM is having
>> even with 5ef924d9e2e8 applied.
>>
>> Given that even the commit message for 5ef924d9e2e8 admits it only
>> shaves about 12% off the TPM response time, that would appear to be an
>> optimization too far if it's going to cause some TPMs to fail.
>>
>> James
> What if TPM started with the timings as they are now and use the
> "reverted" timings if coming up too early?  The question here is
> though,  is such complexity worth of anything or should we just
> revert and do nothing else.

TCG Specification(TCG PC Client Device Driver Design Principles, Section 
10), says - General control timeouts, denoted as TIMEOUT_A (A), 
TIMEOUT_B (B), TIMEOUT_C (C) and TIMEOUT_D (D), are the maximum waiting 
time from a certain control operation from the DD until the TPM shows 
the expected status change.

usleep_range(min, max) takes second parameter as max value which is same 
as maximum delay in our case. Thus the code is in compliance with the 
standard already. We still haven't heard back yet as to the reason for 
this change, nor if the problem is pervasive.

Lastly, a 12% improvement makes a difference or not depends on usecase. 
It did at least in our case.

Thanks & Regards,

      - Nayna

