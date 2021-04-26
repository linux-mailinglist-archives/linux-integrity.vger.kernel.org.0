Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD2F036B505
	for <lists+linux-integrity@lfdr.de>; Mon, 26 Apr 2021 16:37:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233294AbhDZOiO (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 26 Apr 2021 10:38:14 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:22098 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232575AbhDZOiO (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 26 Apr 2021 10:38:14 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13QEWwRW072667;
        Mon, 26 Apr 2021 10:37:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=dIR8qG+fZkjKx3j7arXn5imLXqkq2cTjPJyuy5kjYco=;
 b=aWmoFan4j0muEg/S825aP4IzMh+/36Cf65CkCTuymgotwkWre0ODG7768UGs+QaRlguT
 CFXBvcro2d8wm1arFk8pQHtD+wW4HdUQcV0fVptGxsr72xS2Ole5nskyZ4YosYuSXDKU
 oxdDPAvP12QSxCjx9F6N5QIe6uEPWwdGJyN9rF8sI5jQ1qOc9RZNSpH9QNYD1Ti00llx
 A/Ve5V+4h6yymXABX9GGxs08rpi/EMQaQ+VKMAOz0/VjNI/uXTws86tqgb3btp9PCqwY
 xYeiUQPEaoVjQ75208jyOU4FeKGQDpNdymoWzqn4OptPjbgbthgNNvJCBqTGRHpuZw6m Wg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 385xfbtjct-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Apr 2021 10:37:26 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 13QEXFah073564;
        Mon, 26 Apr 2021 10:37:26 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 385xfbtjc5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Apr 2021 10:37:25 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13QEb45p018141;
        Mon, 26 Apr 2021 14:37:25 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com [9.57.198.23])
        by ppma04dal.us.ibm.com with ESMTP id 384ay9afdp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Apr 2021 14:37:25 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 13QEbOvL34603460
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Apr 2021 14:37:24 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3BA6BAC05F;
        Mon, 26 Apr 2021 14:37:24 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 29B11AC05E;
        Mon, 26 Apr 2021 14:37:24 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 26 Apr 2021 14:37:24 +0000 (GMT)
Subject: Re: [PATCH v2 1/4] tpm: Use a threaded interrupt handler
To:     Lino Sanfilippo <LinoSanfilippo@gmx.de>, peterhuewe@gmx.de,
        jarkko@kernel.org, jgg@ziepe.ca
Cc:     stefanb@linux.vnet.ibm.com, James.Bottomley@hansenpartnership.com,
        keescook@chromium.org, jsnitsel@redhat.com, ml.linux@elloe.vision,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1619394440-30646-1-git-send-email-LinoSanfilippo@gmx.de>
 <1619394440-30646-2-git-send-email-LinoSanfilippo@gmx.de>
From:   Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <d6bf7eef-acfd-b9a0-9892-8309079684e5@linux.ibm.com>
Date:   Mon, 26 Apr 2021 10:37:23 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <1619394440-30646-2-git-send-email-LinoSanfilippo@gmx.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: H9oGXGdNxmJDpC5gO_lrsSNUVDxZdFK7
X-Proofpoint-ORIG-GUID: Jh8jNyDJEWdZAhmkBuiueWmFMbYSB531
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-26_07:2021-04-26,2021-04-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 mlxscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 adultscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0 mlxlogscore=805
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104260114
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 4/25/21 7:47 PM, Lino Sanfilippo wrote:
> Interrupt handling at least includes reading and writing the interrupt
> status register from the interrupt routine. However over SPI those accesses
> require a sleepable context, since a mutex is used in the concerning
> functions.
> For this reason request a threaded interrupt handler which is running in
> (sleepable) process context.
>
> Signed-off-by: Lino Sanfilippo <LinoSanfilippo@gmx.de>


Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>


