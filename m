Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79821247090
	for <lists+linux-integrity@lfdr.de>; Mon, 17 Aug 2020 20:12:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389975AbgHQSLy (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 17 Aug 2020 14:11:54 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42516 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388305AbgHQSLt (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 17 Aug 2020 14:11:49 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07HI1Iig154383;
        Mon, 17 Aug 2020 14:11:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=Gzhy5p5b7/JT+W3fL0vpidMiVbqeH6V27N3m/qo5E2o=;
 b=MfGPDHWoYAJUAXFDotbMODDEh9LC5QlIERoscG0gCSuaEtwpE2vOE96bN0mJwMKudb5o
 j9igS3FyJMmz0NsSkSvlHwI8rPPcR+gesC2bB4NwJJp814jf683/b1Wq41fK6NcUX1LW
 iEQtxW/hiWPQRoD/qFV+l0ngcK6LCNA+E4FVCO+GUZDAXgWqTywLf9REEuDe4EaZemvE
 y5Hl4wha+Wtil2jEzVH6S+wzW54I21gmqHqbQhmHxj0NRCxSFFvLHEIAYyogL16DzAeC
 mBHqkK7nAuHbDy9FfBaDLy/9iyQyR0l8bvT0JaZua7T9AuDtXzI1QcIqKzcCCqtgef3p Ww== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 32y7nhba2f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Aug 2020 14:11:40 -0400
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 07HI2305157748;
        Mon, 17 Aug 2020 14:11:40 -0400
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0b-001b2d01.pphosted.com with ESMTP id 32y7nhba27-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Aug 2020 14:11:40 -0400
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07HHo9Tg018235;
        Mon, 17 Aug 2020 18:11:40 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by ppma02wdc.us.ibm.com with ESMTP id 32x7b8juux-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Aug 2020 18:11:40 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07HIBa0030736814
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Aug 2020 18:11:36 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0E4637805E;
        Mon, 17 Aug 2020 18:11:39 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5BFE97805F;
        Mon, 17 Aug 2020 18:11:38 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon, 17 Aug 2020 18:11:38 +0000 (GMT)
Subject: Re: [ima-evm-utils][PATCH] Install the swtpm package, if available
To:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc:     Petr Vorel <pvorel@suse.cz>, Vitaly Chikunov <vt@altlinux.org>,
        Bruno Meneguele <bmeneg@redhat.com>
References: <20200816193627.73935-1-zohar@linux.ibm.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <cf0df896-e281-1a6e-166f-a799ee244920@linux.ibm.com>
Date:   Mon, 17 Aug 2020 14:11:37 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200816193627.73935-1-zohar@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-17_13:2020-08-17,2020-08-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 mlxscore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 mlxlogscore=999 clxscore=1011 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2008170127
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 8/16/20 3:36 PM, Mimi Zohar wrote:
> The "boot_aggregate.test" requires either a hardware or software TPM.
> Support using the swtpm, if packaged for the distro, in addition to
> tpm_server.
>
> Note: Some travis/<distro>.sh scripts are links to other scripts.
> Don't fail the build of the linked script if the swtpm package doesn't
> exist.
>
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
>   .travis.yml               |  2 +-
>   tests/boot_aggregate.test | 40 ++++++++++++++++++++++++++++-----------
>   travis/fedora.sh          |  1 +
>   3 files changed, 31 insertions(+), 12 deletions(-)
>
> diff --git a/.travis.yml b/.travis.yml
> index 849fcb6ba822..9bea5d19bd0e 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -75,4 +75,4 @@ before_install:
>   script:
>       - INSTALL="${DISTRO%%:*}"
>       - INSTALL="${INSTALL%%/*}"
> -    - docker run -t ima-evm-utils /bin/sh -c "cd travis && if [ \"$VARIANT\" ]; then ARCH=\"$ARCH\" ./$INSTALL.$VARIANT.sh; fi && ARCH=\"$ARCH\" CC=\"$CC\" TSS=\"$TSS\" ./$INSTALL.sh && if [ ! \"$VARIANT\" ]; then which tpm_server || ../tests/install-swtpm.sh; fi && CC=\"$CC\" VARIANT=\"$VARIANT\" ../build.sh"
> +    - docker run -t ima-evm-utils /bin/sh -c "cd travis && if [ \"$VARIANT\" ]; then ARCH=\"$ARCH\" ./$INSTALL.$VARIANT.sh; fi && ARCH=\"$ARCH\" CC=\"$CC\" TSS=\"$TSS\" ./$INSTALL.sh && if [ ! \"$VARIANT\" ]; then which tpm_server || which swtpm || ../tests/install-swtpm.sh; fi && CC=\"$CC\" VARIANT=\"$VARIANT\" ../build.sh"
> diff --git a/tests/boot_aggregate.test b/tests/boot_aggregate.test
> index 43de67de1468..ce310b6ae5b4 100755
> --- a/tests/boot_aggregate.test
> +++ b/tests/boot_aggregate.test
> @@ -33,6 +33,10 @@ else
>   	ASCII_RUNTIME_MEASUREMENTS="./sample-ascii_runtime_measurements-pcrs-8-9"
>   	export TPM_INTERFACE_TYPE="socsim"
>   	export TPM_COMMAND_PORT=2321
> +	export TPM_PLATFORM_PORT=2322
> +	export TPM_SERVER_NAME="localhost"
> +	export TPM_SERVER_TYPE="raw"
> +
>   fi
>
>   # Only stop this test's software TPM.  Preferred method: "tsstpmcmd -stop"
> @@ -48,22 +52,36 @@ cleanup() {
>
>   # Try to start a software TPM if needed.
>   swtpm_start() {
> -	local swtpm
> +	local swtpm swtpm1
>
>   	swtpm="$(which tpm_server)"
> -	if [ -z "${swtpm}" ]; then
> -		echo "${CYAN}SKIP: Softare TPM (tpm_server) not found${NORM}"
> +	swtpm1="$(which swtpm)"
> +	if [ -z "${swtpm}" ] && [ -z "${swptm1}" ]; then
> +		echo "${CYAN}SKIP: Softare TPM (tpm_server and swtpm) not found${NORM}"
>   		return "$SKIP"
>   	fi
>
> -	pgrep tpm_server
> -	if [ $? -eq 0 ]; then
> -		echo "INFO: Software TPM (tpm_server) already running"
> -		return 114
> -	else
> -		echo "INFO: Starting software TPM: ${swtpm}"
> -		${swtpm} > /dev/null 2>&1 &
> -		SWTPM_PPID=$!
> +	if [ ! -z "${swtpm1}" ]; then


Change to 'if [ -n "${swtpm1}" ]; then' ?


> +		pgrep swtpm1
> +		if [ $? -eq 0 ]; then
> +			echo "INFO: Software TPM (swtpm) already running"
> +			return 114
> +		else
> +			echo "INFO: Starting software TPM: ${swtpm1}"
> +			mkdir ./myvtpm
> +			${swtpm1} socket --tpmstate dir=./myvtpm --tpm2 --ctrl type=tcp,port=2322 --server type=tcp,port=2321 --flags not-need-init > /dev/null 2>&1 &
> +			SWTPM_PPID=$!
> +		fi
> +	elif [ ! -z "${swtpm}" ]; then


Same here.

> +		pgrep swtpm
> +		if [ $? -eq 0 ]; then
> +			echo "INFO: Software TPM (tpm_server) already running"
> +			return 114
> +		else
> +			echo "INFO: Starting software TPM: ${swtpm}"
> +			${swtpm} > /dev/null 2>&1 &
> +			SWTPM_PPID=$!
> +		fi
>   	fi
>   	return 0
>   }
> diff --git a/travis/fedora.sh b/travis/fedora.sh
> index d3459e408d81..f9ee9bed7bc1 100755
> --- a/travis/fedora.sh
> +++ b/travis/fedora.sh
> @@ -41,6 +41,7 @@ yum -y install \
>   	which
>
>   yum -y install docbook5-style-xsl || true
> +yum -y install swtpm || true
>
>   # FIXME: debug
>   echo "find /tss2_esys.h"


