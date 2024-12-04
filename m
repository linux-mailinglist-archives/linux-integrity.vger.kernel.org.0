Return-Path: <linux-integrity+bounces-4287-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 095469E4496
	for <lists+linux-integrity@lfdr.de>; Wed,  4 Dec 2024 20:28:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58F01284948
	for <lists+linux-integrity@lfdr.de>; Wed,  4 Dec 2024 19:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ACA31C3BF9;
	Wed,  4 Dec 2024 19:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gbMLZqc9"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D521C3BF5;
	Wed,  4 Dec 2024 19:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733340493; cv=none; b=QYHGhohpBdOcYAffg3vEvw2vcKDIZHNYyuj+98C+jH1189pXs1jN9NXFkElPK63Z0JBWbGQQarN1V/NRkjk2DGm3VqkfgjtraaIUJD5wpwdyzbGvKlCL1dPaLKoxd7fsk0EJATSc8khyh7fxaFQTBIvI26p8DmsIV7900Pnnn6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733340493; c=relaxed/simple;
	bh=V5Z99NBb8b6rSst4hRmnhOCuy/3r9IQFwnLv6vaxXTw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sL6jK9UX5leYlDwjFfwO6rs/Tw50E1uGDwrvV7Pnr6csv+ZsZgLXa1mBRkfFcmQ+whHWFku0A1ppa8taFRnU7F/aAXWQFBD6mbyQyCvR8INCFg7kZ4s+u75Z1s6ZXUMox9+kJkonpGXz9GcXx90NJlHYG+BggW4GhWlwEvn8nWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gbMLZqc9; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B4Ht5Ln003827;
	Wed, 4 Dec 2024 19:27:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ZyQpPl
	+bjV1rX6XPFZ/MNos7dOYW2aS9HLGyFn5yUU4=; b=gbMLZqc9EIE3W13YgvcOjj
	CIO3BdvJJhkJGEK6Cnac70Zbr8qPJLVTwVsUoHG7rkDZnITwax+GD7FvmMGxUojB
	t5n69PjupIkZXOgE/Nmf5w0sOfMXWkK0yoTJoEkdYn3UAyst8rke2/jleu/TUTGI
	vwCAZSJXQtYT/vvVznbPrpqc5GU+fDJN+IGTZlvv/xdmJpdkRj6IQXnieX7ibzud
	phA5XvzF+V+qaZIluVkc6uk96d1kMZ8GGO6JG0aFszu2q5pEu0SM0UnHp0ff4hQE
	ofttavvYMimniWLrKUy+t244SeqTZP4YLGZ/pusbci3xdK/0HVRG+AuuQo19+V7Q
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 437r4psrkq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Dec 2024 19:27:54 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4B4HQFBo005253;
	Wed, 4 Dec 2024 19:27:53 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43a2kxn36q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Dec 2024 19:27:53 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4B4JRqnf17367572
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 4 Dec 2024 19:27:53 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A5C3D5805E;
	Wed,  4 Dec 2024 19:27:52 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 236C15805C;
	Wed,  4 Dec 2024 19:27:52 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.31.103.152])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  4 Dec 2024 19:27:52 +0000 (GMT)
Message-ID: <67b2e94f263bf9a0099efe74cce659d6acb16fe9.camel@linux.ibm.com>
Subject: Re: [PATCH v2] ima: instantiate the bprm_creds_for_exec() hook
From: Mimi Zohar <zohar@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: =?ISO-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
        roberto.sassu@huawei.com, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jeff Xu <jeffxu@chromium.org>,
        Kees Cook
	 <kees@kernel.org>, Paul Moore <paul@paul-moore.com>,
        audit@vger.kernel.org
Date: Wed, 04 Dec 2024 14:27:51 -0500
In-Reply-To: <20241204192514.40308-1-zohar@linux.ibm.com>
References: <20241204192514.40308-1-zohar@linux.ibm.com>
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
X-Proofpoint-GUID: Zygmr5Q-Iz5zrBpJOh9SGFXDcZTqJoY_
X-Proofpoint-ORIG-GUID: Zygmr5Q-Iz5zrBpJOh9SGFXDcZTqJoY_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 clxscore=1011 phishscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 bulkscore=0 mlxlogscore=999 adultscore=0
 lowpriorityscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2412040145

This should have been patch v3.

Mimi

On Wed, 2024-12-04 at 14:25 -0500, Mimi Zohar wrote:
> Like direct file execution (e.g. ./script.sh), indirect file execution
> (e.g. sh script.sh) needs to be measured and appraised.  Instantiate
> the new security_bprm_creds_for_exec() hook to measure and verify the
> indirect file's integrity.  Unlike direct file execution, indirect file
> execution is optionally enforced by the interpreter.
>=20
> Differentiate kernel and userspace enforced integrity audit messages.
>=20
> Co-developed-by: Roberto Sassu <roberto.sassu@huawei.com>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
> Changelog v3:
> - Mickael: add comment ima_bprm_creds_for_exec(), minor code cleanup,
>   add Co-developed-by tag.
>=20
> Changelog v2:
> - Mickael: Use same audit messages with new audit message number
> - Stefan Berger: Return boolean from is_bprm_creds_for_exec()
>=20
>  include/uapi/linux/audit.h            |  1 +
>  security/integrity/ima/ima_appraise.c | 27 +++++++++++++++++++++++--
>  security/integrity/ima/ima_main.c     | 29 +++++++++++++++++++++++++++
>  3 files changed, 55 insertions(+), 2 deletions(-)
>=20
> diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
> index 75e21a135483..826337905466 100644
> --- a/include/uapi/linux/audit.h
> +++ b/include/uapi/linux/audit.h
> @@ -161,6 +161,7 @@
>  #define AUDIT_INTEGRITY_RULE	    1805 /* policy rule */
>  #define AUDIT_INTEGRITY_EVM_XATTR   1806 /* New EVM-covered xattr */
>  #define AUDIT_INTEGRITY_POLICY_RULE 1807 /* IMA policy rules */
> +#define AUDIT_INTEGRITY_DATA_CHECK  1808 /* Userspace enforced data inte=
grity */
> =20
>  #define AUDIT_KERNEL		2000	/* Asynchronous audit record. NOT A REQUEST. =
*/
> =20
> diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/i=
ma/ima_appraise.c
> index 656c709b974f..fc0d1f3cceca 100644
> --- a/security/integrity/ima/ima_appraise.c
> +++ b/security/integrity/ima/ima_appraise.c
> @@ -8,6 +8,7 @@
>  #include <linux/module.h>
>  #include <linux/init.h>
>  #include <linux/file.h>
> +#include <linux/binfmts.h>
>  #include <linux/fs.h>
>  #include <linux/xattr.h>
>  #include <linux/magic.h>
> @@ -469,6 +470,17 @@ int ima_check_blacklist(struct ima_iint_cache *iint,
>  	return rc;
>  }
> =20
> +static bool is_bprm_creds_for_exec(enum ima_hooks func, struct file *fil=
e)
> +{
> +	struct linux_binprm *bprm;
> +
> +	if (func =3D=3D BPRM_CHECK) {
> +		bprm =3D container_of(&file, struct linux_binprm, file);
> +		return bprm->is_check;
> +	}
> +	return false;
> +}
> +
>  /*
>   * ima_appraise_measurement - appraise file measurement
>   *
> @@ -483,6 +495,7 @@ int ima_appraise_measurement(enum ima_hooks func, str=
uct ima_iint_cache *iint,
>  			     int xattr_len, const struct modsig *modsig)
>  {
>  	static const char op[] =3D "appraise_data";
> +	int audit_msgno =3D AUDIT_INTEGRITY_DATA;
>  	const char *cause =3D "unknown";
>  	struct dentry *dentry =3D file_dentry(file);
>  	struct inode *inode =3D d_backing_inode(dentry);
> @@ -494,6 +507,16 @@ int ima_appraise_measurement(enum ima_hooks func, st=
ruct ima_iint_cache *iint,
>  	if (!(inode->i_opflags & IOP_XATTR) && !try_modsig)
>  		return INTEGRITY_UNKNOWN;
> =20
> +	/*
> +	 * Unlike any of the other LSM hooks where the kernel enforces file
> +	 * integrity, enforcing file integrity for the bprm_creds_for_exec()
> +	 * LSM hook with the AT_EXECVE_CHECK flag is left up to the discretion
> +	 * of the script interpreter(userspace). Differentiate kernel and
> +	 * userspace enforced integrity audit messages.
> +	 */
> +	if (is_bprm_creds_for_exec(func, file))
> +		audit_msgno =3D AUDIT_INTEGRITY_DATA_CHECK;
> +
>  	/* If reading the xattr failed and there's no modsig, error out. */
>  	if (rc <=3D 0 && !try_modsig) {
>  		if (rc && rc !=3D -ENODATA)
> @@ -569,7 +592,7 @@ int ima_appraise_measurement(enum ima_hooks func, str=
uct ima_iint_cache *iint,
>  	     (iint->flags & IMA_FAIL_UNVERIFIABLE_SIGS))) {
>  		status =3D INTEGRITY_FAIL;
>  		cause =3D "unverifiable-signature";
> -		integrity_audit_msg(AUDIT_INTEGRITY_DATA, inode, filename,
> +		integrity_audit_msg(audit_msgno, inode, filename,
>  				    op, cause, rc, 0);
>  	} else if (status !=3D INTEGRITY_PASS) {
>  		/* Fix mode, but don't replace file signatures. */
> @@ -589,7 +612,7 @@ int ima_appraise_measurement(enum ima_hooks func, str=
uct ima_iint_cache *iint,
>  			status =3D INTEGRITY_PASS;
>  		}
> =20
> -		integrity_audit_msg(AUDIT_INTEGRITY_DATA, inode, filename,
> +		integrity_audit_msg(audit_msgno, inode, filename,
>  				    op, cause, rc, 0);
>  	} else {
>  		ima_cache_flags(iint, func);
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/i=
ma_main.c
> index 06132cf47016..5d4ac8aa2f1f 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -554,6 +554,34 @@ static int ima_bprm_check(struct linux_binprm *bprm)
>  				   MAY_EXEC, CREDS_CHECK);
>  }
> =20
> +/**
> + * ima_bprm_creds_for_exec - collect/store/appraise measurement.
> + * @bprm: contains the linux_binprm structure
> + *
> + * Based on the IMA policy and the execvat(2) AT_EXECVE_CHECK flag, meas=
ure
> + * and appraise the integrity of a file to be executed by script interpr=
eters.
> + * Unlike any of the other LSM hooks where the kernel enforces file inte=
grity,
> + * enforcing file integrity is left up to the discretion of the script
> + * interpreter (userspace).
> + *
> + * On success return 0.  On integrity appraisal error, assuming the file
> + * is in policy and IMA-appraisal is in enforcing mode, return -EACCES.
> + */
> +static int ima_bprm_creds_for_exec(struct linux_binprm *bprm)
> +{
> +	/*
> +	 * As security_bprm_check() is called multiple times, both
> +	 * the script and the shebang interpreter are measured, appraised,
> +	 * and audited. Limit usage of this LSM hook to just measuring,
> +	 * appraising, and auditing the indirect script execution
> +	 * (e.g. ./sh example.sh).
> +	 */
> +	if (!bprm->is_check)
> +		return 0;
> +
> +	return ima_bprm_check(bprm);
> +}
> +
>  /**
>   * ima_file_check - based on policy, collect/store measurement.
>   * @file: pointer to the file to be measured
> @@ -1177,6 +1205,7 @@ static int __init init_ima(void)
> =20
>  static struct security_hook_list ima_hooks[] __ro_after_init =3D {
>  	LSM_HOOK_INIT(bprm_check_security, ima_bprm_check),
> +	LSM_HOOK_INIT(bprm_creds_for_exec, ima_bprm_creds_for_exec),
>  	LSM_HOOK_INIT(file_post_open, ima_file_check),
>  	LSM_HOOK_INIT(inode_post_create_tmpfile, ima_post_create_tmpfile),
>  	LSM_HOOK_INIT(file_release, ima_file_free),


