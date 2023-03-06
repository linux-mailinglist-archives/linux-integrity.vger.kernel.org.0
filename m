Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07FE16ABF9C
	for <lists+linux-integrity@lfdr.de>; Mon,  6 Mar 2023 13:35:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbjCFMfk (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 6 Mar 2023 07:35:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbjCFMfj (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 6 Mar 2023 07:35:39 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50F4A25BB6
        for <linux-integrity@vger.kernel.org>; Mon,  6 Mar 2023 04:35:38 -0800 (PST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3269tHI9006978;
        Mon, 6 Mar 2023 12:35:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=0jCWrZAzem81E3P9GNYbyloUjJeDd/FeuQx0xMp3Lbg=;
 b=T4LrsNQdnB8LD5Q402f1v722mUDDeGFe9ePMulMCb2FnE1Slj1/TDV90trjYCF8xTuqr
 KbzGhvpcf4jwIo52KmParFaqCxwnMoh5JVWHlBZ0t7eYsu9mOIVHaQM3PcDR+YmxVKtF
 9qMjbJHkPjJzm3Sb4QwfCMS8ioJBPDphxdK5k3O1VkZ8PwbVUloMs68r7szk+svUYOfo
 /Bu8+YpstthfgmiXSL+NIqvdHNnW8ItiBh9qpqCnD6w8iukPwv0uhxy3Ekn48TuOgd0R
 Y/OG/ccfkTE1u9/vn8zdJpv7N7OuuSRxkzgz7CLafURr6jTqqgspc1zjkjps2Cmbm+45 UQ== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3p4ysdkg93-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Mar 2023 12:35:22 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 326BpfSF008540;
        Mon, 6 Mar 2023 12:35:20 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3p4188apuu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Mar 2023 12:35:20 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 326CZIGS30605662
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 Mar 2023 12:35:18 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DC6152004E;
        Mon,  6 Mar 2023 12:35:17 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E943120049;
        Mon,  6 Mar 2023 12:35:16 +0000 (GMT)
Received: from [9.43.25.141] (unknown [9.43.25.141])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Mon,  6 Mar 2023 12:35:16 +0000 (GMT)
Message-ID: <37f75761-c5e7-e3ee-49e4-ab779bb8812c@linux.ibm.com>
Date:   Mon, 6 Mar 2023 18:05:15 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH ima-evm-utils 2/2] tests: fix gen-keys.sh to generate
 sha256 certificates
To:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc:     Vitaly Chikunov <vt@altlinux.org>, Petr Vorel <pvorel@suse.cz>,
        Roberto Sassu <roberto.sassu@huaweicloud.com>
References: <20230306113635.350582-1-zohar@linux.ibm.com>
 <20230306113635.350582-2-zohar@linux.ibm.com>
Content-Language: en-US
From:   R Nageswara Sastry <rnsastry@linux.ibm.com>
In-Reply-To: <20230306113635.350582-2-zohar@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 4_bIee-y0iwhbiCB6twfzD1WHn5nXH6Z
X-Proofpoint-GUID: 4_bIee-y0iwhbiCB6twfzD1WHn5nXH6Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-06_05,2023-03-06_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1011
 malwarescore=0 adultscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0
 mlxlogscore=999 suspectscore=0 bulkscore=0 priorityscore=1501 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303060110
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 06/03/23 5:06 pm, Mimi Zohar wrote:
> On systems with OpenSSL sha1 disabled, the sign-verify.test fails:
> 
> - openssl dgst   -sha1 sha1.txt
> - openssl dgst   -sha1 -sign test-rsa1024.key -hex sha1.txt
> Error setting context
> 804BD5CF787F0000:error:03000098:digital envelope routines:do_sigver_init:invalid digest:crypto/evp/m_sigver.c:343:
> sha1 (test-rsa1024.key) test is skipped (openssl is unable to sign)
> 
> Instead of enabling sha1 support on these systems by setting the environment
> variable OPENSSL_ENABLE_SHA1_SIGNATURES, generate a sha256 certificate.
> 
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>

Tested-by: Nageswara R Sastry <rnsastry@linux.ibm.com>

...
PASS: ima_hash.test
PASS: sign_verify.test
PASS: boot_aggregate.test
SKIP: fsverity.test
SKIP: portable_signatures.test
PASS: ima_policy_check.test
SKIP: mmap_check.test
...



> ---
>   tests/gen-keys.sh | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/gen-keys.sh b/tests/gen-keys.sh
> index 1a6c22a2f3c4..8905cdf2d216 100755
> --- a/tests/gen-keys.sh
> +++ b/tests/gen-keys.sh
> @@ -71,7 +71,7 @@ for m in 1024 1024_skid 2048; do
>       ext=
>     fi
>     if [ ! -e test-rsa$m.key ]; then
> -    log openssl req -verbose -new -nodes -utf8 -sha1 -days 10000 -batch -x509 $ext \
> +    log openssl req -verbose -new -nodes -utf8 -sha256 -days 10000 -batch -x509 $ext \
>         -config test-ca.conf \
>         -newkey rsa:$bits \
>         -out test-rsa$m.cer -outform DER \
> @@ -93,7 +93,7 @@ for curve in prime192v1 prime256v1; do
>       continue
>     fi
>     if [ ! -e test-$curve.key ]; then
> -    log openssl req -verbose -new -nodes -utf8 -sha1 -days 10000 -batch -x509 \
> +    log openssl req -verbose -new -nodes -utf8 -sha256 -days 10000 -batch -x509 \
>         -config test-ca.conf \
>         -newkey ec \
>         -pkeyopt ec_paramgen_curve:$curve \

-- 
Thanks and Regards
R.Nageswara Sastry
