Return-Path: <linux-integrity+bounces-4626-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3DCCA1A905
	for <lists+linux-integrity@lfdr.de>; Thu, 23 Jan 2025 18:39:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F12FC1666AB
	for <lists+linux-integrity@lfdr.de>; Thu, 23 Jan 2025 17:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 534221474A2;
	Thu, 23 Jan 2025 17:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="E4sf8v3v"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0ADBEC5
	for <linux-integrity@vger.kernel.org>; Thu, 23 Jan 2025 17:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737653965; cv=none; b=IXIALDfhTs38hMV9FD4cIt/By8q4Fkhx6SlM4Cr69B8/gNG3mFhdYBqLc4E6RVq8e0Aun5VjE+fLB5jscEOaOn+I4GivlN+3j/95JqqNAnVp2sM9+sxyrtNAtjvXrbomXF5LarBPdC6CA5JQOgXE4JKK8pSnMCFmzmJubpt8ozQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737653965; c=relaxed/simple;
	bh=Wsx7NwHtvPc2zkVlBoq/r49b2GvlxZPoOjg9b4CTA1Q=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HLOk7bHOjeslUtoMt2pxogm2mUwrS98SaLsUgaf1M0wO22CK26RYsE27JISox4aJvrJNFBxazH6XWmS2Uxd4xz1j0TodlOC7xzon44K3nV0+ZfXfg4Ky2Gxo9IrzPIgyU5r8Fp685qDcMAbXxI2uyNnwm0RFYRAhZZCP5vlq5JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=E4sf8v3v; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50N9d722022534;
	Thu, 23 Jan 2025 17:39:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=A3uXV8
	hu1U2d0DiavA56xbXq20mzfmYKzcGlzqX/vDY=; b=E4sf8v3v/93jHR9VT/iwiR
	hKeUhSLFa2TN77XxHKMLiHAtha0Xm1VEFr6V9Yt1YXDd0lxQiMc4zuF3AJzKLEV8
	VNoNU5xnUw5iTdUhaC1lo4vf52hwd2//GUTMWkSf7q511bUwdjbaovQc+hmWirB5
	gl0NR90j/HsiLisQzdI5FTFlMQpDZE7uovCwTDI1bImNwoZvtpnr7UuvwdHqytB6
	/eAaX7JEaOq0Tnt+XLoWLGUhf9iXpgmk0VH0Kwmh/H+lrKXNYtEOaQegWsgpTJD+
	hrzSp3SwOhOeaMy1XChYE++hdadVmHVdO/YEgOxCims+BGgSCmbCaA6rSBXSYY2w
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44bbu9cdm8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jan 2025 17:39:17 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50NHZ3dn019223;
	Thu, 23 Jan 2025 17:39:16 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 448pmspu00-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jan 2025 17:39:16 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50NHdFFT12124816
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jan 2025 17:39:16 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9A40258055;
	Thu, 23 Jan 2025 17:39:15 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 203BE5804B;
	Thu, 23 Jan 2025 17:39:15 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.4.223])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 23 Jan 2025 17:39:15 +0000 (GMT)
Message-ID: <3c7dee2c281867aa279c9d556e4aa62a7e865d36.camel@linux.ibm.com>
Subject: Re: [PATCH v3 05/10] IMA: Read required policy from file
From: Mimi Zohar <zohar@linux.ibm.com>
To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
Cc: linux-integrity@vger.kernel.org
Date: Thu, 23 Jan 2025 12:39:14 -0500
In-Reply-To: <20250114112915.610297-6-pvorel@suse.cz>
References: <20250114112915.610297-1-pvorel@suse.cz>
	 <20250114112915.610297-6-pvorel@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: l5zSDrbCxZOzrgtxnh8jF8a51Woj2qxJ
X-Proofpoint-ORIG-GUID: l5zSDrbCxZOzrgtxnh8jF8a51Woj2qxJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-23_07,2025-01-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 priorityscore=1501 clxscore=1015 adultscore=0 bulkscore=0 mlxscore=0
 suspectscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0
 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501230128

On Tue, 2025-01-14 at 12:29 +0100, Petr Vorel wrote:
> Previously snipped of required policy was as a string or regexp.
> Loading required policy from file allows to move code to ima_setup.sh.
> This is a preparation for loading IMA policy from file.
>=20
> Check can be done on one or both:
> 1) IMA builtin policy (based on /proc/cmdline)
> 2) IMA policy content (actual content of /sys/kernel/security/ima/policy)
>=20
> When missing CONFIG_IMA_READ_POLICY=3Dy on required policy convert: test,=
 but convert
> TFAIL =3D> TCONF.
>=20
> Signed-off-by: Petr Vorel <pvorel@suse.cz>

Thanks, Petr.  Really nice patch.  Below is an improvement suggestion.

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

> ---
>=20
> diff --git a/testcases/kernel/security/integrity/ima/tests/ima_selinux.sh
> b/testcases/kernel/security/integrity/ima/tests/ima_selinux.sh
> index 75f9ba84e4..45fd741b5f 100755
> --- a/testcases/kernel/security/integrity/ima/tests/ima_selinux.sh
> +++ b/testcases/kernel/security/integrity/ima/tests/ima_selinux.sh
> @@ -1,6 +1,7 @@
> =C2=A0#!/bin/sh
> =C2=A0# SPDX-License-Identifier: GPL-2.0-or-later
> =C2=A0# Copyright (c) 2021 Microsoft Corporation
> +# Copyright (c) Linux Test Project, 2021-2025
> =C2=A0# Author: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> =C2=A0#
> =C2=A0# Verify measurement of SELinux policy hash and state.
> @@ -14,15 +15,12 @@ TST_CNT=3D2
> =C2=A0TST_SETUP=3D"setup"
> =C2=A0TST_MIN_KVER=3D"5.12"
> =C2=A0
> -FUNC_CRITICAL_DATA=3D'func=3DCRITICAL_DATA'
> -REQUIRED_POLICY=3D"^measure.*$FUNC_CRITICAL_DATA"
> +REQUIRED_POLICY_CONTENT=3D'selinux.policy'

The selinux.policy contains a specific critical data measurement rule:
measure func=3DCRITICAL_DATA label=3Dselinux.  However the test would work =
with the
generic policy rule "measure func=3DCRITICAL_DATA", which can be specified =
on the .=20
boot command line via "ima_policy=3Dcritical_data".

As long as being able to read the IMA policy is required, in addition to ch=
ecking
whether the specific critical data rule exists, check whether the generic r=
ule exists
before loading the specific one.

Perhaps all that is needed is defining REQUIRED_BUILTIN_POLICY like:
REQUIRED_BUILTIN_POLICY=3D"critical_data"

> =C2=A0
> =C2=A0setup()
> =C2=A0{
> =C2=A0	SELINUX_DIR=3D$(tst_get_selinux_dir)
> =C2=A0	[ "$SELINUX_DIR" ] || tst_brk TCONF "SELinux is not enabled"
> -
> -	require_ima_policy_content "$REQUIRED_POLICY" '-E' >
> $TST_TMPDIR/policy.txt
> =C2=A0}
> =C2=A0
> =C2=A0# Format of the measured SELinux state data.
> @@ -45,7 +43,7 @@ validate_policy_capabilities()
> =C2=A0		measured_value=3D$(echo $1 | awk -F'[=3D;]' -v inx=3D"$inx" '{pri=
nt
> $inx}')
> =C2=A0		expected_value=3D$(cat
> "$SELINUX_DIR/policy_capabilities/$measured_cap")
> =C2=A0		if [ "$measured_value" !=3D "$expected_value" ]; then
> -			tst_res TFAIL "$measured_cap: expected: $expected_value,
> got: $digest"
> +			tst_res $IMA_FAIL "$measured_cap: expected:
> $expected_value, got: $digest"
> =C2=A0			return
> =C2=A0		fi
> =C2=A0
> @@ -75,7 +73,7 @@ test1()
> =C2=A0	# in kernel memory for SELinux
> =C2=A0	line=3D$(grep -E "selinux-policy-hash" $ASCII_MEASUREMENTS | tail =
-1)
> =C2=A0	if [ -z "$line" ]; then
> -		tst_res TFAIL "SELinux policy hash not measured"
> +		tst_res $IMA_FAIL "SELinux policy hash not measured"
> =C2=A0		return
> =C2=A0	fi
> =C2=A0
> @@ -86,7 +84,7 @@ test1()
> =C2=A0		tst_brk TCONF "cannot compute digest for $algorithm"
> =C2=A0
> =C2=A0	if [ "$policy_digest" !=3D "$expected_policy_digest" ]; then
> -		tst_res TFAIL "Digest mismatch: expected: $expected_policy_digest,
> got: $policy_digest"
> +		tst_res $IMA_FAIL "Digest mismatch: expected:
> $expected_policy_digest, got: $policy_digest"
> =C2=A0		return
> =C2=A0	fi
> =C2=A0
> @@ -116,7 +114,7 @@ test2()
> =C2=A0	# state matches that currently set for SELinux
> =C2=A0	line=3D$(grep -E "selinux-state" $ASCII_MEASUREMENTS | tail -1)
> =C2=A0	if [ -z "$line" ]; then
> -		tst_res TFAIL "SELinux state not measured"
> +		tst_res $IMA_FAIL "SELinux state not measured"
> =C2=A0		return
> =C2=A0	fi
> =C2=A0
> @@ -129,7 +127,7 @@ test2()
> =C2=A0	tst_brk TCONF "cannot compute digest for $algorithm"
> =C2=A0
> =C2=A0	if [ "$digest" !=3D "$expected_digest" ]; then
> -		tst_res TFAIL "digest mismatch: expected: $expected_digest, got:
> $digest"
> +		tst_res $IMA_FAIL "digest mismatch: expected: $expected_digest,
> got: $digest"
> =C2=A0		return
> =C2=A0	fi
> =C2=A0
> @@ -146,20 +144,20 @@ test2()
> =C2=A0	enforced_value=3D$(echo $measured_data | awk -F'[=3D;]' '{print $4=
}')
> =C2=A0	expected_enforced_value=3D$(cat $SELINUX_DIR/enforce)
> =C2=A0	if [ "$expected_enforced_value" !=3D "$enforced_value" ]; then
> -		tst_res TFAIL "enforce: expected: $expected_enforced_value, got:
> $enforced_value"
> +		tst_res $IMA_FAIL "enforce: expected: $expected_enforced_value,
> got: $enforced_value"
> =C2=A0		return
> =C2=A0	fi
> =C2=A0
> =C2=A0	checkreqprot_value=3D$(echo $measured_data | awk -F'[=3D;]' '{prin=
t $6}')
> =C2=A0	expected_checkreqprot_value=3D$(cat $SELINUX_DIR/checkreqprot)
> =C2=A0	if [ "$expected_checkreqprot_value" !=3D "$checkreqprot_value" ]; =
then
> -		tst_res TFAIL "checkreqprot: expected:
> $expected_checkreqprot_value, got: $checkreqprot_value"
> +		tst_res $IMA_FAIL "checkreqprot: expected:
> $expected_checkreqprot_value, got: $checkreqprot_value"
> =C2=A0		return
> =C2=A0	fi
> =C2=A0
> =C2=A0	initialized_value=3D$(echo $measured_data | awk -F'[=3D;]' '{print=
 $2}')
> =C2=A0	if [ "$initialized_value" !=3D "1" ]; then
> -		tst_res TFAIL "initialized: expected 1, got: $initialized_value"
> +		tst_res $IMA_FAIL "initialized: expected 1, got:
> $initialized_value"
> =C2=A0		return
> =C2=A0	fi


