Return-Path: <linux-integrity+bounces-4278-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E63229E25AF
	for <lists+linux-integrity@lfdr.de>; Tue,  3 Dec 2024 17:03:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BF7128819D
	for <lists+linux-integrity@lfdr.de>; Tue,  3 Dec 2024 16:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD5BC1F76AD;
	Tue,  3 Dec 2024 16:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DTCMe78g"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70C223CE;
	Tue,  3 Dec 2024 16:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733241810; cv=none; b=ONPhPZnaxYmCOgezLJs4UY6FkzK5LwjAFAk/zpUAJjdts2mwqDHYH+0wmuOaAKpMcZ8p4CWx+XB+mTzuCxb3SYw0zxkjSjXjV7voZNAq+YTpNyOjq4wd6KiU8UZQE87Nygc7RIH8btv3pFdroKG3Glg0BJ/P+3sRfB8I8AMsfDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733241810; c=relaxed/simple;
	bh=1wm8VU2k6nsO+/umiWcRuh2paY89HdBSNb686MfE21k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=chkPq2rMto+LWenVKEBwj7BQpiEkA5mr1bzW/XDUzIv/D359Yi5ucuMBRlZFTTDeYFdcsWiNWfH8L22vBHKKdsJMZDCdhk+L8aOzBtMVYlWgQgcrrRIHfdTqjOX9Ziq27imHD+pLt4vB4HcNtB/R2Wa2M5SEHEiLcesAmkNN+Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DTCMe78g; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B3Csm4W014626;
	Tue, 3 Dec 2024 16:03:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=AB6ql1
	Lm3mqwBjXtDY+Mfmwa6WnsslgZoWq9phCEbKc=; b=DTCMe78gmAyVzpknlkLOXL
	Rpg+loZpBVZD3CPAOwljK8au0mWPAbsEXnT4FWxSnDbOtTorhiCJ0JMi5iXJ1AIl
	NAqha6wnUp/jvZUSpwrnLKyEDmGecr+cT6FHq8LnzBmPaMRskW3QH6tzl/LwjTcL
	uUaGZbdX40imH9baD33q2Dn+a6nT538Yrczc/tBRiaN2IL+t/5Voavfwl1wu67TB
	x0+YwggWo5EjHVAUxS6UyGqzquTDro9yP5ZUzWbYtTFRxks0IzjV+aAEbwThwEf7
	TZsF4Lzt01HQYoMaH+MwwqxJnAPhZvyaJq0LGcfh+DJQVCdTFAMrGE1He/R1D44g
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 437tbxjjjk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Dec 2024 16:03:10 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4B3D3PMW023551;
	Tue, 3 Dec 2024 16:03:09 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 438e1n0cwe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Dec 2024 16:03:09 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4B3G39U622348424
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 3 Dec 2024 16:03:09 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E5B5A58043;
	Tue,  3 Dec 2024 16:03:08 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6808C58055;
	Tue,  3 Dec 2024 16:03:08 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.31.103.152])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  3 Dec 2024 16:03:08 +0000 (GMT)
Message-ID: <f588fffdb27b28531e900e59cc17182617726b59.camel@linux.ibm.com>
Subject: Re: [PATCH] ima: instantiate the bprm_creds_for_exec() hook
From: Mimi Zohar <zohar@linux.ibm.com>
To: =?ISO-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: linux-integrity@vger.kernel.org, roberto.sassu@huawei.com,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
        audit@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
        Jeff Xu
	 <jeffxu@chromium.org>, Kees Cook <kees@kernel.org>
Date: Tue, 03 Dec 2024 11:03:08 -0500
In-Reply-To: <20241203.oZu0aemaiv5a@digikod.net>
References: <20241127210234.121546-1-zohar@linux.ibm.com>
	 <20241129.keeDathoo3Oh@digikod.net>
	 <421b119b81ec044fcdc714aac5748ebe5b4557aa.camel@linux.ibm.com>
	 <20241203.oZu0aemaiv5a@digikod.net>
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
X-Proofpoint-ORIG-GUID: V0vnWNp8XSm0ldcdvHu0FdPdWm7dODi0
X-Proofpoint-GUID: V0vnWNp8XSm0ldcdvHu0FdPdWm7dODi0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 impostorscore=0
 mlxscore=0 suspectscore=0 mlxlogscore=884 priorityscore=1501 bulkscore=0
 phishscore=0 adultscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2412030134

On Tue, 2024-12-03 at 12:53 +0100, Micka=C3=ABl Sala=C3=BCn wrote:
> On Mon, Dec 02, 2024 at 02:40:35PM -0500, Mimi Zohar wrote:
> > On Fri, 2024-11-29 at 12:06 +0100, Micka=C3=ABl Sala=C3=BCn wrote:
> > > For reference, here is the base patch series:
> > > https://lore.kernel.org/all/20241112191858.162021-1-mic@digikod.net/
> > >=20
> > > CCing audit@
> > >=20
> > > On Wed, Nov 27, 2024 at 04:02:34PM -0500, Mimi Zohar wrote:
> > > > Like direct file execution (e.g. ./script.sh), indirect file execut=
ion
> > > > (e.g. sh script.sh) needs to be measured and appraised.  Instantiat=
e
> > > > the new security_bprm_creds_for_exec() hook to measure and verify t=
he
> > > > indirect file's integrity.  Unlike direct file execution, indirect =
file
> > > > execution integrity is optionally enforced by the interpreter.
> > > >=20
> > > > Update the audit messages to differentiate between kernel and users=
pace
> > > > enforced integrity.
> > >=20
> > > I'm not sure to see the full picture.  What is the difference between
> > > execveat() calls and execveat() + AT_EXECVE_CHECK calls?  Both are fr=
om
> > > user space, the only difference is that the first can lead to a full
> > > execution, but the intent is the same.
> >=20
> > We do want the full execution in order to measure/appraise/audit both t=
he direct
> > file execution (e.g. ./script.sh) and the interpreter (e.g. #!/usr/bin/=
bash)
> > specified.
>=20
> Yes, but I was wondering about the difference in the log messages.  In
> both cases the script is checked, but only without AT_EXECVE_CHECK its
> "dependencies" (e.g. script interpreter) are checked.  I guess it could
> be useful to differenciate those but I wanted to make sure we were on
> the same page.

By "those" I assume you're referring to with/without AT_EXECVE_CHECK and no=
t the
missing "dependencies".

In both cases the integrity of the script is being checked, but in one case=
 the
integrity is being enforced by the kernel, while in the other case userspac=
e may
enforce integrity.  The audit message should different between these two ca=
ses.

Mimi



