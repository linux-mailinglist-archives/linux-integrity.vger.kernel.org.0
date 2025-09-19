Return-Path: <linux-integrity+bounces-7204-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4596B8B104
	for <lists+linux-integrity@lfdr.de>; Fri, 19 Sep 2025 21:16:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87D7C7E5CD2
	for <lists+linux-integrity@lfdr.de>; Fri, 19 Sep 2025 19:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFC2C262FF3;
	Fri, 19 Sep 2025 19:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DMPzVkof"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20302522BA;
	Fri, 19 Sep 2025 19:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758309369; cv=none; b=WexnWipjQGeyTBJ3WR1mYbeLUyORaY6DDiKJx26gpvZMMB6JrdEMPLkgV4TEjICJ/OGD18IT0PrmEjE5kNX2LmA/Kp0Fl+YVHyPOdMgxfJM+TQLgLiD2aTD7MnGoK0+Sn7YsyQUW0hHEGh/QGdo4OzA/hhlieBJI865od/gTEQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758309369; c=relaxed/simple;
	bh=hqEDRIoWxovLFD5GRPtTpBf2QWAvOksGPbBR6IacplU=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=XSSLVlozYAX044rRPJytGaHsByzb1yIXrWsIUb53zUna9J7ltbqFeYJWyUIHzBXZHhdqeiwUe3MzDu8y8IbElwAqeOvuEB78X7KBFzxI6hvrQcekqPjEZ+vIYaCwjBlr3BulbkUORT0ZrciwM5FvSkFqawtNiMD7awKQbWq08IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DMPzVkof; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58JBCC62000339;
	Fri, 19 Sep 2025 19:15:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ZRF/XC
	GChCGLfHy31p8bJSdXzbDFSILge0faoD5mpcE=; b=DMPzVkofyyG9t4Pl9QyzSB
	JaxlCb8Ckc+sgn8I31m19DaUzcp0HskIF1JyGOY/xq32PaZLV2LyqUam7Tr86vSF
	fTJ+0ILCc9g+zSbMwC6AxHdnuOJfo4Op8QJ6LdK9CQYIIeTeZymVfN5318jH5k/u
	zr8kHyOlB3mse5lfzG5jzcbySJcEJRlYh/TUy2VTT83AeAUJ8UmFXXsTUWdW+3nP
	bqL2YoXZ5a4F70qpkIUShriPtNJ64NyZSMgQUMH1iEzXZZ3dXSPHV8ZZtdhx97bi
	G2Pf6GyWRWoGP/rZ78Swrm6L1CFHWh55arQDxb4OmUY5BhYenGgCepQoPsVsQbdQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 498dtwsp63-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Sep 2025 19:15:10 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58JJATUI015915;
	Fri, 19 Sep 2025 19:15:09 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 498dtwsp61-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Sep 2025 19:15:09 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58JIbuRl018629;
	Fri, 19 Sep 2025 19:15:08 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 495n5mw8s0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Sep 2025 19:15:08 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58JJF8Cl12124676
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Sep 2025 19:15:08 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 70C725803F;
	Fri, 19 Sep 2025 19:15:08 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 86A3B58056;
	Fri, 19 Sep 2025 19:15:07 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.19.242])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 19 Sep 2025 19:15:07 +0000 (GMT)
Message-ID: <d514db2f7c1de9b6d9092ff2ad1ce4cdba286e83.camel@linux.ibm.com>
Subject: Re: [PATCH v4 11/34] lsm: get rid of the lsm_names list and do
 some cleanup
From: Mimi Zohar <zohar@linux.ibm.com>
To: Paul Moore <paul@paul-moore.com>, linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org
Cc: John Johansen <john.johansen@canonical.com>,
        Roberto Sassu	
 <roberto.sassu@huawei.com>, Fan Wu <wufan@kernel.org>,
        =?ISO-8859-1?Q?Micka=EBl_Sala=FCn?=	 <mic@digikod.net>,
        =?ISO-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
        Kees Cook
 <kees@kernel.org>, Micah Morton <mortonm@chromium.org>,
        Casey Schaufler	
 <casey@schaufler-ca.com>,
        Tetsuo Handa
 <penguin-kernel@I-love.SAKURA.ne.jp>,
        Nicolas Bouchinet
 <nicolas.bouchinet@oss.cyber.gouv.fr>,
        Xiu Jianfeng <xiujianfeng@huawei.com>
In-Reply-To: <20250916220355.252592-47-paul@paul-moore.com>
References: <20250916220355.252592-36-paul@paul-moore.com>
	 <20250916220355.252592-47-paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 19 Sep 2025 15:15:07 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.54.3 (3.54.3-2.fc41) 
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=EYvIQOmC c=1 sm=1 tr=0 ts=68cdabbe cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=e1LNZ6x10KNBX6yl:21 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=xVhDTqbCAAAA:8
 a=VnNF1IyMAAAA:8 a=TkHCxqQqd29e2R4DizEA:9 a=QEXdDO2ut3YA:10
 a=GrmWmAYt4dzCMttCBZOh:22
X-Proofpoint-ORIG-GUID: KK0roCqITVnVApn9kkutlRXKFRa4mg3W
X-Proofpoint-GUID: XIutnYOTwOAMiWgwBBukhxzbO8tG4DA6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE4MDA2NSBTYWx0ZWRfXwD0eDcSvPAbk
 twGugv+uKOzkY3Xt3hflQeYsEziA5OdccHUbSy5ZyYU4lCa697FRkrqUrSIXVcBJUVzb5heUKi6
 WEZS+ElzHlILDstCvKCHgmP4OWNijv1Lg9HH+IV8/MaTUbnw0BH8dA1r9OfAFXommksBR3170nz
 4WM0i78VJmgSvqJc8/UFkG43hP2c2+HUFf3r+jh9isiwuplx7FT/CEo2BIo46g9ncIkT1HuGN00
 yN9EmbAVUUB9elZSYV1i+KCWzpvzBsJsHnswRNeTiOWMv0gdyVpBPu29byjbqAwTXF7Ea/xn0KF
 jR+//sfgJiAHLewCOPl51CxHErOtbEQ+L9PZ7x45Vw/A6/IsgDaRFcjTuTrJXaxfQ/x5AarMG26
 31qZs39d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-19_02,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 suspectscore=0 malwarescore=0 spamscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509180065

On Tue, 2025-09-16 at 18:03 -0400, Paul Moore wrote:
> The LSM currently has a lot of code to maintain a list of the currently
> active LSMs in a human readable string, with the only user being the
> "/sys/kernel/security/lsm" code.  Let's drop all of that code and
> generate the string on first use and then cache it for subsequent use.
>=20
> Signed-off-by: Paul Moore <paul@paul-moore.com>

FYI, checkpatch.pl complains of unbalanced braces, otherwise

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

> ---
>  include/linux/lsm_hooks.h |  1 -
>  security/inode.c          | 43 ++++++++++++++++++++++++++++++++--
>  security/lsm_init.c       | 49 ---------------------------------------
>  3 files changed, 41 insertions(+), 52 deletions(-)
>=20
> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index 7343dd60b1d5..65a8227bece7 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -172,7 +172,6 @@ struct lsm_info {
> =20
> =20
>  /* DO NOT tamper with these variables outside of the LSM framework */
> -extern char *lsm_names;
>  extern struct lsm_static_calls_table static_calls_table __ro_after_init;
> =20
>  /**
> diff --git a/security/inode.c b/security/inode.c
> index 43382ef8896e..6620c3e42af2 100644
> --- a/security/inode.c
> +++ b/security/inode.c
> @@ -22,6 +22,8 @@
>  #include <linux/lsm_hooks.h>
>  #include <linux/magic.h>
> =20
> +#include "lsm.h"
> +
>  static struct vfsmount *mount;
>  static int mount_count;
> =20
> @@ -315,12 +317,49 @@ void securityfs_remove(struct dentry *dentry)
>  EXPORT_SYMBOL_GPL(securityfs_remove);
> =20
>  #ifdef CONFIG_SECURITY
> +#include <linux/spinlock.h>
> +
>  static struct dentry *lsm_dentry;
> +
>  static ssize_t lsm_read(struct file *filp, char __user *buf, size_t coun=
t,
>  			loff_t *ppos)
>  {
> -	return simple_read_from_buffer(buf, count, ppos, lsm_names,
> -		strlen(lsm_names));
> +	int i;
> +	static char *str;
> +	static size_t len;
> +	static DEFINE_SPINLOCK(lock);
> +
> +	/* NOTE: we never free or modify the string once it is set */
> +
> +	if (unlikely(!str || !len)) {
> +		char *str_tmp;
> +		size_t len_tmp =3D 0;
> +
> +		for (i =3D 0; i < lsm_active_cnt; i++)
> +			/* the '+ 1' accounts for either a comma or a NUL */
> +			len_tmp +=3D strlen(lsm_idlist[i]->name) + 1;
> +
> +		str_tmp =3D kmalloc(len_tmp, GFP_KERNEL);
> +		if (!str_tmp)
> +			return -ENOMEM;
> +		str_tmp[0] =3D '\0';
> +
> +		for (i =3D 0; i < lsm_active_cnt; i++) {
> +			if (i > 0)
> +				strcat(str_tmp, ",");
> +			strcat(str_tmp, lsm_idlist[i]->name);
> +		}
> +
> +		spin_lock(&lock);
> +		if (!str) {
> +			str =3D str_tmp;
> +			len =3D len_tmp - 1;
> +		} else
> +			kfree(str_tmp);
> +		spin_unlock(&lock);
> +	}
> +
> +	return simple_read_from_buffer(buf, count, ppos, str, len);
>  }
> =20
>  static const struct file_operations lsm_ops =3D {
> diff --git a/security/lsm_init.c b/security/lsm_init.c
> index 9e495a36a332..87e2147016b3 100644
> --- a/security/lsm_init.c
> +++ b/security/lsm_init.c
> @@ -10,8 +10,6 @@
> =20
>  #include "lsm.h"
> =20
> -char *lsm_names;
> -
>  /* Pointers to LSM sections defined in include/asm-generic/vmlinux.lds.h=
 */
>  extern struct lsm_info __start_lsm_info[], __end_lsm_info[];
>  extern struct lsm_info __start_early_lsm_info[], __end_early_lsm_info[];
> @@ -371,42 +369,6 @@ static void __init lsm_init_ordered(void)
>  	}
>  }
> =20
> -static bool match_last_lsm(const char *list, const char *lsm)
> -{
> -	const char *last;
> -
> -	if (WARN_ON(!list || !lsm))
> -		return false;
> -	last =3D strrchr(list, ',');
> -	if (last)
> -		/* Pass the comma, strcmp() will check for '\0' */
> -		last++;
> -	else
> -		last =3D list;
> -	return !strcmp(last, lsm);
> -}
> -
> -static int lsm_append(const char *new, char **result)
> -{
> -	char *cp;
> -
> -	if (*result =3D=3D NULL) {
> -		*result =3D kstrdup(new, GFP_KERNEL);
> -		if (*result =3D=3D NULL)
> -			return -ENOMEM;
> -	} else {
> -		/* Check if it is the last registered name */
> -		if (match_last_lsm(*result, new))
> -			return 0;
> -		cp =3D kasprintf(GFP_KERNEL, "%s,%s", *result, new);
> -		if (cp =3D=3D NULL)
> -			return -ENOMEM;
> -		kfree(*result);
> -		*result =3D cp;
> -	}
> -	return 0;
> -}
> -
>  static void __init lsm_static_call_init(struct security_hook_list *hl)
>  {
>  	struct lsm_static_call *scall =3D hl->scalls;
> @@ -443,15 +405,6 @@ void __init security_add_hooks(struct security_hook_=
list *hooks, int count,
>  		hooks[i].lsmid =3D lsmid;
>  		lsm_static_call_init(&hooks[i]);
>  	}
> -
> -	/*
> -	 * Don't try to append during early_security_init(), we'll come back
> -	 * and fix this up afterwards.
> -	 */
> -	if (slab_is_available()) {
> -		if (lsm_append(lsmid->name, &lsm_names) < 0)
> -			panic("%s - Cannot get early memory.\n", __func__);
> -	}
>  }
> =20
>  int __init early_security_init(void)
> @@ -488,8 +441,6 @@ int __init security_init(void)
>  	lsm_early_for_each_raw(lsm) {
>  		init_debug("  early started: %s (%s)\n", lsm->id->name,
>  			   is_enabled(lsm) ? "enabled" : "disabled");
> -		if (lsm->enabled)
> -			lsm_append(lsm->id->name, &lsm_names);
>  	}
> =20
>  	/* Load LSMs in specified order. */


