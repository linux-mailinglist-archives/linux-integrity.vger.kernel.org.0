Return-Path: <linux-integrity+bounces-7093-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D42D5B5865A
	for <lists+linux-integrity@lfdr.de>; Mon, 15 Sep 2025 23:06:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34A401B240A7
	for <lists+linux-integrity@lfdr.de>; Mon, 15 Sep 2025 21:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7863328FA91;
	Mon, 15 Sep 2025 21:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="eUgBvziW"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04502E63C;
	Mon, 15 Sep 2025 21:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757970370; cv=none; b=V2vvrkCdhEzscfUcLb1J/5dvOYJ9LefzkzhX1Y9JVc9McZQJBShC77ZQJFPjJKP24tfPPk6q71juRvp6MV4IT4XYd6fkbOCZ3RANCg7ThC1UKpuSiyRY2jlUbWldqdnmWGwqDyYo4j7FTEjfCuVlFiswe00EfaoQnEPmsic5AOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757970370; c=relaxed/simple;
	bh=1rwaw35739SX89Wkk08mu+pzhLkhi0bNecALjoH1t/Q=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=dVmDyPE/EDbOqqyB8QUl8zT5RzEh2/pba0PQBazYrDv9QFVnXy57XjXnTE9JWZnzv3epzBPT8FsFaAKn/FXMmwMiLYAIn1px7OQhw4GhAX6/BCfCUmDiKe0jaIREtqC3vdS3kZBSwVFpe5yP0i1dApfER4D8jIsUNkudh0HlwEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=eUgBvziW; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58FJrAH6031871;
	Mon, 15 Sep 2025 21:05:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=HJvrD4
	VvubL/x9qUwmwj1HrK7vnilKoknCRBtlJQsE4=; b=eUgBvziW2Tn+19QwxUMGxI
	UEIDUhdAac2NjvOZSZg7bs+hI6oA4wx3X8+t5eMgcpdjbxGv1Uw4mYprqqM59lcn
	9pmwApt2mQZv+HpqbpCqKDObzE2HRlq3upyPXMmRFTUPm8b7ex53Qz8Z32k8NnEg
	YG82vM9TdYYoV9q+LIR9+ksRzkPtyxsKLivxUyY6f+sY8UVdz7T9HHiGAWAiW/+W
	xuDT/0iFxFYt+CI4qFfO8Xz04prbDttD3vHwi1xZ7sKwMb0aI+R5H0R4KzrQnKEH
	6HrXbScBhothwvoAfReVuMc/1W66abBv0SiIqu5rUWY8GL61Hf9qir4z4YPq85rg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 494x1tcr16-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Sep 2025 21:05:46 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58FL0ITt006584;
	Mon, 15 Sep 2025 21:05:45 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 494x1tcr13-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Sep 2025 21:05:45 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58FHnk9t005963;
	Mon, 15 Sep 2025 21:05:44 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 495jxu0mak-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Sep 2025 21:05:44 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58FL5iqO24052470
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Sep 2025 21:05:44 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0860158050;
	Mon, 15 Sep 2025 21:05:44 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ED0BD58054;
	Mon, 15 Sep 2025 21:05:42 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.24.60])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 15 Sep 2025 21:05:42 +0000 (GMT)
Message-ID: <40e9c7bd15d4ab8b71ac335b5d896ed39c61980c.camel@linux.ibm.com>
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
Date: Mon, 15 Sep 2025 17:05:42 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=OMsn3TaB c=1 sm=1 tr=0 ts=68c87faa cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=vUXcQdf43LBxS_wO:21 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=20KFwNOVAAAA:8
 a=HqxqN70uwPQbf9qsMsIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: Hb9tl43CgSe-KSuTfmjKazUmO_-C-evf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAwMSBTYWx0ZWRfX87li03ofpJF+
 HCHKhmuOAcBkaJZal5+daZ3wcs+uo6H0cV9S2VK+0NlxwIvqcPorXmzx0QBiY6dTx2G7jNTUh7+
 H+ZtILSU2LJ1D+1jx4VEBCXlGzYGLcfzOuGq6lJ3rjMH/DtXa7JlgE5DLULP7oFSi5Og0BWnWgI
 9zAiDehp5phnU+Xmp1oioRh2PtwJj2Kx9r0MCXpvczDLPERvV3lm5KTAqrOiEk0z+t08HojiyUp
 RPCnsSdm0KEdwyoLoUH1g3OTdKdLSnme8Gf+EK0vRC5MWguSUPD6d56ecPEVvNRcMYnNvxeJtXe
 NCw4ZLUlLHpT9AnEuHzFvtQSxm9f4IBXevCsFTTb0ye1FleFclwDtH6ymMYEgFEjbiJdkmvwcZN
 GpdJ65/T
X-Proofpoint-GUID: QSK9bfB-hjkujywSMo7Iqysud_JEJ5Vk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-15_08,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 spamscore=0 priorityscore=1501 adultscore=0
 impostorscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509130001

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
> result, CA keys won't be loaded into .machine keyring. Btw, if I'm not
> mistaken, current IMA code assumes we are not supposed to fix IMA file
> signature.
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

Instead of re-writing the IMA signature without a clear explanation, define=
 a
new EVM function named evm_fix_hmac() and add a call here in IMA. Only in E=
VM
fix mode would evm_fix_hmac() update the EVM hmac.

        } else if (status !=3D INTEGRITY_PASS) {                           =
      =20
                /*                                                         =
    =20
                 * IMA fix mode updates the IMA file hash, which triggers E=
VM  =20
                 * to update security.evm.  ....                           =
   =20
                 *                                                         =
    =20
                 * Similarly, trigger fixing EVM HMAC for IMA file signatur=
es.=20
                 */                                                        =
    =20
                if ((ima_appraise & IMA_APPRAISE_FIX) && !try_modsig) {    =
    =20
                        if (!xattr_value ||                                =
    =20
                            xattr_value->type !=3D EVM_IMA_XATTR_DIGSIG) { =
      =20
                                if (ima_fix_xattr(dentry, iint))           =
    =20
                                        status =3D INTEGRITY_PASS;         =
      =20
                        } else if (status =3D=3D INTEGRITY_NOLABEL) {      =
        =20
                                evm_fix_hmac(dentry, XATTR_NAME_IMA, ....);=
   =20
                        }                                                  =
    =20
                }               =20

> > >=20
> > >  		/*
> > >=20
> > > base-commit: b320789d6883cc00ac78ce83bccbfe7ed58afcf0
> >=20
>=20


