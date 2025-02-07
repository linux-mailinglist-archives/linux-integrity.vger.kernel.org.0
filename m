Return-Path: <linux-integrity+bounces-4746-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC4F7A2C9CE
	for <lists+linux-integrity@lfdr.de>; Fri,  7 Feb 2025 18:07:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D096016E2A9
	for <lists+linux-integrity@lfdr.de>; Fri,  7 Feb 2025 17:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83E3519AA58;
	Fri,  7 Feb 2025 17:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gx8VLi6e"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D05199EA2;
	Fri,  7 Feb 2025 17:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738948003; cv=none; b=DG0ofOADuakpS6FTRVEaZRs347cTWciN8+9JZMuEtKIV+mb0hzlkPgCRqK5xbGxZT3U8eP5PIqXQ9AIzoeus5Y1fPQfJQaJJFaefyPCW8bOKqMLh5eU6LX+cEXwLrOXXfFcz3a6wmp0JU4R9jbQL92rVqNoGO7VhML349IC39Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738948003; c=relaxed/simple;
	bh=24oarv+IObo4UeWb5G+5XeZXL+zdNmU3e1gfHXqBXzw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=q39n77Y4fNiYAcSqLFOpSccqCwaeOQpgINXAKuzvT27yuUce6iiy7M9dLp4FJBKKlDeJYaTlFAFoTq4/Y5tpWhNAvpKkPvIFF32U6qpa+NNWQ+va1agSFR5NNXwPn8s5a44AQzwx6DQYh4sjvIPNOAuiSR0fvF6liWMCLUYKHx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gx8VLi6e; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5179XT6H004555;
	Fri, 7 Feb 2025 17:06:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=54Xfwu
	4/GToOP5Zl32ytSm70BG/vxYlK2vCwVL3vTfE=; b=gx8VLi6eLM0hk7VPsV1SkH
	/rNxlo+l3GvbB17IsWWzfBN0ZlXCEmMpFwNMlt6YUz5TP7nleIbTZ73FvjwVclcH
	Go4myr6VOv4O51AREPK4VGzthTsElnYhiebqcchHMDP548o5oF19VjIBUlqyhUD/
	gNtdWd5E+4uxsnQTzZNqb0048B1AxTpaIk531XTreIwKH07+zTmobp41ciwOoSjW
	JZMWq0Gk248FzIWNcagv6v7u5FXsLt/PhUe0Htf02i2tp1ma3EkI1lkWbYjmr46X
	fg7pLRN7dMP6i6pj7V3m2xHbnXTHkBT4+mlxoxVTUIIEcwKho9mZT8RbHjqf+IpA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44nfn5j9ft-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Feb 2025 17:06:14 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 517FHJvE007139;
	Fri, 7 Feb 2025 17:06:13 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44hxb04mns-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Feb 2025 17:06:13 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 517H6CKS31392456
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Feb 2025 17:06:13 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AD9BC58052;
	Fri,  7 Feb 2025 17:06:12 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B9AD75805A;
	Fri,  7 Feb 2025 17:06:11 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.80.253])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  7 Feb 2025 17:06:11 +0000 (GMT)
Message-ID: <b2b3fa5d3d20284f790ce74bb97da2b9795a0e0e.camel@linux.ibm.com>
Subject: Re: [PATCH v7 7/7] ima: measure kexec load and exec events as
 critical data
From: Mimi Zohar <zohar@linux.ibm.com>
To: steven chen <chenste@linux.microsoft.com>, stefanb@linux.ibm.com,
        roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
        eric.snowberg@oracle.com, ebiederm@xmission.com, paul@paul-moore.com,
        code@tyhicks.com, bauermann@kolabnow.com,
        linux-integrity@vger.kernel.org, kexec@lists.infradead.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: madvenka@linux.microsoft.com, nramas@linux.microsoft.com,
        James.Bottomley@HansenPartnership.com
Date: Fri, 07 Feb 2025 12:06:11 -0500
In-Reply-To: <3a4053664cde06622e1f9a9d8e3a5aab80b9beb7.camel@linux.ibm.com>
References: <20250203232033.64123-1-chenste@linux.microsoft.com>
	 <20250203232033.64123-9-chenste@linux.microsoft.com>
	 <3a4053664cde06622e1f9a9d8e3a5aab80b9beb7.camel@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: NFngXqVEGlApAhs95P6oeKLezjp3gWro
X-Proofpoint-GUID: NFngXqVEGlApAhs95P6oeKLezjp3gWro
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-07_08,2025-02-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 suspectscore=0 mlxscore=0 adultscore=0 priorityscore=1501 bulkscore=0
 mlxlogscore=999 clxscore=1015 spamscore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502070127

On Fri, 2025-02-07 at 10:16 -0500, Mimi Zohar wrote:
> On Mon, 2025-02-03 at 15:20 -0800, steven chen wrote:
> > The amount of memory allocated at kexec load, even with the extra memor=
y
> > allocated, might not be large enough for the entire measurement list.=
=C2=A0 The
> > indeterminate interval between kexec 'load' and 'execute' could exacerb=
ate
> > this problem.
> >=20
> > Define two new IMA events, 'kexec_load' and 'kexec_execute', to be=20
> > measured as critical data at kexec 'load' and 'execute' respectively.
> > Report the allocated kexec segment size, IMA binary log size and the
> > runtime measurements count as part of those events.
> >=20
> > These events, and the values reported through them, serve as markers in
> > the IMA log to verify the IMA events are captured during kexec soft
> > reboot.=C2=A0 The presence of a 'kexec_load' event in between the last =
two
> > 'boot_aggregate' events in the IMA log implies this is a kexec soft
> > reboot, and not a cold-boot. And the absence of 'kexec_execute' event
> > after kexec soft reboot implies missing events in that window which
> > results in inconsistency with TPM PCR quotes, necessitating a cold boot
> > for a successful remote attestation.
>=20
> As a reminder, please include directions for verifying the buffer data ha=
sh against
> the buffer data.=C2=A0 The directions would be similar to those in commit=
 6b4da8c0e7f
> ("IMA: Define a new template field buf").
>=20
> >=20
> > Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> > Author: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> > Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> > Signed-off-by: steven chen <chenste@linux.microsoft.com>
> > ---
> > =C2=A0security/integrity/ima/ima_kexec.c | 23 +++++++++++++++++++++++
> > =C2=A01 file changed, 23 insertions(+)
> >=20
> > diff --git a/security/integrity/ima/ima_kexec.c
> > b/security/integrity/ima/ima_kexec.c
> > index c9c916f69ca7..0342ddfa9342 100644
> > --- a/security/integrity/ima/ima_kexec.c
> > +++ b/security/integrity/ima/ima_kexec.c
> > @@ -17,6 +17,8 @@
> > =C2=A0#include "ima.h"
> > =C2=A0
> > =C2=A0#ifdef CONFIG_IMA_KEXEC
> > +#define IMA_KEXEC_EVENT_LEN 256
> > +
> > =C2=A0static struct seq_file ima_kexec_file;
> > =C2=A0static void *ima_kexec_buffer;
> > =C2=A0static size_t kexec_segment_size;
> > @@ -36,6 +38,24 @@ static void ima_free_kexec_file_buf(struct seq_file =
*sf)
> > =C2=A0	ima_reset_kexec_file(sf);
> > =C2=A0}
> > =C2=A0
> > +static void ima_measure_kexec_event(const char *event_name)
> > +{
> > +	char ima_kexec_event[IMA_KEXEC_EVENT_LEN];
> > +	size_t buf_size =3D 0;
> > +	long len;
> > +
> > +	buf_size =3D ima_get_binary_runtime_size();
> > +	len =3D atomic_long_read(&ima_htable.len);
> > +
> > +	scnprintf(ima_kexec_event, IMA_KEXEC_EVENT_LEN,
> > +			"kexec_segment_size=3D%lu;ima_binary_runtime_size=3D%lu;"
> > +			"ima_runtime_measurements_count=3D%ld;",
> > +				kexec_segment_size, buf_size, len);
>=20
> From scripts/checkpatch.pl, "Alignment should match open parenthesis".=
=20
>=20
> > +
> > +	ima_measure_critical_data("ima_kexec", event_name, ima_kexec_event,
> > +					strlen(ima_kexec_event), false, NULL,
> > 0);
>=20
> From the kernel-doc scnprintf(), returns the number of bytes.=C2=A0 There=
 should be no
> need to calculate it using strlen().
>=20
> > +}
> > +
> > =C2=A0static int ima_alloc_kexec_file_buf(size_t segment_size)
> > =C2=A0{
> > =C2=A0	/*
> > @@ -60,6 +80,7 @@ static int ima_alloc_kexec_file_buf(size_t segment_si=
ze)
> > =C2=A0out:
> > =C2=A0	ima_kexec_file.read_pos =3D 0;
> > =C2=A0	ima_kexec_file.count =3D sizeof(struct ima_kexec_hdr);	/* reserv=
ed
> > space
> > */
> > +	ima_measure_kexec_event("kexec_load");
> > =C2=A0
> > =C2=A0	return 0;
> > =C2=A0}
> > @@ -201,6 +222,8 @@ static int ima_update_kexec_buffer(struct notifier_=
block
> > *self,
> > =C2=A0		return ret;
> > =C2=A0	}
> > =C2=A0
> > +	ima_measure_kexec_event("kexec_execute");
> > +
> > =C2=A0	ret =3D ima_dump_measurement_list(&buf_size, &buf,
> > =C2=A0					kexec_segment_size);
> > =C2=A0
>=20
> After fixing up and applying this patch set to 6.14.0-rc1, I'm not seeing=
 the
> "kexec_execute".=C2=A0 Even after changing the default extra memory, I'm =
still not
> seeing
> the measurement.

FYI, after reverting commit 254ef9541d68 ("ima: Suspend PCR extends and log=
 appends
when rebooting"), I'm seeing the "kexec_execute" measurement.

Mimi



