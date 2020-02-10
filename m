Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ECF73157FD1
	for <lists+linux-integrity@lfdr.de>; Mon, 10 Feb 2020 17:30:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727640AbgBJQap (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 10 Feb 2020 11:30:45 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:8954 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727686AbgBJQap (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 10 Feb 2020 11:30:45 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01AGP9F3165028;
        Mon, 10 Feb 2020 11:30:29 -0500
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2y1u9p5pve-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Feb 2020 11:30:29 -0500
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 01AGT1XY006702;
        Mon, 10 Feb 2020 11:30:28 -0500
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2y1u9p5pum-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Feb 2020 11:30:28 -0500
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 01AGUI8A006745;
        Mon, 10 Feb 2020 16:30:27 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma02wdc.us.ibm.com with ESMTP id 2y1mm6aw4u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Feb 2020 16:30:27 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01AGUQ8B14484412
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Feb 2020 16:30:26 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 939A812406E;
        Mon, 10 Feb 2020 16:30:26 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 693B612405B;
        Mon, 10 Feb 2020 16:30:26 +0000 (GMT)
Received: from [9.2.202.60] (unknown [9.2.202.60])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 10 Feb 2020 16:30:26 +0000 (GMT)
Subject: Re: [PATCH 1/2] crypto: sm3 - add a new alias name sm3-256
To:     Eric Biggers <ebiggers@kernel.org>,
        Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, jmorris@namei.org,
        serge@hallyn.com, linux-crypto@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200207092219.115056-1-tianjia.zhang@linux.alibaba.com>
 <20200207092219.115056-2-tianjia.zhang@linux.alibaba.com>
 <20200210031717.GA5198@sol.localdomain>
From:   Ken Goldman <kgold@linux.ibm.com>
Message-ID: <1a623251-e83a-3b70-9fbd-8e929a23f7d8@linux.ibm.com>
Date:   Mon, 10 Feb 2020 11:30:26 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200210031717.GA5198@sol.localdomain>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-10_05:2020-02-10,2020-02-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1011 mlxlogscore=899 mlxscore=0
 malwarescore=0 priorityscore=1501 impostorscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002100123
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 2/9/2020 10:17 PM, Eric Biggers wrote:
> According to https://tools.ietf.org/id/draft-oscca-cfrg-sm3-01.html,
> SM3 always produces a 256-bit hash value.  E.g., it says:
> 
> 	"SM3 produces an output hash value of 256 bits long"
> 
> and
> 
> 	"SM3 is a hash function that generates a 256-bit hash value."
> 
> I don't see any mention of "SM3-256".
> 
> So why not just keep it as "sm3" and change hash_info.c instead?
> Since the name there is currently wrong, no one can be using it yet.

Question:  Is 256 bits fundamental to SM3?  Could there ever be a 
variant in the future that's e.g., 512 bits?

