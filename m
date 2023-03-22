Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4294A6C5937
	for <lists+linux-integrity@lfdr.de>; Wed, 22 Mar 2023 23:02:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbjCVWCa (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 22 Mar 2023 18:02:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjCVWC3 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 22 Mar 2023 18:02:29 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 158F4F945;
        Wed, 22 Mar 2023 15:02:26 -0700 (PDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32MKtcG1026249;
        Wed, 22 Mar 2023 22:02:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=b1hWqyStuJqgkeHSvZyfkZYcZFtQsIkyr0dS2JMrN4k=;
 b=dW09PpEXHlQSf7eXdmUDycqJ7eK8+oAx83OoozycelOAc7rSI4gfHntb4PrjBwV2Okfd
 kxQ9kxJntRyvrx2+1YluNabQSuPlhYDvSvWnN3ewY9M5qkev5IBGShZg6xcvnJ8SlRah
 DTYYbbhGNeEzWjO6I+yHVOYafP89eKb1xt9jAEpBpBol/je14MOuPpbEF5VUYJTBrzhq
 opk1QSGBtIsfpavfdya2yyJhxp3XDD1MqLKNAzuCLi+bZG7ldKbcE3rdL8VdxxAatbAL
 O4YwhaT9DEJVXLhE5vSBf5QQziOD2tFPpWeDFkNnCxqYT+h4DQPKgGCluhHHT0zQYKE+ rA== 
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3pg9511ayt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Mar 2023 22:02:25 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32MJURHc000573;
        Wed, 22 Mar 2023 22:02:24 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([9.208.129.114])
        by ppma02dal.us.ibm.com (PPS) with ESMTPS id 3pd4x7s38m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Mar 2023 22:02:24 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
        by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32MM2MP135521048
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Mar 2023 22:02:23 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D521D5805F;
        Wed, 22 Mar 2023 22:02:22 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 936105805D;
        Wed, 22 Mar 2023 22:02:22 +0000 (GMT)
Received: from [9.160.167.235] (unknown [9.160.167.235])
        by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 22 Mar 2023 22:02:22 +0000 (GMT)
Message-ID: <c03bf464-00c1-9121-fb2f-549ac991a658@linux.ibm.com>
Date:   Wed, 22 Mar 2023 18:02:21 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: Documentation on IMA for Linux Kernel Documentation
Content-Language: en-US
To:     linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
References: <7c91820d-0153-e4db-1c60-38b6f650ed20@linux.ibm.com>
 <60ac4c41-65b8-3c3d-7e31-1a580e728ca5@infradead.org>
 <a50110ca-843a-7586-ed2a-aca12702dde9@infradead.org>
From:   Ken Goldman <kgold@linux.ibm.com>
In-Reply-To: <a50110ca-843a-7586-ed2a-aca12702dde9@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: gvFzRzoDkj-z6h-mai3QeA9LTzY2i0Bm
X-Proofpoint-GUID: gvFzRzoDkj-z6h-mai3QeA9LTzY2i0Bm
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-22_18,2023-03-22_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 lowpriorityscore=0 impostorscore=0 bulkscore=0 spamscore=0 mlxscore=0
 mlxlogscore=635 suspectscore=0 priorityscore=1501 phishscore=0
 malwarescore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2303150002 definitions=main-2303220154
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 3/13/2023 6:34 PM, Randy Dunlap wrote:
> On 3/13/23 15:25, Randy Dunlap wrote:
>> [add IMA list]
>>
>> On 3/13/23 14:43, Ken Goldman wrote:
>>> I'm writing documentation on IMA targeting users (not kernel developers).  It includes concepts, details on writing policies, the IMA event log format, utilities, and more.  It aggregates existing scattered documentation, but adds much more.  It's maybe 1/2 done.
>>>
>>> Questions:
>>>
>>> 1. Are there people who could look at it and see if I'm on the right path?
>>>
>>> It's a lot of work.  I'd like to know that it has some chance of acceptance.
>>>
>>> 2. What is the process for getting a block of documentation added to https://www.kernel.org/doc/html?
>>
>> It should be added to the kernel tree in the Documentation/userspace-api/ subdirectory
>> or Documentation/security/ subdirectory.  The kernel.org/doc/ web pages are generated
>> from what is in the Linux kernel tree.
> Ken, if you are not familiar with in-tree kernel documentation, you should take a look
> at the Documentation/doc-guide/ subdirectory for some documentation on the documentation.
>
> Also you can ask for help with specific issues at linux-doc@vger.kernel.org

I've read the guidelines, coding in rest markdown, using sphinx to test 
the web pages.  I think it's right.

1. I was hoping that someone could look at what I'm doing to see if it 
has a chance of acceptance.

I.e., I don't want to spend months on this only to get a quick 'nack'.

2. I wonder what the process for submission is.

