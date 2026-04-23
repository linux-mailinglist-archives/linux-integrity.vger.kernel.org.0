Return-Path: <linux-integrity+bounces-9302-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ODKqDiwj6mnKuwIAu9opvQ
	(envelope-from <linux-integrity+bounces-9302-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Thu, 23 Apr 2026 15:48:28 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 52612453419
	for <lists+linux-integrity@lfdr.de>; Thu, 23 Apr 2026 15:48:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0B71E3031021
	for <lists+linux-integrity@lfdr.de>; Thu, 23 Apr 2026 13:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60F9D2D0C84;
	Thu, 23 Apr 2026 13:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FH+DTb1H"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5EB52C0285;
	Thu, 23 Apr 2026 13:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776951857; cv=none; b=rKWtNsQTR03r2+PMc0c4IcbN9ArocrC29y8gEcaserq5N1vu0rqF6ZR7lljX/oAmx/fH6CtHLwYhHAm3ZBrqkfUr1WdthnJ/hPz/SMmdGOWQvdvo/nq2UaNKmGWvVJSuvHQnwepxj1PFTg8yDwwTmBHehnXcoh3o5IB5ISmbwGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776951857; c=relaxed/simple;
	bh=GFfBv1A9XoMMQjboNfbMvImcPrwkC05tlceuFf8ToNQ=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=oeUtrPL82GkSxVk9Kyd3w3oYQXm/SjefXnQ3ItpvBmT/6olmX541d5ywEw+OZ3TDf0HQ3rZJfcAvitAd3WH8Q52c+1GR1Qhxx5okt/sZzFBreFOZCmXIsFapJGjqKVE33grrEaiE8cBvpYQTXCeeV7wHxIuexKcRzmjC83bgQqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FH+DTb1H; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63N6ooMu3229044;
	Thu, 23 Apr 2026 13:43:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=xd0UHF
	P1ZE/nb/myoyLJa+WYNKpg4XG8PdpKOXq78eM=; b=FH+DTb1Hk/HLZ5IX+0nwww
	PHxw7sDsX/bbBxrkX5qSA3anbsGJLf6sCLQUIyxugSg37D3jvWYISa6c4XQiDYvy
	xNSYtGos9QBXkERsiJq9rme5GAWeLtzfcGBiYLPiWhDpgroMnMwSX0Z5GpBjgtVu
	Mc5akUizT8x/tk8/kYfGt8PusUb9nv4KPsoTexqoVo+KZ9zG5WGbnZuC+Kg7qTaa
	BG0rtdlYUtWK0AxtSrSxyGJ3X7CxgSwkdHNe4ErykTBdnbxjs418I+N5CXAlTJYt
	lvR76v56AwAYfJsdE/4RWFyFzECN6VFS/mYSWSrdA6CtvtPLM+0r0suTZNQLMm5A
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dpeu28wgr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Apr 2026 13:43:48 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63NDZO0C003099;
	Thu, 23 Apr 2026 13:43:47 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dpjkyetdt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Apr 2026 13:43:47 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63NDhkfS15204980
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Apr 2026 13:43:46 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 35EE858053;
	Thu, 23 Apr 2026 13:43:46 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E803A58043;
	Thu, 23 Apr 2026 13:43:43 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.20.220])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 23 Apr 2026 13:43:43 +0000 (GMT)
Message-ID: <bd908e28298d968740d03c97bc7e441de188b7b4.camel@linux.ibm.com>
Subject: Re: [RFC PATCH v2 1/4] security: ima: call ima_init() again at
 late_initcall_sync for defered TPM
From: Mimi Zohar <zohar@linux.ibm.com>
To: Jonathan McDowell <noodles@earth.li>, Yeoreum Yun <yeoreum.yun@arm.com>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.linux.dev, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, roberto.sassu@huawei.com, dmitry.kasatkin@gmail.com,
        eric.snowberg@oracle.com, jarkko@kernel.org, jgg@ziepe.ca,
        sudeep.holla@kernel.org, maz@kernel.org, oupton@kernel.org,
        joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com,
        catalin.marinas@arm.com, will@kernel.org, noodles@meta.com,
        sebastianene@google.com
In-Reply-To: <aeoWO2Cwo04YYu2l@earth.li>
References: <20260422162449.1814615-1-yeoreum.yun@arm.com>
	 <20260422162449.1814615-2-yeoreum.yun@arm.com>
	 <6919248bdc85dac60277fa9d9c83d8bd258ca635.camel@linux.ibm.com>
	 <aekXaU52fzvNYaUF@e129823.arm.com> <aekkVQwueKbFtG7C@e129823.arm.com>
	 <82803bb3b471898a77084c449b73c7f7b4eb2149.camel@linux.ibm.com>
	 <aem0SSQuE1e3pGOS@e129823.arm.com>
	 <56a8aab50a3b5ce0a345fc2079fb2abc7d0f1b23.camel@linux.ibm.com>
	 <aeoAlVEwzRUPrlVe@e129823.arm.com> <aeoRxWPyOHGJd+Jh@e129823.arm.com>
	 <aeoWO2Cwo04YYu2l@earth.li>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Apr 2026 09:43:43 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: VLk680LfBuWU4MevutP832_aGjpXtcSO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIzMDEzMiBTYWx0ZWRfX1SRS9jK1yggO
 X77pyH0zDuAwUvEo5aO+nYKfstVA3eSbLhWbqPYgKOevRXLGOe5S2U/gSU8MZfbcX6gpnQxVLD9
 1OAvLBDiaZrXjSArGCv7VSfIfae7PWgrhLdt2cK9/zO2W9zApRoFZ8amAEPSNcPECUj8cNbMVmJ
 0ePoPNmlz3hvXtCAtfLm0qF03F432IZsQH6jnOazTFXCn2XutmBjt3evzKFc7p9k89bxOlYb3Fw
 AY3Pw0w6cxtOoMB+hBEk4WySVSQNdjqO2ACFsO8R3OkOX9Nb+u/gtAbVFEqumANDg50ZXhgweGd
 kJRpSEyLEMxkkB3tNZpZ7PW2iri4LnfS1AMWKKHmUy9VAl4frVAZVN8WCjahQA1hhz+BZq4b7R3
 lQxB/emfoYcLCvspVPPseJ8lAsZv2/+O6b12a8cFw7NY9kFRmqtUvqh2SVAFgkbV/bXCXGEiLjz
 klORdMEueANPVYuURWw==
X-Authority-Analysis: v=2.4 cv=C8LZDwP+ c=1 sm=1 tr=0 ts=69ea2215 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=7CQSdrXTAAAA:8
 a=4FW480EdQVPiPFE7CngA:9 a=QEXdDO2ut3YA:10 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-ORIG-GUID: 2Vy1Wxh-GJVQo-0D4VxrtFTAzJHLMVrq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 impostorscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604230132
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[25];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9302-lists,linux-integrity=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,lists.linux.dev,paul-moore.com,namei.org,hallyn.com,huawei.com,gmail.com,oracle.com,kernel.org,ziepe.ca,arm.com,meta.com,google.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.ibm.com:mid];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
X-Rspamd-Queue-Id: 52612453419
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 2026-04-23 at 13:53 +0100, Jonathan McDowell wrote:
> On Thu, Apr 23, 2026 at 01:34:13PM +0100, Yeoreum Yun wrote:
> > > > On Thu, 2026-04-23 at 06:55 +0100, Yeoreum Yun wrote:
> > > > > > On Wed, 2026-04-22 at 20:41 +0100, Yeoreum Yun wrote:
> > > > > > > > Hi Mimi,
> > > > > > > >=20
> > > > > > > > > On Wed, 2026-04-22 at 17:24 +0100, Yeoreum Yun wrote:
> > > > > > > > > > To generate the boot_aggregate log in the IMA subsystem=
 with TPM PCR values,
> > > > > > > > > > the TPM driver must be built as built-in and
> > > > > > > > > > must be probed before the IMA subsystem is initialized.
> > > > > > > > > >=20
> > > > > > > > > > However, when the TPM device operates over the FF-A pro=
tocol using
> > > > > > > > > > the CRB interface, probing fails and returns -EPROBE_DE=
FER if
> > > > > > > > > > the tpm_crb_ffa device =E2=80=94 an FF-A device that pr=
ovides the communication
> > > > > > > > > > interface to the tpm_crb driver =E2=80=94 has not yet b=
een probed.
> > > > > > > > > >=20
> > > > > > > > > > To ensure the TPM device operating over the FF-A protoc=
ol with
> > > > > > > > > > the CRB interface is probed before IMA initialization,
> > > > > > > > > > the following conditions must be met:
> > > > > > > > > >=20
> > > > > > > > > >    1. The corresponding ffa_device must be registered,
> > > > > > > > > >       which is done via ffa_init().
> > > > > > > > > >=20
> > > > > > > > > >    2. The tpm_crb_driver must successfully probe this d=
evice via
> > > > > > > > > >       tpm_crb_ffa_init().
> > > > > > > > > >=20
> > > > > > > > > >    3. The tpm_crb driver using CRB over FF-A can then
> > > > > > > > > >       be probed successfully. (See crb_acpi_add() and
> > > > > > > > > >       tpm_crb_ffa_init() for reference.)
> > > > > > > > > >=20
> > > > > > > > > > Unfortunately, ffa_init(), tpm_crb_ffa_init(), and crb_=
acpi_driver_init() are
> > > > > > > > > > all registered with device_initcall, which means crb_ac=
pi_driver_init() may
> > > > > > > > > > be invoked before ffa_init() and tpm_crb_ffa_init() are=
 completed.
> > > > > > > > > >=20
> > > > > > > > > > When this occurs, probing the TPM device is deferred.
> > > > > > > > > > However, the deferred probe can happen after the IMA su=
bsystem
> > > > > > > > > > has already been initialized, since IMA initialization =
is performed
> > > > > > > > > > during late_initcall, and deferred_probe_initcall() is =
performed
> > > > > > > > > > at the same level.
> > > > > > > > > >=20
> > > > > > > > > > To resolve this, call ima_init() again at late_inicall_=
sync level
> > > > > > > > > > so that let IMA not miss TPM PCR value when generating =
boot_aggregate
> > > > > > > > > > log though TPM device presents in the system.
> > > > > > > > > >=20
> > > > > > > > > > Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
> > > > > > > > >=20
> > > > > > > > > A lot of change for just detecting whether ima_init() is =
being called on
> > > > > > > > > late_initcall or late_initcall_sync(), without any explan=
ation for all the other
> > > > > > > > > changes (e.g. ima_init_core).
> > > > > > > > >=20
> > > > > > > > > Please just limit the change to just calling ima_init() t=
wice.
> > > > > > > >=20
> > > > > > > > My concern is that ima_update_policy_flags() will be called
> > > > > > > > when ima_init() is deferred -- not initialised anything.
> > > > > > > > though functionally, it might be okay however,
> > > > > > > > I think ima_update_policy_flags() and notifier should work =
after ima_init()
> > > > > > > > works logically.
> > > > > > > >=20
> > > > > > > > This change I think not much quite a lot. just wrapper ima_=
init() with
> > > > > > > > ima_init_core() with some error handling.
> > > > > > > >=20
> > > > > > > > Am I missing something?
> > > > > > >=20
> > > > > > > Also, if we handle in ima_init() only, but it failed with oth=
er reason,
> > > > > > > we shouldn't call again ima_init() in the late_initcall_sync.
> > > > > > >=20
> > > > > > > To handle this, It wouldn't do in the ima_init() but we need =
to handle
> > > > > > > it by caller of ima_init().
> > > > > >=20
> > > > > > Only tpm_default_chip() is being called to set the ima_tpm_chip=
.  On failure,
> > > > > > instead of going into TPM-bypass mode, return immediately.  The=
re are no calls
> > > > > > to anything else.  Just call ima_init() a second time.
> > > > >=20
> > > > > I=E2=80=99m not fully convinced this is sufficient.
> > > > >=20
> > > > > What I meant is the case where ima_init() fails due to other
> > > > > initialisation steps, not only tpm_default_chip() (e.g. ima_fs_in=
it()).
> > > >=20
> > > > The purpose of THIS patch is to add late_initcall_sync, when the TP=
M is not
> > > > available at late_initcall.  This would be classified as a bug fix =
and would be
> > > > backported.  No other changes should be included in this patch.
> > >=20
> > > Okay.
> > >=20
> > > > >=20
> > > > > I=E2=80=99d also like to ask again whether it is fine to call
> > > > > ima_update_policy_flags() and keep the notifier registered in the
> > > > > deferred TPM case. While this may be functionally acceptable, it =
seems
> > > > > logically questionable to do so when ima_init() has not completed=
.
> > > >=20
> > > > Other than extending the TPM, IMA should behave exactly the same wh=
ether there
> > > > is a TPM or goes into TPM-bypass mode.
> > > >=20
> > > > >=20
> > > > > There is also a possibility that a deferred case ultimately fails=
 (e.g.
> > > > > deferred at late_initcall, but then failing at late_initcall_sync
> > > > > for another reason, even while entering TPM bypass mode). In that=
 case,
> > > > > it seems more appropriate to handle this state in the caller of
> > > > > ima_init(), rather than inside ima_init() itself.
> > > >=20
> > > > If the TPM isn't found at late_initcall_sync(), then IMA should go =
into TPM-
> > > > bypass mode.  Please don't make any other changes to the existing I=
MA behavior
> > > > and hide it here behind the late_initcall_sync change.
> > >=20
> > > Okay. you're talking called ima_update_policy_flags() at late_initcal=
l
> > > wouldn't be not a problem even in case of late_initcall_sync's ima_in=
it()
> > > get failed with "TPM-bypass mode".
> > >=20
> > > I see then, I'll make a patch simpler then.
> >=20
> > But I think in case of below situation:
> >  - late_initcall's first ima_init() is deferred.
> >  - late_initcall_sync try again but failed and try again with
> >    CONFIG_IMA_DEFAULT_HASH.
> >=20
> > I would like to sustain init_ima_core to reduce the same code repeat
> > in late_initcall_sync.
>=20
> I think what Mimi's proposing is:
>=20
> If we're in late_initcall, and the TPM isn't available, return=20
> immediately with an error (the EPROBE_DEFER?), don't do any init.
>=20
> If we're in late_initcall_sync, either we're already initialised, so do=
=20
> return and nothing, or run through the entire flow, even if the TPM=20
> isn't unavailable.
>=20
> So ima_init() just needs to know a) if it's in the sync or non-sync mode=
=20
> and b) for the sync mode, if we've already done the init at
> non-sync.

Thanks, Jonathan.  That is exactly what I'm suggesting.  Any other changes
should not be included in this patch.  Since Yeoreum is not hearing me, fee=
l
free to post a patch.

Mimi

