Return-Path: <linux-integrity+bounces-5785-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C22EFA84D75
	for <lists+linux-integrity@lfdr.de>; Thu, 10 Apr 2025 21:48:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 783143B22E8
	for <lists+linux-integrity@lfdr.de>; Thu, 10 Apr 2025 19:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D39CA1DFE00;
	Thu, 10 Apr 2025 19:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="H/7jrECt"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B35A1EE02F;
	Thu, 10 Apr 2025 19:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744314475; cv=none; b=V3v3zH56b1g04pmEwjj/7qiRDqG1sOlmYHXxplNNturgnU3/W3Z/hAWPO5CcgdWp/sl+gwptW/zD04qZv5ifyN4iD8HEgjNuoknbttA6+V6gNq492xCEfsOHrvweN/6cT79CtSmgEKRHDbPX1fzsKHrjjNn4EznL1i7Xvf/zj/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744314475; c=relaxed/simple;
	bh=3vq9IfT+coLy3S0xB0lkBwcw/X7RYkV6rTC8tZQpm8k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ppq+/JREanFfvk88AritrD/5P/0zgpI+u8skUHGcT35I9WO6BwR+3PsUZbOIozCdI7rNpgsAe09hVkgHCJfaPMPIghv6ttQ5GslMORUcZfMQQTLkRYuQv5B/wP/RZO/x0TncS3uNI5Fmumc+TxvNUsGCK1Ya5dxwvPH/9Wq9V/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=H/7jrECt; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53AJeNL2018133;
	Thu, 10 Apr 2025 19:47:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Ym5t2H
	BCUys4CJouuMEi1f6kxfT8lHW6yUI2giZDpJY=; b=H/7jrECtafdhFxMAWv/jdf
	Vj3b1FxjH7kfpzpEvD/2bgKCWfRI/dE8w4hburlcKcJ8Txke/0w5tNrGXf10Ap4f
	ldD/F70TQxoDpEO4IIFz9biUPt0pK+RdwmEDX4hge1Oj5GQeAgoEwx2i4cIDX9co
	4P76CwzJYc5wlKGYyA1F5r0ajVEOHXaS3chYAXFV7xU1/buXM77qK7GhlrlYwSib
	mbtZsPirZGX2IqYJiuiPpi7S0pUH7toZb3PmNFz3H94upcqTcmtQZLw/Mut67AwW
	jdm8d67LHqDeXtX7FfQQ2CSUdni6lS3Ikj60/KWt+1TSPkbZl+5yPa4uygWnMyog
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45x6ca53st-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Apr 2025 19:47:28 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53AJ0CCK024651;
	Thu, 10 Apr 2025 19:47:27 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 45ueutqwfw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Apr 2025 19:47:27 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53AJlR6d31589090
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Apr 2025 19:47:27 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4165558055;
	Thu, 10 Apr 2025 19:47:27 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5D64358043;
	Thu, 10 Apr 2025 19:47:26 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.31.96.173])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 10 Apr 2025 19:47:26 +0000 (GMT)
Message-ID: <80c8323c5ba2698cf4352e9d64eb8517250955d6.camel@linux.ibm.com>
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
        James.Bottomley@hansenpartnership.com, vgoyal@redhat.com,
        dyoung@redhat.com
Date: Thu, 10 Apr 2025 15:47:26 -0400
In-Reply-To: <692121f5-fc17-45b5-b4c0-c4393bb05bc4@linux.microsoft.com>
References: <20250402124725.5601-1-chenste@linux.microsoft.com>
	 <20250402124725.5601-9-chenste@linux.microsoft.com>
	 <Z/eVWQw3z7yyzyxb@MiWiFi-R3L-srv>
	 <8b5e5495-4b11-4acc-8df1-fb94b2a34f0f@linux.microsoft.com>
	 <8120a7b1eafaa5452981484671e841a7a7872877.camel@linux.ibm.com>
	 <692121f5-fc17-45b5-b4c0-c4393bb05bc4@linux.microsoft.com>
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
X-Proofpoint-GUID: s8_Ot0gv62iN1FhFfWFNmq5-4qh7VQcq
X-Proofpoint-ORIG-GUID: s8_Ot0gv62iN1FhFfWFNmq5-4qh7VQcq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-10_05,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 phishscore=0 mlxscore=0 priorityscore=1501 suspectscore=0
 adultscore=0 bulkscore=0 spamscore=0 clxscore=1015 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504100137

On Thu, 2025-04-10 at 11:49 -0700, steven chen wrote:
> On 4/10/2025 11:04 AM, Mimi Zohar wrote:
> > On Thu, 2025-04-10 at 09:59 -0700, steven chen wrote:
> > > On 4/10/2025 2:54 AM, Baoquan He wrote:
> > > > On 04/02/25 at 05:47am, steven chen wrote:
> > > > > The extra memory allocated for carrying the IMA measurement list =
across
> > > > > kexec is hard-coded as half a PAGE.  Make it configurable.
> > > > >=20
> > > > > Define a Kconfig option, IMA_KEXEC_EXTRA_MEMORY_KB, to configure =
the
> > > > > extra memory (in kb) to be allocated for IMA measurements added d=
uring
> > > > > kexec soft reboot.  Ensure the default value of the option is set=
 such
> > > > > that extra half a page of memory for additional measurements is a=
llocated
> > > > > for the additional measurements.
> > > > >=20
> > > > > Update ima_add_kexec_buffer() function to allocate memory based o=
n the
> > > > > Kconfig option value, rather than the currently hard-coded one.
> > > > >=20
> > > > > Suggested-by: Stefan Berger <stefanb@linux.ibm.com>
> > > > > Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> > > > > Signed-off-by: steven chen <chenste@linux.microsoft.com>
> > > > > Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> > > > > Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> > > > > ---
> > > > >    security/integrity/ima/Kconfig     | 10 ++++++++++
> > > > >    security/integrity/ima/ima_kexec.c | 16 +++++++++++-----
> > > > >    2 files changed, 21 insertions(+), 5 deletions(-)
> > > > >=20
> > > > > diff --git a/security/integrity/ima/Kconfig b/security/integrity/=
ima/Kconfig
> > > > > index 475c32615006..d73c96c3c1c9 100644
> > > > > --- a/security/integrity/ima/Kconfig
> > > > > +++ b/security/integrity/ima/Kconfig
> > > > > @@ -321,4 +321,14 @@ config IMA_DISABLE_HTABLE
> > > > >    	help
> > > > >    	   This option disables htable to allow measurement of duplic=
ate records.
> > > > >   =20
> > > > > +config IMA_KEXEC_EXTRA_MEMORY_KB
> > > > > +	int "Extra memory for IMA measurements added during kexec soft =
reboot"
> > > > > +	depends on IMA_KEXEC
> > > > > +	default 0
> > > > Usually a new Kconfig item which accepts a range should define the =
range
> > > > boundary, otherwise it's not clear to people how large or how small=
 it
> > > > can be set. For example, can I set it as value of 1<<40? We should =
at
> > > > least estimate a possible upper limit for it for other people's
> > > > reference. My personal opinion.
> > > Hi Baoquan,
> > >=20
> > > How about I set range 2-40? Default set as 2, same as the fixed setti=
ng.
> > 0, the current default, sets the "extra" memory to the existing "extra =
half a
> > page of memory for the additional measurements".  For backwards compati=
bility,
> > please do not change this.
> >=20
> > The requirement for a larger "extra" measurement is coming from Microso=
ft. If
> > this isn't any longer a requirement, we could drop this patch.  Lakshmi=
, do you
> > have any thoughts on this?
>=20
> How about the range set as 0-40 and the default as 0?
>=20
> We (Microsoft) are ok with 0 as the default.

Thanks, fine.

>=20
> Thanks
>=20
> > > > The rest looks good to me.
> > > >=20
> > > >=20
> > > > > +	help
> > > > > +	  IMA_KEXEC_EXTRA_MEMORY_KB determines the extra memory to be
> > > > > +	  allocated (in kb) for IMA measurements added during kexec sof=
t reboot.
> > > > > +	  If set to the default value of 0, an extra half page of memor=
y for those
> > > > > +	  additional measurements will be allocated.
> > > > > +
> > > > >    endif
> > > > ...snip...
> > >=20
> > >=20
>=20
>=20


