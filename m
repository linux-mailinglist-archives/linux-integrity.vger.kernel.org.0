Return-Path: <linux-integrity+bounces-5417-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 59663A704DB
	for <lists+linux-integrity@lfdr.de>; Tue, 25 Mar 2025 16:21:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C40E9189874C
	for <lists+linux-integrity@lfdr.de>; Tue, 25 Mar 2025 15:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9C3825BAD0;
	Tue, 25 Mar 2025 15:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ofyL/OIc"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE5E1F4E4B;
	Tue, 25 Mar 2025 15:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742915896; cv=none; b=TjkG6B0AAr+bBu2GT23r3nnI+wpZL2wrq2OHJK+evOBaDfFTpAf2Q9Ux4iTRrj7ym0s2q3utJUgrvyGdgwBHURWhABl3Thv+mBQF+4208ivR25URvvRYBknSohoBtPDIgPyLVTG9IkF5xnrvBXxHrW58B4WG/givmn+T+eZXZxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742915896; c=relaxed/simple;
	bh=7zq/CQC7TQPp6gi1tP1ro4BFZ88fGpzq1RD3fjNhW6o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cPsbUINlxLMnZuuFhYBq5Sv/YWdPitgjUfqyBjrJoGNRuxnWE53MgszK425PE32F14JzOSeLzK6+E9ErtC4hgTHLtj/6imYVNhu0AtKn73G/gR0+nLmIXbdGA88yxtvrJXB6L2oJoWyR9SEjTQsD39qYDqFnCGr4Jpk2CACB3q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ofyL/OIc; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52PEeu96027015;
	Tue, 25 Mar 2025 15:17:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=POXX8n
	qBEfdO/eqxbnBmny0LaPP4yz9sWD3d9Oar7FI=; b=ofyL/OIcmYxQR88RVL3G5J
	bUQm0j3aqJRF7N/TaCaB7rsL0kv0BB++fHPUn4H4yGuoCdJuXTRi0UMCOKY2/wGC
	IzF8u2eqePP63cteN+BzNrF7B2CdSALr4VG//nCpgr4r5Rdn/yCMhyhhFEnPHFxA
	6I8BFZwSAEXOSXNersm9VK9ZIrzYDjYEaPgDCXZYVsBRBHL3e8YTh4OHj5mQ3CoC
	+2MH/G671v2e2XmvslgKaBBZa7LNOuT+kj8ouUqTI+hruBMgZI0HFng94cWLeP2U
	xeXpmmuSwF2xOZxJO+aVANb28Jt5NTUEd4CRhHA9l2rFhma7UiWERUeFqxVSw9Ug
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45kbjwwfnh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Mar 2025 15:17:58 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52PFBSiu024807;
	Tue, 25 Mar 2025 15:17:58 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45kbjwwfna-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Mar 2025 15:17:58 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52PBvQOv030325;
	Tue, 25 Mar 2025 15:17:57 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 45j7htc62r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Mar 2025 15:17:57 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52PFHsYZ21889726
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Mar 2025 15:17:55 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9386B5805F;
	Tue, 25 Mar 2025 15:17:56 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 97C9258053;
	Tue, 25 Mar 2025 15:17:55 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.150.123])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 25 Mar 2025 15:17:55 +0000 (GMT)
Message-ID: <5a1eb4d04d429bf636f781fc333cd4ccba2bdc0b.camel@linux.ibm.com>
Subject: Re: [RFC PATCH v2 05/13] ima: select CRYPTO_SHA256 from Kconfig
From: Mimi Zohar <zohar@linux.ibm.com>
To: Nicolai Stange <nstange@suse.de>,
        Roberto Sassu
 <roberto.sassu@huawei.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc: Eric Snowberg <eric.snowberg@oracle.com>,
        Jarkko Sakkinen
 <jarkko@kernel.org>,
        James Bottomley
 <James.Bottomley@HansenPartnership.com>,
        linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date: Tue, 25 Mar 2025 11:17:55 -0400
In-Reply-To: <20250323140911.226137-6-nstange@suse.de>
References: <20250323140911.226137-1-nstange@suse.de>
	 <20250323140911.226137-6-nstange@suse.de>
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
X-Proofpoint-GUID: rLr7uNarF-6U1np-qOZqJ8_EVMHxTCnq
X-Proofpoint-ORIG-GUID: J8L-Hbvx5O46SQOwmEbM5bq5SR7VegyH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-25_06,2025-03-25_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 spamscore=0
 clxscore=1015 bulkscore=0 adultscore=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503250105

On Sun, 2025-03-23 at 15:09 +0100, Nicolai Stange wrote:
> Since recently, IMA would not record measurement list entries into PCR
> banks for which it doesn't have a corresponding in-kernel hash algorithm
> implementation available anymore (for
> CONFIG_IMA_COMPAT_FALLBACK_TPM_EXTEND=3Dn).

Not necessary info.

>=20
> With TPM 2.0, the only hash algorithms guaranteed to be implemented on a
> TPM are SHA-256/384, c.f. "TCG PC Client Platform TPM Profile
> Specification for TPM 2.0", sec. 4.6 "PCR Requirements".

Ok

> In particular, sha1 is not mandatory, and thus, the CRYPTO_SHA1 dependenc=
y
> of IMA is not sufficient anymore for ensuring that IMA would find at leas=
t
> one usable PCR bank.

No necessary info.

>=20
> So, in order to make sure that IMA has access to at least one usable bank
> on platforms featuring a TPM 2.0 device, make it depend on CRYPTO_SHA256.

-> Make sure that ...

>=20
> Keep the dependency on CRYPTO_SHA1 for the TPM 1 case.

Wondering if the "select CRYPTO_SHA1" could be dependent on TPM 1.2 being
configured as builtin.

>=20
> Signed-off-by: Nicolai Stange <nstange@suse.de>
> ---
>  security/integrity/ima/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kcon=
fig
> index c8f12a4a4edf..8a7e74dc1477 100644
> --- a/security/integrity/ima/Kconfig
> +++ b/security/integrity/ima/Kconfig
> @@ -7,6 +7,7 @@ config IMA
>  	select CRYPTO
>  	select CRYPTO_HMAC
>  	select CRYPTO_SHA1
> +	select CRYPTO_SHA256
>  	select CRYPTO_HASH_INFO
>  	select SECURITY_PATH
>  	select TCG_TPM if HAS_IOMEM

It's not enough to "select CRYPTO_SHA256".  As mentioned on "[RFC PATCH v2
02/13] ima: always create runtime_measurements sysfs file for ima_hash",  d=
on't
assume "ima_hash" will be SHA256.  Include SHA256 as an "extra" hash algori=
thm,
even if it isn't an enabled TPM bank.

Mimi

