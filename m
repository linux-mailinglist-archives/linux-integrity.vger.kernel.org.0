Return-Path: <linux-integrity+bounces-4629-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D48D0A1A916
	for <lists+linux-integrity@lfdr.de>; Thu, 23 Jan 2025 18:45:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B6A11685EB
	for <lists+linux-integrity@lfdr.de>; Thu, 23 Jan 2025 17:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B340146A7B;
	Thu, 23 Jan 2025 17:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jMLBsH7n"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8AC14600F
	for <linux-integrity@vger.kernel.org>; Thu, 23 Jan 2025 17:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737654336; cv=none; b=Ra0xmVaKCeezlICAm9Gb8+Htjfy9Uq85FpEgjEMm2MjqGWG0AFi0gPPSS9Zaj4MSzQuc+/nUTeOsNdLbGvWCUl3ydQTU8QOYj5j25qGjApIiNF2XmxrOkj2hYRyCSUa3Y/u0ehXL/l7jW4VRLYnrQhRWBr3zrfK770I+7EKXJVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737654336; c=relaxed/simple;
	bh=4KlNUVOAqpUDBiHrRJsi3KUeaVLhtjaRAVXgC3xL1hE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hMeFOKK0DBX4nFSU1Vku6gi9RqIpCaGFDo+CPqWxm2mqKPAQx/txRf+vOsqKXQbt2vijVYj3oytNf7LdTPfhaOJZM8PTL9LGOLvE3lNZsEcVOHGYF8htrbT2YwEap3Et78FP6WL/+ek/rltJgjKGyYtoDBwjip0Yvzv4Qj1MssA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jMLBsH7n; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50NAPogN022452;
	Thu, 23 Jan 2025 17:45:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=4KlNUV
	OAqpUDBiHrRJsi3KUeaVLhtjaRAVXgC3xL1hE=; b=jMLBsH7nnkb5nZWV2Y126/
	LMDaK86ir97o0VJ9KloI94OrnQt1x7bFS/a03DnL4Nwkgl5sYWWHbuI5rnx1eDL0
	9e4IymFWTTofi0TAu7rmksEX3cKEfDp+bKa7qp+h3Sr8HEzczhwk/13ZOT+Pix7L
	gXmHmKZU1Va88LgbeA5g4gkMcQ2wLSA2l6FlhdcRkaNsPfYp6Q310IEnz+0SbTUK
	lX5a+M+ZSEOhXoTv3LZmm3EZGGa+VszHNnjAPZWVP51pGxIXNcoQcrxLzyIfDwWw
	AvmIUXSi+rK6Jo15OQ47kkMxv9ml/w1xFfbbilemu0h6qyzNN66/NF4a/QBW+eFA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44bbu9cet0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jan 2025 17:45:29 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50NGDpnI021063;
	Thu, 23 Jan 2025 17:45:28 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 448sb1p9tq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jan 2025 17:45:28 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50NHjR1Q16056860
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jan 2025 17:45:28 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BA19E5805D;
	Thu, 23 Jan 2025 17:45:27 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4C0EB5805A;
	Thu, 23 Jan 2025 17:45:27 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.4.223])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 23 Jan 2025 17:45:27 +0000 (GMT)
Message-ID: <06b7338df420a274e6c2c9e4a8badce4cf277a01.camel@linux.ibm.com>
Subject: Re: [PATCH v3 06/10] ima_violations.sh: Declare tcb builtin policy
From: Mimi Zohar <zohar@linux.ibm.com>
To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
Cc: linux-integrity@vger.kernel.org
Date: Thu, 23 Jan 2025 12:45:26 -0500
In-Reply-To: <20250114112915.610297-7-pvorel@suse.cz>
References: <20250114112915.610297-1-pvorel@suse.cz>
	 <20250114112915.610297-7-pvorel@suse.cz>
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
X-Proofpoint-GUID: hKFybcQny4GHQRVcjbk5MM5W_W34SQI6
X-Proofpoint-ORIG-GUID: hKFybcQny4GHQRVcjbk5MM5W_W34SQI6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-23_07,2025-01-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=796
 priorityscore=1501 clxscore=1015 adultscore=0 bulkscore=0 mlxscore=0
 suspectscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0
 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501230128

On Tue, 2025-01-14 at 12:29 +0100, Petr Vorel wrote:
> IMA builtin policy contains required rules, allow using it.
> This helps more reliable results on kernels without
> CONFIG_IMA_READ_POLICY=3Dy.
>=20
> Signed-off-by: Petr Vorel <pvorel@suse.cz>

Thanks, Petr.

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

> ---
> =C2=A0testcases/kernel/security/integrity/ima/tests/ima_violations.sh | 1=
 +
> =C2=A01 file changed, 1 insertion(+)
>=20
> diff --git a/testcases/kernel/security/integrity/ima/tests/ima_violations=
.sh
> b/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
> index 1852e8bc74..37d8d473c2 100755
> --- a/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
> +++ b/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
> @@ -10,6 +10,7 @@ TST_SETUP=3D"setup"
> =C2=A0TST_CLEANUP=3D"cleanup"
> =C2=A0TST_CNT=3D3
> =C2=A0
> +REQUIRED_BUILTIN_POLICY=3D"tcb"
> =C2=A0REQUIRED_POLICY_CONTENT=3D'violations.policy'
> =C2=A0
> =C2=A0setup()


