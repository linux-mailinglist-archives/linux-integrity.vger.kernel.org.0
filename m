Return-Path: <linux-integrity+bounces-3722-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DD6798C520
	for <lists+linux-integrity@lfdr.de>; Tue,  1 Oct 2024 20:10:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60A10B244CC
	for <lists+linux-integrity@lfdr.de>; Tue,  1 Oct 2024 18:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 414DF1CC882;
	Tue,  1 Oct 2024 18:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="X1VQXYdk"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F071CC16D;
	Tue,  1 Oct 2024 18:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727806229; cv=none; b=li5m9bmJUqMU3R2dikz1f3iJglcwK5Q0YPI1UiN47+U9MgV4s8BwiMrjoNfEqVhNGZ0dWyyGUPPtgQGIkNrxHAeES9jASKYshLsYNQB/Sy+FSamuoyPrpvVO4DVOaB8yNeLKVzI8O+VTM6xrLgPKVBWYoakw+1vBf6vO5InixQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727806229; c=relaxed/simple;
	bh=HL2E3QMrC4FldlfCN6NH6Ig5eHF5SQWPoluFh8RdjgQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VQ+uRfq3FepktSqJZw6cpvzsB1m8RM+GFc/ds37i9CTjyrPf3U/+0h78EEwZHsIOM9t/r3gwumygHlb+DuhI1MJo9pSWDbOycsL0kTJs97luWdvZ1UDJBBHTNR9lA+FscWSA7sleS9YlfMVraAU+m8Xn+zA9edw//3P5HgLSTS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=X1VQXYdk; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 491Howx7001081;
	Tue, 1 Oct 2024 18:10:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:content-transfer-encoding:mime-version; s=pp1; bh=
	4iPy/miIDfWox6jCNp/OmEeJAi43UdG2oJnaBzafbRE=; b=X1VQXYdkWdSj385l
	X+mngF02odJ/uH+xasipOCRbuCBjwwQZ7E3s1oMC9NiSGXrxwvJb4CIN+3aRsW6c
	FNKtD3rERbztKIchungvGp7hnVCgfZSNU8nox2z4qbv//MADwkIi/LrxBM+qr6Pu
	zJJfC90OFj1gUQCx5SeOyBVv2qifGDM/DqS/GtjDsUrABJOWGGdKNWqbhOQd6RlP
	ZzYIXhLBqx9ofgEFlp0Z1JEJn2MlyomI1skdIuTuUBIpuswhAX/IlqDy9zyewz6R
	tMliPC64y63R8aVNswQgZyFI97cGxMQqUx9RXNOnI1puiYQUZ2OpjC4EtUnE8oFT
	6GThBw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 420nu102nt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Oct 2024 18:10:06 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 491IA5Rc010808;
	Tue, 1 Oct 2024 18:10:05 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 420nu102nm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Oct 2024 18:10:05 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 491I4s1o008026;
	Tue, 1 Oct 2024 18:10:04 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41xvgxx3ma-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Oct 2024 18:10:04 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 491IA41F28967550
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 1 Oct 2024 18:10:04 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5F99058056;
	Tue,  1 Oct 2024 18:10:04 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 173F758045;
	Tue,  1 Oct 2024 18:10:03 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.187.29])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  1 Oct 2024 18:10:02 +0000 (GMT)
Message-ID: <3fed38bc5c9de9e1a16fd5c1413ba8a965d26dac.camel@linux.ibm.com>
Subject: Re: [PATCH v5 0/5] Lazy flush for the auth session
From: Mimi Zohar <zohar@linux.ibm.com>
To: Jarkko Sakkinen <jarkko@kernel.org>, linux-integrity@vger.kernel.org
Cc: James.Bottomley@HansenPartnership.com, roberto.sassu@huawei.com,
        mapengyu@gmail.com, David Howells <dhowells@redhat.com>,
        Paul Moore
 <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn"
 <serge@hallyn.com>, Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe
 <jgg@ziepe.ca>, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 01 Oct 2024 14:10:02 -0400
In-Reply-To: <D4D05FKB9VSG.33COYTJHUX6EM@kernel.org>
References: <20240921120811.1264985-1-jarkko@kernel.org>
	 <D4D05FKB9VSG.33COYTJHUX6EM@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: IJLTXFMuREwjxEudd-VPtXiTR7PBTX-5
X-Proofpoint-ORIG-GUID: DOAhx2zVjTwcOAWOiSc8KR0E8tYZqdMf
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-01_13,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 adultscore=0 spamscore=0 impostorscore=0 suspectscore=0 mlxscore=0
 malwarescore=0 priorityscore=1501 clxscore=1011 lowpriorityscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2410010116

On Sun, 2024-09-22 at 20:51 +0300, Jarkko Sakkinen wrote:
> On Sat Sep 21, 2024 at 3:08 PM EEST, Jarkko Sakkinen wrote:
> > This patch set aims to fix:
> > https://bugzilla.kernel.org/show_bug.cgi?id=3D219229.
> >=20
> > The baseline for the series is the v6.11 tag.
> >=20
> > v4:
> > https://lore.kernel.org/linux-integrity/20240918203559.192605-1-jarkko@=
kernel.org/
> > v3:
> > https://lore.kernel.org/linux-integrity/20240917154444.702370-1-jarkko@=
kernel.org/
> > v2:
> > https://lore.kernel.org/linux-integrity/20240916110714.1396407-1-jarkko=
@kernel.org/
> > v1:
> > https://lore.kernel.org/linux-integrity/20240915180448.2030115-1-jarkko=
@kernel.org/
> >=20
> > Jarkko Sakkinen (5):
> >   tpm: Return on tpm2_create_null_primary() failure
> >   tpm: Implement tpm2_load_null() rollback
> >   tpm: flush the null key only when /dev/tpm0 is accessed
> >   tpm: Allocate chip->auth in tpm2_start_auth_session()
> >   tpm: flush the auth session only when /dev/tpm0 is open
> >=20
> >  drivers/char/tpm/tpm-chip.c       |  14 ++++
> >  drivers/char/tpm/tpm-dev-common.c |   8 +++
> >  drivers/char/tpm/tpm-interface.c  |  10 ++-
> >  drivers/char/tpm/tpm2-cmd.c       |   3 +
> >  drivers/char/tpm/tpm2-sessions.c  | 109 ++++++++++++++++++------------
> >  include/linux/tpm.h               |   2 +
> >  6 files changed, 102 insertions(+), 44 deletions(-)
>=20
>=20
> Roberto, James, speaking of digest cache. This patch set has no aim to
> fix those issues but I do believe that it should improve also that=20
> feature.
>=20
> If I don't get soon patch reviews for the patch set, I'll pick the 2nd
> best option: disable bus encryption on all architectures including x86
> and ARM64 (being by default on).
>=20
> It's a force majeure situation. I know this would sort out the issue
> but I really cannot send these as a pull request with zero reviewe-by's.
>=20
> I expect this to be closed by tomorrow.

Jarkko, sorry to be so late to this discussion.  The bus HMAC/encryption re=
ally
impacts IMA as well.  Even with this patch set, it's slow.  My preference w=
ould
be to disable bus encryption on all architectures until there is a boot/run=
time
option allowing it to be disabled for IMA as discussed in the other thread.

In the other thread, I also mentioned that the Kconfig is incorrectly worde=
d.=20
The performance degradation is not limited to encryption, but the HMAC itse=
lf.=20
Please change "Saying Y here adds some encryption overhead to all kernel to=
 TPM
transactions." to "Saying Y here adds overhead to all kernel to TPM
transactions."

thanks,

Mimi

