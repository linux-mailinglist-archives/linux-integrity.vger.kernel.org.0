Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 418C85288CB
	for <lists+linux-integrity@lfdr.de>; Mon, 16 May 2022 17:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245099AbiEPP1U (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 16 May 2022 11:27:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237564AbiEPP1P (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 16 May 2022 11:27:15 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A93E12752;
        Mon, 16 May 2022 08:27:12 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24GEgGDL006364;
        Mon, 16 May 2022 15:27:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=yqTm+tvG0RovaS00GJyo6FfAEwPrCerjF5IWEOA/zzM=;
 b=Ag4TlQUl824wmRC/GwTfEnnDOPZdkHgLyWppWykEVqmeZYes3WLgihPe4YXrzopnqrAS
 mGbtJcbdT8sd7iuDIat7/ItJjeNKMBqvS6SFNksrRkhWzuZCoLkjrF7af6ou9tb0DrGt
 6phpFVhrG3o06enJJRUffHuWlRmGHmTYsCIbLVKH4Bq/NEglj9DTTt51t1Xrup6D8cVL
 m8FLSaCnHMd/KkyjtH5mn/Ewk40wzR4wET3Th4VnGVYdn2JcgcVWXQ4yViSdsTqHwd7w
 CLoVZAHa6iZpyLGk3VR9T8RRA0lfwos+eB/n4w9/2eLsNLvwvaN+raBmOnWsQ8VBqr1E Tw== 
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g3rm093ju-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 May 2022 15:27:11 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24GFIWA8018273;
        Mon, 16 May 2022 15:27:10 GMT
Received: from b03cxnp07027.gho.boulder.ibm.com (b03cxnp07027.gho.boulder.ibm.com [9.17.130.14])
        by ppma01dal.us.ibm.com with ESMTP id 3g242ats8k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 May 2022 15:27:10 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp07027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24GFR9le37028224
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 May 2022 15:27:09 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2E06A78060;
        Mon, 16 May 2022 15:27:09 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AA0717805F;
        Mon, 16 May 2022 15:27:08 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon, 16 May 2022 15:27:08 +0000 (GMT)
Message-ID: <b01b3269-626f-5918-41c0-08c05518525a@linux.ibm.com>
Date:   Mon, 16 May 2022 11:27:08 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] evm: Clean up some variables
Content-Language: en-US
To:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <20220513174105.3684229-1-stefanb@linux.ibm.com>
 <6d91e146702bcaf361cb193eaca35c57e38482df.camel@linux.ibm.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <6d91e146702bcaf361cb193eaca35c57e38482df.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 3PrTYJ6z17GIOtApsFH2cJEKk5_trfXE
X-Proofpoint-ORIG-GUID: 3PrTYJ6z17GIOtApsFH2cJEKk5_trfXE
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-16_14,2022-05-16_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 spamscore=0 clxscore=1015 mlxlogscore=814 bulkscore=0
 suspectscore=0 mlxscore=0 lowpriorityscore=0 priorityscore=1501
 phishscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205160086
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 5/16/22 10:50, Mimi Zohar wrote:
> On Fri, 2022-05-13 at 13:41 -0400, Stefan Berger wrote:
>> Make hmac_tfm static since it's not used anywhere else besides the file
>> it is in.
>>
>> Remove declaration of hash_tfm since it doesn't exist.
>>
>> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> 
> Thanks, Stefan.   Both this patch and "evm: Return INTEGRITY_PASS for
> enum integrity_status value '0'"  are now queued in next-integrity.
> 
> Mimi
> 

There's also this one here:

https://lore.kernel.org/all/20220421175205.798974-1-stefanb@linux.ibm.com/
