Return-Path: <linux-integrity+bounces-5142-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80DA8A55708
	for <lists+linux-integrity@lfdr.de>; Thu,  6 Mar 2025 20:43:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EF43177677
	for <lists+linux-integrity@lfdr.de>; Thu,  6 Mar 2025 19:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 798F526F479;
	Thu,  6 Mar 2025 19:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Uvvglu2Y"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA69D1A83EE
	for <linux-integrity@vger.kernel.org>; Thu,  6 Mar 2025 19:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741290203; cv=none; b=AxCm267/HpoOjvw1u3wtmETwLr6MlzuPhybskGDb4y2Jirh6WgNAHb6A4RbT6HJeId5Xkw1aCA5Gba6iUWwEXKMgtZPNBw7GrKdsuxUfJe8sVgWT3pDlnr8CiDFcWacFunjiti+FiO+uLZlS04nLME9YUP26iCRj0GPHaVG2swA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741290203; c=relaxed/simple;
	bh=QBX2a4TIM6JoaAGBPDCNfKElLiQnQQhdrGHDuSoOsQA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=P5kmsZMx4KWLDOk7vHh0u9UoyenMdCXhO2h714WJaZJTTSMv1AgnrY2WcYRLMjW6hK7nDFyUKmSjFJ6hKQxy2VxNEcv1hsZGMwE8eL2rOo4RRqljJZp6mDAN8rp/8I15pA6VsEdyfUtV/Es4wP+yNrS7k+MhYIbZXBj45/tL0vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Uvvglu2Y; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 526E3PaH019615;
	Thu, 6 Mar 2025 19:43:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=A1T94T
	BKIUcyMMqijletLeHQp7MKLadoBgO1lW4DHk0=; b=Uvvglu2Y/B/pOgvOozxZKS
	GyFKF02s+YZn6z7ca/tsl+leu+u9ekOXyrK/dCDCw8i/vrqGbOmtqbhYQCa7ZMtt
	bOehLCh+V+YpoyRPS1gSmxwcKW+QpHvAC1zWvmMy0w+dnWDxCSzzegKO/el45qOk
	tZo0TQoD8bnyWGpYh0iLyqGejMPU7qC+fFWsZYTns66LZjHAg1IfE6FqiBuyCH8i
	W0Qp4rFNXlLGwHNGJXLEY94oPFAZQHB0p6yEnbuBcc4aD/rnTYOJhrYfyspC7z9r
	ULzPpIeRz+KF7hc08EGfdzu6iRESeNrU69iixe52ktqFXZnbtpS1qG/unLzRDhdA
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 457d4p1tw5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Mar 2025 19:43:15 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 526JY3Hv013743;
	Thu, 6 Mar 2025 19:43:14 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 454e2m2jk5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Mar 2025 19:43:14 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 526JhC3c25690670
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 6 Mar 2025 19:43:12 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B340B58068;
	Thu,  6 Mar 2025 19:43:13 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 75EE258067;
	Thu,  6 Mar 2025 19:43:13 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.31.103.152])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  6 Mar 2025 19:43:13 +0000 (GMT)
Message-ID: <d3de8fcbf9570e913592b6c8a00f52423f221952.camel@linux.ibm.com>
Subject: Re: Unbalanced TPM2 HMAC session calls
From: Mimi Zohar <zohar@linux.ibm.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>,
        Jonathan
 McDowell <noodles@earth.li>,
        Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-integrity@vger.kernel.org
Date: Thu, 06 Mar 2025 14:43:13 -0500
In-Reply-To: <1e1f60fae0fa86a4f3c16106836f63cf1709ab5e.camel@HansenPartnership.com>
References: <Z8m8G0RfiRyYGH_t@earth.li>
	 <f16aae4408cc7bdd98fa70972b70747c26958dd1.camel@linux.ibm.com>
	 <1e1f60fae0fa86a4f3c16106836f63cf1709ab5e.camel@HansenPartnership.com>
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
X-Proofpoint-GUID: y8oh-R76GTcYfq-nh2d4HCQPz9BdwrvD
X-Proofpoint-ORIG-GUID: y8oh-R76GTcYfq-nh2d4HCQPz9BdwrvD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-06_06,2025-03-06_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 suspectscore=0 clxscore=1015 phishscore=0 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 mlxlogscore=953 adultscore=0 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503060148

On Thu, 2025-03-06 at 11:30 -0800, James Bottomley wrote:
> On Thu, 2025-03-06 at 13:59 -0500, Mimi Zohar wrote:
> > On Thu, 2025-03-06 at 15:15 +0000, Jonathan McDowell wrote:
> > > We're seeing a lot of:
> > >=20
> > > tpm tpm0: auth session is active
> > >=20
> > > messages in our logs. This is emitted (once per boot) by=20
> > > tpm2_start_auth_session() if the auth sessions is already active
> > > when it is called.
> > >=20
> > > Investigating I think this is because tpm2_pcr_extend() calls=20
> > > tpm_buf_append_hmac_session() which sets TPM2_SA_CONTINUE_SESSION
> > > so tpm_buf_check_hmac_response() does not cleanup the auth session,
> > > but then doesn't call tpm2_end_auth_session().
> > >=20
> > > Looking at tpm2_get_random() it uses TPM2_SA_CONTINUE_SESSION but
> > > *also* cleans up with tpm2_end_auth_session().
> > >=20
> > > I'd be sending a patch proposing the addition of
> > > tpm2_end_auth_session() to the end of tpm2_pcr_extend() but I
> > > recall a bunch of discussion about trying to cache the HMAC session
> > > to improve IMA performance, so I don't know if perhaps we should be
> > > dropping the warning instead?
> >=20
> > Hi Jonathan,
> >=20
> > That suggestion was nixed.=C2=A0
>=20
> Well it's also upstream as
>=20
> https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/co=
mmit/?id=3Ddf745e25098dcb2f706399c0d06dd8d1bab6b6ec
>=20
> even though it didn't work out for large numbers of extends.

Oh, right!  That patch definitely helped with performance, just not enough.=
=20
Without that patch, some of my test systems wouldn't boot.

Mimi

> However,
> that commit introduced this message on a warn once behaviour, so it
> seems to be expected that this gets printed once for some reason.  From
> a code flow point of view, the lazy session handling seems to be
> working correctly, so I think just dropping the warn is correct.
>=20
> Regards,
>=20
> James
>=20


