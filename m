Return-Path: <linux-integrity+bounces-4308-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91AF19E6495
	for <lists+linux-integrity@lfdr.de>; Fri,  6 Dec 2024 04:11:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 885F616A39A
	for <lists+linux-integrity@lfdr.de>; Fri,  6 Dec 2024 03:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6664317DE2D;
	Fri,  6 Dec 2024 03:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="roIIUP5n"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC27041C77;
	Fri,  6 Dec 2024 03:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733454668; cv=none; b=cC+uihvICHiqHsT6Yl4bOpXRo1i4BeyFnI74yvYmn2diampgIbPNndZcPaPUYHTq//4+S9Tiwgyh2JovncVnpOm3oLcm9klNH2upFuEvj7J06Eg1MPrSCQUndFj9M/J3tgzTbfgBGFHouhaWplITrfXT0Wzh39aFhZ9dt9VHalw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733454668; c=relaxed/simple;
	bh=YCcsQBLzz097jKtMcuCVJ8K011zJcVsZOgndM9W1fEI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=taox2BvlfyYajX6iGF9H3aitINetmPHW/ODyKPkPnfqOMLl0QS9gXaxQIGUQ+mAg0yyIrTccNC3xGMdo3W2q3AVM+p9H2rR8fRWqz0s5TwHQl8Upt/fgSJtoLzJPNCrwKw0qKSC3mcpu4945iMtRNZDy5vwD6+7QHjY2hwVxLzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=roIIUP5n; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B5JX6xw027768;
	Fri, 6 Dec 2024 03:10:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=yDhAM7
	HPcAjoSQqLayCtHWYxOTAHydOBcH6zeNAKDLQ=; b=roIIUP5nCCMgEXm4IdtUFP
	AKARimDUGh5yWy0/sKObBrHrg/39KQjHrnR+QrbaNw3QIXXAP7IVyMC/RMztxt41
	KHdv6Ll1pqwyvwZ/AAmOaqvMV7J3SIBejak7Vsqk3oPDldnwDuZRsDoKiMk9y7WZ
	Y+492gPJrlZAFcPbBiCsouyvOK3NAi4L78EA7tga7q85TzJkEB7pI8ErjvA93RxQ
	CoQ07AloyGxj8hvMNZRR/rlzCgdZE4fIXz+tD23VAoGEdTLjSXeDRwPTlsdKS/I/
	W83mW8tacnq2Zl1t+TDUm0JfFMHFXudRvUuIPpUp5ws6ZHKhrO0RS7A3pxFPYqxg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43ba1ymdk8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Dec 2024 03:10:39 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4B60tcso005278;
	Fri, 6 Dec 2024 03:10:38 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 438fr1vwa2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Dec 2024 03:10:38 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4B63AbLA49086890
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 6 Dec 2024 03:10:37 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 372815805A;
	Fri,  6 Dec 2024 03:10:37 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9639658051;
	Fri,  6 Dec 2024 03:10:36 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.36.231])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  6 Dec 2024 03:10:36 +0000 (GMT)
Message-ID: <b6dc4d8b23b822638ab676055809503060c0bca2.camel@linux.ibm.com>
Subject: Re: [PATCH v2] ima: instantiate the bprm_creds_for_exec() hook
From: Mimi Zohar <zohar@linux.ibm.com>
To: Paul Moore <paul@paul-moore.com>, linux-integrity@vger.kernel.org
Cc: =?ISO-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
        roberto.sassu@huawei.com, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jeff Xu <jeffxu@chromium.org>,
        Kees Cook
	 <kees@kernel.org>, audit@vger.kernel.org
Date: Thu, 05 Dec 2024 22:10:36 -0500
In-Reply-To: <282573d0ea82ac71c8305d0c8cc89083@paul-moore.com>
References: <20241204192514.40308-1-zohar@linux.ibm.com>
	 <282573d0ea82ac71c8305d0c8cc89083@paul-moore.com>
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
X-Proofpoint-ORIG-GUID: Eikc-Du9f6xTPsAUAf3TY1Ri9qqXeCVg
X-Proofpoint-GUID: Eikc-Du9f6xTPsAUAf3TY1Ri9qqXeCVg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=998 phishscore=0 adultscore=0 spamscore=0 priorityscore=1501
 bulkscore=0 mlxscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412060021

On Thu, 2024-12-05 at 19:30 -0500, Paul Moore wrote:
> On Dec  4, 2024 Mimi Zohar <zohar@linux.ibm.com> wrote:
> >=20
> > Like direct file execution (e.g. ./script.sh), indirect file execution
> > (e.g. sh script.sh) needs to be measured and appraised.  Instantiate
> > the new security_bprm_creds_for_exec() hook to measure and verify the
> > indirect file's integrity.  Unlike direct file execution, indirect file
> > execution is optionally enforced by the interpreter.
> >=20
> > Differentiate kernel and userspace enforced integrity audit messages.
> >=20
> > Co-developed-by: Roberto Sassu <roberto.sassu@huawei.com>
> > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> > ---
> > Changelog v3:
> > - Mickael: add comment ima_bprm_creds_for_exec(), minor code cleanup,
> >   add Co-developed-by tag.
> >=20
> > Changelog v2:
> > - Mickael: Use same audit messages with new audit message number
> > - Stefan Berger: Return boolean from is_bprm_creds_for_exec()
> >=20
> >  include/uapi/linux/audit.h            |  1 +
> >  security/integrity/ima/ima_appraise.c | 27 +++++++++++++++++++++++--
> >  security/integrity/ima/ima_main.c     | 29 +++++++++++++++++++++++++++
> >  3 files changed, 55 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
> > index 75e21a135483..826337905466 100644
> > --- a/include/uapi/linux/audit.h
> > +++ b/include/uapi/linux/audit.h
> > @@ -161,6 +161,7 @@
> >  #define AUDIT_INTEGRITY_RULE	    1805 /* policy rule */
> >  #define AUDIT_INTEGRITY_EVM_XATTR   1806 /* New EVM-covered xattr */
> >  #define AUDIT_INTEGRITY_POLICY_RULE 1807 /* IMA policy rules */
> > +#define AUDIT_INTEGRITY_DATA_CHECK  1808 /* Userspace enforced data in=
tegrity */
>=20
> I worry that "DATA_CHECK" is a bit vague, should we change the name so
> that there is some hint of either userspace enforcement or
> AT_EXECVE_CHECK?
>=20
> What about AUDIT_INTEGRITY_DATA_USER?

The emphasis should be on userspace - AUDIT_INTEGRITY_USERSPACE.

Mimi

