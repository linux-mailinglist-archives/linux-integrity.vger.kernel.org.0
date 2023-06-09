Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 193FE72A28F
	for <lists+linux-integrity@lfdr.de>; Fri,  9 Jun 2023 20:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbjFISuJ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 9 Jun 2023 14:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjFISuI (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 9 Jun 2023 14:50:08 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D1E13A81;
        Fri,  9 Jun 2023 11:50:07 -0700 (PDT)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 359IlA3R001149;
        Fri, 9 Jun 2023 18:49:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=myGzGs2NawOBCwWz7+upUz/JwK6dQ3oOlKG8artjLsg=;
 b=Tlg2h+4k+8omqvp18PZBG69LYolCdOgFacEckvNHPvQX1jTTKCFC+TNkGivoe/AclTpa
 22LLDWt8RrmwRfrpfwF8V0VnLFPr+eVUkU8F1F59DUjplMwvEVXnzq/ap+K0CmOJp2Xp
 FyuhXtuv4AEyjwxzUZLl3c8BQ9KZeaibZzT/riHzE21lSwv6N/VBCt/gL7HgGqvF4t1U
 pR3PRa4e46xwNcF/ixiLU1uJBzjYd5R61bXT/qg22tfnhJK+U8ppPCoL8v30d41gEbaj
 tcVPvYq0XYUrS1POto4RFDj6TLjLB5t/MBNEf5H9YOD/C7iLhafsqddfBiz8advqlaqu jg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3r49nkr3av-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Jun 2023 18:49:45 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 359IniJb009506;
        Fri, 9 Jun 2023 18:49:45 GMT
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3r49nkr3ah-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Jun 2023 18:49:44 +0000
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 359IAhWv022632;
        Fri, 9 Jun 2023 18:49:43 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([9.208.130.101])
        by ppma03wdc.us.ibm.com (PPS) with ESMTPS id 3r2a77q2c2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Jun 2023 18:49:43 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
        by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 359Ingwv6292016
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 9 Jun 2023 18:49:42 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 29E905805D;
        Fri,  9 Jun 2023 18:49:42 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7A91358054;
        Fri,  9 Jun 2023 18:49:40 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Fri,  9 Jun 2023 18:49:40 +0000 (GMT)
Message-ID: <4afde78d-e138-9eee-50e0-dbd32f4dcfe0@linux.ibm.com>
Date:   Fri, 9 Jun 2023 14:49:35 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v9 2/4] tpm: of: Make of-tree specific function commonly
 available
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Jerry Snitselaar <jsnitsel@redhat.com>
Cc:     kexec@lists.infradead.org, devicetree@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, nayna@linux.ibm.com,
        nasastry@in.ibm.com, mpe@ellerman.id.au,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Nageswara R Sastry <rnsastry@linux.ibm.com>,
        Coiby Xu <coxu@redhat.com>
References: <20230418134409.177485-1-stefanb@linux.ibm.com>
 <20230418134409.177485-3-stefanb@linux.ibm.com>
 <e4dcxwp63uisirxwanjwrhzrnve45wqnxhijfp4oq274r4neco@v2btoy43ue5h>
 <CT8BRJZS8RQU.9ICEA2UAFC7G@suppilovahvero>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <CT8BRJZS8RQU.9ICEA2UAFC7G@suppilovahvero>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: vnMB3zCx4Hhs6QhKY0JaE9KiteMDLAjg
X-Proofpoint-ORIG-GUID: ekM5eMhdXay5_PWqimPauZQ9QWzNxbDb
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-09_14,2023-06-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=881 impostorscore=0 malwarescore=0 bulkscore=0 mlxscore=0
 phishscore=0 adultscore=0 suspectscore=0 priorityscore=1501 clxscore=1011
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306090155
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 6/9/23 14:18, Jarkko Sakkinen wrote:
> On Thu May 25, 2023 at 1:56 AM EEST, Jerry Snitselaar wrote:
>> On Tue, Apr 18, 2023 at 09:44:07AM -0400, Stefan Berger wrote:
>>> Simplify tpm_read_log_of() by moving reusable parts of the code into
>>> an inline function that makes it commonly available so it can be
>>> used also for kexec support. Call the new of_tpm_get_sml_parameters()
>>> function from the TPM Open Firmware driver.
>>>
>>> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
>>> Cc: Jarkko Sakkinen <jarkko@kernel.org>
>>> Cc: Jason Gunthorpe <jgg@ziepe.ca>
>>> Cc: Rob Herring <robh+dt@kernel.org>
>>> Cc: Frank Rowand <frowand.list@gmail.com>
>>> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
>>> Tested-by: Nageswara R Sastry <rnsastry@linux.ibm.com>
>>> Tested-by: Coiby Xu <coxu@redhat.com>
>>> Acked-by: Jarkko Sakkinen <jarkko@kernel.org>
>>>
>>
>> Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
> 
> If I just pick tpm only patches they won't apply so maybe TPM changes
> should be better separated if that is by any means possible.

Per the comment here I am putting this series here on hold.
https://lore.kernel.org/linux-integrity/20230418134409.177485-1-stefanb@linux.ibm.com/T/#m03745c2af2c46f19f329522fcb6ccb2bf2eaedc7


BR,
    Stefan
