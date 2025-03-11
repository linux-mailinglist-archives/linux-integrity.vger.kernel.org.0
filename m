Return-Path: <linux-integrity+bounces-5228-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6964FA5C195
	for <lists+linux-integrity@lfdr.de>; Tue, 11 Mar 2025 13:45:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A7503A4722
	for <lists+linux-integrity@lfdr.de>; Tue, 11 Mar 2025 12:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E92E22FF22;
	Tue, 11 Mar 2025 12:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="a180Wzog"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFBF5322E;
	Tue, 11 Mar 2025 12:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741697132; cv=none; b=Sr3TsrAEq5GOfHsVy7y3h24Z0ta3GNFHuUrDkEyOPj0jT8BCv9S5M+DVt1/Fz4gvgg/fQOEJzQBCNuOFC/J4HQZDbBLEXBzwAbUGNnTSBoMNjlbRoOv7iHjmrwWfkkTWhfHpP93yIT5ubMbpnOQAlOSisRrol49FdXITtWEoeyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741697132; c=relaxed/simple;
	bh=xj+1D8ksPdQzwEBRN8cYEqDzhY/NBmBySm0XVKszDaQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XgxmyxGp/BOytAXqaja963nQSHDu7iXH1gMGUMClgBOdXidqMG+qpCqeatVELC0jPn7E5Z5dnmw1gofK/7d72zvjmM0+U+cYfmROoogyvP9pz71xKjZMAoqL8B5ZRGnW+gaKkp35QWkEqbB+QCNqVTBxOXF8M6PJwAP7Jd2HwU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=a180Wzog; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52B9vOFU005892;
	Tue, 11 Mar 2025 12:44:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=kmXfpt
	VW9q2WaIV8tj2ijtdDlxZ/5KSD1Ekbp7i9cuM=; b=a180WzogI/vru5HC+uWMdy
	vh3s3wLkFb93WWzLc2wsiU2I+SWifbCbHVeayXonBY59goNuwa5nDdGbcoPlJ4DG
	fs7fwONjAvw3ObzU0SrEa0mNRgIRz0nGvmuVobFJrQE4yZBK/KsHTf0Gc/zabgJ2
	NajFQFNIyj9WThcO+u2fiKND7u+MmFXZhuxfUxM//GuY/BB+KtT239lR88Hzp6n2
	PROjIeFw23xRC0bNt5n+Y35unxLE7UcjzvtUHtOHXeroinrnDwsFUSN95PNR2aDp
	3jCVQHGYQ5NlDporctugz61HWAPa5fDnxB272zQV7TB5o+HA09m8Mlm4IQlRnv+Q
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45a78quw37-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Mar 2025 12:44:37 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52BCN9E0006941;
	Tue, 11 Mar 2025 12:44:36 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 45907t4ct0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Mar 2025 12:44:36 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52BCiZWA12124844
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Mar 2025 12:44:36 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B303A5804B;
	Tue, 11 Mar 2025 12:44:35 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DED3F58055;
	Tue, 11 Mar 2025 12:44:33 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.163.116])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 11 Mar 2025 12:44:33 +0000 (GMT)
Message-ID: <631f326006226e23f4f755fd32255792f6514a90.camel@linux.ibm.com>
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
Date: Tue, 11 Mar 2025 08:44:33 -0400
In-Reply-To: <69f43be0ed70eee45d3d9d9ac2aeaf39def5770a.camel@linux.ibm.com>
References: <20250304190351.96975-1-chenste@linux.microsoft.com>
	 <20250304190351.96975-2-chenste@linux.microsoft.com>
	 <Z8g+uhZQ6totYLmp@MiWiFi-R3L-srv>
	 <fe6e3c1333a50d66dc876b5a196d3491170802a8.camel@linux.ibm.com>
	 <8bc74dd8-ecd0-44ad-88a2-8b36fa61100a@linux.microsoft.com>
	 <69f43be0ed70eee45d3d9d9ac2aeaf39def5770a.camel@linux.ibm.com>
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
X-Proofpoint-GUID: LKRc30FZcYrokCVrh36qHk1wdT_YHYkV
X-Proofpoint-ORIG-GUID: LKRc30FZcYrokCVrh36qHk1wdT_YHYkV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-11_02,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 spamscore=0 adultscore=0 mlxlogscore=999 phishscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503110080

On Thu, 2025-03-06 at 21:51 -0500, Mimi Zohar wrote:
> On Thu, 2025-03-06 at 14:45 -0800, steven chen wrote:
> > On 3/5/2025 4:27 AM, Mimi Zohar wrote:
> > > On Wed, 2025-03-05 at 20:08 +0800, Baoquan He wrote:
> > > > On 03/04/25 at 11:03am, steven chen wrote:
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
> > > > > This patch includes the following changes:
> > > > I don't know why one patch need include so many changes. From below=
 log,
> > > > it should be split into separate patches. It may not need to make o=
ne
> > > > patch to reflect one change, we should at least split and wrap seve=
ral
> > > > kind of changes to ease patch understanding and reviewing. My perso=
nal
> > > > opinion.
> > > Agreed, well explained.
> > >=20
> > > Mimi
> > >=20
> > > > >   - Refactor ima_dump_measurement_list() to move the memory alloc=
ation
> > > > >     to a separate function ima_alloc_kexec_file_buf() which alloc=
ates
> > > > >     buffer of size 'kexec_segment_size' at kexec 'load'.
> > > > >   - Make the local variable ima_kexec_file in ima_dump_measuremen=
t_list()
> > > > >     a local static to the file, so that it can be accessed from
> > > > >     ima_alloc_kexec_file_buf(). Compare actual memory required to=
 ensure
> > > > >     there is enough memory for the entire measurement record.
> > > > >   - Copy only complete measurement records.
> > > > >   - Make necessary changes to the function ima_add_kexec_buffer()=
 to call
> > > > >     the above two functions.
> > > > >   - Compared the memory size allocated with memory size of the en=
tire
> > > > >     measurement record. Copy only complete measurement records if=
 there
> > > > >     is enough memory. If there is not enough memory, it will not =
copy
> > > > >     any IMA measurement records, and this situation will result i=
n a
> > > > >     failure of remote attestation.
> > > > >=20
> > > > > Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
> > > > > Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> > > > > Signed-off-by: steven chen <chenste@linux.microsoft.com>
> >=20
> > I will split this patch into the following two patches:
> >=20
> >  =C2=A0 =C2=A0 ima: define and call ima_alloc_kexec_file_buf
> >  =C2=A0=C2=A0=C2=A0 ima: copy measurement records as much as possible a=
cross kexec
>=20
> Steven, breaking up code into patches is in order to simplify patch revie=
w.=20
> This is done by limiting each patch to a single "logical change" [1].  Fo=
r
> example, the change below has nothing to do with "separate allocating the=
 buffer
> and copying the measurement records into separate functions".
>=20
>         /* This is an append-only list, no need to hold the RCU read lock=
 */
>         list_for_each_entry_rcu(qe, &ima_measurements, later, true) {
> -               if (file.count < file.size) {
> +               entry_size +=3D ima_get_binary_runtime_entry_size(qe->ent=
ry);=20
> +               if (entry_size <=3D segment_size) {
>                         khdr.count++;
> -                       ima_measurements_show(&file, qe);
> +                       ima_measurements_show(&ima_kexec_file, qe);
>                 } else {
>                         ret =3D -EINVAL;
> +                       pr_err("IMA log file is too big for Kexec buf\n")=
;
>                         break;
>                 }
>         }
>=20
> The original code potentially copied a partial last measurement record, n=
ot a
> complete measurement record.  For ease of review, the above change is fin=
e, but
> it needs to be a separate patch.
>=20
> Patches:
> 1. ima: copy only complete measurement records across kexec
> 2. ima: define and call ima_alloc_kexec_file_buf()

Steven,

The alternative would be to revert using ima_get_binary_runtime_entry_size(=
) and
simply use "ima_kexec_file.count < ima_kexec_file.size".  Only
ima_kexec_file.size would be initialized in ima_alloc_kexec_buf().  The res=
t
would remain in ima_dump_measurement_list().  get_binary_runtime_size() wou=
ldn't
need to be made global.

To further simplify the patch review, first define a separate patch to just
rename the seq_file "file" to "ima_kexec_file".

Mimi

