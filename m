Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E46BC30B57D
	for <lists+linux-integrity@lfdr.de>; Tue,  2 Feb 2021 03:53:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbhBBCxC (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 1 Feb 2021 21:53:02 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:29090 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229537AbhBBCxC (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 1 Feb 2021 21:53:02 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 1122W271081243;
        Mon, 1 Feb 2021 21:52:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=6WKJwVmtPBlbT7P/CClAA9KYUe0rp9hAQsx2toKuEKI=;
 b=rMCjBeQDXV4KVkeO5h1EXjd/UQFyFHHgnGj2zMTIEbiipBO3m/dlKSFlOdOZKYUeyDjm
 0n7mu54dC+QpAs0LAVuzoyz6537T26h5SRQ+FLtKiaBipmjC6e7ANJhfyMWGp6IDImgy
 q+M8+yIyJgctLxw6nECJCRRn19JgNAmlxxIIjRjOP/ssWAKDxH9JmXQcmIZrRDR3T1QT
 ePqLFJ7YAkgOYN2iO7gxI2gRIaRPKet+rIdDXwuw6m6wFjbeomc2U6qe62uM+mJWjJ9s
 owTZfCgUc6IkqaGvFzP/WwKBwl4lW7CLD86k7guWL2NVXWf+e2+k1RjSE3ZN4JntDb/b lA== 
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36ewkbs008-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 01 Feb 2021 21:52:19 -0500
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 1122i1K4008570;
        Tue, 2 Feb 2021 02:52:18 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma03dal.us.ibm.com with ESMTP id 36eheke6bg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 02 Feb 2021 02:52:18 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1122qHMt7733894
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 2 Feb 2021 02:52:17 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CC2B4AC05B;
        Tue,  2 Feb 2021 02:52:17 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BD25CAC059;
        Tue,  2 Feb 2021 02:52:17 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue,  2 Feb 2021 02:52:17 +0000 (GMT)
Subject: Re: [PATCH] ima_evm_utils: Add testing with elliptic curves
 prime192v1 and 256v1
To:     zohar@linux.ibm.com, vt@altlinux.org,
        linux-integrity@vger.kernel.org
References: <20210202015055.1506308-1-stefanb@linux.ibm.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <98a96c4e-6751-2496-9697-d78d583b3799@linux.ibm.com>
Date:   Mon, 1 Feb 2021 21:52:17 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210202015055.1506308-1-stefanb@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-01_14:2021-01-29,2021-02-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 adultscore=0 impostorscore=0 malwarescore=0 spamscore=0
 clxscore=1015 bulkscore=0 lowpriorityscore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102020012
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 2/1/21 8:50 PM, Stefan Berger wrote:
> Add test cases that test the signing and signature verification with the
> elliptic curves prime192v1 and prime256v1, also known as NIST P192 and
> P256. These curves will soon be supported by Linux. If OpenSSL cannot
> generate prime192v1 keys, as is the case on Fedora, where this curve is
> not supported, the respective tests will be skipped automatically.
>
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> ---
>   tests/gen-keys.sh      | 20 ++++++++++++++++++++
>   tests/sign_verify.test | 15 +++++++++++++++
>   2 files changed, 35 insertions(+)
>
> diff --git a/tests/gen-keys.sh b/tests/gen-keys.sh
> index 407876b..46130cf 100755
> --- a/tests/gen-keys.sh
> +++ b/tests/gen-keys.sh
> @@ -66,6 +66,26 @@ for m in 1024 2048; do
>     fi
>   done
>   
> +for curve in prime192v1 prime256v1; do
> +  if [ "$1" = clean ] || [ "$1" = force ]; then
> +    rm -f test-$curve.cer test-$curve.key test-$curve.pub
> +  fi
> +  if [ "$1" = clean ]; then
> +    continue
> +  fi
> +  if [ ! -e test-$curve.key ]; then
> +    log openssl req -verbose -new -nodes -utf8 -sha1 -days 10000 -batch -x509 \
> +      -config test-ca.conf \
> +      -newkey ec \
> +      -pkeyopt ec_paramgen_curve:$curve \
> +      -out test-$curve.cer -outform DER \
> +      -keyout test-$curve.key
> +    if [ -s test-$curve.key ]; then
> +      log openssl pkey -in test-$curve.key -out test-$curve.pub -pubout
> +    fi
> +  fi
> +done
> +
>   # EC-RDSA
>   for m in \
>     gost2012_256:A \
> diff --git a/tests/sign_verify.test b/tests/sign_verify.test
> index 288e133..b4fffda 100755
> --- a/tests/sign_verify.test
> +++ b/tests/sign_verify.test
> @@ -366,6 +366,21 @@ sign_verify  rsa1024  sha384  0x030205:K:0080
>   sign_verify  rsa1024  sha512  0x030206:K:0080
>   sign_verify  rsa1024  rmd160  0x030203:K:0080
>   
> +# Test v2 signatures with ECDSA
> +# Signature length can be 0x36-0x38 bytes long
> +sign_verify  prime192v1 sha1   0x030202:K:003[678]

Actually valid sizes are also 0x35 and 0x45 below. Smaller ones seems to 
be rather rare, though, but I will leave my tests running. It depends on 
the r and s components of the signature and whether they have leading 
zeros, which will be cut away.

So I need to send a v2 for this.


    Stefan


