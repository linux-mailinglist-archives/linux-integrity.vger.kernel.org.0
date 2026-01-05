Return-Path: <linux-integrity+bounces-8166-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C088ACF5CA8
	for <lists+linux-integrity@lfdr.de>; Mon, 05 Jan 2026 23:15:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3D722300C35C
	for <lists+linux-integrity@lfdr.de>; Mon,  5 Jan 2026 22:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 042A121D3F8;
	Mon,  5 Jan 2026 22:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="O3ak6mfQ"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4138A4400;
	Mon,  5 Jan 2026 22:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767651345; cv=none; b=CZYu2bu4zWDs15am9bNqXQ960JI98W0xr1wJHejO923pggVBQSp+D4R/5tGUEyQA0ba2ug1zH7R4EK5SK8WwQavREQ4F3jIrjNzhHN6X0G19m4PquLq7joybmmExeS3hCjqbPs/oxSLfXIWegokBT7q3nuaMYMa4xpqqqGjZBYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767651345; c=relaxed/simple;
	bh=dIMpzg53lbeHFbzg7iu1NoK13wOaoOgOxjIGmtH/im4=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=F8sR91Z8FbedRC88JDgLSTYt3LJiCfdFxDKcDXVccE5WUmfy0P1ISGTTZz9HXVrH+GCi/YR91iyiBxihmo9XCJ+UqS86Wkz4jgyak7ZOuwkq9eRKELBrR/21d53p4tb31yuq9wGEl/36zLcngUD3+tDlN9eZW/SXnO7D6fbdyDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=O3ak6mfQ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 605DNq4F025314;
	Mon, 5 Jan 2026 22:15:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=0LEeQI
	geAzRC3jFgjw5Mo+ThfW1movurS6vLpC+EdCk=; b=O3ak6mfQxJKfrDvSfCVUQA
	j8xHTqFk6lSiZTc4/5RpALX0pRd91q0aWMc/6y5US/Yu3uyCYt8/hurve3ctVWIy
	vTrL0KDBJKNiETLNbH2yMg/9mGwblE1rOVA6Trw28PMd+Er8gmJ6IylN/z/gi5/o
	VYkp87ORrVWlJSThnYrO1r8tmr/1jBRMBjlUll3oufa6eewbziX5Oa2paunMUHAP
	FqUL7fJd0wvcw9BACJQLXEM/a3mjDvsRm0bayDoHKsUZ8NEFnVGqGzdruH2xMloO
	oDu9tHsYGBCDT7wcP7GwVHqW9pV/8kFQ0Hj3g5z2cA26rjdo0mp3sQnVc+ecpo5g
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4betrtgpgu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Jan 2026 22:15:18 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 605MBAvg023316;
	Mon, 5 Jan 2026 22:15:17 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4betrtgpgt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Jan 2026 22:15:17 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 605KhfsV005210;
	Mon, 5 Jan 2026 22:15:17 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4bfexk07w1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Jan 2026 22:15:17 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 605MFGHE59834694
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 5 Jan 2026 22:15:17 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9998C58056;
	Mon,  5 Jan 2026 22:15:16 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8BECF58052;
	Mon,  5 Jan 2026 22:15:15 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.32.202])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  5 Jan 2026 22:15:15 +0000 (GMT)
Message-ID: <4a4778ff395e533cad86ff3ffbf0ba90c3eb8798.camel@linux.ibm.com>
Subject: Re: [PATCH RFC] ima: Fallback to a ctime guard without i_version
 updates
From: Mimi Zohar <zohar@linux.ibm.com>
To: Frederick Lawler <fred@cloudflare.com>,
        Roberto Sassu	
 <roberto.sassu@huawei.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Eric Snowberg <eric.snowberg@oracle.com>,
        Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn"	 <serge@hallyn.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christian Brauner	
 <brauner@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>, Jeff Layton	
 <jlayton@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, kernel-team@cloudflare.com
In-Reply-To: <20251229-xfs-ima-fixup-v1-1-6a717c939f7c@cloudflare.com>
References: <20251229-xfs-ima-fixup-v1-1-6a717c939f7c@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 05 Jan 2026 17:15:15 -0500
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.54.3 (3.54.3-2.fc41) 
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=aaJsXBot c=1 sm=1 tr=0 ts=695c37f6 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EG7W4yiQAAAA:8 a=R52Hk5ivK_uCdHmPRCcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: cAzKqfQGoH-eG5yRopbqa_UdJK4IEdsu
X-Proofpoint-ORIG-GUID: WEINdELwkBWCjPPiIoQwInaqreiOPcKI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA1MDE5MCBTYWx0ZWRfX0qrPlm9AlG5Q
 GoWz7xvnnNu7LaU6j8BnuFI1pXqOQriVuVRf+l7pXl6pGhkPtw7/BmG5Hfx1cdi9cn/eUamzIB+
 5+DISevecjGUmZYOOaMjTaEMhp+XZRyV+U5/0X2gzwwmgu6JWugIn20/jykWcUqYc3fYlhAimsk
 g6a+Ir1hq5f1mVtAcyCrRC6w6LP4NaDfWx5Q8wpIK1zQAVB8FVK6oUadCgGf15BVAHW6Y4XErL5
 CmY2jf8TpN9KC4F78ZCYtofqNGI4GYlho6vrPIDQ3mo1fAaBHgw+P+U+eKEPZ7bF/CyKv820a6M
 gzEBCYLFHa9CE58myA+y3122U7SgazwgqSivEWZ4wmfJglX90Iw7Gnkz7o5vVfKAx9lQYJywTU/
 a7okbl6a3O5bzr68jp09SYhCpz8vC8QBwinv5nXzK9iyBYZZIdTy38MbmZzoXpVjCNWcSSyKZpy
 7jby+VWxbwzLHvNDHUA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-05_02,2026-01-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 priorityscore=1501 clxscore=1011 phishscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2512120000 definitions=main-2601050190

On Mon, 2025-12-29 at 11:52 -0600, Frederick Lawler wrote:
> Since commit 1cf7e834a6fb ("xfs: switch to multigrain timestamps"), IMA
> is no longer able to correctly track inode.i_version due to the struct
> kstat.change_cookie no longer containing an updated i_version.
>=20
> Introduce a fallback mechanism for IMA that instead tracks a
> integrity_ctime_guard() in absence of or outdated i_version
> for stacked file systems.

Thanks, Frederick.

Instead of using the new function name integrity_ctime_guard() to describe =
the
change, please describe the change in words.  Perhaps something like: rely =
on
the inode's ctime to detect a file data or metadata change.

The purpose of generating a ctime guard value, as opposed to using the tv_s=
ec
and tv_nsec, I assume is to minimize the amount of memory being saved in th=
e
iint.

>=20
> EVM is left alone since it mostly cares about the backing inode.
>=20
> Link: https://lore.kernel.org/all/aTspr4_h9IU4EyrR@CMGLRV3
> Fixes: 1cf7e834a6fb ("xfs: switch to multigrain timestamps")
> Suggested-by: Jeff Layton <jlayton@kernel.org>
> Signed-off-by: Frederick Lawler <fred@cloudflare.com>
> ---
> The motivation behind this was that file systems that use the
> cookie to set the i_version for stacked file systems may still do so.
> Then add in the ctime_guard as a fallback if there's a detected change.
> The assumption is that the ctime will be different if the i_version is
> different anyway for non-stacked file systems.

Agreed. This patch inverts the i_version test to return immediately if the
i_version hasn't changed and then checks the ctime guard value.  Is the cti=
me
guard value test simply a performance improvement?

>=20
> I'm not too pleased with passing in struct file* to
> integrity_inode_attrs_changed() since EVM doesn't currently use
> that for now, but I couldn't come up with another idea to get the
> stat without coming up with a new stat function to accommodate just
> the file path, fully separate out IMA/EVM checks, or lastly add stacked
> file system support to EVM (which doesn't make much sense to me
> at the moment).
>=20
> I plan on adding in self test infrastructure for the v1, but I would
> like to get some early feedback on the approach first.

I really appreciate your adding a self test.

thanks,

Mimi

