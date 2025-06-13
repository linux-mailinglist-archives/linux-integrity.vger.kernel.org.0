Return-Path: <linux-integrity+bounces-6449-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 559C9AD967F
	for <lists+linux-integrity@lfdr.de>; Fri, 13 Jun 2025 22:36:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 878DE3BC004
	for <lists+linux-integrity@lfdr.de>; Fri, 13 Jun 2025 20:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A6AB24BD0C;
	Fri, 13 Jun 2025 20:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EVdLv17X"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E761825A333;
	Fri, 13 Jun 2025 20:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749846928; cv=none; b=OAuCU6O/xOjPiVeBqSrxxRXu7OdxhUXgDFIO0xyytl8OjZ9SRLIzAHzUm+MnJUpiLXYTeID4/IgAsVwsdoWkVozJlEt0YMUnEqkwKh+LM56CROKwIREtKNcvVj2KtY2bCTQKDDHT27cEhagsV3bpplnveMTGgHqaJTmpvfURn0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749846928; c=relaxed/simple;
	bh=V1jCsXngTtJvAEzXv7vsil4xncAYb7+S++eg7D17lMw=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=K9oqe7GvO9tOuregbV1sKAEtN7X5j7UMu8Oxe6iNaPMfSAhEDt3t1Nr+Rgcnykr+O+Tp9bq4upd9xLdFgRl+8QErkEoDIWAhcby/C68ph4bXWGu8+68lfcb4Aa6XHRqNcIpgFSyVkzgA9JaDm2SapBW992xXV73hRykMrSaAM3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=EVdLv17X; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55DJAq3Y030944;
	Fri, 13 Jun 2025 20:35:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=gpIonl
	jNp8yCoYn7R8AlY5k7J5ldvAlDebUGV7HIwnI=; b=EVdLv17XbXtgsn68lI+K5w
	qKgg3mD4aFUYHMiQuTxW9VixlC+ZjgyBsyj8G6uHzInyGQqeh3h+ltNxqE/7jtJm
	uNDXJWqeLNtz41QuBzqm7tO48oYudLRI7FEQQzKPNeY8NyUBm9c0uTORejk4UKCw
	N20a9cO7Xdi/8piShdDSLhEz5OPWMP9krSjziE4rAV9wP485PfyyWW+lqknDOjNQ
	DlMFmrUeVHjReFbGkIEhTIudMPB1biNbOj15nZEA3Jk8JkPANp5s9HQ6M/kQrK/P
	v+8Qb9fsNa0UPKWtvNOaBnJ5myD4Hl/huetrtfLpSOAcsR0lruVVT2PHdu1YgyWQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 474dv838wd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Jun 2025 20:35:01 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 55DKW43S015685;
	Fri, 13 Jun 2025 20:35:00 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 474dv838wa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Jun 2025 20:35:00 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55DHkYOo022352;
	Fri, 13 Jun 2025 20:34:59 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 475050bwp4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Jun 2025 20:34:59 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55DKYs6j20382328
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Jun 2025 20:34:54 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A114F5803F;
	Fri, 13 Jun 2025 20:34:58 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C47E458056;
	Fri, 13 Jun 2025 20:34:57 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.101.213])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 13 Jun 2025 20:34:57 +0000 (GMT)
Message-ID: <ae5e62722e238f55315b7ce523f7d2eb3af5e063.camel@linux.ibm.com>
Subject: Re: [RFC PATCH 25/29] ima,evm: move initcalls to the LSM framework
From: Mimi Zohar <zohar@linux.ibm.com>
To: Paul Moore <paul@paul-moore.com>, David Howells <dhowells@redhat.com>
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
        Eric Snowberg
 <eric.snowberg@oracle.com>
In-Reply-To: <CAHC9VhTfNQeu3gcWii7kUrGY+fVygXs6j4UhybodPqjuSzA-pQ@mail.gmail.com>
References: <20250409185019.238841-31-paul@paul-moore.com>
	 <20250409185019.238841-56-paul@paul-moore.com>
	 <12d9ea5981f5a2c33a01798311543db2e9bd4ee3.camel@linux.ibm.com>
	 <CAHC9VhTfNQeu3gcWii7kUrGY+fVygXs6j4UhybodPqjuSzA-pQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Jun 2025 16:34:57 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: iNIJM6qMf0-2b67n-QsfZZ9QIGJKK6O-
X-Proofpoint-GUID: SnEw9RzY2I7Vv3ptpdqioiYgQPsQFJ6v
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEzMDE0MiBTYWx0ZWRfXwULc2+xj45Bz QuzPQoXsEHRZ3Z137rOwZA14dbt7mx7wCMnTA6AW+vJBg5ELaniJ2pVsGv2Eqw9Kh5SyKNeB1xU WzupmwElTJDnRSSg25qrO6GMgHoFC/14JYAZ6Lhm8nrinSDzrgVvCxbMusyq9Uyt0fSxzl3QKcT
 h8MDj4N/Mskq/NvpTJxpD4DjYtnKe7GuABa4qyOoQXcUa2ok2qJ6zIiSWc2QrT/oRWzkhWYcncL zaImdNgVmjr3OLVJfrw9YPmcLaqiYAII3oOzKKzERaFT6/PObTDQYBC6SVH7FUzqt9+1cT3UHUx WZDfyxauXLj7jTa2i895LkuefbCFo2eQSQqcVadgZg5dctIHP3RaF5CPhmqzQYWffzrXkXH8QX2
 tbMmlMfc75iR67UQ/aakt27L4OhX5xdc21ucCCTnr7qihiFqBbaizHtBf/FoMzQzZ35zdjPN
X-Authority-Analysis: v=2.4 cv=CfMI5Krl c=1 sm=1 tr=0 ts=684c8b75 cx=c_pps a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8 a=tiGqyuVAyrAc4NrlPAYA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-13_03,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 phishscore=0 priorityscore=1501 clxscore=1015 impostorscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506130142

On Wed, 2025-06-11 at 16:27 -0400, Paul Moore wrote:
> On Fri, May 30, 2025 at 6:04=E2=80=AFPM Mimi Zohar <zohar@linux.ibm.com> =
wrote:
> > On Wed, 2025-04-09 at 14:50 -0400, Paul Moore wrote:
> > > This patch converts IMA and EVM to use the LSM frameworks's initcall
> > > mechanism.  There were two challenges to doing this conversion: the
> > > first simply being the number of initcalls across IMA and EVM, and th=
e
> > > second was the number of resources shared between the two related,
> > > yet independent LSMs.
> >=20
> > There are a number of the initcalls under integrity/platform/, which lo=
ad arch
> > specific keys onto the platform and machine keyrings, which shouldn't b=
e
> > included in this patch.
>=20
> I don't want to assume too much from your reply, but if the cert/key
> loading under integrity/platform shouldn't be subject to the LSM
> initcall rework, that implies that the integrity/platform cert/key
> loading is independent of IMA/EVM and should perhaps live somewhere
> else, e.g. security/keys?
>=20
> Or am I misunderstanding something?

When the .platform keyring was upstreamed it was upstreamed for a very spec=
ific
purpose so that IMA could verify the kexec kernel image.  Afterwareds it wa=
s
immediately used to verify the pesigned kexec image.  Now it is being (ab)u=
sed
by other subsystems - ipe and dm-verity - and is being proposed by the "[PA=
TCH
RFC 0/1] module: Optionally use .platform keyring for signatures verificati=
on".
From an integrity perspective this is definitely not a good idea.  The
discussion, which I'm sure you're aware of, is here:
https://lore.kernel.org/linux-integrity/20250602132535.897944-1-vkuznets@re=
dhat.com/

It does not make any sense to move the code for the platform and machine
keyrings to security/keys.  If they need to move anywhere, it would be to t=
he
certs/ directory.

>=20
> > > The first problem was resolved by the creation of two new functions,
> > > integrity_device_init() and integrity_late_init(), with each focused =
on
> > > calling all of the various IMA/EVM initcalls for a single initcall ty=
pe.
> > > The second problem was resolved by registering both of these new
> > > functions as initcalls for each LSM and including code in each
> > > registered initcall to ensure it only executes once.
> >=20
> > With the above change, there obviously will be a lot fewer initcalls, b=
ut it
> > might still make sense to keep the common ima/evm function.
>=20
> I'm not sure I understand, what do you mean by "common ima/evm
> function"?  This patch doesn't remove any IMA/EVM functions, it adds
> the integrity_device_init() and integrity_late_init() functions to
> setup and populate some keyrings.

"The above change" refers to not including the platform and the arch specif=
ic
calls or machine keyring initcalls.  By not including them, there are a lot
fewer initcalls in this ima,evm patch.

Mimi


