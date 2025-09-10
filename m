Return-Path: <linux-integrity+bounces-7044-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00C02B5153D
	for <lists+linux-integrity@lfdr.de>; Wed, 10 Sep 2025 13:15:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF9A0167623
	for <lists+linux-integrity@lfdr.de>; Wed, 10 Sep 2025 11:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C82F127055E;
	Wed, 10 Sep 2025 11:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZreNsi36"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E179DB67E;
	Wed, 10 Sep 2025 11:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757502941; cv=none; b=lOysWPh8t7g4A9goDGSpprfKfwn0/XKpo+Hq+yFBsNwFSRVPuWuUwF23aaGdhK3PM3q8lCVUGGm0xDInNFsy5FxCZd2yMmZ+di2MbKtXDxgiWLe2D8bVZ2zQIXPBhWSlmnATgfsRT8MvTJjxSXwrEHzfoboasg97wHQPGrtTqA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757502941; c=relaxed/simple;
	bh=JKF3sokOfz/KJOLEHPFIVxsadWmDVqjPfFG/mnyQ2Ak=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=LiYR/0gUG8bgva20KDm6zHl8alpCt1+rRTjcwsyFFETGXAl7aFRR6IkxoyUj+McEs2THiY6f3DJGgRTXKo/V/6XS6vciOaSIAvWn6i+DRMm/oyvVRvxvzYVdReMdqpkOXgathyFx/sidpVxo1lrJzmbMrQzFac6S5l4Qvq0T8Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZreNsi36; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58A9cQib007706;
	Wed, 10 Sep 2025 11:15:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=H35gS4
	QrbBq711GNVZfhIT+nzbCQvrvrln/RaNPm8Jw=; b=ZreNsi36d4zSIk0BHReat1
	oqE1rc9kaCusnqWOBwocMOlYXKHbEwZw9glHhgzk8BHPexABFAHURAQzkx9GeV34
	lq3/yIqaAZIM/v5ySWCr8rY4t45tJfIqdu5VT87TKYuOhz60oWs7FwKkcbNrNAMC
	FOk7NT44NvYxqYWDSVXVwujPysUckesQoGwQVtGrhQG+zPMjX8kTpGEMS63dm6Is
	PzF6ivfh+SOpBUebHh/78Wpze2tagecmAQlEoCfJ5T8OVhK6FnHfvgiq1mEj4qKv
	x7QbBN2zj8LX+hmbfugyE7SyK+vPGhqDSyGc/LlusdjauoMglrGSGIxFnEZ+nNLg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490xyd2h63-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Sep 2025 11:15:23 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58ABFM9Z022396;
	Wed, 10 Sep 2025 11:15:22 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490xyd2h61-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Sep 2025 11:15:22 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58AB7Goi017218;
	Wed, 10 Sep 2025 11:15:21 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4911gmfx44-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Sep 2025 11:15:21 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58ABFLex10420832
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Sep 2025 11:15:21 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0BFE55805D;
	Wed, 10 Sep 2025 11:15:21 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0592758054;
	Wed, 10 Sep 2025 11:15:20 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.153.78])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 10 Sep 2025 11:15:19 +0000 (GMT)
Message-ID: <cbcbdb3e4aed17f387ae1d357906796551e2f470.camel@linux.ibm.com>
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
In-Reply-To: <r3himk4z2aiyqsjstlpnda4wafeo7i4oum3n2dbvnasmtep5ex@zqodcpjmyx5b>
References: <20250909041954.1626914-1-coxu@redhat.com>
	 <5aeecf1aa6eff8ae0ea0a9e95d5df79aee338b32.camel@linux.ibm.com>
	 <r3himk4z2aiyqsjstlpnda4wafeo7i4oum3n2dbvnasmtep5ex@zqodcpjmyx5b>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 10 Sep 2025 07:15:19 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: T6fqf-X3Lo5EH4zQyPJVUxUOnJdGeh1d
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDIzNSBTYWx0ZWRfX9xsq9HSd22dU
 8dCgzMxrT75YsgiVcwJ5i1+ZPwkIKyT951kmafSYwVXA+nW0LVTsRYgfqkWmy3FGRm04A5q2PEC
 BxJ9Qf/Dcf7ydZ48tTpY9aReZmz1OdtYUJkCRf2+/udRTXhmmaYLm5r0oozwlRfPlwCb3ysQwp8
 XmIXppBD4+dkLu1OShYwkMeHRFt6Izpu0pyZGKpYucZDiOpgw0DsS1XuASX7gG6uURhySdqCwaP
 M5Mr+sZsqFUKoFGefNg3pM2Ypyw/YWtHSKhdGiC7Wlx4HGuM16Y1Cv+323Pr4sF3Sk1v/USvpt5
 UZZhFF/QbW+RL0XOuQsQnhBJ0XzPHkbBMNzphT6BckbAVZc1m+DM8X4TstBn7eU69tjXbhd46Zn
 Vs6d5LMz
X-Proofpoint-GUID: N0YggciuCLL5XZbibiRPnPQZmFy3DOqR
X-Authority-Analysis: v=2.4 cv=F59XdrhN c=1 sm=1 tr=0 ts=68c15dcb cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=vUXcQdf43LBxS_wO:21 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=20KFwNOVAAAA:8
 a=n6TOAAXvfV5sXn8gDmAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-09_03,2025-09-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 clxscore=1015
 impostorscore=0 bulkscore=0 adultscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509060235

On Wed, 2025-09-10 at 09:20 +0800, Coiby Xu wrote:
> On Tue, Sep 09, 2025 at 11:31:20AM -0400, Mimi Zohar wrote:
> > On Tue, 2025-09-09 at 12:19 +0800, Coiby Xu wrote:
> > > When both IMA and EVM fix modes are enabled, accessing a file with IM=
A
> > > signature won't cause security.evm to be fixed. But this doesn't happ=
en
> > > to a file with correct IMA hash already set because accessing it will
> > > cause setting security.ima again which triggers fixing security.evm
> > > thanks to security_inode_post_setxattr->evm_update_evmxattr.
> > >=20
> > > Let's use the same mechanism to fix security.evm for a file with IMA
> > > signature.
> > >=20
> > > Signed-off-by: Coiby Xu <coxu@redhat.com>
> >=20
> > Agreed, re-writing the file signature stored as security.ima would forc=
e
> > security.evm to be updated.
> >=20
> > Unfortunately, I'm missing something. ima_appraise_measurement() first =
verifies
> > the existing security.evm xattr, before verifying the security.ima xatt=
r.  If
> > the EVM HMAC fails to verify, it immediately exits ima_appraise_measure=
ment().
> > security.ima in this case is never verified.
> >=20
> > This patch seems to address the case where the existing security.evm is=
 valid,
> > but the file signature stored in security.ima is invalid.  (To get to t=
he new
> > code, the "status" flag is not INTEGRITY_PASS.)  Re-writing the same in=
valid
> > file signature would solve an invalid security.evm, but not an invalid =
IMA file
> > signature.  What am I missing?
>=20
> Hi, Mimi,
>=20
> Thanks for raising the question! This patch is to address the case where
> IMA signature is already added but security.evm doesn't yet exist. So
> EVM HMAC fails to verify but there is no exiting
> ima_appraise_measurement immediately.
>=20
> And you are right that re-writing an invalid IMA file won't fix an
> invalid IMA file signature. And even when IMA signature is valid, the
> verification may fail because the key is missing from .ima keyring. This
> happens because we need to turn off secure boot to enable fix mode. As a
> result, CA keys won't be loaded into .machine keyring.

> Btw, if I'm not
> mistaken, current IMA code assumes we are not supposed to fix IMA file
> signature.

Right, unlike file hashes, new or the same file signature can be written, b=
ut
cannot be "fixed" in the literal sense, as that would require calculating t=
he
file hash and signing it with a private key.

This patch triggers "fixing" the EVM HMAC by re-writing the existing IMA fi=
le
signature.  I assume the same result could be achieved by simply re-install=
ing
the file signature.  In both cases, the EVM HMAC key needs to exist and be
loaded.

>=20
> >=20
> > > ---
> > >  security/integrity/ima/ima_appraise.c | 27 +++++++++++++++++++++----=
--
> > >  1 file changed, 21 insertions(+), 6 deletions(-)
> > >=20
> > > diff --git a/security/integrity/ima/ima_appraise.c b/security/integri=
ty/ima/ima_appraise.c
> > > index f435eff4667f..18c3907c5e44 100644
> > > --- a/security/integrity/ima/ima_appraise.c
> > > +++ b/security/integrity/ima/ima_appraise.c
> > > @@ -595,12 +595,27 @@ int ima_appraise_measurement(enum ima_hooks fun=
c, struct ima_iint_cache *iint,
> > >  		integrity_audit_msg(audit_msgno, inode, filename,
> > >  				    op, cause, rc, 0);
> > >  	} else if (status !=3D INTEGRITY_PASS) {
> > > -		/* Fix mode, but don't replace file signatures. */
> > > -		if ((ima_appraise & IMA_APPRAISE_FIX) && !try_modsig &&
> > > -		    (!xattr_value ||
> > > -		     xattr_value->type !=3D EVM_IMA_XATTR_DIGSIG)) {
> > > -			if (!ima_fix_xattr(dentry, iint))
> > > -				status =3D INTEGRITY_PASS;
> > > +		/*
> > > +		 * Fix mode, but don't replace file signatures.
> > > +		 *
> > > +		 * When EVM fix mode is also enabled, security.evm will be
> > > +		 * fixed automatically when security.ima is set because of
> > > +		 * security_inode_post_setxattr->evm_update_evmxattr.
> > > +		 */
> > > +		if ((ima_appraise & IMA_APPRAISE_FIX) && !try_modsig) {
> > > +			if (!xattr_value ||
> > > +			    xattr_value->type !=3D EVM_IMA_XATTR_DIGSIG) {
> > > +				if (ima_fix_xattr(dentry, iint))
> > > +					status =3D INTEGRITY_PASS;
> > > +			} else if (xattr_value->type =3D=3D EVM_IMA_XATTR_DIGSIG &&
> > > +				   evm_revalidate_status(XATTR_NAME_IMA)) {
> > > +				if (!__vfs_setxattr_noperm(&nop_mnt_idmap,
> > > +							   dentry,
> > > +							   XATTR_NAME_IMA,
> > > +							   xattr_value,
> > > +							   xattr_len, 0))
> > > +					status =3D INTEGRITY_PASS;
> > > +			}
> > >  		}
> > >=20
> > >  		/*
> > >=20
> > > base-commit: b320789d6883cc00ac78ce83bccbfe7ed58afcf0
> >=20
>=20


