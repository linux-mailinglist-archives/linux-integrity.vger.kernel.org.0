Return-Path: <linux-integrity+bounces-4628-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7CC9A1A909
	for <lists+linux-integrity@lfdr.de>; Thu, 23 Jan 2025 18:40:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E5F43A4F91
	for <lists+linux-integrity@lfdr.de>; Thu, 23 Jan 2025 17:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFAE61474A2;
	Thu, 23 Jan 2025 17:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="G492nb+I"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A638EC5
	for <linux-integrity@vger.kernel.org>; Thu, 23 Jan 2025 17:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737654000; cv=none; b=TVolUn0UsocBSA5QN7+0JH2uC7k9vbpZ+a8yWf6zAZj+l5CsHB3UyZHFNYoCsY5l1Seyk09FJOxdgOJL9vwJwjbFzLM8/y38clUGdO+OxtlNF88xn6v+qoYbWE/rNvLUXfuFE7uLh8Zl6p0M3cKZMZ+MjzzZzToJ/VjB8+9nDeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737654000; c=relaxed/simple;
	bh=uukO9VTEBpizSnyKKzqbUbDkcMY1j98HopbfqeeRsos=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AxKRqOydLBYXi5o3ybRe+4DrEq2cB9BBWGWLlkX+4pT03iyjCH4+weGvUYqhvgE7I6vQTy58iVdx7EqrZnS8XS1BAh4iYF4cGhQyLj34TOnRLJJVILkhHdiYweK0hy9vVfR8HS7MpuEe18Yn0bdbBJ8/HLCYq4mcy+w64KnDaxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=G492nb+I; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50NFdT9M001995;
	Thu, 23 Jan 2025 17:39:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=8r5iKo
	TiDMS1mg7o0fmUlPoSwOyHMvJejeBuMi0Du14=; b=G492nb+I+l6fBcJIOJqaVz
	HtSOZj2shGTz3vqurfVxYF1IO07AZ1rU3mSuzYVKGSDrq6hDH/gqT9sjDg6RPR9o
	mSK9iF7ro0AYgH32vKdJe261x/T05RVHbh7vUE7bb28tZZxpWWvWEKwzA3uQUDFn
	eXRcmFCgJW36B8hWPwToCUpCT+F20hesIASRNKqxaFO9GWZwViHhPWpeHvqnS/83
	KIzknfmguVIqLJDrtYW6HCqgXGKu7nqnYeNKdvTuoV70EzLR+ybgCNj9+X5LaXFs
	rSbzIRzneH2FI32LB7nYEwhtnE5CPYb/+kggB9z8Zyaf3lWXKMiQwyC+GftymUOA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44brku0jq3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jan 2025 17:39:54 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50NEmAZf024307;
	Thu, 23 Jan 2025 17:39:53 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 448q0yes0e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jan 2025 17:39:53 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50NHdrcv7668012
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jan 2025 17:39:53 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7E2815805A;
	Thu, 23 Jan 2025 17:39:53 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0F4C458054;
	Thu, 23 Jan 2025 17:39:53 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.4.223])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 23 Jan 2025 17:39:52 +0000 (GMT)
Message-ID: <457bde4721991e43ceb6deefeee4a3fde33661e6.camel@linux.ibm.com>
Subject: Re: [PATCH v3 09/10] ima_measurements.sh: Check policy for test3
From: Mimi Zohar <zohar@linux.ibm.com>
To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
Cc: linux-integrity@vger.kernel.org
Date: Thu, 23 Jan 2025 12:39:52 -0500
In-Reply-To: <20250114112915.610297-10-pvorel@suse.cz>
References: <20250114112915.610297-1-pvorel@suse.cz>
	 <20250114112915.610297-10-pvorel@suse.cz>
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
X-Proofpoint-ORIG-GUID: pHZ0zuCpHVF8IPGojvj0yY8P589FJVE-
X-Proofpoint-GUID: pHZ0zuCpHVF8IPGojvj0yY8P589FJVE-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-23_07,2025-01-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 suspectscore=0 mlxlogscore=999 clxscore=1015 lowpriorityscore=0
 spamscore=0 malwarescore=0 phishscore=0 adultscore=0 priorityscore=1501
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501230128

Hi Petr,

On Tue, 2025-01-14 at 12:29 +0100, Petr Vorel wrote:
> First two tests are working with ima_policy=3Dtcb,
> but 3rd test requires more specific policy.
>=20
> Signed-off-by: Petr Vorel <pvorel@suse.cz>

Sorry I'm not seeing the difference between "ima_policy=3Dtcb" and the spec=
ific policy.
The patch itself looks correct and should allow the test to work even witho=
ut
specifying the "tcb" policy on the boot command line.

After fixing the patch description, feel free to add:

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>


> ---
> =C2=A0.../kernel/security/integrity/ima/tests/ima_measurements.sh=C2=A0 |=
 5 +++++
> =C2=A01 file changed, 5 insertions(+)
>=20
> diff --git a/testcases/kernel/security/integrity/ima/tests/ima_measuremen=
ts.sh
> b/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh
> index c42c31c898..35acc6ea78 100755
> --- a/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh
> +++ b/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh
> @@ -77,6 +77,11 @@ test3()
> =C2=A0	tst_res TINFO "verify not measuring user files"
> =C2=A0	tst_check_cmds sudo || return
> =C2=A0
> +	if [ "$IMA_POLICY_CHECKED" !=3D 1 ]; then
> +		tst_res TCONF "test requires specific policy, try load it with
> LTP_IMA_LOAD_POLICY=3D1"
> +		return
> +	fi
> +
> =C2=A0	if ! id $user >/dev/null 2>/dev/null; then
> =C2=A0		tst_res TCONF "missing system user $user (wrong installation)"
> =C2=A0		return


