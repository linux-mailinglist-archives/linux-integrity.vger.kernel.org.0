Return-Path: <linux-integrity+bounces-4538-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66062A0C136
	for <lists+linux-integrity@lfdr.de>; Mon, 13 Jan 2025 20:20:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D43A3A4A4F
	for <lists+linux-integrity@lfdr.de>; Mon, 13 Jan 2025 19:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB22A1C5D50;
	Mon, 13 Jan 2025 19:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Wo/rlrj1"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70341B86D5;
	Mon, 13 Jan 2025 19:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736796003; cv=none; b=fbz3TEtX114dS14sDd48DDpHXedmUrv3dctxSNb0GN+b0kRAcwhSbOKZjHYZ0moiYYwi/VhwiZGzXkl4pYKcExUbo6UypS8G3bQbZzx3mCecVOKses1WMC0y6NGuUdYIR4pBsnzVdv2TS2m5fTrMwcnhZ8wM0/GOKG9N5llvsC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736796003; c=relaxed/simple;
	bh=i00nt1pNQEzWalk7161BHLMJsuhcHpCi9Ja3fweC1OI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ssGvHQwX9co1ZQsYhHuG01dEsBXj/x3Yf+cjhyKs8k39Q8BRZKa5X2WjIgkKEHYyeetmPQndo9/jPZdOo+fUqnPi4hLShWu0k9vxruoeHQI/mD5tWFMVI+VzEbqkBYA6QIpm/ycYN9Vcv7QrH5r/XXr2rTB5f2bYrY6mULDs61M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Wo/rlrj1; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50DE2GfE024304;
	Mon, 13 Jan 2025 19:19:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=m32IFU
	xkT1rTF5Uw0esJDrL1j9HuYj+Xb9VayNk1u7s=; b=Wo/rlrj1Xdy9MWSdtAPZ+r
	v018wiBt3yrpwYIZkRAj77PzPkWgNdjPQnUlJFaO2EpEAFtNpwLVJ8plPvDVB0OO
	4ibZxOrqL55LdHXVX35FekOgG+oqOkNZYHiWHAh1+XcIy6kZkG+yVbqJkKTnvCW7
	7uRh/GGvb0tJXJL8vo/lTv8dscu1hoWhn+zm1otePvZ8ugpke28DlFX1L8Ghfdps
	cqfY6G5bc6XPWvENY9yGYbYEW17P2GloVAZA4/F0S/Umn5+Lox8v+hVvAgqyWbMq
	ivG1yrxhwkjX3kr2/ZrYsXyV8wkeJd5ZXUv+MJwotWL5ySp8i7hDIscr+tUXRtvg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 444qjamb2p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jan 2025 19:19:28 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50DJDBGl005611;
	Mon, 13 Jan 2025 19:19:27 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 444qjamb2m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jan 2025 19:19:27 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50DHv8hb016498;
	Mon, 13 Jan 2025 19:19:27 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4445p1fdh0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jan 2025 19:19:27 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50DJJQZp24838706
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Jan 2025 19:19:26 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 568055804B;
	Mon, 13 Jan 2025 19:19:26 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 43F8258068;
	Mon, 13 Jan 2025 19:19:24 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.32.139])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 13 Jan 2025 19:19:24 +0000 (GMT)
Message-ID: <d1b05612412a1d4b858662f296b45279c2141aa8.camel@linux.ibm.com>
Subject: Re: [PATCH V2] security: fix typos and spelling errors
From: Mimi Zohar <zohar@linux.ibm.com>
To: =?ISO-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>,
        Tanya Agarwal
	 <tanyaagarwal25699@gmail.com>
Cc: casey@schaufler-ca.com, takedakn@nttdata.co.jp,
        penguin-kernel@i-love.sakura.ne.jp, john.johansen@canonical.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        roberto.sassu@huawei.com, dmitry.kasatkin@gmail.com,
        eric.snowberg@oracle.com, mic@digikod.net, gnoack@google.com,
        stephen.smalley.work@gmail.com, omosnace@redhat.com,
        linux-kernel@vger.kernel.org, apparmor@lists.ubuntu.com,
        linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org,
        skhan@linuxfoundation.org, anupnewsmail@gmail.com
Date: Mon, 13 Jan 2025 14:19:23 -0500
In-Reply-To: <20250113.a860b47a11c7@gnoack.org>
References: <20250111.22fc32ae0729@gnoack.org>
	 <20250112072925.1774-1-tanyaagarwal25699@gmail.com>
	 <20250113.a860b47a11c7@gnoack.org>
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
X-Proofpoint-GUID: CHrURvGPGMhDDi_Atm7BrRFZJJw8-XxF
X-Proofpoint-ORIG-GUID: uamWymo0QXOEAqqQo8nNK2P81opZ7cIz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 malwarescore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 suspectscore=0 impostorscore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501130152

On Mon, 2025-01-13 at 15:50 +0100, G=C3=BCnther Noack wrote:
> On Sun, Jan 12, 2025 at 12:59:27PM +0530, Tanya Agarwal wrote:
> > From: Tanya Agarwal <tanyaagarwal25699@gmail.com>
> >=20
> > Fix typos and spelling errors in security module comments that were
> > identified using the codespell tool.
> > No functional changes - documentation only.
> >=20
> > Signed-off-by: Tanya Agarwal <tanyaagarwal25699@gmail.com>
> > ---
> > Thanks G=C3=BCnther, for catching this error.
> > The irony of having a spelling mistake in a patch that fixes spelling
> > mistakes is not lost on me :)=20
> >=20
> > I've fixed it in V2 of the patch. Thank you for the careful review!
> >=20
> > V2: fix spelling mistake - s/beeen/been/=20
> >=20
> > =C2=A0security/apparmor/apparmorfs.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 6 =
+++---
> > =C2=A0security/apparmor/domain.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 | 4 ++--
> > =C2=A0security/apparmor/label.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 | 2 +-
> > =C2=A0security/apparmor/lsm.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 2 +-
> > =C2=A0security/apparmor/policy.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 | 4 ++--
> > =C2=A0security/integrity/evm/evm_crypto.c | 2 +-
> > =C2=A0security/integrity/evm/evm_main.c=C2=A0=C2=A0 | 2 +-
> > =C2=A0security/integrity/ima/ima_main.c=C2=A0=C2=A0 | 6 +++---
> > =C2=A0security/landlock/ruleset.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 2 +-
> > =C2=A0security/selinux/avc.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 2 +-
> > =C2=A0security/smack/smack.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 2 +-
> > =C2=A0security/smack/smack_access.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 | 4 ++--
> > =C2=A0security/smack/smack_lsm.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 | 6 +++---
> > =C2=A0security/smack/smackfs.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 2 +-
> > =C2=A0security/tomoyo/domain.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 2 +-
> > =C2=A015 files changed, 24 insertions(+), 24 deletions(-)
> >=20
>=20
> [...]
>=20
> > diff --git a/security/integrity/ima/ima_main.c
> > b/security/integrity/ima/ima_main.c
> > index 9b87556b03a7..cdb8c7419d7e 100644
> > --- a/security/integrity/ima/ima_main.c
> > +++ b/security/integrity/ima/ima_main.c
> > @@ -983,9 +983,9 @@ int process_buffer_measurement(struct mnt_idmap *id=
map,
> > =C2=A0	}
> > =C2=A0
> > =C2=A0	/*
> > -	 * Both LSM hooks and auxilary based buffer measurements are
> > -	 * based on policy.=C2=A0 To avoid code duplication, differentiate
> > -	 * between the LSM hooks and auxilary buffer measurements,
> > +	 * Both LSM hooks and auxiliary based buffer measurements are
> > +	 * based on policy. To avoid code duplication, differentiate
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 ^^^
>=20
> (Small nit:) This change from two-spaces-after-the-dot to a single
> space looks like it happened accidentally.=C2=A0 The two-space style is
> dominant in the ima_main.c file.
>=20
> (However, I am not involved in IMA and others have more authority to
> review this part.=C2=A0 As Paul also said, reviews tend to go smoother wh=
en
> the scope for the patch is a single subsystem - it makes the
> responsibilities clearer.)
>=20
> > +	 * between the LSM hooks and auxiliary buffer measurements,

The spelling mistake being corrected in two places is auxilary -> auxiliary=
.  Thank
you for noticing the unnecessary change from two spaces to one space as wel=
l.

FYI, I agree with Paul the patch should be split.

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>


> > =C2=A0	 * retrieving the policy rule information only for the LSM hook
> > =C2=A0	 * buffer measurements.
> > =C2=A0	 */
>=20
> =E2=80=93G=C3=BCnther


