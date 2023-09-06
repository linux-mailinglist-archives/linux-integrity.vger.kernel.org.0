Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 617A87944C8
	for <lists+linux-integrity@lfdr.de>; Wed,  6 Sep 2023 22:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233023AbjIFUyS (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 6 Sep 2023 16:54:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244544AbjIFUyR (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 6 Sep 2023 16:54:17 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61916E70
        for <linux-integrity@vger.kernel.org>; Wed,  6 Sep 2023 13:54:13 -0700 (PDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 386KpESW026090;
        Wed, 6 Sep 2023 20:54:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=y7Oy3lK9qf3Oh0BgD47IldUHOTe0J6m2H9wlQvtPH7E=;
 b=UFTl4NQpWF+FUJLKSvXktfpLIEbzJDyXhdAfhy3ClulWRARJtNCz5sPe3EMqXn2bgXI0
 rwQSfTuHdFh+ObqeSUfWWzT1rJs4/Dx0ZHItmWTPzzw/BM0hAQsIjR29XunboLzx62OO
 Rqtus/T+b7B/9lX3JKpWZAxWTPwHPw9/2QWhH+kngfGRXTc3dR2FMlw28M118lrvBfxX
 0jt0A2CA4C0OgoRngQ8jatH0b9BuyRHjodUUctgPzWg53OVppNV1BZ6sst0DqYDG9MBB
 ZDB/pKLBQAH4PBDjzgcLeMLSVHCmKRPe2y1tm2GwtVcJKFOxFP3PM9/H2nl1GzmUsmDb 3g== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sy0ty82pr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Sep 2023 20:54:08 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 386Iw0BB021433;
        Wed, 6 Sep 2023 20:54:07 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
        by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3svfrypr1x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Sep 2023 20:54:07 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
        by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 386Ks63k066182
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 6 Sep 2023 20:54:07 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BFDCF58054;
        Wed,  6 Sep 2023 20:54:06 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 66BAB58062;
        Wed,  6 Sep 2023 20:54:06 +0000 (GMT)
Received: from [9.67.51.26] (unknown [9.67.51.26])
        by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Wed,  6 Sep 2023 20:54:06 +0000 (GMT)
Message-ID: <5800e76f-bae5-b3c8-9d0d-51584c93d4ad@linux.ibm.com>
Date:   Wed, 6 Sep 2023 16:54:04 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: Linux IMA documentation
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Linux Integrity <linux-integrity@vger.kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>
References: <a5ed5a0f-5692-426e-d058-983cf4d9cccb@linux.ibm.com>
 <CUUY4NO1I9DA.1S0KWKJVHQ8K5@seitikki>
 <6ea76738-f587-087d-60ea-ed03adedab62@linux.ibm.com>
 <CVAGSGSJ0NC2.1OQUGKH4ZR0ZB@suppilovahvero>
From:   Ken Goldman <kgold@linux.ibm.com>
In-Reply-To: <CVAGSGSJ0NC2.1OQUGKH4ZR0ZB@suppilovahvero>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: p0u19cpBj3twqa1B-ntfkVxdCi_2ZZKJ
X-Proofpoint-ORIG-GUID: p0u19cpBj3twqa1B-ntfkVxdCi_2ZZKJ
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-06_06,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 adultscore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 clxscore=1015 spamscore=0 mlxlogscore=999
 malwarescore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2308100000 definitions=main-2309060178
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Jonathan:  What should be my next step?

On 9/4/2023 5:52 PM, Jarkko Sakkinen wrote:
> On Fri Sep 1, 2023 at 12:46 AM EEST, Ken Goldman wrote:
>> Thank you.
>>
>> Do you know the process for getting this accepted into the kernel
>> documentation.
> 
> The bulk of the work would be to convert it ReStructured Text and
> follow the guidelines in https://docs.kernel.org/doc-guide/index.html

I think I did that.  The source .rst is at
https://github.com/IBM/ima-doc

> 
> You should also CC the documentation patches to:
> 
> * Jonathan Corbet <corbet@lwn.net> (maintainer of the documentation)
> * linux-doc@vger.kernel.org

Thank you for this.

>   
> Perhaps Mimi could help out formalizing this together so I suggest to
> work with her. I'm also happy to review the documentation once the
> patches are out.

Mimi worked with me from the beginning.
