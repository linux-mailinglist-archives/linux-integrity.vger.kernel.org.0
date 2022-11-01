Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 647C0615439
	for <lists+linux-integrity@lfdr.de>; Tue,  1 Nov 2022 22:25:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbiKAVZl (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 1 Nov 2022 17:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230324AbiKAVZk (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 1 Nov 2022 17:25:40 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A27BB483
        for <linux-integrity@vger.kernel.org>; Tue,  1 Nov 2022 14:25:39 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A1LIofJ020882;
        Tue, 1 Nov 2022 21:25:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=iHx51r7huHEbiDBZxfKveGQSny44ral1HSdNBhp95yw=;
 b=VgS0knS7IzYJPvTfMiKkCW9M4CqEUZLTDUgRBfODPZcdv4sv36RAfehTHkWL5k5qrXx/
 yCHApFvFvYDphRFrjvntZdsjITUccC5qIUI12U1g0dEqrmH2MpIPlZzf163k+Dw2dTjB
 l00mJ9B5EzT3G6pHQa/KL4ypC+b4rQYGrhcMMH2q7qBNU43FGNOP7O/tOZ23ckrMbJ1c
 fBAeS9/yoslkeTwC7mP1VwDoimt0Qy9CH0CQQLx7++7af0iI8NUf9O3SeajTjxenDP9i
 qXDryuIvmBHtQTCYY29nAOwW0/9tpaLp5t5C7uqPBMHSoIbDRb4efY78sUHwPg84jm/N NQ== 
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kjwjjn1yg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Nov 2022 21:25:32 +0000
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2A1LKEhE018624;
        Tue, 1 Nov 2022 21:25:31 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma01wdc.us.ibm.com with ESMTP id 3kgut9phqp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Nov 2022 21:25:31 +0000
Received: from smtpav05.wdc07v.mail.ibm.com ([9.208.128.117])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2A1LPUwv19071546
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 1 Nov 2022 21:25:31 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 66B6658053;
        Tue,  1 Nov 2022 21:25:30 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0434658059;
        Tue,  1 Nov 2022 21:25:30 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Tue,  1 Nov 2022 21:25:29 +0000 (GMT)
Message-ID: <1dc2c60f-b573-7b8a-ad5c-70567249bf4e@linux.ibm.com>
Date:   Tue, 1 Nov 2022 17:25:29 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH ima-evm-utils v4 14/17] Base sm2/sm3 test on openssl
 version installed
Content-Language: en-US
To:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc:     Petr Vorel <pvorel@suse.cz>, Vitaly Chikunov <vt@altlinux.org>
References: <20221101201803.372652-1-zohar@linux.ibm.com>
 <20221101201803.372652-15-zohar@linux.ibm.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20221101201803.372652-15-zohar@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: JiFOa9T7XykSBs3x1ND8mA04X1nbrej1
X-Proofpoint-GUID: JiFOa9T7XykSBs3x1ND8mA04X1nbrej1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-01_10,2022-11-01_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 spamscore=0 bulkscore=0 priorityscore=1501 phishscore=0 clxscore=1011
 malwarescore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211010147
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 11/1/22 16:18, Mimi Zohar wrote:
> Since the distros are now shipping with OpenSSL 3, no need
> to build it.  Limit the sm2/sm3 test to OpenSSL 3.
> 
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
>   tests/sign_verify.test | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/sign_verify.test b/tests/sign_verify.test
> index 3e9548e1aeb7..ed95f6955dc1 100755
> --- a/tests/sign_verify.test
> +++ b/tests/sign_verify.test
> @@ -416,8 +416,8 @@ sign_verify  prime256v1 sha384 0x030205:K:004[345678]
>   sign_verify  prime256v1 sha512 0x030206:K:004[345678]
>   
>   # If openssl 3.0 is installed, test the SM2/3 algorithm combination
> -if [ -x /opt/openssl3/bin/openssl ]; then
> -  PATH=/opt/openssl3/bin:$PATH LD_LIBRARY_PATH=/opt/openssl3/lib \
> +ssl_version=$(openssl version | sed -e 's/^OpenSSL //' | sed -e 's/ .*//')

This would give you the major number in one step by selecting all all characters after 'OpenSSL ' and before the first '.':

major=$(openssl version | sed -n 's/^OpenSSL \([^\.]\).*/\1/p')


> +if test "${ssl_version::1}" = "3"; then
>       sign_verify  sm2    sm3    0x030211:K:004[345678]
>   fi
>   

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>

