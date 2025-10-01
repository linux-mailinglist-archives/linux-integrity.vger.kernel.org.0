Return-Path: <linux-integrity+bounces-7353-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 830A2BB1516
	for <lists+linux-integrity@lfdr.de>; Wed, 01 Oct 2025 19:05:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CD3D7A32A9
	for <lists+linux-integrity@lfdr.de>; Wed,  1 Oct 2025 17:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F158D2D2490;
	Wed,  1 Oct 2025 17:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HXKPdcea"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416AA1898F2;
	Wed,  1 Oct 2025 17:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759338296; cv=none; b=NE8M6BpU+obvYYPD1w7Ovzx18yrtl2wwR0Izqcpv4++SUkXhqODBL+UMwLrtT6zuCvkBhobCs1TCX1K4zSViQ2JGaIXt99gir8nJN8C1Wn9zTNbbdmH6ss4IFPwos40c7BK3RkeDlj2zjMH9zlsSpaNO4zIADkaqgG464H8I56U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759338296; c=relaxed/simple;
	bh=gLn1ZbgWybMDWfKIwNh+SmsEVaw1IxMFfAlX3cBkiOw=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=QjL5fAL2de0+dbsmU517nA12UTG/hN/i9XUUFonTYJysMHi0c0p0bUCHNVxVzO0M9vZlwQgbkrxbrHl5y4/jUTZ+iYMYB4uUEXLxlNB3e3EtZ2/SmBc3q899aK8EeXf14griBttXI203i20kie8XC5uiL0UCXvwfdMiSmHmslgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HXKPdcea; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 591BS7LY012103;
	Wed, 1 Oct 2025 17:03:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=mmSOu7
	yKr3U6hbL/BRIUs8d04OPVHGv1MnkV/X4o7Xs=; b=HXKPdceayx1dfiHDxHXF8/
	85g52TU0ZqMMS3WLWxU2JC0SHa39AMX9/BxncI6E7zEzw2SE8btq8eOjQB/FunlV
	HPj+wdAZTkywPPGyu7/51tForZR9SxUG8TU7LwHYRoXpArB1Lznn/1U3c91WoV1z
	NajUkEcmUEdksqcTW/bZwnn/dt+8J0ZUwr7T68Qevgw50Q9u52gFBSao2MCpF6uj
	oj0yzTyvZBR57ZDecjfLzls5RDyaIp9bN5/W52M3lZPzJ5flpFS8hgwB/wHTUFdU
	TNiGQK8e8RePbwEStkxgCdjMAhUs/6axDU9gfayFcvoqDiCgPujArTFVEhVuBcxQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49e7kugxsq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Oct 2025 17:03:45 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 591GTk4P006318;
	Wed, 1 Oct 2025 17:03:45 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49e7kugxsf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Oct 2025 17:03:44 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 591FwwDY026740;
	Wed, 1 Oct 2025 17:03:42 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49eu8n1wu6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Oct 2025 17:03:42 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 591H3fgi19071570
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 1 Oct 2025 17:03:42 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 957D858062;
	Wed,  1 Oct 2025 17:03:41 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0A2805803F;
	Wed,  1 Oct 2025 17:03:40 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.83.6])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  1 Oct 2025 17:03:39 +0000 (GMT)
Message-ID: <74178ea117c18f88b4c3607e5a2afb81fc80e428.camel@linux.ibm.com>
Subject: Re: [PATCH v4 31/34] ima,evm: move initcalls to the LSM framework
From: Mimi Zohar <zohar@linux.ibm.com>
To: Paul Moore <paul@paul-moore.com>
Cc: selinux@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        John Johansen	
 <john.johansen@canonical.com>,
        Roberto Sassu <roberto.sassu@huawei.com>, Fan Wu	 <wufan@kernel.org>,
        =?ISO-8859-1?Q?Micka=EBl_Sala=FCn?=
 <mic@digikod.net>,
        =?ISO-8859-1?Q?G=FCnther?= Noack	 <gnoack@google.com>,
        Kees Cook <kees@kernel.org>, Micah Morton	 <mortonm@chromium.org>,
        Casey
 Schaufler <casey@schaufler-ca.com>,
        Tetsuo Handa	
 <penguin-kernel@i-love.sakura.ne.jp>,
        Nicolas Bouchinet	
 <nicolas.bouchinet@oss.cyber.gouv.fr>,
        Xiu Jianfeng <xiujianfeng@huawei.com>
In-Reply-To: <CAHC9VhQCmFJQ1=Eyu1D+Mcg2FVDByrk8QcwV5HaZdB95esiA7Q@mail.gmail.com>
References: <20250916220355.252592-36-paul@paul-moore.com>
	 <20250916220355.252592-67-paul@paul-moore.com>
	 <CAHC9VhQCmFJQ1=Eyu1D+Mcg2FVDByrk8QcwV5HaZdB95esiA7Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Oct 2025 13:03:39 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.54.3 (3.54.3-2.fc41) 
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=T7WBjvKQ c=1 sm=1 tr=0 ts=68dd5ef1 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=xVhDTqbCAAAA:8 a=i0EeH86SAAAA:8
 a=ZJK8B7V9_OMLTbgYB20A:9 a=QEXdDO2ut3YA:10 a=GrmWmAYt4dzCMttCBZOh:22
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: hZGLNhxj87aDUW4936bVLO8xxDAtHYKA
X-Proofpoint-ORIG-GUID: k5UJfdv3YdwmyUKVFwmHKIRdvytbBGVj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAyNSBTYWx0ZWRfXy8eVh3SF7PaW
 IMHVuM3Iq6G0WgHivAHw28L5ajRUbDlAu/2ckJnrppyuy58WODxDP9evm+g0t3Rj6qPGhjtpy7L
 Ho9h7W/mWy7qXk0N8sINxrPO/5lnS55azBDvMUkTBwsUPm3zPLwUuxNI9eHVO20Cwp4NOWJu/ra
 05Xxcd3ViNQMtlhMDwZ4EzK6kv9WY0a7vgwKBrxSdrG/Ju4B5H0TefZWNYu5+G+v5CTSJXNMj+e
 SkWQQ9USOZUeNQts8+RLFs6cycl0+cYeUdXnSie+G0XM3WBXQ8U8v3HEjNVm5apbuY46X3LQ1bO
 dFAghCfT5ghK2y3JD4MfQ1GpbHfNxl+ErlsVNIsEpNLjd6fGBXlqEoYo8MpNjcFfK2Hz1SjpTnc
 /QtMMP+HR2UDL0YYeLludTIk5qobvA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-01_05,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 spamscore=0 suspectscore=0 priorityscore=1501
 bulkscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270025

On Tue, 2025-09-30 at 16:11 -0400, Paul Moore wrote:
> On Tue, Sep 16, 2025 at 6:14=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> >=20
> > From: Roberto Sassu <roberto.sassu@huawei.com>
> >=20
> > This patch converts IMA and EVM to use the LSM frameworks's initcall
> > mechanism. It moved the integrity_fs_init() call to ima_fs_init() and
> > evm_init_secfs(), to work around the fact that there is no "integrity" =
LSM,
> > and introduced integrity_fs_fini() to remove the integrity directory, i=
f
> > empty. Both integrity_fs_init() and integrity_fs_fini() support the
> > scenario of being called by both the IMA and EVM LSMs.
> >=20
> > This patch does not touch any of the platform certificate code that
> > lives under the security/integrity/platform_certs directory as the
> > IMA/EVM developers would prefer to address that in a future patchset.
> >=20
> > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > [PM: adjust description as discussed over email]
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
> > ---
> >  security/integrity/evm/evm_main.c  |  3 +--
> >  security/integrity/evm/evm_secfs.c | 11 +++++++++--
> >  security/integrity/iint.c          | 14 ++++++++++++--
> >  security/integrity/ima/ima_fs.c    | 11 +++++++++--
> >  security/integrity/ima/ima_main.c  |  4 ++--
> >  security/integrity/integrity.h     |  2 ++
> >  6 files changed, 35 insertions(+), 10 deletions(-)
>=20
> I appreciate you reviewing most (all?) of the other patches in this
> patchset, but any chance you could review the IMA/EVM from Roberto?
> This is the only patch that really needs your review ...

I've already reviewed the patch, just not Acked it yet.  I'll hopefully get=
 to
testing it later this week or next week.

Mimi


