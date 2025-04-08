Return-Path: <linux-integrity+bounces-5669-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16647A806F2
	for <lists+linux-integrity@lfdr.de>; Tue,  8 Apr 2025 14:32:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEB3E4A11B5
	for <lists+linux-integrity@lfdr.de>; Tue,  8 Apr 2025 12:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF77C26A1C1;
	Tue,  8 Apr 2025 12:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hO8t9dFN"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DACF026A1BB;
	Tue,  8 Apr 2025 12:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744115035; cv=none; b=VgxZul8WbAe3W8dFb9LrOAHT23pwkZz3WgZTKNUcbV3cJOotzH3uVabZBaX0SxaxunmChqbBy7r6TdwO9T7bg8SO/otL1mwxTUpzZj+ewRLSZMAMBKSRswEAEv67P5F3LU1iyP4BAg7+dLtMoiKYa4t8I5qKp7/Fzrebnb9fRl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744115035; c=relaxed/simple;
	bh=+0kQLkBersQAxuyEm9gFXmNVKMeuozD/pQuw7cAkMQM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UrkJebEiWml8WvLokfnKPnr12RtMCK+LdlTFd5JHQgkOklCKSDkbxIe1uUeo6EJjWAP0Mv1RFBjcfmmz9IL4JHHVu4XSJKmyon0aP0dg7FFPr2d/RYm28Of/+JfcPpHqx6yYknvmrYuM0NJghHGE2iaVNxpJ/rpNfZIzPgwkd/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hO8t9dFN; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5388SgxK006128;
	Tue, 8 Apr 2025 12:23:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=TSDFVL
	2bAGJP3SpPcF0vFklGV1RUikVjEFAV9J9MNSM=; b=hO8t9dFNiDkBh39+16txV3
	FkzZqX9HzCvUEWQjs2rtwDQq6TUiWZOLrek9OIQ82bN+6eklVDf4dbrGHGG8rvxm
	EE1mXKEuIDyEcUbTYNd/W1yqpcraPydKgbcKfkyJC53yNvCwZubKs9YkMNz+e89I
	uHQ7x8VTxvsmG7ofAZD5qJ6hlZLq+2ce+5+WuyJHYdgzOAzY5J68EQ0HLjVg89vH
	hpey3Am+9gt8fEbqRiwvaeyFPLRmwo0n7c4hsaxAo1FDHwinrdmNvAYGrWSzv5x6
	zoUq7YVudBVx3IWrrfLnJBhmFwtJvCWTwFqvMDb8+4J4ZVn/vAEVIHWouvKfl4Yg
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45w0ar12hd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Apr 2025 12:23:11 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5388Nxxj025510;
	Tue, 8 Apr 2025 12:23:10 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45ugbkthfm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Apr 2025 12:23:10 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 538CN9MM21824096
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 8 Apr 2025 12:23:09 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 13C2158066;
	Tue,  8 Apr 2025 12:23:09 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3A3E158059;
	Tue,  8 Apr 2025 12:23:07 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.63.116])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  8 Apr 2025 12:23:07 +0000 (GMT)
Message-ID: <fe4769ef1597a30fb5fcc26edc81b221bde55a56.camel@linux.ibm.com>
Subject: Re: [PATCH v11 2/9] ima: define and call ima_alloc_kexec_file_buf()
From: Mimi Zohar <zohar@linux.ibm.com>
To: Baoquan He <bhe@redhat.com>
Cc: steven chen <chenste@linux.microsoft.com>, stefanb@linux.ibm.com,
        roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
        eric.snowberg@oracle.com, ebiederm@xmission.com, paul@paul-moore.com,
        code@tyhicks.com, bauermann@kolabnow.com,
        linux-integrity@vger.kernel.org, kexec@lists.infradead.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
        madvenka@linux.microsoft.com, nramas@linux.microsoft.com,
        James.Bottomley@hansenpartnership.com, vgoyal@redhat.com,
        dyoung@redhat.com
Date: Tue, 08 Apr 2025 08:23:06 -0400
In-Reply-To: <Z/TbuF47dg7zUpsm@MiWiFi-R3L-srv>
References: <20250402124725.5601-1-chenste@linux.microsoft.com>
	 <20250402124725.5601-3-chenste@linux.microsoft.com>
	 <a293ed27094f7fa7a36f1641a9e6b17a49e26fa0.camel@linux.ibm.com>
	 <Z/SoekIdreYI3uBZ@MiWiFi-R3L-srv>
	 <36e244edd96a51f0749d54811c9567f954680a39.camel@linux.ibm.com>
	 <Z/TbuF47dg7zUpsm@MiWiFi-R3L-srv>
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
X-Proofpoint-GUID: EFNMJg-JmMUR1qPMBRahCJhc4D5Orrbk
X-Proofpoint-ORIG-GUID: EFNMJg-JmMUR1qPMBRahCJhc4D5Orrbk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-08_04,2025-04-08_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 adultscore=0 bulkscore=0 mlxlogscore=999 lowpriorityscore=0 clxscore=1015
 impostorscore=0 mlxscore=0 spamscore=0 priorityscore=1501 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504080085

On Tue, 2025-04-08 at 16:18 +0800, Baoquan He wrote:
> On 04/08/25 at 01:03am, Mimi Zohar wrote:
> > On Tue, 2025-04-08 at 12:39 +0800, Baoquan He wrote:
> > > On 04/08/25 at 12:07am, Mimi Zohar wrote:
> > > > On Wed, 2025-04-02 at 05:47 -0700, steven chen wrote:
> > > > > In the current implementation, the ima_dump_measurement_list() AP=
I is=20
> > > > > called during the kexec "load" phase, where a buffer is allocated=
 and=20
> > > > > the measurement records are copied. Due to this, new events added=
 after
> > > > > kexec load but before kexec execute are not carried over to the n=
ew kernel
> > > > > during kexec operation
> > > >=20
> > > > Repeating this here is unnecessary.
> > > > >=20
> > > > > To allow the buffer allocation and population to be separated int=
o distinct
> > > > > steps, make the function local seq_file "ima_kexec_file" to a fil=
e variable.
> > > >=20
> > > > This change was already made in [PATCH v11 1/9] ima: rename variabl=
e the
> > > > set_file "file" to "ima_kexec_file".  Please remove.
> > > >=20
> > > > >=20
> > > > > Carrying the IMA measurement list across kexec requires allocatin=
g a
> > > > > buffer and copying the measurement records.  Separate allocating =
the
> > > > > buffer and copying the measurement records into separate function=
s in
> > > > > order to allocate the buffer at kexec 'load' and copy the measure=
ments
> > > > > at kexec 'execute'.
> > > > >=20
> > > > > Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> > > > > Signed-off-by: steven chen <chenste@linux.microsoft.com>
> > > > > ---
> > > > >  security/integrity/ima/ima_kexec.c | 46 +++++++++++++++++++++++-=
------
> > > > >  1 file changed, 35 insertions(+), 11 deletions(-)
> > > > >=20
> > > > > diff --git a/security/integrity/ima/ima_kexec.c b/security/integr=
ity/ima/ima_kexec.c
> > > > > index 650beb74346c..b12ac3619b8f 100644
> > > > > --- a/security/integrity/ima/ima_kexec.c
> > > > > +++ b/security/integrity/ima/ima_kexec.c
> > > > > @@ -15,26 +15,46 @@
> > > > >  #include "ima.h"
> > > > > =20
> > > > >  #ifdef CONFIG_IMA_KEXEC
> > > > > +static struct seq_file ima_kexec_file;
> > > > > +
> > > > > +static void ima_free_kexec_file_buf(struct seq_file *sf)
> > > > > +{
> > > > > +	vfree(sf->buf);
> > > > > +	sf->buf =3D NULL;
> > > > > +	sf->size =3D 0;
> > > > > +	sf->read_pos =3D 0;
> > > > > +	sf->count =3D 0;
> > > > > +}
> > > > > +
> > > > > +static int ima_alloc_kexec_file_buf(size_t segment_size)
> > > > > +{
> > > > > +	ima_free_kexec_file_buf(&ima_kexec_file);
> > > >=20
> > > > After moving the vfree() here at this stage in the patch set, the I=
MA
> > > > measurement list fails to verify when doing two consecutive "kexec =
-s -l"
> > > > with/without a "kexec -s -u" in between.  Only after "ima: kexec: m=
ove IMA log
> > > > copy from kexec load to execute" the IMA measurement list verifies =
properly with
> > > > the vfree() here.
> > >=20
> > > I also noticed this, patch 7 will remedy this. Put patch 7 just after
> > > this patch or squash it into this patch?
> > >=20
> > > [PATCH v11 7/9] ima: verify if the segment size has changed
> >=20
> > I'm glad you noticed this too!  I've been staring at it for a while, no=
t knowing
> > what to do.
> >=20
> > "ima: verify if the segment size has changed" is new to v11.  It was or=
iginally
> > part of this patch.  My comment on v10 was:
> >=20
> > The call to ima_reset_kexec_file() in ima_add_kexec_buffer() resets
> > ima_kexec_file.buf() hiding the fact that the above test always fails a=
nd falls
> > through.  As a result, 'buf' is always being re-allocated.
> >=20
> > and
> >=20
> > Instead of adding and then removing the ima_reset_kexec_file() call fro=
m
> > ima_add_kexec_buffer(), defer adding the segment size test to when it i=
s
> > actually possible for the segment size to change. Please make the segme=
nt size
> > test as a separate patch.
> >=20
> > ima_reset_kexec_file() will then only be called by ima_free_kexec_file_=
buf().
> > Inline the ima_reset_kexec_file() code in ima_free_kexec_file_buf().
>=20
> Thanks for deliberating on this and the details sharing, Mimi.
>=20
> It could be fine if we add note in patch 2 log to mention the possible
> failure. With my understanding, commit/patch bisectable means it won't
> break compiling and block the testing. The failure you are concerned
> about is not a blocker, right? And people won't back port partial
> patches of this series.
>=20
> Nore sure if there's another better way we can take or detour.

Right, doing two consecutive kexec loads in a row is not common and won't b=
lock
testing.  Patch readability is more important, in this case, at least to me=
.=20
I'm fine with your suggestion.

Thanks, Boaquan.

> >=20
> > >=20
> > > >=20
> > > > > +
> > > > > +	/* segment size can't change between kexec load and execute */
> > > > > +	ima_kexec_file.buf =3D vmalloc(segment_size);
> > > > > +	if (!ima_kexec_file.buf)
> > > > > +		return -ENOMEM;
> > > > > +
> > > > > +	ima_kexec_file.size =3D segment_size;
> > > > > +	ima_kexec_file.read_pos =3D 0;
> > > > > +	ima_kexec_file.count =3D sizeof(struct ima_kexec_hdr);	/* reser=
ved space */
> > > > > +
> > > > > +	return 0;
> > > > > +}
> > > > > +
> > > >=20
> > >=20
> > >=20
> >=20
>=20
>=20


