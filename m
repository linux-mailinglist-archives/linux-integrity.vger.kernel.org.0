Return-Path: <linux-integrity+bounces-7221-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E2D31B90483
	for <lists+linux-integrity@lfdr.de>; Mon, 22 Sep 2025 12:54:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A614C4E1E05
	for <lists+linux-integrity@lfdr.de>; Mon, 22 Sep 2025 10:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 996BA296BA2;
	Mon, 22 Sep 2025 10:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pHRVjbD6"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F01522F;
	Mon, 22 Sep 2025 10:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758538439; cv=none; b=MC34lVTc+FGi4H+7SbdMXa3BAO8nRjTTmyHTsXDrYzewYbN1d0v8p3kAjjOSwS3LJJduvEcRgZaNrCN5JUTsyBPCzQ4t8FOw9R4/I0UCbB25HOyW9J3wAPiPtE0FPYDr+OwupBgCU6n2Z/xA7Ajp0C2z/vWh2iaM4fyAdUBqt4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758538439; c=relaxed/simple;
	bh=vVm/rh4qZNO++H9SW3SoCc/GJbF845IniMlO6ufZtJA=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=TPsWUvr/relUp2ZpfBe/eNayY6l7y4h+NCM0X500zZCxz6oF6fgKLPNKwf0tT73nYR6qM3Pmyh4BNmUBxD71NSMDdOad7Ppkd6x62g5QBjNGyVfUQ97iSRjnrdCLLR3s6XmaKd4aR7vyofl4xEDG5WaAQDx6u0htZcPFL+e3EO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pHRVjbD6; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58M527x5006772;
	Mon, 22 Sep 2025 10:52:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=0YCa5i
	xq5n6J1YTb8a626BPv5bsn7LSdr5yPiOqA2tQ=; b=pHRVjbD6d58T6s9vFRMeuH
	MjklQbzxjyZK1y2dPIIU2S9IvIC5fX0u1zXinmcxw5oPXUmtA6AvR6lG5mNEixmt
	7poxwVX1idglU8QEsBp0Zu7s+o/k9BJWMgpDRdmi4Bypl72I4hLbty0B2oWuBj6I
	sTrA0OZHOqVE8ta9IaTXboPWIlcXVR6nuJDVq9W7H4WltwlzTzYx7bKoeqcjx42T
	EEjz28IkdQsujx2Lmob2J0c25FkjkRQJrtLberDM2xq1flftNj8E94aDKntM32N/
	CIsloF0w1HU/U+KvsjBzQ63R9FrU8N51S9C5MW/j/95s3Er1QRl8I1FUkUhe2bjA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 499jpk1ywu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Sep 2025 10:52:51 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58MAqpLR009215;
	Mon, 22 Sep 2025 10:52:51 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 499jpk1ywr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Sep 2025 10:52:51 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58MA5qeP030397;
	Mon, 22 Sep 2025 10:52:50 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 49a9a0we0b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Sep 2025 10:52:50 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58MAqnwI22086254
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Sep 2025 10:52:50 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C37705805E;
	Mon, 22 Sep 2025 10:52:49 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DA24958056;
	Mon, 22 Sep 2025 10:52:48 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.106.79])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 22 Sep 2025 10:52:48 +0000 (GMT)
Message-ID: <63cf73f5ed8ceda0d68df416c2ba18334e7a9b83.camel@linux.ibm.com>
Subject: Re: [PATCH v4 11/34] lsm: get rid of the lsm_names list and do
 some cleanup
From: Mimi Zohar <zohar@linux.ibm.com>
To: Paul Moore <paul@paul-moore.com>
Cc: linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org, John Johansen <john.johansen@canonical.com>,
        Roberto Sassu <roberto.sassu@huawei.com>, Fan Wu <wufan@kernel.org>,
        =?ISO-8859-1?Q?Micka=EBl_Sala=FCn?=	 <mic@digikod.net>,
        =?ISO-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
        Kees Cook
 <kees@kernel.org>, Micah Morton <mortonm@chromium.org>,
        Casey Schaufler	
 <casey@schaufler-ca.com>,
        Tetsuo Handa
 <penguin-kernel@i-love.sakura.ne.jp>,
        Nicolas Bouchinet
 <nicolas.bouchinet@oss.cyber.gouv.fr>,
        Xiu Jianfeng <xiujianfeng@huawei.com>
In-Reply-To: <CAHC9VhSOhaB86yEV0+2HWRc3oYgZmLX+Nz3ERbohGRHeroKThA@mail.gmail.com>
References: <20250916220355.252592-36-paul@paul-moore.com>
	 <20250916220355.252592-47-paul@paul-moore.com>
	 <d514db2f7c1de9b6d9092ff2ad1ce4cdba286e83.camel@linux.ibm.com>
	 <CAHC9VhSOhaB86yEV0+2HWRc3oYgZmLX+Nz3ERbohGRHeroKThA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Sep 2025 06:52:48 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.54.3 (3.54.3-2.fc41) 
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=L50dQ/T8 c=1 sm=1 tr=0 ts=68d12a83 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=e1LNZ6x10KNBX6yl:21 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=xVhDTqbCAAAA:8 a=Yt5IGFHnr2jDG3FCesEA:9 a=QEXdDO2ut3YA:10
 a=Xy2LUYiHjMsA:10 a=8uXwW3QgYZ0A:10 a=ZXulRonScM0A:10
 a=GrmWmAYt4dzCMttCBZOh:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAxMCBTYWx0ZWRfXyyDaNV6T7CaU
 MMUmBJm3RcjcTh4NfEA4+GyUHcJqTa/VuvDeuMH5OqljMNIZVe0kyE5SLkFLoylGmkWdmWcxYzb
 MJf8isLeikt9oPhJKxYV3YSkb5lC0wiJr9bCYgiwJivdf970qxGYY/luR7G9P34gp5GaGvg/Q9C
 EDKzZKmZFisMhohOn8lDrYPXGRsecDZ0XHPmzDtkUPaTFD1C63Gc7m+g51VF/WSXI0ijtF/SZKj
 jBKOd9IeCdQoJz0/1NLGgrkDIX3CLrgD/9v0KhmGfPb6wXc1F/ct0jQB0fvXSIiOXRwwgIbQAWS
 BVmjphS/dJjE56FwVmFE+GNRCJLxdGFAWVjyY8EL7MOStmNlpC2UARvJUXqVMhhRojrA+Y2z2B6
 GFVnYXwP
X-Proofpoint-ORIG-GUID: tEhjr0P0ulCtjiWToiXabeOCCn-dvYUI
X-Proofpoint-GUID: utIOu00GY_2fVWhAugXHLKw5UBb5_6OI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-22_01,2025-09-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 phishscore=0 impostorscore=0 spamscore=0
 priorityscore=1501 suspectscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200010

On Sun, 2025-09-21 at 15:23 -0400, Paul Moore wrote:
> On Fri, Sep 19, 2025 at 3:16=E2=80=AFPM Mimi Zohar <zohar@linux.ibm.com> =
wrote:
> >=20
> > On Tue, 2025-09-16 at 18:03 -0400, Paul Moore wrote:
> > > The LSM currently has a lot of code to maintain a list of the current=
ly
> > > active LSMs in a human readable string, with the only user being the
> > > "/sys/kernel/security/lsm" code.  Let's drop all of that code and
> > > generate the string on first use and then cache it for subsequent use=
.
> > >=20
> > > Signed-off-by: Paul Moore <paul@paul-moore.com>
> >=20
> > FYI, checkpatch.pl complains of unbalanced braces, otherwise
>=20
> Looks good to me?
>=20
> % stg export --stdout lsm-lsm_names_cleanup | ./scripts/checkpatch.pl -
> total: 0 errors, 0 warnings, 139 lines checked
>=20
> Your patch has no obvious style problems and is ready for submission.

Try adding "--strict", which enforces
https://www.kernel.org/doc/html/v4.10/process/coding-style.html#placing-bra=
ces-and-spaces

Mimi

