Return-Path: <linux-integrity+bounces-4968-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E9D4A3FF4F
	for <lists+linux-integrity@lfdr.de>; Fri, 21 Feb 2025 20:07:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A1DC167F10
	for <lists+linux-integrity@lfdr.de>; Fri, 21 Feb 2025 19:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C3E21FBC86;
	Fri, 21 Feb 2025 19:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Qj+db7xu"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337631D7E50;
	Fri, 21 Feb 2025 19:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740164862; cv=none; b=nFdqY3AF0SpCBsZq+a7IQE3JLWGzZaCB/zol+Ubsx2kmoO4x9ZwX5ezRQDEH9cE6g0d+XBCFqiqyxneiyBPHJvzjqIBqOr5lZFr5RtG5dGp4zRY6uszD0zJ7xaLmXbgR2U3zOprVZetlBPjVLGxdFPjAt8DfnUKIbPMXsSPFfiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740164862; c=relaxed/simple;
	bh=DbrqP0BacaSAXAnoX53ZZJOcVs7BxL29Huazrq9X37k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CGtRhdd/lSi/SDvihhYFWgq686oe5FKc4NH1t/f4ehIYWvxCFcEo2HZ1LDwbjay/HplVZoiFPxGGICOBXhH/Ehsvu3JGMR3xkjW0j9H9Fme60LAp2+0Gt6rSvKwwyAuCoOPgFbSHDzkbOK6xccYdx1p1e/+FQIOV1Us76XPU3Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Qj+db7xu; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51LIMe4x031829;
	Fri, 21 Feb 2025 19:07:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=heDO+g
	AI4iMzWupr9MuQuH5tFKokm/yoJasfRTU3cp0=; b=Qj+db7xuvQd+nLbmOaiux2
	t+dRcrAR5dmeYNxeHzpBkasiuD429gJdAjnZDSxHONM9ufyDtezX5oGPoWAtvtOf
	ODXcoEubCilZiTOwHVyLuyW/4I1TcywKpvsk9S3Gr9O3UtvUOiku5JWNAkxhBbhn
	nQIazWPTtCUMDzxxV9BAb3EZZYrN7giiqGkzy0vOAiwsqzjbSg5TTHuc4mgkh18D
	0x6tPCQliBF4xyVQKSAcPdd92tbI5m9jkeNO5Xr7In9Gd0IO6ZbIkMotkpL9uoVB
	Hbm0DJIEXtsKbo9B+zqK/Wy7eWKlCqeMH9P/KzLvza6FaH657PpkisP2ZvKdJ6uQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44xgb0ck69-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Feb 2025 19:07:14 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51LIkAsL002433;
	Fri, 21 Feb 2025 19:07:13 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 44w03xhnkn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Feb 2025 19:07:13 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51LJ7DoQ32244352
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Feb 2025 19:07:13 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 39CA158052;
	Fri, 21 Feb 2025 19:07:13 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1634658065;
	Fri, 21 Feb 2025 19:07:12 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.108.12])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 21 Feb 2025 19:07:12 +0000 (GMT)
Message-ID: <36f8cb5131c51f784fa6e7a062b6318b30c9cc28.camel@linux.ibm.com>
Subject: Re: [PATCH v8 4/7] ima: kexec: define functions to copy IMA log at
 soft boot
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
Date: Fri, 21 Feb 2025 14:07:11 -0500
In-Reply-To: <20250218225502.747963-5-chenste@linux.microsoft.com>
References: <20250218225502.747963-1-chenste@linux.microsoft.com>
	 <20250218225502.747963-5-chenste@linux.microsoft.com>
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
X-Proofpoint-GUID: tl1t-f3xrxoME_Ejbk6c9jgxYK4Zw_1d
X-Proofpoint-ORIG-GUID: tl1t-f3xrxoME_Ejbk6c9jgxYK4Zw_1d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-21_07,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 malwarescore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0
 impostorscore=0 priorityscore=1501 phishscore=0 adultscore=0 mlxscore=0
 bulkscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502210131

On Tue, 2025-02-18 at 14:54 -0800, steven chen wrote:
> IMA log is copied to the new Kernel during kexec 'load' using=20
> ima_dump_measurement_list().=C2=A0 The log copy at kexec 'load' may resul=
t in
> loss of IMA measurements during kexec soft reboot.=C2=A0 It needs to be c=
opied
> over during kexec 'execute'.=C2=A0 Setup the needed infrastructure to mov=
e the
> IMA log copy from kexec 'load' to 'execute'.=20
>=20
> Define a new IMA hook ima_update_kexec_buffer() as a stub function.
> It will be used to call ima_dump_measurement_list() during kexec=20
> 'execute'.=C2=A0=C2=A0=20
>=20
> Implement ima_kexec_post_load() function to be invoked after the new=20
> Kernel image has been loaded for kexec. ima_kexec_post_load() maps the=
=20
> IMA buffer to a segment in the newly loaded Kernel.=C2=A0 It also registe=
rs=20
> the reboot notifier_block to trigger ima_update_kexec_buffer() at=20
> exec 'execute'.
>=20
> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> Signed-off-by: steven chen <chenste@linux.microsoft.com>
> ---
> =C2=A0include/linux/ima.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 3 ++
> =C2=A0security/integrity/ima/ima_kexec.c | 46 +++++++++++++++++++++++++++=
+++
> =C2=A02 files changed, 49 insertions(+)
>=20
> diff --git a/include/linux/ima.h b/include/linux/ima.h
> index 0bae61a15b60..8e29cb4e6a01 100644
> --- a/include/linux/ima.h
> +++ b/include/linux/ima.h
> @@ -32,6 +32,9 @@ static inline void ima_appraise_parse_cmdline(void) {}
> =C2=A0
> =C2=A0#ifdef CONFIG_IMA_KEXEC
> =C2=A0extern void ima_add_kexec_buffer(struct kimage *image);
> +extern void ima_kexec_post_load(struct kimage *image);
> +#else
> +static inline void ima_kexec_post_load(struct kimage *image) {}
> =C2=A0#endif
> =C2=A0
> =C2=A0#else
> diff --git a/security/integrity/ima/ima_kexec.c
> b/security/integrity/ima/ima_kexec.c
> index 704676fa6615..0fa65f91414b 100644
> --- a/security/integrity/ima/ima_kexec.c
> +++ b/security/integrity/ima/ima_kexec.c
> @@ -12,10 +12,14 @@
> =C2=A0#include <linux/kexec.h>
> =C2=A0#include <linux/of.h>
> =C2=A0#include <linux/ima.h>
> +#include <linux/reboot.h>
> +#include <asm/page.h>
> =C2=A0#include "ima.h"
> =C2=A0
> =C2=A0#ifdef CONFIG_IMA_KEXEC
> =C2=A0static struct seq_file ima_kexec_file;
> +static void *ima_kexec_buffer;
> +static bool ima_kexec_update_registered;
> =C2=A0
> =C2=A0static void ima_reset_kexec_file(struct seq_file *sf)
> =C2=A0{
> @@ -183,6 +187,48 @@ void ima_add_kexec_buffer(struct kimage *image)
> =C2=A0	kexec_dprintk("kexec measurement buffer for the loaded kernel at
> 0x%lx.\n",
> =C2=A0		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kbuf.mem);
> =C2=A0}
> +
> +/*
> + * Called during kexec execute so that IMA can update the measurement li=
st.
> + */
> +static int ima_update_kexec_buffer(struct notifier_block *self,
> +				=C2=A0=C2=A0 unsigned long action, void *data)
> +{
> +	return NOTIFY_OK;
> +}
> +
> +struct notifier_block update_buffer_nb =3D {
> +	.notifier_call =3D ima_update_kexec_buffer,
> +};
> +
> +/*
> + * Create a mapping for the source pages that contain the IMA buffer
> + * so we can update it later.
> + */

Hi Steven,

It does more than just that.  It also registers a second IMA reboot notifie=
r.=20
(Is a second reboot notifier really necessary?)  It seems that the
ima_reboot_notifier() is executed after this one, otherwise the kexec_execu=
te
would be missing.  However, I'm not sure that is guaranteed.

I'm wondering if this patch should be limited to saving the map segments.  =
In
any case, using the reboot notifier is relatively new and should at least b=
e
reflected here and in the patch description.

thanks,

Mimi

> +void ima_kexec_post_load(struct kimage *image)
> +{
> +	if (ima_kexec_buffer) {
> +		kimage_unmap_segment(ima_kexec_buffer);
> +		ima_kexec_buffer =3D NULL;
> +	}
> +
> +	if (!image->ima_buffer_addr)
> +		return;
> +
> +	ima_kexec_buffer =3D kimage_map_segment(image,
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 image->ima_buffer_addr,
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 image->ima_buffer_size);
> +	if (!ima_kexec_buffer) {
> +		pr_err("Could not map measurements buffer.\n");
> +		return;
> +	}
> +
> +	if (!ima_kexec_update_registered) {
> +		register_reboot_notifier(&update_buffer_nb);
> +		ima_kexec_update_registered =3D true;
> +	}
> +}
> +
> =C2=A0#endif /* IMA_KEXEC */
> =C2=A0
> =C2=A0/*


