Return-Path: <linux-integrity+bounces-7275-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A279B9D4FB
	for <lists+linux-integrity@lfdr.de>; Thu, 25 Sep 2025 05:27:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3333424BD6
	for <lists+linux-integrity@lfdr.de>; Thu, 25 Sep 2025 03:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1F352D73B5;
	Thu, 25 Sep 2025 03:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QWa/iM1E"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0E634BA52;
	Thu, 25 Sep 2025 03:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758770861; cv=none; b=NmTxpAGPjRLD6zmvYvsFD6sGs6SheadaZhcg9I3WUxwnUSMhPcLl9S7ZE9RF6qq60BKGLxamit3ZJ+YhzQXkYkMlf0IN6yzoiKXz4e8NGYoYfcE6rztfgnuFqqSFkSIcGj/PH6ZKpEk3FcJZYwL/KEvAWU+Cce16wzckjlAzCK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758770861; c=relaxed/simple;
	bh=897izMHSnpSWEKwmhIyhDb9lc/ccJPpGssQcwPQT2GY=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=dN6KUxhWH44zgv1U6TpWbeuEwGVgwOr+xvr3NbdBkshY5cq2pRp7PmqURqe2Gwdkj94hcjPoj6gfkrFbW43vJsGiI8e17XouELR3P4L1aRK7rJbOtjqMc5A4AB6HQRNv+q0EpaL5XeDhu7pZ3FRmQg9qsOGYe1PpHNrL5PohUCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QWa/iM1E; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58OHKFPB020231;
	Thu, 25 Sep 2025 03:27:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=/gJIis
	HjCMjK3tMDMtGhrUYoHtL0jRCeFDDBAA8WTyg=; b=QWa/iM1EIhyqe6NcvgJnSe
	ItTulDhG4HV50xY6sPONhn0bT5lv4W/3uunQRkiLxJ1NtHNdyeNhVFGbs8Bs4O1Y
	BO2Thj4Fj/zcrn2tbde/HlAoRmBGsllSQ3VLUSzJ6+v1/dV2hDMw8MfJ3mhCi+EE
	zVht4sFEaVJgLq3B2d8ntzRBPWZttj0bD3RL6h/4m0tKd54RHRA7PLJeJzkyFiyq
	FaDFPybvYWSbjRUpI2SbPJmGT5Bu3ulC/KaKbf9CGz1TR02hvNIITM+B9QEpaxRN
	8utDYzx+0PbCROGz85o3PHB/UMOBGR9YuDqyZ3mRqUZ6hTiESSlbWdasPYBTBkaw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 499n0ju3pw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Sep 2025 03:27:07 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58P3R6SO028269;
	Thu, 25 Sep 2025 03:27:06 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 499n0ju3pu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Sep 2025 03:27:06 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58P1moTc013342;
	Thu, 25 Sep 2025 03:27:05 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49cj34ax1u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Sep 2025 03:27:05 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58P3R4wD27198004
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Sep 2025 03:27:04 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CDF195861E;
	Thu, 25 Sep 2025 03:27:04 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 253A25861D;
	Thu, 25 Sep 2025 03:27:04 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.91.131])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 25 Sep 2025 03:27:04 +0000 (GMT)
Message-ID: <e74e81465e168a7f43583d5783850cc5fe7ca1c5.camel@linux.ibm.com>
Subject: Re: [PATCH] ima: setting security.ima to fix security.evm for a
 file with IMA signature
From: Mimi Zohar <zohar@linux.ibm.com>
To: Coiby Xu <coxu@redhat.com>
Cc: linux-integrity@vger.kernel.org, Roberto Sassu
 <roberto.sassu@huawei.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Eric Snowberg <eric.snowberg@oracle.com>,
        Paul Moore	
 <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn"	
 <serge@hallyn.com>,
        "open list:SECURITY SUBSYSTEM"	
 <linux-security-module@vger.kernel.org>,
        open list	
 <linux-kernel@vger.kernel.org>
In-Reply-To: <4l7l4duxfximhzixruim3lnij5mhnlqs5srzycc6j6c2bu5zda@ogoj3ade37fd>
References: <20250909041954.1626914-1-coxu@redhat.com>
	 <5aeecf1aa6eff8ae0ea0a9e95d5df79aee338b32.camel@linux.ibm.com>
	 <r3himk4z2aiyqsjstlpnda4wafeo7i4oum3n2dbvnasmtep5ex@zqodcpjmyx5b>
	 <40e9c7bd15d4ab8b71ac335b5d896ed39c61980c.camel@linux.ibm.com>
	 <4l7l4duxfximhzixruim3lnij5mhnlqs5srzycc6j6c2bu5zda@ogoj3ade37fd>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Sep 2025 23:27:03 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.54.3 (3.54.3-2.fc41) 
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAzMyBTYWx0ZWRfXy2maijrWT1RE
 1b8V4IXE12tOS0mApWq4tUfBMGsTjetVH1e1HGA7w73H+vLafXt6Mxhs9nhEkRhwyd7cr4DDKSq
 cb2maw4LNLIHxC7zD+0jl8nvwnHkf3gpjfOEi7fLqVb/FQbbqolnuAqUccVmNrRaOR3S5UEJx5q
 4hZhUvVc8Vc5tPgV5LAA4T9VTxoZ7kaQDJyFuwQ81B2fWsbpKGsVW3lfTYVVsCU1ENfYtX6fpqA
 IlR2oquqzgWw/rtEmD+hvhJ0pFzZPS9im4NTNJcc2sF9XT6gRWg10Lu0kC7y/TffQiS7QYkIjx1
 38DIFFGnKO3zYM7jQ9SxeoyCJTKy8I/nzIEplbSLwk6ltPV/RbEjE8ab3HqYCKFn2l/RIyeOfZ2
 MwWLRjI+
X-Authority-Analysis: v=2.4 cv=TOlFS0la c=1 sm=1 tr=0 ts=68d4b68b cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=vUXcQdf43LBxS_wO:21 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10
 a=dJQkUw5hVWgj95crPp0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: Klu5Db8Y922saA8Gedrbifvz0HBb71ro
X-Proofpoint-GUID: 9iy7satFKtTFk83ID0QZQSscgLrldQIE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 phishscore=0 impostorscore=0 adultscore=0
 suspectscore=0 spamscore=0 bulkscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509200033

On Wed, 2025-09-24 at 16:03 +0800, Coiby Xu wrote:
> On Mon, Sep 15, 2025 at 05:05:42PM -0400, Mimi Zohar wrote:
> > On Wed, 2025-09-10 at 09:20 +0800, Coiby Xu wrote:
> > > On Tue, Sep 09, 2025 at 11:31:20AM -0400, Mimi Zohar wrote:
> > > > On Tue, 2025-09-09 at 12:19 +0800, Coiby Xu wrote:
> > > > > When both IMA and EVM fix modes are enabled, accessing a file wit=
h IMA
> > > > > signature won't cause security.evm to be fixed. But this doesn't =
happen
> > > > > to a file with correct IMA hash already set because accessing it =
will
> > > > > cause setting security.ima again which triggers fixing security.e=
vm
> > > > > thanks to security_inode_post_setxattr->evm_update_evmxattr.
> > > > >=20
> > > > > Let's use the same mechanism to fix security.evm for a file with =
IMA
> > > > > signature.
> > > > >=20
> [...]
> > > > > ---
> > > > >  security/integrity/ima/ima_appraise.c | 27 +++++++++++++++++++++=
------
> > > > >  1 file changed, 21 insertions(+), 6 deletions(-)
> > > > >=20
> > > > > diff --git a/security/integrity/ima/ima_appraise.c b/security/int=
egrity/ima/ima_appraise.c
> > > > > index f435eff4667f..18c3907c5e44 100644
> > > > > --- a/security/integrity/ima/ima_appraise.c
> > > > > +++ b/security/integrity/ima/ima_appraise.c
> > > > > @@ -595,12 +595,27 @@ int ima_appraise_measurement(enum ima_hooks=
 func, struct ima_iint_cache *iint,
> > > > >  		integrity_audit_msg(audit_msgno, inode, filename,
> > > > >  				    op, cause, rc, 0);
> > > > >  	} else if (status !=3D INTEGRITY_PASS) {
> > > > > -		/* Fix mode, but don't replace file signatures. */
> > > > > -		if ((ima_appraise & IMA_APPRAISE_FIX) && !try_modsig &&
> > > > > -		    (!xattr_value ||
> > > > > -		     xattr_value->type !=3D EVM_IMA_XATTR_DIGSIG)) {
> > > > > -			if (!ima_fix_xattr(dentry, iint))
> > > > > -				status =3D INTEGRITY_PASS;
> > > > > +		/*
> > > > > +		 * Fix mode, but don't replace file signatures.
> > > > > +		 *
> > > > > +		 * When EVM fix mode is also enabled, security.evm will be
> > > > > +		 * fixed automatically when security.ima is set because of
> > > > > +		 * security_inode_post_setxattr->evm_update_evmxattr.
> > > > > +		 */
> > > > > +		if ((ima_appraise & IMA_APPRAISE_FIX) && !try_modsig) {
> > > > > +			if (!xattr_value ||
> > > > > +			    xattr_value->type !=3D EVM_IMA_XATTR_DIGSIG) {
> > > > > +				if (ima_fix_xattr(dentry, iint))
> > > > > +					status =3D INTEGRITY_PASS;
> > > > > +			} else if (xattr_value->type =3D=3D EVM_IMA_XATTR_DIGSIG &&
> > > > > +				   evm_revalidate_status(XATTR_NAME_IMA)) {
> > > > > +				if (!__vfs_setxattr_noperm(&nop_mnt_idmap,
> > > > > +							   dentry,
> > > > > +							   XATTR_NAME_IMA,
> > > > > +							   xattr_value,
> > > > > +							   xattr_len, 0))
> > > > > +					status =3D INTEGRITY_PASS;
> > > > > +			}
> > > > >  		}
> >=20
> > Instead of re-writing the IMA signature without a clear explanation, de=
fine a
> > new EVM function named evm_fix_hmac() and add a call here in IMA. Only =
in EVM
> > fix mode would evm_fix_hmac() update the EVM hmac.
> >=20
> >        } else if (status !=3D INTEGRITY_PASS) {
> >                /*
> >                 * IMA fix mode updates the IMA file hash, which trigger=
s EVM
> >                 * to update security.evm.  ....
> >                 *
> >                 * Similarly, trigger fixing EVM HMAC for IMA file signa=
tures.
> >                 */
> >                if ((ima_appraise & IMA_APPRAISE_FIX) && !try_modsig) {
> >                        if (!xattr_value ||
> >                            xattr_value->type !=3D EVM_IMA_XATTR_DIGSIG)=
 {
> >                                if (ima_fix_xattr(dentry, iint))
> >                                        status =3D INTEGRITY_PASS;
> >                        } else if (status =3D=3D INTEGRITY_NOLABEL) {
> >                                evm_fix_hmac(dentry, XATTR_NAME_IMA, ...=
.);
> >                        }
> >                }
>=20
> Thanks for the advice! I wonder if we should use existing
> evm_update_evmxattr instead of defining a new EVM function.=20
>=20
>      /*
>       * Calculate the hmac and update security.evm xattr
>       *
>       * Expects to be called with i_mutex locked.
>       */
>      int evm_update_evmxattr(struct dentry *dentry, const char *xattr_nam=
e,
>      			const char *xattr_value, size_t xattr_value_len)
>      {
>      }
>=20
>=20
> I already tried evm_update_evmxattr and can confirm it works.  But later
> I switched to __vfs_setxattr_noperm because I thought it's consistent
> with current logic of adding security.evm when there is already correct
> security.ima and it's a slightly smaller change.

Calling evm_inode_updatexattr() is limited to EVM.  Only after verifying th=
e
existing EVM value is evm_inode_updatexattr() called. For example, in
evm_inode_setxattr() the existing EVM value is verified and then updated in
evm_inode_post_setxattr(), by calling evm_inode_updatexattr().

In this case, the new function evm_fix_hmac() would call evm_update_evmxatt=
r()
only after verifying the EVM mode is set to fix.

