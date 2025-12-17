Return-Path: <linux-integrity+bounces-8091-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 152FBCC8884
	for <lists+linux-integrity@lfdr.de>; Wed, 17 Dec 2025 16:42:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 171893148411
	for <lists+linux-integrity@lfdr.de>; Wed, 17 Dec 2025 15:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E73C7359F80;
	Wed, 17 Dec 2025 15:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KbRUERgU"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40FC23596F8;
	Wed, 17 Dec 2025 15:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765985214; cv=none; b=lPzgSkCx+wEEZnpw2x65lFExd/wT8TXaJEcV5XXSTvJ2/g44Cy8H1OUBif2fFFmS8hWr5YMSJab1yuOvsw76AvwbKCk+7PDWXsknnyo9tYjqBwzziuIxr/sTqCbojstdYXmMSs0S3DfT3KGQ4IT21H/ds2iSNMU/i7nLh7Giucs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765985214; c=relaxed/simple;
	bh=ckFG9yCBPCeBY082ub684scmigIUOsiKpLa2Nfi1CTg=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=qwPNDomIbJJGcFZGFhu5orr6Zk/Ingx86ViORSCAHHElKZdcRfLfCpD7Hzzx68JTYuwGHgza4O4lExcber9LEIv4I8vWgvm1O0bRDXB1PWg93272trGEut2quOv0II0+3gstw5WjAyl4ncXGvKhtnRc+T5Ivv/D6peZ/m2Z+RxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KbRUERgU; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BH6VLZ0006896;
	Wed, 17 Dec 2025 15:26:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=DKoXLi
	eBOqq08z07bvl+o+dYTPY3fWPvN2EE1w2gDzA=; b=KbRUERgU4cKg2xRYFxHj2j
	fnakyQRKHS00GNQCnYVHtc2gm6mcvdE0daxpi5SRDMe21snlmAFCerZFqiJMvPeQ
	fUX0KkYmQxHyYoYBb4Kh5VrhXFs1prZEQxrCB8g/bJ10C3O50XyWQLaWYfZJaVRG
	aF1KMdVj6nRpN1GD/5OGsKaZ4KRAjvuhbPozDlIZtZ4CY7gwCmGc61xfzCrwQcKz
	ICDcxrawKmS4vHE5Bf+9zc0psTXN0EVR3UkmiF2Q3p9tgr/6UDBURXBI9Z38qCAY
	/M+UFV9DH7RwH9KLDCYtPNTo3xYKNwBGtwb60bgxrOmI3Z1G5vBrKs/fTjZdHJ/w
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b0wjq54m7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Dec 2025 15:26:25 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5BHFDvXE000797;
	Wed, 17 Dec 2025 15:26:24 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b0wjq54m4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Dec 2025 15:26:24 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BHCmEsQ012816;
	Wed, 17 Dec 2025 15:26:24 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4b1juyb4rg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Dec 2025 15:26:24 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5BHFQN7Y19202578
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Dec 2025 15:26:23 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7EA1458052;
	Wed, 17 Dec 2025 15:26:23 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9A8EA5805A;
	Wed, 17 Dec 2025 15:26:22 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.66.168])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 17 Dec 2025 15:26:22 +0000 (GMT)
Message-ID: <45ca26a5b08f42fb1318cd78a62dda20b9adb84e.camel@linux.ibm.com>
Subject: Re: [RFC][PATCH v2] ima: Add support for staging measurements for
 deletion and trimming
From: Mimi Zohar <zohar@linux.ibm.com>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>, corbet@lwn.net,
        dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        gregorylumen@linux.microsoft.com, chenste@linux.microsoft.com,
        nramas@linux.microsoft.com, Roberto Sassu <roberto.sassu@huawei.com>
In-Reply-To: <20251212171932.316676-1-roberto.sassu@huaweicloud.com>
References: <20251212171932.316676-1-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 17 Dec 2025 10:26:22 -0500
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.54.3 (3.54.3-2.fc41) 
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjEzMDAwMSBTYWx0ZWRfX5rvLz0ncaOzW
 h0iKXDggcsekEWak9J/7FAlGCRDqWsFmsh4SHQbuGTdJYpKYeVgMdGWXIW2FsvcuiMgmqdYB7RW
 j6q5oBOTMlG2inw/i1PcxmhA1snYkJN3BRs+LGGNhX6cz7KHspIE5dKdCw9oB1Hcc2JBBhEutEN
 jpakLy9wE4UGkkr6Hbp7fSqRCwYEVHpkHgKm97De7VTJjny9rEPY/WYos3izVgWmBm5sCUNRyfH
 ijmVvO0I8Q4TktMptm1vcy0nCNSIr6XQlfx9QHAvY2kw9LMYDRXTMkPhXXSm0ujCXAiTBS17CaU
 t9djVNI3A2sGy3r9/x9Fj1BynCQJVNiiC+cYpW4KmgKHteZG/f9+qHK0XHiyS5GSDkiiMrGH0rf
 5VkltOO7IATJC2xpxumK9oSta2J1Tg==
X-Proofpoint-GUID: 38Hu_ad1YeVrF7BzaAGbKW6hy2OzGMaf
X-Proofpoint-ORIG-GUID: WPBA0wQp3Kfkxu4HDCrvmpRN7PbyFtSX
X-Authority-Analysis: v=2.4 cv=Kq5AGGWN c=1 sm=1 tr=0 ts=6942cba1 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=i0EeH86SAAAA:8 a=JtGQKGBNXkVSYQT4CyIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-17_02,2025-12-16_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 impostorscore=0 clxscore=1015 spamscore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2512130001

Hi Roberto,

Thank you!  Everything is working as designed.

- Only public functions require kernel-doc comments, but other functions wo=
uld
benefit having a comment.

- As I mentioned in response to Steven's patch, "After trimming the measure=
ment
list, existing verifiers, which walk the IMA measurement list, will obvious=
ly
fail to match the PCRs.  Breaking existing userspace applications is a prob=
lem
and, unfortunately, requires yet another Kconfig option.  It needs to be at
least mentioned here in the patch description."

On Fri, 2025-12-12 at 18:19 +0100, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
>=20
> Introduce the ability of staging the entire (or a portion of the) IMA
> measurement list for deletion. Staging means moving the current content o=
f
> the measurement list to a separate location, and allowing users to read a=
nd
> delete it. This causes the measurement list to be atomically truncated
> before new measurements can be added.=C2=A0

This last sentence is the crux of your of your proposal.
 -> "quickly be atomically ... so ..."

I must be missing something.  With the ability of trimming N records, it's
unclear to me the benefit of staging the measurement list and requiring a
separate deletion. The measurement list can be read before trimming without
loosing any measurements.  Like now, the entire measurement list could be m=
oved
to a staging area. Instead of freeing all of the records, only N records wo=
uld
be freed.  Afterwards the remaining staged measurements (N+1) could be rest=
ored
to the head of the measurement list.

--=20
thanks,

Mimi


