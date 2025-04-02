Return-Path: <linux-integrity+bounces-5542-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49D60A786CF
	for <lists+linux-integrity@lfdr.de>; Wed,  2 Apr 2025 05:30:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9A8D16D823
	for <lists+linux-integrity@lfdr.de>; Wed,  2 Apr 2025 03:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C96A234545;
	Wed,  2 Apr 2025 03:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Us28gNiV"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25DC922DF9A
	for <linux-integrity@vger.kernel.org>; Wed,  2 Apr 2025 03:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743564619; cv=none; b=TVi0NapUps3qlY5tdp6tBYbPvgM82zROCsANzYaO/BYWKx3kdx3+yPC0P4Fedir6cvEvKjcy7YCaYdsMk6qTIBr3jW/bzkouyhrEg9UlROR6pAh7RfKJleNifDSLIENwRSvS43+f5xfRmReaZoSEmhrVqJyvUVqM0FlG3ZhOhhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743564619; c=relaxed/simple;
	bh=885pPW9P3K6wzUrAWe7JLU4rsWRqrWbicIBxm5fKqWM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=H+20jVwBtKqrPxYxETSM1nUZUxWtEYrprgMvtChWewqJLKGPxNW3w+x3a2Kgc5tLMQDfp1I5RrZk7Xz2fMnFlVsmuiwz8B96WW13mTx1yoq7NaTUa4IHQwAITRxECoLhGiRkm3iNvYZgQRwkiEzXCrLAZrsdrUEwlGVdA/HVDFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Us28gNiV; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 531NDHuA017985;
	Wed, 2 Apr 2025 03:30:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=tS1OEX
	gG6dBoeONA1DljEz14zXLQwqcVtv3Vz/VIHqU=; b=Us28gNiVZ2/+QTYZsh0W/A
	cnBcpaBYJnloblL/XBINj0jQDa2tORkvVJAFhy5ycztSWd2Wf+V/RfUC2ar8bWhf
	w+S4kyMAkX0Ff4Wt/0I9e0PC1FjR5dXBNyWQ/Lz1Xkh3Icl+boC9+ilxXB2dd20c
	c4vWZpItdi6H0QOycTxrOtNawdEfZnSRExZmDAr4TihE9ShL7GUJqwWNg/43vU5L
	bH3srV67MDaLb9uMJ2z0F+Yij8UA/rE02jHNBIM25RuOQwgSwztJuMrHqTkBNw9S
	ealxnpbofbnG0ZOOy7YvI620Vp/EjSrzeEtd0J9Q2eKDYtjXslsNipk6yp+h6m9Q
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45r8h9xf9j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Apr 2025 03:30:12 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5320EfiV014555;
	Wed, 2 Apr 2025 03:30:11 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45pvpm5v8d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Apr 2025 03:30:11 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5323UASQ22479548
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 2 Apr 2025 03:30:10 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BA31858056;
	Wed,  2 Apr 2025 03:30:10 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5AC7E58052;
	Wed,  2 Apr 2025 03:30:10 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.133.136])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  2 Apr 2025 03:30:10 +0000 (GMT)
Message-ID: <d14c72bbb377c6f8f0efdbf6d725c553b3ad741c.camel@linux.ibm.com>
Subject: Re: [RFC PATCH] ima: add a knob to make IMA be able to be disabled
From: Mimi Zohar <zohar@linux.ibm.com>
To: RuiRui Yang <ruyang@redhat.com>, Coiby Xu <coxu@redhat.com>
Cc: Baoquan He <bhe@redhat.com>, linux-integrity@vger.kernel.org,
        kexec@lists.infradead.org
Date: Tue, 01 Apr 2025 23:30:09 -0400
In-Reply-To: <CALu+AoQrKunS5RjikkcZD7=J9vwhv1_Dw96fmO0EtyKi0MHHJg@mail.gmail.com>
References: <20250331061611.253919-1-bhe@redhat.com>
	 <b1eba83a9f68ed9a19100f6c0dc5aca7aff437d5.camel@linux.ibm.com>
	 <fv7h5jfb4r6d5j6jjpgyjbv75zyzqpy6tbqn3ahzuewghnvrgd@5yclg75kr3cq>
	 <CALu+AoQrKunS5RjikkcZD7=J9vwhv1_Dw96fmO0EtyKi0MHHJg@mail.gmail.com>
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
X-Proofpoint-ORIG-GUID: XPhfhJA0wTBn6zLvzuiCL9zKe0rzqk73
X-Proofpoint-GUID: XPhfhJA0wTBn6zLvzuiCL9zKe0rzqk73
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-02_01,2025-04-01_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 bulkscore=0 spamscore=0 mlxlogscore=999 lowpriorityscore=0 impostorscore=0
 mlxscore=0 clxscore=1011 phishscore=0 priorityscore=1501 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504020018

On Wed, 2025-04-02 at 09:47 +0800, RuiRui Yang wrote:
> On Wed, 2 Apr 2025 at 09:41, Coiby Xu <coxu@redhat.com> wrote:
> >=20
> > On Mon, Mar 31, 2025 at 08:15:08AM -0400, Mimi Zohar wrote:
> > > On Mon, 2025-03-31 at 14:16 +0800, Baoquan He wrote:
> > > > It doesn't make sense to run IMA functionality in kdump kernel, and=
 that
> > > > will cost extra memory. It would be great to allow IMA to be disabl=
ed on
> > > > purpose, e.g for kdump kernel.
> > > >=20
> > > > Hence add a knob here to allow people to disable IMA if needed.
> > > >=20
> > > > Signed-off-by: Baoquan He <bhe@redhat.com>
> > > > ---
> > > >  security/integrity/ima/ima_main.c | 21 +++++++++++++++++++++
> > > >  1 file changed, 21 insertions(+)
> > > >=20
> > > > diff --git a/security/integrity/ima/ima_main.c b/security/integrity=
/ima/ima_main.c
> > > > index 28b8b0db6f9b..5d677d1389fe 100644
> > > > --- a/security/integrity/ima/ima_main.c
> > > > +++ b/security/integrity/ima/ima_main.c
> > > > @@ -38,11 +38,27 @@ int ima_appraise;
> > > >=20
> > > >  int __ro_after_init ima_hash_algo =3D HASH_ALGO_SHA1;
> > > >  static int hash_setup_done;
> > > > +static int ima_disabled =3D 0;
> > > >=20
> > > >  static struct notifier_block ima_lsm_policy_notifier =3D {
> > > >      .notifier_call =3D ima_lsm_policy_change,
> > > >  };
> > > >=20
> > > > +static int __init ima_setup(char *str)
> > > > +{
> > > > +    if (strncmp(str, "off", 3) =3D=3D 0)
> > > > +                ima_disabled =3D 1;
> > > > +        else if (strncmp(str, "on", 2) =3D=3D 0)
> > > > +                ima_disabled =3D 0;
> > > > +        else
> > > > +                pr_err("invalid ima setup option: \"%s\" ", str);
> > > > +
> > > > +    return 1;
> > > > +}
> > > > +__setup("ima=3D", ima_setup);
> > >=20
> > > I understand your wanting to disable IMA for Kdump, but this goes way=
 beyond
> > > that.  Please don't make it generic like this.
> > >=20
> > > Please refer to ima_appraise_parse_cmdline().
> >=20
> > Hi Mimi,
> >=20
> > To save memory for kdump, it seems init_ima has been to be skipped thus
> > ima=3Doff is necessary (ima_appraise=3Doff won't serve the purpose). Or=
 do
> > you have any specific concerns in mind?
>=20
> I think as Mimi said see below logic enforces the IMA even with the
> cmdline disabling, see ima_appraise_parse_cmdline:
> if (sb_state) {
>                 if (!(appraisal_state & IMA_APPRAISE_ENFORCE))
>                         pr_info("Secure boot enabled: ignoring
> ima_appraise=3D%s option",
>                                 str);
>         } else {
>                 ima_appraise =3D appraisal_state;
>         }

Thanks, RuiRui.

Coiby, would disabling just IMA-measurement, as opposed to IMA-appraisal, s=
ave
sufficient memory for kdump?

> > >=20
> > > > +
> > > > +
> > > > +
> > > >  static int __init hash_setup(char *str)
> > > >  {
> > > >      struct ima_template_desc *template_desc =3D ima_template_desc_=
current();
> > > > @@ -1176,6 +1192,11 @@ static int __init init_ima(void)
> > > >  {
> > > >      int error;
> > > >=20
> > > > +    if (ima_disabled) {
> > > > +            pr_info("IMA functionality is disabled on purpose!");
> > > > +            return 0;
> > > > +    }
> > > > +
> > > >      ima_appraise_parse_cmdline();
> > > >      ima_init_template_list();
> > > >      hash_setup(CONFIG_IMA_DEFAULT_HASH);
> > >=20
> > >=20
> >=20
> > --
> > Best regards,
> > Coiby
> >=20
> >=20
>=20
>=20


