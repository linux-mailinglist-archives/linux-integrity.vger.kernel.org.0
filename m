Return-Path: <linux-integrity+bounces-9310-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OBOPAn1f6mmrygIAu9opvQ
	(envelope-from <linux-integrity+bounces-9310-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Thu, 23 Apr 2026 20:05:49 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A26B455E4A
	for <lists+linux-integrity@lfdr.de>; Thu, 23 Apr 2026 20:05:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BD84230177A1
	for <lists+linux-integrity@lfdr.de>; Thu, 23 Apr 2026 18:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37AD030BF4F;
	Thu, 23 Apr 2026 18:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UFtu6quv"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529EA36E46C;
	Thu, 23 Apr 2026 18:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776967328; cv=none; b=CODZysX/eH5XyIrAvfEfYwH+E3V8xTPzKHm90u8O8I60OoeLoyW/IQFHFGwBLG8g1izd30xHsNVXtVX0V4yh6URv3ur36hlAjo4oJbiq4BldvcSzV9Ezi4966jEPfykXtDX95itV6AbCYXKoIRfY1cymlJyeTCmk1Ng1TDnCEys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776967328; c=relaxed/simple;
	bh=fDY90DMv3Ol8vb9oXJ/nzUFMIK0Cb7pUN0sAUQwV0HI=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=AbpLBJTmHlqvUHgBY6RHJCmPxSajVHDYwCqdmy2JmUYo7ThhSocLG6JXmKi99QLn/+P9HBMZTtn7Dqosx5oMg/oNJN4phLt7XoFQdRS9IULkbLmciw0cEy2oohl8EECIL7xzevgBBE/Vz7KjWi2F4MRSFbjaYurZNx+sVE6K8yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UFtu6quv; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63N8Z3Q73657884;
	Thu, 23 Apr 2026 18:01:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=9sjJYo
	hzQJT7F4cb93bmmPzBc2C6eRDRAe69SB0r5eM=; b=UFtu6quvBAz6lukmYUN/+i
	V+5d5WSG+AfoUyORKZtrsbPHElhh7SYmKb8r6tzOWHGHIQLLQiUU1NS1Qor5hWeq
	gaPyWoGCWXzOjTLJMqBI1RcJkpO1ApvQp5ctNOerJwGVqrZqfQD78Kls6G9UgEQZ
	6KFf6+8SqEpPmC8jccPLPdRs1qvLHPedkyvkuKBptVmfOuHA1b2awbwrQvZklHlO
	JOrlIx5h3KTAsAZnxMf43BL+jYEjLs4rpUZePAyXpiCWdgxtyo3y/p+1F6/UU0XM
	ceGXXPmSiu69EPhoS89iegJTNZ2KKFwHvHG5FAQ8th3JMe1Gxk6mzG/kQZKyy5uA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dpeu7sfe7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Apr 2026 18:01:22 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63NHocIR029971;
	Thu, 23 Apr 2026 18:01:21 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dpjky7pkd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Apr 2026 18:01:21 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63NI1KvJ17040038
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Apr 2026 18:01:20 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A18B25804E;
	Thu, 23 Apr 2026 18:01:20 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6403458054;
	Thu, 23 Apr 2026 18:01:18 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.31.96.173])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 23 Apr 2026 18:01:18 +0000 (GMT)
Message-ID: <e4e242ae5533d5762a3647186a178764881bf9ff.camel@linux.ibm.com>
Subject: Re: [RFC PATCH v2 1/4] security: ima: call ima_init() again at
 late_initcall_sync for defered TPM
From: Mimi Zohar <zohar@linux.ibm.com>
To: Yeoreum Yun <yeoreum.yun@arm.com>, Jonathan McDowell <noodles@earth.li>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.linux.dev, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, roberto.sassu@huawei.com, dmitry.kasatkin@gmail.com,
        eric.snowberg@oracle.com, jarkko@kernel.org, jgg@ziepe.ca,
        sudeep.holla@kernel.org, maz@kernel.org, oupton@kernel.org,
        joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com,
        catalin.marinas@arm.com, will@kernel.org, noodles@meta.com,
        sebastianene@google.com
In-Reply-To: <aeotq8nPVu4wvEx5@e129823.arm.com>
References: <aekkVQwueKbFtG7C@e129823.arm.com>
	 <82803bb3b471898a77084c449b73c7f7b4eb2149.camel@linux.ibm.com>
	 <aem0SSQuE1e3pGOS@e129823.arm.com>
	 <56a8aab50a3b5ce0a345fc2079fb2abc7d0f1b23.camel@linux.ibm.com>
	 <aeoAlVEwzRUPrlVe@e129823.arm.com> <aeoRxWPyOHGJd+Jh@e129823.arm.com>
	 <aeoWO2Cwo04YYu2l@earth.li>
	 <bd908e28298d968740d03c97bc7e441de188b7b4.camel@linux.ibm.com>
	 <aeokwrC86WI7uT+K@e129823.arm.com> <aeomlp3I0eVE5mce@earth.li>
	 <aeotq8nPVu4wvEx5@e129823.arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Apr 2026 14:01:17 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: wxO2tqbBYODpuAMX3yii5CFXn_ixY172
X-Authority-Analysis: v=2.4 cv=Ksp9H2WN c=1 sm=1 tr=0 ts=69ea5e73 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=7CQSdrXTAAAA:8
 a=46FjsvL0HBcK6KeyIT0A:9 a=QEXdDO2ut3YA:10 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-GUID: SLJUqnjIQ7hAgxoc7XerQzZD9gD-DF_7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIzMDE3MyBTYWx0ZWRfX59eM+OfmhLYt
 Ph5s8NVrrugP46CRSIHrUMqOusBiOvYj8VcMZuucXBaw9zOsVwD/Vqfg7ahYLK75GqCBudJtecz
 TwUZ0q6KBuB4onhgHBfmkSxUd9bljwRaOQVeVKIlKzz0VgTCGAY0CJJdAsfJ7G/e9upzbFcSMPp
 eendN1Ahoym6JVGfobIbUz8xaemNBzn+Tl2XPcB/+Oz7FJn5SPWaUEhuDkj1I7ph9yHSFkwjzvc
 Gq2I1MUVCIv3TLy5HF9RaNNx0ccUoIheDx4O49o0KjIh8tHZJS5wv6YzsVyco1dZlbU+DaiJNse
 Sw1kVjxlAw7cCyUIgrZwmsGu2opV3egqrkRWA4bm40zrIxjx598OPFQhgkx2YN6pkn8ko/kH0p1
 JpaZHcdhxySAwxp5hrhl9hfV9hruSzWWazb7j2x4h8iOZXBDzumaGPw5ZXOf1yfTZN0Mgg+5drs
 bXyUQdqQA2khGQdCBFg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 adultscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604230173
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[25];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9310-lists,linux-integrity=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,lists.linux.dev,paul-moore.com,namei.org,hallyn.com,huawei.com,gmail.com,oracle.com,kernel.org,ziepe.ca,arm.com,meta.com,google.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.ibm.com:mid];
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
X-Rspamd-Queue-Id: 1A26B455E4A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 2026-04-23 at 15:33 +0100, Yeoreum Yun wrote:
> Hi Jonathan,
>=20
> > * # Be careful, this email looks suspicious; * Out of Character: The se=
nder is exhibiting a significant deviation from their usual behavior, this =
may indicate that their account has been compromised. Be extra cautious bef=
ore opening links or attachments. *
> > On Thu, Apr 23, 2026 at 02:55:14PM +0100, Yeoreum Yun wrote:
> > > > On Thu, 2026-04-23 at 13:53 +0100, Jonathan McDowell wrote:
> > > > > On Thu, Apr 23, 2026 at 01:34:13PM +0100, Yeoreum Yun wrote:
> > > > > > > > On Thu, 2026-04-23 at 06:55 +0100, Yeoreum Yun wrote:
> > > > > > > > > > On Wed, 2026-04-22 at 20:41 +0100, Yeoreum Yun wrote:
> > > > > > > > > > > > Hi Mimi,
> > > > > > > > > > > >=20
> > > > > > > > > > > > > On Wed, 2026-04-22 at 17:24 +0100, Yeoreum Yun wr=
ote:
> > > > > > > > > > > > > > To generate the boot_aggregate log in the IMA s=
ubsystem with TPM PCR values,
> > > > > > > > > > > > > > the TPM driver must be built as built-in and
> > > > > > > > > > > > > > must be probed before the IMA subsystem is init=
ialized.
> > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > However, when the TPM device operates over the =
FF-A protocol using
> > > > > > > > > > > > > > the CRB interface, probing fails and returns -E=
PROBE_DEFER if
> > > > > > > > > > > > > > the tpm_crb_ffa device =E2=80=94 an FF-A device=
 that provides the communication
> > > > > > > > > > > > > > interface to the tpm_crb driver =E2=80=94 has n=
ot yet been probed.
> > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > To ensure the TPM device operating over the FF-=
A protocol with
> > > > > > > > > > > > > > the CRB interface is probed before IMA initiali=
zation,
> > > > > > > > > > > > > > the following conditions must be met:
> > > > > > > > > > > > > >=20
> > > > > > > > > > > > > >    1. The corresponding ffa_device must be regi=
stered,
> > > > > > > > > > > > > >       which is done via ffa_init().
> > > > > > > > > > > > > >=20
> > > > > > > > > > > > > >    2. The tpm_crb_driver must successfully prob=
e this device via
> > > > > > > > > > > > > >       tpm_crb_ffa_init().
> > > > > > > > > > > > > >=20
> > > > > > > > > > > > > >    3. The tpm_crb driver using CRB over FF-A ca=
n then
> > > > > > > > > > > > > >       be probed successfully. (See crb_acpi_add=
() and
> > > > > > > > > > > > > >       tpm_crb_ffa_init() for reference.)
> > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > Unfortunately, ffa_init(), tpm_crb_ffa_init(), =
and crb_acpi_driver_init() are
> > > > > > > > > > > > > > all registered with device_initcall, which mean=
s crb_acpi_driver_init() may
> > > > > > > > > > > > > > be invoked before ffa_init() and tpm_crb_ffa_in=
it() are completed.
> > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > When this occurs, probing the TPM device is def=
erred.
> > > > > > > > > > > > > > However, the deferred probe can happen after th=
e IMA subsystem
> > > > > > > > > > > > > > has already been initialized, since IMA initial=
ization is performed
> > > > > > > > > > > > > > during late_initcall, and deferred_probe_initca=
ll() is performed
> > > > > > > > > > > > > > at the same level.
> > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > To resolve this, call ima_init() again at late_=
inicall_sync level
> > > > > > > > > > > > > > so that let IMA not miss TPM PCR value when gen=
erating boot_aggregate
> > > > > > > > > > > > > > log though TPM device presents in the system.
> > > > > > > > > > > > > >=20
> > > > > > > > > > > > > > Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com=
>
> > > > > > > > > > > > >=20
> > > > > > > > > > > > > A lot of change for just detecting whether ima_in=
it() is being called on
> > > > > > > > > > > > > late_initcall or late_initcall_sync(), without an=
y explanation for all the other
> > > > > > > > > > > > > changes (e.g. ima_init_core).
> > > > > > > > > > > > >=20
> > > > > > > > > > > > > Please just limit the change to just calling ima_=
init() twice.
> > > > > > > > > > > >=20
> > > > > > > > > > > > My concern is that ima_update_policy_flags() will b=
e called
> > > > > > > > > > > > when ima_init() is deferred -- not initialised anyt=
hing.
> > > > > > > > > > > > though functionally, it might be okay however,
> > > > > > > > > > > > I think ima_update_policy_flags() and notifier shou=
ld work after ima_init()
> > > > > > > > > > > > works logically.
> > > > > > > > > > > >=20
> > > > > > > > > > > > This change I think not much quite a lot. just wrap=
per ima_init() with
> > > > > > > > > > > > ima_init_core() with some error handling.
> > > > > > > > > > > >=20
> > > > > > > > > > > > Am I missing something?
> > > > > > > > > > >=20
> > > > > > > > > > > Also, if we handle in ima_init() only, but it failed =
with other reason,
> > > > > > > > > > > we shouldn't call again ima_init() in the late_initca=
ll_sync.
> > > > > > > > > > >=20
> > > > > > > > > > > To handle this, It wouldn't do in the ima_init() but =
we need to handle
> > > > > > > > > > > it by caller of ima_init().
> > > > > > > > > >=20
> > > > > > > > > > Only tpm_default_chip() is being called to set the ima_=
tpm_chip.  On failure,
> > > > > > > > > > instead of going into TPM-bypass mode, return immediate=
ly.  There are no calls
> > > > > > > > > > to anything else.  Just call ima_init() a second time.
> > > > > > > > >=20
> > > > > > > > > I=E2=80=99m not fully convinced this is sufficient.
> > > > > > > > >=20
> > > > > > > > > What I meant is the case where ima_init() fails due to ot=
her
> > > > > > > > > initialisation steps, not only tpm_default_chip() (e.g. i=
ma_fs_init()).
> > > > > > > >=20
> > > > > > > > The purpose of THIS patch is to add late_initcall_sync, whe=
n the TPM is not
> > > > > > > > available at late_initcall.  This would be classified as a =
bug fix and would be
> > > > > > > > backported.  No other changes should be included in this pa=
tch.
> > > > > > >=20
> > > > > > > Okay.
> > > > > > >=20
> > > > > > > > >=20
> > > > > > > > > I=E2=80=99d also like to ask again whether it is fine to =
call
> > > > > > > > > ima_update_policy_flags() and keep the notifier registere=
d in the
> > > > > > > > > deferred TPM case. While this may be functionally accepta=
ble, it seems
> > > > > > > > > logically questionable to do so when ima_init() has not c=
ompleted.
> > > > > > > >=20
> > > > > > > > Other than extending the TPM, IMA should behave exactly the=
 same whether there
> > > > > > > > is a TPM or goes into TPM-bypass mode.
> > > > > > > >=20
> > > > > > > > >=20
> > > > > > > > > There is also a possibility that a deferred case ultimate=
ly fails (e.g.
> > > > > > > > > deferred at late_initcall, but then failing at late_initc=
all_sync
> > > > > > > > > for another reason, even while entering TPM bypass mode).=
 In that case,
> > > > > > > > > it seems more appropriate to handle this state in the cal=
ler of
> > > > > > > > > ima_init(), rather than inside ima_init() itself.
> > > > > > > >=20
> > > > > > > > If the TPM isn't found at late_initcall_sync(), then IMA sh=
ould go into TPM-
> > > > > > > > bypass mode.  Please don't make any other changes to the ex=
isting IMA behavior
> > > > > > > > and hide it here behind the late_initcall_sync change.
> > > > > > >=20
> > > > > > > Okay. you're talking called ima_update_policy_flags() at late=
_initcall
> > > > > > > wouldn't be not a problem even in case of late_initcall_sync'=
s ima_init()
> > > > > > > get failed with "TPM-bypass mode".
> > > > > > >=20
> > > > > > > I see then, I'll make a patch simpler then.
> > > > > >=20
> > > > > > But I think in case of below situation:
> > > > > >  - late_initcall's first ima_init() is deferred.
> > > > > >  - late_initcall_sync try again but failed and try again with
> > > > > >    CONFIG_IMA_DEFAULT_HASH.
> > > > > >=20
> > > > > > I would like to sustain init_ima_core to reduce the same code r=
epeat
> > > > > > in late_initcall_sync.
> > > > >=20
> > > > > I think what Mimi's proposing is:
> > > > >=20
> > > > > If we're in late_initcall, and the TPM isn't available, return
> > > > > immediately with an error (the EPROBE_DEFER?), don't do any init.
> > > > >=20
> > > > > If we're in late_initcall_sync, either we're already initialised,=
 so do
> > > > > return and nothing, or run through the entire flow, even if the T=
PM
> > > > > isn't unavailable.
> > > > >=20
> > > > > So ima_init() just needs to know a) if it's in the sync or non-sy=
nc mode
> > > > > and b) for the sync mode, if we've already done the init at
> > > > > non-sync.
> > > >=20
> > > > Thanks, Jonathan.  That is exactly what I'm suggesting.  Any other =
changes
> > > > should not be included in this patch.  Since Yeoreum is not hearing=
 me, feel
> > > > free to post a patch.
> > >=20
> > > I see. so what you need to is this only
> > > If it looks good to you. I'll send it at v3.
> >=20
> > FWIW, I pulled the tpm_default_chip check out a level to account for th=
e
> > extra init you mentioned, and have the following (completely untested o=
r
> > compiled, but gives the approach):
> >=20
> > diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> > index d48bf0ad26f4..88fe105b7f00 100644
> > --- a/include/linux/lsm_hooks.h
> > +++ b/include/linux/lsm_hooks.h
> > @@ -166,6 +166,7 @@ enum lsm_order {
> >   * @initcall_fs: LSM callback for fs_initcall setup, optional
> >   * @initcall_device: LSM callback for device_initcall() setup, optiona=
l
> >   * @initcall_late: LSM callback for late_initcall() setup, optional
> > + * @initcall_late_sync: LSM callback for late_initcall_sync() setup, o=
ptional
> >   */
> >  struct lsm_info {
> >  	const struct lsm_id *id;
> > @@ -181,6 +182,7 @@ struct lsm_info {
> >  	int (*initcall_fs)(void);
> >  	int (*initcall_device)(void);
> >  	int (*initcall_late)(void);
> > +	int (*initcall_late_sync)(void);
> >  };
> >  #define DEFINE_LSM(lsm)							\
> > diff --git a/security/integrity/ima/ima_init.c b/security/integrity/ima=
/ima_init.c
> > index a2f34f2d8ad7..a60dfb8316d8 100644
> > --- a/security/integrity/ima/ima_init.c
> > +++ b/security/integrity/ima/ima_init.c
> > @@ -119,10 +119,6 @@ int __init ima_init(void)
> >  {
> >  	int rc;
> > -	ima_tpm_chip =3D tpm_default_chip();
> > -	if (!ima_tpm_chip)
> > -		pr_info("No TPM chip found, activating TPM-bypass!\n");
> > -
> >  	rc =3D integrity_init_keyring(INTEGRITY_KEYRING_IMA);
> >  	if (rc)
> >  		return rc;
> > diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima=
/ima_main.c
> > index 1d6229b156fb..b60a85fa803a 100644
> > --- a/security/integrity/ima/ima_main.c
> > +++ b/security/integrity/ima/ima_main.c
> > @@ -1237,7 +1237,7 @@ static int ima_kernel_module_request(char *kmod_n=
ame)
> >  #endif /* CONFIG_INTEGRITY_ASYMMETRIC_KEYS */
> > -static int __init init_ima(void)
> > +static int __init init_ima(bool sync)
> >  {
> >  	int error;
> > @@ -1247,6 +1247,19 @@ static int __init init_ima(void)
> >  		return 0;
> >  	}
> > +	/* If we found the TPM during our first attempt, nothing further to d=
o */
> > +	if (sync && ima_tpm_chip)
> > +		return 0;
> > +
> > +	ima_tpm_chip =3D tpm_default_chip();
> > +	if (!ima_tpm_chip && !sync) {
> > +		pr_debug("TPM not available, will try later\n");
> > +		return -EPROBE_DEFER;
> > +	}
> > +
> > +	if (!ima_tpm_chip)
> > +		pr_info("No TPM chip found, activating TPM-bypass!\n");
> > +
> >  	ima_appraise_parse_cmdline();
> >  	ima_init_template_list();
> >  	hash_setup(CONFIG_IMA_DEFAULT_HASH);
> > @@ -1274,6 +1287,16 @@ static int __init init_ima(void)
> >  	return error;
> >  }
> > +static int __init init_ima_late(void)
> > +{
> > +	return init_ima(false);
> > +}
> > +
> > +static int __init init_ima_late_sync(void)
> > +{
> > +	return init_ima(true);
> > +}
> > +
> >  static struct security_hook_list ima_hooks[] __ro_after_init =3D {
> >  	LSM_HOOK_INIT(bprm_check_security, ima_bprm_check),
> >  	LSM_HOOK_INIT(bprm_creds_for_exec, ima_bprm_creds_for_exec),
> > @@ -1319,6 +1342,7 @@ DEFINE_LSM(ima) =3D {
> >  	.init =3D init_ima_lsm,
> >  	.order =3D LSM_ORDER_LAST,
> >  	.blobs =3D &ima_blob_sizes,
> > -	/* Start IMA after the TPM is available */
> > -	.initcall_late =3D init_ima,
> > +	/* Ensure we start IMA after the TPM is available */
> > +	.initcall_late =3D init_ima_late,
> > +	.initcall_late_sync =3D init_ima_late_sync,
> >  };
> > diff --git a/security/lsm_init.c b/security/lsm_init.c
> > index 573e2a7250c4..4e5c59beb82a 100644
> > --- a/security/lsm_init.c
> > +++ b/security/lsm_init.c
> > @@ -547,13 +547,22 @@ device_initcall(security_initcall_device);
> >   * security_initcall_late - Run the LSM late initcalls
> >   */
> >  static int __init security_initcall_late(void)
> > +{
> > +	return lsm_initcall(late);
> > +}
> > +late_initcall(security_initcall_late);
> > +
> > +/**
> > + * security_initcall_late_sync - Run the LSM late initcalls sync
> > + */
> > +static int __init security_initcall_late_sync(void)
> >  {
> >  	int rc;
> > -	rc =3D lsm_initcall(late);
> > +	rc =3D lsm_initcall(late_sync);
> >  	lsm_pr_dbg("all enabled LSMs fully activated\n");
> >  	call_blocking_lsm_notifier(LSM_STARTED_ALL, NULL);
> >  	return rc;
> >  }
> > -late_initcall(security_initcall_late);
> > +late_initcall_sync(security_initcall_late_sync);
>=20
> I'm fine this. but are we talking about "ima_init()" not "init_ima()"?

Having two functions named ima_init() and init_ima() is really confusing.  =
At
least with this patch, init_ima() will be replaced with init_ima_late() and
init_ima_sync().

> Because of this, I've fixuated and make a long stupid speaking myself.

The commit 0e0546eabcd6 ("firmware: arm_ffa: Change initcall level of ffa_i=
nit()
to rootfs_initcall") patch description was really well written.  I'm really=
 sad
that it needs to be reverted.

The TPM not being initialized before IMA, has been an issue for a really lo=
ng
time.  Hopefully this patch will safely fix it, not only for you, but for o=
thers
as well.

>=20
> If this seems good to Mimi, I don't care who send it.
> But If you're going to send this, could you includes 2 and 3 too?

Once this patch is ready, we can create a topic branch to coordinate upstre=
aming
the remaining patches.

thanks!

Mimi


