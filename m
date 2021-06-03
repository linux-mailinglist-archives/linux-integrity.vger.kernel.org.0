Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8721039A103
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Jun 2021 14:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbhFCMex (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 3 Jun 2021 08:34:53 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:29920 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229876AbhFCMex (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 3 Jun 2021 08:34:53 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 153C4AJP095306;
        Thu, 3 Jun 2021 08:33:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=Hwq66EGg2XWj2KdlQHVnfsT2F/0lkUQs+MW4ZqGdRA4=;
 b=laXiT9UoghEtzk1UZPSouu9/kvpQMQDYtbULJGs07q8d0BilLR7VdiMHJcZBBV2fnznA
 hZM3XHb5fjMumDKkMzpZmnP14T2DAP9NKnKvEDon/GUN7/o0mKX95QZ1jYGSk6SBSjSt
 hxSOo39mD5ZlumAs5CB3b2H/cSqMMvJa+ycPa/CPMWcFPkpDrj3AEhJ4+W5M4wjIGSKJ
 RZJcHnmcNsmMSkV3b3H2e4Kx22TbCuzIR7w7KTuj9aQreFD4bd11Emr78N3vWR5whypt
 U7a5qt2XxGSxH8/bej/0y6itqNW5TZcihyOk4klec1V/aiCsh0PYkr1iIRsOvHL4MEqA qw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38xxfqsftp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Jun 2021 08:33:02 -0400
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 153C4KLl096737;
        Thu, 3 Jun 2021 08:33:02 -0400
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38xxfqsftc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Jun 2021 08:33:02 -0400
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 153CWx3C007336;
        Thu, 3 Jun 2021 12:33:01 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
        by ppma02wdc.us.ibm.com with ESMTP id 38ud89yn7e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Jun 2021 12:33:01 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 153CX0Kj20513066
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 3 Jun 2021 12:33:00 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7351478064;
        Thu,  3 Jun 2021 12:33:00 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CE93878063;
        Thu,  3 Jun 2021 12:32:59 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu,  3 Jun 2021 12:32:59 +0000 (GMT)
Subject: Re: [PATCH v5 0/2] Add support for ECDSA-signed kernel modules
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     jeyu@kernel.org, keyrings@vger.kernel.org, dhowells@redhat.com,
        dwmw2@infradead.org, zohar@linux.ibm.com, nayna@linux.ibm.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210602143537.545132-1-stefanb@linux.ibm.com>
 <20210603064738.pwfq3n7erzmncdmw@kernel.org>
From:   Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <8b79651b-1fe4-48c0-3498-529344ac6243@linux.ibm.com>
Date:   Thu, 3 Jun 2021 08:32:59 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210603064738.pwfq3n7erzmncdmw@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: BZYzHRmbjzbEdXfphBXsqbIrb3K_9DcV
X-Proofpoint-ORIG-GUID: TvOPFa_85iNyyTwlcLODZfjyx3dfeXLe
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-03_08:2021-06-02,2021-06-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 phishscore=0 clxscore=1015 mlxscore=0 priorityscore=1501
 malwarescore=0 mlxlogscore=919 impostorscore=0 bulkscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106030082
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 6/3/21 2:47 AM, Jarkko Sakkinen wrote:
>
>> -- 
>> 2.29.2
>>
>>
> Please instead send a fix.

We have a Fixes tag in 1/2, so we want this to propagate to older 
kernels and need the fix in 1/2 for that reason.

    Stefan


