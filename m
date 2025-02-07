Return-Path: <linux-integrity+bounces-4756-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7FAEA2CCAC
	for <lists+linux-integrity@lfdr.de>; Fri,  7 Feb 2025 20:37:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB9BF1882D21
	for <lists+linux-integrity@lfdr.de>; Fri,  7 Feb 2025 19:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DFF918C930;
	Fri,  7 Feb 2025 19:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="R6AnF65d"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9271624F9;
	Fri,  7 Feb 2025 19:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738957037; cv=none; b=ssLWIlRCc4xs1N+zYYXE7gKuPhXlKCZTBLjbyq/NMck9c30ITbMjOeczaCgMrHkFoC/dIDH8CM20EIuk2pUDeI+LSnjzPo+pcAwiEpYBZ2eZ+uXbCbiYy7AlSTOH2wWPWFNETSwCscNe6FBz6pv2WAuLdQOFKiN+nOuqcLcbQyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738957037; c=relaxed/simple;
	bh=ZAZWfDtfQccy4fzIALA5QtX9TJEE8cmli5qJJwoF88U=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=I16QXiHR37q3AF5396TZBxjYlY+D7d1XXaPPg4F38dX/Or/tuaMo/VBFxOiSrJF8EK1VDfyzUz7kbJStqjdJpgQRvil8H06nreds/Kb6hntUh+Os4u3DsAMi1TOu7mbkE0R31EBjO+v9qbVR0l/c2c4VH1sozbl7BiCKbVefiK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=R6AnF65d; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 517FdXl1029989;
	Fri, 7 Feb 2025 19:36:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=r2D2Jy
	vOBarhZSAqtc1h5NHJGa1JGnXoIakCrs2JBdA=; b=R6AnF65dImnzu8mVMbNSKj
	RKiw7Gcexw16/wXJbVFFtgVAtR1te4/CfxbfZHEPzhNYsc7kvkS9Sh7wXmu2blPZ
	CUjq+CariqQRxUTNiy/r03F2uCTjQ1EUnbAf9uj0T5s5I0YXyQ4jhtDsrAlu4xM7
	86bNOIXYs572ONfNqoPOZ71KfWypFf0zefRC1QE+ms1Z1NfTGIGZj1Ej4TKLLICa
	7E8BmAHTOjsn37NRxX8bqLPw5Zzes8HN5f3GYXmbj7tsEmI9hqTJtMMHeXvxYaPx
	CtfNsC79RNdLKysQ11buXtkkR/MQO7m+wYumtVdN71TQi8BcAdj30q2XEuXKtp4Q
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44nn0th672-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Feb 2025 19:36:53 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 517Gp572005261;
	Fri, 7 Feb 2025 19:36:52 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 44j05kcw3k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Feb 2025 19:36:52 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 517JapDf27722370
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Feb 2025 19:36:51 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6E93A58053;
	Fri,  7 Feb 2025 19:36:51 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C5FCE58043;
	Fri,  7 Feb 2025 19:36:49 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.80.253])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  7 Feb 2025 19:36:49 +0000 (GMT)
Message-ID: <9dd19d7824aad9be423d8ef57cbfc7b0faf689d5.camel@linux.ibm.com>
Subject: Re: [PATCH v7 1/7] ima: define and call ima_alloc_kexec_file_buf
From: Mimi Zohar <zohar@linux.ibm.com>
To: steven chen <chenste@linux.microsoft.com>, stefanb@linux.ibm.com,
        roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
        eric.snowberg@oracle.com, ebiederm@xmission.com, paul@paul-moore.com,
        code@tyhicks.com, bauermann@kolabnow.com,
        linux-integrity@vger.kernel.org, kexec@lists.infradead.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: madvenka@linux.microsoft.com, nramas@linux.microsoft.com,
        James.Bottomley@HansenPartnership.com
Date: Fri, 07 Feb 2025 14:36:49 -0500
In-Reply-To: <4d258641d36088b1a1239724a2951211159d81f0.camel@linux.ibm.com>
References: <20250203232033.64123-1-chenste@linux.microsoft.com>
	 <20250203232033.64123-2-chenste@linux.microsoft.com>
	 <4d258641d36088b1a1239724a2951211159d81f0.camel@linux.ibm.com>
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
X-Proofpoint-GUID: L5gyLswepfzIr3-MuG4mL7461Y4cl6iI
X-Proofpoint-ORIG-GUID: L5gyLswepfzIr3-MuG4mL7461Y4cl6iI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-07_09,2025-02-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0 impostorscore=0
 bulkscore=0 adultscore=0 malwarescore=0 mlxlogscore=948 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502070146

On Thu, 2025-02-06 at 11:49 -0500, Mimi Zohar wrote:
> Thanks, Steven, for picking up and working on Tushar's patch set.
>=20
> I normally finish reviewing the patch set, before commenting.=C2=A0 In th=
is case,
> there's
> a generic comment that relates to all of the patches.=C2=A0 It's also a w=
ay of letting
> you
> know that I've started reviewing the patch set.=C2=A0 The remaining comme=
nts will come
> after I finish reviewing the patch set.
>=20
> On Mon, 2025-02-03 at 15:20 -0800, steven chen wrote:
> > Carrying the IMA measurement list across kexec requires allocating a
> > buffer and copying the measurement records.=C2=A0 Separate allocating t=
he
> > buffer and copying the measurement records into separate functions in
> > order to allocate the buffer at kexec 'load' and copy the measurements
> > at kexec 'execute'.
> >=20
> > This patch includes the following changes:
> > =C2=A0- Refactor ima_dump_measurement_list() to move the memory allocat=
ion
> > =C2=A0=C2=A0 to a separate function ima_alloc_kexec_file_buf() which al=
locates
> > =C2=A0=C2=A0 buffer of size 'kexec_segment_size' at kexec 'load'.
> > =C2=A0- Make the local variable ima_kexec_file in ima_dump_measurement_=
list()
> > =C2=A0=C2=A0 a local static to the file, so that it can be accessed fro=
m=20
> > =C2=A0=C2=A0 ima_alloc_kexec_file_buf(). Compare actual memory required=
 to ensure=20
> > =C2=A0=C2=A0 there is enough memory for the entire measurement record.
> > =C2=A0- Copy as many measurement events as possible.
> > =C2=A0- Make necessary changes to the function ima_add_kexec_buffer() t=
o call
> > =C2=A0=C2=A0 the above two functions.
> > =C2=A0- Compared the memory size allocated with memory size of the enti=
re=20
> > =C2=A0=C2=A0 measurement record. If there is not enough memory, it will=
 copy as many
> > =C2=A0=C2=A0 IMA measurement records as possible, and this situation wi=
ll result
> > =C2=A0=C2=A0 in a failure of remote attestation.
> >=20
> > Author: Tushar Sugandhi <tusharsu@linux.microsoft.com>
>=20
> I understand you want to credit Tushar for the patch, but the mechanism i=
s
> described
> in Documentation/process/submitting-patches.rst.=C2=A0 Refer to the parag=
raph on "Co-
> developed-by".=C2=A0 There is no tag named "Author".
>=20
> > Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> > Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
>=20
> "Suggested-by" goes before the Signed-off-by tag(s). "Reviewed-by" tag go=
es after
> your and/or Tushar's Signed-off-tag.
>=20
> > Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> > Signed-off-by: steven chen <chenste@linux.microsoft.com>
>=20
> Before the "Co-developed-by" tag was defined, it was implied simply by th=
is
> ordering
> of the "Signed-off-by" tags.
>=20
> For those patches you didn't modify, simply import Tushar's patch with hi=
m as the
> author and add your Signed-off-by tag after his.

Thanks, Steven.  The patch set at this point is bi-sect safe.  The are just=
 a few
formatting cleanups based on "scripts/checkpatch --strict --codespell".  Be=
fore re-
posting, please re-base on the next-integrity branch and address the missin=
g
"kexec_execute" critical data.

Eric is the kexec maintainer so we need his Ack.

thanks,

Mimi

