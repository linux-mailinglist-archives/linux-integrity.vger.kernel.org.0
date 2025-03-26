Return-Path: <linux-integrity+bounces-5426-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 811A0A70EB4
	for <lists+linux-integrity@lfdr.de>; Wed, 26 Mar 2025 03:04:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BB57175E71
	for <lists+linux-integrity@lfdr.de>; Wed, 26 Mar 2025 02:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D70182B9CF;
	Wed, 26 Mar 2025 02:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RhphDWeC"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C0AA48;
	Wed, 26 Mar 2025 02:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742954646; cv=none; b=ZUqqLGrJwk0Hyw+yIgp3WJyB1pR5BusCGk4ZwtxhOxQkF7E31DHY9K5UPzUaFxLmzV2ymPt0dn8XTCeTOstKimV7fJGuLukwOsAwamPoRZb45DKcOzIVFXcmrNlKD2SmY6/KwMESbSjGKapUrpzZQ9K4t1yHUTDFcklLQ0z/Dqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742954646; c=relaxed/simple;
	bh=Uc6IKoLnecfwyf9b8ue4GuqAs2x7ftlDf54t7wJ9hls=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CF1fvKW2vbUO1OGQhIcXNx25pwYNgzmVBgw2sUcoHVt4srPZushiPlWsJQJdkIToCmCaOLFrAakvcGcUUCKip1RiRprVRcwfXEAC15oSWXo7rnjltpIJcafXs2Y+0JCQTIvfe+UBd8Fuinuzvfy2XDe61gU7F9UeYqHOxzjnE6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RhphDWeC; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52PNkpTp027805;
	Wed, 26 Mar 2025 01:58:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=UAynEl
	6cMkSvWcHYZiBfJ1uKyi+qwXrby/dv+it5z9w=; b=RhphDWeCpaXMNi4vJ+i4sH
	mLSnlW/dTgW6yr6i/AYHOhg+JlVyM1zqRyV0IHBOBtT05JhHfkwXMlkZsSuOotDb
	euSJ58KLfBlbAHpYGTgYD9vJgzb1UKnOghcG+4IN3Bn4XkcLzDovXVI15F1vR1O7
	R0fn3vWtE9Ob1rkfx3hFJwMQ+rLdGLwNvkXIB5A67dvivVXO56ZNHDPX5HfanNdd
	gYuWhT+9TsSkFFAXzHvUS3HOO1/V78QnlTK/tb/7HQaWP/pxCab0qELyz5hpv5Sy
	Vwb0WFsyTJYB2glOWfbcuj+e4GJ+1kyEkfo6twexGPv3f3/e5vT1zs9ocU+0zmgw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45kbjx05a3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Mar 2025 01:58:49 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52Q1w0Sg005839;
	Wed, 26 Mar 2025 01:58:49 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45kbjx059w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Mar 2025 01:58:49 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52Q03CGe030308;
	Wed, 26 Mar 2025 01:58:48 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 45j7htee87-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Mar 2025 01:58:48 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52Q1wmX627525650
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Mar 2025 01:58:48 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1308E58055;
	Wed, 26 Mar 2025 01:58:48 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7A9D258043;
	Wed, 26 Mar 2025 01:58:47 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.99.18])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 26 Mar 2025 01:58:47 +0000 (GMT)
Message-ID: <fa71ecce9f7a92099b335a9495e83da43123e489.camel@linux.ibm.com>
Subject: Re: [RFC PATCH v2 00/13] ima: get rid of hard dependency on SHA-1
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
Date: Tue, 25 Mar 2025 21:58:47 -0400
In-Reply-To: <20250323140911.226137-1-nstange@suse.de>
References: <20250323140911.226137-1-nstange@suse.de>
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
X-Proofpoint-GUID: xolENMekHrP3m2GqBexbEmu858s--Lwf
X-Proofpoint-ORIG-GUID: WBUpf0gZeQIMS71I2vmB64m0We5E1Az1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-25_10,2025-03-25_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 spamscore=0
 clxscore=1015 bulkscore=0 adultscore=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503260010

On Sun, 2025-03-23 at 15:08 +0100, Nicolai Stange wrote:
> Hi,
>=20
> this is v2 of the RFC series to disentangle IMA from its current
> dependency on a working SHA-1 implementation.
>=20
> For reference, v1 can be found at [1].
>=20
> Several options for when and how to invalidate unsupported TPM PCR banks
> by extending them with a unique constant had been discussed at the v1:
> a.) every single time a new entry gets added to the measurement list
> b.) or only once.
>=20
> b.) is appealing, because it enables recognizing unsupported banks right
> away from their value, but comes at a significant additional complexity.
> Fortunately, it turned out that it's possible to develop b.) incrementall=
y
> on top of a.), so this series can get truncated
> - after [5/13] ("ima: select CRYPTO_SHA256 from Kconfig") to get a.),
> - or after [9/13] ("ima: invalidate unsupported PCR banks only once")
>   to get a partial b.), invalidating unsupported banks only once for
>   each kernel booted, but redoing it for each kernel in a kexec chain,
> - or not at all to get the full b.), i.e. to skip reinvalidations even
>   from later kernels in the kexec chain if possible.
>=20
> I would personally go for the full set, because it also enables some
> perhaps helpful diagnostics for the kernel log, but OTOH I'm clearly
> biased now because I've implemented everthing. So it's your judgement
> call now on how to proceed. Either way, I would send the next iteration i=
n
> non-RFC mode with the full CC set. If you opted for a.) only, it would be
> a.) only, i.e. [1-5/13]. If you decided for b.), it might make sense to
> send in two batches to facilitate review: [1-9/13] first and the rest
> somewhen later.

Agreed.  Reviewing 1-9/13 is plenty.

To summarize/re-iterate:

- Don't rely on the "ima_hash" algorithm being the same for the kexec'ed ke=
rnel.
Create an "extra" bank for sha256, if the TPM is not configured for it.  We=
'll
be guaranteed at least one complete measurement list.

- Testing without SHA1 is difficult.  Maybe "select CRYPTO_SHA1" could be m=
ade
dependent on TPM 1.2 being enabled.

- From a testing perspective, it might be simpler to define a new Kconfig, =
but
I'm not sure it is really needed.  If SHA1 is configured as builtin, then
continue extending the unsupported TPM banks with SHA1.  Only if SHA1 isn't
configured, extend a single invalidate record (0xFE) per unsupported TPM ba=
nk.

- Should multiple PCRs be invalidated if the TPM bank hash algorithm was no=
t
configured as builtin?  Or just invalidate the CONFIG_IMA_MEASURE_PCR_IDX?

- The number of unsupported TPM banks doesn't change until the next kexec. =
 No
need to keep re-calculating the number of TPM banks to extend.

Mimi

>=20
> FWIW, I did some testing now, on the full series in a VM with a swtpm
> attached to it:
> - both with and without CONFIG_TCG_TPM2_HMAC (for [10/13] ("tpm:
>   authenticate tpm2_pcr_read()" coverage) and
> - with a focus on verifying everything related to the new invalidation
>   logic is working as intended.
>=20
> Thanks a lot!
>=20
> Nicolai
>=20
>=20
>=20
> Changes to v1:
> - [v1 1/7] ("ima: don't expose runtime_measurements for unsupported
>   hashes"): no change.
> - [v1 2/7] ("ima: always create runtime_measurements sysfs file for
>   ima_hash"): no change.
> - [v1 3/7] ("ima: move INVALID_PCR() to ima.h"): moved to [v2 6/13],
>   otherwise no change.
> - [v1 4/7] ("ima: track the set of PCRs ever extended"):
>   moved to [v2 8/13], drop code restoring ima_extended_pcrs_mask at kexec=
,
>   update it from ima_pcr_extend() only if the tpm_pcr_extend() was
>   successful.
> - [v1 5/7] ("tpm: enable bank selection for PCR extend"): moved to
>   [v2 7/13], fix a bug by actually passing the skip mask from
>   tpm_pcr_extend() to tpm2_pcr_extend().
> - [v1 6/7] ("ima: invalidate unsupported PCR banks once at first use"):
>   gone, superseded by the new
>     [v2 3/13]  ("invalidate unsupported PCR banks")
>     [v2 9/13]  ("ima: invalidate unsupported PCR banks only once")
>     [v2 13/13] ("ima: don't re-invalidate unsupported PCR banks after
>               kexec")
> - [v1 7/7] ("ima: make SHA1 non-mandatory"): moved to [v2 4/13],
>   diff context updates due to ima_unsupported_tpm_banks_mask not
>   existing yet at this point in the series.
>=20
> - [v2 5/13] ("ima: select CRYPTO_SHA256 from Kconfig"): new to
>   (hopefully) address feedback at [2].
> - [v2 10/13] ("tpm: authenticate tpm2_pcr_read()"): new, prerequisite
>   for the next in a sense.
> - [v2 11/13] ("ima: introduce ima_pcr_invalidated_banks() helper"): new,
>   prerequisite for [13/13].
> - [v2 12/13] ("ma: make ima_free_tfm()'s linkage extern"): new,
>   likewise a prerequisite for [13/13].
>=20
>=20
> [1] https://lore.kernel.org/r/20250313173339.3815589-1-nstange@suse.de
> [2] https://lore.kernel.org/r/4e760360258bda56fbcb8f67e865a7a4574c305a.ca=
mel@linux.ibm.com
>=20
>=20
> Nicolai Stange (13):
>   ima: don't expose runtime_measurements for unsupported hashes
>   ima: always create runtime_measurements sysfs file for ima_hash
>   ima: invalidate unsupported PCR banks
>   ima: make SHA1 non-mandatory
>   ima: select CRYPTO_SHA256 from Kconfig
>   ima: move INVALID_PCR() to ima.h
>   tpm: enable bank selection for PCR extend
>   ima: track the set of PCRs ever extended
>   ima: invalidate unsupported PCR banks only once
>   tpm: authenticate tpm2_pcr_read()
>   ima: introduce ima_pcr_invalidated_banks() helper
>   ima: make ima_free_tfm()'s linkage extern
>   ima: don't re-invalidate unsupported PCR banks after kexec
>=20
>  drivers/char/tpm/tpm-interface.c      |  29 +++-
>  drivers/char/tpm/tpm.h                |   3 +-
>  drivers/char/tpm/tpm2-cmd.c           |  75 ++++++++-
>  include/linux/tpm.h                   |   3 +
>  security/integrity/ima/Kconfig        |  15 ++
>  security/integrity/ima/ima.h          |  12 ++
>  security/integrity/ima/ima_crypto.c   | 216 ++++++++++++++++++++++----
>  security/integrity/ima/ima_fs.c       |  41 +++--
>  security/integrity/ima/ima_policy.c   |   5 +-
>  security/integrity/ima/ima_queue.c    |  54 ++++++-
>  security/integrity/ima/ima_template.c |  84 +++++++++-
>  11 files changed, 471 insertions(+), 66 deletions(-)
>=20


