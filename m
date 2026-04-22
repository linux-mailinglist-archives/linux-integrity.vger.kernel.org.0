Return-Path: <linux-integrity+bounces-9282-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gPmINFI86WmEWQIAu9opvQ
	(envelope-from <linux-integrity+bounces-9282-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Wed, 22 Apr 2026 23:23:30 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B2F244AE12
	for <lists+linux-integrity@lfdr.de>; Wed, 22 Apr 2026 23:23:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AD6A331173E2
	for <lists+linux-integrity@lfdr.de>; Wed, 22 Apr 2026 21:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8677736C5AC;
	Wed, 22 Apr 2026 21:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RaZO2EVi"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0938236CDF2;
	Wed, 22 Apr 2026 21:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776892856; cv=none; b=TEfURtU3/rSatVpHqEyNpEbOwHDwkWkwt6SBJIHJwdKB2OEj6/BnQu3/LQ+XHE/JQ0BrEyVBR5wCemgi/mgpPtuWdBw3jAvKvod66bkaLZKphDp5t4x69zUfOInOoDlE/dDjxJeu/44cozCU7ntruH/7b7/So52RpYgTeZ8ZhTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776892856; c=relaxed/simple;
	bh=6jWGgfcPWny91soeKsdb/OZB0eFBFuPWpK+FhUWREKk=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=Y4wUTJvVNugYVqlhWKa283wCCYgIkkgv/AKmmTjDBVSlX2igilpA72FB6P36s2i9kxX351mtZUfo+ud2PtjOpfF0ZRgip3uiVPCNDryYhlvvrZzbb8+T4rdrV/xyFLJ23nN2mYCSH4/Nx74Fql05hFOm3qu5RUXt6SpgKEYQVWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RaZO2EVi; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63MGMGsL3514986;
	Wed, 22 Apr 2026 21:20:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=N9Q6zX
	la1NdmTIBlj9DdrsDLNUyJ3CVakT7/aa1rnmQ=; b=RaZO2EViu2zjJQmCy9erjy
	GgH2sRGGgap1fJtbQXrsrzY0pYTcHdYLx+Tdy314NBgncNjTYpJbh4a2yngNGlTV
	va95no4LmXtqilO6QjGJGvfMy2BSJMDd9LTa+gMf8cMf6bH6S1yrvBPf7WhfPLzr
	SAP7nIQHqyZAujkxtXMCRAIXmN14Img4r0W3gVNQrfBxxIMfALc2HLDoA/bbafOd
	8ELly+j9oL+No0FwnR+CjapVOz9NHBs6KygF5nUCR6RJt6zui5oUckBou64gWJlI
	PgWD33vI4L0QGjMkF73hZNrryEN8u4mhT5Dd3dCULzUBvhm0wmZtsMm3bjWNw1Sw
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dpeu25quw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Apr 2026 21:20:25 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63MLKP46003300;
	Wed, 22 Apr 2026 21:20:25 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dpjkxv1pj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Apr 2026 21:20:25 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63MLKOma30212616
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Apr 2026 21:20:24 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 214005805A;
	Wed, 22 Apr 2026 21:20:24 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0340D58054;
	Wed, 22 Apr 2026 21:20:22 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.108.56])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 22 Apr 2026 21:20:21 +0000 (GMT)
Message-ID: <82803bb3b471898a77084c449b73c7f7b4eb2149.camel@linux.ibm.com>
Subject: Re: [RFC PATCH v2 1/4] security: ima: call ima_init() again at
 late_initcall_sync for defered TPM
From: Mimi Zohar <zohar@linux.ibm.com>
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.linux.dev, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, roberto.sassu@huawei.com, dmitry.kasatkin@gmail.com,
        eric.snowberg@oracle.com, jarkko@kernel.org, jgg@ziepe.ca,
        sudeep.holla@kernel.org, maz@kernel.org, oupton@kernel.org,
        joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com,
        catalin.marinas@arm.com, will@kernel.org, noodles@meta.com,
        sebastianene@google.com
In-Reply-To: <aekkVQwueKbFtG7C@e129823.arm.com>
References: <20260422162449.1814615-1-yeoreum.yun@arm.com>
	 <20260422162449.1814615-2-yeoreum.yun@arm.com>
	 <6919248bdc85dac60277fa9d9c83d8bd258ca635.camel@linux.ibm.com>
	 <aekXaU52fzvNYaUF@e129823.arm.com> <aekkVQwueKbFtG7C@e129823.arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Apr 2026 17:20:21 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDIwNyBTYWx0ZWRfX0jfEbj7MTwwa
 ox2HJyMSt3nYqIQUULKK/mTgh7iAajU/inJqPwHaMWC2xC4mCaO3Z/hWABJNVt/X9JjkpbvoUSL
 6PppQTWIFSBA4iBKJYapHSICKPKb/7STsgch7HMKGYz+EzthvK1D5AqoggdZJo2NPO3YwswijFO
 p+ukhUTG4RFf54d4F8EBnoVxhHAEJmQu7VkjlpyrbdRs3VRYtszFa+3wM8vPNXNfr7jL0TyixGx
 tU/d71BUqVZQlrmhtn9O6SvBkD50fiiEIveaq8FFezuzYLdfRaFt7Ws5W0aNj/SiC+g1jUkMUyE
 ebEoVeUkEcFA4Wg+SEtWhZstyYB7OIgb93J9MT8CclY+hb8MjeViL9a9hjzrRzzHkF0wi52J00f
 a+uNWkeyBysRnoLsWYBujmAUNjupz6vNwDGRF5vb1jWxr3M5uS4zBmo80Mj+AQwB1kjW1ta78R8
 uERZsW8RMt+RiS5EgIg==
X-Proofpoint-ORIG-GUID: -CizEOXcVN8y4Gm9Utqg7W1DWsJLA8SP
X-Proofpoint-GUID: c2CvbLkTaVGt95WdoE9L2uC52JF8GKAP
X-Authority-Analysis: v=2.4 cv=XMUAjwhE c=1 sm=1 tr=0 ts=69e93b9a cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=7CQSdrXTAAAA:8
 a=DNaOwHcBnvVBCHw5JSAA:9 a=QEXdDO2ut3YA:10 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-22_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 priorityscore=1501 impostorscore=0 bulkscore=0
 spamscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604220207
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,lists.linux.dev,paul-moore.com,namei.org,hallyn.com,huawei.com,gmail.com,oracle.com,kernel.org,ziepe.ca,arm.com,meta.com,google.com];
	TAGGED_FROM(0.00)[bounces-9282-lists,linux-integrity=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zohar@linux.ibm.com,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[ibm.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-integrity];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 3B2F244AE12
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 2026-04-22 at 20:41 +0100, Yeoreum Yun wrote:
> > Hi Mimi,
> >=20
> > > On Wed, 2026-04-22 at 17:24 +0100, Yeoreum Yun wrote:
> > > > To generate the boot_aggregate log in the IMA subsystem with TPM PC=
R values,
> > > > the TPM driver must be built as built-in and
> > > > must be probed before the IMA subsystem is initialized.
> > > >=20
> > > > However, when the TPM device operates over the FF-A protocol using
> > > > the CRB interface, probing fails and returns -EPROBE_DEFER if
> > > > the tpm_crb_ffa device =E2=80=94 an FF-A device that provides the c=
ommunication
> > > > interface to the tpm_crb driver =E2=80=94 has not yet been probed.
> > > >=20
> > > > To ensure the TPM device operating over the FF-A protocol with
> > > > the CRB interface is probed before IMA initialization,
> > > > the following conditions must be met:
> > > >=20
> > > >    1. The corresponding ffa_device must be registered,
> > > >       which is done via ffa_init().
> > > >=20
> > > >    2. The tpm_crb_driver must successfully probe this device via
> > > >       tpm_crb_ffa_init().
> > > >=20
> > > >    3. The tpm_crb driver using CRB over FF-A can then
> > > >       be probed successfully. (See crb_acpi_add() and
> > > >       tpm_crb_ffa_init() for reference.)
> > > >=20
> > > > Unfortunately, ffa_init(), tpm_crb_ffa_init(), and crb_acpi_driver_=
init() are
> > > > all registered with device_initcall, which means crb_acpi_driver_in=
it() may
> > > > be invoked before ffa_init() and tpm_crb_ffa_init() are completed.
> > > >=20
> > > > When this occurs, probing the TPM device is deferred.
> > > > However, the deferred probe can happen after the IMA subsystem
> > > > has already been initialized, since IMA initialization is performed
> > > > during late_initcall, and deferred_probe_initcall() is performed
> > > > at the same level.
> > > >=20
> > > > To resolve this, call ima_init() again at late_inicall_sync level
> > > > so that let IMA not miss TPM PCR value when generating boot_aggrega=
te
> > > > log though TPM device presents in the system.
> > > >=20
> > > > Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
> > >=20
> > > A lot of change for just detecting whether ima_init() is being called=
 on
> > > late_initcall or late_initcall_sync(), without any explanation for al=
l the other
> > > changes (e.g. ima_init_core).
> > >=20
> > > Please just limit the change to just calling ima_init() twice.
> >=20
> > My concern is that ima_update_policy_flags() will be called
> > when ima_init() is deferred -- not initialised anything.
> > though functionally, it might be okay however,
> > I think ima_update_policy_flags() and notifier should work after ima_in=
it()
> > works logically.
> >=20
> > This change I think not much quite a lot. just wrapper ima_init() with
> > ima_init_core() with some error handling.
> >=20
> > Am I missing something?
>=20
> Also, if we handle in ima_init() only, but it failed with other reason,
> we shouldn't call again ima_init() in the late_initcall_sync.
>=20
> To handle this, It wouldn't do in the ima_init() but we need to handle
> it by caller of ima_init().

Only tpm_default_chip() is being called to set the ima_tpm_chip.  On failur=
e,
instead of going into TPM-bypass mode, return immediately.  There are no ca=
lls
to anything else.  Just call ima_init() a second time.

Mimi



