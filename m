Return-Path: <linux-integrity+bounces-9295-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QOtPAof+6WkHrAIAu9opvQ
	(envelope-from <linux-integrity+bounces-9295-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Thu, 23 Apr 2026 13:12:07 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 586994511F5
	for <lists+linux-integrity@lfdr.de>; Thu, 23 Apr 2026 13:12:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DCBC33044088
	for <lists+linux-integrity@lfdr.de>; Thu, 23 Apr 2026 11:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D9493E5584;
	Thu, 23 Apr 2026 11:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="phIKyxxb"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B833803DF;
	Thu, 23 Apr 2026 11:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776942633; cv=none; b=G6LuzjEd0t/uuGn+QP73IrpbCpXhQBcI0u+QA4LYLGXhjfm+7v/5QtibaaAjaSGhzsIRGF3FrWAiZPa8k15pjQXcPAV9Ru2OvYusdQ/AdmTFdLUo4o1+FRPj3JejgaiuJnA8+edmjIKZ+kbCCIHmK6t3XDzbhFPYHZU53C1d0z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776942633; c=relaxed/simple;
	bh=JT5twL2J7acwNcY6pJiiop+tw/rE0IBIUj5mB32UzvQ=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=uxSH78LhIaMz6RinBXWfaQXvQgZhJ4YzcqJEP+ohLyeWikoFdrLXyEuNOYIWf7eWgEL1LCKzOyeV/EAYsrh7xUxdIRfurPgYWwjuadv/LRBt7hpcgJ+uPrFe4ZbekUuGySmXL91IeaCdd9fplSJCksrf3AEeP4eiqInniWnUL0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=phIKyxxb; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63N8gTCV3291912;
	Thu, 23 Apr 2026 11:10:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=QqbwFb
	H6a5UBENtannNyDFRDj77cnqqhpzw83NssmuA=; b=phIKyxxbQljRirMHj1fQ/d
	NJ09845ej2/LgX6yHnSL31UNQfT/gXP2SAbtCyvWQ7tGXWHmvX49duJuc0S7DGNE
	4nHvtUBzO0iNEJbfwt5HCTPlNvUhYNj4UrDiZC44p2Si5tHNTM3H3WyIefmYFO6b
	ShZPjYON4/WfcGLdj1fhArCNedmydWs9SGlCmkfZLavBCHKHAB51RLMPfXxGnazv
	nBSgk6NBz5H7PhOBBLq2TCShM84Vc9aOTMuub9L2SjL3K0x3e3leRLtA0YcrCQTO
	xXFhQ86Ufkeu8maoG8T87cbwdTdi0VZuwwZTi9Fs65oX7AeUIe5KwdZmOExomkdA
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dphfrfnmh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Apr 2026 11:10:04 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63NB5I0B023969;
	Thu, 23 Apr 2026 11:10:03 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dpjkxxaj1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Apr 2026 11:10:03 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63NBA3NQ41288082
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Apr 2026 11:10:03 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 65D49580AF;
	Thu, 23 Apr 2026 11:01:12 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1339E580A8;
	Thu, 23 Apr 2026 11:01:11 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.174.254])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 23 Apr 2026 11:01:10 +0000 (GMT)
Message-ID: <56a8aab50a3b5ce0a345fc2079fb2abc7d0f1b23.camel@linux.ibm.com>
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
In-Reply-To: <aem0SSQuE1e3pGOS@e129823.arm.com>
References: <20260422162449.1814615-1-yeoreum.yun@arm.com>
	 <20260422162449.1814615-2-yeoreum.yun@arm.com>
	 <6919248bdc85dac60277fa9d9c83d8bd258ca635.camel@linux.ibm.com>
	 <aekXaU52fzvNYaUF@e129823.arm.com> <aekkVQwueKbFtG7C@e129823.arm.com>
	 <82803bb3b471898a77084c449b73c7f7b4eb2149.camel@linux.ibm.com>
	 <aem0SSQuE1e3pGOS@e129823.arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Apr 2026 07:01:10 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: K6OLk0fbJGi7d60h0ZFqhtW1DlQ1sSgg
X-Proofpoint-ORIG-GUID: hNdzntgNSc0GoNTv5nyCRXyUj0Jw9Lw3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIzMDEwNyBTYWx0ZWRfX7F4fjZ4CGN+i
 JhBrBzc1jFFXCf0LwhxTb74RyjH7BEb0SE0jd5+KULOKAVvz8N1WXqIjpGbTYPZF/4aGxFuYY8D
 RoiNrMqRBQbbLLe3wlTZ01gLV/4GUC10I2qcw8WJgiGQST9x5WD9Nm12v47iuQ7uMmbLsvSQSRO
 CTTTrWNqGNlyMorwLz20KkJkG7E7+tPEnRbBpmRGj1u4WTBS3OEI3Ynct24sF4eQmUBQhTsIpPX
 N7BK+yIS5DXwPZ8Ids9iBWThCXP/nV705EeQL+7PU3yOSiammG+HFXYFbOWEVFC8ARGpPLao3XU
 hH7UcSBZMA/l539+Tm+GnpOK9x/qUPxUywbZuIlxRRDeAQD3Pod0pVZ2HtuxPzyV59ymTN0Oae8
 NMssg9riaIJ/kf+mzhclh3CUxOSKwZaQ+11MyZ0LQJTD2G/5vg9sJYfNN1au7OVB1cEuzdFCEGm
 +Xp7/MAN0aMfH/Lw1gw==
X-Authority-Analysis: v=2.4 cv=SJxykuvH c=1 sm=1 tr=0 ts=69e9fe0d cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=7CQSdrXTAAAA:8
 a=aEHzUbLWVaQ50KIkOWgA:9 a=QEXdDO2ut3YA:10 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604230107
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
	RCPT_COUNT_TWELVE(0.00)[24];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9295-lists,linux-integrity=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,lists.linux.dev,paul-moore.com,namei.org,hallyn.com,huawei.com,gmail.com,oracle.com,kernel.org,ziepe.ca,arm.com,meta.com,google.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.ibm.com:mid];
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
X-Rspamd-Queue-Id: 586994511F5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 2026-04-23 at 06:55 +0100, Yeoreum Yun wrote:
> > On Wed, 2026-04-22 at 20:41 +0100, Yeoreum Yun wrote:
> > > > Hi Mimi,
> > > >=20
> > > > > On Wed, 2026-04-22 at 17:24 +0100, Yeoreum Yun wrote:
> > > > > > To generate the boot_aggregate log in the IMA subsystem with TP=
M PCR values,
> > > > > > the TPM driver must be built as built-in and
> > > > > > must be probed before the IMA subsystem is initialized.
> > > > > >=20
> > > > > > However, when the TPM device operates over the FF-A protocol us=
ing
> > > > > > the CRB interface, probing fails and returns -EPROBE_DEFER if
> > > > > > the tpm_crb_ffa device =E2=80=94 an FF-A device that provides t=
he communication
> > > > > > interface to the tpm_crb driver =E2=80=94 has not yet been prob=
ed.
> > > > > >=20
> > > > > > To ensure the TPM device operating over the FF-A protocol with
> > > > > > the CRB interface is probed before IMA initialization,
> > > > > > the following conditions must be met:
> > > > > >=20
> > > > > >    1. The corresponding ffa_device must be registered,
> > > > > >       which is done via ffa_init().
> > > > > >=20
> > > > > >    2. The tpm_crb_driver must successfully probe this device vi=
a
> > > > > >       tpm_crb_ffa_init().
> > > > > >=20
> > > > > >    3. The tpm_crb driver using CRB over FF-A can then
> > > > > >       be probed successfully. (See crb_acpi_add() and
> > > > > >       tpm_crb_ffa_init() for reference.)
> > > > > >=20
> > > > > > Unfortunately, ffa_init(), tpm_crb_ffa_init(), and crb_acpi_dri=
ver_init() are
> > > > > > all registered with device_initcall, which means crb_acpi_drive=
r_init() may
> > > > > > be invoked before ffa_init() and tpm_crb_ffa_init() are complet=
ed.
> > > > > >=20
> > > > > > When this occurs, probing the TPM device is deferred.
> > > > > > However, the deferred probe can happen after the IMA subsystem
> > > > > > has already been initialized, since IMA initialization is perfo=
rmed
> > > > > > during late_initcall, and deferred_probe_initcall() is performe=
d
> > > > > > at the same level.
> > > > > >=20
> > > > > > To resolve this, call ima_init() again at late_inicall_sync lev=
el
> > > > > > so that let IMA not miss TPM PCR value when generating boot_agg=
regate
> > > > > > log though TPM device presents in the system.
> > > > > >=20
> > > > > > Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
> > > > >=20
> > > > > A lot of change for just detecting whether ima_init() is being ca=
lled on
> > > > > late_initcall or late_initcall_sync(), without any explanation fo=
r all the other
> > > > > changes (e.g. ima_init_core).
> > > > >=20
> > > > > Please just limit the change to just calling ima_init() twice.
> > > >=20
> > > > My concern is that ima_update_policy_flags() will be called
> > > > when ima_init() is deferred -- not initialised anything.
> > > > though functionally, it might be okay however,
> > > > I think ima_update_policy_flags() and notifier should work after im=
a_init()
> > > > works logically.
> > > >=20
> > > > This change I think not much quite a lot. just wrapper ima_init() w=
ith
> > > > ima_init_core() with some error handling.
> > > >=20
> > > > Am I missing something?
> > >=20
> > > Also, if we handle in ima_init() only, but it failed with other reaso=
n,
> > > we shouldn't call again ima_init() in the late_initcall_sync.
> > >=20
> > > To handle this, It wouldn't do in the ima_init() but we need to handl=
e
> > > it by caller of ima_init().
> >=20
> > Only tpm_default_chip() is being called to set the ima_tpm_chip.  On fa=
ilure,
> > instead of going into TPM-bypass mode, return immediately.  There are n=
o calls
> > to anything else.  Just call ima_init() a second time.
>=20
> I=E2=80=99m not fully convinced this is sufficient.
>=20
> What I meant is the case where ima_init() fails due to other
> initialisation steps, not only tpm_default_chip() (e.g. ima_fs_init()).

The purpose of THIS patch is to add late_initcall_sync, when the TPM is not
available at late_initcall.  This would be classified as a bug fix and woul=
d be
backported.  No other changes should be included in this patch.

>=20
> If it fails at the late_initcall stage for such reasons, then we
> should not call ima_init() again at late_initcall_sync.
>=20
> For this reason, instead of adding a static variable inside
> ima_init(), I think it would be better to manage the state in the
> caller and introduce something like an ima_initialised flag. Also, if
> initialisation fails for other reasons, the notifier block should be
> unregistered.

Defining a global file static variable, in lieu of a local static variable,=
 is
fine. Defining two functions, one for late_initcall and another for
late_initcall_sync, that do nothing other than call ima_init() is also fine=
.
Please keep this patch as simple as possible.

>=20
> I=E2=80=99d also like to ask again whether it is fine to call
> ima_update_policy_flags() and keep the notifier registered in the
> deferred TPM case. While this may be functionally acceptable, it seems
> logically questionable to do so when ima_init() has not completed.

Other than extending the TPM, IMA should behave exactly the same whether th=
ere
is a TPM or goes into TPM-bypass mode.

>=20
> There is also a possibility that a deferred case ultimately fails (e.g.
> deferred at late_initcall, but then failing at late_initcall_sync
> for another reason, even while entering TPM bypass mode). In that case,
> it seems more appropriate to handle this state in the caller of
> ima_init(), rather than inside ima_init() itself.

If the TPM isn't found at late_initcall_sync(), then IMA should go into TPM=
-
bypass mode.  Please don't make any other changes to the existing IMA behav=
ior
and hide it here behind the late_initcall_sync change.

>=20
> Am I still missing something?

When your original patch moved the initialization from late_initcall to
late_initcall_sync, you didn't question anything.  There's absolutely no
difference between that and calling ima_init twice, as long as on late_init=
call
ima_init() returns immediately if the TPM chip isn't defined.

Any other changes are superfluous.  Keep the patch simple!

Mimi

