Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3210078F4C8
	for <lists+linux-integrity@lfdr.de>; Thu, 31 Aug 2023 23:46:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245250AbjHaVqt (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 31 Aug 2023 17:46:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230514AbjHaVqs (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 31 Aug 2023 17:46:48 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CD9B107
        for <linux-integrity@vger.kernel.org>; Thu, 31 Aug 2023 14:46:46 -0700 (PDT)
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37VLg5DX030166;
        Thu, 31 Aug 2023 21:46:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=8xpEtcpba8Fu+wcSZ0gfLV2T3vOSLxEfWXwq2NvtFMA=;
 b=j3Pip1SOv88aS/qJeQL2eJ/mlhzgVUpsSVCLXpgWLDrRWy9P8ErwU6LKC2JBgWzrVyA8
 riehspFUEMUxXs67TAjzGScuhRT1inoUYq8Zi62YwquHYiVPprhQf8+bHg6fM8u/32jC
 4gJaN+np9QoabCTKszZlpiTD0QnXnd7bu943VfzTWpk0XX1AV7+qJXPsK6OuJ5N4QCMf
 GOCvF34IwbDbb7HYae+DV/kgfC1tK1SDhKM9Cm4vuLgctBtEa+G1rQ/vI7w7Ks9TRrAC
 5K6rwVAjkueaH56AKjuOUkzQSd03i9O9TxLNteM68TTcrLGigSBdNrhEPXQhYiYj/NHx 8w== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sty82xsxu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 31 Aug 2023 21:46:36 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37VKK6Mv014342;
        Thu, 31 Aug 2023 21:46:36 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
        by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3sqvqnqww3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 31 Aug 2023 21:46:36 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
        by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37VLkZvn57475544
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Aug 2023 21:46:35 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B245258053;
        Thu, 31 Aug 2023 21:46:35 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6ACB858043;
        Thu, 31 Aug 2023 21:46:35 +0000 (GMT)
Received: from [9.67.121.70] (unknown [9.67.121.70])
        by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 31 Aug 2023 21:46:35 +0000 (GMT)
Message-ID: <6ea76738-f587-087d-60ea-ed03adedab62@linux.ibm.com>
Date:   Thu, 31 Aug 2023 17:46:35 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: Linux IMA documentation
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Linux Integrity <linux-integrity@vger.kernel.org>
References: <a5ed5a0f-5692-426e-d058-983cf4d9cccb@linux.ibm.com>
 <CUUY4NO1I9DA.1S0KWKJVHQ8K5@seitikki>
From:   Ken Goldman <kgold@linux.ibm.com>
In-Reply-To: <CUUY4NO1I9DA.1S0KWKJVHQ8K5@seitikki>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: a8ZYwLHphH4vwTnEQk3WOhIVVlqHVs-2
X-Proofpoint-GUID: a8ZYwLHphH4vwTnEQk3WOhIVVlqHVs-2
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-31_19,2023-08-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 phishscore=0 suspectscore=0 priorityscore=1501 adultscore=0 malwarescore=0
 clxscore=1015 mlxlogscore=687 bulkscore=0 lowpriorityscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2308310193
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Thank you.

Do you know the process for getting this accepted into the kernel 
documentation.

It's not ready today, but I should start on the process/

On 8/17/2023 12:04 PM, Jarkko Sakkinen wrote:
> On Wed Aug 16, 2023 at 9:42 PM UTC, Ken Goldman wrote:
>> Is this the right place to announce this?  If not, let me know.
>>
>> https://ima-doc.readthedocs.io/en/latest/index.html
>>
>> This is a first pass at IMA documentation.  It's targeted at users, not
>> kernel developers.
>>
>> Some areas are clearly incomplete, but I don't think there is anything
>> incorrect.
>>
>> Suggestions, contributions, corrections are all welcome.
>>
>> The source is at https://github.com/IBM/ima-doc
> 
> Looks useful for non-IMA kernel developers too IMHO, thanks for doing
> this.
> 
> BR, Jarkko
