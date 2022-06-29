Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93EBE560264
	for <lists+linux-integrity@lfdr.de>; Wed, 29 Jun 2022 16:18:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbiF2ORA (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 29 Jun 2022 10:17:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbiF2OQ7 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 29 Jun 2022 10:16:59 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 623842ED5B;
        Wed, 29 Jun 2022 07:16:58 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25TEElIS003730;
        Wed, 29 Jun 2022 14:16:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=cHy38VAaYfwUL1rpWnFpkNYgiHgrJYl/KVo8ZW+UcrM=;
 b=eU8PvES2MDv1rWgeOGt4waBT2BpeTvMJzfYXZeu0jOhn7/f4QaXZIU2oCXg9Xh8yhMGd
 xFcCftfvts7SjW2abIhfNCae8fMezIYeEFpdxGR1Seqq38pNZprkr8WYcsC5lU1gmRyz
 B3pa63LIb0ErZv2drcuvX5QWWduVcSTM7j9qeU79TWgah5icw46NSrW6bPRhxE4Mipcz
 TWWgfaEGXt4pchopFzm5JBCH4T3rtGiXDKworScHTCsxUAtuSrwjpjdxJkcO4erLs6AG
 KwaIHbgOBMJBUCUwkSDtYbf3fvTb6eCyXyO3JbvmJZebCTv4uS2QGPezgMrrQDv2xo8O TQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h0rb580v1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Jun 2022 14:16:41 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 25TEGfHl008991;
        Wed, 29 Jun 2022 14:16:41 GMT
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h0rb580ut-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Jun 2022 14:16:41 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 25TE5xGh004496;
        Wed, 29 Jun 2022 14:16:40 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by ppma03dal.us.ibm.com with ESMTP id 3gwt0aggdq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Jun 2022 14:16:40 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 25TEGcsd25821584
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Jun 2022 14:16:38 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 982C1BE051;
        Wed, 29 Jun 2022 14:16:38 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 16305BE054;
        Wed, 29 Jun 2022 14:16:38 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed, 29 Jun 2022 14:16:38 +0000 (GMT)
Message-ID: <6e097ec9-0657-b920-89c5-cef3e95bd7ea@linux.ibm.com>
Date:   Wed, 29 Jun 2022 10:16:37 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v2 1/3] tpm: of: Move of-tree specific code from tpm
 driver into of driver
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Rob Herring <robh@kernel.org>, kexec@lists.infradead.org,
        devicetree@vger.kernel.org, linux-integrity@vger.kernel.org,
        nayna@linux.ibm.com, nasastry@in.ibm.com,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Frank Rowand <frowand.list@gmail.com>
References: <20220616154130.2052541-1-stefanb@linux.ibm.com>
 <20220616154130.2052541-2-stefanb@linux.ibm.com>
 <20220627224325.GB3082294-robh@kernel.org>
 <170c78f7-f0ba-c186-dacf-55759dae9b83@linux.ibm.com>
 <Yru83e4OLW7vH5/o@kernel.org>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <Yru83e4OLW7vH5/o@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: tIUxx4YKQ9ejkBKzzE9b6Rri7pkvOR0z
X-Proofpoint-GUID: _H4DtsbsPJ0mRAmXjonrw9KfRF1GT3s2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-06-29_17,2022-06-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 mlxscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 mlxlogscore=999 spamscore=0 bulkscore=0 impostorscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206290052
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 6/28/22 22:45, Jarkko Sakkinen wrote:
> On Tue, Jun 28, 2022 at 09:29:48AM -0400, Stefan Berger wrote:
>>
>>
>> On 6/27/22 18:43, Rob Herring wrote:
>>> On Thu, Jun 16, 2022 at 11:41:28AM -0400, Stefan Berger wrote:
>>>> Simplify tpm_read_log_of() by moving Openfirmware-specific code into
>>>> the Openfirmware driver to make the code reusable. Call the new
>>>
>>> There is no such 'Openfirmware driver'.
>>>
>>>> of_tpm_get_sml_parameters() function from the TPM Openfirmware driver.
>>>>
>>>> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
>>>> Cc: Jarkko Sakkinen <jarkko@kernel.org>
>>>> Cc: Jason Gunthorpe <jgg@ziepe.ca>
>>>> Cc: Rob Herring <robh+dt@kernel.org>
>>>> Cc: Frank Rowand <frowand.list@gmail.com>
>>>> ---
>>>>    drivers/char/tpm/eventlog/of.c | 31 +++++--------------------------
>>>>    drivers/of/Makefile            |  2 +-
>>>>    drivers/of/device_node.c       | 27 +++++++++++++++++++++++++++
>>>
>>> Humm, definitely the wrong direction. Generally, code for specific
>>> bindings does not go in drivers/of/. There used to be some, but we've
>>> moved it to the appropriate subsystems. kexec was an exception to not
>>> have 2 copies of the same code in arch/.
>>
>> The function I am moving here is called by the TPM subsystem and also now by
>> of/kexec.c. The latter is compiled under the following conditions:
>>
>> ifdef CONFIG_KEXEC_FILE
>> ifdef CONFIG_OF_FLATTREE
>> obj-y	+= kexec.o
>> endif
>> endif
>>
>> The code that current calls it is compiled under the following conditions:
>>
>> tpm-$(CONFIG_OF) += eventlog/of.o
>>
>> To make it available to both I could keep it in the TPM subsystem like this:
>>
>> obj-$(CONFIG_OF) = tpm_of.o
>>
>>
>> Jarrko, if you read this, any comment?
>>
>>
>>     Stefan
> 
> Why can't you convert of_tpm_get_sml_parameters() to inline function?

I can do that and put it into include/linux/tpm.h. The only concern 
would have been the size of the function.

Thanks,
    Stefan

> 
> BR, Jarkko
