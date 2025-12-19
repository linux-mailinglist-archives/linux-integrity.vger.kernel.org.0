Return-Path: <linux-integrity+bounces-8123-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 57E05CD1906
	for <lists+linux-integrity@lfdr.de>; Fri, 19 Dec 2025 20:13:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1F463301A712
	for <lists+linux-integrity@lfdr.de>; Fri, 19 Dec 2025 19:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 819E32EB5BA;
	Fri, 19 Dec 2025 19:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mYfkGxCI"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC25B2D5C8E
	for <linux-integrity@vger.kernel.org>; Fri, 19 Dec 2025 19:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766171610; cv=none; b=AT3UuqC6n42colR0kikHfaCLgcT+8jEraqOac8imwdPIuO0l1LXNwIXEQTdG8uBNbjogDypVRErs1UMt6KK+yx/fJQdv7HqSTUAxwiYMRHv76wZV3GzaNb3e9hQy9svMGWV5eJqPTsnFAnljTT+rFZ6LHxsdAfLtuKo9ZxcsZNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766171610; c=relaxed/simple;
	bh=OqE6DS9r1DEYgMhlDJ0G/gWxO4867m2lvvmvMzTOTDU=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=kpboldn1YqXCpezNazje71XXBfFJhNspPDGFT9AS3dR1X7deYqp6eKpYw+yAaSAvEl9P18R4erxU+iKi0ZG8cSvSum6UdmJQeGtk2p5vY5LaePnT6BbuMx82wl2oD+SMZoPuXJ4m8iIBAnShuTmqyQYWuwbCkb0GZWWHmYwQOKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mYfkGxCI; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BJA6qLH013483;
	Fri, 19 Dec 2025 19:13:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=a2pYwx
	JrPDAhOjSn9b123HPdoH/W50k9kEAR40IaSfw=; b=mYfkGxCI1jKzF1IPBHPIIU
	64MLK8C545nsBnAtLE1ZaMk3wgAxi8kzKhYMrs2Hys4ET8vv8Q8LZdnxYRqRHJOq
	sGLcyNlRalGEhqX5AIr3ScH+rKlIA8GsrEzBrAKiuIIx0Psg7J4wBl603ugh1K5P
	o6eSXVU8XQtbRa4wEIZJqzU7jsaagdxfsemnqON/765xr1RqqxVl8KgimyRw4vhA
	WwvYWlZ/3jM8Y19lPIe+77td2uL4hAbLsK71ons16ousMwyVDP1fU6Ye9bWbRWR3
	RPvT6WtT5l89KJKv/O16zDSD5Tx4Ul2c7aDpzrAyR6BySw00D+Tc51+bX0zjB7HA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b4r3d5cs7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Dec 2025 19:13:11 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5BJJ4wG9000502;
	Fri, 19 Dec 2025 19:13:10 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b4r3d5cs6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Dec 2025 19:13:10 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BJIVqbH029545;
	Fri, 19 Dec 2025 19:13:09 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4b4qvqwdw8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Dec 2025 19:13:09 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5BJJD94228967570
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Dec 2025 19:13:09 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 291655805B;
	Fri, 19 Dec 2025 19:13:09 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 720375804B;
	Fri, 19 Dec 2025 19:13:08 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.43.111])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 19 Dec 2025 19:13:08 +0000 (GMT)
Message-ID: <8808db9a7abcc3299b688537d19d53310be5c17e.camel@linux.ibm.com>
Subject: Re: [RFC][PATCH v2 1/2] ima: measure loaded policy after write on
 securityfs policy file
From: Mimi Zohar <zohar@linux.ibm.com>
To: Enrico Bravi <enrico.bravi@polito.it>, linux-integrity@vger.kernel.org,
        dmitry.kasatkin@gmail.com, roberto.sassu@huawei.com
Cc: eric.snowberg@oracle.com
In-Reply-To: <20251216165620.683529-2-enrico.bravi@polito.it>
References: <20250225131255.154826-1-enrico.bravi@polito.it>
	 <20251216165620.683529-2-enrico.bravi@polito.it>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 19 Dec 2025 14:13:07 -0500
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.54.3 (3.54.3-2.fc41) 
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=WYkBqkhX c=1 sm=1 tr=0 ts=6945a3c7 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=9z9mAJ6vW8FpOuu1OngA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: lTy5_yASjc3F_fevMH6PvUX-t30XJsau
X-Proofpoint-ORIG-GUID: cM4x9Qo7Pk4XKtvjmZ00SsPb0rokHJvF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE5MDE1MyBTYWx0ZWRfXxjfI5kho5beb
 3LMvNQvhMMlk+ojFiYeLhtoUuRuh9IzRquAGnrCYQUOdJRqHAu+DXL+CKyJCtsWxGSyb6/0TT2k
 Esn6URULZYXV1BHtcA0+0RpWBAk8pUHi9h0luJ/Rk3DlXp1ml86F2d71eixOnhmJJWaK8KFkrFd
 O4nMHUudyDIr7zzrSJY0eu7hCINI7cVTNNw5lez3c8dZ2/Lg+h9y0WyQZNAP6HKwYBqxmaLTOda
 PfrewAk6eNfdNjcd7ziejQDCd18SpTKJl9XsIF/uqjcUtFHF+51c5AyXXWJeLuJuwFJ3dY45zeu
 TwUE1U3OrI8qnrLWOXnsVPrrdfj+altu8yYnWfxS9Xax02Ws181W/fdPWG19rQB6V4FAXcIwn/r
 3Vc1BpB4R1yWKo0vVmd46JlBZgqoJduQrpczTuic9FsOCzGB2+yp+DajGEU7DWZKpVsqhLsyCh2
 /919enPsp/5b1xMZGcg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-19_06,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 priorityscore=1501
 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0 clxscore=1011
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2512120000
 definitions=main-2512190153

On Tue, 2025-12-16 at 17:56 +0100, Enrico Bravi wrote:
> IMA policy can be written multiple times in the securityfs policy file
> at runtime if CONFIG_IMA_WRITE_POLICY=3Dy. When IMA_APPRAISE_POLICY is
> required, the policy needs to be signed to be loaded, writing the absolut=
e
> path of the file containing the new policy:
>=20
> echo /path/of/custom_ima_policy > /sys/kernel/security/ima/policy
>=20
> When this is not required, policy can be written directly, rule by rule:
>=20
> echo -e "measure func=3DBPRM_CHECK mask=3DMAY_EXEC\n" \
>         "audit func=3DBPRM_CHECK mask=3DMAY_EXEC\n" \
>      > /sys/kernel/security/ima/policy
>=20
> In this case, a new policy can be loaded without being measured or
> appraised.
>=20
> Add a new critical data record to measure the textual policy
> representation when it becomes effective.

The IMA policy could be really large.  Do we really want to include all the
policy rules in the template data?  The other option would be to include a =
hash
of the policy rules, in lieu of the policy rules themselves.

Please include directions for verifying the critical-data (e.g. using xxd).

>=20
> Signed-off-by: Enrico Bravi <enrico.bravi@polito.it>
> ---
>  security/integrity/ima/ima.h        |  1 +
>  security/integrity/ima/ima_efi.c    |  1 +
>  security/integrity/ima/ima_fs.c     |  1 +
>  security/integrity/ima/ima_policy.c | 63 ++++++++++++++++++++++++++++-
>  4 files changed, 64 insertions(+), 2 deletions(-)
>=20
> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> index e3d71d8d56e3..ca7b96663623 100644
> --- a/security/integrity/ima/ima.h
> +++ b/security/integrity/ima/ima.h
> @@ -425,6 +425,7 @@ void *ima_policy_start(struct seq_file *m, loff_t *po=
s);
>  void *ima_policy_next(struct seq_file *m, void *v, loff_t *pos);
>  void ima_policy_stop(struct seq_file *m, void *v);
>  int ima_policy_show(struct seq_file *m, void *v);
> +void ima_measure_loaded_policy(void);
> =20
>  /* Appraise integrity measurements */
>  #define IMA_APPRAISE_ENFORCE	0x01
> diff --git a/security/integrity/ima/ima_efi.c b/security/integrity/ima/im=
a_efi.c
> index 138029bfcce1..199c42d0f8b3 100644
> --- a/security/integrity/ima/ima_efi.c
> +++ b/security/integrity/ima/ima_efi.c
> @@ -62,6 +62,7 @@ static const char * const sb_arch_rules[] =3D {
>  	"appraise func=3DPOLICY_CHECK appraise_type=3Dimasig",
>  #endif
>  	"measure func=3DMODULE_CHECK",
> +	"measure func=3DCRITICAL_DATA label=3Dima_policy",

With this rule, the policy will always be measured, even when loading a sig=
ned
policy file.  It that necessary?

>  	NULL
>  };
> =20
> diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima=
_fs.c
> index 87045b09f120..89946d803d44 100644
> --- a/security/integrity/ima/ima_fs.c
> +++ b/security/integrity/ima/ima_fs.c
> @@ -476,6 +476,7 @@ static int ima_release_policy(struct inode *inode, st=
ruct file *file)
>  	}
> =20
>  	ima_update_policy();
> +	ima_measure_loaded_policy();
>  #if !defined(CONFIG_IMA_WRITE_POLICY) && !defined(CONFIG_IMA_READ_POLICY=
)
>  	securityfs_remove(file->f_path.dentry);
>  #elif defined(CONFIG_IMA_WRITE_POLICY)
> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima=
/ima_policy.c
> index 128fab897930..956063748008 100644
> --- a/security/integrity/ima/ima_policy.c
> +++ b/security/integrity/ima/ima_policy.c
> @@ -17,6 +17,7 @@
>  #include <linux/slab.h>
>  #include <linux/rculist.h>
>  #include <linux/seq_file.h>
> +#include <linux/vmalloc.h>
>  #include <linux/ima.h>
> =20
>  #include "ima.h"
> @@ -1983,7 +1984,6 @@ const char *const func_tokens[] =3D {
>  	__ima_hooks(__ima_hook_stringify)
>  };
> =20
> -#ifdef	CONFIG_IMA_READ_POLICY
>  enum {
>  	mask_exec =3D 0, mask_write, mask_read, mask_append
>  };
> @@ -2277,7 +2277,6 @@ int ima_policy_show(struct seq_file *m, void *v)
>  	seq_puts(m, "\n");
>  	return 0;
>  }
> -#endif	/* CONFIG_IMA_READ_POLICY */
> =20
>  #if defined(CONFIG_IMA_APPRAISE) && defined(CONFIG_INTEGRITY_TRUSTED_KEY=
RING)
>  /*
> @@ -2334,3 +2333,63 @@ bool ima_appraise_signature(enum kernel_read_file_=
id id)
>  	return found;
>  }
>  #endif /* CONFIG_IMA_APPRAISE && CONFIG_INTEGRITY_TRUSTED_KEYRING */
> +
> +static size_t ima_policy_text_len(void)
> +{
> +	struct list_head *ima_rules_tmp;
> +	struct ima_rule_entry *entry;
> +	struct seq_file file;
> +	size_t size =3D 0;
> +	char rule[255];
> +
> +	file.buf =3D rule;
> +	file.read_pos =3D 0;
> +	file.size =3D 255;
> +	file.count =3D 0;
> +
> +	rcu_read_lock();
> +	ima_rules_tmp =3D rcu_dereference(ima_rules);
> +	list_for_each_entry_rcu(entry, ima_rules_tmp, list) {
> +		ima_policy_show(&file, entry);
> +		size +=3D file.count;
> +		file.count =3D 0;
> +	}
> +	rcu_read_unlock();
> +
> +	return size;
> +}
> +
> +void ima_measure_loaded_policy(void)
> +{
> +	const char *event_name =3D "ima_policy_loaded";
> +	const char *op =3D "measure_loaded_ima_policy";
> +	const char *audit_cause =3D "ENOMEM";
> +	struct ima_rule_entry *rule_entry;
> +	struct list_head *ima_rules_tmp;
> +	struct seq_file file;
> +	int result =3D -ENOMEM;
> +	size_t file_len =3D ima_policy_text_len();

Normally a function is defined to prevent code duplication or for readabili=
ty.=20
In this case, it doesn't achieve either.

Add a comment here, something like:
/* calculate IMA policy rules memory size */

> +
> +	file.buf =3D vmalloc(file_len);
> +	if (!file.buf) {
> +		integrity_audit_msg(AUDIT_INTEGRITY_PCR, NULL, event_name,
> +				    op, audit_cause, result, 1);
> +		return;
> +	}
>=20
>=20

And another comment below, something like:
/* copy IMA policy rules to a buffer */

> +
> +	file.read_pos =3D 0;
> +	file.size =3D file_len;
> +	file.count =3D 0;
> +
> +	rcu_read_lock();
> +	ima_rules_tmp =3D rcu_dereference(ima_rules);
> +	list_for_each_entry_rcu(rule_entry, ima_rules_tmp, list) {
> +		ima_policy_show(&file, rule_entry);
> +	}
> +	rcu_read_unlock();
> +
> +	ima_measure_critical_data("ima_policy", event_name, file.buf,
> +				  file.count, false, NULL, 0);
> +
> +	vfree(file.buf);
> +}

Thanks,

Mimi

