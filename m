Return-Path: <linux-integrity+bounces-5414-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 960E0A6E7D5
	for <lists+linux-integrity@lfdr.de>; Tue, 25 Mar 2025 02:04:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60B8A170031
	for <lists+linux-integrity@lfdr.de>; Tue, 25 Mar 2025 01:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22E20CA6B;
	Tue, 25 Mar 2025 01:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="W6nHcAPS"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825E311712;
	Tue, 25 Mar 2025 01:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742864660; cv=none; b=hBjFfkP9NqUOHP+kp2mPbIZY8Ey8KrjA5fTCZHqXkpaGEk7neqYmKF+WV1d/278Q9Ad4U5t4DaU5vxhenukjbpDna1jHT/CK1151qXk5i3NwuqNc5lMdh7ZtifyX6BtlM8ZE8mpzTNLcmWInjXqRyQ3RMl+Q4W+on6ojqjxPfCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742864660; c=relaxed/simple;
	bh=aHjMPBfWpy498Yd9hfP3xTQ6B1tKP7dKUerGBCkDEy4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XI2595Cu1JYRg5vj2AmiUFrT2rGKraGJKzgGVB72eqsBTRlD58NGA1vY98RGuToHcrOYTFv7FinP6KXYNy3jz9tJENqe+wMzeu6jDirQ0BDwU4TY7i5xKJzvsPLra1VWuL8sDe3ORr5TDgz2NYvnxN5GouQYcCyKQaX8ssIjOAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=W6nHcAPS; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52OLPCTR027979;
	Tue, 25 Mar 2025 01:03:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=SVkkiy
	pbdvsWYQ6AXdGiEwqDmcgkYftcfbss9MKI3Bc=; b=W6nHcAPS44gEhT4JaLVEbf
	qECwqyw7AUtTXhmTfQU0Rsx2lCYdVUM47BtjDVIKwDozxlrDNB+3yhVtF1lycVwn
	pVpBUTWPH41VsnBF+xkBKLgPoJdjtoGb9r3Bn/doQQ8UrR09R7OWx2VH1T1ET14T
	3lXFFd6UnOas1f5cavXeNLxkDrAdj3rBBP4Yr8QePdWxhbb+Cj2nLzdB645sFDx9
	qkyPlkYTkF3OY33uwfOG7SAvA5OjvvScRf5vULhvjMpEW3bFNL/ykaERPwVAp6U6
	iPPmaP4X3HZlNievJFPNcxwqdLy6GPB/4ugvGeMIIRBt3nDhUeBaN65q1j2T6UbA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45k7e3bec0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Mar 2025 01:03:55 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52P13Hs3004932;
	Tue, 25 Mar 2025 01:03:54 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45k7e3bebx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Mar 2025 01:03:54 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52ONOrMQ025463;
	Tue, 25 Mar 2025 01:03:53 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45j7x012sc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Mar 2025 01:03:53 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52P13qRe22938008
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Mar 2025 01:03:53 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C9FB158051;
	Tue, 25 Mar 2025 01:03:52 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1C17D5805C;
	Tue, 25 Mar 2025 01:03:52 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.190.127])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 25 Mar 2025 01:03:51 +0000 (GMT)
Message-ID: <f7d257cd3f98447b2b3d7aff1eee6586c1596606.camel@linux.ibm.com>
Subject: Re: [RFC PATCH v2 03/13] ima: invalidate unsupported PCR banks
From: Mimi Zohar <zohar@linux.ibm.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>,
        Nicolai Stange
 <nstange@suse.de>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Dmitry
 Kasatkin <dmitry.kasatkin@gmail.com>
Cc: Eric Snowberg <eric.snowberg@oracle.com>,
        Jarkko Sakkinen
	 <jarkko@kernel.org>, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 24 Mar 2025 21:03:51 -0400
In-Reply-To: <5b15393c8046cf87cc09e932e6addf20d9b1d871.camel@HansenPartnership.com>
References: <20250323140911.226137-1-nstange@suse.de>
	 <20250323140911.226137-4-nstange@suse.de>
	 <5b15393c8046cf87cc09e932e6addf20d9b1d871.camel@HansenPartnership.com>
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
X-Proofpoint-ORIG-GUID: vEcYtFgUjpoEJ7_qg5-3XkC-ReL6ZXWy
X-Proofpoint-GUID: sFzrUdUcl8vmTCD7WNMJBYfmlThdYem8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-24_07,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 mlxscore=0 suspectscore=0 phishscore=0 adultscore=0 impostorscore=0
 mlxlogscore=999 lowpriorityscore=0 priorityscore=1501 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503250001

On Sun, 2025-03-23 at 17:18 -0400, James Bottomley wrote:
> On Sun, 2025-03-23 at 15:09 +0100, Nicolai Stange wrote:
> > Normally IMA would extend a template hash of each bank's associated
> > algorithm into a PCR. However, if a bank's hash algorithm is
> > unavailable to the kernel at IMA init time, it would fallback to
> > extending padded SHA1 hashes instead.
> >=20
> > That is, if e.g. SHA-256 was missing at IMA init, it would extend
> > padded SHA1 template hashes into a PCR's SHA-256 bank.
> >=20
> > The ima_measurement command (marked as experimental) from ima-evm-
> > utils would accordingly try both variants when attempting to verify a
> > measurement list against PCRs. keylime OTOH doesn't seem to -- it
> > expects the template hash type to match the PCR bank algorithm. I
> > would argue that for the latter case, the fallback scheme could
> > potentially cause hard to debug verification failures.
> >=20
> > There's another problem with the fallback scheme: right now, SHA-1
> > availability is a hard requirement for IMA, and it would be good for
> > a number of reasons to get rid of that. However, if SHA-1 is not
> > available to the kernel, it can hardly provide padded SHA-1 template
> > hashes for PCR banks with unsupported algos.
>=20
> I think this was done against the day IMA only supported sha1 and the
> TPM sha256 and beyond so there'd at least be a record that could be
> replayed.  I think today with most distros defaulting IMAs hash to
> sha256 that's much less of a problem.

Commit 1ea973df6e21 ("ima: Calculate and extend PCR with digests in
ima_template_entry") added the support for extending multiple banks.  It
included the support for extending padded SHA1 digests for unknown TPM bank=
 hash
algorithms.  Clearly it wasn't addressing the case of a TPM sha256 bank.

>=20
> > There are several more or less reasonable alternatives possible,
> > among them are:
> > a.) Instead of padded SHA-1, use padded/truncated ima_hash template
> > =C2=A0=C2=A0=C2=A0 hashes.
> > b.) Don't extend unsupported banks at all.
> > c.) Record every event as a violation, i.e. extend unsupported banks
> > =C2=A0=C2=A0=C2=A0 with 0xffs.
> > d.) Invalidate unsupported banks at least once by extending with a
> > unique
> > =C2=A0=C2=A0=C2=A0 constant (e.g. with 0xfes).
>=20
> Instead of any of that, why not do what the TCG tells us to do for
> unsupported banks and simply cap them with 0xffffffff record
> EV_SEPARATOR and stop extending to them? (note this would probably
> require defining a separator event for IMA)

open-writers and ToMToU integrity violations are added to the IMA measureme=
nt
list as 0x00's, but are extended into the TPM using 0xFF's.  Unfortunately,=
 as
mentioned previously, some verifiers ignore these integrity violations by
automatically replacing the 0x00's with 0xFF's.

What do you mean by "simply cap" them?  Does it automatically prevent the P=
CR
from being extended?  If not, then this patch set is doing exactly that -
preventing the TPM bank from additional extends.

Mimi

