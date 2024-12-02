Return-Path: <linux-integrity+bounces-4269-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3256F9E0D5C
	for <lists+linux-integrity@lfdr.de>; Mon,  2 Dec 2024 21:52:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 597E2B2DC9C
	for <lists+linux-integrity@lfdr.de>; Mon,  2 Dec 2024 19:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 405661DE892;
	Mon,  2 Dec 2024 19:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Hnh0GZID"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6D918E047;
	Mon,  2 Dec 2024 19:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733168453; cv=none; b=Kal7PHe11Yxalw7NYQWvMxQ9cStNQwCabSwwnaJ7AQwiS/2EXzKvReUCGlov3ofPY3pp0czHWabep6C5DRQBxoFrFnhk7X0DIG0FsmLMkJltA59rqvmWb2ljiUxB9ErgXIicckUxz1qPRYoFB75TAA64UFjldhSA35PciX2cqVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733168453; c=relaxed/simple;
	bh=3dvxIB2oNqh+4TYGO3ezioTkwcKN2PFha0czYCzr1eE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OLCGjGRxabi3QfqPL4xw+TlaneY2P4ZMVQBDbcreWJ+fKRZ5kgyUcUcaqVGw7F5+KhXu1I8FbKnBJfrpvueFmeoXEs6qc2sr+XbHDWKbv/WABOHSlgfXbBKDzTeGRMmToYLAhbdlbdnlDvrhWNGwXiQNkIe3dq8sG4JAwoSMIqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Hnh0GZID; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B2Ab2KN013712;
	Mon, 2 Dec 2024 19:40:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=TQOW9C
	+l9indLZMFa2Oqb4lyi9d1eK8Flxfg7APZm8g=; b=Hnh0GZIDEmbuUxrLXMmwpp
	kW7mSACxRw1W+qwtYHVJzrV1h7jb4Tqaa7sGyfWLSajPYTyId+HAcR9IvsqdDmzN
	TaH5Avqw73ThqWxGYIhCjsojI6gT1DLSNxpXUHDrPOHs9mUZbpCgA9vyr9s6QaYj
	qKQquM+6DbtVph6JUBuXuebLVnBzvAgxqpyNTFkuwcX5wun/aYn75eyCzm3fved8
	+O21D3BxkbT8RzLX12X+qIZceg0Yp606nk9NiYtx4TFymTBzq6qmzhDccPapPWmb
	VU2eYQlmlNdaVr5JpYV/kQHVQtbzjh24ViYjv8RAEje9rtMVgAjPnRquCXHY0L2g
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 437s4htmcd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Dec 2024 19:40:38 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4B2IEYfX007470;
	Mon, 2 Dec 2024 19:40:38 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 438f8jatpg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Dec 2024 19:40:38 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4B2JebMQ50135410
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 2 Dec 2024 19:40:37 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 447ED58053;
	Mon,  2 Dec 2024 19:40:37 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 66ABC58043;
	Mon,  2 Dec 2024 19:40:36 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.143.146])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  2 Dec 2024 19:40:36 +0000 (GMT)
Message-ID: <421b119b81ec044fcdc714aac5748ebe5b4557aa.camel@linux.ibm.com>
Subject: Re: [PATCH] ima: instantiate the bprm_creds_for_exec() hook
From: Mimi Zohar <zohar@linux.ibm.com>
To: =?ISO-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: linux-integrity@vger.kernel.org, roberto.sassu@huawei.com,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
        audit@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Date: Mon, 02 Dec 2024 14:40:35 -0500
In-Reply-To: <20241129.keeDathoo3Oh@digikod.net>
References: <20241127210234.121546-1-zohar@linux.ibm.com>
	 <20241129.keeDathoo3Oh@digikod.net>
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
X-Proofpoint-GUID: cjWddGwaWJXg3Cvte-VuV8TozL9yt5NH
X-Proofpoint-ORIG-GUID: cjWddGwaWJXg3Cvte-VuV8TozL9yt5NH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 suspectscore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 lowpriorityscore=0 bulkscore=0
 impostorscore=0 phishscore=0 spamscore=0 malwarescore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2412020165

On Fri, 2024-11-29 at 12:06 +0100, Micka=C3=ABl Sala=C3=BCn wrote:
> For reference, here is the base patch series:
> https://lore.kernel.org/all/20241112191858.162021-1-mic@digikod.net/
>=20
> CCing audit@
>=20
> On Wed, Nov 27, 2024 at 04:02:34PM -0500, Mimi Zohar wrote:
> > Like direct file execution (e.g. ./script.sh), indirect file execution
> > (e.g. sh script.sh) needs to be measured and appraised.  Instantiate
> > the new security_bprm_creds_for_exec() hook to measure and verify the
> > indirect file's integrity.  Unlike direct file execution, indirect file
> > execution integrity is optionally enforced by the interpreter.
> >=20
> > Update the audit messages to differentiate between kernel and userspace
> > enforced integrity.
>=20
> I'm not sure to see the full picture.  What is the difference between
> execveat() calls and execveat() + AT_EXECVE_CHECK calls?  Both are from
> user space, the only difference is that the first can lead to a full
> execution, but the intent is the same.

We do want the full execution in order to measure/appraise/audit both the d=
irect
file execution (e.g. ./script.sh) and the interpreter (e.g. #!/usr/bin/bash=
)
specified.

>=20
> >=20
> > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> > ---
> >  security/integrity/ima/ima_appraise.c | 84 ++++++++++++++++++++-------
> >  security/integrity/ima/ima_main.c     | 22 +++++++
> >  2 files changed, 86 insertions(+), 20 deletions(-)
> >=20
> > diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity=
/ima/ima_appraise.c
> > index 656c709b974f..b5f8e49cde9d 100644
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
> > @@ -16,6 +17,7 @@
> >  #include <linux/fsverity.h>
> >  #include <keys/system_keyring.h>
> >  #include <uapi/linux/fsverity.h>
> > +#include <linux/securebits.h>
> > =20
> >  #include "ima.h"
> > =20
> > @@ -276,7 +278,8 @@ static int calc_file_id_hash(enum evm_ima_xattr_typ=
e type,
> >   */
> >  static int xattr_verify(enum ima_hooks func, struct ima_iint_cache *ii=
nt,
> >  			struct evm_ima_xattr_data *xattr_value, int xattr_len,
> > -			enum integrity_status *status, const char **cause)
> > +			enum integrity_status *status, const char **cause,
> > +			bool is_check)
> >  {
> >  	struct ima_max_digest_data hash;
> >  	struct signature_v2_hdr *sig;
> > @@ -292,9 +295,11 @@ static int xattr_verify(enum ima_hooks func, struc=
t ima_iint_cache *iint,
> >  		if (*status !=3D INTEGRITY_PASS_IMMUTABLE) {
> >  			if (iint->flags & IMA_DIGSIG_REQUIRED) {
> >  				if (iint->flags & IMA_VERITY_REQUIRED)
> > -					*cause =3D "verity-signature-required";
> > +					*cause =3D !is_check ? "verity-signature-required" :
> > +						"verity-signature-required(userspace)";
>=20
> This looks simpler (same for all following checks):
> is_check ? "verity-signature-required(userspace)" : "verity-signature-req=
uired";
>=20
> >  				else
> > -					*cause =3D "IMA-signature-required";
> > +					*cause =3D !is_check ? "IMA-signature-required" :
> > +						"IMA-signature-required(userspace)";
> >  				*status =3D INTEGRITY_FAIL;
> >  				break;
> >  			}
> > @@ -314,7 +319,8 @@ static int xattr_verify(enum ima_hooks func, struct=
 ima_iint_cache *iint,
> >  		else
> >  			rc =3D -EINVAL;
> >  		if (rc) {
> > -			*cause =3D "invalid-hash";
> > +			*cause =3D !is_check ? "invalid-hash" :
> > +				"invalid-hash(userspace)";
> >  			*status =3D INTEGRITY_FAIL;
> >  			break;
> >  		}
> > @@ -325,14 +331,16 @@ static int xattr_verify(enum ima_hooks func, stru=
ct ima_iint_cache *iint,
> > =20
> >  		mask =3D IMA_DIGSIG_REQUIRED | IMA_VERITY_REQUIRED;
> >  		if ((iint->flags & mask) =3D=3D mask) {
> > -			*cause =3D "verity-signature-required";
> > +			*cause =3D !is_check ? "verity-signature-required" :
> > +				"verity-signature-required(userspace)";
> >  			*status =3D INTEGRITY_FAIL;
> >  			break;
> >  		}
> > =20
> >  		sig =3D (typeof(sig))xattr_value;
> >  		if (sig->version >=3D 3) {
> > -			*cause =3D "invalid-signature-version";
> > +			*cause =3D !is_check ? "invalid-signature-version" :
> > +				"invalid-signature-version(userspace)";
> >  			*status =3D INTEGRITY_FAIL;
> >  			break;
> >  		}
> > @@ -353,7 +361,8 @@ static int xattr_verify(enum ima_hooks func, struct=
 ima_iint_cache *iint,
> >  						     iint->ima_hash->digest,
> >  						     iint->ima_hash->length);
> >  		if (rc) {
> > -			*cause =3D "invalid-signature";
> > +			*cause =3D !is_check ? "invalid-signature" :
> > +				"invalid-signature(userspace)";
> >  			*status =3D INTEGRITY_FAIL;
> >  		} else {
> >  			*status =3D INTEGRITY_PASS;
> > @@ -364,7 +373,8 @@ static int xattr_verify(enum ima_hooks func, struct=
 ima_iint_cache *iint,
> > =20
> >  		if (iint->flags & IMA_DIGSIG_REQUIRED) {
> >  			if (!(iint->flags & IMA_VERITY_REQUIRED)) {
> > -				*cause =3D "IMA-signature-required";
> > +				*cause =3D !is_check ? "IMA-signature-required" :
> > +					"IMA-signature-required(userspace)";
> >  				*status =3D INTEGRITY_FAIL;
> >  				break;
> >  			}
> > @@ -372,7 +382,8 @@ static int xattr_verify(enum ima_hooks func, struct=
 ima_iint_cache *iint,
> > =20
> >  		sig =3D (typeof(sig))xattr_value;
> >  		if (sig->version !=3D 3) {
> > -			*cause =3D "invalid-signature-version";
> > +			*cause =3D !is_check ? "invalid-signature-version" :
> > +				"invalid-signature-version(userspace)";
> >  			*status =3D INTEGRITY_FAIL;
> >  			break;
> >  		}
> > @@ -382,7 +393,8 @@ static int xattr_verify(enum ima_hooks func, struct=
 ima_iint_cache *iint,
> >  				       container_of(&hash.hdr,
> >  					       struct ima_digest_data, hdr));
> >  		if (rc) {
> > -			*cause =3D "sigv3-hashing-error";
> > +			*cause =3D !is_check ? "sigv3-hashing-error" :
> > +				"sigv3-hashing-error(userspace)";
> >  			*status =3D INTEGRITY_FAIL;
> >  			break;
> >  		}
> > @@ -392,7 +404,8 @@ static int xattr_verify(enum ima_hooks func, struct=
 ima_iint_cache *iint,
> >  					     xattr_len, hash.digest,
> >  					     hash.hdr.length);
> >  		if (rc) {
> > -			*cause =3D "invalid-verity-signature";
> > +			*cause =3D !is_check ? "invalid-verity-signature" :
> > +				"invalid-verify-signature(userspace)";
> >  			*status =3D INTEGRITY_FAIL;
> >  		} else {
> >  			*status =3D INTEGRITY_PASS;
> > @@ -401,7 +414,8 @@ static int xattr_verify(enum ima_hooks func, struct=
 ima_iint_cache *iint,
> >  		break;
> >  	default:
> >  		*status =3D INTEGRITY_UNKNOWN;
> > -		*cause =3D "unknown-ima-data";
> > +		*cause =3D !is_check ? "unknown-ima-data" :
> > +			"unknown-ima-data(userspace)";
> >  		break;
> >  	}
> > =20
> > @@ -469,6 +483,18 @@ int ima_check_blacklist(struct ima_iint_cache *iin=
t,
> >  	return rc;
> >  }
> > =20
> > +static int is_bprm_creds_for_exec(enum ima_hooks func, struct file *fi=
le)
> > +{
> > +	struct linux_binprm *bprm =3D NULL;
> > +
> > +	if (func =3D=3D BPRM_CHECK) {
> > +		bprm =3D container_of(&file, struct linux_binprm, file);
> > +		if (bprm->is_check)
> > +			return 1;
> > +	}
> > +	return 0;
> > +}
> > +
> >  /*
> >   * ima_appraise_measurement - appraise file measurement
> >   *
> > @@ -489,11 +515,24 @@ int ima_appraise_measurement(enum ima_hooks func,=
 struct ima_iint_cache *iint,
> >  	enum integrity_status status =3D INTEGRITY_UNKNOWN;
> >  	int rc =3D xattr_len;
> >  	bool try_modsig =3D iint->flags & IMA_MODSIG_ALLOWED && modsig;
> > +	bool is_check =3D false;
> > =20
> >  	/* If not appraising a modsig, we need an xattr. */
> >  	if (!(inode->i_opflags & IOP_XATTR) && !try_modsig)
> >  		return INTEGRITY_UNKNOWN;
> > =20
> > +	/*
> > +	 * Unlike any of the other LSM hooks where the kernel enforces file
> > +	 * integrity, enforcing file integrity for the bprm_creds_for_exec()
> > +	 * LSM hook is left up to the discretion of the script interpreter
> > +	 * (userspace).
> > +	 *
> > +	 * Since the SECBIT_EXEC_RESTRICT_FILE flag is just a hint as to
> > +	 * userspace intentions, simply annotate the audit messages indicatin=
g
> > +	 * a userspace based query.
> > +	 */
> > +	is_check =3D is_bprm_creds_for_exec(func, file);
> > +
> >  	/* If reading the xattr failed and there's no modsig, error out. */
> >  	if (rc <=3D 0 && !try_modsig) {
> >  		if (rc && rc !=3D -ENODATA)
> > @@ -501,11 +540,14 @@ int ima_appraise_measurement(enum ima_hooks func,=
 struct ima_iint_cache *iint,
> > =20
> >  		if (iint->flags & IMA_DIGSIG_REQUIRED) {
> >  			if (iint->flags & IMA_VERITY_REQUIRED)
> > -				cause =3D "verity-signature-required";
> > +				cause =3D !is_check ? "verity-signature-required" :
> > +					"verity-signature-required(userspace)";
> >  			else
> > -				cause =3D "IMA-signature-required";
> > +				cause =3D !is_check ? "IMA-signature-required" :
> > +					"IMA-signature-required(userspace)";
> >  		} else {
> > -			cause =3D "missing-hash";
> > +			cause =3D !is_check ? "missing-hash" :
> > +				"missing-hash(userspace)";
> >  		}
> > =20
> >  		status =3D INTEGRITY_NOLABEL;
> > @@ -531,14 +573,15 @@ int ima_appraise_measurement(enum ima_hooks func,=
 struct ima_iint_cache *iint,
> >  			break;
> >  		fallthrough;
> >  	case INTEGRITY_NOLABEL:		/* No security.evm xattr. */
> > -		cause =3D "missing-HMAC";
> > +		cause =3D !is_check ? "missing-HMAC" : "missing-HMAC(userspace)";
> >  		goto out;
> >  	case INTEGRITY_FAIL_IMMUTABLE:
> >  		set_bit(IMA_DIGSIG, &iint->atomic_flags);
> > -		cause =3D "invalid-fail-immutable";
> > +		cause =3D !is_check ? "invalid-fail-immutable" :
> > +		       "invalid-fail-immutable(userspace)";
> >  		goto out;
> >  	case INTEGRITY_FAIL:		/* Invalid HMAC/signature. */
> > -		cause =3D "invalid-HMAC";
> > +		cause =3D !is_check ? "invalid-HMAC" : "invalid-HMAC(userspace)";
> >  		goto out;
> >  	default:
> >  		WARN_ONCE(true, "Unexpected integrity status %d\n", status);
> > @@ -546,7 +589,7 @@ int ima_appraise_measurement(enum ima_hooks func, s=
truct ima_iint_cache *iint,
> > =20
> >  	if (xattr_value)
> >  		rc =3D xattr_verify(func, iint, xattr_value, xattr_len, &status,
> > -				  &cause);
> > +				  &cause, is_check);
> > =20
> >  	/*
> >  	 * If we have a modsig and either no imasig or the imasig's key isn't
> > @@ -568,7 +611,8 @@ int ima_appraise_measurement(enum ima_hooks func, s=
truct ima_iint_cache *iint,
> >  	    ((inode->i_sb->s_iflags & SB_I_UNTRUSTED_MOUNTER) ||
> >  	     (iint->flags & IMA_FAIL_UNVERIFIABLE_SIGS))) {
> >  		status =3D INTEGRITY_FAIL;
> > -		cause =3D "unverifiable-signature";
> > +		cause =3D !is_check ? "unverifiable-signature" :
> > +			"unverifiable-signature(userspace)";
> >  		integrity_audit_msg(AUDIT_INTEGRITY_DATA, inode, filename,
> >  				    op, cause, rc, 0);
>=20
> Instead of adding new causes, another option would be to add a new audit
> record type (e.g. AUDIT_INTEGRITY_DATA_CHECK).  This would help filter
> these new kind of messages and I guess scale better.

Thanks.  This sounds like a better alternative.

>=20
> Another alternative would be to extend the audit message with a new
> field (e.g. "check=3D1"), but that would not help for efficient filtering=
.
>=20
> >  	} else if (status !=3D INTEGRITY_PASS) {
> > diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima=
/ima_main.c
> > index 06132cf47016..2b5d6bae77a4 100644
> > --- a/security/integrity/ima/ima_main.c
> > +++ b/security/integrity/ima/ima_main.c
> > @@ -554,6 +554,27 @@ static int ima_bprm_check(struct linux_binprm *bpr=
m)
> >  				   MAY_EXEC, CREDS_CHECK);
> >  }
> > =20
> > +/**
> > + * ima_bprm_creds_for_exec - based on policy, collect/store/appraise m=
easurement.
> > + * @bprm: contains the linux_binprm structure
> > + *
> > + * Based on the IMA policy and the execvat(2) AT_CHECK flag, measure a=
nd
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
>=20
> Why not replace bprm_check_security with bprm_creds_for_exec
> implementation altogether?

To measure/appraise/audit the interpreter specified in the direct file (e.g=
.
./script.sh).

>=20
> >  	LSM_HOOK_INIT(file_post_open, ima_file_check),
> >  	LSM_HOOK_INIT(inode_post_create_tmpfile, ima_post_create_tmpfile),
> >  	LSM_HOOK_INIT(file_release, ima_file_free),
> > --=20
> > 2.47.0
> >=20
> >=20
>=20


