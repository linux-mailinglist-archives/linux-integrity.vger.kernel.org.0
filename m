Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC25230A9E6
	for <lists+linux-integrity@lfdr.de>; Mon,  1 Feb 2021 15:36:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbhBAOf7 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 1 Feb 2021 09:35:59 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60930 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230210AbhBAOf5 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 1 Feb 2021 09:35:57 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 111EVi23006364;
        Mon, 1 Feb 2021 09:35:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=NH960khcaH5kqbSEa5tOHjMKvP9yY4aVTJT8WCDyZtY=;
 b=jLXfQy+gulAmt53VGsFZBMHFQxQj5iTt7F9Nm8WILDOLj57uTkOUBZtplv3TM25kUu6p
 qE0LcZozT1HSFIg5qcRaNoIPkIqfDlMl9oSUV92e5RopAF4Yo5XbX6w3bd+hos6lvciL
 bpP1yTiXpQfuvTWujdSMY1bAgtDBhzD9KgsaaeHn0itgIac5jFsO7cvj8bhuafl9Dqo6
 B2d4PISyuwW0KGTCV0Lj/zByLjMKVO2XInjFnS7PLl1BA//S7F+LhrE6qTLr7ZajUZwK
 zWFAbHL5tzdpHgwZ4uhtkttrZb0eoBn/ZWLQrdakuzaJSIo/oryGlRBh7gjj9ysr+s1N Dg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36ejbp2rcg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 01 Feb 2021 09:35:10 -0500
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 111EWvYJ012960;
        Mon, 1 Feb 2021 09:35:09 -0500
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36ejbp2ray-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 01 Feb 2021 09:35:09 -0500
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 111EOsCB015586;
        Mon, 1 Feb 2021 14:35:08 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
        by ppma02wdc.us.ibm.com with ESMTP id 36cy38y1ue-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 01 Feb 2021 14:35:08 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 111EZ7Mn16318802
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 1 Feb 2021 14:35:07 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A5E9EAC065;
        Mon,  1 Feb 2021 14:35:07 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9310AAC05E;
        Mon,  1 Feb 2021 14:35:07 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon,  1 Feb 2021 14:35:07 +0000 (GMT)
Subject: Re: [PATCH v5 2/4] x509: Detect sm2 keys by their parameters OID
To:     David Howells <dhowells@redhat.com>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc:     keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, patrick@puiterwijk.org,
        linux-integrity@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>
References: <20210129150355.850093-3-stefanb@linux.vnet.ibm.com>
 <20210129150355.850093-1-stefanb@linux.vnet.ibm.com>
 <4162801.1612185801@warthog.procyon.org.uk>
From:   Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <71a77d10-e645-194f-5073-ebf180a8d70e@linux.ibm.com>
Date:   Mon, 1 Feb 2021 09:35:07 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <4162801.1612185801@warthog.procyon.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-01_05:2021-01-29,2021-02-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 mlxscore=0 malwarescore=0 suspectscore=0 clxscore=1015
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2102010073
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 2/1/21 8:23 AM, David Howells wrote:
> Stefan Berger <stefanb@linux.vnet.ibm.com> wrote:
>
>> From: Stefan Berger <stefanb@linux.ibm.com>
>>
>> Detect whether a key is an sm2 type of key by its OID in the parameters
>> array rather than assuming that everything under OID_id_ecPublicKey
>> is sm2, which is not the case.
>>
>> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
>> Cc: David Howells <dhowells@redhat.com>
>> Cc: keyrings@vger.kernel.org
> I presume these cc's are intentionally not on the first patch or the cover (if
> there is one)?

No, this is not intentional. I guess this is a case of wrong use of cc: 
versus mailing lists - my bad. I posted the whole series to 
linux-crypto, linux-integrity, keyrings and lkml.

V6 is at least visible here now:

- https://lkml.org/lkml/2021/1/31/323

- https://marc.info/?l=linux-crypto-vger&m=161213604618722&w=2

- 
https://lore.kernel.org/linux-integrity/20210131233301.1301787-1-stefanb@linux.ibm.com/T/#mbc9fae5facb4178f64c1145e2654258c0af8fa96

- https://marc.info/?l=linux-keyrings&m=161213608818735&w=2



>
> Do you have a branch you want me to pull or did you want me to take just
> patches 2-4?

Please take it from the mailing list. If there are requests for more 
changes on the crypto level, I will send another series. I personally am 
waiting for some sort of verdict on the crypto level...

    Stefan


