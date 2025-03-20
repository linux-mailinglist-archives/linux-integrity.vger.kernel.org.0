Return-Path: <linux-integrity+bounces-5337-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CC19A6A6DD
	for <lists+linux-integrity@lfdr.de>; Thu, 20 Mar 2025 14:07:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C85716EBCC
	for <lists+linux-integrity@lfdr.de>; Thu, 20 Mar 2025 13:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16E4C2557C;
	Thu, 20 Mar 2025 13:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XIXSk8Ai"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5198C29A1;
	Thu, 20 Mar 2025 13:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742476001; cv=none; b=AbEabnpOWtSC5ozN4Dv//ZkqvaaxWiZfYFDXx21XURYkLuNnJDGoEIFNez+xsskdSiKyiH8JublNPigYjFMTqNOoB2lg3WJgvCx/hgTOcXFhvm+pqXc1jxHb178xvnKv/yFF9TGH7iWJ/KKujkVqndcIH/dVyfVIqDSdcFUcNRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742476001; c=relaxed/simple;
	bh=zjp3pQUhSVuMmZ6Sst6AT+0qgO4plzHIpE0hhREy3I0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jlrBT2mo24DHDnUSeNj/iHBMlJbxePoFN+WkCp9U99IwF7zp1GwRvqwtRfYNiuMGDJxtGOFtUgSFa/Z/KpDUf1eIFF4UoKKjR9wt+yj2gjVoSwmGtpa0ACpWJfCWLSjopz77u59IexMa6dANE8N0VyHxx+AYI9/Jxgz7TQKkHvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XIXSk8Ai; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52K7gpHg030809;
	Thu, 20 Mar 2025 13:06:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=8mFVcq
	FA1C6pWd8bYYrSIaZl/JCsBhWrZXtha/PnkrI=; b=XIXSk8AijIN/BUxZkkingD
	FfD51MOdZPzJhKy2MqmDm4PPzuTpx75PcVsadZGSxxPTjKA0ZgzjsIpwdlvfS11P
	0rwPzHbobNC0ce+DhMW29rir5mVgF30UEpuN3KTX21HPg04GgVb0h5XtFlj7f6yE
	73dHeT9HK4cTYPn8OihB10RHPV+cT4IIAy1rU/kf+A90mymEvHxiD1H73XewgFgw
	UU0TAjoO0wSb0S4UGMQg1CpqN3pGE8UQbda2atCVGR1Fc8HcuZsERonSJmy7LAcW
	EWEFIETKDJBDM/oFr6WsCzdUDd89Pk959Iq9taunZV5BioLNo13HUWKJhy5Y+h9g
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45g53qc5sk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Mar 2025 13:06:16 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52KAqeNP032041;
	Thu, 20 Mar 2025 13:06:15 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 45dkvtrbbj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Mar 2025 13:06:15 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52KD6Eu118612764
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Mar 2025 13:06:15 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C0FE75805A;
	Thu, 20 Mar 2025 13:06:14 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8919E58062;
	Thu, 20 Mar 2025 13:06:13 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.21.227])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 20 Mar 2025 13:06:13 +0000 (GMT)
Message-ID: <a8368f2402e1145c134e445d015c434140874e06.camel@linux.ibm.com>
Subject: Re: [PATCH v10 2/8] ima: define and call ima_alloc_kexec_file_buf()
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
Date: Thu, 20 Mar 2025 09:06:13 -0400
In-Reply-To: <Z9t0h5vvxP+meMkO@MiWiFi-R3L-srv>
References: <20250318010448.954-1-chenste@linux.microsoft.com>
	 <20250318010448.954-3-chenste@linux.microsoft.com>
	 <Z9p7rwXqjB3vjCpj@MiWiFi-R3L-srv>
	 <447b1bf7b31e936ab959b8ba13f09a9c25bb3977.camel@linux.ibm.com>
	 <Z9t0h5vvxP+meMkO@MiWiFi-R3L-srv>
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
X-Proofpoint-GUID: VxlXgarFD0AYjfhnl5T_btcofPGxYlna
X-Proofpoint-ORIG-GUID: VxlXgarFD0AYjfhnl5T_btcofPGxYlna
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-20_03,2025-03-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 mlxscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 phishscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503200080

On Thu, 2025-03-20 at 09:51 +0800, Baoquan He wrote:
> > > > diff --git a/security/integrity/ima/ima_kexec.c b/security/integrit=
y/ima/ima_kexec.c
> > > > index 8567619889d1..45170e283272 100644
> > > > --- a/security/integrity/ima/ima_kexec.c
> > > > +++ b/security/integrity/ima/ima_kexec.c
> > > > @@ -15,6 +15,48 @@
> > > > =C2=A0 #include "ima.h"
> > > > =C2=A0=20
> > > > =C2=A0 #ifdef CONFIG_IMA_KEXEC
> > > > +static struct seq_file ima_kexec_file;
> > > > +
> > > > +static void ima_reset_kexec_file(struct seq_file *sf)
> > > > +{
> > > > +	sf->buf =3D NULL;
> > > > +	sf->size =3D 0;
> > > > +	sf->read_pos =3D 0;
> > > > +	sf->count =3D 0;
> > > > +}
> > > > +
> > > > +static void ima_free_kexec_file_buf(struct seq_file *sf)
> > > > +{
> > > > +	vfree(sf->buf);
> > > > +	ima_reset_kexec_file(sf);
> > > > +}
> > > > +
> > > > +static int ima_alloc_kexec_file_buf(size_t segment_size)
> > > > +{
> > > > +	/*
> > > > +	 * kexec 'load' may be called multiple times.
> > > > +	 * Free and realloc the buffer only if the segment_size is
> > > > +	 * changed from the previous kexec 'load' call.
> > > > +	 */
> > > > +	if (ima_kexec_file.buf && ima_kexec_file.size =3D=3D segment_size=
)
> > > > +		goto out;
> >=20
> > The call to ima_reset_kexec_file() in ima_add_kexec_buffer() resets
> > ima_kexec_file.buf() hiding the fact that the above test always fails a=
nd falls
> > through.=C2=A0 As a result, 'buf' is always being re-allocated.

Hi Steven,

[Reiterating the comment in the "ima: kexec: move IMA log copy from kexec l=
oad
to execute" thread, here, for completeness.]

Instead of adding and then removing the ima_reset_kexec_file() call from
ima_add_kexec_buffer(), defer adding the segment size test to when it is
actually possible for the segment size to change. Please make the segment s=
ize
test as a separate patch.

ima_reset_kexec_file() will then only be called by ima_free_kexec_file_buf(=
).=20
Inline the ima_reset_kexec_file() code in ima_free_kexec_file_buf().

thanks,

Mimi

