Return-Path: <linux-integrity+bounces-5001-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 588B0A4734A
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Feb 2025 04:06:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC6401889CD3
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Feb 2025 03:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49E5E78F4B;
	Thu, 27 Feb 2025 03:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hql5laKQ"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D832B9B7
	for <linux-integrity@vger.kernel.org>; Thu, 27 Feb 2025 03:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740625592; cv=none; b=cRbzrxx341tBiHiPOq1jJLvJ4mQ/4JnFkSD6Yi3Jwm79VXTvHNQdsm7aZ8hPiz//xaVG35BpLKc3dWd7ymoay9+9go9uqwZbgYqaJ5tXhQJBFVASEU1kGy/9Mj7YGVovIPstvXx4/RknKPsjqRP68Dkw228Lqf7D66mphERyo/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740625592; c=relaxed/simple;
	bh=fs5JOq8EoyeCp8CJngEL87ej2Nvlki8xcQdmGXGsX7M=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IIzMSPPUOeSNvl8Za65xqPyh9P05OvQUsWEcPvqloevuFw33TzfsF+Qj/4ySSNJJUcam5UChoC2Q0EYa4BMtKVKMlOoo5tdxD7HHoPOatjDb+CGWln8edq7RXEz7Uu4V3E7vrno0RX2hE8T53QkZaEkkb8T8k9NNdhlcxzOIbfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hql5laKQ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51R1FnSw005907;
	Thu, 27 Feb 2025 03:05:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=2shAvC
	Ll1tKRcLsKWcNEIu/nsZ1bxf0DxAJbkxGIFaY=; b=hql5laKQE1UjZeKw4h0yk2
	VCg+em5AFqLT1yDeHZImmTnwMt3y9Uw/rHC5Uz2nY0txCb3z7OYaCkmSNU6Wv4fM
	0FvNHpz7ANynw0sYTmRTKeuKlhrqaZl4LBpxKea/96GRRfzbJ0/pejK2g5jH//Uz
	UZltFOrczZ59LF0i5jlFBvG8JeAEiQdRXHOl9fx7njYeHTJN+dpRbOlGxdRrUxcx
	SCNrVllvXnYgDW56szALTzGeGN3k/P+J92o5tpil9ruC7pLsbS8hc+PU5pL230T1
	uHVFLzSbOB+8n89tx69OfIYyPyyDDmpgR1CTv7jUd+BEHEeTd5BwZ4IpIfOCiYAg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 451xnp52gf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Feb 2025 03:05:17 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 51R35HW2014717;
	Thu, 27 Feb 2025 03:05:17 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 451xnp52gd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Feb 2025 03:05:17 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51R1l5Bw026287;
	Thu, 27 Feb 2025 03:05:16 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44yswnpbxk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Feb 2025 03:05:16 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51R35FQh32047868
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Feb 2025 03:05:15 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B48E55806B;
	Thu, 27 Feb 2025 03:05:15 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 451385805A;
	Thu, 27 Feb 2025 03:05:15 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.102.129])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 27 Feb 2025 03:05:15 +0000 (GMT)
Message-ID: <9fb7a98bb88c05d953fd90c84c78af0bbd58df9b.camel@linux.ibm.com>
Subject: Re: [RFC][PATCH] ima: add measurement for first unverified write on
 ima policy file
From: Mimi Zohar <zohar@linux.ibm.com>
To: Enrico Bravi <enrico.bravi@polito.it>,
        "roberto.sassu@huawei.com"
	 <roberto.sassu@huawei.com>,
        "linux-integrity@vger.kernel.org"
	 <linux-integrity@vger.kernel.org>,
        "dmitry.kasatkin@gmail.com"
	 <dmitry.kasatkin@gmail.com>
Cc: "eric.snowberg@oracle.com" <eric.snowberg@oracle.com>
Date: Wed, 26 Feb 2025 22:05:14 -0500
In-Reply-To: <013864bca0b53d65b9546125090c8d7776ee565a.camel@polito.it>
References: <20250225131255.154826-1-enrico.bravi@polito.it>
	 <ecc4630b5e3161736aa1e32f037facb9123025fc.camel@linux.ibm.com>
	 <013864bca0b53d65b9546125090c8d7776ee565a.camel@polito.it>
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
X-Proofpoint-ORIG-GUID: ZgWmrzsH9WDK4otaEWiiQcOCVcs6XeuE
X-Proofpoint-GUID: lhjvXmGZ7dwPZtOY5CZzx35JTPJy2Jmo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-27_01,2025-02-26_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 suspectscore=0 mlxlogscore=999 spamscore=0 phishscore=0
 mlxscore=0 adultscore=0 malwarescore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502270022

On Wed, 2025-02-26 at 22:53 +0000, Enrico  Bravi wrote:
> On Tue, 2025-02-25 at 20:53 -0500, Mimi Zohar wrote:
> > On Tue, 2025-02-25 at 14:12 +0100, Enrico Bravi wrote:
> > > The first write on the ima policy file permits to override the defaul=
t
> > > policy defined with the ima_policy=3D boot parameter. This can be don=
e
> > > by adding the /etc/ima/ima-policy which allows loading the custom pol=
icy
> > > during boot. It is also possible to load custom policy at runtime thr=
ough
> > > file operations:
> > >=20
> > > cp custom_ima_policy /sys/kernel/security/ima/policy
> > > cat custom_ima_policy > /sys/kernel/security/ima/policy
> > >=20
> > > or by writing the absolute path of the file containing the custom pol=
icy:
> > >=20
> > > echo /path/of/custom_ima_policy > /sys/kernel/security/ima/policy
> > >=20
> > > In these cases, file signature can be necessary to load the policy
> > > (func=3DPOLICY_CHECK). Custom policy can also be set at runtime by di=
rectly
> > > writing the policy stream on the ima policy file:
> > >=20
> > > echo -e "measure func=3DBPRM_CHECK mask=3DMAY_EXEC\n" \
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0"audit func=3DBPRM_CH=
ECK mask=3DMAY_EXEC\n" \
> > > =C2=A0=C2=A0=C2=A0=C2=A0 > /sys/kernel/security/ima/policy
> > >=20
> > > In this case, there is no mechanism to verify the integrity of the ne=
w
> > > policy.
> > >=20
> > > Add a new entry in the ima measurements list containing the ascii cus=
tom
> > > ima policy buffer when not verified at load time.
> > >=20
> > > Signed-off-by: Enrico Bravi <enrico.bravi@polito.it>
> >=20
> > Hi Enrico,
>=20
> Hi Mimi,
>=20
> thank you for the quick response.
>=20
> > This patch set hard codes measuring the initial custom IMA policy rules=
 that
> > replace the builtin policies specified on the boot command line.=C2=A0 =
IMA
> > shouldn't hard code policy.
>=20
> My first approach was to define a new critical-data record,=C2=A0

Hopefully the new critical-data will be of the entire IMA policy.

> but performing the
> measurement after the custom policy becomes effective, the measurement co=
uld be
> bypassed omitting func=3DCRITICAL_DATA in the custom policy.
>=20
> > I'm not quite sure why you're differentiating between
> > measuring the initial and subsequent custom IMA policy rules.=C2=A0=C2=
=A0
>=20
> My intention is to measure the first direct write (line by line) on the p=
olicy
> file, without loading the initial custom policy from a file. This case, i=
f I'm
> not wrong, is not covered by func=3DPOLICY_CHECK.

When secure boot is enabled, the arch specific policy rules require the IMA
policy to be signed.  Without secure boot enabled, you're correct. The cust=
om
policy rules may directly be loaded without being measured.

Why only measure "the first direct write"?  Additional custom policy rules =
may
be directly appended without being measured.

>=20
> > Consider defining a new critical-data record to measure the current IMA=
 policy
> > rules.=C2=A0 Also consider including the new critical-data rule in the =
arch
> > specific policy rules.
>=20
> I think that your suggestion, to add the critical-data rule in the arch p=
olicy
> rules, solves the problems of bypassing the measurement and hard coding p=
olicy.
>=20
> Thank you very much for your feedback.

You're welcome.

Mimi
>=20

