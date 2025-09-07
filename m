Return-Path: <linux-integrity+bounces-7024-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A20AB48029
	for <lists+linux-integrity@lfdr.de>; Sun,  7 Sep 2025 23:13:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F1871B22247
	for <lists+linux-integrity@lfdr.de>; Sun,  7 Sep 2025 21:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 038ED217659;
	Sun,  7 Sep 2025 21:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="V9Od9jVx"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411F51A0BFD;
	Sun,  7 Sep 2025 21:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757279598; cv=none; b=AUvKvHj+oAwRHs/S/m9OTCeVFkGe5p/RC0QGmfiz1cY++L1FwzD2vnIEHyMSwYa2n83NYc9kN8g75cIXC0XwYjmOR/oZUxfjA21jhRAVytuKPLxOi/HmoycKmzTsnppJBW3BVeTKYZG9lmh7pio+jGqN8/S6peIkWf/M2xxiowI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757279598; c=relaxed/simple;
	bh=6oD62rq77GKNyBkQ/7TQ+ZNvD8fwHs59VUiFxHpMBCo=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=fCHEyz7ybiMe5nFRASPAwLlubnaVIz5OFjqfMuSU7gFLbzr1LoqqENu5lGAxvZiWO0oT/RxjBd4/Bj2zhfBAY2+fThvpf9F9ITlFOrjdjJe8dpOORU3eI31Es3ZEsMKmltjlARuXjM0eC6XWuOBVothrbqARYVcxr1QCuhyw3jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=V9Od9jVx; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 587FcK4f017992;
	Sun, 7 Sep 2025 21:12:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=UADAl+
	OYq8oUanXggYpE7JXZky5eaKI3MrdEZXl2m2U=; b=V9Od9jVxFHEpYz18T7JIW8
	RTGY/9FSbgsHfLM7ywoITC67whTFnbe53+4udSMX2PCPbjNbHwTYuYkY9GKCc1wt
	MmGsbOAGkQ/L0QEYdXcKWQQ5ca2evjuS1Mgq2wZnRgFZ5auJU07yelbQnh7aOOYD
	4WQeQfHZUWbuhWx+s33UkaDs9vNVH7D/DgxCE5PzIEQmKsIWR5ZqDZB/ZQXdkGQ9
	HHUSD2DnXPGOJILh3V5UIW9NlWWRHGQ0p8W/NucBAwuTOLJFGVa1tjT73dGW8erl
	1++vd5VtUVgRfevBQW5frlKTBlbFv+uThAVEI3xuSPOTIA/1dthDfDBsvs9SQ7NA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490uke3b6r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 07 Sep 2025 21:12:03 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 587L93TI022276;
	Sun, 7 Sep 2025 21:12:02 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490uke3b6m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 07 Sep 2025 21:12:02 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 587I1ZVa007929;
	Sun, 7 Sep 2025 21:12:02 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49109pb3ex-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 07 Sep 2025 21:12:02 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 587LC1L531064640
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 7 Sep 2025 21:12:01 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9A8C558059;
	Sun,  7 Sep 2025 21:12:01 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1311958058;
	Sun,  7 Sep 2025 21:12:00 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.133.224])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Sun,  7 Sep 2025 21:11:59 +0000 (GMT)
Message-ID: <bd46c63ebb9eddfcdc8df92fe9f85473416ea8a0.camel@linux.ibm.com>
Subject: Re: [PATCH v3 31/34] ima,evm: move initcalls to the LSM framework
From: Mimi Zohar <zohar@linux.ibm.com>
To: Paul Moore <paul@paul-moore.com>,
        Roberto Sassu
 <roberto.sassu@huawei.com>
Cc: linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org, John Johansen <john.johansen@canonical.com>,
        Fan
 Wu	 <wufan@kernel.org>,
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
In-Reply-To: <CAHC9VhS3KdVO9n-dgk1qFzTae0i+Oab8atMmt0CAsMEm1D4v5w@mail.gmail.com>
References: <20250814225159.275901-36-paul@paul-moore.com>
	 <20250814225159.275901-67-paul@paul-moore.com>
	 <CAHC9VhS3KdVO9n-dgk1qFzTae0i+Oab8atMmt0CAsMEm1D4v5w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 07 Sep 2025 17:11:59 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDE5NSBTYWx0ZWRfXxVupSFHpxLE1
 957t8E7sJExGW7UYrI1nriHk6izpwbNwmg5BqR6/gtkS7j0v7CWiKqgZ1yz0CebXc1YSe2j+ccZ
 HJRPSq8cGlrCVP7GiVgdmZqqUee6aK+38e1gk7yFi+U/oq+3OpEcWRNN+dbJBDVEX7j+moO5Omj
 D0SRbYFqJrBlDZx8ZupaTYySwPynrppatJ75oieYvmjZVJK8eWdDscPf3AMtIw0ONLNL6JOO2IH
 no+7YA5z+6i3dwpGLtt4Ezo/7TY2b2Jlol8ikeCv3AMKDrM/A694A2TO62IB1C58k46ytvA9whK
 cJBo/L/zFLYakrZ38g7rCgFFS7G8lCRVmRjvHbvHpXJsxkC6aOUzO2tljva2gS2wbXrATS7EDXz
 4uhVv+PN
X-Proofpoint-ORIG-GUID: 1UhvkcA7m0eWnu8GuzjezvdVYJZyv8ce
X-Proofpoint-GUID: ZF0rDJrXo7J8ELHMwmIbE9c-7vDo2jbX
X-Authority-Analysis: v=2.4 cv=StCQ6OO0 c=1 sm=1 tr=0 ts=68bdf523 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=xVhDTqbCAAAA:8 a=2aP09IxchJ5fDEcG8Q4A:9
 a=QEXdDO2ut3YA:10 a=GrmWmAYt4dzCMttCBZOh:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-07_08,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 bulkscore=0 clxscore=1011 adultscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060195

On Fri, 2025-08-22 at 16:45 -0400, Paul Moore wrote:
> On Thu, Aug 14, 2025 at 6:55=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> >=20
> > This patch converts IMA and EVM to use the LSM frameworks's initcall
> > mechanism.  There was a minor challenge in this conversion that wasn't
> > seen when converting the other LSMs brought about by the resource
> > sharing between the two related, yes independent IMA and EVM LSMs.
> > This was resolved by registering the same initcalls for each LSM and
> > including code in each registered initcall to ensure it only executes
> > once during each boot.
> >=20
> > It is worth mentioning that this patch does not touch any of the
> > "platform certs" code that lives in the security/integrity/platform_cer=
ts
> > directory as the IMA/EVM maintainers have assured me that this code is
> > unrelated to IMA/EVM, despite the location, and will be moved to a more
> > relevant subsystem in the future.

The "unrelated to IMA/EVM" wording misses the point.  An exception was made=
 to
load the pre-boot keys onto the .platform keyring in order for IMA/EVM to v=
erify
the kexec kernel image appended signature.  This exception was subsequently
extended to verifying the pesigned kexec kernel image signature.  (Other
subsystems are abusing the keys on the .platform keyring to verify other
signatures.)

Instead of saying "unrelated to IMA/EVM", how about saying something along =
the
lines of "IMA has a dependency on the platform and machine keyrings, but th=
is
dependency isn't limited to IMA/EVM."

Paul, this patch set doesn't apply to cleanly to Linus's tree.  What is the=
 base
commit?

Mimi

