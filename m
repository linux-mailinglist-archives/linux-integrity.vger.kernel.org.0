Return-Path: <linux-integrity+bounces-4588-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9142A159F9
	for <lists+linux-integrity@lfdr.de>; Sat, 18 Jan 2025 00:38:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04C8F1692CB
	for <lists+linux-integrity@lfdr.de>; Fri, 17 Jan 2025 23:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 205221DDC0F;
	Fri, 17 Jan 2025 23:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pYcwOns4"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609E51DC9BF;
	Fri, 17 Jan 2025 23:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737157111; cv=none; b=C1ax7ZyChDWVwKnN5WVnUfp27IneGXJ1TpXt2+z32cY/fPZlaaZSc93UqDJWx06M5DxfaM1NMoQAfte42k9xM23RJbVsbrakTGUJjQtQXDe6WG7AQCTR5H3RzP/lOuwbS941qonGGSx609ZSmacrNxQNHgYS1ZwL7vei8xA4Zjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737157111; c=relaxed/simple;
	bh=W9rauymGG636CzhmZXtNuGeLAsbJMLCdwK9H+eidk8k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aFA+cFYIVka40Wfr6PVUoiDxIhG1+9ZjeCeEQm6+h0O7DZ2+zdmFAaMo0J97Z3imJBkkeWliiLc4BXdclzRSXArrDuRpR/yw4qWwTczp8nehA5KtdpzbPmDo6mVy401ix03uC1wPAGxHnSbwcNHXvKHjeiORUkswMZdC9PhZrL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pYcwOns4; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50HLQM6g022186;
	Fri, 17 Jan 2025 23:37:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=W9rauy
	mGG636CzhmZXtNuGeLAsbJMLCdwK9H+eidk8k=; b=pYcwOns44wCMZzTbAMQ8IE
	bCUFj0VxjiFEMTv5tF5rsp7u9MvUWwSB+99pgXd/7/YmowL7S0mUXDsIJ9RAiAM+
	dvmPDW7hlsdC3HJNB7gpDb5FEvtBB9g2jPszStI8pi1cfNIAQEB71sYp6BL/+1sK
	hj87AC0Z7D8w54Zr6dUMVCPZ8fSqNuFOW+7wyd+iFdyOhWM8Cka9G4lesagJU4D/
	XGYPp/epgJ7Cb4qsCoEDOcExjt3tAurFTOu18Q42LztbV1h85/lQTkbddOwd6tMn
	4W4zGA6vFDV+xPpliPZtui9o/xz0rSE+s4NnbDaJrc/eqLoBddyRMlUZdHE7Q3SQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 447rp5aduj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Jan 2025 23:37:55 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50HNbtU8014859;
	Fri, 17 Jan 2025 23:37:55 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 447rp5adug-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Jan 2025 23:37:55 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50HL5LdH002681;
	Fri, 17 Jan 2025 23:37:54 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4443byncu0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Jan 2025 23:37:54 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50HNbrWu19661388
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Jan 2025 23:37:54 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C12AC58058;
	Fri, 17 Jan 2025 23:37:53 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D100B58057;
	Fri, 17 Jan 2025 23:37:52 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.15.82])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 17 Jan 2025 23:37:52 +0000 (GMT)
Message-ID: <c84b2a23b5ea5cc5332c6edcb0a953a0a9ecd4d4.camel@linux.ibm.com>
Subject: Re: [PATCH v2] ima: kexec: silence RCU list traversal warning
From: Mimi Zohar <zohar@linux.ibm.com>
To: Breno Leitao <leitao@debian.org>,
        Roberto Sassu
 <roberto.sassu@huawei.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Eric Snowberg <eric.snowberg@oracle.com>,
        Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrew Morton
 <akpm@linux-foundation.org>
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com
Date: Fri, 17 Jan 2025 18:37:52 -0500
In-Reply-To: <20250116-jovial-stalwart-chipmunk-0b3693@leitao>
References: <20241121-ima_rcu-v2-1-4d48630cf2c6@debian.org>
	 <20250116-jovial-stalwart-chipmunk-0b3693@leitao>
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
X-Proofpoint-GUID: m7v_Lu-HEIawRgNyj2ekpfxpwt6-e_Ah
X-Proofpoint-ORIG-GUID: DOQNup_8nTHermrQQJMUD-CTbY0aaqf3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-17_08,2025-01-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=711
 impostorscore=0 lowpriorityscore=0 mlxscore=0 adultscore=0 malwarescore=0
 priorityscore=1501 clxscore=1015 spamscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501170182

On Thu, 2025-01-16 at 03:23 -0800, Breno Leitao wrote:
> Hello Mimi,
>=20
> On Thu, Nov 21, 2024 at 01:57:12AM -0800, Breno Leitao wrote:
> > The ima_measurements list is append-only and doesn't require
> > rcu_read_lock() protection. However, lockdep issues a warning when
> > traversing RCU lists without the read lock:
> >=20
> > =C2=A0 security/integrity/ima/ima_kexec.c:40 RCU-list traversed in non-=
reader
> > section!!
>=20
> What are the next steps in regarding this issue? I am still seeing this
> problem on Linus' tree.

It's included in the v6.14 pull request, which I just sent.

thanks,

Mimi

