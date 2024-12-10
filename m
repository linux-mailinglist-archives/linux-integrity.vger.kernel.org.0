Return-Path: <linux-integrity+bounces-4335-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E42AA9EB6FF
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Dec 2024 17:49:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F186168CCC
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Dec 2024 16:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 726FA230D01;
	Tue, 10 Dec 2024 16:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sj/piHTU"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6D978F5A;
	Tue, 10 Dec 2024 16:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733849303; cv=none; b=W4cWOz/435CQ/fcmbqwENvriiyJzL32ibib+iJHOeabyrLRy6aXPB6TcKhDtnZfsbP/J/I93KupzYrYeN0AQ6rvOy/5iIeudRL0X3dcuzYR6tW91eOorrgUZqUFJ8rW3LWOK3OPFWXlJSBXQxGktZheg8FKM4uN8HIALVB+bbxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733849303; c=relaxed/simple;
	bh=CDmWz5CiCJkhk/84wx4DIhxG+Go5pfa/hXNPyS+mkCs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bSlBbXnugkzk1YgmILd6JH2i0g1lRdEvBF7cLgPAlrnM9oilSlKoeroI3jqSzNgeQ0S+gtpq4l/m7z3A9jzhnkJ4pxvxuTYbkNWwUTdNBNxq9WN56HrW+ZOMq6gg8/LMNkBp6mqhqSL0V1wQdcTKjIzqd05kLhdk+e3pK3iNPDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sj/piHTU; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BADrZHH004001;
	Tue, 10 Dec 2024 16:47:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=y7ps4y
	jzkZ/XtpKHNj+sd4uVbzn3335JijmLLbvAbDs=; b=sj/piHTU1zd8XuP3cPux/1
	nt9tjYfZZyQnHYz3A2vr9VKQhuYytAOUGFAtgxinf7W074xL3dNrnROnnbdDqbEm
	CrT+xK56u3JERZpicUunH5R1omEhPk/NCg9Sl9HB6CtrZ9LWxIe+JcEtqgU0yD+Y
	Az2Fbrylw2v2c2rk1qwiWXQ9fqrurjV4DHwypU/hbYBTBFcpsN2yMsFvpuZgznK5
	xKw05DsIR0Dsrfeuteosjx+C1HRJ7gD+sGvjPf/Rr2u/F9jicfs6Bfe5OljedvsU
	NoiAFSEe5SYEyXAzLTPM9bgDFChzA1pkzE6b+OBXaarVlyXatrQ/3WxpF9DoZYLA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43ce0xf5pc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Dec 2024 16:47:57 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BAD28MJ017421;
	Tue, 10 Dec 2024 16:47:57 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 43d3d1m4xj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Dec 2024 16:47:57 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BAGludf22545120
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Dec 2024 16:47:56 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 519B958059;
	Tue, 10 Dec 2024 16:47:56 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5C63458053;
	Tue, 10 Dec 2024 16:47:55 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.160.242])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 10 Dec 2024 16:47:55 +0000 (GMT)
Message-ID: <983114dbf101b0df7d61a31af002783d06fc963d.camel@linux.ibm.com>
Subject: Re: [PATCH v2] ima: instantiate the bprm_creds_for_exec() hook
From: Mimi Zohar <zohar@linux.ibm.com>
To: =?ISO-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: Paul Moore <paul@paul-moore.com>, linux-integrity@vger.kernel.org,
        roberto.sassu@huawei.com, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jeff Xu <jeffxu@chromium.org>,
        Kees Cook
	 <kees@kernel.org>, audit@vger.kernel.org
Date: Tue, 10 Dec 2024 11:47:54 -0500
In-Reply-To: <20241210.Wie6ion7Aich@digikod.net>
References: <20241204192514.40308-1-zohar@linux.ibm.com>
	 <282573d0ea82ac71c8305d0c8cc89083@paul-moore.com>
	 <b6dc4d8b23b822638ab676055809503060c0bca2.camel@linux.ibm.com>
	 <20241210.Wie6ion7Aich@digikod.net>
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
X-Proofpoint-GUID: COmalQii4v1ua8ESt7Q21uSSxSkETcMb
X-Proofpoint-ORIG-GUID: COmalQii4v1ua8ESt7Q21uSSxSkETcMb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 clxscore=1011 impostorscore=0 mlxscore=0 mlxlogscore=538
 priorityscore=1501 malwarescore=0 adultscore=0 bulkscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412100122

On Tue, 2024-12-10 at 17:34 +0100, Micka=C3=ABl Sala=C3=BCn wrote:
> > > > +++ b/include/uapi/linux/audit.h
> > > > @@ -161,6 +161,7 @@
> > > > =C2=A0 #define AUDIT_INTEGRITY_RULE	=C2=A0=C2=A0=C2=A0 1805 /* poli=
cy rule */
> > > > =C2=A0 #define AUDIT_INTEGRITY_EVM_XATTR=C2=A0=C2=A0 1806 /* New EV=
M-covered xattr */
> > > > =C2=A0 #define AUDIT_INTEGRITY_POLICY_RULE 1807 /* IMA policy rules=
 */
> > > > +#define AUDIT_INTEGRITY_DATA_CHECK=C2=A0 1808 /* Userspace enforce=
d data integrity */
> > >=20
> > > I worry that "DATA_CHECK" is a bit vague, should we change the name s=
o
> > > that there is some hint of either userspace enforcement or
> > > AT_EXECVE_CHECK?
> > >=20
> > > What about AUDIT_INTEGRITY_DATA_USER?
> >=20
> > The emphasis should be on userspace - AUDIT_INTEGRITY_USERSPACE.
>=20
> Looks good, I'll send a new patch series with this change, following
> https://lore.kernel.org/all/20241205160925.230119-9-mic@digikod.net/

Sound good!  Thank you.

Mimi

