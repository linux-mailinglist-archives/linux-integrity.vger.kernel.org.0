Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FE4F667A7C
	for <lists+linux-integrity@lfdr.de>; Thu, 12 Jan 2023 17:15:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231948AbjALQP0 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 12 Jan 2023 11:15:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230353AbjALQO5 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 12 Jan 2023 11:14:57 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB4938FE7
        for <linux-integrity@vger.kernel.org>; Thu, 12 Jan 2023 08:11:44 -0800 (PST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30CFLMVD012826;
        Thu, 12 Jan 2023 16:11:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=b9cZ5dKV0ixJxrgvJV5fsKo8Vv0G/sZtWyGdNqBBHOI=;
 b=e4XHHGr2+OLrSw7z0t/nrUkpQAxCCwcKe2EdZLsZkRNY7YFCcKK40tv3ltzmQgQxoFRW
 rpL+DOGo5b1SDeApIz2gaZJ6p/7NXqs0TzyIys159f3wygk/5wgs5tmy1RQuq/RSeSxZ
 qD4nxhUNb43Zul/gahnp3zlq6s+Wt9b/HSgFgVerafqj6bPvhLAZhpCHyyiTTE0nkBpE
 5rB6QVTHsfRr+CcF0d+3v/P1ahSoycEYscP2d7O/2fmx9lvKcH8l4A2arVXniW5aaS4P
 5mI/4zrC8DgW7Po5wvmLfqrU0m/v9W1NAPaLyL6+hyBV34EPESlCRMm1OT8S77p5LUB1 Ig== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3n2msc9ch0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Jan 2023 16:11:18 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30CG9Env029279;
        Thu, 12 Jan 2023 16:11:17 GMT
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3n2msc9cgj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Jan 2023 16:11:17 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30CFI6TC029123;
        Thu, 12 Jan 2023 16:11:16 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([9.208.130.97])
        by ppma04dal.us.ibm.com (PPS) with ESMTPS id 3n1m03cj1v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Jan 2023 16:11:16 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
        by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30CGBFWw29950304
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Jan 2023 16:11:15 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6BC255805A;
        Thu, 12 Jan 2023 16:11:15 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EEAF558060;
        Thu, 12 Jan 2023 16:11:14 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 12 Jan 2023 16:11:14 +0000 (GMT)
Message-ID: <42a75a49-31c8-4987-2b0d-83fef07d6cde@linux.ibm.com>
Date:   Thu, 12 Jan 2023 11:11:14 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH ima-evm-utils v2 8/9] Use in-place built fsverity binary
 instead of installing it
Content-Language: en-US
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>, zohar@linux.ibm.com,
        dmitry.kasatkin@gmail.com
Cc:     linux-integrity@vger.kernel.org, vt@altlinux.org, pvorel@suse.cz,
        Roberto Sassu <roberto.sassu@huawei.com>
References: <20230112122426.3759938-1-roberto.sassu@huaweicloud.com>
 <20230112122426.3759938-9-roberto.sassu@huaweicloud.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20230112122426.3759938-9-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 3A6vtdpZSmTmvClklIH6jM0TXk0C-My3
X-Proofpoint-GUID: g0pYABtjeZ17tSgiATPosGBRYc6JIdL-
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-12_08,2023-01-12_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 lowpriorityscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 impostorscore=0 mlxscore=0 mlxlogscore=999 spamscore=0 adultscore=0
 priorityscore=1501 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2301120116
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 1/12/23 07:24, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
> 
> Instead of making changes to the system, use in-place built fsverity binary
> by adding ../fsverity-utils to the PATH variable, so that the binary can be
> found with the 'which' command.
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>

> ---
>   tests/fsverity.test       | 2 +-
>   tests/install-fsverity.sh | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/fsverity.test b/tests/fsverity.test
> index 84312aa08a30..e05978be7ea6 100755
> --- a/tests/fsverity.test
> +++ b/tests/fsverity.test
> @@ -30,7 +30,7 @@
>   # custom policy rules might take precedence.
>   
>   cd "$(dirname "$0")" || exit 1
> -PATH=../src:$PATH
> +PATH=../src:../fsverity-utils:$PATH
>   source ./functions.sh
>   
>   # Base VERBOSE on the environment variable, if set.
> diff --git a/tests/install-fsverity.sh b/tests/install-fsverity.sh
> index 418fc42f472b..d00674c0d3a2 100755
> --- a/tests/install-fsverity.sh
> +++ b/tests/install-fsverity.sh
> @@ -2,6 +2,6 @@
>   
>   git clone https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/fsverity-utils.git
>   cd fsverity-utils
> -CC=gcc make -j$(nproc) && sudo make install
> +CC=gcc make -j$(nproc)
>   cd ..
>   rm -rf fsverity-utils
