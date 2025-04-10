Return-Path: <linux-integrity+bounces-5783-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E4CBA84BC7
	for <lists+linux-integrity@lfdr.de>; Thu, 10 Apr 2025 20:04:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 434FB19E6974
	for <lists+linux-integrity@lfdr.de>; Thu, 10 Apr 2025 18:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 435811E991A;
	Thu, 10 Apr 2025 18:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qGTU0oUV"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8953C4503B;
	Thu, 10 Apr 2025 18:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744308288; cv=none; b=RBvbSM+SpDy9NqTpsgNb9Dn/ZgEPIybjZ5hdp4ye+URG+DoWr53Ba7wHlwpmRP8W9WreXxBbDbZ55G0ABTjoae2bOYx1xGYUMw5D6Y66uYQGS2wG82hcXJ1+vmcgx7jfe2rY//uyDHYOqKfOAOQ4wMpx8m/VUSgEXC454r9/YQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744308288; c=relaxed/simple;
	bh=jWt77GgIvrO7HDBTaqFl74YPeT0HlqlFULfLHD08aCA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZsijoSuuP01xqOZfBUXMd9bOjHxuIP3LfLUMcrpLYm64qSqW1oWQf7E6wQknXwhVi9iyc5yGZWYniCSF9jLY56WhHUMi4ehBOVqE7VlIHlW9qUtarnCR3ppcoabt7FFDnzYC786e/iOJ6Vv6BjDeCBhlA599Bb557P0nwTxvP6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qGTU0oUV; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53AEFx6k004797;
	Thu, 10 Apr 2025 18:04:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=/rmo8P
	L7AP6+c3XqmgbJzb4sX5ESJQbg1hSW/zInAWo=; b=qGTU0oUV5Pe3c4+TB/5KXR
	HnAePl6c7+frGv2tGepJM6E1PZm138dHco79T5g8cnK2UuDjxH82bvzg875kipRD
	G3UKSKY5ktJ4YrMj4/3/bR0LYh+2RPKCrtpnOFLOh3Yb0SF3BnXP99rt0vT+Z0ZC
	FdSNdnduqhIWQ7SvGmVO6/MtEgWRZ+PDPDASZEqhgfjuKohOdeY1t9pqEcdskk8B
	RjQDzHfXtHLsisYc+pnqWfJ0vcS7Vtg5CWvZau9UXz7BEO9goCm/d41b8/4HO7U4
	19fkJ9jUXtv7r3Y/2i2NOv9uQi9Zf73l9wZtwaQUxDb4SDIr+TcILf0gEmeWJ81A
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45x0406cf8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Apr 2025 18:04:21 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53AGBX0R024577;
	Thu, 10 Apr 2025 18:04:20 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 45ueutqg75-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Apr 2025 18:04:20 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53AI4GsQ29950464
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Apr 2025 18:04:17 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F33C258056;
	Thu, 10 Apr 2025 18:04:18 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1A9F058052;
	Thu, 10 Apr 2025 18:04:18 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.31.96.173])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 10 Apr 2025 18:04:18 +0000 (GMT)
Message-ID: <8120a7b1eafaa5452981484671e841a7a7872877.camel@linux.ibm.com>
Subject: Re: [PATCH v11 8/9] ima: make the kexec extra memory configurable
From: Mimi Zohar <zohar@linux.ibm.com>
To: steven chen <chenste@linux.microsoft.com>, Baoquan He <bhe@redhat.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Cc: stefanb@linux.ibm.com, roberto.sassu@huaweicloud.com,
        roberto.sassu@huawei.com, eric.snowberg@oracle.com,
        ebiederm@xmission.com, paul@paul-moore.com, code@tyhicks.com,
        bauermann@kolabnow.com, linux-integrity@vger.kernel.org,
        kexec@lists.infradead.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, madvenka@linux.microsoft.com,
        nramas@linux.microsoft.com, James.Bottomley@hansenpartnership.com,
        vgoyal@redhat.com, dyoung@redhat.com
Date: Thu, 10 Apr 2025 14:04:17 -0400
In-Reply-To: <8b5e5495-4b11-4acc-8df1-fb94b2a34f0f@linux.microsoft.com>
References: <20250402124725.5601-1-chenste@linux.microsoft.com>
	 <20250402124725.5601-9-chenste@linux.microsoft.com>
	 <Z/eVWQw3z7yyzyxb@MiWiFi-R3L-srv>
	 <8b5e5495-4b11-4acc-8df1-fb94b2a34f0f@linux.microsoft.com>
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
X-Proofpoint-ORIG-GUID: 1IF-ZY7KdAvuwrxOxQjzXJQWslav6FLG
X-Proofpoint-GUID: 1IF-ZY7KdAvuwrxOxQjzXJQWslav6FLG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-10_05,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 spamscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 suspectscore=0 mlxlogscore=999
 phishscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504100129

On Thu, 2025-04-10 at 09:59 -0700, steven chen wrote:
> On 4/10/2025 2:54 AM, Baoquan He wrote:
> > On 04/02/25 at 05:47am, steven chen wrote:
> > > The extra memory allocated for carrying the IMA measurement list acro=
ss
> > > kexec is hard-coded as half a PAGE.  Make it configurable.
> > >=20
> > > Define a Kconfig option, IMA_KEXEC_EXTRA_MEMORY_KB, to configure the
> > > extra memory (in kb) to be allocated for IMA measurements added durin=
g
> > > kexec soft reboot.  Ensure the default value of the option is set suc=
h
> > > that extra half a page of memory for additional measurements is alloc=
ated
> > > for the additional measurements.
> > >=20
> > > Update ima_add_kexec_buffer() function to allocate memory based on th=
e
> > > Kconfig option value, rather than the currently hard-coded one.
> > >=20
> > > Suggested-by: Stefan Berger <stefanb@linux.ibm.com>
> > > Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> > > Signed-off-by: steven chen <chenste@linux.microsoft.com>
> > > Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> > > Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> > > ---
> > >   security/integrity/ima/Kconfig     | 10 ++++++++++
> > >   security/integrity/ima/ima_kexec.c | 16 +++++++++++-----
> > >   2 files changed, 21 insertions(+), 5 deletions(-)
> > >=20
> > > diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/=
Kconfig
> > > index 475c32615006..d73c96c3c1c9 100644
> > > --- a/security/integrity/ima/Kconfig
> > > +++ b/security/integrity/ima/Kconfig
> > > @@ -321,4 +321,14 @@ config IMA_DISABLE_HTABLE
> > >   	help
> > >   	   This option disables htable to allow measurement of duplicate r=
ecords.
> > >  =20
> > > +config IMA_KEXEC_EXTRA_MEMORY_KB
> > > +	int "Extra memory for IMA measurements added during kexec soft rebo=
ot"
> > > +	depends on IMA_KEXEC
> > > +	default 0
> > Usually a new Kconfig item which accepts a range should define the rang=
e
> > boundary, otherwise it's not clear to people how large or how small it
> > can be set. For example, can I set it as value of 1<<40? We should at
> > least estimate a possible upper limit for it for other people's
> > reference. My personal opinion.
>=20
> Hi Baoquan,
>=20
> How about I set range 2-40? Default set as 2, same as the fixed setting.

0, the current default, sets the "extra" memory to the existing "extra half=
 a
page of memory for the additional measurements".  For backwards compatibili=
ty,
please do not change this.

The requirement for a larger "extra" measurement is coming from Microsoft. =
If
this isn't any longer a requirement, we could drop this patch.  Lakshmi, do=
 you
have any thoughts on this?

thanks,

Mimi

>=20
> > The rest looks good to me.
> >=20
> >=20
> > > +	help
> > > +	  IMA_KEXEC_EXTRA_MEMORY_KB determines the extra memory to be
> > > +	  allocated (in kb) for IMA measurements added during kexec soft re=
boot.
> > > +	  If set to the default value of 0, an extra half page of memory fo=
r those
> > > +	  additional measurements will be allocated.
> > > +
> > >   endif
> > ...snip...
>=20
>=20
>=20


