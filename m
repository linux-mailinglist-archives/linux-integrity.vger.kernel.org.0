Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1D23400F5E
	for <lists+linux-integrity@lfdr.de>; Sun,  5 Sep 2021 13:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237854AbhIELxU (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 5 Sep 2021 07:53:20 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50722 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232168AbhIELxU (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 5 Sep 2021 07:53:20 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 185BXf5n125035;
        Sun, 5 Sep 2021 07:52:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=H5lJPSVWQorg03732JJJ6Tmc0uaq81iJXf9FxFelzgI=;
 b=jVSjOgl/nxoxdFxU0Av4QQEK9fizOOHccOZB2NRpGM3rU6AIZbyUgCimz3QdmqbaWFk3
 CrzAe17WLbOQnaRppKU8fAmDfIsHSvBWFiqN2sUtRVE1Xb/7tued9lqHKPow2dw2GyrG
 b9Hes91jykvCDBISo4h9TZIpz2b29DsEyX+Ci2D8qLap/ox/H1EPNYfzf/ou1oap9clj
 3kpxXMJP2l/75uNgBn5TbpQMRxdPumon/UuEdSzLpQWSxi5iX5gMUT+aYP2Ep7aNqKdb
 Rvov2WnV8ezrdyPmC7lqTrCXgNt3/xItXyEsP7YX/oTbD2g//T0lpTwS95O50ef8/dSa rA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3avs4ckh4u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 05 Sep 2021 07:52:15 -0400
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 185BqEla178395;
        Sun, 5 Sep 2021 07:52:14 -0400
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3avs4ckh4p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 05 Sep 2021 07:52:14 -0400
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 185Bm98a023299;
        Sun, 5 Sep 2021 11:52:14 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by ppma03wdc.us.ibm.com with ESMTP id 3av0e8yn6x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 05 Sep 2021 11:52:13 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 185BqD0n17302210
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 5 Sep 2021 11:52:13 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EEF2613605D;
        Sun,  5 Sep 2021 11:52:12 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D8D7E13604F;
        Sun,  5 Sep 2021 11:52:10 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Sun,  5 Sep 2021 11:52:10 +0000 (GMT)
Subject: Re: [PATCH ima-evm-utils v4] evmctl: Use secure heap for private keys
 and passwords
To:     Vitaly Chikunov <vt@altlinux.org>
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org,
        Bruno Meneguele <bmeneg@redhat.com>
References: <20210904105054.3388329-1-vt@altlinux.org>
 <cee7b810-e9fd-9924-a8dd-9cc1e3211bd7@linux.ibm.com>
 <20210905081137.nsslgto7mqsfxn2b@altlinux.org>
From:   Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <301ace0b-397e-6e83-37c0-6dc4794597ee@linux.ibm.com>
Date:   Sun, 5 Sep 2021 07:52:10 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210905081137.nsslgto7mqsfxn2b@altlinux.org>
Content-Type: text/plain; charset=koi8-r; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: DFWcOaSBmAACcu8t7hAynlTEu4sAWizt
X-Proofpoint-ORIG-GUID: UftlzVcrccjBqk4DJL-xzZYoz3RIn1Fw
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-09-04_09:2021-09-03,2021-09-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 suspectscore=0 clxscore=1015 mlxlogscore=999 impostorscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2108310000 definitions=main-2109050080
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 9/5/21 4:11 AM, Vitaly Chikunov wrote:
> Stefan,
>
> On Sat, Sep 04, 2021 at 09:10:50PM -0400, Stefan Berger wrote:
>> On 9/4/21 6:50 AM, Vitaly Chikunov wrote:
>>> After CRYPTO_secure_malloc_init OpenSSL will automatically store private
>>> keys in secure heap. OPENSSL_secure_malloc(3):
>>>
>>>     If a secure heap is used, then private key BIGNUM values are stored
>>>     there. This protects long-term storage of private keys, but will not
>>>     necessarily put all intermediate values and computations there.
>>>
>>> Additionally, we try to keep user passwords in secure heap too.
>>> This facility is only available since OpenSSL_1_1_0-pre1.
>>> Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
>>> Reviewed-by: Bruno Meneguele <bmeneg@redhat.com>
>>> Cc: Stefan Berger <stefanb@linux.ibm.com>
>>> ---
>>> Change since v3:
>>> - Undo secure heap handling from (file2bin and) calc_evm_hmac since this
>>>     is debugging tool only. Add comment about this.
>>> - Since there is only code removals and new comments I keep Reviewed-by
>>>     tag.
>>>
>>>    src/evmctl.c | 97 +++++++++++++++++++++++++++++++++++++++++++++-------
>>>    1 file changed, 85 insertions(+), 12 deletions(-)
>>>
>>> @@ -2596,15 +2616,41 @@ static struct option opts[] = {
>>>    };
>>> +/*
>>> + * Copy password from optarg into secure heap, so it could be
>>> + * freed in the same way as a result of get_password().
>>> + */
>>> +static char *optarg_password(char *optarg)
>>> +{
>>
>> Mimi applied my patch that takes the password from an environment variable
>> to the next-testing branch. The code there (imaevm_params.keypassš =
>> getenv("..."))would have to change as well calling this function here. Even
>> though the man page of getenv says that 'The caller must take care not to
>> modify this string, since that would change the environment of the process'
>> we should be able to overwrite the env variable's password value just like
>> here. Maybe for this purpose rename this function to dup_password() ?
> `/proc/<pid>/environ' is never world readable (unlike `cmdline'), so we
> don't even need to overwrite it there. But, we can.

Or you could add an option for whether to overwrite the source...


>
> (Btw, I found the 'EVMCTL_KEY_PASSWORD' patch.)
>
>>> @@ -2643,6 +2691,7 @@ int main(int argc, char *argv[])
>>>    	ENGINE *eng = NULL;
>>>    	unsigned long keyid;
>>>    	char *eptr;
>>> +	char *keypass = NULL; /* @secure heap */
>>>    #if !(OPENSSL_VERSION_NUMBER < 0x10100000)
>>>    	OPENSSL_init_crypto(
>>> @@ -2651,6 +2700,17 @@ int main(int argc, char *argv[])
>>>    #endif
>>>    			    OPENSSL_INIT_ENGINE_ALL_BUILTIN, NULL);
>>>    #endif
>>> +#if OPENSSL_VERSION_NUMBER > 0x10100000
>>> +	/*
>>> +	 * This facility is available since OpenSSL_1_1_0-pre1.
>>
>> Shouldn't the comparison then not include 0x10100000?
>>
>> #if OPENSSL_VERSION_NUMBER >= 0x10100000
> The number is from `include/openssl/opensslv.h' from the time when
> relevant commit is already applied. So, I use `>'. It seems good match
> for OpenSSL_1_1_0-pre1 too:
>
>    $ git grep OPENSSL_VERSION_NUMBER OpenSSL_1_1_0-pre1:include/openssl/opensslv.h
>    OpenSSL_1_1_0-pre1:include/openssl/opensslv.h:# define OPENSSL_VERSION_NUMBER  0x10100001L

You are right. I had checkout out this commit here:

commit abd30777cc72029e8a44e4b67201cae8ed3d19c1 (HEAD -> OpenSSL_1_1_0, 
tag: OpenSSL_1_1_0)
Author: Matt Caswell <matt@openssl.org>
Date:šš Thu Aug 25 16:29:18 2016 +0100

 ššš Prepare for 1.1.0 release

 ššš Reviewed-by: Richard Levitte <levitte@openssl.org


It shows this here:

$ grep -r OPENSSL_VERSION_NUM ./include/
./include/openssl/crypto.h:#š define SSLEAY_VERSION_NUMBER 
OPENSSL_VERSION_NUMBER
./include/openssl/opensslv.h:# define OPENSSL_VERSION_NUMBER 0x1010000fL

There's an 'f' at the 'end'.

 š Stefan


>
> Thanks,
>
