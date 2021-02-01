Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6BCA30ACA4
	for <lists+linux-integrity@lfdr.de>; Mon,  1 Feb 2021 17:32:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbhBAQ3m (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 1 Feb 2021 11:29:42 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:16010 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230124AbhBAQ3j (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 1 Feb 2021 11:29:39 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 111GSfoE179195;
        Mon, 1 Feb 2021 11:28:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=WXJ3sG6uWEMRNmnT/QdS/LYmyndP6SFOZ2x6NqGshbM=;
 b=EoAXGaAZRCv8HcreZ5K45+KDngq1x+AjGrHcsgqBK7RnJz5TbuYrH2dkfcwTwqC7A9hL
 OUygrFj6sbTPyCvo3rEzdZlnJ6za9/y516ClegrOSTehtFjzyCEdLWFBlOA8XZWJc1XY
 T/50OJlyge4LQNe1AiF9xHtLzn6owKFCPBi/cqM1hHbq+7xpL07hr5VDPYBK2yEP9U6s
 xXwG5rKRuH/8zG59GBMxhvKbU3XktdKbRjR4832+TtSxtGQ8+QpXbGtaVDxBdpd6ek6q
 ozVxS8Q8xtP4Xq+5/y3yIz68rqHy++hn0sT+GrvPL2X/v9/ORy22tS1t3MLoAXvcBIe2 jQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36emrggxff-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 01 Feb 2021 11:28:50 -0500
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 111GShw5179472;
        Mon, 1 Feb 2021 11:28:49 -0500
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36emrggxc4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 01 Feb 2021 11:28:49 -0500
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 111GI4uJ005970;
        Mon, 1 Feb 2021 16:28:46 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma03wdc.us.ibm.com with ESMTP id 36cy38qu5f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 01 Feb 2021 16:28:46 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 111GSkkI19530158
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 1 Feb 2021 16:28:46 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2EF0DAC064;
        Mon,  1 Feb 2021 16:28:46 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1C473AC05F;
        Mon,  1 Feb 2021 16:28:46 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon,  1 Feb 2021 16:28:46 +0000 (GMT)
Subject: Re: [PATCH v7 0/4] Add support for x509 certs with NIST p256 and p192
 keys
To:     David Howells <dhowells@redhat.com>
Cc:     keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        davem@davemloft.net, herbert@gondor.apana.org.au,
        zohar@linux.ibm.com, linux-kernel@vger.kernel.org,
        patrick@puiterwijk.org, linux-integrity@vger.kernel.org
References: <20210201151910.1465705-1-stefanb@linux.ibm.com>
 <32177.1612196003@warthog.procyon.org.uk>
From:   Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <7836898a-0a42-5c9b-3a42-7ff4c7a03ea4@linux.ibm.com>
Date:   Mon, 1 Feb 2021 11:28:45 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <32177.1612196003@warthog.procyon.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-01_06:2021-01-29,2021-02-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 mlxlogscore=999 bulkscore=0 spamscore=0
 lowpriorityscore=0 mlxscore=0 malwarescore=0 clxscore=1015 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102010084
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 2/1/21 11:13 AM, David Howells wrote:
> Stefan Berger <stefanb@linux.ibm.com> wrote:
>
>> v6->v7:
>>    - Moved some OID defintions to patch 1 for bisectability
>>    - Applied R-b's
> But I can't now apply 2-4 without patch 1.

Two possible solutions:

1) the whole series goes through the crypto tree

2) I make the OIDs addition patch 1 that both keyrings and crypto take 
separately?


   Stefan


