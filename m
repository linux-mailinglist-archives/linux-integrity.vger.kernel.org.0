Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BECD6678B4
	for <lists+linux-integrity@lfdr.de>; Thu, 12 Jan 2023 16:12:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240352AbjALPMU (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 12 Jan 2023 10:12:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbjALPLr (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 12 Jan 2023 10:11:47 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 412E7120AE
        for <linux-integrity@vger.kernel.org>; Thu, 12 Jan 2023 07:00:47 -0800 (PST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30CEh9rQ020443;
        Thu, 12 Jan 2023 15:00:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=978pL6F/vm35tI5WgrHu8LPgFjuAeBEDsH/2P6m+yS0=;
 b=W+OCj58Opwhhs3RWmMbuUc0bfq/ywYllK0mUp2QR0lkr7UmwjrhlxmSr7Lq3q/qgyvlK
 rXhCCNGcFTDt1/RUatjUoo8/q/uQ85GEe0Bu+bfMUW3QebZaYI7os+eLFNeiY1IkErXX
 19gnzyMSl7KQ4DMHhkYOSnPgzAdi7ctXZCC9mRo+GOITCbuo4HcDWsL6mJSz/J6duZRS
 rxkPoQSIvZhLUDivrSvGbS0gEDo6oqQbD685CMnutSongzCskoS1JQZKPBsRPtHjNTZX
 JTNxVF2TLEoKYCDzF3k1SsfFB49af+q4QZSdb+c61i+38EOb0hqqC+iJ1Bcn5nzunY/O tQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3n2m7agdu7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Jan 2023 15:00:06 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30CEhpsg022523;
        Thu, 12 Jan 2023 15:00:05 GMT
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3n2m7agdtq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Jan 2023 15:00:05 +0000
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30CEb7r9004569;
        Thu, 12 Jan 2023 15:00:05 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([9.208.130.97])
        by ppma05wdc.us.ibm.com (PPS) with ESMTPS id 3n1kk7hsvn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Jan 2023 15:00:05 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
        by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30CF04fO30802354
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Jan 2023 15:00:04 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F1CC758054;
        Thu, 12 Jan 2023 15:00:03 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DD03158060;
        Thu, 12 Jan 2023 15:00:02 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 12 Jan 2023 15:00:02 +0000 (GMT)
Message-ID: <8d15733c-67bc-ce58-0724-fa5a9cdc905e@linux.ibm.com>
Date:   Thu, 12 Jan 2023 10:00:02 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH ima-evm-utils v2 4/9] Add support for UML in functions.sh
Content-Language: en-US
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>, zohar@linux.ibm.com,
        dmitry.kasatkin@gmail.com
Cc:     linux-integrity@vger.kernel.org, vt@altlinux.org, pvorel@suse.cz,
        Roberto Sassu <roberto.sassu@huawei.com>
References: <20230112122426.3759938-1-roberto.sassu@huaweicloud.com>
 <20230112122426.3759938-5-roberto.sassu@huaweicloud.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20230112122426.3759938-5-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: xTiwE5Fqh_KEuGInB9DcoOv1nCGFrVRh
X-Proofpoint-GUID: 5njSCujJ6tuH2ZdeBsZkEYLp1anP7fr1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-12_08,2023-01-12_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 spamscore=0 malwarescore=0 phishscore=0 impostorscore=0
 mlxscore=0 clxscore=1011 bulkscore=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301120105
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
> Add the new functions _run_user_mode(), _exit_user_mode(),
> _init_user_mode() and _cleanup_user_mode() to run the tests inside a system
> booted with the UML kernel.
> 
> A typical structure of a script with tests is:
> 
> trap cleanup SIGINT SIGTERM SIGSEGV EXIT
> 
> _cleanup() {
> 	<test cleanup>
> }
> 
> cleanup() {
> 	_cleanup_user_mode _cleanup
> 	_report_exit_and_cleanup
> }
> 
> <tests implementations>
> 
> _run_user_mode ../linux $PWD/$(basename $0) "env_var1=$env_var1 ..."
> 
> _exit_user_mode ../linux
> 
> _init_user_mode
> 
> <tests init>
> 
> <tests call>
> 
> If the UML_MODE environment variable is not set to 1, ignore the UML kernel
> execution and initialization requests, and perform the cleanup in the
> current environment. Ignore the same also if the script is already run in
> the UML environment, to avoid loops. Instead, for cleanup, do it only in
> the UML environment and skip it in the host environment.
> 
> Signal to the host environment failures of tests run in the UML environment
> with an unclean shutdown of the UML kernel.
> 
> Add haveged and systemd as dependencies for the tests in ci/fedora.sh,
> respectively for initializing the random number generator and for shutting
> down the system in the environment created by the UML kernel.
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>   ci/fedora.sh       |  4 ++-
>   tests/functions.sh | 79 +++++++++++++++++++++++++++++++++++++++++++++-
>   2 files changed, 81 insertions(+), 2 deletions(-)
> 
> diff --git a/ci/fedora.sh b/ci/fedora.sh
> index e60de7981c60..198034a34e3c 100755
> --- a/ci/fedora.sh
> +++ b/ci/fedora.sh
> @@ -45,7 +45,9 @@ yum -y install \
>   	vim-common \
>   	wget \
>   	which \
> -	zstd
> +	zstd \
> +	haveged \
> +	systemd
>   
>   yum -y install docbook5-style-xsl || true
>   yum -y install swtpm || true
> diff --git a/tests/functions.sh b/tests/functions.sh
> index 8f6f02dfcd95..98829d94fae1 100755
> --- a/tests/functions.sh
> +++ b/tests/functions.sh
> @@ -267,6 +267,16 @@ _report_exit_and_cleanup() {
>     [ $testsfail -gt 0 ] && echo -n "$RED" || echo -n "$NORM"
>     echo " FAIL: $testsfail"
>     echo "$NORM"
> +  # Signal failure to UML caller with an unclean shutdown.
> +  if [ -n "$UML_MODE" ] && [ "$UML_MODE" -eq 1 ] && [ $$ -eq 1 ]; then
> +    if [ -z "$(which poweroff)" ]; then
> +      echo "Warning: cannot properly shutdown system"
> +    fi
> +
> +    if [ $testsfail -eq 0 ]; then
> +      poweroff -f
> +    fi
> +  fi
>     if [ $testsfail -gt 0 ]; then
>       exit "$FAIL"
>     elif [ $testspass -gt 0 ]; then
> @@ -312,4 +322,71 @@ _softhsm_teardown() {
>     rm -rf "${SOFTHSM_SETUP_CONFIGDIR}"
>     unset SOFTHSM_SETUP_CONFIGDIR SOFTHSM2_CONF PKCS11_KEYURI \
>       EVMCTL_ENGINE OPENSSL_ENGINE OPENSSL_KEYFORM
> -}
> \ No newline at end of file
> +}
> +
> +# Syntax: _run_user_mode <UML binary> <init> <additional kernel parameters>
> +_run_user_mode() {
> +  if [ -z "$UML_MODE" ] || [ "$UML_MODE" -ne 1 ]; then
> +    return
> +  fi
> +
> +  if [ $$ -eq 1 ]; then
> +    return
> +  fi
> +
> +  expect_pass $1 rootfstype=hostfs rw init=$2 quiet mem=256M $3
> +}
> +
> +# Syntax: _exit_user_mode <UML binary>
> +_exit_user_mode() {
> +  if [ -z "$UML_MODE" ] || [ "$UML_MODE" -ne 1 ]; then
> +    return
> +  fi
> +
> +  if [ $$ -eq 1 ]; then
> +    return
> +  fi
> +
> +  if [ -f "$1" ]; then
> +    exit $OK
> +  fi
> +}
> +
> +# Syntax: _init_user_mode
> +_init_user_mode() {
> +  if [ -z "$UML_MODE" ] || [ "$UML_MODE" -ne 1 ]; then
> +    return
> +  fi
> +
> +  if [ $$ -ne 1 ]; then
> +    return
> +  fi
> +
> +  mount -t proc proc /proc
> +  mount -t sysfs sysfs /sys
> +  mount -t securityfs securityfs /sys/kernel/security
> +
> +  if [ -n "$(which haveged 2> /dev/null)" ]; then
> +    $(which haveged) -w 1024 &> /dev/null
> +  fi

What's different when it's missing?

> +
> +  pushd $PWD > /dev/null
> +}
> +
> +# Syntax: _cleanup_user_mode <cleanup function>
> +_cleanup_user_mode() {
> +  if [ -z "$UML_MODE" ] || [ "$UML_MODE" -ne 1 ]; then
> +    $1
> +    return
> +  fi
> +
> +  if [ $$ -ne 1 ]; then
> +    return
> +  fi
> +
> +  $1
> +
> +  umount /sys/kernel/security
> +  umount /sys
> +  umount /proc
> +}

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
