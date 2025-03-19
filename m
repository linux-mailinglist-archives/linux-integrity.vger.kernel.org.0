Return-Path: <linux-integrity+bounces-5327-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64034A69A5F
	for <lists+linux-integrity@lfdr.de>; Wed, 19 Mar 2025 21:57:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4223189739A
	for <lists+linux-integrity@lfdr.de>; Wed, 19 Mar 2025 20:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFF9010E0;
	Wed, 19 Mar 2025 20:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SI8odV4G"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F7620A5DD;
	Wed, 19 Mar 2025 20:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742417676; cv=none; b=eZayIDJ8qr6/gqmdHp9JHupCUWgsufe2unH0f8YU9R0xMScwXMRI0ww/lJzWcbikt89qqcUYKMSibccT2ip3ah93nT6cnTGO43E3hb/v0wdMHQ409m130Cb/pKw2Ic/0aTJ9xegyMSgaU2OJNfaewXkjwipmpxqfW4nzF6aQDt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742417676; c=relaxed/simple;
	bh=jhe5TRPk7AgQ53zutL2dS9nwuVf3KdoiTWwmafACBrQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lRxtE9WUwpePXKWHTKKOSbgB1BpAKcPA0JGu3oEdQTus/fPC5Gq/Z2vFsoogtXCSWSzxP2pQB8zyyV/FFMAoDZvkiD1LrSvE3pqQqct+73LndVgkd6SDQyYsfNWg3gvqcNOy6iKYgwBUpRrU6uLAjJZQX4k6EWaUwN3+0JFKM+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SI8odV4G; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52JHefsb011955;
	Wed, 19 Mar 2025 20:53:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=yE4VMn
	192WN9LXIae9KIuJmw1l5jr0rfKiIFPJaHyxA=; b=SI8odV4GPq2T6rRuuPLJ+I
	G6jLNQc1r91b8CTCrzFA8OjVGzaEdDAAAFLsOkQ/pUKZ0xEvA4hxqMa+mvHLs7Gb
	FKApKVhlYvuy0TyXT+Q4ctPWpdn3X7awJEQwFIsYRu68YxbyJFNk7SraQVPwIpeP
	VvggxpENyQCGMsfy+eEDiEoT3ZhCYM99A/hEE6DeEj88q1GKk1byfKzp2WXxY2fJ
	FFGlhubaG1lgxpfhPVL/Ak4ZRJtxortc/qqh2WpEx+dMRyi1NZrinNm3U/g0zU+5
	fmo3tMpOo4bSl4iAr9os5I4m1rkNHy8J1F4mAOA7Lo1RqMZ2o9oVm1JF1L0NLepw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45fwy22sut-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Mar 2025 20:53:49 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52JHwt5W005635;
	Wed, 19 Mar 2025 20:53:48 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45dm9040cq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Mar 2025 20:53:48 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52JKrlns12976696
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Mar 2025 20:53:47 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7984C58066;
	Wed, 19 Mar 2025 20:53:47 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 793BD5805D;
	Wed, 19 Mar 2025 20:53:45 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.80.224])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 19 Mar 2025 20:53:45 +0000 (GMT)
Message-ID: <b3491376fc2137f930755a3ab5591ac0982a9540.camel@linux.ibm.com>
Subject: Re: [PATCH v10 6/8] ima: kexec: move IMA log copy from kexec load
 to execute
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
Date: Wed, 19 Mar 2025 16:53:44 -0400
In-Reply-To: <20250318010448.954-7-chenste@linux.microsoft.com>
References: <20250318010448.954-1-chenste@linux.microsoft.com>
	 <20250318010448.954-7-chenste@linux.microsoft.com>
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
X-Proofpoint-ORIG-GUID: NSEznNJZwO53Fdc7avUwq61S5_BLCk4K
X-Proofpoint-GUID: NSEznNJZwO53Fdc7avUwq61S5_BLCk4K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-19_07,2025-03-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 bulkscore=0 spamscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 adultscore=0 priorityscore=1501 mlxscore=0 lowpriorityscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503190137

On Mon, 2025-03-17 at 18:04 -0700, steven chen wrote:
> ima_dump_measurement_list() is called during kexec 'load', which may
> result in loss of IMA measurements during kexec soft reboot. Due to=20
> missed measurements that only occurred after kexec 'load', this function=
=20
> needs to be called during kexec 'execute'.

-> , defer calling ima_dump_measurement_list() to kexec 'execute'.

>=20
> This patch includes the following changes:
>  - Implement kimage_file_post_load() function to be invoked after the new
>    kernel image has been loaded for kexec.
>  - Call kimage_file_post_load() from kexec_file_load() syscall only for
>    kexec soft reboot scenarios and not for KEXEC_FILE_ON_CRASH.  It will
>    map the IMA segment, and register reboot notifier for the function
>    ima_update_kexec_buffer() which would copy the IMA log at kexec soft
>    reboot.
>  - Make kexec_segment_size variable local static to the file so that it=
=20
>    becomes accessible both during kexec 'load' and 'execute'.
>  - Move ima_dump_measurement_list() call from ima_add_kexec_buffer()
>    to ima_update_kexec_buffer().
>  - Copy the measurement list as much as possible.

Let's summarize the above changes, as below, and then remove the list.

Define and call the new kimage_file_post_load() to call ima_kexec_post_load=
(),
which registers the reboot notifier (ima_update_kexec_buffer).

Finally, move ima_dump_measurement_list() from ima_add_kexec_buffer()
to ima_update_kexec_buffer() to defer copying the measurement list.

>  - Remove ima_reset_kexec_file() call from ima_add_kexec_buffer(), now
>    that the buffer is being copied at kexec 'execute', and resetting the
>    file at kexec 'load' would corrupt the buffer.

Instead of adding and then removing the ima_reset_kexec_file() call from
ima_add_kexec_buffer(), defer adding the test in ima_alloc_kexec_file_buf()=
 to
see if the segment size has changed.  That should be a subsequent patch, af=
ter
this one.

ima_reset_kexec_file() is then ever called from only one place.  Combine
ima_reset_kexec_file() with ima_free_kexec_file_buf().

thanks,

Mimi

>=20
> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> Cc: Eric Biederman <ebiederm@xmission.com>
> Cc: Baoquan He <bhe@redhat.com>=20
> Cc: Vivek Goyal <vgoyal@redhat.com>
> Cc: Dave Young <dyoung@redhat.com>
> Signed-off-by: steven chen <chenste@linux.microsoft.com>
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> ---
>  kernel/kexec_file.c                | 10 ++++++
>  security/integrity/ima/ima_kexec.c | 51 ++++++++++++++++++------------
>  2 files changed, 40 insertions(+), 21 deletions(-)
>=20
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index 606132253c79..ab449b43aaee 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -201,6 +201,13 @@ kimage_validate_signature(struct kimage *image)
>  }
>  #endif
> =20
> +static void kimage_file_post_load(struct kimage *image)
> +{
> +#ifdef CONFIG_IMA_KEXEC
> +	ima_kexec_post_load(image);
> +#endif
> +}
> +
>  /*
>   * In file mode list of segments is prepared by kernel. Copy relevant
>   * data from user space, do error checking, prepare segment list
> @@ -428,6 +435,9 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int,=
 initrd_fd,
> =20
>  	kimage_terminate(image);
> =20
> +	if (!(flags & KEXEC_FILE_ON_CRASH))
> +		kimage_file_post_load(image);
> +
>  	ret =3D machine_kexec_post_load(image);
>  	if (ret)
>  		goto out;
> diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/=
ima_kexec.c
> index 9336c4f60650..c390c745f882 100644
> --- a/security/integrity/ima/ima_kexec.c
> +++ b/security/integrity/ima/ima_kexec.c
> @@ -19,6 +19,7 @@
>  #ifdef CONFIG_IMA_KEXEC
>  static bool ima_kexec_update_registered;
>  static struct seq_file ima_kexec_file;
> +static size_t kexec_segment_size;
>  static void *ima_kexec_buffer;
> =20
>  static void ima_reset_kexec_file(struct seq_file *sf)
> @@ -67,7 +68,7 @@ static int ima_alloc_kexec_file_buf(size_t segment_size=
)
>   *    if the size of the allocated memory is not less than the size of I=
MA measurement list
>   *        copy the measurement list to the allocated memory.
>   *    else
> - *        return error
> + *        copy the measurement list as much as possible.
>   */
>  static int ima_dump_measurement_list(unsigned long *buffer_size, void **=
buffer,
>  				     unsigned long segment_size)
> @@ -95,9 +96,6 @@ static int ima_dump_measurement_list(unsigned long *buf=
fer_size, void **buffer,
>  		}
>  	}
> =20
> -	if (ret < 0)
> -		goto out;
> -
>  	/*
>  	 * fill in reserved space with some buffer details
>  	 * (eg. version, buffer size, number of measurements)
> @@ -117,7 +115,7 @@ static int ima_dump_measurement_list(unsigned long *b=
uffer_size, void **buffer,
> =20
>  	*buffer_size =3D ima_kexec_file.count;
>  	*buffer =3D ima_kexec_file.buf;
> -out:
> +
>  	return ret;
>  }
> =20
> @@ -135,9 +133,8 @@ void ima_add_kexec_buffer(struct kimage *image)
>  	unsigned long binary_runtime_size;
> =20
>  	/* use more understandable variable names than defined in kbuf */
> +	size_t kexec_buffer_size =3D 0;
>  	void *kexec_buffer =3D NULL;
> -	size_t kexec_buffer_size;
> -	size_t kexec_segment_size;
>  	int ret;
> =20
>  	/*
> @@ -162,13 +159,6 @@ void ima_add_kexec_buffer(struct kimage *image)
>  		return;
>  	}
> =20
> -	ima_dump_measurement_list(&kexec_buffer_size, &kexec_buffer,
> -				  kexec_segment_size);
> -	if (!kexec_buffer) {
> -		pr_err("Not enough memory for the kexec measurement buffer.\n");
> -		return;
> -	}
> -
>  	kbuf.buffer =3D kexec_buffer;
>  	kbuf.bufsz =3D kexec_buffer_size;
>  	kbuf.memsz =3D kexec_segment_size;
> @@ -186,12 +176,6 @@ void ima_add_kexec_buffer(struct kimage *image)
>  	image->ima_segment_index =3D image->nr_segments - 1;
>  	image->is_ima_segment_index_set =3D true;
> =20
> -	/*
> -	 * kexec owns kexec_buffer after kexec_add_buffer() is called
> -	 * and it will vfree() that buffer.
> -	 */
> -	ima_reset_kexec_file(&ima_kexec_file);
> -
>  	kexec_dprintk("kexec measurement buffer for the loaded kernel at 0x%lx.=
\n",
>  		      kbuf.mem);
>  }
> @@ -202,7 +186,32 @@ void ima_add_kexec_buffer(struct kimage *image)
>  static int ima_update_kexec_buffer(struct notifier_block *self,
>  				   unsigned long action, void *data)
>  {
> -	return NOTIFY_OK;
> +	size_t buf_size =3D 0;
> +	int ret =3D NOTIFY_OK;
> +	void *buf =3D NULL;
> +
> +	if (!kexec_in_progress) {
> +		pr_info("No kexec in progress.\n");
> +		return ret;
> +	}
> +
> +	if (!ima_kexec_buffer) {
> +		pr_err("Kexec buffer not set.\n");
> +		return ret;
> +	}
> +
> +	ret =3D ima_dump_measurement_list(&buf_size, &buf, kexec_segment_size);
> +
> +	if (ret)
> +		pr_err("Dump measurements failed. Error:%d\n", ret);
> +
> +	if (buf_size !=3D 0)
> +		memcpy(ima_kexec_buffer, buf, buf_size);
> +
> +	kimage_unmap_segment(ima_kexec_buffer);
> +	ima_kexec_buffer =3D NULL;
> +
> +	return ret;
>  }
> =20
>  static struct notifier_block update_buffer_nb =3D {


