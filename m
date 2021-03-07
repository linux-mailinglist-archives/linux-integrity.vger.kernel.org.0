Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2D9E32FE4F
	for <lists+linux-integrity@lfdr.de>; Sun,  7 Mar 2021 02:22:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbhCGBVk (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 6 Mar 2021 20:21:40 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51248 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229853AbhCGBVU (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 6 Mar 2021 20:21:20 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12712fQF190420;
        Sat, 6 Mar 2021 20:21:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=G5mSRo0y5jOHQ4SXS4quhgDX4tam3PZzn1nNJxhlcSo=;
 b=S08sys6rivGCNZFAvih1RzaTteVf8UsXNCivpW3FcxpOc10CQNu2D7vYhAY21kEfqzkp
 oDFfqzmNT0mfDgka+RTr0Jigvu2CwFWpUBoQBwVuQ+pOqZXJ7ZcnX2h5YmMsgDZE4Pk1
 K+u1W0AAqiggRgMn3gntgGnxykZn7isBhhtxhUEDO6z3N3k6cf6OAspwKITGdw0nA8e8
 Dr3UOf+goLBCMksm/8MGUj6jmzWvcVmL5JkgOtw3O8qrJjdEMMKMT3X0erroY1qRCj3E
 AHgtIyZKY4x+cPpwU08hi3j45fa7mQ5yLDxdXSqPU6UNhZBxIytaJMFTW0nSpI9dM2Fa vw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 374gk549yb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 06 Mar 2021 20:21:04 -0500
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 12712gOL190496;
        Sat, 6 Mar 2021 20:21:04 -0500
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0b-001b2d01.pphosted.com with ESMTP id 374gk549y6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 06 Mar 2021 20:21:04 -0500
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 1271Gih8005996;
        Sun, 7 Mar 2021 01:21:03 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
        by ppma02dal.us.ibm.com with ESMTP id 3741c8pjg3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 07 Mar 2021 01:21:03 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1271L1JN38535614
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 7 Mar 2021 01:21:02 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E28AD136055;
        Sun,  7 Mar 2021 01:21:01 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DFDD5136053;
        Sun,  7 Mar 2021 01:21:00 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Sun,  7 Mar 2021 01:21:00 +0000 (GMT)
Subject: Re: [PATCH v10 3/9] crypto: Add math to support fast NIST P384
To:     Vitaly Chikunov <vt@altlinux.org>
Cc:     Stefan Berger <stefanb@linux.vnet.ibm.com>,
        keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        davem@davemloft.net, herbert@gondor.apana.org.au,
        dhowells@redhat.com, zohar@linux.ibm.com,
        linux-kernel@vger.kernel.org, patrick@puiterwijk.org,
        linux-integrity@vger.kernel.org,
        Saulo Alessandre <saulo.alessandre@tse.jus.br>
References: <20210305005203.3547587-1-stefanb@linux.vnet.ibm.com>
 <20210305005203.3547587-4-stefanb@linux.vnet.ibm.com>
 <20210306192553.lxy5w262g2vs2hvv@altlinux.org>
 <9ac456d7-a5e1-9e42-5d34-7dc1c70082e0@linux.ibm.com>
 <20210307000310.ytes6la73x5bkori@altlinux.org>
From:   Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <340a3176-05a2-6a4a-7c19-6c2aa2667083@linux.ibm.com>
Date:   Sat, 6 Mar 2021 20:21:00 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210307000310.ytes6la73x5bkori@altlinux.org>
Content-Type: text/plain; charset=koi8-r; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-06_08:2021-03-03,2021-03-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999 clxscore=1015
 impostorscore=0 priorityscore=1501 adultscore=0 bulkscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103070004
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 3/6/21 7:03 PM, Vitaly Chikunov wrote:
> Stefan,
>
> On Sat, Mar 06, 2021 at 06:29:18PM -0500, Stefan Berger wrote:
>> On 3/6/21 2:25 PM, Vitaly Chikunov wrote:
>>> On Thu, Mar 04, 2021 at 07:51:57PM -0500, Stefan Berger wrote:
>>>> From: Saulo Alessandre <saulo.alessandre@tse.jus.br>
>>>>
>>>> * crypto/ecc.c
>>>>     - add vli_mmod_fast_384
>>>>     - change some routines to pass ecc_curve forward until vli_mmod_fast
>>>>
>>>> * crypto/ecc.h
>>>>     - add ECC_CURVE_NIST_P384_DIGITS
>>>>     - change ECC_MAX_DIGITS to P384 size
>>>>
>>>> Signed-off-by: Saulo Alessandre <saulo.alessandre@tse.jus.br>
>>>> Tested-by: Stefan Berger <stefanb@linux.ibm.com>
>>>> ---
>>>>    crypto/ecc.c | 266 +++++++++++++++++++++++++++++++++++++--------------
>>>>    crypto/ecc.h |   3 +-
>>>>    2 files changed, 194 insertions(+), 75 deletions(-)
>>>>
>>>> diff --git a/crypto/ecc.c b/crypto/ecc.c
>>>> index f6cef5a7942d..c125576cda6b 100644
>>>> --- a/crypto/ecc.c
>>>> +++ b/crypto/ecc.c
>>>> @@ -778,18 +778,133 @@ static void vli_mmod_fast_256(u64 *result, const u64 *product,
>>>>    ...
>>>>    /* Computes result = product % curve_prime for different curve_primes.
>>>>     *
>>>>     * Note that curve_primes are distinguished just by heuristic check and
>>>>     * not by complete conformance check.
>>>>     */
>>>>    static bool vli_mmod_fast(u64 *result, u64 *product,
>>>> -			  const u64 *curve_prime, unsigned int ndigits)
>>>> +			  const struct ecc_curve *curve)
>>>>    {
>>>>    	u64 tmp[2 * ECC_MAX_DIGITS];
>>>> +	const u64 *curve_prime = curve->p;
>>>> +	const unsigned int ndigits = curve->g.ndigits;
>>>> -	/* Currently, both NIST primes have -1 in lowest qword. */
>>>> -	if (curve_prime[0] != -1ull) {
>>>> +	/* Currently, all NIST have name nist_.* */
>>>> +	if (strncmp(curve->name, "nist_", 5) != 0) {
>>> I am not sure, but maybe this strncmp should not be optimized somehow,
>>> since vli_mmod_fast could be called quite frequently. Perhaps by integer
>>> algo id or even callback?
>> Should be optimized or should not be? You seem to say both.
> Excuse me for the typo. I meant "should be optimized". I think, maybe
> it's time to add algo selector id (for the case statement, for example
> instead of `switch (ndigits)') or just callback for a low level mmod
> function.
>
> If you think this would not impact performance then nevermind.

I think it would only be a few cycles. Of course we could introduce a 
flag to indicate nist functions (rather than using strncmp on the name) 
or work with the callbacks (only for the nist functions?) as you 
mentioned, but maybe that's something we could do after? Either way we 
would have to pass the ecc_curve pointer all the way into vli_mmod_fast. 
So this change here is preparing for this as well.

 š Stefan


