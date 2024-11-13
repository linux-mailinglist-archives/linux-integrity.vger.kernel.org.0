Return-Path: <linux-integrity+bounces-4101-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A96CC9C681D
	for <lists+linux-integrity@lfdr.de>; Wed, 13 Nov 2024 05:35:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62E2A282A82
	for <lists+linux-integrity@lfdr.de>; Wed, 13 Nov 2024 04:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92C55170854;
	Wed, 13 Nov 2024 04:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CMb3vsa5"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07902566;
	Wed, 13 Nov 2024 04:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731472476; cv=none; b=lLqtWFKiVyuEIHlNG2sXY1qgsq7SjX/IOVdOcNbn6M41fPuomPDUu70LLTQHi4sG5RLa/dWq2jXL7pAhFvVlMJnde3ba6dEabwLUDK8Pm/Bt2qzzzu3dPVwaMmEUIfBU25h6npF6pOwgxGYj3yjfHPxZN38v152YIWo+h+QrWQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731472476; c=relaxed/simple;
	bh=8l/52pfQVzbm9v+GBnJpIUtiv38RXCms0yOX+DnWWbs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=c8foADy+5X+vQWLd06Wks6Znz7ol0wtbq8XPZjzSUwSmx4UWZ7aD4TlrkV/2dQn906YgKhvssJn638tR3+gro5UOgUKmoEHNJdLtNaZxuIArX+CuUxOZct3BktQhyfROewDMRwrDtPT86u3vAnBWd3F+JEFJfaLSvY/FkZjnhRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CMb3vsa5; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AD36pAe020357;
	Wed, 13 Nov 2024 04:34:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=mCko/W
	j4lckQMpHoFs4hjvEI7twM6lFzN9e6FYJmK94=; b=CMb3vsa51QVvE+2RLwR+To
	RY3A0rGQE071M0Vn4lMckbWmNR3i8t8iSlKOxg5bBA7bBS7H1It/53glwObqUVYW
	QyptIQzrfkkY9NhH35iWYI8vG+CWm9ucKPvwBguS643XFXElNL8U0S2tfKPyXOuk
	SCaz3Af139qJu7oKhfEG8cbrJct5jzRm77BW7+aouCGbLET1HVyKsoQCauOO03jC
	CrxnGiuAJvD5oD+PMRNGvtc2b5USDcGOVcAJG6iaRdL2PtEYNxs/4ypbsyqLp3Qy
	1qhpZEZRdVVcJes/7T3r01dA/03HxafVrGwonQVy/q3VRW6zuyExtDYjYpBwxM/A
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42vk39gcqb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Nov 2024 04:34:10 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4AD4YASx019461;
	Wed, 13 Nov 2024 04:34:10 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42vk39gcq8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Nov 2024 04:34:10 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4AD2mSeD010502;
	Wed, 13 Nov 2024 04:34:09 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 42tj2s5j6q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Nov 2024 04:34:09 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4AD4Y8WG49217792
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Nov 2024 04:34:08 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 98C055805A;
	Wed, 13 Nov 2024 04:34:08 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6C31658052;
	Wed, 13 Nov 2024 04:34:07 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.180.180])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 13 Nov 2024 04:34:07 +0000 (GMT)
Message-ID: <9649cec7710241dc359c7c1a715b2cef36ebce15.camel@linux.ibm.com>
Subject: Re: [PATCH v3] tpm: Opt-in in disable PCR integrity protection
From: Mimi Zohar <zohar@linux.ibm.com>
To: Jarkko Sakkinen <jarkko@kernel.org>, linux-integrity@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>, Peter Huewe <peterhuewe@gmx.de>,
        Jason
 Gunthorpe <jgg@ziepe.ca>,
        James Bottomley
 <James.Bottomley@HansenPartnership.com>
Cc: Roberto Sassu <roberto.sassu@huawei.com>,
        David Howells
 <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>,
        James Morris
 <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, Thomas Huth
 <thuth@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Paul E.
 McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Xiongwei Song <xiongwei.song@windriver.com>,
        Stefan Berger
 <stefanb@linux.ibm.com>,
        Ard Biesheuvel <ardb@kernel.org>, Al Viro
 <viro@zeniv.linux.org.uk>,
        "open list:DOCUMENTATION"
 <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:KEYS-TRUSTED" <keyrings@vger.kernel.org>,
        "open list:SECURITY
 SUBSYSTEM" <linux-security-module@vger.kernel.org>,
        Josh Poimboeuf
 <jpoimboe@kernel.org>
Date: Tue, 12 Nov 2024 23:34:07 -0500
In-Reply-To: <20241113002414.609168-1-jarkko@kernel.org>
References: <20241113002414.609168-1-jarkko@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 4F_JmppFqug7dZ38kyS3LZYqbeYr9XTn
X-Proofpoint-ORIG-GUID: 58IQKpm7d3g1bW6axaA3zTAq8U56cUnR
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1011
 suspectscore=0 bulkscore=0 adultscore=0 spamscore=0 phishscore=0
 mlxscore=0 mlxlogscore=999 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411130039

On Wed, 2024-11-13 at 02:24 +0200, Jarkko Sakkinen wrote:
> The initial HMAC session feature added TPM bus encryption and/or integrity
> protection to various in-kernel TPM operations. This can cause performance
> bottlenecks with IMA, as it heavily utilizes PCR extend operations.
>=20
> In order to mitigate this performance issue, introduce a kernel
> command-line parameter to the TPM driver for disabling the integrity
> protection for PCR extend operations (i.e. TPM2_PCR_Extend).
>=20
> Cc: James Bottomley <James.Bottomley@HansenPartnership.com>
> Link: https://lore.kernel.org/linux-integrity/20241015193916.59964-1-zoha=
r@linux.ibm.com/
> Fixes: 6519fea6fd37 ("tpm: add hmac checks to tpm2_pcr_extend()")
> Co-developed-by: Roberto Sassu <roberto.sassu@huawei.com>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> Co-developed-by: Mimi Zohar <zohar@linux.ibm.com>
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

The module_param variable documentation needs to be updated to reflect the
actual module_param variable 'disable_pcr_integrity'.

Otherwise,
Tested-by: Mimi Zohar <zohar@linux.ibm.com>

> ---
> v3:
> - Please test this too ;-) I did quick testing only.
> - Fixed the reported glitches and mistakes.
> v2:
> - Followed Mimi's suggestions.
> ---
>  .../admin-guide/kernel-parameters.txt         |  9 ++++
>  drivers/char/tpm/tpm-buf.c                    | 20 ++++++++
>  drivers/char/tpm/tpm2-cmd.c                   | 30 ++++++++---
>  drivers/char/tpm/tpm2-sessions.c              | 51 ++++++++++---------
>  include/linux/tpm.h                           |  3 ++
>  5 files changed, 82 insertions(+), 31 deletions(-)
>=20
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentat=
ion/admin-guide/kernel-parameters.txt
> index 1666576acc0e..7107ad322b2e 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -6727,6 +6727,15 @@
>  	torture.verbose_sleep_duration=3D [KNL]
>  			Duration of each verbose-printk() sleep in jiffies.
> =20
> +	tpm.disable_pcr_integrity_protection=3D [HW,TPM]

-> tpm.disable_pcr_integrity=3D

> +			Do not protect PCR registers from unintended physical
> +			access, or interposers in the bus by the means of
> +			having an integrity protected session wrapped around
> +			TPM2_PCR_Extend command. Consider this in a situation
> +			where TPM is heavily utilized by IMA, thus protection
> +			causing a major performance hit, and the space where
> +			machines are deployed is by other means guarded.
> +
>  	tpm_suspend_pcr=3D[HW,TPM]
>  			Format: integer pcr id
>  			Specify that at suspend time, the tpm driver
> diff --git a/drivers/char/tpm/tpm-buf.c b/drivers/char/tpm/tpm-buf.c
> index cad0048bcc3c..e49a19fea3bd 100644
> --- a/drivers/char/tpm/tpm-buf.c
> +++ b/drivers/char/tpm/tpm-buf.c
> @@ -146,6 +146,26 @@ void tpm_buf_append_u32(struct tpm_buf *buf, const u=
32 value)
>  }
>  EXPORT_SYMBOL_GPL(tpm_buf_append_u32);
> =20
> +/**
> + * tpm_buf_append_handle() - Add a handle
> + * @chip:	&tpm_chip instance
> + * @buf:	&tpm_buf instance
> + * @handle:	a TPM object handle
> + *
> + * Add a handle to the buffer, and increase the count tracking the numbe=
r of
> + * handles in the command buffer. Works only for command buffers.
> + */
> +void tpm_buf_append_handle(struct tpm_chip *chip, struct tpm_buf *buf, u=
32 handle)
> +{
> +	if (buf->flags & TPM_BUF_TPM2B) {
> +		dev_err(&chip->dev, "Invalid buffer type (TPM2B)\n");
> +		return;
> +	}
> +
> +	tpm_buf_append_u32(buf, handle);
> +	buf->handles++;
> +}
> +
>  /**
>   * tpm_buf_read() - Read from a TPM buffer
>   * @buf:	&tpm_buf instance
> diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
> index 1e856259219e..dfdcbd009720 100644
> --- a/drivers/char/tpm/tpm2-cmd.c
> +++ b/drivers/char/tpm/tpm2-cmd.c
> @@ -14,6 +14,10 @@
>  #include "tpm.h"
>  #include <crypto/hash_info.h>
> =20
> +static bool disable_pcr_integrity;
> +module_param(disable_pcr_integrity, bool, 0444);
> +MODULE_PARM_DESC(disable_pcr_integrity, "Disable integrity protection of=
 TPM2_PCR_Extend");

'disable_pcr_integrity' doesn't match the documentation.

> +
>  static struct tpm2_hash tpm2_hash_map[] =3D {
>  	{HASH_ALGO_SHA1, TPM_ALG_SHA1},
>  	{HASH_ALGO_SHA256, TPM_ALG_SHA256},
> @@ -232,18 +236,26 @@ int tpm2_pcr_extend(struct tpm_chip *chip, u32 pcr_=
idx,


thanks,

Mimi


