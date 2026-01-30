Return-Path: <linux-integrity+bounces-8369-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IBZuC1cYfGk/KgIAu9opvQ
	(envelope-from <linux-integrity+bounces-8369-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 30 Jan 2026 03:32:55 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id AD30FB67C4
	for <lists+linux-integrity@lfdr.de>; Fri, 30 Jan 2026 03:32:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1DF2430059A2
	for <lists+linux-integrity@lfdr.de>; Fri, 30 Jan 2026 02:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C83E73164D0;
	Fri, 30 Jan 2026 02:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="B2CLE9ai"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2195D2036E9;
	Fri, 30 Jan 2026 02:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769740371; cv=none; b=Uo5vuwh25krWnM022Ao1H8AUa3Z0AfoM9aJaWr4YCB06BvNFQExHGyY6fUXyMB4pAaKhdOfECdXB8f+tHR6jlkgURdHl+8qg8TMmvIETu01kaLFptI4LK7dfhcLSRbUceSan+x7HejcHHBGYPb/t39DTUn26KJ6I2+eBVTW/SoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769740371; c=relaxed/simple;
	bh=WDw7rcNTDL7tHtKIZICN9Bl/1o7hwHMBaDMW76RvDnY=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=A5QFZdxTIsI/bVAEvZhPStaPSowMXjBnNe2PZ4psvhZ/kQnZh2MVXCHxJTQnwhkd2Vd24r0lchYhSekzuzPqtMS+8A40/WCMAsfLA6RRtvJeI3ET0x+tzEIY+Jl9zz7IrVtLinAV220LNisaTQToDYcGtFlGgn7CDAO3KHohU5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=B2CLE9ai; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60TEKBX4022829;
	Fri, 30 Jan 2026 02:32:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=2OIqzh
	5ESxmNvzqg/wpLtxWi8GFv5+sJn6Gn6i5KMVg=; b=B2CLE9aiFti1rvjC4LnfFk
	sPLontwqlWjVm2Zn6dlxE3Q7FGT97y7WvDCUX8dx7evF/bC2jrVqL/GOFJA9eI8q
	T1soL0zx6vywPi1GXXbtudHSqjki+l6E0bd5/ev0aW/hc1IyEdLx95XBRpruPHhu
	/hB5LuPt/S+5uHKadB5OKFrSvFLjvcpJUTxVzBjoS4RGHAF6OsSiRqRFmZHudEPa
	lZb4hYMxXPw84oOSLoO43pJFCfyCWkq8fc0J9awf5ErKfiE2dTeU1kwXhineBOi6
	9vCwsJXLjSahcnIFU87qRpL1vyn1vZv6qkFzqV13JyqNglD1KISN9Y/U7C6w8K6Q
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvkgn15dg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 30 Jan 2026 02:32:22 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60U2WL6G021639;
	Fri, 30 Jan 2026 02:32:21 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvkgn15df-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 30 Jan 2026 02:32:21 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60U1Ajul018238;
	Fri, 30 Jan 2026 02:32:20 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4bwb424a99-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 30 Jan 2026 02:32:20 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60U2WJGF62783812
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Jan 2026 02:32:19 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 615D15805A;
	Fri, 30 Jan 2026 02:32:19 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5350D5805E;
	Fri, 30 Jan 2026 02:32:18 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.18.136])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 30 Jan 2026 02:32:18 +0000 (GMT)
Message-ID: <42da6a2c72b1093b7aa5106cdce4d0efdbd785ee.camel@linux.ibm.com>
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
In-Reply-To: <20260129-xfs-ima-fixup-v4-1-6bb89df7b6a3@cloudflare.com>
References: <20260129-xfs-ima-fixup-v4-1-6bb89df7b6a3@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Jan 2026 21:32:17 -0500
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Gr1PO01C c=1 sm=1 tr=0 ts=697c1836 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EG7W4yiQAAAA:8 a=Nh1rTGwYjvPCPEUbleoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: um94vgnG2Af_JZ72yUtGnbWEuTMce5B_
X-Proofpoint-ORIG-GUID: XNXvJCX7-hRKC11F9nfWWGW6Vgdr7Q8I
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTMwMDAxNiBTYWx0ZWRfX8NhCMrkCZ4ZY
 nwlgqUcZX24DCWJDmaa4lb1Q2NrJdUtAkhtO+FC1J36ZdcG4PAqLOinHVHnRA/p71NaCCqBpYYi
 BCQv0UdMIa/Edd4trcQhb5dhiDGAMx7TXcFEAHN5OMR3ZKsiAjTQmIuj33jbQftQMus/NjYzyBF
 B2I2+Wcj4TfVIFrj3lCNHo6ehUP4vR1Y0m8nnkq8ulI3qKnx/+TEXRHnb51JK0zAvvNIxG8g0Id
 WXD4mH5IfSwOdtOcMzarcxc4uhFDWUYxhZ/rgcWvfvE1z0tE191Rv25U0VmxKlL2TkgfHqOBlIa
 IWC30OZkFImsoge3sIaChBuMDheHL7btVjbE4FK++v6gAeJYUWlwV8F3cdPooQcpQOqqxus0FXB
 Pqp/yp8+/sef2aWFYHoyL1rGhZQS1U2Xl54lZ8w1pDM5RbrgtGiGqJHTCHqpy7KE5mKsR6+RL09
 bCDH/0m5L7egpm63TTA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-29_03,2026-01-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 lowpriorityscore=0 suspectscore=0
 impostorscore=0 phishscore=0 malwarescore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2601300016
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8369-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[cloudflare.com,huawei.com,gmail.com,oracle.com,paul-moore.com,namei.org,hallyn.com,kernel.org,toxicpanda.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_TWELVE(0.00)[13];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zohar@linux.ibm.com,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[ibm.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-integrity];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cloudflare.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.ibm.com:mid]
X-Rspamd-Queue-Id: AD30FB67C4
X-Rspamd-Action: no action

On Thu, 2026-01-29 at 12:07 -0600, Frederick Lawler wrote:
> Commit 1cf7e834a6fb ("xfs: switch to multigrain timestamps")
> introduced a means to track change detection for an inode
> via ctime updates, opposed to setting kstat.change_cookie to
> an i_version when calling into xfs_vn_getattr().
>=20
> This introduced a regression for IMA such that an action
> performed on a LOWER inode on a stacked file systems always
> requires a re-evaluation if the LOWER file system does not
> leverage kstat.change_cookie to track inode i_version or lacks
> i_version support all together.

Please describe the change in behavior that needs to be fixed.  Are there t=
oo
many, too few measurements, or both?

Examples are fine, but first describe the problem - not detecting file chan=
ge on
xfs.

>=20
> In the case of stacking XFS on XFS, an action on either the LOWER or UPPE=
R
> will require re-evaluation. Stacking TMPFS on XFS for instance, once the
> inode is UPPER is mutated, IMA resumes normal behavior because TMPFS
> leverages generic_fillattr() to update the change cookie.

This sounds like the same issue - not detecting file change on xfs.  The pr=
oblem
is simply manifesting itself on stacked filesystems.

>=20
> This is because IMA caches kstat.change_cookie to compare against an
> inode's i_version directly in integrity_inode_attrs_changed(), and thus
> could be out of date depending on how file systems set
> kstat.change_cookie.
>=20
> To address this, require integrity_inode_attrs_changed() to query
> vfs_getattr_nosec() to compare the cached version against
> kstat.change_cookie directly. This ensures that when updates occur,
> we're accessing the same changed inode version on changes, and fallback
> to compare against kstat.ctime when STATX_CHANGE_COOKIE is missing from
> result mask.
>=20
> Lastly, because EVM still relies on querying and caching a inode's
> i_version directly, the integrity_inode_attrs_changed() falls back to the
> original inode.i_version !=3D cached comparison.
>=20
> Link: https://lore.kernel.org/all/aTspr4_h9IU4EyrR@CMGLRV3
> Fixes: 1cf7e834a6fb ("xfs: switch to multigrain timestamps")
> Suggested-by: Jeff Layton <jlayton@kernel.org>
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> Signed-off-by: Frederick Lawler <fred@cloudflare.com>
> ---
>  include/linux/integrity.h         | 35 +++++++++++++++++++++++++++++++--=
--
>  security/integrity/evm/evm_main.c |  5 ++---
>  security/integrity/ima/ima_api.c  | 11 ++++++++---
>  security/integrity/ima/ima_main.c | 17 ++++++++++-------
>  4 files changed, 51 insertions(+), 17 deletions(-)
>=20
> diff --git a/include/linux/integrity.h b/include/linux/integrity.h
> index f5842372359be5341b6870a43b92e695e8fc78af..034f0a1ed48ca8c19c764e302=
bbfc555dad92cde 100644
> --- a/include/linux/integrity.h
> +++ b/include/linux/integrity.h
> @@ -9,6 +9,8 @@
> =20
>  #include <linux/fs.h>
>  #include <linux/iversion.h>
> +#include <linux/kernel.h>
> +#include <linux/time64.h>
> =20
>  enum integrity_status {
>  	INTEGRITY_PASS =3D 0,
> @@ -51,14 +53,39 @@ integrity_inode_attrs_store(struct integrity_inode_at=
tributes *attrs,
> =20
>  /*
>   * On stacked filesystems detect whether the inode or its content has ch=
anged.
> + *
> + * Must be called in process context.
>   */
>  static inline bool
>  integrity_inode_attrs_changed(const struct integrity_inode_attributes *a=
ttrs,
> -			      const struct inode *inode)
> +			      struct file *file, struct inode *inode)
>  {
> -	return (inode->i_sb->s_dev !=3D attrs->dev ||
> -		inode->i_ino !=3D attrs->ino ||
> -		!inode_eq_iversion(inode, attrs->version));
> +	struct kstat stat;
> +
> +	might_sleep();
> +
> +	if (inode->i_sb->s_dev !=3D attrs->dev || inode->i_ino !=3D attrs->ino)
> +		return true;
> +
> +	/*
> +	 * EVM currently relies on backing inode i_version. While IS_I_VERSION
> +	 * is not a good indicator of i_version support, this still retains
> +	 * the logic such that a re-evaluation should still occur for EVM, and
> +	 * only for IMA if vfs_getattr_nosec() fails.
> +	 */
> +	if (!file || vfs_getattr_nosec(&file->f_path, &stat,
> +				       STATX_CHANGE_COOKIE | STATX_CTIME,
> +				       AT_STATX_SYNC_AS_STAT))
> +		return !IS_I_VERSION(inode) ||
> +			!inode_eq_iversion(inode, attrs->version);
> +
> +	if (stat.result_mask & STATX_CHANGE_COOKIE)
> +		return stat.change_cookie !=3D attrs->version;
> +
> +	if (stat.result_mask & STATX_CTIME)
> +		return timespec64_to_ns(&stat.ctime) !=3D (s64)attrs->version;
> +
> +	return true;
>  }
> =20
> =20
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/i=
ma_main.c
> index 5770cf691912aa912fc65280c59f5baac35dd725..8ac42b03740eb93bf23b15cb9=
039af6cd32aa999 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -28,6 +28,7 @@
>  #include <linux/iversion.h>
>  #include <linux/evm.h>
>  #include <linux/crash_dump.h>
> +#include <linux/time64.h>
> =20
>  #include "ima.h"
> =20
> @@ -199,10 +200,13 @@ static void ima_check_last_writer(struct ima_iint_c=
ache *iint,
>  					    &iint->atomic_flags);
>  		if ((iint->flags & IMA_NEW_FILE) ||
>  		    vfs_getattr_nosec(&file->f_path, &stat,
> -				      STATX_CHANGE_COOKIE,
> -				      AT_STATX_SYNC_AS_STAT) ||
> -		    !(stat.result_mask & STATX_CHANGE_COOKIE) ||
> -		    stat.change_cookie !=3D iint->real_inode.version) {
> +			    STATX_CHANGE_COOKIE | STATX_CTIME,
> +			    AT_STATX_SYNC_AS_STAT) ||
> +		    ((stat.result_mask & STATX_CHANGE_COOKIE) ?
> +		      stat.change_cookie !=3D iint->real_inode.version :
> +		      (!(stat.result_mask & STATX_CTIME) ||
> +			timespec64_to_ns(&stat.ctime) !=3D
> +			(s64)iint->real_inode.version))) {
>  			iint->flags &=3D ~(IMA_DONE_MASK | IMA_NEW_FILE);
>  			iint->measured_pcrs =3D 0;
>  			if (update)

The original i_version test was clear.  This code has become really hard to
understand and needs to be cleaned up.  Defining a helper function, will al=
so
avoid code duplication.

Mimi

