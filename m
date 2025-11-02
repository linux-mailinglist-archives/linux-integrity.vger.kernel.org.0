Return-Path: <linux-integrity+bounces-7557-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B8A3EC290BC
	for <lists+linux-integrity@lfdr.de>; Sun, 02 Nov 2025 16:06:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 426894E10A8
	for <lists+linux-integrity@lfdr.de>; Sun,  2 Nov 2025 15:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F1FD1547F2;
	Sun,  2 Nov 2025 15:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="quuh0PYl"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60841548C;
	Sun,  2 Nov 2025 15:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762095986; cv=none; b=k63Pq5+X/lZowsnk4MVyGSrKxXqJF4xI+dlji8oNv8n3hwtbsh4kQHsybdhJE8Pgh5Aw770HeuECv50jfBZolr/05p1z3+S9lxpu7/pPS0LYFrUMyTdfpkfaWrHDSuw+fbHN6X67P3V/0gZbCKo0jyj2RdgmDBe3vXLYS7zpcy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762095986; c=relaxed/simple;
	bh=Y/TfvwRtylgp9+GXHTm/CQJvnFREbnd09gzaiGHxmqc=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=H2mB3gb9AYy+caAfHtF/vqc0hyz1W0L9LW3UiB+YPfVnCisD40PVtQ8lhL2snM6AdcIDlSINomXb4bJu/5wbSU1p9rsq8srkXgWaXKSAlfHSN2MLPMF9WKB+/6TA5mR9/M/TfLuHV1UTzSNhJ8EKDAtJjteeuInpw6iJqRtNW5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=quuh0PYl; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A2EPjZE028667;
	Sun, 2 Nov 2025 15:05:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=h2cIrY
	DHldqHX54hilNkiCWkEgwobj3LhX7CjRgOYD0=; b=quuh0PYl9zREuvH8XUi8Dn
	B+99B7xh1+sEEPZMLEusai9ahbcBdNZPBXr0aj3wRGWewi5xAYlOIKnjyMInEVur
	aBQTdgU6gWXEWMVpfJ1P59/jImMi50NUfhslG5xVTRuCdfHRNDnOanyNjpr82HQZ
	tTa3++szUC0cnriDBHY9Z4iRH2f5VsgZTFjLKZfxktU69cmqLYaNXlpczsoQkAjp
	kVIjjFZq9xiI0i8aUqcAiGBjyTCKS3Kvqry3o194ZZY6pBWeoyDPqwD8FuT20hcg
	ZaOGt2UvxS+wT1D5Mq4xfv6jiLByZFsvy1d95MLMDCmv2W/xhWybrl8LZ/WK7EMA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a59vu3m6t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 02 Nov 2025 15:05:34 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5A2F5XTJ032156;
	Sun, 2 Nov 2025 15:05:33 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a59vu3m6r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 02 Nov 2025 15:05:33 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5A2DMGAu025557;
	Sun, 2 Nov 2025 15:05:32 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4a5vhsa06a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 02 Nov 2025 15:05:32 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5A2F5W8N29360534
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 2 Nov 2025 15:05:32 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4BAA458052;
	Sun,  2 Nov 2025 15:05:32 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5B41D5805A;
	Sun,  2 Nov 2025 15:05:31 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.190.185])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Sun,  2 Nov 2025 15:05:31 +0000 (GMT)
Message-ID: <baa39fcd1b6b485f14b8f06dcd96b81359e6e491.camel@linux.ibm.com>
Subject: Re: [PATCH v2] lsm,ima: new LSM hook
 security_kernel_module_read_file to access decompressed kernel module
From: Mimi Zohar <zohar@linux.ibm.com>
To: Paul Moore <paul@paul-moore.com>, Coiby Xu <coxu@redhat.com>
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        Karel Srot <ksrot@redhat.com>, James Morris <jmorris@namei.org>,
        "Serge E.
 Hallyn" <serge@hallyn.com>,
        Luis Chamberlain	 <mcgrof@kernel.org>,
        Petr
 Pavlu <petr.pavlu@suse.com>, Daniel Gomez	 <da.gomez@kernel.org>,
        Sami
 Tolvanen <samitolvanen@google.com>,
        Roberto Sassu	
 <roberto.sassu@huawei.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Eric Snowberg <eric.snowberg@oracle.com>,
        open list
 <linux-kernel@vger.kernel.org>,
        "open list:MODULE SUPPORT"
 <linux-modules@vger.kernel.org>
In-Reply-To: <CAHC9VhRBXkW+XuqhxJvEOYR_VMxFh4TRWUtXzZky=AG_nyBYEQ@mail.gmail.com>
References: <20250928030358.3873311-1-coxu@redhat.com>
	 <20251031074016.1975356-1-coxu@redhat.com>
	 <CAHC9VhRBXkW+XuqhxJvEOYR_VMxFh4TRWUtXzZky=AG_nyBYEQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 02 Nov 2025 10:05:31 -0500
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.54.3 (3.54.3-2.fc41) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 8Z-scviHlVf3LfftQtzRa1ejOqrrStl2
X-Proofpoint-GUID: 1sVFZIHn9J8Fsgz4oTvi7QiHyty3gYwV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAxMDAyMSBTYWx0ZWRfX/vesfn6XpXpH
 BT8hvqQ7DrQsMRqyL8s5nJklgVh9moDpraVbXYjBFu8QQDoIG5yKiN3CywwiOicE83H+7R6rRIJ
 HV0iaWbEp7vW0jmFicb4UuGcanxIogdqb/5rLU1SdR3PMHI52P3zzJ118RXMGmA0jLMhDE6K7df
 u/RpiyL8IMJLoWiinxRLYwudSJYkYJWy/OoqJL7yzfiLHHvxBgamgEQphLZnoKxPoUCNgBwBHxi
 JO7aT3ZFLRlpDvyFZYfAwYDH10+BEQat680qptu2zfAZS/gZFJ0Ps/XxrMMn5kX20BeZkILyrv2
 030eSbBv7TKrNzG+HiDuTjiMdr9LbeUT1fg7+XsDgrlLM05B3FI/PNHgCV6/K7EgS19b6ck1AMu
 sPdplNsJZPI1vbxe+3Um9MLhKku+Hw==
X-Authority-Analysis: v=2.4 cv=U6qfzOru c=1 sm=1 tr=0 ts=6907733e cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8 a=CfLjOnkwlt8k9LrJmxEA:9
 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-02_02,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 impostorscore=0 spamscore=0 phishscore=0
 clxscore=1011 malwarescore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511010021

On Sat, 2025-11-01 at 12:50 -0400, Paul Moore wrote:
> On Fri, Oct 31, 2025 at 3:41=E2=80=AFAM Coiby Xu <coxu@redhat.com> wrote:
> >=20
> > Currently, when in-kernel module decompression (CONFIG_MODULE_DECOMPRES=
S)
> > is enabled, IMA has no way to verify the appended module signature as i=
t
> > can't decompress the module.
> >=20
> > Define a new LSM hook security_kernel_module_read_file which will be
> > called after kernel module decompression is done so IMA can access the
> > decompressed kernel module to verify the appended signature.
> >=20
> > Since IMA can access both xattr and appended kernel module signature
> > with the new LSM hook, it no longer uses the security_kernel_post_read_=
file
> > LSM hook for kernel module loading.
> >=20
> > Before enabling in-kernel module decompression, a kernel module in
> > initramfs can still be loaded with ima_policy=3Dsecure_boot. So adjust =
the
> > kernel module rule in secure_boot policy to allow either an IMA
> > signature OR an appended signature i.e. to use
> > "appraise func=3DMODULE_CHECK appraise_type=3Dimasig|modsig".
> >=20
> > Reported-by: Karel Srot <ksrot@redhat.com>
> > Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
> > Signed-off-by: Coiby Xu <coxu@redhat.com>
> > ---
> > v1: https://lore.kernel.org/linux-integrity/20250928030358.3873311-1-co=
xu@redhat.com/
> >=20
> >  include/linux/lsm_hook_defs.h       |  2 ++
> >  include/linux/security.h            |  7 +++++++
> >  kernel/module/main.c                | 10 +++++++++-
> >  security/integrity/ima/ima_main.c   | 26 ++++++++++++++++++++++++++
> >  security/integrity/ima/ima_policy.c |  2 +-
> >  security/security.c                 | 17 +++++++++++++++++
> >  6 files changed, 62 insertions(+), 2 deletions(-)
>=20
> We don't really need a new LSM hook for this do we?  Can't we just
> define a new file read type, e.g.  READING_MODULE_DECOMPRESS, and do
> another call to security_kernel_post_read_file() after the module is
> unpacked?  Something like the snippet below ...

Yes, this is similar to my suggestion based on defining multiple enumeratio=
ns:
READING_MODULE, READING_COMPRESSED_MODULE, and READING_DECOMPRESSED_MODULE.=
=20
With this solution, IMA would need to make an exception in the post kernel
module read for the READING_COMPRESSED_MODULE case, since the kernel module=
 has
not yet been decompressed.

Coiby suggested further simplification by moving the call later.  At which =
point
either there is or isn't an appended signature for non-compressed and
decompressed kernel modules.

As long as you don't have a problem calling the security_kernel_post_read_f=
ile()
hook again, could we move the call later and pass READING_MODULE_UNCOMPRESS=
ED?

>=20
> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index c66b26184936..f127000d2e0a 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -3693,6 +3693,14 @@ static int init_module_from_file(struct file *f, c=
onst ch
> ar __user * uargs, int
>                        mod_stat_add_long(len, &invalid_decompress_bytes);
>                        return err;
>                }
> +
> +               err =3D security_kernel_post_read_file(f,
> +                                                    (char *)info.hdr, in=
fo.len,
> +                                                    READING_MODULE_DECOM=
PRESS);
> +               if (err) {
> +                       mod_stat_inc(&failed_kreads);
> +                       return err;
> +               }
>        } else {
>                info.hdr =3D buf;
>                info.len =3D len;

=3D=3D defer security_kernel_post_read_file() call to here =3D=3D

Mimi

