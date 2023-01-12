Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3FE0667965
	for <lists+linux-integrity@lfdr.de>; Thu, 12 Jan 2023 16:35:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240365AbjALPfp (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 12 Jan 2023 10:35:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240352AbjALPfO (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 12 Jan 2023 10:35:14 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 106B163186
        for <linux-integrity@vger.kernel.org>; Thu, 12 Jan 2023 07:25:29 -0800 (PST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30CEh6Bb018979;
        Thu, 12 Jan 2023 15:24:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=T1SfgZdfQVDHYzKwzoGe9bZrinsutRaKRp2oPoaIsCU=;
 b=MzE3pjmBx0EVlYszlqtl/wLn1caUplHbUXGWqDb/oU/74Zqyp0jKvlcP2RdVwkqQaQz+
 ikn+Gy0vUAPB0+Bu1UyoSRy5q/3VnXKV3S5cniZcLoys8l0b51k4KFVmM2ArV7lWCjQd
 tI8U69d+FKm1cDRRrsjyhD+PFEC3y+r8mtp279WYFZPmK41DEy9gcmJsJZgNSo2HruaY
 qtAxPmK38C2aTLcd15uZrX3QFPpWpm8RNChak8mvtA9G950JOt5/TsuWRHi8K0MPirfs
 EO76mjFno36ESDetd0i/pO23dVWV8JmHZP2aOD2jb2Pj+Liqmu6pbJURmd+tl9oaugrY Hw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3n2m7ah5hs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Jan 2023 15:24:44 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30CEj0q1025871;
        Thu, 12 Jan 2023 15:24:44 GMT
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3n2m7ah5h9-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Jan 2023 15:24:44 +0000
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30CEXwrH004632;
        Thu, 12 Jan 2023 15:07:37 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([9.208.129.117])
        by ppma05wdc.us.ibm.com (PPS) with ESMTPS id 3n1kk7hudq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Jan 2023 15:07:37 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
        by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30CF7a7K10486354
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Jan 2023 15:07:36 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 73ABD58063;
        Thu, 12 Jan 2023 15:07:36 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B82475804B;
        Thu, 12 Jan 2023 15:07:35 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 12 Jan 2023 15:07:35 +0000 (GMT)
Message-ID: <9bbcd04c-cf91-af59-c2e4-ed5fdd786e9c@linux.ibm.com>
Date:   Thu, 12 Jan 2023 10:07:35 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH ima-evm-utils v2 5/9] Introduce TST_LIST variable to
 select a test to execute
Content-Language: en-US
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>, zohar@linux.ibm.com,
        dmitry.kasatkin@gmail.com
Cc:     linux-integrity@vger.kernel.org, vt@altlinux.org, pvorel@suse.cz,
        Roberto Sassu <roberto.sassu@huawei.com>
References: <20230112122426.3759938-1-roberto.sassu@huaweicloud.com>
 <20230112122426.3759938-6-roberto.sassu@huaweicloud.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20230112122426.3759938-6-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: wd1B9e_QUr6GGxMFrfa5mSMjJWKLRVYp
X-Proofpoint-GUID: sCcP8a8HqJh_I2V6dWE9owJSZNhiBhme
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-12_08,2023-01-12_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 spamscore=0 malwarescore=0 phishscore=0 impostorscore=0
 mlxscore=0 clxscore=1011 bulkscore=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301120109
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 1/12/23 07:24, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
> 
> It might be desirable, due to restrictions in the testing environment, to
> execute tests individually. Introduce the TST_LIST variable, which can be
> set with the name of the test to execute. If the variable is set,
> expect_pass and expect_fail automatically skip the tests when the first
> argument of those functions does not match the value of TST_LIST.
> 
> TST_LIST can be also used in conjunction with the UML kernel. It is
> sufficient to add it to the kernel command line.
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>   tests/functions.sh | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/tests/functions.sh b/tests/functions.sh
> index 98829d94fae1..298c30393ce6 100755
> --- a/tests/functions.sh
> +++ b/tests/functions.sh
> @@ -72,6 +72,12 @@ declare -i TNESTED=0 # just for sanity checking
>   expect_pass() {
>     local -i ret
>   
> +  if [ -n "$TST_LIST" ] && [ "${TST_LIST/$1/}" = $TST_LIST ]; then

"$TSR_LIST" for consistency and if it comes to shellcheck also to address "Double quote to prevent globbing and word splitting."

> +    [ "$VERBOSE" -gt 1 ] && echo "____ SKIP test: $*"
> +    testsskip+=1
> +    return $SKIP
> +  fi
> +
>     if [ $TNESTED -gt 0 ]; then
>       echo $RED"expect_pass should not be run nested"$NORM
>       testsfail+=1
> @@ -98,6 +104,12 @@ expect_pass() {
>   expect_fail() {
>     local ret
>   
> +  if [ -n "$TST_LIST" ] && [ "${TST_LIST/$1/}" = $TST_LIST ]; then

Same here.

> +    [ "$VERBOSE" -gt 1 ] && echo "____ SKIP test: $*"
> +    testsskip+=1
> +    return $SKIP
> +  fi
> +
>     if [ $TNESTED -gt 0 ]; then
>       echo $RED"expect_fail should not be run nested"$NORM
>       testsfail+=1
