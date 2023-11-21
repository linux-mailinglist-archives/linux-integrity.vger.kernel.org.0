Return-Path: <linux-integrity+bounces-174-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5CF97F3A04
	for <lists+linux-integrity@lfdr.de>; Wed, 22 Nov 2023 00:03:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80A7CB211EA
	for <lists+linux-integrity@lfdr.de>; Tue, 21 Nov 2023 23:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D042354BEF;
	Tue, 21 Nov 2023 23:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GiT/qhUx"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA43E10C
	for <linux-integrity@vger.kernel.org>; Tue, 21 Nov 2023 15:03:33 -0800 (PST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ALMkDdf018481;
	Tue, 21 Nov 2023 23:03:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=8MCUN10kPsWW4ejGYPhq89iX/EBpS3gODWOP3XpH0dA=;
 b=GiT/qhUxDxuAGxnwpCkTHRt3sMgbrg2HSxZXUBUMkcKzl9WTn0CICG/fxroRexAWym64
 29wCXw05+BwxDG9/xKyiEL4D/z3Yruick59RxUXDT3CVQ08r6Rmz5CxtoO6wQZ5DmgnM
 9BFVeyz19PE4ZGfpaVzIOB9Vr0ADI1m0WT8QhaQWhWYORSZ+FND8nePRyUhB5GkKB1/H
 hpOT+SRluqQhqLmKIgJfJEXCKkD7DBjZFOqo3PUV6sRBQSxppnshvr25c5s27RHxzI5S
 Nbq/hMy7uxxEgyqQbqpSWrTzOqBnWRVRtNrllhldtnRHprv4BHHgMwCwTzV4t1SgpVl1 TA== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uh4wn9jk6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Nov 2023 23:03:27 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3ALM4G75007410;
	Tue, 21 Nov 2023 23:03:26 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3uf7kt49nb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Nov 2023 23:03:26 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3ALN3QHM36504000
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Nov 2023 23:03:26 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E991458056;
	Tue, 21 Nov 2023 23:03:25 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9C41558085;
	Tue, 21 Nov 2023 23:03:25 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.87.103])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 21 Nov 2023 23:03:25 +0000 (GMT)
Message-ID: <3083025b210cd5c44e9fa0df578c0b210a690f0c.camel@linux.ibm.com>
Subject: Re: [ima-evm-utils PATCH 04/14] tests: Address issues raised by
 shellcheck SC2320
From: Mimi Zohar <zohar@linux.ibm.com>
To: Stefan Berger <stefanb@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc: roberto.sassu@huaweicloud.com
Date: Tue, 21 Nov 2023 18:03:25 -0500
In-Reply-To: <20231110202137.3978820-5-stefanb@linux.ibm.com>
References: <20231110202137.3978820-1-stefanb@linux.ibm.com>
	 <20231110202137.3978820-5-stefanb@linux.ibm.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 0XJlp-Leu8W5Y-24pV6E_3opsm_LZO6l
X-Proofpoint-ORIG-GUID: 0XJlp-Leu8W5Y-24pV6E_3opsm_LZO6l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-21_14,2023-11-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 adultscore=0 malwarescore=0
 impostorscore=0 mlxscore=0 bulkscore=0 phishscore=0 clxscore=1015
 spamscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311060000 definitions=main-2311210180

Hi Stefan,

On Fri, 2023-11-10 at 15:21 -0500, Stefan Berger wrote:
> Address issues raised by shellcheck SC2320:
>   "This $? refers to echo/printf, not a previous command.
>    Assign to variable to avoid it being overwritten."
> 
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> ---
>  tests/Makefile.am              | 2 +-
>  tests/mmap_check.test          | 8 +++-----
>  tests/portable_signatures.test | 9 +++------
>  3 files changed, 7 insertions(+), 12 deletions(-)
> 
> diff --git a/tests/Makefile.am b/tests/Makefile.am
> index bcc1ee4..babfa7a 100644
> --- a/tests/Makefile.am
> +++ b/tests/Makefile.am
> @@ -26,7 +26,7 @@ clean-local:
>  distclean: distclean-keys
>  
>  shellcheck:
> -	shellcheck -i SC2086,SC2181,SC2046 \
> +	shellcheck -i SC2086,SC2181,SC2046,SC2320 \
>  		functions.sh gen-keys.sh install-fsverity.sh \
>  		install-mount-idmapped.sh install-openssl3.sh \
>  		install-swtpm.sh install-tss.sh softhsm_setup \
> diff --git a/tests/mmap_check.test b/tests/mmap_check.test
> index 2dd3433..3d2e1b1 100755
> --- a/tests/mmap_check.test
> +++ b/tests/mmap_check.test
> @@ -97,11 +97,9 @@ check_load_ima_rule() {
>  
>  	new_policy=$(mktemp -p "$g_mountpoint")
>  	echo "$1" > "$new_policy"
> -	echo "$new_policy" > /sys/kernel/security/ima/policy
> -	result=$?
> -	rm -f "$new_policy"
> -
> -	if [ "$result" -ne 0 ]; then
> +	if echo "$new_policy" > /sys/kernel/security/ima/policy; then
> +		rm -f "$new_policy"
> +	else
>  		echo "${RED}Failed to set IMA policy${NORM}"
>  		return "$HARDFAIL"
>  	fi

This isn't equiavlent.  $new_policy was previously always removed.

> diff --git a/tests/portable_signatures.test b/tests/portable_signatures.test
> index 9f3339b..5251211 100755
> --- a/tests/portable_signatures.test
> +++ b/tests/portable_signatures.test
> @@ -80,7 +80,6 @@ METADATA_CHANGE_FOWNER_2=3002
>  
>  check_load_ima_rule() {
>  	local rule_loaded
> -	local result
>  	local new_policy
>  
>  	rule_loaded=$(grep "$1" /sys/kernel/security/ima/policy)
> @@ -88,11 +87,9 @@ check_load_ima_rule() {
>  		new_policy=$(mktemp -p "$g_mountpoint")
>  		echo "$1" > "$new_policy"
>  		evmctl sign -o -a sha256 --imasig --key "$key_path" "$new_policy" &> /dev/null
> -		echo "$new_policy" > /sys/kernel/security/ima/policy
> -		result=$?
> -		rm -f "$new_policy"
> -
> -		if [ "$result" -ne 0 ]; then
> +		if echo "$new_policy" > /sys/kernel/security/ima/policy; then
> +			rm -f "$new_policy"
> +		else
>  			echo "${RED}Failed to set IMA policy${NORM}"
>  			return "$FAIL"
>  		fi

Same here.

-- 
thanks,

Mimi


