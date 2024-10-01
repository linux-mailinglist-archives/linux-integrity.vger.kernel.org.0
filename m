Return-Path: <linux-integrity+bounces-3721-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9986D98BD3A
	for <lists+linux-integrity@lfdr.de>; Tue,  1 Oct 2024 15:17:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49A7E1F2329F
	for <lists+linux-integrity@lfdr.de>; Tue,  1 Oct 2024 13:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C89401C57B0;
	Tue,  1 Oct 2024 13:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GKSPeadb"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA201C5791
	for <linux-integrity@vger.kernel.org>; Tue,  1 Oct 2024 13:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727788564; cv=none; b=cPiHo7MGED+l8tt6jWAf5YrkPIRIh2kdWCvZVdVR1Uq3dyR0GJyZxckqaAEarwnEXkeEqQYEvH8DQtZO1Aq9r6uVMaBRtQcYZJK0M4OCQJc3l4kU5YhDWT6ZWRoHgW2xFu0jcOURTyvmWf+0n7ZGq90TNqxFt5iGjCcW9ObXbcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727788564; c=relaxed/simple;
	bh=Hw2VLE7Wv2Ofi14LJ8hBqQjcy7IAahVfgap/kqRUt5E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AffjUtArtG6iAP3NJsVd9YZmtHQ6zPK7t8o//g3YHv9y2MHUUj01gIROkvd1X+eyQOZDbz3CxC2RCJcMrvHRZffR6Z80rPLzKNgXV2RfTmMP8hbdtyxGjJDkFx1sdr0PqTDWi1+ExVwq8IlQWGWkfiRqzWAvX5H2IpAM0+kHevI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GKSPeadb; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4917K2ie021430;
	Tue, 1 Oct 2024 13:10:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:content-transfer-encoding:mime-version; s=pp1; bh=
	xfpSs3/9kdPKjfmzrP5z9RFpR2zPs7EHy+KB+T2ubDQ=; b=GKSPeadbv2PnBfGW
	L/svx7xeOqvC6jHvLCiMBkAKB5jl0pcY9jK7fX8cpN8laxQFSdKTZG7WcqwVCBzr
	OtTAyBA5r6nXV6omwaGvXDD7+1tKl23KTa9Ja4l6ntx0DL1PqP6vAb6hXrUzHOcW
	SDO+451eDETmriaxwBGpZs4YsO9x7fhd6i/+zbW+qCmwbyg6B7BzWW0qduASXql5
	TkuiCKH6Zhy5z3jhmMZv3XFUlLf7f2rj0e1xjC6d2X13za4SUN4pJLPUWeJt7L4C
	at8csaaeXwG1XilJOOKnzYj0cLJCTcsVa1wpM33TkeKb/XyZHWuAxzRPl0xHab4M
	tQiLhQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 420cknhtf1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Oct 2024 13:10:48 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 491CvFsC014157;
	Tue, 1 Oct 2024 13:10:48 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41xwmk4epx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Oct 2024 13:10:48 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 491DAl6h39977252
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 1 Oct 2024 13:10:47 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5000658054;
	Tue,  1 Oct 2024 13:10:47 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C0CE55805A;
	Tue,  1 Oct 2024 13:10:46 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.145.60])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  1 Oct 2024 13:10:46 +0000 (GMT)
Message-ID: <ce1e8f8748fc8593b3b0f4fd90d3e0bc3f085c93.camel@linux.ibm.com>
Subject: Re: TPM HMAC (really) bad performance
From: Mimi Zohar <zohar@linux.ibm.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>,
        Roberto Sassu
	 <roberto.sassu@huaweicloud.com>,
        Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-integrity@vger.kernel.org
Date: Tue, 01 Oct 2024 09:10:46 -0400
In-Reply-To: <560e2303c30cc9c200156d223c323d2f353e711b.camel@linux.ibm.com>
References: <b8a7b3566e6014ba102ab98e10ede0d574d8930e.camel@huaweicloud.com>
	 <d66af0d491f7576c7d865bf6de4da4c83cf0c3ba.camel@huaweicloud.com>
	 <7025be516c4de1cbd8958c80242f503cc6e92c4a.camel@HansenPartnership.com>
	 <dd0f55e179ae6aaa1c99c320facc1bb33ccb25c8.camel@linux.ibm.com>
	 <1f1e3b64c24608e9a37f959d9cf7e1f869311410.camel@HansenPartnership.com>
	 <560e2303c30cc9c200156d223c323d2f353e711b.camel@linux.ibm.com>
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
X-Proofpoint-GUID: iP_kUjwOfrALq_i6voWyIO9vfUfhlRSu
X-Proofpoint-ORIG-GUID: iP_kUjwOfrALq_i6voWyIO9vfUfhlRSu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-01_09,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 mlxscore=0 priorityscore=1501 clxscore=1015 spamscore=0 lowpriorityscore=0
 adultscore=0 impostorscore=0 phishscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2410010084

On Mon, 2024-09-30 at 23:13 -0400, Mimi Zohar wrote:
> >=20
> > > =C2=A0 just disabling it for IMA or disabling it entirely based on wh=
ether
> > > IMA is configured?
> >=20
> > Since tpm2_pcr_extend() is unused if IMA is disabled, we don't really
> > need to condition on it, we could just remove the HMAC from extends.
>=20
> Ok, so defining a new Kconfig is unnecessary.

IMA is enabled at boot/runtime, based on loading a policy.  Similarly the T=
PM
HMAC performance impact decision at least for IMA needs to be left with the
system owner, not with the person building the kernel.  My suggestion would=
 be
to define an IMA boot command line option that enables TPM HMAC.  Without t=
he
boot command line option, a warning should be emitted.

Mimi

