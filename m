Return-Path: <linux-integrity+bounces-4283-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 56B7C9E3E55
	for <lists+linux-integrity@lfdr.de>; Wed,  4 Dec 2024 16:31:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B07EB4463B
	for <lists+linux-integrity@lfdr.de>; Wed,  4 Dec 2024 14:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 402E220C02A;
	Wed,  4 Dec 2024 14:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pTfWWrz8"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589DE20B213;
	Wed,  4 Dec 2024 14:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733324285; cv=none; b=DpfXL1m8BfdOqPpc156+HXZwLv9C7HUhTBrz1XrDIFZ3eYSstUyPqdb+3daAAY2hrt1NxwC+DJSLWLoaJH96KFor4PJrEQRqsAOp9kTSCd92f80MclPml0GY382Glabp6LRptH+f3JhcOhv0VO+JYB354U7sIIGxgQygUtjWkfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733324285; c=relaxed/simple;
	bh=GjhrluYpreCYMFzYbEg2LLnQDJaUUnwaAD8vNIvs5NI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=THlMcxALepceP+0B6EF+s9aDicUyV/UDTkV8RdWsMNYIc2QrEbw5wR2aBpYf9VtVcC1zCIHUuartCLFv67ZryP/OjUGbXwX81TRGx+XUqnQ1mafmrb+o2/MdUhbFaJBwxEbgMOWTGA8hzAqbE9QsBrtBQifytHxzipjOJyL3jaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pTfWWrz8; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B48Bg0w011762;
	Wed, 4 Dec 2024 14:57:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=LbRQWc
	qh8s2WL9rDyIC61iCEkeVu2qlyk1Orynh7ddI=; b=pTfWWrz8YPcd4ZL1gq+Z/y
	8EJe0CW62+ZE39Kqrq7WQJjv8w75se7Be8ryIwCW8WqPbMLjAwjU7Htg1H8lI+TI
	zOGaX6B5Tikb3fMqMXrsArE9pXRomDqvACu8n5nWRjZJ2FaqYdbq0z/T3ANfvrNr
	FMlvCsSrKx/rFG+JR9KMA3w1OyRdOp4iB8B+codj7axgD+aaYzItaoiAK+yIxJuc
	Me4+v81B0ws5MZgeEGYsd0gr2Hj5Iz7oGbY7nQr+4FxtYTbT7NPrVnYRYetihY1B
	Y+aBtjf+mPlDcgdD+pgo4IXdMljITvE2lyPRzBhoeCxTJvmA+6ukaYHpDzZ9DsCA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 437s4j84ur-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Dec 2024 14:57:45 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4B4AiZUe005290;
	Wed, 4 Dec 2024 14:57:45 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 438fr1naff-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Dec 2024 14:57:45 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4B4Evic947579486
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 4 Dec 2024 14:57:44 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3FC6A5805B;
	Wed,  4 Dec 2024 14:57:44 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 450C758055;
	Wed,  4 Dec 2024 14:57:43 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.150.77])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  4 Dec 2024 14:57:43 +0000 (GMT)
Message-ID: <a888a94fa38a538f961ad8a3a1bafda5b9870c89.camel@linux.ibm.com>
Subject: Re: [PATCH v2] ima: instantiate the bprm_creds_for_exec() hook
From: Mimi Zohar <zohar@linux.ibm.com>
To: =?ISO-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: linux-integrity@vger.kernel.org, roberto.sassu@huawei.com,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeff
 Xu <jeffxu@chromium.org>, Kees Cook <kees@kernel.org>,
        Paul Moore
 <paul@paul-moore.com>, audit@vger.kernel.org,
        Fan Wu
 <wufan@linux.microsoft.com>
Date: Wed, 04 Dec 2024 09:57:42 -0500
In-Reply-To: <20241204.IeZeTheing4e@digikod.net>
References: <20241203233424.287880-1-zohar@linux.ibm.com>
	 <20241204.IeZeTheing4e@digikod.net>
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
X-Proofpoint-GUID: cVyas8FIZ12rnqu1kunuyWJbnyFAfkyv
X-Proofpoint-ORIG-GUID: cVyas8FIZ12rnqu1kunuyWJbnyFAfkyv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 suspectscore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 lowpriorityscore=0 bulkscore=0
 impostorscore=0 phishscore=0 spamscore=0 malwarescore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2412040111

On Wed, 2024-12-04 at 11:15 +0100, Micka=C3=ABl Sala=C3=BCn wrote:
> On Tue, Dec 03, 2024 at 06:34:24PM -0500, Mimi Zohar wrote:
> > Like direct file execution (e.g. ./script.sh), indirect file exection
> > (e.g. sh script.sh) needs to be measured and appraised.  Instantiate
> > the new security_bprm_creds_for_exec() hook to measure and verify the
> > indirect file's integrity.  Unlike direct file execution, indirect file
> > execution is optionally enforced by the interpreter.
> >=20
> > Differentiate kernel and userspace enforced integrity audit messages.
> >=20
>=20
> I guess there is a missing tag:
>=20
> Co-developed-by: Roberto Sassu <roberto.sassu@huawei.com>

Having a different author with multiple "Signed-off-by" implies the patch
history, but adding the "Co-developed-by" is explicit.  I'll add the Co-
developed-by tag.

>=20
> > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
>=20
> With some minor comments, this looks good to me. I'll include this patch
> or the next one in my patch series.  Thanks!

Thank you.

>=20
> > ---
> > Changelog v2:
> > - Mickael: Use same audit messages with new audit message number
> > - Stefan Berger: Return boolean from is_bprm_creds_for_exec()=20
> >=20
> >  include/uapi/linux/audit.h            |  1 +
> >  security/integrity/ima/ima_appraise.c | 28 +++++++++++++++++++++++++--
> >  security/integrity/ima/ima_main.c     | 22 +++++++++++++++++++++
> >  3 files changed, 49 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
> > index 75e21a135483..826337905466 100644
> > --- a/include/uapi/linux/audit.h
> > +++ b/include/uapi/linux/audit.h
> > @@ -161,6 +161,7 @@
> >  #define AUDIT_INTEGRITY_RULE	    1805 /* policy rule */
> >  #define AUDIT_INTEGRITY_EVM_XATTR   1806 /* New EVM-covered xattr */
> >  #define AUDIT_INTEGRITY_POLICY_RULE 1807 /* IMA policy rules */
> > +#define AUDIT_INTEGRITY_DATA_CHECK  1808 /* Userspace enforced data in=
tegrity */
> > =20
> >  #define AUDIT_KERNEL		2000	/* Asynchronous audit record. NOT A REQUEST=
. */
> > =20
> > diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity=
/ima/ima_appraise.c
> > index 656c709b974f..144e0b39fbcd 100644
> > --- a/security/integrity/ima/ima_appraise.c
> > +++ b/security/integrity/ima/ima_appraise.c
> > @@ -8,6 +8,7 @@
> >  #include <linux/module.h>
> >  #include <linux/init.h>
> >  #include <linux/file.h>
> > +#include <linux/binfmts.h>
> >  #include <linux/fs.h>
> >  #include <linux/xattr.h>
> >  #include <linux/magic.h>
> > @@ -469,6 +470,18 @@ int ima_check_blacklist(struct ima_iint_cache *iin=
t,
> >  	return rc;
> >  }
> > =20
> > +static bool is_bprm_creds_for_exec(enum ima_hooks func, struct file *f=
ile)
> > +{
> > +	struct linux_binprm *bprm =3D NULL;
> > +
> > +	if (func =3D=3D BPRM_CHECK) {
>=20
> struct linux_binprm *bprm;

Local variables are normally defined at the beginning of the function.
>=20
> > +		bprm =3D container_of(&file, struct linux_binprm, file);
> > +		if (bprm->is_check)
> > +			return true;
>=20
> return bprm->is_check;

Yes, that's better.

>=20
> > +	}
> > +	return false;
> > +}
> > +
> >  /*
> >   * ima_appraise_measurement - appraise file measurement
> >   *
> > @@ -483,6 +496,7 @@ int ima_appraise_measurement(enum ima_hooks func, s=
truct ima_iint_cache *iint,
> >  			     int xattr_len, const struct modsig *modsig)
> >  {
> >  	static const char op[] =3D "appraise_data";
> > +	int audit_msgno =3D AUDIT_INTEGRITY_DATA;
> >  	const char *cause =3D "unknown";
> >  	struct dentry *dentry =3D file_dentry(file);
> >  	struct inode *inode =3D d_backing_inode(dentry);
> > @@ -494,6 +508,16 @@ int ima_appraise_measurement(enum ima_hooks func, =
struct ima_iint_cache *iint,
> >  	if (!(inode->i_opflags & IOP_XATTR) && !try_modsig)
> >  		return INTEGRITY_UNKNOWN;
> > =20
> > +	/*
> > +	 * Unlike any of the other LSM hooks where the kernel enforces file
> > +	 * integrity, enforcing file integrity for the bprm_creds_for_exec()
> > +	 * LSM hook with the AT_EXECVE_CHECK flag is left up to the discretio=
n
> > +	 * of the script interpreter(userspace). Differentiate kernel and
> > +	 * userspace enforced integrity audit messages.
> > +	 */
> > +	if (is_bprm_creds_for_exec(func, file))
> > +		audit_msgno =3D AUDIT_INTEGRITY_DATA_CHECK;
> > +
> >  	/* If reading the xattr failed and there's no modsig, error out. */
> >  	if (rc <=3D 0 && !try_modsig) {
> >  		if (rc && rc !=3D -ENODATA)
> > @@ -569,7 +593,7 @@ int ima_appraise_measurement(enum ima_hooks func, s=
truct ima_iint_cache *iint,
> >  	     (iint->flags & IMA_FAIL_UNVERIFIABLE_SIGS))) {
> >  		status =3D INTEGRITY_FAIL;
> >  		cause =3D "unverifiable-signature";
> > -		integrity_audit_msg(AUDIT_INTEGRITY_DATA, inode, filename,
> > +		integrity_audit_msg(audit_msgno, inode, filename,
> >  				    op, cause, rc, 0);
> >  	} else if (status !=3D INTEGRITY_PASS) {
> >  		/* Fix mode, but don't replace file signatures. */
> > @@ -589,7 +613,7 @@ int ima_appraise_measurement(enum ima_hooks func, s=
truct ima_iint_cache *iint,
> >  			status =3D INTEGRITY_PASS;
> >  		}
> > =20
> > -		integrity_audit_msg(AUDIT_INTEGRITY_DATA, inode, filename,
> > +		integrity_audit_msg(audit_msgno, inode, filename,
> >  				    op, cause, rc, 0);
> >  	} else {
> >  		ima_cache_flags(iint, func);
> > diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima=
/ima_main.c
> > index 06132cf47016..f0830e6d0cda 100644
> > --- a/security/integrity/ima/ima_main.c
> > +++ b/security/integrity/ima/ima_main.c
> > @@ -554,6 +554,27 @@ static int ima_bprm_check(struct linux_binprm *bpr=
m)
> >  				   MAY_EXEC, CREDS_CHECK);
> >  }
> > =20
> > +/**
> > + * ima_bprm_creds_for_exec - collect/store/appraise measurement.
> > + * @bprm: contains the linux_binprm structure
> > + *
> > + * Based on the IMA policy and the execvat(2) AT_CHECK flag, measure a=
nd
>=20
> AT_EXECVE_CHECK

Thanks, good catch.
>=20
> > + * appraise the integrity of a file to be executed by script interpret=
ers.
> > + * Unlike any of the other LSM hooks where the kernel enforces file in=
tegrity,
> > + * enforcing file integrity is left up to the discretion of the script
> > + * interpreter (userspace).
> > + *
> > + * On success return 0.  On integrity appraisal error, assuming the fi=
le
> > + * is in policy and IMA-appraisal is in enforcing mode, return -EACCES=
.
> > + */
> > +static int ima_bprm_creds_for_exec(struct linux_binprm *bprm)
> > +{
>=20
> We could have a comment explaining that ima_bprm_check() will not be
> called a second time bi the bprm_check_security hook if bprm->is_check
> is true because this hook would then not be called.  This would not be a
> security issue anyway, just a useless call.

Proposed comment:
+       /*=20
+        * As security_bprm_check() is called multiple times, both=20
+        * the script and the shebang interpreter are measured, appraised,
+        * and audited. Limit usage of this LSM hook to just measuring,
+        * appraising, and auditing the indirect script execution
+        * (e.g. ./sh example.sh).
+        */

>=20
> > +	if (!bprm->is_check)
> > +		return 0;
> > +
> > +	return ima_bprm_check(bprm);
> > +}
> > +
> >  /**
> >   * ima_file_check - based on policy, collect/store measurement.
> >   * @file: pointer to the file to be measured
> > @@ -1177,6 +1198,7 @@ static int __init init_ima(void)
> > =20
> >  static struct security_hook_list ima_hooks[] __ro_after_init =3D {
> >  	LSM_HOOK_INIT(bprm_check_security, ima_bprm_check),
> > +	LSM_HOOK_INIT(bprm_creds_for_exec, ima_bprm_creds_for_exec),
> >  	LSM_HOOK_INIT(file_post_open, ima_file_check),
> >  	LSM_HOOK_INIT(inode_post_create_tmpfile, ima_post_create_tmpfile),
> >  	LSM_HOOK_INIT(file_release, ima_file_free),
> > --=20
> > 2.47.0
> >=20
> >=20


