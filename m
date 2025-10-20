Return-Path: <linux-integrity+bounces-7507-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DD0ABF127E
	for <lists+linux-integrity@lfdr.de>; Mon, 20 Oct 2025 14:27:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6119A3AD654
	for <lists+linux-integrity@lfdr.de>; Mon, 20 Oct 2025 12:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C0AE16DEB3;
	Mon, 20 Oct 2025 12:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UYiPj0CK"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E1430F555;
	Mon, 20 Oct 2025 12:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760962936; cv=none; b=sHVVd7yTg4xvPKqCcj+Sj9y0Ix1hZMaDru/yBQzF4AdjgAHdAiUdQA9MCHmwpl8EMcDIN/XMP4JjhyYklkdYzkliyZErlLr9iR+k9pi7TOcyYGwj7oelnyQ7HOSk64WF/N7LqVg5+Sts3uQqvCpD1sPWnC5AOARsjPGWXGAkPWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760962936; c=relaxed/simple;
	bh=of3wZAUHKMfCVZYVBcIRSyBLTUb2ezn0Z1hO3nSqfII=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=IxlUqrFTmvmIT3Pikbm+hImgtjIrkG6oI9v/2oTZKMe9x6Qt2xGymuRHWM+fNnlxQA0G37ykrG3O0RoVDzTuY1zs7aPrfDa3BnAfKbV815+vnTLYFleI0MYY3jdVnWOBCzbvsgIXyUMIXgYrzinr0DIdP/QB5mHO7xIrnfpDISw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UYiPj0CK; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59JMhEtm001343;
	Mon, 20 Oct 2025 12:21:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=cNpXfp
	oUFXhapoL9sTv4eIMTnzU91hptS30+pXpGrF8=; b=UYiPj0CKqgZy73ViJ56a0u
	3jJrk/2vG9i7ESpwny3f8CRJo2DcQEbRfhsK/CNH5AEECg2swVN8EHyj6ZgRSw0z
	zYyrgsaI+0oPRsIjYn3oLbNbV1X9I+arvl55c9OMmDCp7TQlRYQqEGKITnTtvDA0
	0Z5sbU3Dh8nXS9bH9A4WNH4BpYHsaE5Qz5CmvCM8D4aG6s+AH5RdDQVPxZCo1c6Z
	N45NCvyNJ9TmKWUoVSsUxmks/KM6Hj3SVXv+1XNLWxDHQQRoYbQDLVo1XzuodCBN
	ZJFjNuhPfPwbG/5GhsuyBM5zi3/UXpdqiJ86pElu1KI75ONnfRwVjoF7GXN0H/3g
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v32h88pt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Oct 2025 12:21:53 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59KCIaFx030654;
	Mon, 20 Oct 2025 12:21:52 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v32h88pq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Oct 2025 12:21:52 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59KBxp43002306;
	Mon, 20 Oct 2025 12:21:52 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 49vqej5dbr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Oct 2025 12:21:51 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59KCLp2029557300
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Oct 2025 12:21:51 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2E39558059;
	Mon, 20 Oct 2025 12:21:51 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EFAC558063;
	Mon, 20 Oct 2025 12:21:49 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.31.144])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 20 Oct 2025 12:21:49 +0000 (GMT)
Message-ID: <559f6ebf4a19da321fffc2a3ca180dc3d6216a22.camel@linux.ibm.com>
Subject: Re: [PATCH] ima: Fall back to default kernel module signature
 verification
From: Mimi Zohar <zohar@linux.ibm.com>
To: Coiby Xu <coxu@redhat.com>
Cc: linux-integrity@vger.kernel.org,
        Dmitry Torokhov
 <dmitry.torokhov@gmail.com>,
        Karel Srot <ksrot@redhat.com>,
        Roberto Sassu
 <roberto.sassu@huawei.com>,
        Dmitry Kasatkin	 <dmitry.kasatkin@gmail.com>,
        Eric Snowberg <eric.snowberg@oracle.com>,
        Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn"	 <serge@hallyn.com>,
        "open list:SECURITY SUBSYSTEM"	 <linux-security-module@vger.kernel.org>,
        open list	 <linux-kernel@vger.kernel.org>
In-Reply-To: <z6f4getlayaxaxvlxfxn2yvn5dvhrct64wke4uu2s3dfll3bqq@754bklrku55n>
References: <20250928030358.3873311-1-coxu@redhat.com>
	 <896f4fb0c0146512a66daf0b4c1e033aca4bd6d4.camel@linux.ibm.com>
	 <bcd1f7b48311aff55711cdff4a6cdbb72aae1d04.camel@linux.ibm.com>
	 <xq7bgyg63xlbogcik2we26yr5uf62f6kj3qn7ooljmqaoccrix@kkmuhza5cfdr>
	 <9d279fd3d7b3cbb2778183ec777d6b9da8a64b82.camel@linux.ibm.com>
	 <5bzredottmp2tdm3uebzjfqjr6c7bwssqkrbdqvudruvzr764e@37j6ycjci2sk>
	 <27bb0c218084f51eba07f041d0fffea8971865b9.camel@linux.ibm.com>
	 <z6f4getlayaxaxvlxfxn2yvn5dvhrct64wke4uu2s3dfll3bqq@754bklrku55n>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Oct 2025 08:21:49 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.54.3 (3.54.3-2.fc41) 
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfXx2sXdzBFqE/3
 Chand0NEWi5yJUE1JpE90Efp/BTQYh2L0GvsDXlVKVvAPAWQb+tBY5SlZgKUZMY03h+XYauSXu4
 ECGSrrtVP9zWs943kOlEDzrEmYfPPz3vXQVONhvGKfehCJPxeSNfmbqe6wp+GzcSkUuSdITksRS
 0EA9isfnRfH0+6efN/MWQL+8C4gWMWpwPfwA0UDU84cTksGlsZtj5wWREEuazm23c1unrrusamj
 FiCKb1fjOIf46UIVzB5sUWusHKQNPRly7vaEjzHrw2y0AJWLde8RpTjms2P1NkAOufzCdJJGF7O
 9oo4UKLaNHEmEs3eBrdnCs2X/BZkZ2EHCZoYguXWWA3F0ea65tIbLqVkUg9OJOy5aAAuq57ZQFn
 3zf/Kh0Nmv/cKZsCmlbNzW5tuCJi+g==
X-Authority-Analysis: v=2.4 cv=OrVCCi/t c=1 sm=1 tr=0 ts=68f62961 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=gQ7tohhNsIfWToB5Hf4A:9 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: -wQ3BsphU_0TP5q_Rdhw-GwkOHurO_Lm
X-Proofpoint-ORIG-GUID: FbuxV6urzwBcOUH24ky1XvU7_oMffsb7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0
 clxscore=1015 bulkscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022

On Sat, 2025-10-18 at 07:19 +0800, Coiby Xu wrote:
> > > > 2. Instead of defining an additional process_measurement() argument=
 to identify
> > > > compressed kernel modules, to simplify the code it might be possibl=
e to define a
> > > > new "func" named COMPRESSED_MODULE_CHECK.
> > > >=20
> > > > +       [READING_COMPRESSED_MODULE] =3D MODULE_CHECK,  -> COMPRESSE=
D_MODULE_CHECK
> > >=20
> > > I also thought about this approach. But IMA rule maps kernel module
> > > loading to MODULE_CHECK. If we define a new rule and ask users to use
> > > this new rule, ima_policy=3Dsecure_boot still won't work.
> >=20
> > I don't have a problem with extending the "secure-boot" policy to suppo=
rt
> > uncompressed kernel modules appended signatures, based on whether
> > CONFIG_MODULE_SIG is enabled.  The new rule would be in addition to the=
 existing
> > MODULE_CHECK rule.
>=20
> I assume once the new rule get added, we can't remove it for userspace
> backward compatibility, right? And with CPIO xattr supported, it seems
> there is no need to keep this rule. So if this concern is valid, do you
> think we shall switch to another approach i.e. to make IMA support
> verifying decompressed module and then make "secure-boot" to allow
> appended module signature?

Yes, once the rule is added, it wouldn't be removed.  As for "to make IMA
support verifying decompressed module", yes that might be a better solution=
,
than relying on "sig_enforce" being enabled. IMA already supports verifying=
 the
appended signatures.  A new IMA specific or LSM hook would need to be defin=
ed
after module_decompress().

Remember based on policy, IMA supports:
1. verifying the signature stored in security.ima xattr
2. verifying the appended signature (not for compressed kernel modules)
3. verifying both the xattr and appended signatures
4. none

To prevent 3 - verifying both types of signatures, the IMA arch specific po=
licy
rule only adds the "appraise func=3DMODULE_CHECK ..." rule if CONFIG_MODULE=
_SIG is
NOT enabled.  Calling set_module_sig_enforced() from ima_appraise_measureme=
nt()
to set sig_enforce could inadvertently result in requiring both the xattr a=
nd
the appended signature kernel module verification.  To prevent this from
happening, "sig_enforce" should not be set, only verified in
ima_appraise_measurement().

>=20
> Another thought is to make CPIO support xattr. Today I realize that
> ima_policy=3Dsecure_boot can also cause failure of loading kdump kernel.
> So the issue this patch tries to resolves has much less impact than I
> thought. Maybe we can wait until CPIO xattr support is ready? I'll help
> review and test Roberto's patches if this is the best way forward.

I'm not sure of the status of the CPIO patch set.  Roberto?

Mimi



