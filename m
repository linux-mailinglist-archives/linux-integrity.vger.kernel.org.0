Return-Path: <linux-integrity+bounces-5156-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 923EAA55DEA
	for <lists+linux-integrity@lfdr.de>; Fri,  7 Mar 2025 03:52:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCFC516D979
	for <lists+linux-integrity@lfdr.de>; Fri,  7 Mar 2025 02:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A899B188904;
	Fri,  7 Mar 2025 02:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pGSCZJTc"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023117E9;
	Fri,  7 Mar 2025 02:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741315948; cv=none; b=WMXGmrz97SEtQu4+5L9cR012m7J/X966DFNqS53draeHeoHryRvMmdegC/kYTkkDVtw7n4XXEdSgIrlIp5uVdFOANvbZq68DMFGOI76W0aypgka3MNHzqTdEkDoyKp2lhrSehttlsl4khep8QAWbPKvdXFy9LKNtULRcpVulhdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741315948; c=relaxed/simple;
	bh=QWbG3mhYXb/JRpxuDbnSsSzhGiAA/DGHDEjj14JZBuY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sn7oJagPRGjSiIFZb5uXPvSs0kE54T7+Iufxopu9JtZYvlF2J4WfMTM2VqgocBs6cJjA5+TUMg7FUGlO25PHTglOe77mcsq/VWxj3h4NJNUAnacU2aleEygHrNWr1bRHJp6twN92wrRZg2qcUp/W0ABrisgU/fSXt6nH6/xkBYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pGSCZJTc; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 526MOQlj023805;
	Fri, 7 Mar 2025 02:51:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=LSX7u7
	hpQG9kzrD00xcMaeuOdbSpidIB6YttNQE9Zog=; b=pGSCZJTcoSXR8zGp2dMuo1
	U2kpuyIqgc4U3CJhjYQ1lqparoY/ADpqNpOYCc+nkQIl8ClpXKL6Qf8kepwvhrm8
	dXBJC9xNn86/DkoSBc6AkZcGs+zXuSfYNgEE8hs0KrQHXmIAOWYhUx2XvVk2yXMW
	DbqnP8XNEGRfLJjgv/OdnMCJCApaZTUc3n9FNQpov4mfWUaPb+tZIosYiT+tX2Yn
	pLI7W/RTBHRgyvTurBxEiID9YolyFyc/DYnD4YaUnCu9uYpnDJ+5HVu6e22WUdos
	up5lZZ4M774B+ksCcwmfb3lrsSpRtxhsh2WNpwRNinEjdtZYy6pNwM6IfWItiJRw
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4574396btd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Mar 2025 02:51:53 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5271a7X2020841;
	Fri, 7 Mar 2025 02:51:52 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 454djnvf29-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Mar 2025 02:51:52 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5272ppD727525806
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Mar 2025 02:51:52 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C82E958056;
	Fri,  7 Mar 2025 02:51:51 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8E63B5805E;
	Fri,  7 Mar 2025 02:51:50 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.66.15])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  7 Mar 2025 02:51:50 +0000 (GMT)
Message-ID: <69f43be0ed70eee45d3d9d9ac2aeaf39def5770a.camel@linux.ibm.com>
Subject: Re: [PATCH v9 1/7] ima: copy only complete measurement records
 across kexec
From: Mimi Zohar <zohar@linux.ibm.com>
To: steven chen <chenste@linux.microsoft.com>, Baoquan He <bhe@redhat.com>
Cc: stefanb@linux.ibm.com, roberto.sassu@huaweicloud.com,
        roberto.sassu@huawei.com, eric.snowberg@oracle.com,
        ebiederm@xmission.com, paul@paul-moore.com, code@tyhicks.com,
        bauermann@kolabnow.com, linux-integrity@vger.kernel.org,
        kexec@lists.infradead.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, madvenka@linux.microsoft.com,
        nramas@linux.microsoft.com, James.Bottomley@hansenpartnership.com,
        vgoyal@redhat.com, dyoung@redhat.com
Date: Thu, 06 Mar 2025 21:51:50 -0500
In-Reply-To: <8bc74dd8-ecd0-44ad-88a2-8b36fa61100a@linux.microsoft.com>
References: <20250304190351.96975-1-chenste@linux.microsoft.com>
	 <20250304190351.96975-2-chenste@linux.microsoft.com>
	 <Z8g+uhZQ6totYLmp@MiWiFi-R3L-srv>
	 <fe6e3c1333a50d66dc876b5a196d3491170802a8.camel@linux.ibm.com>
	 <8bc74dd8-ecd0-44ad-88a2-8b36fa61100a@linux.microsoft.com>
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
X-Proofpoint-GUID: tcXPqrwRdfAvKYDFQQvRS5oy_sLHQISR
X-Proofpoint-ORIG-GUID: tcXPqrwRdfAvKYDFQQvRS5oy_sLHQISR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-07_01,2025-03-06_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 spamscore=0 phishscore=0 clxscore=1015 mlxscore=0
 malwarescore=0 adultscore=0 mlxlogscore=999 priorityscore=1501 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503070015

On Thu, 2025-03-06 at 14:45 -0800, steven chen wrote:
> On 3/5/2025 4:27 AM, Mimi Zohar wrote:
> > On Wed, 2025-03-05 at 20:08 +0800, Baoquan He wrote:
> > > On 03/04/25 at 11:03am, steven chen wrote:
> > > > Carrying the IMA measurement list across kexec requires allocating =
a
> > > > buffer and copying the measurement records.  Separate allocating th=
e
> > > > buffer and copying the measurement records into separate functions =
in
> > > > order to allocate the buffer at kexec 'load' and copy the measureme=
nts
> > > > at kexec 'execute'.
> > > >=20
> > > > This patch includes the following changes:
> > > I don't know why one patch need include so many changes. From below l=
og,
> > > it should be split into separate patches. It may not need to make one
> > > patch to reflect one change, we should at least split and wrap severa=
l
> > > kind of changes to ease patch understanding and reviewing. My persona=
l
> > > opinion.
> > Agreed, well explained.
> >=20
> > Mimi
> >=20
> > > >   - Refactor ima_dump_measurement_list() to move the memory allocat=
ion
> > > >     to a separate function ima_alloc_kexec_file_buf() which allocat=
es
> > > >     buffer of size 'kexec_segment_size' at kexec 'load'.
> > > >   - Make the local variable ima_kexec_file in ima_dump_measurement_=
list()
> > > >     a local static to the file, so that it can be accessed from
> > > >     ima_alloc_kexec_file_buf(). Compare actual memory required to e=
nsure
> > > >     there is enough memory for the entire measurement record.
> > > >   - Copy only complete measurement records.
> > > >   - Make necessary changes to the function ima_add_kexec_buffer() t=
o call
> > > >     the above two functions.
> > > >   - Compared the memory size allocated with memory size of the enti=
re
> > > >     measurement record. Copy only complete measurement records if t=
here
> > > >     is enough memory. If there is not enough memory, it will not co=
py
> > > >     any IMA measurement records, and this situation will result in =
a
> > > >     failure of remote attestation.
> > > >=20
> > > > Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
> > > > Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> > > > Signed-off-by: steven chen <chenste@linux.microsoft.com>
>=20
> I will split this patch into the following two patches:
>=20
>  =C2=A0 =C2=A0 ima: define and call ima_alloc_kexec_file_buf
>  =C2=A0=C2=A0=C2=A0 ima: copy measurement records as much as possible acr=
oss kexec

Steven, breaking up code into patches is in order to simplify patch review.=
=20
This is done by limiting each patch to a single "logical change" [1].  For
example, the change below has nothing to do with "separate allocating the b=
uffer
and copying the measurement records into separate functions".

        /* This is an append-only list, no need to hold the RCU read lock *=
/
        list_for_each_entry_rcu(qe, &ima_measurements, later, true) {
-               if (file.count < file.size) {
+               entry_size +=3D ima_get_binary_runtime_entry_size(qe->entry=
);=20
+               if (entry_size <=3D segment_size) {
                        khdr.count++;
-                       ima_measurements_show(&file, qe);
+                       ima_measurements_show(&ima_kexec_file, qe);
                } else {
                        ret =3D -EINVAL;
+                       pr_err("IMA log file is too big for Kexec buf\n");
                        break;
                }
        }

The original code potentially copied a partial last measurement record, not=
 a
complete measurement record.  For ease of review, the above change is fine,=
 but
it needs to be a separate patch.

Patches:
1. ima: copy only complete measurement records across kexec
2. ima: define and call ima_alloc_kexec_file_buf()

The original code copied as many measurement records as possible.  Please d=
o not
change it.

thanks,

Mimi

[1] Refer to the section "Separate your changes" in
https://www.kernel.org/doc/Documentation/process/submitting-patches.rst






