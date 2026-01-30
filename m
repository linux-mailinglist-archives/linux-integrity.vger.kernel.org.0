Return-Path: <linux-integrity+bounces-8371-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MKBZK1isfGkaOQIAu9opvQ
	(envelope-from <linux-integrity+bounces-8371-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 30 Jan 2026 14:04:24 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D9310BADA4
	for <lists+linux-integrity@lfdr.de>; Fri, 30 Jan 2026 14:04:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 24ADC300361C
	for <lists+linux-integrity@lfdr.de>; Fri, 30 Jan 2026 13:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1246D27E;
	Fri, 30 Jan 2026 13:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="K+j+gtFg"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2196127472;
	Fri, 30 Jan 2026 13:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769778094; cv=none; b=tHORWeRHj+p/4NctTe1/rtjeRD5DZNXCGVy93fEUKw3trhYF1Eq0LsRb10SAehVrr8NDEzsoHKONYmab3/NJUFlhOm0EWkmVBKqZOBXYJl2DHpxaFJkF9yD7DGyG9C2CJaCc3p/tmOyY/dBbX8UsIJlTDU4YY9ykUJhscAks1jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769778094; c=relaxed/simple;
	bh=sonhc906lOyPA3Rivxyo7mMB8kPmlhOuDfn3QMT/OAI=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=XkDMG9NDYQxk+DYB93n3x1WEMfwG67taOYdfSR9u3lQMlrCDF6aSzwkGOB1TCWi8pRtOY13iRjxvecaDVu2x2cvov9huShXyh1W2w45hv4m3NS741fllgw4lig/I0bOkGglKZFQliEZbg0Uzv1fI6BTIZwdHkWekR5r3FJPOqog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=K+j+gtFg; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60U2eAdU024596;
	Fri, 30 Jan 2026 13:00:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=s8EnGz
	FZjcZZrR5BC19BtR7KfOn3CUwhlV7Zg8/z4eQ=; b=K+j+gtFgH5tv7xoWGKv/Yc
	ZEzhWoiGgyes2XkDZL2gWi9wlDf7oEyfkGcU3xv02soiPk4SV5j/jreHIV3jnNzV
	i5P4yA/pEMOyUhKgOx1T2QC3tPgX/QAfKSjqHFNcC9iWu7hQs3y5kl8u5lT/l1ac
	JN5p8vG1X2kcEHeV7FRB2m+eDU9RidoVi6d5QWVB7YmjQVIhBC1RGVHrLNT0rlw1
	Cu4eO7GTBfENE6I3MHdQU//gbuIsVu2D7R1TRVeGPIVrZmxfNh6VUK2EZ0hGQd4E
	a3tF0aJwZvEWSkEZC9VWpx2FPJKc3ulMvKHBdzAyRo/pk9RX2imT7xprBeDPI66w
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvnrtwver-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 30 Jan 2026 13:00:59 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60UD0wZf026137;
	Fri, 30 Jan 2026 13:00:58 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvnrtwvek-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 30 Jan 2026 13:00:58 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60UAvcSv006687;
	Fri, 30 Jan 2026 13:00:57 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4bw8sypaj6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 30 Jan 2026 13:00:57 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60UD0uw415925784
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Jan 2026 13:00:56 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3127E58064;
	Fri, 30 Jan 2026 13:00:56 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9AE4058054;
	Fri, 30 Jan 2026 13:00:54 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.15.157])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 30 Jan 2026 13:00:54 +0000 (GMT)
Message-ID: <1da265acd3168a5c2b7390ddafc6a46d5e2d5613.camel@linux.ibm.com>
Subject: Re: [PATCH v4] ima: Fallback to ctime check for FS without
 kstat.change_cookie
From: Mimi Zohar <zohar@linux.ibm.com>
To: Frederick Lawler <fred@cloudflare.com>,
        Roberto Sassu	
 <roberto.sassu@huawei.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Eric Snowberg <eric.snowberg@oracle.com>,
        Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn"	 <serge@hallyn.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christian Brauner	
 <brauner@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>, Jeff Layton	
 <jlayton@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, kernel-team@cloudflare.com
In-Reply-To: <42da6a2c72b1093b7aa5106cdce4d0efdbd785ee.camel@linux.ibm.com>
References: <20260129-xfs-ima-fixup-v4-1-6bb89df7b6a3@cloudflare.com>
	 <42da6a2c72b1093b7aa5106cdce4d0efdbd785ee.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Jan 2026 08:00:54 -0500
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 3e9ipa-iXY0qYl6m_xYnyQ1Cfm2QZKDp
X-Authority-Analysis: v=2.4 cv=Uptu9uwB c=1 sm=1 tr=0 ts=697cab8b cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EG7W4yiQAAAA:8 a=X3O0K8v4pOr1HE7MqPgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: UL6HhsACli3gxIz8CMq3jCFNLN7TTmSB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTMwMDEwNCBTYWx0ZWRfX3mBCVrIl8Kf8
 y9kUz7pFGPzx/ja71T8g2dJUI0YGTYyqrhkT+yTO+hayS7fBOJAbDXHViJDlBeyS63crTrnl2qg
 9dbB0FPKKj0maqXx0itfYgfeRyFUtCl3E7ftaNfYxsP//YI+Y9ch0oki2gmbhUoI2aUThqT5D/v
 Hq8kIwN+MvY4lzqHFoQ5M809GWnzX8mwMQbV5YMGZUMR9cwJxLyi69Z1vqXWNmhrTXNCcqnS/nL
 /3QKODt+h33mcQqut/Uq0+MLMb8vbQKowGM3oy1IYu2pdgkeYUOFaKB7hmK9BmeQX7HiZCnomN8
 gBwCH9nsGDCIVsI8zuhDDQGh7d00qLIWSdfI3B9bkFTy5t0hvgd7y2o/MiRh1DqybOVPnE3iZ1z
 nSvkFODas10WwJBBO+71NYwbrNghO3GAs2P1DEjODxVmWYihvEPpyNMdYNN+q540XLSJG4yniQh
 LJo1LAqPvJMKV7XCGKw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-30_01,2026-01-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 clxscore=1015 lowpriorityscore=0
 phishscore=0 adultscore=0 impostorscore=0 bulkscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2601300104
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8371-lists,linux-integrity=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[cloudflare.com,huawei.com,gmail.com,oracle.com,paul-moore.com,namei.org,hallyn.com,kernel.org,toxicpanda.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[15];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zohar@linux.ibm.com,linux-integrity@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_TWELVE(0.00)[13];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-integrity];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: D9310BADA4
X-Rspamd-Action: no action

On Thu, 2026-01-29 at 21:32 -0500, Mimi Zohar wrote:
> On Thu, 2026-01-29 at 12:07 -0600, Frederick Lawler wrote:
> > Commit 1cf7e834a6fb ("xfs: switch to multigrain timestamps")
> > introduced a means to track change detection for an inode
> > via ctime updates, opposed to setting kstat.change_cookie to
> > an i_version when calling into xfs_vn_getattr().
> >=20
> > This introduced a regression for IMA such that an action
> > performed on a LOWER inode on a stacked file systems always
> > requires a re-evaluation if the LOWER file system does not
> > leverage kstat.change_cookie to track inode i_version or lacks
> > i_version support all together.
>=20
> Please describe the change in behavior that needs to be fixed.  Are there=
 too
> many, too few measurements, or both?
>=20
> Examples are fine, but first describe the problem - not detecting file ch=
ange on
> xfs.
>=20
> >=20
> > In the case of stacking XFS on XFS, an action on either the LOWER or UP=
PER
> > will require re-evaluation. Stacking TMPFS on XFS for instance, once th=
e
> > inode is UPPER is mutated, IMA resumes normal behavior because TMPFS
> > leverages generic_fillattr() to update the change cookie.
>=20
> This sounds like the same issue - not detecting file change on xfs.  The =
problem
> is simply manifesting itself on stacked filesystems.

Splitting this patch, so that the base XFS changes are in one patch and the
stacked filesystem changes are in the other, would really help clarify what=
 is
needed and the reason why.

Mimi

>=20
> >=20
> > This is because IMA caches kstat.change_cookie to compare against an
> > inode's i_version directly in integrity_inode_attrs_changed(), and thus
> > could be out of date depending on how file systems set
> > kstat.change_cookie.
> >=20
> > To address this, require integrity_inode_attrs_changed() to query
> > vfs_getattr_nosec() to compare the cached version against
> > kstat.change_cookie directly. This ensures that when updates occur,
> > we're accessing the same changed inode version on changes, and fallback
> > to compare against kstat.ctime when STATX_CHANGE_COOKIE is missing from
> > result mask.
> >=20
> > Lastly, because EVM still relies on querying and caching a inode's
> > i_version directly, the integrity_inode_attrs_changed() falls back to t=
he
> > original inode.i_version !=3D cached comparison.
> >=20
> > Link: https://lore.kernel.org/all/aTspr4_h9IU4EyrR@CMGLRV3
> > Fixes: 1cf7e834a6fb ("xfs: switch to multigrain timestamps")
> > Suggested-by: Jeff Layton <jlayton@kernel.org>
> > Reviewed-by: Jeff Layton <jlayton@kernel.org>
> > Signed-off-by: Frederick Lawler <fred@cloudflare.com>
> > ---
> >  include/linux/integrity.h         | 35 +++++++++++++++++++++++++++++++=
----
> >  security/integrity/evm/evm_main.c |  5 ++---
> >  security/integrity/ima/ima_api.c  | 11 ++++++++---
> >  security/integrity/ima/ima_main.c | 17 ++++++++++-------
> >  4 files changed, 51 insertions(+), 17 deletions(-)
> >=20
> > diff --git a/include/linux/integrity.h b/include/linux/integrity.h
> > index f5842372359be5341b6870a43b92e695e8fc78af..034f0a1ed48ca8c19c764e3=
02bbfc555dad92cde 100644
> > --- a/include/linux/integrity.h
> > +++ b/include/linux/integrity.h
> > @@ -9,6 +9,8 @@
> > =20
> >  #include <linux/fs.h>
> >  #include <linux/iversion.h>
> > +#include <linux/kernel.h>
> > +#include <linux/time64.h>
> > =20
> >  enum integrity_status {
> >  	INTEGRITY_PASS =3D 0,
> > @@ -51,14 +53,39 @@ integrity_inode_attrs_store(struct integrity_inode_=
attributes *attrs,
> > =20
> >  /*
> >   * On stacked filesystems detect whether the inode or its content has =
changed.
> > + *
> > + * Must be called in process context.
> >   */
> >  static inline bool
> >  integrity_inode_attrs_changed(const struct integrity_inode_attributes =
*attrs,
> > -			      const struct inode *inode)
> > +			      struct file *file, struct inode *inode)
> >  {
> > -	return (inode->i_sb->s_dev !=3D attrs->dev ||
> > -		inode->i_ino !=3D attrs->ino ||
> > -		!inode_eq_iversion(inode, attrs->version));
> > +	struct kstat stat;
> > +
> > +	might_sleep();
> > +
> > +	if (inode->i_sb->s_dev !=3D attrs->dev || inode->i_ino !=3D attrs->in=
o)
> > +		return true;
> > +
> > +	/*
> > +	 * EVM currently relies on backing inode i_version. While IS_I_VERSIO=
N
> > +	 * is not a good indicator of i_version support, this still retains
> > +	 * the logic such that a re-evaluation should still occur for EVM, an=
d
> > +	 * only for IMA if vfs_getattr_nosec() fails.
> > +	 */
> > +	if (!file || vfs_getattr_nosec(&file->f_path, &stat,
> > +				       STATX_CHANGE_COOKIE | STATX_CTIME,
> > +				       AT_STATX_SYNC_AS_STAT))
> > +		return !IS_I_VERSION(inode) ||
> > +			!inode_eq_iversion(inode, attrs->version);
> > +
> > +	if (stat.result_mask & STATX_CHANGE_COOKIE)
> > +		return stat.change_cookie !=3D attrs->version;
> > +
> > +	if (stat.result_mask & STATX_CTIME)
> > +		return timespec64_to_ns(&stat.ctime) !=3D (s64)attrs->version;
> > +
> > +	return true;
> >  }
> > =20
> > =20
> > diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima=
/ima_main.c
> > index 5770cf691912aa912fc65280c59f5baac35dd725..8ac42b03740eb93bf23b15c=
b9039af6cd32aa999 100644
> > --- a/security/integrity/ima/ima_main.c
> > +++ b/security/integrity/ima/ima_main.c
> > @@ -28,6 +28,7 @@
> >  #include <linux/iversion.h>
> >  #include <linux/evm.h>
> >  #include <linux/crash_dump.h>
> > +#include <linux/time64.h>
> > =20
> >  #include "ima.h"
> > =20
> > @@ -199,10 +200,13 @@ static void ima_check_last_writer(struct ima_iint=
_cache *iint,
> >  					    &iint->atomic_flags);
> >  		if ((iint->flags & IMA_NEW_FILE) ||
> >  		    vfs_getattr_nosec(&file->f_path, &stat,
> > -				      STATX_CHANGE_COOKIE,
> > -				      AT_STATX_SYNC_AS_STAT) ||
> > -		    !(stat.result_mask & STATX_CHANGE_COOKIE) ||
> > -		    stat.change_cookie !=3D iint->real_inode.version) {
> > +			    STATX_CHANGE_COOKIE | STATX_CTIME,
> > +			    AT_STATX_SYNC_AS_STAT) ||
> > +		    ((stat.result_mask & STATX_CHANGE_COOKIE) ?
> > +		      stat.change_cookie !=3D iint->real_inode.version :
> > +		      (!(stat.result_mask & STATX_CTIME) ||
> > +			timespec64_to_ns(&stat.ctime) !=3D
> > +			(s64)iint->real_inode.version))) {
> >  			iint->flags &=3D ~(IMA_DONE_MASK | IMA_NEW_FILE);
> >  			iint->measured_pcrs =3D 0;
> >  			if (update)
>=20
> The original i_version test was clear.  This code has become really hard =
to
> understand and needs to be cleaned up.  Defining a helper function, will =
also
> avoid code duplication.
>=20
> Mimi

