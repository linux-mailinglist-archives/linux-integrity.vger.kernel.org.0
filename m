Return-Path: <linux-integrity+bounces-3720-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 479FD98B2A9
	for <lists+linux-integrity@lfdr.de>; Tue,  1 Oct 2024 05:14:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E79AB24DAA
	for <lists+linux-integrity@lfdr.de>; Tue,  1 Oct 2024 03:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE2104AEE5;
	Tue,  1 Oct 2024 03:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XR8QBzDo"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5076B2CA2
	for <linux-integrity@vger.kernel.org>; Tue,  1 Oct 2024 03:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727752458; cv=none; b=rPXAqq03omo2nAJ5TzHPKylkhYa6wEo64FEGcrDKFd9mqinT34EUZYqkThGH/dYyPAJfJXhAmk5gIzuhREkob3FBBGq39+wmGVHfis6pLRE9VrLRMSXueMhAjyrrz1IDjawYEi/+3vSsoNy7m72MFHKLMD8vaF3cqWyUlGTYk+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727752458; c=relaxed/simple;
	bh=vyGChemqw1ztBwYqtr7LfISAj9zW6IMn+sERAm9wTvY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=E4e3JJYLLqPO0WQ9PNaTlqNMktBjqR6FBow5O5VRdOjaW+kTj2YqG/U6V5ocNOTmgjO/hBtzWFbogWlz6NfACtUTM9UPGdOrsvAZyU6x6qdloVEHVx86erEKC5DQ/SE8p7RRmerkIfFaKGCIuk2y0Ms9iU6VKyx7+h/ilgXkuQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XR8QBzDo; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48UITUCO014101;
	Tue, 1 Oct 2024 03:13:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:content-transfer-encoding:mime-version; s=pp1; bh=
	+i4xJIRTy+eL8Rd5Ma9RROyChPKtniM5ZFYNooNCeww=; b=XR8QBzDoF6uzH54T
	L71ezEqd6AIiioINOQrt6Ao882viEDyl3eh1FqIZ5D5S+kV1d8AFMighCGN+19Wi
	oWoy7IPfAXqFci+EjuT/9ihP7Qf30iZSbc3nbdMiA1CqXa6B2wyVYxRnxF9mqXaT
	XRKBOq+wob0kXJt87Banbz0XN8sI6RU0YzxpcLWkrMG4Hvqha7nahPLlEpYB+UOF
	DhXndqXqmIIR3m7Y7hJNRki/6nDvBkB+eGLrdZR4q9dnppldo6qTjVBX0pGKTUYe
	firsCXpiKNUwBYJSGl+UZvbkQJE/sP8TRtl19yJD9sr8Xtohg6RZm+0pmZGwkCZ8
	fZi4lQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41x9apd9n5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Oct 2024 03:13:57 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4910s2mt020409;
	Tue, 1 Oct 2024 03:13:57 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 41xv4s25ev-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Oct 2024 03:13:57 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4913DuQA42271084
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 1 Oct 2024 03:13:56 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5653158059;
	Tue,  1 Oct 2024 03:13:56 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AEE6058058;
	Tue,  1 Oct 2024 03:13:55 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.184.11])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  1 Oct 2024 03:13:55 +0000 (GMT)
Message-ID: <560e2303c30cc9c200156d223c323d2f353e711b.camel@linux.ibm.com>
Subject: Re: TPM HMAC (really) bad performance
From: Mimi Zohar <zohar@linux.ibm.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>,
        Roberto Sassu
	 <roberto.sassu@huaweicloud.com>,
        Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-integrity@vger.kernel.org
Date: Mon, 30 Sep 2024 23:13:55 -0400
In-Reply-To: <1f1e3b64c24608e9a37f959d9cf7e1f869311410.camel@HansenPartnership.com>
References: <b8a7b3566e6014ba102ab98e10ede0d574d8930e.camel@huaweicloud.com>
	 <d66af0d491f7576c7d865bf6de4da4c83cf0c3ba.camel@huaweicloud.com>
	 <7025be516c4de1cbd8958c80242f503cc6e92c4a.camel@HansenPartnership.com>
	 <dd0f55e179ae6aaa1c99c320facc1bb33ccb25c8.camel@linux.ibm.com>
	 <1f1e3b64c24608e9a37f959d9cf7e1f869311410.camel@HansenPartnership.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: jymp3lPKN17klJa3hKQZrW_Xy2isp0Gm
X-Proofpoint-GUID: jymp3lPKN17klJa3hKQZrW_Xy2isp0Gm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-09-30_22,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 lowpriorityscore=0 mlxlogscore=999 malwarescore=0 priorityscore=1501
 phishscore=0 mlxscore=0 suspectscore=0 adultscore=0 clxscore=1015
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2410010020

On Mon, 2024-09-30 at 17:16 -0700, James Bottomley wrote:
> On Mon, 2024-09-30 at 10:09 -0400, Mimi Zohar wrote:
> > On Fri, 2024-09-27 at 10:15 -0400, James Bottomley wrote:
> > > On Fri, 2024-09-27 at 15:53 +0200, Roberto Sassu wrote:
> > > > On Fri, 2024-09-06 at 14:32 +0200, Roberto Sassu wrote:
> > > > > Hi all
> > > > >=20
> > > > > when running the benchmark on my new component, the Integrity
> > > > > Digest Cache, I ran into a serious performance issue.
> > > > >=20
> > > > > The benchmark is extending a TPM PCR with 12313 entries of the
> > > > > IMA measurement list, and calculating the time elapsed for the
> > > > > operation.
> > > > >=20
> > > > > Without TPM HMAC: 102.8 seconds
> > > > >=20
> > > > > With TPM HMAC: 1941.71 seconds
> > > >=20
> > > > Jarkko patch set [1] improved the performance:
> > > >=20
> > > > 404.4 seconds
> > > >=20
> > > >=20
> > > > Still quite slow.
> > >=20
> > > So this is now the internal TPM overhead.=C2=A0 There's not much we c=
an
> > > do in the kernel to optimize that.=C2=A0 Your own figures were
> > >=20
> > > > No HMAC:
> > > >=20
> > > > # tracer: function_graph
> > > > #
> > > > # CPU=C2=A0 DURATION=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 FUNCTION CALLS
> > > > # |=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 |=C2=A0=C2=A0 |=C2=A0=C2=A0 |
> > > > =C2=A00)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 tpm2_pcr_extend() {
> > > > =C2=A00)=C2=A0=C2=A0 1.112 us=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=
 tpm_buf_append_hmac_session();
> > > > =C2=A00) # 6360.029 us |=C2=A0=C2=A0=C2=A0 tpm_transmit_cmd();
> > > > =C2=A00) # 6415.012 us |=C2=A0 }
> > > >=20
> > > >=20
> > > > HMAC:
> > > >=20
> > > > # tracer: function_graph
> > > > #
> > > > # CPU=C2=A0 DURATION=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 FUNCTION CALLS
> > > > # |=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 |=C2=A0=C2=A0 |=C2=A0=C2=A0 |
> > > > =C2=A01)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 tpm2_pcr_extend() {
> > > > =C2=A01)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 tpm2_start_auth_session() {
> > > > =C2=A01) * 36976.99 us |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tpm_transmit=
_cmd();
> > > > =C2=A01) * 84746.51 us |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tpm_transmit=
_cmd();
> > > > =C2=A01) # 3195.083 us |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tpm_transmit=
_cmd();
> > > > =C2=A01) @ 126795.1 us |=C2=A0=C2=A0=C2=A0 }
> > > > =C2=A01)=C2=A0=C2=A0 2.254 us=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=
 tpm_buf_append_hmac_session();
> > > > =C2=A01)=C2=A0=C2=A0 3.546 us=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=
 tpm_buf_fill_hmac_session();
> > > > =C2=A01) * 24356.46 us |=C2=A0=C2=A0=C2=A0 tpm_transmit_cmd();
> > > > =C2=A01)=C2=A0=C2=A0 3.496 us=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=
 tpm_buf_check_hmac_response();
> > > > =C2=A01) @ 151171.0 us |=C2=A0 }
> > >=20
> > > or 6ms for no session extend vs 24ms for with session extend, so
> > > effectively 4x slower, which is exactly what the above figures are
> > > also showing.
> > >=20
> > > > =C2=A0We should consider not only the boot performance.
> > > > Depending on the use case, IMA can be used after boot and slow
> > > > down applications performance.
> > >=20
> > > Right, but this is IMA fish or cut bait time: are you willing to
> > > pay a 4x penalty for improved security, bearing in mind that not
> > > all TPMs will show the 4x slow down, since some have much better
> > > optimized crypto routines.=C2=A0 If yes, we can simply keep the no fl=
ush
> > > optimization. If no, we'd have to turn off security for IMA extends
> >=20
> > Another way of looking at it is that the performance for existing
> > TPMs is unacceptable with CONFIG_TCG_TPM2_HMAC configured at least
> > for the builtin "ima_policy=3Dtcb" policy, replaced with a similar
> > custom policy.=C2=A0 Without Jarkko's patch set it takes ~10 minutes to
> > boot.=C2=A0 With Jarkko's patch set it takes ~3 minutes.
>=20
> So that's the question: is 3 minutes acceptable?

There's no possible way of knowing how IMA is currently being used or wheth=
er
this performance degradation would be acceptable in all cases.

> >  Saying it will work with newer, faster TPMs isn't a viable solution
> > for distros.=C2=A0 Either the Kconfig is turned on or not for all syste=
ms.
> >=20
> > Is the reason for the performance degradation due to the HMAC or
> > encryption?
>=20
> It's the HMAC.  There's no security sensitive information in an extend
> so no reason to do encrypt/decrypt as well.

Agreed

>=20
> > =C2=A0 If the performance degradation is due to the HMAC, then the last
> > line should be:
> > "Saying Y here adds some overhead to all kernel to TPM transactions".
> >=20
> > config TCG_TPM2_HMAC
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool "Use HMAC and encrypted=
 transactions on the TPM bus"
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 default X86_64
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 select CRYPTO_ECDH
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 select CRYPTO_LIB_AESCFB
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 select CRYPTO_LIB_SHA256
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 help
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Setting this cau=
ses us to deploy a scheme which uses
> > request
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 and response HMA=
Cs in addition to encryption for
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 communicating wi=
th the TPM to prevent or detect bus
> > snooping
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 and interposer a=
ttacks (see tpm-security.rst).=C2=A0 Saying Y
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 here adds some e=
ncryption overhead to all kernel to TPM
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 transactions.
> >=20
> > I'm not quite sure what you mean by "If no, we'd have to turn off
> > security for IMA extends."=C2=A0 Are you leaving it enabled for all oth=
er
> > TPM communication,
>=20
> Since IMA is the only current user of tpm2_pcr_extend() that's an
> option, yes.  This would mean an interposer could intercept and either
> discard or modify an extend without being detected.

From an attestation perspective, assuming that the measurement list wasn't
compromised as well, discarding/modifying the extend would be detected by t=
he
attestation service.  Modifying a different PCR, however, could potentially=
 be a
problem.

>=20
> >  just disabling it for IMA or disabling it entirely based on whether
> > IMA is configured?
>=20
> Since tpm2_pcr_extend() is unused if IMA is disabled, we don't really
> need to condition on it, we could just remove the HMAC from extends.

Ok, so defining a new Kconfig is unnecessary.

Mimi

