Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2573467B3B2
	for <lists+linux-integrity@lfdr.de>; Wed, 25 Jan 2023 14:53:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235073AbjAYNxD (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 25 Jan 2023 08:53:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbjAYNxC (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 25 Jan 2023 08:53:02 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50064448F
        for <linux-integrity@vger.kernel.org>; Wed, 25 Jan 2023 05:53:01 -0800 (PST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30PDPUlQ023444;
        Wed, 25 Jan 2023 13:52:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=EyZ8X7G4MewCyPYsVMRmrsCsXJFXLMeuvR4jSstY6Zs=;
 b=BXpDVGvhn5s1HTpDOOtnSbUxxk2VZDVink1Kqn1K/telbeOSiXfz09jHhBJKZI6rbfMO
 4Zph6amFiulGwVY9H26pfJS68NX1my9Kv1jiWEzK63KrOZqSXWJopNDtzfL/PSF31hP+
 kZO+klFifhQGOR/RhxzmGUvdbSW7XbDk7YBeWiv6B2fS0jkZjR0XVdS/XHWPixh47uDA
 g8oSIyTXRu9d2aUo33uK8pLd48x9Jp6EXEt5hQ5uIap7ISOzuxxw8cJTdefKEPx1wNxb
 iQfnLG04mbUV3H3MaiQtrlWci91IVIjJihmXqeWwQ8GKZ2lTnXUWgnziKVGzNMU4UfKX qA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3na9vcrb4c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Jan 2023 13:52:39 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30PDb68O014036;
        Wed, 25 Jan 2023 13:52:39 GMT
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3na9vcrb40-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Jan 2023 13:52:39 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30PBDPDG019860;
        Wed, 25 Jan 2023 13:52:38 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([9.208.129.114])
        by ppma04dal.us.ibm.com (PPS) with ESMTPS id 3n87p7e4aq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Jan 2023 13:52:38 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
        by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30PDqbHp54460906
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Jan 2023 13:52:37 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1A51E58050;
        Wed, 25 Jan 2023 13:52:37 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 61D5758045;
        Wed, 25 Jan 2023 13:52:36 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 25 Jan 2023 13:52:36 +0000 (GMT)
Message-ID: <946839db-8089-3d71-e723-c6816bb0cea9@linux.ibm.com>
Date:   Wed, 25 Jan 2023 08:52:35 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH ima-evm-utils v3 04/11] Pass cleanup function and its
 arguments to _report_exit_and_cleanup()
Content-Language: en-US
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>, zohar@linux.ibm.com,
        dmitry.kasatkin@gmail.com
Cc:     linux-integrity@vger.kernel.org, vt@altlinux.org, pvorel@suse.cz,
        Roberto Sassu <roberto.sassu@huawei.com>
References: <20230125085030.1568256-1-roberto.sassu@huaweicloud.com>
 <20230125085030.1568256-5-roberto.sassu@huaweicloud.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20230125085030.1568256-5-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 8gE7UPi07pHHAHpwyq7FwhqqTKn-szFu
X-Proofpoint-ORIG-GUID: lCXIrrD6A0d-lUsChjr1MwM9xcwQLAF5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-25_08,2023-01-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 phishscore=0 mlxlogscore=999 clxscore=1011 spamscore=0
 adultscore=0 priorityscore=1501 malwarescore=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301250121
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 1/25/23 03:50, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
> 
> If an error occurs before any test is executed, _report_exit_and_cleanup()
> returns 77 ($SKIP) as exit code, which might not reflect the real exit code
> at the time the script terminated its execution.
> 
> If the function registered in the shell trap() is a cleanup function
> calling _report_exit_and_cleanup() inside, the latter will not have access
> to the exit code at the time of the trap but instead to the exit code of
> the cleanup function.
> 
> To solve this issue, pass the cleanup function and its arguments to
> _report_exit_and_cleanup(), so that the latter can first get the script
> exit code and then can execute the cleanup function.
> 
> Finally, if no test was executed, return the exit code at the time of the
> trap() instead of 77.
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>   tests/boot_aggregate.test |  2 +-
>   tests/fsverity.test       |  3 +--
>   tests/functions.sh        | 10 ++++++++--
>   3 files changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/tests/boot_aggregate.test b/tests/boot_aggregate.test
> index d7115660385f..ca5faf9cd97d 100755
> --- a/tests/boot_aggregate.test
> +++ b/tests/boot_aggregate.test
> @@ -12,7 +12,7 @@
>   # for verifying the calculated boot_aggregate is included in this
>   # directory as well.
>   
> -trap cleanup SIGINT SIGTERM EXIT
> +trap '_report_exit_and_cleanup cleanup' SIGINT SIGTERM EXIT
>   
>   # Base VERBOSE on the environment variable, if set.
>   VERBOSE="${VERBOSE:-0}"
> diff --git a/tests/fsverity.test b/tests/fsverity.test
> index 549c42a32608..be9594010de5 100755
> --- a/tests/fsverity.test
> +++ b/tests/fsverity.test
> @@ -47,7 +47,7 @@ FSVERITY="$(which fsverity)"
>   _require dd mkfs blkid e2fsck tune2fs evmctl setfattr
>   ./gen-keys.sh >/dev/null 2>&1
>   
> -trap cleanup SIGINT SIGTERM EXIT
> +trap '_report_exit_and_cleanup cleanup' SIGINT SIGTERM EXIT
>   
>   cleanup() {
>           if [ -e $TST_MNT ]; then
> @@ -58,7 +58,6 @@ cleanup() {
>   			rm "$TST_IMG"
>   		fi
>   	fi
> -	_report_exit_and_cleanup
>   }
>   
>   # Loopback mount a file
> diff --git a/tests/functions.sh b/tests/functions.sh
> index 8f6f02dfcd95..cf83ad21562f 100755
> --- a/tests/functions.sh
> +++ b/tests/functions.sh
> @@ -250,10 +250,14 @@ _enable_gost_engine() {
>   # Show test stats and exit into automake test system
>   # with proper exit code (same as ours). Do cleanups.
>   _report_exit_and_cleanup() {
> +  local exit_code=$?
> +
>     if [ -n "${WORKDIR}" ]; then
>       rm -rf "${WORKDIR}"
>     fi
>   
> +  "$@"
> +
>     if [ $testsfail -gt 0 ]; then
>       echo "================================="
>       echo " Run with FAILEARLY=1 $0 $*"
> @@ -271,8 +275,10 @@ _report_exit_and_cleanup() {
>       exit "$FAIL"
>     elif [ $testspass -gt 0 ]; then
>       exit "$OK"
> -  else
> +  elif [ $testsskip -gt 0 ]; then
>       exit "$SKIP"
> +  else
> +    exit $exit_code

For consistency reasons (and to make shell checker happy): exit "$exit_code".


With this change:

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>

>     fi
>   }
>   
> @@ -312,4 +318,4 @@ _softhsm_teardown() {
>     rm -rf "${SOFTHSM_SETUP_CONFIGDIR}"
>     unset SOFTHSM_SETUP_CONFIGDIR SOFTHSM2_CONF PKCS11_KEYURI \
>       EVMCTL_ENGINE OPENSSL_ENGINE OPENSSL_KEYFORM
> -}
> \ No newline at end of file
> +}
