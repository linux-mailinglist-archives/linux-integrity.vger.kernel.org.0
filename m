Return-Path: <linux-integrity+bounces-7576-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AF0EC37C64
	for <lists+linux-integrity@lfdr.de>; Wed, 05 Nov 2025 21:48:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0B9804E1704
	for <lists+linux-integrity@lfdr.de>; Wed,  5 Nov 2025 20:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E43526ED55;
	Wed,  5 Nov 2025 20:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LrBvm8C9"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3388E17993;
	Wed,  5 Nov 2025 20:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762375679; cv=none; b=OlYpYNRhVGgsMLW5L2Meh3KldktxPci9P7OT+1aW6OYAnz4VnmYbgYWvcwpOjhFzy06va4SlHArw0CphSU9HuoVHwoNR+9RqeboheiURc1DR5oT8mt5lp147bD2sJDTRf8dqSCLfmiJXMH6HWtmAC1hu5eHJ4KkOdpR6uno+f3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762375679; c=relaxed/simple;
	bh=0TYl3AZvZEI/AkAGjZ6giIv2/6S5nXZsOrWvVJnEDBs=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=BpVUJvjB9J8L0xkq68pPhX6SsTp1bdHMxM7O33o1eTlz2dsTRu8lyTJaeFTy3FVaMOsy6z4kbkQjoWP4G/y0rNJqWAWSywoJd+TaQ0VVZ54aYTN3hezr62YKNS9A2hdp2BHU5gOL6b4oXytkLb7AyeERZtKeQliesDJu/uuUlrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LrBvm8C9; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A5FsMQ7030815;
	Wed, 5 Nov 2025 20:47:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=kUZr3O
	ADl2t4OXiwaArYRj8Lg0CEqw+z2RxxKoklc10=; b=LrBvm8C9vHOD99MFZ2xgzY
	8yWrDNiGZ9D3YOSz1z02cJ+mrHQueApRsDd1fGVliQ8DT2s2aoz5MK9Nh85iZN7J
	nrAezjZIVRDUUuQiwixZ2o+GYgBYaKF/ZwgTKukNuzU2LUHFU8NRA66TbqUJ36Db
	0GlmTH0KJJVukG3ZPyyR98Rn3qENG1zaBx74/D+Uw6cBr3NTKDO7xi9HbEsX6PMX
	jn/O9QIJlq6D2WyLHHAADWE6eSc6/8dZTqL4O7nMAg1tDtlFtUu+M9IA5FBs9cop
	aatmtL8fErSajsp8oiZEqcnBdMgxqENd0jKngNH+NEAMfMrF0nE27w3/m7WcrXgw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a59v232e5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Nov 2025 20:47:41 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5A5KfaFE012630;
	Wed, 5 Nov 2025 20:47:40 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a59v232dj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Nov 2025 20:47:40 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5A5HvxEl025556;
	Wed, 5 Nov 2025 20:47:28 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4a5vhstb5c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Nov 2025 20:47:28 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5A5KlRbR27001450
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Nov 2025 20:47:27 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CF34E58058;
	Wed,  5 Nov 2025 20:47:27 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 43D0858059;
	Wed,  5 Nov 2025 20:47:26 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.187.69])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  5 Nov 2025 20:47:26 +0000 (GMT)
Message-ID: <84a0e1785c7f0ff816b3246be49012092ae12126.camel@linux.ibm.com>
Subject: Re: [PATCH v2] lsm,ima: new LSM hook
 security_kernel_module_read_file to access decompressed kernel module
From: Mimi Zohar <zohar@linux.ibm.com>
To: Coiby Xu <coxu@redhat.com>, Paul Moore <paul@paul-moore.com>
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
In-Reply-To: <fftfj4o3kqxmfu3hb655xczqcddoeqjv55llsnwkrdu5isdm4z@6sqe3k24a6kk>
References: <20250928030358.3873311-1-coxu@redhat.com>
	 <20251031074016.1975356-1-coxu@redhat.com>
	 <CAHC9VhRBXkW+XuqhxJvEOYR_VMxFh4TRWUtXzZky=AG_nyBYEQ@mail.gmail.com>
	 <baa39fcd1b6b485f14b8f06dcd96b81359e6e491.camel@linux.ibm.com>
	 <CAHC9VhToe-VNqbh6TY2iYnRvqTHRfQjnHYSRWYgt8K7NcLKMdg@mail.gmail.com>
	 <fftfj4o3kqxmfu3hb655xczqcddoeqjv55llsnwkrdu5isdm4z@6sqe3k24a6kk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Nov 2025 15:47:25 -0500
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.54.3 (3.54.3-2.fc41) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: bLKHmUeFUral6ZPVEZVjuKVkO_ooWOAU
X-Proofpoint-ORIG-GUID: _26o0JY9VQtY3hxer9tcSuh1jF9L0cgh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAxMDAyMSBTYWx0ZWRfX1V8n0MHdB8tw
 1vnFVl4U1zZNO7q6Q7lvxKM6OzkxWuA8yyaM/+LQecpgqiQqMp+S8NN6+VYlQQCdZmS0mF343Tl
 SDRiUBaK0uOiD5093P+X5fVHBwSqtpZ5VEsOpPoDJDXKRh/bEU8DblB+6j1QDLfG8fauWYmWn/+
 1+bkqhOgyJs9aNQHTMHer1nHe3Td6KXbqcyOwEjgYt/tNGR5mFJd+80+P1/W2HIoR4isAGHv+3n
 s/TGuq/g4h6ugExNlMJ2IussKNQ+n+HsJ1LOu2/8f71ewfaymMdlw8dHowPMnDzBeit2MkKtTfa
 R5y4Ct1dph0oAdfSrTJ4zSgjsuAPH6pF9xL4wxb8I8i4nAxKKPiflmE2RwcFiNOW2FbSGWJDQdT
 nfwnJEVzA7jNrQWJuemPuBYHxxYMxw==
X-Authority-Analysis: v=2.4 cv=H8HWAuYi c=1 sm=1 tr=0 ts=690bb7ed cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=NEAV23lmAAAA:8 a=VnNF1IyMAAAA:8
 a=guW0fOh7C9lSObWThwYA:9 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-05_08,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 impostorscore=0 clxscore=1015 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511010021

On Wed, 2025-11-05 at 08:18 +0800, Coiby Xu wrote:
> On Sun, Nov 02, 2025 at 10:43:04AM -0500, Paul Moore wrote:
> > On Sun, Nov 2, 2025 at 10:06=E2=80=AFAM Mimi Zohar <zohar@linux.ibm.com=
> wrote:
> > > On Sat, 2025-11-01 at 12:50 -0400, Paul Moore wrote:
> > > > On Fri, Oct 31, 2025 at 3:41=E2=80=AFAM Coiby Xu <coxu@redhat.com> =
wrote:
> > > > >=20
> > > > > Currently, when in-kernel module decompression (CONFIG_MODULE_DEC=
OMPRESS)
> > > > > is enabled, IMA has no way to verify the appended module signatur=
e as it
> > > > > can't decompress the module.
> > > > >=20
> > > > > Define a new LSM hook security_kernel_module_read_file which will=
 be
> > > > > called after kernel module decompression is done so IMA can acces=
s the
> > > > > decompressed kernel module to verify the appended signature.
> > > > >=20
> > > > > Since IMA can access both xattr and appended kernel module signat=
ure
> > > > > with the new LSM hook, it no longer uses the security_kernel_post=
_read_file
> > > > > LSM hook for kernel module loading.
> > > > >=20
> > > > > Before enabling in-kernel module decompression, a kernel module i=
n
> > > > > initramfs can still be loaded with ima_policy=3Dsecure_boot. So a=
djust the
> > > > > kernel module rule in secure_boot policy to allow either an IMA
> > > > > signature OR an appended signature i.e. to use
> > > > > "appraise func=3DMODULE_CHECK appraise_type=3Dimasig|modsig".
> > > > >=20
> > > > > Reported-by: Karel Srot <ksrot@redhat.com>
> > > > > Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
> > > > > Signed-off-by: Coiby Xu <coxu@redhat.com>
> > > > > ---
> > > > > v1: https://lore.kernel.org/linux-integrity/20250928030358.387331=
1-1-coxu@redhat.com/
> > > > >=20
> > > > >  include/linux/lsm_hook_defs.h       |  2 ++
> > > > >  include/linux/security.h            |  7 +++++++
> > > > >  kernel/module/main.c                | 10 +++++++++-
> > > > >  security/integrity/ima/ima_main.c   | 26 +++++++++++++++++++++++=
+++
> > > > >  security/integrity/ima/ima_policy.c |  2 +-
> > > > >  security/security.c                 | 17 +++++++++++++++++
> > > > >  6 files changed, 62 insertions(+), 2 deletions(-)
> > > >=20
> > > > We don't really need a new LSM hook for this do we?  Can't we just
> > > > define a new file read type, e.g.  READING_MODULE_DECOMPRESS, and d=
o
> > > > another call to security_kernel_post_read_file() after the module i=
s
> > > > unpacked?  Something like the snippet below ...
> > >=20
> > > Yes, this is similar to my suggestion based on defining multiple enum=
erations:
> > > READING_MODULE, READING_COMPRESSED_MODULE, and READING_DECOMPRESSED_M=
ODULE.
> > > With this solution, IMA would need to make an exception in the post k=
ernel
> > > module read for the READING_COMPRESSED_MODULE case, since the kernel =
module has
> > > not yet been decompressed.
> > >=20
> > > Coiby suggested further simplification by moving the call later.  At =
which point
> > > either there is or isn't an appended signature for non-compressed and
> > > decompressed kernel modules.
> > >=20
> > > As long as you don't have a problem calling the security_kernel_post_=
read_file()
> > > hook again, could we move the call later and pass READING_MODULE_UNCO=
MPRESSED?
> >=20
> > It isn't clear from these comments if you are talking about moving
> > only the second security_kernel_post_read_file() call that was
> > proposed for init_module_from_file() to later in the function, leaving
> > the call in kernel_read_file() intact, or something else?
>=20
> Hi Paul and Mimi,
>=20
> Thanks for sharing your feedback! Yes, you are right, there is no need
> for a new LSM hook. Actually by not introducing a new LSM hook, we can
> have a much simpler solution!
>=20
> >=20
> > I think we want to leave the hook calls in kernel_read_file() intact,
> > in which case I'm not certain what advantage there is in moving the
> > security_kernel_post_read_file() call to a location where it is called
> > in init_module_from_file() regardless of if the module is compressed
> > or not.  In the uncompressed case you are calling the hook twice for
> > no real benefit?  It may be helpful to submit a patch with your
> > proposal as a patch can be worth a thousand words ;)
> >=20
> >=20
> > > > diff --git a/kernel/module/main.c b/kernel/module/main.c
> > > > index c66b26184936..f127000d2e0a 100644
> > > > --- a/kernel/module/main.c
> > > > +++ b/kernel/module/main.c
> > > > @@ -3693,6 +3693,14 @@ static int init_module_from_file(struct file=
 *f, const ch
> > > > ar __user * uargs, int
> > > >                        mod_stat_add_long(len, &invalid_decompress_b=
ytes);
> > > >                        return err;
> > > >                }
> > > > +
> > > > +               err =3D security_kernel_post_read_file(f,
> > > > +                                                    (char *)info.h=
dr, info.len,
> > > > +                                                    READING_MODULE=
_DECOMPRESS);
> > > > +               if (err) {
> > > > +                       mod_stat_inc(&failed_kreads);
> > > > +                       return err;
> > > > +               }
> > > >        } else {
> > > >                info.hdr =3D buf;
> > > >                info.len =3D len;
> > >=20
> > > =3D=3D defer security_kernel_post_read_file() call to here =3D=3D
>=20
> By moving security_kernel_post_read_file, I think what Mimi means is to
> move security_kernel_post_read_file in init_module_from_file() to later
> in the function,
>=20
> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index c66b261849362a..66725e53fef0c1 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -3678,6 +3678,7 @@ static int init_module_from_file(struct file *f, co=
nst char __user * uargs, int
>   	struct load_info info =3D { };
>   	void *buf =3D NULL;
>   	int len;
> +	int err;
>  =20
>   	len =3D kernel_read_file(f, 0, &buf, INT_MAX, NULL, READING_MODULE);
>   	if (len < 0) {
> @@ -3686,7 +3687,7 @@ static int init_module_from_file(struct file *f, co=
nst char __user * uargs, int
>   	}
>  =20
>   	if (flags & MODULE_INIT_COMPRESSED_FILE) {
> -		int err =3D module_decompress(&info, buf, len);
> +		err =3D module_decompress(&info, buf, len);
>   		vfree(buf); /* compressed data is no longer needed */
>   		if (err) {
>   			mod_stat_inc(&failed_decompress);
> @@ -3698,6 +3699,14 @@ static int init_module_from_file(struct file *f, c=
onst char __user * uargs, int
>   		info.len =3D len;
>   	}
>  =20
> +	err =3D security_kernel_post_read_file(f, (char *)info.hdr, info.len,
> +					     READING_MODULE);
> +	if (err) {
> +		mod_stat_inc(&failed_kreads);
> +		free_copy(&info, flags);
> +		return err;
> +	}
> +
>   	return load_module(&info, uargs, flags);
>   }
>=20
> If we only call security_kernel_post_read_file the 2nd time for a
> decompressed kernel module, IMA won't be sure what to do when
> security_kernel_post_read_file is called for the 1st time because it
> can't distinguish between a compressed module with appended signature or
> a uncompressed module without appended signature. If it permits 1st
> calling security_kernel_post_read_file, a uncompressed module without
> appended signature can be loaded. If it doesn't permit 1st calling
> security_kernel_post_read_file, there is no change to call
> security_kernel_post_read_file again for decompressed module.
>=20
> And you are right, there is no need to call
> security_kernel_post_read_file twice. And from the perspective of IMA,
> it simplifies reasoning if it is guaranteed that IMA will always access
> uncompressed kernel module regardless regardless of its original
> compression state.=20
>=20
> So I think a better solution is to stop calling
> security_kernel_post_read_file in kernel_read_file for READING_MODULE.
> This can also avoiding introducing an unnecessary
> READING_MODULE_UNCOMPRESSED/READING_COMPRESSED_MODULE enumeration and
> can make the solution even simpler,
>=20
> diff --git a/fs/kernel_read_file.c b/fs/kernel_read_file.c
> index de32c95d823dbd..7c78e84def6ec7 100644
> --- a/fs/kernel_read_file.c
> +++ b/fs/kernel_read_file.c
> @@ -107,7 +107,12 @@ ssize_t kernel_read_file(struct file *file, loff_t o=
ffset, void **buf,
>   			goto out_free;
>   		}
>  =20
> -		ret =3D security_kernel_post_read_file(file, *buf, i_size, id);
> +		/*
> +		 * security_kernel_post_read_file will be called later after
> +		 * a read kernel module is truly decompressed
> +		 */
> +		if (id !=3D READING_MODULE)
> +			ret =3D security_kernel_post_read_file(file, *buf, i_size, id);
>   	}
>=20
> Btw, I notice IMA is the only user of security_kernel_post_read_file so
> this change won't affect other LSMs. For a full patch, please visit
> https://github.com/coiby/linux/commit/558d85779ab5d794874749ecfae0e48b890=
bf3e0.patch
>=20
> If there are concerns that I'm unaware of and a new
> READING_MODULE_UNCOMPRESSED/READING_COMPRESSED_MODULE enumeration is
> necessary, here's another patch
> https://github.com/coiby/linux/commit/cdd40317b6070f48ec871c6a89428084f38=
ca083.patch

Hi Coiby,

Based on the conversation with Paul, there is no reason to remove the exist=
ing
security_kernel_post_read_file() call.

The changes are similar to the 2nd link, but a bit different.
- Define a single enumeration named READING_MODULE_COMPRESSED.

- In module/main.c add a new security_kernel_post_read_file() call immediat=
ely
after decompressing the kernel module.  Like a previous version of this pat=
ch,
call kernel_read_file() with either READING_MODULE or READING_MODULE_COMPRE=
SSED
based on MODULE_INIT_COMPRESSED_FILE.

- In ima_post_read_file() defer verifying the signature when the enumeratio=
n is
READING_MODULE_COMPRESSED.  (No need for a new function ima_read_kernel_mod=
ule.)

thanks,

Mimi

