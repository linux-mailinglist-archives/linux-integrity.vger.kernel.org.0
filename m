Return-Path: <linux-integrity+bounces-5323-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6AB8A68E51
	for <lists+linux-integrity@lfdr.de>; Wed, 19 Mar 2025 14:55:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E534D1897023
	for <lists+linux-integrity@lfdr.de>; Wed, 19 Mar 2025 13:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A68DB374EA;
	Wed, 19 Mar 2025 13:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hhQtIAD8"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED567D2FB;
	Wed, 19 Mar 2025 13:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742392071; cv=none; b=tNmz2mvjrZjjUNjvX0gUgU2FQNeNXRHtIIm5ybHVR7Hybx9+wl5RZGKh8aA3Nl/3CinGEZ/0aHSzufViXrusuELhQy+M9ioVotmJrfVHa2TR+eixHhJ8n9wWAANwybPBG5lRqNz+HTntc8lM8DYO3TyN/nkV6WQSWViz29NAr0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742392071; c=relaxed/simple;
	bh=+A/gnFa3tJXba6oQjNpasyUiGoJgAi65ZnKOzeviY7E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=G8ntMERBWT9oNJbS20gx366xKytpn2573EqW9rXbNWZrb9KPLm5j/IkVgR+npmNt3tMIq8UPs6wjaDnyiUV575htcpupRfSR/GhW4h+y64/s8KKZOxgowDiUUkTutM9Ma2pkPoq4rtYTF3XoirA/cZTcqCqvh6YzZ+Tg6VMB+Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hhQtIAD8; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52JCwqVm027756;
	Wed, 19 Mar 2025 13:42:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=hibXXx
	1/tkAqZb4o1JLhcDjbMgUARFxDE4ALNQxZcMc=; b=hhQtIAD8t4t2WtJ4l0UN/C
	5NV/Aw7WCrcUSBJoAAJ1S0DeWBVe8Evn1Sx3Yl1A62jZ/NUfw+/ozdKRfFi7VvTR
	GE707mtlFKQN2iR1AlgzL895bvB5ezBSj4X/OQS7I2WMKc/csnZuzXfHpkiMHZtd
	IL2Ty4eRzZkUiGys36HiHyg6ox4QNY5q/5cCbH+aKNG51l3CNzFGSRjQDUVbP0hD
	TGeMmLL3lQ9cqVmOH/SIUIjCaXYNg94aautZM5sXA2+8//XVsLxizbDcPQpWnNox
	Nw/VFlvPXU+gR0OeiVm8fGmASgZI0Eo2Qt8VonNJ6+KQ9yDiKcBFDr6+dSTDuNLg
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45fa8pe72u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Mar 2025 13:42:17 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52JBMNMB023214;
	Wed, 19 Mar 2025 13:42:16 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 45dp3ksndp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Mar 2025 13:42:16 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52JDgFUU26083906
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Mar 2025 13:42:15 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6FE2258057;
	Wed, 19 Mar 2025 13:42:15 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 48B9658061;
	Wed, 19 Mar 2025 13:42:14 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.177.219])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 19 Mar 2025 13:42:14 +0000 (GMT)
Message-ID: <255e75954d9418e2658a6eba6879804c31b3713f.camel@linux.ibm.com>
Subject: Re: [PATCH v10 1/8] ima: rename variable the ser_file "file" to
 "ima_kexec_file"
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
Date: Wed, 19 Mar 2025 09:42:13 -0400
In-Reply-To: <20250318010448.954-2-chenste@linux.microsoft.com>
References: <20250318010448.954-1-chenste@linux.microsoft.com>
	 <20250318010448.954-2-chenste@linux.microsoft.com>
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
X-Proofpoint-GUID: S3orxwh3KxQBkV_RUEJ9W7ZkTdvzT8VT
X-Proofpoint-ORIG-GUID: S3orxwh3KxQBkV_RUEJ9W7ZkTdvzT8VT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-19_05,2025-03-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 mlxscore=0 spamscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 adultscore=0 phishscore=0 mlxlogscore=999 lowpriorityscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503190092

Fix spelling: set_file


On Mon, 2025-03-17 at 18:04 -0700, steven chen wrote:
> The name of the local variable "file" of type seq_file defined in the
> ima_dump_measurement_list function is too generic. To better reflect the
> purpose of the variable, rename it to "ima_kexec_file". This change will=
=20
> help improve code readability and maintainability by making the variable'=
s
> role more explicit.

The reason for making the variable name change is the variable scope.

-> Before making the function local seq_file "file" variable global, rename=
 it
to ima_kexec_file.

>=20
> The variable ima_kexec_file is indeed the memory allocated for copying IM=
A
> measurement records. The ima_dump_measurement_list function calculates th=
e=20
> actual memory occupied by the IMA logs and compares it with the allocated=
=20
> memory. If there is enough memory, it copies all IMA measurement records;=
=20
> otherwise, it does not copy any records, which would result in a failure
> of remote attestation.

This paragraph is not applicable to the patch change.

>=20
> Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
> Signed-off-by: steven chen <chenste@linux.microsoft.com>
> ---
>  security/integrity/ima/ima_kexec.c | 39 ++++++++++++++++++------------
>  1 file changed, 24 insertions(+), 15 deletions(-)
>=20
> diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/=
ima_kexec.c
> index 9d45f4d26f73..8567619889d1 100644
> --- a/security/integrity/ima/ima_kexec.c
> +++ b/security/integrity/ima/ima_kexec.c
> @@ -15,33 +15,41 @@
>  #include "ima.h"
> =20
>  #ifdef CONFIG_IMA_KEXEC
> +/*
> + * Copy the measurement list to the allocated memory
> + * compare the size of IMA measurement list with the size of the allocat=
ed memory
> + *    if the size of the allocated memory is not less than the size of I=
MA measurement list
> + *        copy the measurement list to the allocated memory.
> + *    else
> + *        return error
> + */

Please minimize patch changes.  Before posting, please look at the patch(s)=
 and
remove anything not applicable to it.  In this case, the comment is not
applicable to the variable name change.

thanks,

Mimi
 =20
>  static int ima_dump_measurement_list(unsigned long *buffer_size, void **=
buffer,
>  				     unsigned long segment_size)
>  {
> +	struct seq_file ima_kexec_file;
>  	struct ima_queue_entry *qe;
> -	struct seq_file file;
>  	struct ima_kexec_hdr khdr;
>  	int ret =3D 0;
> =20
>  	/* segment size can't change between kexec load and execute */
> -	file.buf =3D vmalloc(segment_size);
> -	if (!file.buf) {
> +	ima_kexec_file.buf =3D vmalloc(segment_size);
> +	if (!ima_kexec_file.buf) {
>  		ret =3D -ENOMEM;
>  		goto out;
>  	}
> =20
> -	file.file =3D NULL;
> -	file.size =3D segment_size;
> -	file.read_pos =3D 0;
> -	file.count =3D sizeof(khdr);	/* reserved space */
> +	ima_kexec_file.file =3D NULL;
> +	ima_kexec_file.size =3D segment_size;
> +	ima_kexec_file.read_pos =3D 0;
> +	ima_kexec_file.count =3D sizeof(khdr);	/* reserved space */
> =20
>  	memset(&khdr, 0, sizeof(khdr));
>  	khdr.version =3D 1;
>  	/* This is an append-only list, no need to hold the RCU read lock */
>  	list_for_each_entry_rcu(qe, &ima_measurements, later, true) {
> -		if (file.count < file.size) {
> +		if (ima_kexec_file.count < ima_kexec_file.size) {
>  			khdr.count++;
> -			ima_measurements_show(&file, qe);
> +			ima_measurements_show(&ima_kexec_file, qe);
>  		} else {
>  			ret =3D -EINVAL;
>  			break;
> @@ -55,23 +63,24 @@ static int ima_dump_measurement_list(unsigned long *b=
uffer_size, void **buffer,
>  	 * fill in reserved space with some buffer details
>  	 * (eg. version, buffer size, number of measurements)
>  	 */
> -	khdr.buffer_size =3D file.count;
> +	khdr.buffer_size =3D ima_kexec_file.count;
>  	if (ima_canonical_fmt) {
>  		khdr.version =3D cpu_to_le16(khdr.version);
>  		khdr.count =3D cpu_to_le64(khdr.count);
>  		khdr.buffer_size =3D cpu_to_le64(khdr.buffer_size);
>  	}
> -	memcpy(file.buf, &khdr, sizeof(khdr));
> +	memcpy(ima_kexec_file.buf, &khdr, sizeof(khdr));
> =20
>  	print_hex_dump_debug("ima dump: ", DUMP_PREFIX_NONE, 16, 1,
> -			     file.buf, file.count < 100 ? file.count : 100,
> +			     ima_kexec_file.buf, ima_kexec_file.count < 100 ?
> +			     ima_kexec_file.count : 100,
>  			     true);
> =20
> -	*buffer_size =3D file.count;
> -	*buffer =3D file.buf;
> +	*buffer_size =3D ima_kexec_file.count;
> +	*buffer =3D ima_kexec_file.buf;
>  out:
>  	if (ret =3D=3D -EINVAL)
> -		vfree(file.buf);
> +		vfree(ima_kexec_file.buf);
>  	return ret;
>  }
> =20


