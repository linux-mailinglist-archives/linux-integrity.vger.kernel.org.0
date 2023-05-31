Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79440718855
	for <lists+linux-integrity@lfdr.de>; Wed, 31 May 2023 19:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbjEaRVH (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 31 May 2023 13:21:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjEaRVG (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 31 May 2023 13:21:06 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DEE810F;
        Wed, 31 May 2023 10:21:02 -0700 (PDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34VHEpim009732;
        Wed, 31 May 2023 17:20:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=qs5UfhqUCmTD15CNNvZrfi8v6jrQfD2MUato+MQ/xYg=;
 b=rsL4E2NlVIMZ9KkrL1w7pI62GuPFznyushx+OBn32U3Q/Y0KMuO4ckSCtC+rKruugy/M
 Qn4nz1aB7e+vJaxnURm9zMrRKc1E9TGsRn50aml4nHiD+YSQfZtGxoF4x+fjUdVumRvv
 P5fCpkzDFnKAoCFXAphc3IPKZJwB6TUuKNDQGFM8Wrvk2UXtGaXXfwEDNKRPZGtmLllD
 NhVofsHMRsFpdIecXu7Q7uePrJTJrN2XOK3IlAIbG4uBz03IswLbDYyyTeWy5s6+hSeQ
 71F3U97CNLptbr4b07a/No03VP8YWihqDK8TVPAMC+4T9LiTPjLZCksfUeXwV++IDPVJ 2A== 
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qxa6hrghe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 31 May 2023 17:20:51 +0000
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 34VFOaeT008110;
        Wed, 31 May 2023 17:20:50 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([9.208.129.120])
        by ppma02wdc.us.ibm.com (PPS) with ESMTPS id 3qu9g8cr58-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 31 May 2023 17:20:50 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
        by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 34VHKnrV62521778
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 May 2023 17:20:49 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5CBC358053;
        Wed, 31 May 2023 17:20:49 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 664C358043;
        Wed, 31 May 2023 17:20:48 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 31 May 2023 17:20:48 +0000 (GMT)
Message-ID: <edca8d02-01d9-c328-3d3e-015d0ed61a0b@linux.ibm.com>
Date:   Wed, 31 May 2023 13:20:47 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH RFC v2] tpm: tpm_vtpm_proxy: do not reference kernel
 memory as user memory
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        linux-integrity@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Alejandro Cabrera <alejandro.cabreraaldaya@tuni.fi>,
        Jarkko Sakkinen <jarkko.sakkinen@tuni.fi>,
        stable@vger.kernel.org, Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org
References: <20230530020133.235765-1-jarkko@kernel.org>
 <b2657b55-355d-80cb-23cc-d11825f64ad1@linux.ibm.com>
 <83c010a7b8821309a023e41efbabb7e96f156eec.camel@kernel.org>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <83c010a7b8821309a023e41efbabb7e96f156eec.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: LuTckC3YOCvj5e4Bzxy2z-eWJl6DaMIC
X-Proofpoint-GUID: LuTckC3YOCvj5e4Bzxy2z-eWJl6DaMIC
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-31_12,2023-05-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 mlxscore=0
 spamscore=0 adultscore=0 mlxlogscore=604 impostorscore=0 malwarescore=0
 bulkscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305310144
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 5/31/23 13:17, Jarkko Sakkinen wrote:
> On Tue, 2023-05-30 at 13:45 -0400, Stefan Berger wrote:
>>
>> On 5/29/23 22:01, Jarkko Sakkinen wrote:
>>> From: Jarkko Sakkinen <jarkko.sakkinen@tuni.fi>
>>>
>>
>>> -	rc = copy_to_user(buf, proxy_dev->buffer, len);
>>> +	if (buf)
>>> +		rc = copy_to_user(buf, proxy_dev->buffer, len);
>>> +
>>
>> Looking through other drivers it seems buf is always expected to be a valid non-NULL pointer on file_operations.read().
>>
>>
>> https://elixir.bootlin.com/linux/latest/source/arch/x86/mm/tlb.c#L1279   simple_read_from_buffer will pass the pointer to the user buffer along and it ('to') ends up in copy_to_user(to, ...);
>>
>>
>> Same here: https://elixir.bootlin.com/linux/latest/source/security/integrity/ima/ima_fs.c#L41
> 
> It is good to mention here that IMA uses __user tagged pointers
> correctly, and it does not really compare to the vtpm driver code
> by any possible means. So let's not add illegit comparison points.

Yes, sir. Did you read David' response?
> 
> BR, Jarkko
