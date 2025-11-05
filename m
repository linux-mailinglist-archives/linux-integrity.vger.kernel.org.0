Return-Path: <linux-integrity+bounces-7575-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B2697C37B86
	for <lists+linux-integrity@lfdr.de>; Wed, 05 Nov 2025 21:28:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D64B74F461F
	for <lists+linux-integrity@lfdr.de>; Wed,  5 Nov 2025 20:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34892346FB3;
	Wed,  5 Nov 2025 20:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VdFSaBnN"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D347280CD5;
	Wed,  5 Nov 2025 20:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762374331; cv=none; b=n9xjenb81iUuebp/A4tG2rKFw3nN09/eJ/jb5rsxxGdd8vX9QDeIXZ5Ue+TzW2lI/FfiHX3z7sA5D7s70D0cxjJ93X9wqdoOIGemLxw6kGM8N22b4+Ko+OxzG2ttqyo97AVrarCv3Rd2Fd310QUL3lufEi7QT0x5lJNCN7pCV/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762374331; c=relaxed/simple;
	bh=XKvcNgj58R3KJ+Z876rQ/nWPNZUPDyEmGCwRtcrKYTk=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=rpE9/G9nZuGZUHuBaQYH+apG8wuCb4K/4JDbe9LFoz7qJtckuHzBNP4QW0MoSB4ElKjtQFgeNOMJaJvztbJYrh0mbM1hCTJhG4uyrTnknqma/JidCO8QjV5Zi7xxc3zf3qybN6lAUjyS0hHWQG56L9mORlhuRqQVs+t8obRn/Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VdFSaBnN; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A5HaGJt014150;
	Wed, 5 Nov 2025 20:25:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=c6lakh
	1DWNQtJoQevb+PjeqhHVik2qq3INjLuu3tERM=; b=VdFSaBnN9GIgFM8ptphtJp
	N0nSwXo2yygzzc9S3u9u9HXxEv5sYeTTdhUeUPOzHx3zsiaYpmDs4EpjVdfDw31H
	PVAjZVJ1yffgqmRRk559tswJkQujdxba/rSGgEjBzSoVq6FG/x99CVnLqSMRrXJ+
	1bWXmLYtCwiwwRjckGW6TMbHZj+m9mtnqwJv1Z4V4rArk6qnbbGaxVoPq3a57zvr
	aLjCuKfhAMqpI9bYPrXqPHuOl8UVoHY6xTr1kka6bXhauxTlpe7Q73w+AeypeAM0
	L9xs8VY8tVjN+sIUhAFccFkVN2v26flovwKLgN5NEzRjLLpcaongnNvmxPfBAt1w
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a59v22ywe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Nov 2025 20:25:10 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5A5KP9t1014026;
	Wed, 5 Nov 2025 20:25:09 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a59v22ywa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Nov 2025 20:25:09 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5A5J5uIR018804;
	Wed, 5 Nov 2025 20:25:08 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4a5whnj1tv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Nov 2025 20:25:08 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5A5KP7TD15729318
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Nov 2025 20:25:07 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8C5985805E;
	Wed,  5 Nov 2025 20:25:07 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ED86358056;
	Wed,  5 Nov 2025 20:25:05 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.187.69])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  5 Nov 2025 20:25:05 +0000 (GMT)
Message-ID: <8646ad03f2f14f45c0ade7c7d7cc148f56d964b1.camel@linux.ibm.com>
Subject: Re: [PATCH v2] lsm,ima: new LSM hook
 security_kernel_module_read_file to access decompressed kernel module
From: Mimi Zohar <zohar@linux.ibm.com>
To: Paul Moore <paul@paul-moore.com>
Cc: Coiby Xu <coxu@redhat.com>, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, Karel Srot <ksrot@redhat.com>,
        James
 Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Luis
 Chamberlain	 <mcgrof@kernel.org>,
        Petr Pavlu <petr.pavlu@suse.com>, Daniel
 Gomez	 <da.gomez@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Roberto Sassu	 <roberto.sassu@huawei.com>,
        Dmitry Kasatkin
 <dmitry.kasatkin@gmail.com>,
        Eric Snowberg <eric.snowberg@oracle.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:MODULE SUPPORT"
 <linux-modules@vger.kernel.org>
In-Reply-To: <CAHC9VhS6xWvu5TjjS4MRGFEWxdAhg-Xsf6L+=K0k8U+fgiAtTQ@mail.gmail.com>
References: <20250928030358.3873311-1-coxu@redhat.com>
	 <20251031074016.1975356-1-coxu@redhat.com>
	 <CAHC9VhRBXkW+XuqhxJvEOYR_VMxFh4TRWUtXzZky=AG_nyBYEQ@mail.gmail.com>
	 <baa39fcd1b6b485f14b8f06dcd96b81359e6e491.camel@linux.ibm.com>
	 <CAHC9VhToe-VNqbh6TY2iYnRvqTHRfQjnHYSRWYgt8K7NcLKMdg@mail.gmail.com>
	 <fftfj4o3kqxmfu3hb655xczqcddoeqjv55llsnwkrdu5isdm4z@6sqe3k24a6kk>
	 <CAHC9VhRGwXvhU64Nk5jdmtPfrt9bbkzpLVqS0LRbtN3Q3HhnCw@mail.gmail.com>
	 <0c7e94a436a3742003e5e1155a48480d8307a9c7.camel@linux.ibm.com>
	 <CAHC9VhS6xWvu5TjjS4MRGFEWxdAhg-Xsf6L+=K0k8U+fgiAtTQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Nov 2025 15:25:05 -0500
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.54.3 (3.54.3-2.fc41) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: kxEO1YW_F4PIvuR3DU2AEpwxnkIpKcvb
X-Proofpoint-ORIG-GUID: h7VMnFIcOyeJNaUbUfCkTc_WVvsSwbyg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAxMDAyMSBTYWx0ZWRfX07jFlEHUaQIW
 Bcz30fwCHHZb//Ff4vvWkomttWSIJf4bC+I0Zzr+DgxuovzdyVo2VTWvx1oJycWAFZ8v0ZemNjb
 8/CnXId9V7DTzM0ZcyCLwzmuATiaMHtQuzT5bXZ5qgVdqWEgNjfu1dTFFQcqWOvDiNuuBEsEM82
 uZz48sco60ZtC6QWNGbmzfTxLjXsiPhNqwcnei0tY+vYBJzp4XL/AwV/jPWabiBLFJklaGpa9Aj
 QcP2UQou8d+xQNs90uFAMe2R5sVUd+QuunnwIkXZl/rtcgBqT7heuUH5dLqc8UuM5Px9MWn3YQ9
 MBQrLNLr8v8GlWkCrQBQY1dnR6zGmwDLVHuXS5+4HK7cG9FDMsTkjgVlGU1q6KIPw1m8ssDpfAF
 qo7Pue9pltRCU4taF9llg0v09uX6Ig==
X-Authority-Analysis: v=2.4 cv=H8HWAuYi c=1 sm=1 tr=0 ts=690bb2a6 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=D47IpgBTf8qnc8UESFAA:9 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-05_07,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 impostorscore=0 clxscore=1015 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511010021

On Wed, 2025-11-05 at 10:42 -0500, Paul Moore wrote:
> On Wed, Nov 5, 2025 at 9:07=E2=80=AFAM Mimi Zohar <zohar@linux.ibm.com> w=
rote:
> > On Tue, 2025-11-04 at 21:47 -0500, Paul Moore wrote:
> > > Assuming I'm understanding the problem correctly, I think you're
> > > making this harder than it needs to be.  I believe something like thi=
s
> > > should solve the problem without having to add more conditionals
> > > around the hooks in kernel_read_file(), and limiting the multiple
> > > security_kernel_post_read_file() calls to just the compressed case ..=
.
> > > and honestly in each of the _post_read_file() calls in the compressed
> > > case, the buffer contents have changed so it somewhat makes sense.
> >=20
> > > Given the code below, IMA could simply ignore the
> > > READING_MODULE_COMPRESSED case (or whatever it is the IMA needs to do
> > > in that case) and focus on the READING_MODULE case as it does today.
> > > I expect the associated IMA patch would be both trivial and small.
> > >=20
> > > diff --git a/kernel/module/main.c b/kernel/module/main.c
> > > index c66b26184936..b435c498ec01 100644
> > > --- a/kernel/module/main.c
> > > +++ b/kernel/module/main.c
> > > @@ -3675,17 +3675,19 @@ static int idempotent_wait_for_completion(str=
uct idempot
> > > ent *u)
> > >=20
> > > static int init_module_from_file(struct file *f, const char __user * =
uargs, int
> > > flags)
> > > {
> > > +       bool compressed =3D !!(flags & MODULE_INIT_COMPRESSED_FILE);
> > >        struct load_info info =3D { };
> > >        void *buf =3D NULL;
> > >        int len;
> > >=20
> > > -       len =3D kernel_read_file(f, 0, &buf, INT_MAX, NULL, READING_M=
ODULE);
> > > +       len =3D kernel_read_file(f, 0, &buf, INT_MAX, NULL,
> > > +                              compressed ? READING_MODULE_COMPRESSED=
 : READING_
> > > MODULE);
> > >        if (len < 0) {
> > >                mod_stat_inc(&failed_kreads);
> > >                return len;
> > >        }
> > >=20
> > > -       if (flags & MODULE_INIT_COMPRESSED_FILE) {
> > > +       if (compressed) {
> > >                int err =3D module_decompress(&info, buf, len);
> > >                vfree(buf); /* compressed data is no longer needed */
> > >                if (err) {
> > > @@ -3693,6 +3695,14 @@ static int init_module_from_file(struct file *=
f, const ch
> > > ar __user * uargs, int
> > >                        mod_stat_add_long(len, &invalid_decompress_byt=
es);
> > >                        return err;
> > >                }
> > > +
> > > +               err =3D security_kernel_post_read_file(f,
> > > +                                                    (char *)info.hdr=
, info.len,
> > > +                                                    READING_MODULE);
> >=20
> > Without changing the enumeration here, IMA would not be able to differe=
ntiate
> > the first call to security_kernel_post_read_file() and this one.  The f=
irst call
> > would result in unnecessary error messages.
>=20
> Given the patch snippet above, in the case where an uncompressed
> module is passed into init_module_from_file() there would be the
> following checks, in this order:
>=20
>  * kernel_read_file()
>  -> security_kernel_read_file(READING_MODULE)
>  -> security_kernel_post_read_file(READING_MODULE)
>  * init_module_from_file()
>  -> NONE
>=20
> ... this should be the same as the current behavior.
>=20
> In the case where a compressed module is passed into
> init_module_from_file() there would be the following checks, in this
> order:
>=20
>  * kernel_read_file()
>  -> security_kernel_read_file(READING_MODULE_COMPRESSED)
>  -> security_kernel_post_read_file(READING_MODULE_COMPRESSED)
>  * init_module_from_file()
>  -> security_kernel_post_read_file(READING_MODULE)
>=20
> ... the two differences being that the hook calls in
> kernel_read_file() use the READING_MODULE_COMPRESSED id, which seems
> appropriate as the data passed to the hook is the compressed
> representation, and the additional _post_read_file() hook call in
> init_module_from_file() using the READING_MODULE id, as the data
> passed to the hook is now uncompressed.  Not only should IMA be able
> to easily differentiate between the two _post_read_file() calls, but
> it should have access to both the compressed and uncompressed data.

Thanks, Paul.  Yes, a single additional enumeration is enough.

Mimi

