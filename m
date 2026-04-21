Return-Path: <linux-integrity+bounces-9267-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qOEMMnx752nC9QEAu9opvQ
	(envelope-from <linux-integrity+bounces-9267-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 21 Apr 2026 15:28:28 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C34743B562
	for <lists+linux-integrity@lfdr.de>; Tue, 21 Apr 2026 15:28:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 85C9C300F5CF
	for <lists+linux-integrity@lfdr.de>; Tue, 21 Apr 2026 13:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CA642417D9;
	Tue, 21 Apr 2026 13:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BQXRJNvH"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E177D40855;
	Tue, 21 Apr 2026 13:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776778003; cv=none; b=fbJDskEW1Gtu/Ded4Qg7aEM+38xGJQukJ6V79riSinfyfd8UGjUK212FbBsn2sHO4Nyev3YRspubXpYKoLt9SyJCpIsISennhnwFLvNg9S58sJWFu34/hZPLRcMoTzjjftbVD4c8f5ui6mkzcaK6XuNz3Bg3ziMrMfNMK/4PlCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776778003; c=relaxed/simple;
	bh=y7Hvx/C8b9Y5hwiNytujlo6Mo8hea2frt4s5LfeYKn4=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=KDPQG2vqgx1QxeZfYjfgBs5ys67Ly97uy6p/p6DjmocWfabHj8/x5b+B24EyrOfjg3e8V9TZuP+CRF/ZkJakasHQ9Tmp4sl01pK3L/rBbC42t0RP+ZxD8x4O8xIpDd4FZPoYYLsIrROAHm3rqfioeqwcLHu3G037PFrQdUf5zGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BQXRJNvH; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63LCMIAH1684959;
	Tue, 21 Apr 2026 13:26:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=a5JpIi
	HSpvSchdG9kvlWhfLYfuojE6inHmkxSqX6J0I=; b=BQXRJNvHf/CcVxH0ihyoHx
	juD2W7hykiPR+GS/B8ZvpLzt3VZMZRNmFYtF8Swj7Ykk9YlPnqmN1kBSEZr5CNe8
	m6nNSYwOp19Tix5+XOoDRDNFdYaNrw8M6PUaTld8Gpo7VNj/i64ou0Shd6lKImPS
	IOJhl3+hihAwSG/JXdHFG9N+SGnpR+mjrT3wLjT/NOGMbQkgbBSklqpozemWCJ0c
	6/EFHXqKazn+qCyGuoZoeWNHwq3tpdVzYFzrg4BIfje/y+AU7Pbz8BqPobyOAylC
	/isMnsCRN1tjlODQfjfug3mR46trMn1vw/VDW/DwTqnq5P9wNxV+QLfgksdrShLQ
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dm2j6megk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Apr 2026 13:26:09 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63LDO1nq020423;
	Tue, 21 Apr 2026 13:26:08 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dmpgg8p7w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Apr 2026 13:26:08 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63LDPfVk21234186
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Apr 2026 13:25:41 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 98FE658068;
	Tue, 21 Apr 2026 13:26:07 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4C99058052;
	Tue, 21 Apr 2026 13:26:06 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.18.93])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 21 Apr 2026 13:26:06 +0000 (GMT)
Message-ID: <d6bcc9ef98a1e86887c5a79ff2822e70b5534343.camel@linux.ibm.com>
Subject: Re: [RFC PATCH 1/4] security: ima: move ima_init into
 late_initcall_sync
From: Mimi Zohar <zohar@linux.ibm.com>
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.linux.dev, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, roberto.sassu@huawei.com, dmitry.kasatkin@gmail.com,
        eric.snowberg@oracle.com, peterhuewe@gmx.de, jarkko@kernel.org,
        jgg@ziepe.ca, sudeep.holla@kernel.org, maz@kernel.org,
        oupton@kernel.org, joey.gouly@arm.com, suzuki.poulose@arm.com,
        yuzenghui@huawei.com, catalin.marinas@arm.com, will@kernel.org
In-Reply-To: <aedyh61iTnQRyzMv@e129823.arm.com>
References: <20260417175759.3191279-1-yeoreum.yun@arm.com>
	 <20260417175759.3191279-2-yeoreum.yun@arm.com>
	 <a6a0e15286c983d720de227c6827adbe976c5b9b.camel@linux.ibm.com>
	 <aedyh61iTnQRyzMv@e129823.arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Apr 2026 09:26:05 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIxMDEzMyBTYWx0ZWRfX0suQ6SmBGOIZ
 AIaYeN9SO7i8CIwIIuw6eSjU+duSC6YJ/Al6XUC10/3bZJM++txtcl3IIfW7zTcGCl+miEzL1eM
 wA8v7CNmDonrKS8aL2U9MsM236IB/aPhhtEgl9SIY2SKXX2NnjBjHhSy926VPcWHu0W/RK/4qdN
 Tc1flhlYKKigx+YaCjWmRYXS3sIEoyB0a6geu+qZFuJYowKu3Pj9+l54P24xeGc/sLkcux0/Vn9
 JljqWPtBu8LboN7G6enbKeUSblq1odKQhwTSwvjl/nVLwfo2XlbKXKVUcvusHpC6/MS910xSy57
 kQfCEyYVpv1YJpvUfkVUXpJE4l1piP7iLCqR+ioGvlQwRvsitn2zyEnOoE1dIJK25ovf9+8YGux
 byrDlTdQKV7zjx3jgmv9DgL9pN0L7hLuF7QhWFHFKWo7/n7QoAjPvk/puNUA1vngCRVxm9taKQ5
 fj/2w62QrZrJR0DxaEg==
X-Proofpoint-GUID: gEDjObHyjwV79gSjIS0e3G9OFGZ7xoQI
X-Authority-Analysis: v=2.4 cv=SOJykuvH c=1 sm=1 tr=0 ts=69e77af2 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=7CQSdrXTAAAA:8
 a=DwIRA4aEKqX1ECuSU3YA:9 a=QEXdDO2ut3YA:10 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-ORIG-GUID: atQDO3iv7P8iJENV48zi2sfflM5pN5dU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_02,2026-04-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 phishscore=0 suspectscore=0 adultscore=0 impostorscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604210133
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[23];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9267-lists,linux-integrity=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,lists.linux.dev,paul-moore.com,namei.org,hallyn.com,huawei.com,gmail.com,oracle.com,gmx.de,kernel.org,ziepe.ca,arm.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.ibm.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zohar@linux.ibm.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-integrity];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 2C34743B562
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 2026-04-21 at 13:50 +0100, Yeoreum Yun wrote:
> Hi Mimi,
>=20
> > On Fri, 2026-04-17 at 18:57 +0100, Yeoreum Yun wrote:
> > > To generate the boot_aggregate log in the IMA subsystem with TPM PCR =
values,
> > > the TPM driver must be built as built-in and
> > > must be probed before the IMA subsystem is initialized.
> > >=20
> > > However, when the TPM device operates over the FF-A protocol using
> > > the CRB interface, probing fails and returns -EPROBE_DEFER if
> > > the tpm_crb_ffa device =E2=80=94 an FF-A device that provides the com=
munication
> > > interface to the tpm_crb driver =E2=80=94 has not yet been probed.
> > >=20
> > > To ensure the TPM device operating over the FF-A protocol with
> > > the CRB interface is probed before IMA initialization,
> > > the following conditions must be met:
> > >=20
> > >    1. The corresponding ffa_device must be registered,
> > >       which is done via ffa_init().
> > >=20
> > >    2. The tpm_crb_driver must successfully probe this device via
> > >       tpm_crb_ffa_init().
> > >=20
> > >    3. The tpm_crb driver using CRB over FF-A can then
> > >       be probed successfully. (See crb_acpi_add() and
> > >       tpm_crb_ffa_init() for reference.)
> > >=20
> > > Unfortunately, ffa_init(), tpm_crb_ffa_init(), and crb_acpi_driver_in=
it() are
> > > all registered with device_initcall, which means crb_acpi_driver_init=
() may
> > > be invoked before ffa_init() and tpm_crb_ffa_init() are completed.
> > >=20
> > > When this occurs, probing the TPM device is deferred.
> > > However, the deferred probe can happen after the IMA subsystem
> > > has already been initialized, since IMA initialization is performed
> > > during late_initcall, and deferred_probe_initcall() is performed
> > > at the same level.
> > >=20
> > > To resolve this, move ima_init() into late_inicall_sync level
> > > so that let IMA not miss TPM PCR value when generating boot_aggregate
> > > log though TPM device presents in the system.
> > >=20
> > > Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
> >=20
> > IMA should be initialized as early as possible. I'm really hesitant to =
defer
> > ima_init() to late_initcall_sync() for systems that the TPM is currentl=
y
> > initialized in time. For these systems, continue initializing IMA at
> > late_initcall(). As a compromise for those systems that the TPM isn't p=
roperly
> > initialized in time, define and instantiate the late_initcall_sync().
> >=20
> > ima_init() would need to differentiate between the late_initcall and
> > late_initcall_sync.  On late_initcall(), instead of saying "No TPM chip=
 found,
> > activating TPM-bypass!",  it should say "No TPM chip found, deferring t=
o
> > late_initcall_sync" or something similar.
>=20
> But can we really move those initialisations to be called again?
>=20
> I am referring to functions such as ima_init_crypto(),
> ima_add_boot_aggregate(), and ima_measure_critical_data() in ima_init()=
=E2=80=94
> first without TPM, and then a second time once TPM becomes available.
> I don=E2=80=99t think that approach would work.
>=20
> In other words, unless tpm_default_chip() can differentiate between a TPM
> device that is deferred and one that does not exist, we cannot distinguis=
h
> between the =E2=80=9Cdefer=E2=80=9D case and =E2=80=9C-EEXIST=E2=80=9D.
>=20
> It might be possible if the TPM core tracked the state when a driver retu=
rns
> -EPROBE_DEFER, but I am not sure that is the right approach.
> For deferred probe cases, the =E2=80=9Cdevice initialised in time=E2=80=
=9D check should
> likely be done at late_initcall_sync, rather than late_initcall.
>=20
> This implies that any such check performed before late_initcall_sync
> does not reflect a valid state, as it cannot distinguish between =E2=80=
=9Cnot
> present=E2=80=9D and =E2=80=9Cdeferred=E2=80=9D.
>=20
> Therefore, I think the TPM check in IMA should be performed at
> late_initcall_sync.
>=20
>=20
> Am I missing something?

In ima_init() you short circuit out, when called by late_initcall(), if the=
 TPM
hasn't been initialized.  So the rest of the ima_init() isn't called.  Roug=
hly
something like this (needs some cleanup):

int __init ima_init(void)
{
        static int first =3D 1;
        int rc;

        if (ima_tpm_chip)
                return 0;

        ima_tpm_chip =3D tpm_default_chip();
        if (!ima_tpm_chip && first) {
                pr_info("No TPM chip found, deferring te late_initcall_sync=
()\n");
                first =3D 0;
                return 0;
        }

The rest of the code remains the same.

Mimi

