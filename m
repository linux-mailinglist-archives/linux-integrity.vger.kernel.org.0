Return-Path: <linux-integrity+bounces-4928-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D23C3A3DD5B
	for <lists+linux-integrity@lfdr.de>; Thu, 20 Feb 2025 15:53:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 924313A3063
	for <lists+linux-integrity@lfdr.de>; Thu, 20 Feb 2025 14:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86EF71D5161;
	Thu, 20 Feb 2025 14:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HqfaYLYb"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D3B1CEADB;
	Thu, 20 Feb 2025 14:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740063219; cv=none; b=t2XXTMcFiYwZu/DPsMfw5BBSS8XdxkMBfR8S8c78eLl2nUlgGUqG1PpdRii/7trlauH2JbPTRC4aOQvXeXtVlv6Vsp3BaQ43vZCoNShTEUsYdAVyLGaRa2TcDcc2A0G1d7ZtxMXCGMW6OAZ6HOInFoYxDui3Zi9F24ECEVu9wdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740063219; c=relaxed/simple;
	bh=0FD/F3/U3JtxRzEWsoIttOjwcl1YpzXDxVHZBGkrh4g=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ly5ZDkUqMt7UX6GreY219AhDAufY+U3OKCwZCEeOMl1KSILb4TskqJz3Xv6Mgo9U36P15s2ycX8N90TaKzRDOI4CdomY4wEysFIjcSLf4gBGjGNlT1vEDGzAXe4LWGq0COh9ipQ0zEzQjKagHgZIsyvqt1y8yTNRt8DrMeCvlyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HqfaYLYb; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51K5Nt98026987;
	Thu, 20 Feb 2025 14:53:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=DxPrub
	vpyMyHPwXulmc6NE8Ykno5YlYbrXFIxcV6o4s=; b=HqfaYLYbsw6dfJiMGJNPsk
	bE9OTOs6OF8m1KiDqN71YyIBHpi+An2+QQalkdwJqTc+EyU1eJGkK6y9GUpVbSp3
	K2eRf5vCbCtx1oZVrSXnTCJTjTSUymcwfuGtfUBqUgVDEnipGm6nBZ+vwLZAQeuq
	Z9Y81zRW+3checmVuSz9FV/L94CmOUDQEPaZG/czY1dc+QaTHQYt22AJEEAc7dlo
	gRhNqliif/BgB+iM3XlsfkZtOi5DyI3CP+v+Z+gRnRRFtSvxK9G2KLh5p974CMZz
	gdcRV0vXCxo9HolSjztHb/LCH/1+7nH0L6Co+z49t7zzprZjLZgEZ/S1RlkTKyxg
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44wx78jnp8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Feb 2025 14:53:11 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51KEU69L030262;
	Thu, 20 Feb 2025 14:53:10 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44w01xajrv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Feb 2025 14:53:10 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51KEr9vl55247346
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Feb 2025 14:53:10 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9134058043;
	Thu, 20 Feb 2025 14:53:09 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6563258055;
	Thu, 20 Feb 2025 14:53:08 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.95.183])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 20 Feb 2025 14:53:08 +0000 (GMT)
Message-ID: <8023fa50a84817cc911a117db9bd3757c34fddfb.camel@linux.ibm.com>
Subject: Re: [PATCH v8 1/7] ima: define and call ima_alloc_kexec_file_buf
From: Mimi Zohar <zohar@linux.ibm.com>
To: steven chen <chenste@linux.microsoft.com>, stefanb@linux.ibm.com,
        roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
        eric.snowberg@oracle.com, ebiederm@xmission.com, paul@paul-moore.com,
        code@tyhicks.com, bauermann@kolabnow.com,
        linux-integrity@vger.kernel.org, kexec@lists.infradead.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: madvenka@linux.microsoft.com, nramas@linux.microsoft.com,
        James.Bottomley@HansenPartnership.com, bhe@redhat.com,
        vgoyal@redhat.com, dyoung@redhat.com
Date: Thu, 20 Feb 2025 09:53:08 -0500
In-Reply-To: <20250218225502.747963-2-chenste@linux.microsoft.com>
References: <20250218225502.747963-1-chenste@linux.microsoft.com>
	 <20250218225502.747963-2-chenste@linux.microsoft.com>
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
X-Proofpoint-GUID: 0u5j1XQVbruFEpzDEASxZk_uqFo1o6kt
X-Proofpoint-ORIG-GUID: 0u5j1XQVbruFEpzDEASxZk_uqFo1o6kt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-20_06,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 phishscore=0 malwarescore=0 mlxscore=0 clxscore=1015
 spamscore=0 suspectscore=0 mlxlogscore=999 lowpriorityscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502200104

On Tue, 2025-02-18 at 14:54 -0800, steven chen wrote:
> Carrying the IMA measurement list across kexec requires allocating a
> buffer and copying the measurement records.=C2=A0 Separate allocating the
> buffer and copying the measurement records into separate functions in
> order to allocate the buffer at kexec 'load' and copy the measurements
> at kexec 'execute'.
>=20
> This patch includes the following changes:
> =C2=A0- Refactor ima_dump_measurement_list() to move the memory allocatio=
n
> =C2=A0=C2=A0 to a separate function ima_alloc_kexec_file_buf() which allo=
cates
> =C2=A0=C2=A0 buffer of size 'kexec_segment_size' at kexec 'load'.
> =C2=A0- Make the local variable ima_kexec_file in ima_dump_measurement_li=
st()
> =C2=A0=C2=A0 a local static to the file, so that it can be accessed from=
=20
> =C2=A0=C2=A0 ima_alloc_kexec_file_buf(). Compare actual memory required t=
o ensure=20
> =C2=A0=C2=A0 there is enough memory for the entire measurement record.
> =C2=A0- Copy as many measurement events as possible.
> =C2=A0- Make necessary changes to the function ima_add_kexec_buffer() to =
call
> =C2=A0=C2=A0 the above two functions.
> =C2=A0- Compared the memory size allocated with memory size of the entire=
=20
> =C2=A0=C2=A0 measurement record. If there is not enough memory, it will c=
opy as many
> =C2=A0=C2=A0 IMA measurement records as possible, and this situation will=
 result
> =C2=A0=C2=A0 in a failure of remote attestation.
>=20
> Author: Tushar Sugandhi <tusharsu@linux.microsoft.com>

Steven, thank you again for picking up this patch set.

As previously explained, there is no tag named "Author" in
https://www.kernel.org/doc/Documentation/process/submitting-patches.rst.  T=
o give credit
to the original author use "Co-developed-by".  The "Co-developed-by:" tag i=
s immediately
followed by the original author's "Signed-off-by:" tag.  Please refer to th=
e document for
an example.

> Suggested-by: Mimi Zohar <zohar@linux.ibm.com>

<--- "Co-developed-by:" would go here.
> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> Signed-off-by: steven chen <chenste@linux.microsoft.com>
> ---
> =C2=A0security/integrity/ima/ima.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0=C2=A0 1 +
> =C2=A0security/integrity/ima/ima_kexec.c | 102 +++++++++++++++++++++-----=
---
> =C2=A0security/integrity/ima/ima_queue.c |=C2=A0=C2=A0 4 +-
> =C2=A03 files changed, 77 insertions(+), 30 deletions(-)
>=20
> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> index 24d09ea91b87..4428fcf42167 100644
> --- a/security/integrity/ima/ima.h
> +++ b/security/integrity/ima/ima.h
> @@ -274,6 +274,7 @@ bool ima_template_has_modsig(const struct ima_templat=
e_desc
> *ima_template);
> =C2=A0int ima_restore_measurement_entry(struct ima_template_entry *entry)=
;
> =C2=A0int ima_restore_measurement_list(loff_t bufsize, void *buf);
> =C2=A0int ima_measurements_show(struct seq_file *m, void *v);
> +int ima_get_binary_runtime_entry_size(struct ima_template_entry *entry);
> =C2=A0unsigned long ima_get_binary_runtime_size(void);
> =C2=A0int ima_init_template(void);
> =C2=A0void ima_init_template_list(void);
> diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/=
ima_kexec.c
> index 9d45f4d26f73..89088f1fa989 100644
> --- a/security/integrity/ima/ima_kexec.c
> +++ b/security/integrity/ima/ima_kexec.c
> @@ -15,63 +15,97 @@
> =C2=A0#include "ima.h"
> =C2=A0
> =C2=A0#ifdef CONFIG_IMA_KEXEC
> +static struct seq_file ima_kexec_file;
> +
> +static void ima_reset_kexec_file(struct seq_file *sf)
> +{
> +	sf->buf =3D NULL;
> +	sf->size =3D 0;
> +	sf->read_pos =3D 0;
> +	sf->count =3D 0;
> +}
> +
> +static void ima_free_kexec_file_buf(struct seq_file *sf)
> +{
> +	vfree(sf->buf);
> +	ima_reset_kexec_file(sf);
> +}
> +
> +static int ima_alloc_kexec_file_buf(size_t segment_size)
> +{
> +	/*
> +	 * kexec 'load' may be called multiple times.
> +	 * Free and realloc the buffer only if the segment_size is
> +	 * changed from the previous kexec 'load' call.
> +	 */
> +	if (ima_kexec_file.buf && ima_kexec_file.size =3D=3D segment_size)
> +		goto out;
> +
> +	ima_free_kexec_file_buf(&ima_kexec_file);
> +
> +	/* segment size can't change between kexec load and execute */
> +	ima_kexec_file.buf =3D vmalloc(segment_size);
> +	if (!ima_kexec_file.buf)
> +		return -ENOMEM;
> +
> +	ima_kexec_file.size =3D segment_size;
> +
> +out:
> +	ima_kexec_file.read_pos =3D 0;
> +	ima_kexec_file.count =3D sizeof(struct ima_kexec_hdr);	/* reserved spac=
e */
> +
> +	return 0;
> +}
> +

<--- ima_dump_measurement_list() function comment goes here.

> =C2=A0static int ima_dump_measurement_list(unsigned long *buffer_size, vo=
id **buffer,
> =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0 unsigned long segment_size)
> =C2=A0{
> =C2=A0	struct ima_queue_entry *qe;
> -	struct seq_file file;
> =C2=A0	struct ima_kexec_hdr khdr;
> =C2=A0	int ret =3D 0;
> +	size_t entry_size =3D 0;
> =C2=A0
> -	/* segment size can't change between kexec load and execute */
> -	file.buf =3D vmalloc(segment_size);
> -	if (!file.buf) {
> -		ret =3D -ENOMEM;
> -		goto out;
> +	if (!ima_kexec_file.buf) {
> +		pr_err("Kexec file buf not allocated\n");
> +		return -EINVAL;
> =C2=A0	}
> =C2=A0
> -	file.file =3D NULL;
> -	file.size =3D segment_size;
> -	file.read_pos =3D 0;
> -	file.count =3D sizeof(khdr);	/* reserved space */
> -
> =C2=A0	memset(&khdr, 0, sizeof(khdr));
> =C2=A0	khdr.version =3D 1;
> =C2=A0	/* This is an append-only list, no need to hold the RCU read lock =
*/
> +	/* Copy as many IMA measurements list records as possible */

Having two consecutive comments like this looks weird.  Please refer to sec=
tion "8)
Commenting" of https://www.kernel.org/doc/Documentation/process/coding-styl=
e.rst.=20

The first comment is particular to list_for_each_entry_rcu() and should rem=
ain here.  The
latter comment is more generic and should be included as part of a function=
 comment.

> =C2=A0	list_for_each_entry_rcu(qe, &ima_measurements, later, true) {
> -		if (file.count < file.size) {
> +		entry_size +=3D ima_get_binary_runtime_entry_size(qe->entry);
> +		if (entry_size <=3D segment_size) {

As much as possible splitting a function shouldn't change the existing code=
.  It makes it
harder to review.  This sort of change should be a separate patch with the =
Subject topic
line something like "ima: copy only complete measurement records across kex=
ec".  Making
this change as the first patch in the patch set will also allow it to be ba=
ckported.

> =C2=A0			khdr.count++;
> -			ima_measurements_show(&file, qe);
> +			ima_measurements_show(&ima_kexec_file, qe);
> =C2=A0		} else {
> =C2=A0			ret =3D -EINVAL;
> +			pr_err("IMA log file is too big for Kexec buf\n");
> =C2=A0			break;

We really DO want to "Copy as many IMA measurements list records as possibl=
e" as possible.
However, the code doesn't match the comment, since the caller of
ima_dump_measurement_list() treats -EINVAL as an error and bails.

> =C2=A0		}
> =C2=A0	}
> =C2=A0
> -	if (ret < 0)
> -		goto out;
> -
> =C2=A0	/*
> =C2=A0	 * fill in reserved space with some buffer details
> =C2=A0	 * (eg. version, buffer size, number of measurements)
> =C2=A0	 */
> -	khdr.buffer_size =3D file.count;
> +	khdr.buffer_size =3D ima_kexec_file.count;
> =C2=A0	if (ima_canonical_fmt) {
> =C2=A0		khdr.version =3D cpu_to_le16(khdr.version);
> =C2=A0		khdr.count =3D cpu_to_le64(khdr.count);
> =C2=A0		khdr.buffer_size =3D cpu_to_le64(khdr.buffer_size);
> =C2=A0	}
> -	memcpy(file.buf, &khdr, sizeof(khdr));
> +	memcpy(ima_kexec_file.buf, &khdr, sizeof(khdr));
> =C2=A0
> =C2=A0	print_hex_dump_debug("ima dump: ", DUMP_PREFIX_NONE, 16, 1,
> -			=C2=A0=C2=A0=C2=A0=C2=A0 file.buf, file.count < 100 ? file.count : 10=
0,
> +			=C2=A0=C2=A0=C2=A0=C2=A0 ima_kexec_file.buf, ima_kexec_file.count < 1=
00 ?
> +			=C2=A0=C2=A0=C2=A0=C2=A0 ima_kexec_file.count : 100,
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0 true);
> =C2=A0
> -	*buffer_size =3D file.count;
> -	*buffer =3D file.buf;
> -out:
> -	if (ret =3D=3D -EINVAL)
> -		vfree(file.buf);
> +	*buffer_size =3D ima_kexec_file.count;
> +	*buffer =3D ima_kexec_file.buf;
> +
> =C2=A0	return ret;
> =C2=A0}
> =C2=A0
> @@ -90,7 +124,7 @@ void ima_add_kexec_buffer(struct kimage *image)
> =C2=A0
> =C2=A0	/* use more understandable variable names than defined in kbuf */
> =C2=A0	void *kexec_buffer =3D NULL;
> -	size_t kexec_buffer_size;
> +	size_t kexec_buffer_size =3D 0;
> =C2=A0	size_t kexec_segment_size;
> =C2=A0	int ret;
> =C2=A0
> @@ -110,13 +144,19 @@ void ima_add_kexec_buffer(struct kimage *image)
> =C2=A0		return;
> =C2=A0	}
> =C2=A0
> -	ima_dump_measurement_list(&kexec_buffer_size, &kexec_buffer,
> -				=C2=A0 kexec_segment_size);
> -	if (!kexec_buffer) {
> +	ret =3D ima_alloc_kexec_file_buf(kexec_segment_size);
> +	if (ret < 0) {
> =C2=A0		pr_err("Not enough memory for the kexec measurement buffer.\n");
> =C2=A0		return;
> =C2=A0	}
> =C2=A0
> +	ret =3D ima_dump_measurement_list(&kexec_buffer_size, &kexec_buffer,
> +					kexec_segment_size);
> +	if (ret < 0) {
> +		pr_err("Failed to dump IMA measurements. Error:%d.\n", ret);
> +		return;
> +	}
> +

As mentioned above, we really do want to copy as many measurement records a=
s possible
across kexec.

> =C2=A0	kbuf.buffer =3D kexec_buffer;
> =C2=A0	kbuf.bufsz =3D kexec_buffer_size;
> =C2=A0	kbuf.memsz =3D kexec_segment_size;
> @@ -131,6 +171,12 @@ void ima_add_kexec_buffer(struct kimage *image)
> =C2=A0	image->ima_buffer_size =3D kexec_segment_size;
> =C2=A0	image->ima_buffer =3D kexec_buffer;
> =C2=A0
> +	/*
> +	 * kexec owns kexec_buffer after kexec_add_buffer() is called
> +	 * and it will vfree() that buffer.
> +	 */
> +	ima_reset_kexec_file(&ima_kexec_file);
> +
> =C2=A0	kexec_dprintk("kexec measurement buffer for the loaded kernel at 0=
x%lx.\n",
> =C2=A0		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kbuf.mem);
> =C2=A0}
> diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/=
ima_queue.c
> index 83d53824aa98..3dfd178d4292 100644
> --- a/security/integrity/ima/ima_queue.c
> +++ b/security/integrity/ima/ima_queue.c
> @@ -78,7 +78,7 @@ static struct ima_queue_entry *ima_lookup_digest_entry(=
u8
> *digest_value,
> =C2=A0 * binary_runtime_measurement list entry, which contains a
> =C2=A0 * couple of variable length fields (e.g template name and data).
> =C2=A0 */
> -static int get_binary_runtime_size(struct ima_template_entry *entry)
> +int ima_get_binary_runtime_entry_size(struct ima_template_entry *entry)
> =C2=A0{
> =C2=A0	int size =3D 0;
> =C2=A0
> @@ -122,7 +122,7 @@ static int ima_add_digest_entry(struct ima_template_e=
ntry *entry,
> =C2=A0	if (binary_runtime_size !=3D ULONG_MAX) {
> =C2=A0		int size;
> =C2=A0
> -		size =3D get_binary_runtime_size(entry);
> +		size =3D ima_get_binary_runtime_entry_size(entry);
> =C2=A0		binary_runtime_size =3D (binary_runtime_size < ULONG_MAX - size) =
?
> =C2=A0		=C2=A0=C2=A0=C2=A0=C2=A0 binary_runtime_size + size : ULONG_MAX;
> =C2=A0	}

This change would be included in the new first patch named something like "=
ima: copy only
complete measurement records across kexec".

Thanks,

Mimi

