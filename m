Return-Path: <linux-integrity+bounces-5139-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6863FA55614
	for <lists+linux-integrity@lfdr.de>; Thu,  6 Mar 2025 19:59:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93654172F1A
	for <lists+linux-integrity@lfdr.de>; Thu,  6 Mar 2025 18:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8EF026B0A9;
	Thu,  6 Mar 2025 18:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZuTgZMNB"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5725A25D54E
	for <linux-integrity@vger.kernel.org>; Thu,  6 Mar 2025 18:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741287575; cv=none; b=Qv8a3Yl1nuYCRT3WZ0RdsQUSrSwVUS6nPOzKzYqbpMtlT89tG73jNda3l/huvqCMZqvYkrGipxEdhkhDm+ySJ2Pz2p7vNQTxrJIKIL6InFLZmOcBNr+LAEj9E5ksUSmiYshIj97MYbLuhv6WPDXMxFe+kEHskQ6l2NVuk0UNiaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741287575; c=relaxed/simple;
	bh=s42C+03hqGp0Gxnmzwh34bP6BBS6vbENu5XbX4bMd8E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MmJ0J8IEs8Rf5i+17CovvCDc9nRFmKpKj8DEJZDcMf0AzO2clRfuCXlVD1irkosWXmBZQXk6yDXNIWp2FKc9F2GBOgsLO3egYsCMahFTp9x6qskPNIicx1uUDQKgkv6KCo60oBIV2eEx5et0aADVJ2c644E3rgaq0L4IRa1mQzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZuTgZMNB; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 526CVIKs023802;
	Thu, 6 Mar 2025 18:59:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=M6MmZA
	DOLjlmp5wBIpW3AP0RYgDRR8PKI89vEsVMCww=; b=ZuTgZMNBkyRhCL6Wf0MerR
	+J414yGiBCJ146ioTEQXvjV3X7xi9WsphYkmuFDVc8JiUXsSPOCXmEJg78S7oFOF
	zvOA3Rv63pUtj3T7jVKvMOIOZW9JYssc5FYd8LIve/InoJyqgc8BIyZ371vTKk9U
	t8OqMamPooLGoJtnsl3sfZeoB6S2NizFw38dayJiQMYIlr5jpqXNE1HUZHzfQiYa
	Q7DSqjCrulM4JcDuRtTRvzrvx9tLhTRcUiP2tRvQohPFteqdntDmHuAVQP2XMhmi
	gFdmeeNrBI8/uWx5SRryCf0esfJxMxAh6CJ8JhFUEWstpux1btq+Id/aME+G5qEg
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4574394ff1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Mar 2025 18:59:27 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 526Gn57E020824;
	Thu, 6 Mar 2025 18:59:26 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 454eska4vv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Mar 2025 18:59:26 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 526IxP7c30868146
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 6 Mar 2025 18:59:26 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A11A558059;
	Thu,  6 Mar 2025 18:59:25 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1555C58058;
	Thu,  6 Mar 2025 18:59:25 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.31.103.152])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  6 Mar 2025 18:59:24 +0000 (GMT)
Message-ID: <f16aae4408cc7bdd98fa70972b70747c26958dd1.camel@linux.ibm.com>
Subject: Re: Unbalanced TPM2 HMAC session calls
From: Mimi Zohar <zohar@linux.ibm.com>
To: Jonathan McDowell <noodles@earth.li>,
        James Bottomley
 <James.Bottomley@hansenpartnership.com>,
        Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-integrity@vger.kernel.org
Date: Thu, 06 Mar 2025 13:59:24 -0500
In-Reply-To: <Z8m8G0RfiRyYGH_t@earth.li>
References: <Z8m8G0RfiRyYGH_t@earth.li>
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
X-Proofpoint-GUID: 0_4ZEJviF562WCylegBP44diXvXsyzk3
X-Proofpoint-ORIG-GUID: 0_4ZEJviF562WCylegBP44diXvXsyzk3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-06_06,2025-03-06_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 spamscore=0 phishscore=0 clxscore=1015 mlxscore=0
 malwarescore=0 adultscore=0 mlxlogscore=999 priorityscore=1501 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503060144

On Thu, 2025-03-06 at 15:15 +0000, Jonathan McDowell wrote:
> We're seeing a lot of:
>=20
> tpm tpm0: auth session is active
>=20
> messages in our logs. This is emitted (once per boot) by=20
> tpm2_start_auth_session() if the auth sessions is already active when it=
=20
> is called.
>=20
> Investigating I think this is because tpm2_pcr_extend() calls=20
> tpm_buf_append_hmac_session() which sets TPM2_SA_CONTINUE_SESSION so=20
> tpm_buf_check_hmac_response() does not cleanup the auth session, but=20
> then doesn't call tpm2_end_auth_session().
>=20
> Looking at tpm2_get_random() it uses TPM2_SA_CONTINUE_SESSION but *also*=
=20
> cleans up with tpm2_end_auth_session().
>=20
> I'd be sending a patch proposing the addition of tpm2_end_auth_session()=
=20
> to the end of tpm2_pcr_extend() but I recall a bunch of discussion=20
> about trying to cache the HMAC session to improve IMA performance, so I=
=20
> don't know if perhaps we should be dropping the warning instead?

Hi Jonathan,

That suggestion was nixed.  Instead the boot command line option
"tpm.disable_pcr_integrity" was upstreamed to disable the HMAC for TPM exte=
nds.
Refer to commit 27184f8905ba ("tpm: Opt-in in disable PCR integrity
protection').

Mimi

>=20
> (As an aside, I'm not clear dropping the warning is enough, as I can't=
=20
> see where the session otherwise gets cleaned up other than by accident=
=20
> when the RNG tries to get more randomness.)
>=20


