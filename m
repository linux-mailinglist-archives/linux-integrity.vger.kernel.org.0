Return-Path: <linux-integrity+bounces-8074-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E0EBECC4955
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Dec 2025 18:11:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F3624305DEC6
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Dec 2025 17:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1C6F3590C2;
	Tue, 16 Dec 2025 12:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Q27eFqom"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E461358D12;
	Tue, 16 Dec 2025 12:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765889486; cv=none; b=cNH9vfKvhMVFQSb+SAz/CmwOMWvjtkOIFt9YT/SvzVnn01pgDfSZax2h8Bc8xEsCW7CyEeNj/1zb1XvrsvLtrWDjROyK0PzD7eUBhhH9arYjvxAQ6+7Fj7fp4wdWtsBOqj9qjJw7Kj2+zAKKxpOYTBva8jUVLI+pcTXeYOid0kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765889486; c=relaxed/simple;
	bh=ti6Dk4Ek5FlXf6xEBQ/adxxJC9ZJqhDol762fo0LZUw=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=f3/P+4EQtyksCMMfwdKRdDAhYsUlVhAi8z2J6mmLPRp3zjGe2g/XfTPobcyDLxevAM4s31baRj4Gr3FXsqhEsUeQzkpZIKeLc19SFpACTI6KjkKBWgOqT5IEMLqt94eqzIetMYXd+D9tmvfAl5lQqSrzlDnvhUp2NjDq1s9pJuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Q27eFqom; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BG2m6Om001615;
	Tue, 16 Dec 2025 12:51:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=hNFFEt
	vfQ7A6ouq4WsKG9Uu49lNx4XLMADh/Njl+Zxs=; b=Q27eFqombMQaLVqU0FacBc
	G+yyTCDJuVrsd84T29XjIyU9GsiTqoSWIbJpHj5cy/Gy+vbqZmqjv5VKgRc7upbu
	4YljX/1R65ylI7pGX7MYPJ2/mchyoFWig6yOscASQfFLfZIJ8Yqcd38a4+d9T3jT
	CZ2JdUVx7rWJQR3WI9JTsUsv939uB1yyZqwoOowbRh7++6X8wa0T8aSAvKYTiFdO
	5fZoRfcQypOdr1H4aHRWqBSFocm7sHIGjVDHQTPtiQ9F3lBnHljt1INzQfnJFBMU
	VFwSm0rpDvxa4oTpVbY5jbIjW5G9Bu/evMK4y9gfU7yZBfu3kFn1OXcmU/ByeQ1g
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b0ytv727c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Dec 2025 12:51:03 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5BGCp2PJ013958;
	Tue, 16 Dec 2025 12:51:02 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b0ytv727a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Dec 2025 12:51:02 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BGCS4fg026786;
	Tue, 16 Dec 2025 12:51:01 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4b1jfsccdn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Dec 2025 12:51:01 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5BGCp1XP30081590
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Dec 2025 12:51:01 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 17DA158045;
	Tue, 16 Dec 2025 12:51:01 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 586E858054;
	Tue, 16 Dec 2025 12:50:59 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.168.158])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 16 Dec 2025 12:50:59 +0000 (GMT)
Message-ID: <c93907cb0f08f9baa320488989aa87e7867ee9da.camel@linux.ibm.com>
Subject: Re: [PATCH V2 1/1] IMA event log trimming
From: Mimi Zohar <zohar@linux.ibm.com>
To: steven chen <chenste@linux.microsoft.com>, linux-integrity@vger.kernel.org
Cc: roberto.sassu@huawei.com, dmitry.kasatkin@gmail.com,
        eric.snowberg@oracle.com, corbet@lwn.net, serge@hallyn.com,
        paul@paul-moore.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, anirudhve@linux.microsoft.com,
        gregorylumen@linux.microsoft.com, nramas@linux.microsoft.com,
        sushring@linux.microsoft.com, linux-doc@vger.kernel.org
In-Reply-To: <d80958ec-f139-41e9-afa0-a5aca94221de@linux.microsoft.com>
References: <20251210235314.3341-1-chenste@linux.microsoft.com>
	 <20251210235314.3341-2-chenste@linux.microsoft.com>
	 <d80958ec-f139-41e9-afa0-a5aca94221de@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Dec 2025 07:50:58 -0500
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.54.3 (3.54.3-2.fc41) 
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjEzMDAyMyBTYWx0ZWRfX/E0qhx9lZqhu
 HnQpj4pJNaMKN9aLLVGHdeXur6FCCxwdK1xYJFfAkH/VmWgOblwdMo+kwoddzzK+Ht7YpUx2KqH
 oQDGwuZa5p57vkuYkWju71RMWgeaqmHpjPDA9Cs0S8YwqaAZojfsqJQ432O/SqziD1YCGTrA/jc
 wWaHex3m5pxFGwpOCTYxlY0JQDiLLTRErsQEb1EdUVnR2OfBKKaTRIQUmCdm1Glx6Ocnx9rDKGg
 dGfLIqsGALOmHvY8s+NnSbZMZfhB7f42dTHEmEASBKUErAYStlgHaAYyvNN+HfO71X8/QKddB4q
 xCdtJ+x/z2/TxIAUL55VOKaRqkudEvoJ/szeUAm7G7Lj1dbFFupMFmaKVP5sxE+uRNB5g5m4y2G
 CsmyF3oA/OAlIexkiAMrWyy54nwf6g==
X-Proofpoint-ORIG-GUID: l33RvHUxbLQ00-nke2W_GJiw23DkzZqt
X-Authority-Analysis: v=2.4 cv=QtRTHFyd c=1 sm=1 tr=0 ts=694155b7 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yMhMjlubAAAA:8 a=Vx3P-orQicAo808I3v0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: Do9LEKy4auvYDR9COv1lSJOujKGz_ARe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-16_02,2025-12-15_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2512130023

Hi Steven,

As I previously said, "The main difference between this patch and Roberto's
version is the length of time needed for locking the measurement list, whic=
h
prevents new entries from being appended to the measurement list.  In Rober=
to's
version, the list head is moved quickly and the lock released.  Measuring t=
he
total amount of time needed to trim the measurement list ignores the benefi=
t of
his version. I plan on reviewing both this version and his (hopefully today=
)."

The other difference is "when" the IMA measurement list is read and saved,
before the trigger to trim the measurement list or after when the measureme=
nt
list is staged.  In this case, the initial trigger trims the measurement li=
st.
In the other case, the measurement list is staged and then deleted.  When
reviewing Roberto's patch, I plan to discuss it.

After trimming the measurement list, existing verifiers, which walk the IMA
measurement list, will obviously fail to match the PCRs.  Breaking existing
userspace applications is a problem and, unfortunately, requires yet anothe=
r
Kconfig option.  It needs to be at least mentioned here in the patch
description.

There are two places where it says, "the list never shrinks, so we don't ne=
ed a
lock here".  Either the code, the comment, or both need to be updated.


On Thu, 2025-12-11 at 10:41 -0800, steven chen wrote:
> On 12/10/2025 3:53 PM, steven chen wrote:
> > This patch is for trimming N entries of the IMA event logs. It will als=
o
> > cleaning the hash table if ima_flush_htable is set.

Please refer to "Describe your changes in imperative mood" in the "Describe=
 your
changes" section of Documentation/process/submitting-patches.rst.

> >=20
> > It provides a userspace interface ima_trim_log that can be used to inpu=
t
> > number N to let kernel to trim N entries of IMA event logs. When read

There is only a single kernel measurement list or event log, not plural.  T=
here
are N number of "entries" or "records" in the IMA measurement list.

-> trim N records from the IMA measurement list.

> > this interface, it returns number of entries trimmed last time.

Please provide an example of how to initiate the trim.

After trimming the IMA measurement list, are the other securityfs files cor=
rect?
Are they correct after a kexec?  Or are they reset without a way of resurre=
cting
them without the full measurement list?

> >=20
> > Signed-off-by: steven chen <chenste@linux.microsoft.com>

> > ---
> >   .../admin-guide/kernel-parameters.txt         |   4 +
> >   security/integrity/ima/ima.h                  |   2 +
> >   security/integrity/ima/ima_fs.c               | 175 +++++++++++++++++=
-
> >   security/integrity/ima/ima_queue.c            |  64 +++++++
> >   4 files changed, 241 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Document=
ation/admin-guide/kernel-parameters.txt
> > index e92c0056e4e0..cd1a1d0bf0e2 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -2197,6 +2197,10 @@
> >   			Use the canonical format for the binary runtime
> >   			measurements, instead of host native format.
> >  =20
> > +	ima_flush_htable  [IMA]
> > +			Flush the measurement list hash table when trim all
> > +			or a part of it for deletion.
> > +
> >   	ima_hash=3D	[IMA]
> >   			Format: { md5 | sha1 | rmd160 | sha256 | sha384
> >   				   | sha512 | ... }
> > diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.=
h
> > index e3d71d8d56e3..ab0e30ee25ea 100644
> > --- a/security/integrity/ima/ima.h
> > +++ b/security/integrity/ima/ima.h
> > @@ -246,8 +246,10 @@ void ima_post_key_create_or_update(struct key *key=
ring, struct key *key,
> >  =20
> >   #ifdef CONFIG_IMA_KEXEC
> >   void ima_measure_kexec_event(const char *event_name);
> > +long ima_purge_event_log(long number_logs);
> >   #else
> >   static inline void ima_measure_kexec_event(const char *event_name) {}
> > +static inline long ima_purge_event_log(long number_logs) { return 0; }
> >   #endif
> >  =20
> >   /*
> > diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/i=
ma_fs.c
> > index 87045b09f120..410f7d03c43f 100644
> > --- a/security/integrity/ima/ima_fs.c
> > +++ b/security/integrity/ima/ima_fs.c
> > @@ -21,6 +21,9 @@
> >   #include <linux/rcupdate.h>
> >   #include <linux/parser.h>
> >   #include <linux/vmalloc.h>
> > +#include <linux/ktime.h>
> > +#include <linux/timekeeping.h>
> > +#include <linux/ima.h>
> >  =20
> >   #include "ima.h"
> >  =20
> > @@ -38,6 +41,14 @@ __setup("ima_canonical_fmt", default_canonical_fmt_s=
etup);
> >  =20
> >   static int valid_policy =3D 1;
> >  =20
> > +#define IMA_LOG_TRIM_REQ_LENGTH 11
> > +#define IMA_LOG_TRIM_EVENT_LEN 256
> > +
> > +static long trimcount;
> > +/* mutex protects atomicity of trimming measurement list requests */

ima_measure_lock is taken for more than just synchronization of trimming th=
e
measurement list.  Please update comment.

> > +static DEFINE_MUTEX(ima_measure_lock);
> > +static long ima_measure_users;
> > +
> >   static ssize_t ima_show_htable_value(char __user *buf, size_t count,
> >   				     loff_t *ppos, atomic_long_t *val)
> >   {
> > @@ -202,16 +213,65 @@ static const struct seq_operations ima_measurment=
s_seqops =3D {
> >   	.show =3D ima_measurements_show
> >   };
> >  =20

_ima_measurements_open() seems pretty fundamental to the locking scheme.=
=20
Preventing opening the IMA measurement list is new.  There should at least =
be a
short, regular comment explaining what you're locking and why.

> > +static int _ima_measurements_open(struct inode *inode, struct file *fi=
le,
> > +				  const struct seq_operations *seq_ops)
> > +{
> > +	bool write =3D !!(file->f_mode & FMODE_WRITE);
> > +	int ret;
> > +
> > +	if (write && !capable(CAP_SYS_ADMIN))
> > +		return -EPERM;
> > +
> > +	mutex_lock(&ima_measure_lock);
> > +	if ((write && ima_measure_users !=3D 0) ||
> > +	    (!write && ima_measure_users < 0)) {
> > +		mutex_unlock(&ima_measure_lock);
> > +		return -EBUSY;
> > +	}
> > +
> > +	ret =3D seq_open(file, seq_ops);
> > +	if (ret < 0) {
> > +		mutex_unlock(&ima_measure_lock);
> > +		return ret;
> > +	}
> > +
> > +	if (write)
> > +		ima_measure_users--;
> > +	else
> > +		ima_measure_users++;
> > +
> > +	mutex_unlock(&ima_measure_lock);
> > +	return ret;
> > +}
> > +
> >   static int ima_measurements_open(struct inode *inode, struct file *fi=
le)
> >   {
> > -	return seq_open(file, &ima_measurments_seqops);
> > +	return _ima_measurements_open(inode, file, &ima_measurments_seqops);
> > +}
> > +
> > +static int ima_measurements_release(struct inode *inode, struct file *=
file)
> > +{
> > +	bool write =3D !!(file->f_mode & FMODE_WRITE);
> > +	int ret;
> > +
> > +	mutex_lock(&ima_measure_lock);
> > +	ret =3D seq_release(inode, file);
> > +	if (!ret) {
> > +		if (write)
> > +			ima_measure_users++;
> > +		else
> > +			ima_measure_users--;
> > +	}
> > +
> > +	mutex_unlock(&ima_measure_lock);
> > +	return ret;
> >   }
> >  =20
> >   static const struct file_operations ima_measurements_ops =3D {
> >   	.open =3D ima_measurements_open,
> >   	.read =3D seq_read,
> >   	.llseek =3D seq_lseek,
> > -	.release =3D seq_release,
> > +	.release =3D ima_measurements_release,
> >   };
> >  =20
> >   void ima_print_digest(struct seq_file *m, u8 *digest, u32 size)
> > @@ -279,14 +339,111 @@ static const struct seq_operations ima_ascii_mea=
surements_seqops =3D {
> >  =20
> >   static int ima_ascii_measurements_open(struct inode *inode, struct fi=
le *file)
> >   {
> > -	return seq_open(file, &ima_ascii_measurements_seqops);
> > +	return _ima_measurements_open(inode, file, &ima_ascii_measurements_se=
qops);
> >   }
> >  =20
> >   static const struct file_operations ima_ascii_measurements_ops =3D {
> >   	.open =3D ima_ascii_measurements_open,
> >   	.read =3D seq_read,
> >   	.llseek =3D seq_lseek,
> > -	.release =3D seq_release,
> > +	.release =3D ima_measurements_release,
> > +};
> > +
> > +static void ima_measure_trim_event(const long number_logs)
> > +{
> > +	char ima_log_trim_event[IMA_LOG_TRIM_EVENT_LEN];
> > +	struct timespec64 ts;
> > +	u64 time_ns;
> > +	int n;
> > +
> > +	ktime_get_real_ts64(&ts);
> > +	time_ns =3D (u64)ts.tv_sec * 1000000000ULL + ts.tv_nsec;
> > +	n =3D scnprintf(ima_log_trim_event, IMA_LOG_TRIM_EVENT_LEN,
> > +		      "time=3D%llu; log trim this time=3D%lu;",
> > +		       time_ns, number_logs);
> > +
> > +	ima_measure_critical_data("ima_log_trim", "trim ima event logs", ima_=
log_trim_event, n, false, NULL, 0);
> > +}

There's no mention of a new critical data record in the patch description. =
 It
should be a separate patch with a full patch description describing what it=
 is
and how to verify it.

> > +
> > +static int ima_log_trim_open(struct inode *inode, struct file *file)
> > +{
> > +	bool write =3D !!(file->f_mode & FMODE_WRITE);
> > +
> > +	if (!write && capable(CAP_SYS_ADMIN))
> > +		return 0;
> > +	else if (!capable(CAP_SYS_ADMIN))
> > +		return -EPERM;
> > +
> > +	return _ima_measurements_open(inode, file, &ima_measurments_seqops);
> > +}
> > +
> > +static ssize_t ima_log_trim_read(struct file *file, char __user *buf, =
size_t size, loff_t *ppos)
> > +{
> > +	char tmpbuf[IMA_LOG_TRIM_REQ_LENGTH];	/* greater than largest 'long' =
string value */
> > +	ssize_t len;
> > +
> > +	len =3D scnprintf(tmpbuf, sizeof(tmpbuf), "%li\n", trimcount);
> > +	return simple_read_from_buffer(buf, size, ppos, tmpbuf, len);
> > +}
> > +
> > +static ssize_t ima_log_trim_write(struct file *file,
> > +				  const char __user *buf, size_t datalen, loff_t *ppos)
> > +{
> > +	unsigned char req[IMA_LOG_TRIM_REQ_LENGTH];
> > +	long count, n;
> > +	int ret;
> > +
> > +	if (*ppos > 0 || datalen > IMA_LOG_TRIM_REQ_LENGTH || datalen < 2) {
> > +		ret =3D -EINVAL;
> > +		goto out;
> > +	}
> > +
> > +	n =3D (int)datalen;
> > +
> > +	ret =3D copy_from_user(req, buf, datalen);
> > +	if (ret < 0)
> > +		goto out;
> > +
> > +	count =3D 0;
> > +	for (int i =3D 0; i < n; ++i) {
> > +		if (req[i] < '0' || req[i] > '9') {
> > +			ret =3D -EINVAL;
> > +			goto out;
> > +		}
> > +		count =3D count * 10 + req[i] - '0';
> > +	}

This code can be simplified by using the kstrto*_from_user() family of
functions.  The patch description should include an example how to trim the
measurement list.

> > +	ret =3D ima_purge_event_log(count);

The term "purge" is really strong wording.  I hope you're not purging the
measurement list, but simply removing them from kernel memory.

> > +
> > +	if (ret < 0)
> > +		goto out;
> > +
> > +	trimcount =3D ret;
> > +
> > +	if (trimcount > 0)
> > +		ima_measure_trim_event(trimcount);
> > +
> > +	ret =3D datalen;
> > +out:
> > +	return ret;
> > +}
> > +
> > +static int ima_log_trim_release(struct inode *inode, struct file *file=
)
> > +{
> > +	bool write =3D !!(file->f_mode & FMODE_WRITE);
> > +	if (!write && capable(CAP_SYS_ADMIN))
> > +		return 0;
> > +	else if (!capable(CAP_SYS_ADMIN))
> > +		return -EPERM;
> > +
> > +	return ima_measurements_release(inode, file);
> > +}
> > +
> > +static const struct file_operations ima_log_trim_ops =3D {
> > +	.open =3D ima_log_trim_open,
> > +	.read =3D ima_log_trim_read,
> > +	.write =3D ima_log_trim_write,
> > +	.llseek =3D generic_file_llseek,
> > +	.release =3D ima_log_trim_release
> >   };
> >  =20
> >   static ssize_t ima_read_policy(char *path)
> > @@ -528,6 +685,16 @@ int __init ima_fs_init(void)
> >   		goto out;
> >   	}
> >  =20
> > +	dentry =3D securityfs_create_file("ima_trim_log",
> > +					S_IRUSR | S_IRGRP | S_IWUSR | S_IWGRP,
> > +					ima_dir, NULL, &ima_log_trim_ops);
> > +	if (IS_ERR(dentry)) {
> > +		ret =3D PTR_ERR(dentry);
> > +		goto out;
> > +	}
> > +
> > +	trimcount =3D 0;
> > +
> >   	dentry =3D securityfs_create_file("runtime_measurements_count",
> >   				   S_IRUSR | S_IRGRP, ima_dir, NULL,
> >   				   &ima_measurements_count_ops);
> > diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/im=
a/ima_queue.c
> > index 590637e81ad1..77ab52469727 100644
> > --- a/security/integrity/ima/ima_queue.c
> > +++ b/security/integrity/ima/ima_queue.c
> > @@ -22,6 +22,14 @@
> >  =20
> >   #define AUDIT_CAUSE_LEN_MAX 32
> >  =20
> > +bool ima_flush_htable;
> > +static int __init ima_flush_htable_setup(char *str)
> > +{
> > +	ima_flush_htable =3D true;
> > +	return 1;
> > +}
> > +__setup("ima_flush_htable", ima_flush_htable_setup);
> > +
> >   /* pre-allocated array of tpm_digest structures to extend a PCR */
> >   static struct tpm_digest *digests;
> >  =20
> > @@ -220,6 +228,62 @@ int ima_add_template_entry(struct ima_template_ent=
ry *entry, int violation,
> >   	return result;
> >   }
> >  =20
> > +/* Delete the IMA event logs */

Do you mean delete the IMA event records/entries?

> > +long ima_purge_event_log(long number_logs)

If this function is not defined as static, then it requires a kernel-doc.

> > +{
> > +	struct ima_queue_entry *qe, *qe_tmp;
> > +	LIST_HEAD(ima_measurements_staged);
> > +	unsigned int i;
> > +	long cur =3D number_logs;

The variable name "number_logs" is confusing.  As I mentioned in the patch
description, there is one measurement list with multiple records.  There ar=
en't
multiple logs in the kernel (other than the staged list).

> > +
> > +	if (number_logs <=3D 0)
> > +		return number_logs;
> > +
> > +	mutex_lock(&ima_extend_list_mutex);
> > +
> > +
> > +	list_for_each_entry(qe, &ima_measurements, later) {
> > +		if (--number_logs =3D=3D 0)
> > +			break;
> > +	}
> > +
> > +	if (number_logs > 0) {
> > +		mutex_unlock(&ima_extend_list_mutex);
> > +		return -ENOENT;
> > +	}
> > +
> > +	__list_cut_position(&ima_measurements_staged, &ima_measurements,
> > +				    &qe->later);
> > +	atomic_long_sub(cur, &ima_htable.len);
> > +
> > +	if (!IS_ENABLED(CONFIG_IMA_DISABLE_HTABLE) && ima_flush_htable) {
> > +		list_for_each_entry(qe, &ima_measurements_staged, later)
> > +			/* It can race with ima_lookup_digest_entry(). */
> > +			hlist_del_rcu(&qe->hnext);
> > +	}
>=20
> If the h table can be staged during the locking period and deleted after=
=20
> unlocking, the time
> the list is held will be reduced.
>=20
> I will work on this, and any suggestions are greatly appreciated.
>=20
> Thanks,
>=20
> Steven
>=20
> > +
> > +	mutex_unlock(&ima_extend_list_mutex);
> > +
> > +
> > +	list_for_each_entry_safe(qe, qe_tmp, &ima_measurements_staged, later)=
 {
> > +		for (i =3D 0; i < qe->entry->template_desc->num_fields; i++) {
> > +			kfree(qe->entry->template_data[i].data);
> > +			qe->entry->template_data[i].data =3D NULL;
> > +			qe->entry->template_data[i].len =3D 0;
> > +		}
> > +
> > +		list_del(&qe->later);
> > +
> > +		if (ima_flush_htable) {
> > +			kfree(qe->entry->digests);
> > +			kfree(qe->entry);
> > +			kfree(qe);
> > +		}
> > +	}

To avoid code duplication, there's a similar function named
ima_free_template_entry().  Any changes needed to the function should be do=
ne as
a preparatory patch.

> > +
> > +	return cur;
> > +}
> > +
> >   int ima_restore_measurement_entry(struct ima_template_entry *entry)
> >   {
> >   	int result =3D 0;


--=20
thanks,

Mimi

