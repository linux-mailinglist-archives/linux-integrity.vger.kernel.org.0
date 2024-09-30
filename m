Return-Path: <linux-integrity+bounces-3718-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73D2A98AC66
	for <lists+linux-integrity@lfdr.de>; Mon, 30 Sep 2024 20:52:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE06EB20D85
	for <lists+linux-integrity@lfdr.de>; Mon, 30 Sep 2024 18:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 241B0192D7F;
	Mon, 30 Sep 2024 18:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Cl0mFaWc"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4199F5466B
	for <linux-integrity@vger.kernel.org>; Mon, 30 Sep 2024 18:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727722340; cv=none; b=eEK3xJGIb2Ia2YBcn4Mmr8mr6fgW7rX+i5iJpo991l6Wo+136v1IGA02RmEJdbIGDdDYiOqnrzNbuijjPt7P3LG3tVL8aL75yRtwZ9SiNbBNRp3vGAvp6SwDTDEvER7Sm3uzKt9rknjnH7uVTuen0GBljB7ofEvGlWmoAT+86eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727722340; c=relaxed/simple;
	bh=axcf5xUJ7DogSWnIpT/NlSusOFGFxRVFHCZY/kQc2qk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kZkJiEdpqafjecPvy+GyN7JEImot382lvu1NxgZxw1UHAXzvjG2tIUw2HA/w5zFmuqYd+9OcAWM5QDdSvmYUCJXtvk8Lz9ThAZ+CWJglFndtquPWW5mv4fz6CMaca71M//OHFQ7t4YBc4+QRqdBYNoWbFOLDrwS+1mBfAPhS80k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Cl0mFaWc; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48UITUdA014101;
	Mon, 30 Sep 2024 18:52:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:content-transfer-encoding:mime-version; s=pp1; bh=
	g7bja3P6vUlCx23FPZIBpYi7z1jFmD0VBmZLP4YH1Jo=; b=Cl0mFaWcQv6lqePu
	4VQaZn2WTkf5IktcCnG1Ccchj/LbHqKkylv6GaGZATq+nmAHsX87DqYNfinK9o97
	jL6wB0Eq5dz4+xNWUcFdRaJAvlsynjTo0Qw88308K0TT9KLzFR8vZ2USEI+VPofy
	FsQ+LCsaWAcZPAGd0Bj9OtvammiNSBE0zq4r9auvvOGe95YpqG4EhhZpXngKtvMj
	Dlpr9vzdngY1msaNgjg7uz20AnaK0bdlp19MjlzgYO04I5p75jr7PkcInE/MGmpZ
	ThX/o7NCp/Fphhlkk9WdIbdF5b0/t/9Tc7yTL2tjEopNZEWbbcT+JIrLvCcvalnF
	U32g4g==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41x9apbq2p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Sep 2024 18:52:03 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48UHcgEI017852;
	Mon, 30 Sep 2024 18:52:02 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41xw4mr6tv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Sep 2024 18:52:02 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 48UIq2v446006690
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Sep 2024 18:52:02 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 154095805D;
	Mon, 30 Sep 2024 18:52:02 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C1E7E58058;
	Mon, 30 Sep 2024 18:52:01 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.watson.ibm.com (unknown [9.31.102.161])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 30 Sep 2024 18:52:01 +0000 (GMT)
Message-ID: <58f1e3fb98d55114cf69b98d0861b57ba2154578.camel@linux.ibm.com>
Subject: Re: TPM HMAC (really) bad performance
From: Mimi Zohar <zohar@linux.ibm.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>,
        Roberto Sassu
	 <roberto.sassu@huaweicloud.com>,
        Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-integrity@vger.kernel.org
Date: Mon, 30 Sep 2024 14:52:01 -0400
In-Reply-To: <dd0f55e179ae6aaa1c99c320facc1bb33ccb25c8.camel@linux.ibm.com>
References: <b8a7b3566e6014ba102ab98e10ede0d574d8930e.camel@huaweicloud.com>
	 <d66af0d491f7576c7d865bf6de4da4c83cf0c3ba.camel@huaweicloud.com>
	 <7025be516c4de1cbd8958c80242f503cc6e92c4a.camel@HansenPartnership.com>
	 <dd0f55e179ae6aaa1c99c320facc1bb33ccb25c8.camel@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: noxJnY_aEtpnUXUzG3-yhl6uRIPLYIpa
X-Proofpoint-GUID: noxJnY_aEtpnUXUzG3-yhl6uRIPLYIpa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-09-30_18,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 lowpriorityscore=0 mlxlogscore=901 malwarescore=0 priorityscore=1501
 phishscore=0 mlxscore=0 suspectscore=0 adultscore=0 clxscore=1015
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409300134

On Mon, 2024-09-30 at 10:09 -0400, Mimi Zohar wrote:
> On Fri, 2024-09-27 at 10:15 -0400, James Bottomley wrote:
> > On Fri, 2024-09-27 at 15:53 +0200, Roberto Sassu wrote:
> > > On Fri, 2024-09-06 at 14:32 +0200, Roberto Sassu wrote:
> > > > Hi all
> > > >=20
> > > > when running the benchmark on my new component, the Integrity
> > > > Digest
> > > > Cache, I ran into a serious performance issue.
> > > >=20
> > > > The benchmark is extending a TPM PCR with 12313 entries of the IMA
> > > > measurement list, and calculating the time elapsed for the
> > > > operation.
> > > >=20
> > > > Without TPM HMAC: 102.8 seconds
> > > >=20
> > > > With TPM HMAC: 1941.71 seconds
> > >=20
> > > Jarkko patch set [1] improved the performance:
> > >=20
> > > 404.4 seconds
> > >=20
> > >=20
> > > Still quite slow.
> >=20
> > So this is now the internal TPM overhead.  There's not much we can do
> > in the kernel to optimize that.  Your own figures were
> >=20
> > > No HMAC:
> > >=20
> > > # tracer: function_graph
> > > #
> > > # CPU  DURATION                  FUNCTION CALLS
> > > # |     |   |                     |   |   |   |
> > >  0)               |  tpm2_pcr_extend() {
> > >  0)   1.112 us    |    tpm_buf_append_hmac_session();
> > >  0) # 6360.029 us |    tpm_transmit_cmd();
> > >  0) # 6415.012 us |  }
> > >=20
> > >=20
> > > HMAC:
> > >=20
> > > # tracer: function_graph
> > > #
> > > # CPU  DURATION                  FUNCTION CALLS
> > > # |     |   |                     |   |   |   |
> > >  1)               |  tpm2_pcr_extend() {
> > >  1)               |    tpm2_start_auth_session() {
> > >  1) * 36976.99 us |      tpm_transmit_cmd();
> > >  1) * 84746.51 us |      tpm_transmit_cmd();
> > >  1) # 3195.083 us |      tpm_transmit_cmd();
> > >  1) @ 126795.1 us |    }
> > >  1)   2.254 us    |    tpm_buf_append_hmac_session();
> > >  1)   3.546 us    |    tpm_buf_fill_hmac_session();
> > >  1) * 24356.46 us |    tpm_transmit_cmd();
> > >  1)   3.496 us    |    tpm_buf_check_hmac_response();
> > >  1) @ 151171.0 us |  }
> >=20
> > or 6ms for no session extend vs 24ms for with session extend, so
> > effectively 4x slower, which is exactly what the above figures are also
> > showing.
> >=20
> > >  We should consider not only the boot performance.
> > > Depending on the use case, IMA can be used after boot and slow down
> > > applications performance.
> >=20
> > Right, but this is IMA fish or cut bait time: are you willing to pay a
> > 4x penalty for improved security, bearing in mind that not all TPMs
> > will show the 4x slow down, since some have much better optimized
> > crypto routines.  If yes, we can simply keep the no flush optimization.
> > If no, we'd have to turn off security for IMA extends
>=20
> Another way of looking at it is that the performance for existing TPMs is
> unacceptable with CONFIG_TCG_TPM2_HMAC configured at least for the builti=
n
> "ima_policy=3Dtcb" policy, replaced with a similar custom policy.  Withou=
t
> Jarkko's patch set it takes ~10 minutes to boot.  With Jarkko's patch set=
 it
> takes ~3 minutes. Saying it will work with newer, faster TPMs isn't a via=
ble
> solution for distros.  Either the Kconfig is turned on or not for all sys=
tems.

FYI without CONFIG_TCG_TPM2_HMAC configured, with the the same "ima_policy=
=3Dtcb"
builtin policy and custom policy it takes 49 seconds to boot.

>=20
> Is the reason for the performance degradation due to the HMAC or encrypti=
on?  If
> the performance degradation is due to the HMAC, then the last line should=
 be:
> "Saying Y here adds some overhead to all kernel to TPM transactions".
>=20
> config TCG_TPM2_HMAC
>         bool "Use HMAC and encrypted transactions on the TPM bus"
>         default X86_64
>         select CRYPTO_ECDH
>         select CRYPTO_LIB_AESCFB
>         select CRYPTO_LIB_SHA256
>         help
>           Setting this causes us to deploy a scheme which uses request
>           and response HMACs in addition to encryption for
>           communicating with the TPM to prevent or detect bus snooping
>           and interposer attacks (see tpm-security.rst).  Saying Y
>           here adds some encryption overhead to all kernel to TPM
>           transactions.
>=20
> I'm not quite sure what you mean by "If no, we'd have to turn off securit=
y for
> IMA extends."  Are you leaving it enabled for all other TPM communication=
, just
> disabling it for IMA or disabling it entirely based on whether IMA is
> configured?
>=20
> Mimi


