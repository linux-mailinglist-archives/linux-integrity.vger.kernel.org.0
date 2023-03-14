Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F18D66B9642
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Mar 2023 14:31:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231645AbjCNNbd (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 14 Mar 2023 09:31:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231782AbjCNNbK (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 14 Mar 2023 09:31:10 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEAE9A64A4
        for <linux-integrity@vger.kernel.org>; Tue, 14 Mar 2023 06:27:54 -0700 (PDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32ECdb1D027435;
        Tue, 14 Mar 2023 13:27:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=YcrD+b9MRtBbij0L3QH+6neqtMo7lddv+CjWa0NKsGc=;
 b=Or9QW2sE1wsLjz8NfCBW2ZBHWGDws5OjBSoM2vvc2f9N5J8FByNc7eQYS0idVpfjQnJg
 iUjKE93yI5TIyq4VuC3WlqnsSXYZVgqOqbvVBMC3SitkFugigE9+xaQsUGtoPcTDSttf
 86Izz/jCehCzAFf+iFJFwJIZWjyfqPyd5L2hOwszDcrNCc5mUrxG/vwGaOnGc095aXNN
 oMwXl8ZEf6tDoa5BuNlJOawZxcBhKJ8i43XX0cU6eLlhxX0kBWhao7iAPYZyL1R5Edrj
 A683tw0yCGwx9UraGWZpU1BaZ3XmoeNUOPTIAe1qdmSVZTadeU6x0CkcMHx4e7rnWcQ8 bA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3panssykd1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Mar 2023 13:27:51 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32ED4CLh014284;
        Tue, 14 Mar 2023 13:27:51 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3panssykc5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Mar 2023 13:27:51 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32E7gieh030084;
        Tue, 14 Mar 2023 13:27:48 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3p8gwfcw5g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Mar 2023 13:27:48 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32EDRkWm23462624
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Mar 2023 13:27:46 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 48C4E20043;
        Tue, 14 Mar 2023 13:27:46 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 43E4F2004E;
        Tue, 14 Mar 2023 13:27:45 +0000 (GMT)
Received: from [9.43.100.151] (unknown [9.43.100.151])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Tue, 14 Mar 2023 13:27:45 +0000 (GMT)
Message-ID: <74b2f01d-ce07-ff7e-e8f3-5d551a5ec554@linux.ibm.com>
Date:   Tue, 14 Mar 2023 18:57:43 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH ima-evm-utils] Fix fsverity.test mount failure for ppc64
To:     Vitaly Chikunov <vt@altlinux.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
References: <20230311091644.647214-1-vt@altlinux.org>
Content-Language: en-US
From:   R Nageswara Sastry <rnsastry@linux.ibm.com>
In-Reply-To: <20230311091644.647214-1-vt@altlinux.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: fDcseprARY2ag8c1OE9tOLe-WsrAxgG9
X-Proofpoint-ORIG-GUID: recvaP1nC3TX4lyeycQdz3WD2IAD8u1Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-14_06,2023-03-14_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1015
 malwarescore=0 suspectscore=0 priorityscore=1501 mlxscore=0 bulkscore=0
 mlxlogscore=999 adultscore=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303140112
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 11/03/23 2:46 pm, Vitaly Chikunov wrote:
> fsverity requires fs blocksize to be equal to pagesoze, which is
> different on ppc64 (64K). Default mkfs blocksize if 4K. This difference
> causes mount failure and following error message:
> 
>    INFO: Mounting loopback filesystem
>    mount: /tmp/fsverity-test: wrong fs type, bad option, bad superblock on /dev/loop0, missing codepage or helper program, or other error.
>           dmesg(1) may have more information after failed mount system call.
>    FAILURE: mounting loopback filesystem
> 
> It's said this limitation is removed in Linux v6.3, but for backward
> compatibility better to leave workaround for it.
> 
> Fixes: b259a2b ("tests: add fsverity measurement test")
> Signed-off-by: Vitaly Chikunov <vt@altlinux.org>

Tested-by: Nageswara R Sastry <rnsastry@linux.ibm.com>

Tested on Power10, PowerVM:

1. Kernel version: 6.3-rc6
with or with out this patch the fsverity.test result is same ie:
PASS: 6 SKIP: 0 FAIL: 0


2. Kernel version: 6.2.6

with out patch:
seen the reported error ie
mount: /tmp/fsverity-test: wrong fs type, bad option, bad superblock on 
/dev/loop0, missing codepage or helper program, or other error.
FAILURE: mounting loopback filesystem

with patch:
PASS: 4 SKIP: 2 FAIL: 0



> ---
>   tests/fsverity.test | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/fsverity.test b/tests/fsverity.test
> index 01d5c35..5ad7634 100755
> --- a/tests/fsverity.test
> +++ b/tests/fsverity.test
> @@ -120,6 +120,9 @@ create_loopback_file() {
>   	case $fs_type in
>   	ext4|f2fs)
>   		options="-O verity"
> +		# verity requires blocksize to be equal to pagesize.
> +		pagesize=$(getconf PAGE_SIZE)
> +		[ "$pagesize" -eq 4096 ] || options+=" -b $pagesize"
>   		;;
>   	btrfs)
>   		;;
> @@ -136,7 +139,7 @@ create_loopback_file() {
>   	fi
>   
>   	echo "INFO: Building an $fs_type filesystem"
> -	if ! mkfs -t "$fs_type" -q "${TST_IMG}" "$options"; then
> +	if ! mkfs -t "$fs_type" -q "${TST_IMG}" $options; then
>   		echo "${RED}FAILURE: Creating $fs_type filesystem${NORM}"
>   		exit "$FAIL"
>   	fi

-- 
Thanks and Regards
R.Nageswara Sastry
