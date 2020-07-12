Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45CF721CB9A
	for <lists+linux-integrity@lfdr.de>; Sun, 12 Jul 2020 23:38:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729398AbgGLVic (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 12 Jul 2020 17:38:32 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:17708 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729020AbgGLVic (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 12 Jul 2020 17:38:32 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06CL5n5l173916;
        Sun, 12 Jul 2020 17:38:21 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3279a9gh3f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 12 Jul 2020 17:38:21 -0400
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06CLA2aW183068;
        Sun, 12 Jul 2020 17:38:20 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3279a9gh3b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 12 Jul 2020 17:38:20 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06CLYVpK002798;
        Sun, 12 Jul 2020 21:38:20 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
        by ppma01dal.us.ibm.com with ESMTP id 3275286733-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 12 Jul 2020 21:38:19 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06CLcIQd58065278
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 12 Jul 2020 21:38:18 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A2217136059;
        Sun, 12 Jul 2020 21:38:18 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0C9B413604F;
        Sun, 12 Jul 2020 21:38:17 +0000 (GMT)
Received: from [9.85.134.145] (unknown [9.85.134.145])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Sun, 12 Jul 2020 21:38:17 +0000 (GMT)
Subject: Re: [PATCH v5 4/6] security: keys: trusted: use ASN.1 TPM2 key format
 for the blobs
To:     James Prestwood <prestwoj@gmail.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>, keyrings@vger.kernel.org
References: <20200130101812.6271-1-James.Bottomley@HansenPartnership.com>
 <20200130101812.6271-5-James.Bottomley@HansenPartnership.com>
 <5c593b6f23ae41e90e6b3799141ea68944bb4034.camel@gmail.com>
 <1582761736.4245.12.camel@HansenPartnership.com>
 <f9b64fe39eb71a1560ca2d1887238d0b4f9f111a.camel@gmail.com>
 <1582764844.4245.29.camel@HansenPartnership.com>
 <17e025e222cb6aefb5680d6cdad64a9ecf76fa97.camel@gmail.com>
 <1582834760.18538.15.camel@HansenPartnership.com>
 <3feaa7a3265b472bb3694045448fc44368f1fb99.camel@gmail.com>
From:   Ken Goldman <kgold@linux.ibm.com>
Message-ID: <34d5fef9-1baf-83a8-3e54-5065ea96f412@linux.ibm.com>
Date:   Sun, 12 Jul 2020 17:38:16 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <3feaa7a3265b472bb3694045448fc44368f1fb99.camel@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-12_13:2020-07-10,2020-07-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 impostorscore=0 priorityscore=1501 suspectscore=0
 clxscore=1011 spamscore=0 malwarescore=0 phishscore=0 mlxlogscore=999
 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007120169
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 2/27/2020 3:57 PM, James Prestwood wrote:
> I am learning lots from this discussion, so thank you. I had assumed
> that the parent key crypto had to match the child key, RSA vs EC, but
> sounds like that is not the case. And yes, this sounds like a much
> better way to go now that I have a bit more info on it.

I know this old.  Just FYI:

The TPM WG debated this for a while, but decided that the TPM should not
enforce parent / child algorithm matching.  It's for the application to 
decide.

I also note that parent keys wrap their child keys using a symmetric
key, typically AES, not an RSA or ECC key.  The load time would be the 
same for an ECC or RSA parent, because it's not using the asymmetric
key.

This different from TPM 1.2, which always uses parent RSA wrapping.

The asymmetric key is used for:

1 - import (key backup, using externally generated keys)
2 - Salted sessions

While both are useful, they're not typically used in a
critical path.




