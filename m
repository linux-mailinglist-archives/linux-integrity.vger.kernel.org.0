Return-Path: <linux-integrity+bounces-9306-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CI+qHYIx6mkCwwIAu9opvQ
	(envelope-from <linux-integrity+bounces-9306-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Thu, 23 Apr 2026 16:49:38 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 51B9A453DFA
	for <lists+linux-integrity@lfdr.de>; Thu, 23 Apr 2026 16:49:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3F47F3002515
	for <lists+linux-integrity@lfdr.de>; Thu, 23 Apr 2026 14:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4585033ADAC;
	Thu, 23 Apr 2026 14:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BO1ztlFN"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD78A3242BC;
	Thu, 23 Apr 2026 14:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776955773; cv=none; b=lEsyZxj2tdV4SEXhGnCsJFVpbxKODt23vvHEGdqF5RTHfU+1H07J1NW2oQPyL7tWxYTdoPaWr0RMuNDxQQPdAmpLceVSkJphKhE42GWwNaGhjRsW/dOt5GR96ZTcntsfQ4CXlv65NnBBC/32wrJUAHLb7NFRVyDOMOfThQgoiQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776955773; c=relaxed/simple;
	bh=A3d3TMrbuppm7+/PSwvzX0eNY8UWtT73+fx177P1i7c=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=QMZK/oWZnqW0D7uyMWwQPMnWAZPCjQ4u+EU9xPHa/C1mNkcsQpnvC9UU8tvwSQcLQuBCRyLd6uwn0ZBb1i6+CHEIdpymrHHNhpVd91D+p8wDS/NKGKfRK4YXD+xl4A+U8Y4cNxR5i6e3OqAlBC9YFjPSLr7pgyAq2Fx+idyjEQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BO1ztlFN; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63N7QKD53944159;
	Thu, 23 Apr 2026 14:48:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=2X95vN
	FhiGgw4Oc8IWUqhuoOMgNVlJZ/+5OGocvfY/c=; b=BO1ztlFN95zprQPeZ4dgTq
	woJObfJbu/QC2hUiIO4w2R1h24i0i4Eqi2B2j1pT0Bzt02t7eICaV4kfnycTQUSG
	LcGX4LEz3VOMhbNz1xIuZgBYaiKqMBMQ97NiRmb2nc6AQCyyHSjP1EX9vtayj1jm
	/BaCB1iDKIEkOpJ3b7OhGlTsAT3ncYOhYRO137ZF6Aa5nfuq1to32qoOZqk4QlIg
	6jZ1jQAQxALuh3Lwqi+qKGyjerexCBNA52WdPUthHmUZW9NUb0cbLwB4M7XZC+fe
	O9cVPhoKeMA0GcJXlcx3rUO5sWnwWPDpKDY4UA02/PQeYVxecjyuM2Xo264O/SRA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dpeu3rkgf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Apr 2026 14:48:53 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63NEZUJm004742;
	Thu, 23 Apr 2026 14:48:52 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dpjky713c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Apr 2026 14:48:52 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63NEmPOv29557474
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Apr 2026 14:48:25 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D39F258052;
	Thu, 23 Apr 2026 14:48:51 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9C0AB58050;
	Thu, 23 Apr 2026 14:48:49 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.20.220])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 23 Apr 2026 14:48:49 +0000 (GMT)
Message-ID: <2866f7679fe6933de667ce74ae68bd4ea9198e2a.camel@linux.ibm.com>
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
In-Reply-To: <aeomlp3I0eVE5mce@earth.li>
References: <aekXaU52fzvNYaUF@e129823.arm.com>
	 <aekkVQwueKbFtG7C@e129823.arm.com>
	 <82803bb3b471898a77084c449b73c7f7b4eb2149.camel@linux.ibm.com>
	 <aem0SSQuE1e3pGOS@e129823.arm.com>
	 <56a8aab50a3b5ce0a345fc2079fb2abc7d0f1b23.camel@linux.ibm.com>
	 <aeoAlVEwzRUPrlVe@e129823.arm.com> <aeoRxWPyOHGJd+Jh@e129823.arm.com>
	 <aeoWO2Cwo04YYu2l@earth.li>
	 <bd908e28298d968740d03c97bc7e441de188b7b4.camel@linux.ibm.com>
	 <aeokwrC86WI7uT+K@e129823.arm.com> <aeomlp3I0eVE5mce@earth.li>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Apr 2026 10:48:49 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: mhnhRqzT077GasUIHAWRC6Bxei_ER3TC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIzMDE0OCBTYWx0ZWRfX7LTl84561ngj
 NrfCegwr1JH9F/ZSapPt1HM5AU1eXvd5s3CLlRIHPmfnRal147hEslMOmSeNEjpg0nUjVJSts9v
 5+09IWcVbM4ROgZOM+HCz8dUCvKF0E2mgEl/p11rK57BlC0Z4p4/o9UtAt1s+dPcO9AVwRDXicw
 oFZndN60zpTd5M1vMBK/B/o7kUONIdy/QJzpnWJmYZAnKmU9c+EfFGuY75/eoc9okcHbF4TS95q
 siHGQeFBROqNceXGxkZpiSpPkqUVNrfomS+A6IZO4Vdvp2X2QR8gIMd4TK6SbbOwE1uY2vjx2rb
 JvwWK72ykzPNtA/z7x+emRFVxw0VHXRYhCi50ZwF1Oi+siXXQ/Ute6YwXqGV2pePDQ5bkUVgPBZ
 9OnuRe1Nx9hn3nihhE2bahyusFYc7FatdKLr4XAm7syDThMfYT42Qv9KMgTQAYLVbX1DjAdXFvl
 G/0G8X8IGeFhucv2LMw==
X-Authority-Analysis: v=2.4 cv=a6kAM0SF c=1 sm=1 tr=0 ts=69ea3155 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=7CQSdrXTAAAA:8
 a=EGpjKbHA07BNBKX1QMUA:9 a=QEXdDO2ut3YA:10 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-ORIG-GUID: b6OLFrmHeMQJAjCoVqyqnXU3MJj-NPDh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 bulkscore=0
 lowpriorityscore=0 impostorscore=0 clxscore=1015 phishscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604230148
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[25];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9306-lists,linux-integrity=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,lists.linux.dev,paul-moore.com,namei.org,hallyn.com,huawei.com,gmail.com,oracle.com,kernel.org,ziepe.ca,arm.com,meta.com,google.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.ibm.com:mid,arm.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
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
X-Rspamd-Queue-Id: 51B9A453DFA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 2026-04-23 at 15:03 +0100, Jonathan McDowell wrote:
> On Thu, Apr 23, 2026 at 02:55:14PM +0100, Yeoreum Yun wrote:
> > > On Thu, 2026-04-23 at 13:53 +0100, Jonathan McDowell wrote:
> > > > On Thu, Apr 23, 2026 at 01:34:13PM +0100, Yeoreum Yun wrote:
> > > > > > > On Thu, 2026-04-23 at 06:55 +0100, Yeoreum Yun wrote:
> > > > > > > > > On Wed, 2026-04-22 at 20:41 +0100, Yeoreum Yun wrote:
> > > > > > > > > > > Hi Mimi,
> > > > > > > > > > >=20
> > > > > > > > > > > > On Wed, 2026-04-22 at 17:24 +0100, Yeoreum Yun wrot=
e:
> > > > > > > > > > > > > To generate the boot_aggregate log in the IMA sub=
system with TPM PCR values,
> > > > > > > > > > > > > the TPM driver must be built as built-in and
> > > > > > > > > > > > > must be probed before the IMA subsystem is initia=
lized.
> > > > > > > > > > > > >=20
> > > > > > > > > > > > > However, when the TPM device operates over the FF=
-A protocol using
> > > > > > > > > > > > > the CRB interface, probing fails and returns -EPR=
OBE_DEFER if
> > > > > > > > > > > > > the tpm_crb_ffa device =E2=80=94 an FF-A device t=
hat provides the communication
> > > > > > > > > > > > > interface to the tpm_crb driver =E2=80=94 has not=
 yet been probed.
> > > > > > > > > > > > >=20
> > > > > > > > > > > > > To ensure the TPM device operating over the FF-A =
protocol with
> > > > > > > > > > > > > the CRB interface is probed before IMA initializa=
tion,
> > > > > > > > > > > > > the following conditions must be met:
> > > > > > > > > > > > >=20
> > > > > > > > > > > > >    1. The corresponding ffa_device must be regist=
ered,
> > > > > > > > > > > > >       which is done via ffa_init().
> > > > > > > > > > > > >=20
> > > > > > > > > > > > >    2. The tpm_crb_driver must successfully probe =
this device via
> > > > > > > > > > > > >       tpm_crb_ffa_init().
> > > > > > > > > > > > >=20
> > > > > > > > > > > > >    3. The tpm_crb driver using CRB over FF-A can =
then
> > > > > > > > > > > > >       be probed successfully. (See crb_acpi_add()=
 and
> > > > > > > > > > > > >       tpm_crb_ffa_init() for reference.)
> > > > > > > > > > > > >=20
> > > > > > > > > > > > > Unfortunately, ffa_init(), tpm_crb_ffa_init(), an=
d crb_acpi_driver_init() are
> > > > > > > > > > > > > all registered with device_initcall, which means =
crb_acpi_driver_init() may
> > > > > > > > > > > > > be invoked before ffa_init() and tpm_crb_ffa_init=
() are completed.
> > > > > > > > > > > > >=20
> > > > > > > > > > > > > When this occurs, probing the TPM device is defer=
red.
> > > > > > > > > > > > > However, the deferred probe can happen after the =
IMA subsystem
> > > > > > > > > > > > > has already been initialized, since IMA initializ=
ation is performed
> > > > > > > > > > > > > during late_initcall, and deferred_probe_initcall=
() is performed
> > > > > > > > > > > > > at the same level.
> > > > > > > > > > > > >=20
> > > > > > > > > > > > > To resolve this, call ima_init() again at late_in=
icall_sync level
> > > > > > > > > > > > > so that let IMA not miss TPM PCR value when gener=
ating boot_aggregate
> > > > > > > > > > > > > log though TPM device presents in the system.
> > > > > > > > > > > > >=20
> > > > > > > > > > > > > Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
> > > > > > > > > > > >=20
> > > > > > > > > > > > A lot of change for just detecting whether ima_init=
() is being called on
> > > > > > > > > > > > late_initcall or late_initcall_sync(), without any =
explanation for all the other
> > > > > > > > > > > > changes (e.g. ima_init_core).
> > > > > > > > > > > >=20
> > > > > > > > > > > > Please just limit the change to just calling ima_in=
it() twice.
> > > > > > > > > > >=20
> > > > > > > > > > > My concern is that ima_update_policy_flags() will be =
called
> > > > > > > > > > > when ima_init() is deferred -- not initialised anythi=
ng.
> > > > > > > > > > > though functionally, it might be okay however,
> > > > > > > > > > > I think ima_update_policy_flags() and notifier should=
 work after ima_init()
> > > > > > > > > > > works logically.
> > > > > > > > > > >=20
> > > > > > > > > > > This change I think not much quite a lot. just wrappe=
r ima_init() with
> > > > > > > > > > > ima_init_core() with some error handling.
> > > > > > > > > > >=20
> > > > > > > > > > > Am I missing something?
> > > > > > > > > >=20
> > > > > > > > > > Also, if we handle in ima_init() only, but it failed wi=
th other reason,
> > > > > > > > > > we shouldn't call again ima_init() in the late_initcall=
_sync.
> > > > > > > > > >=20
> > > > > > > > > > To handle this, It wouldn't do in the ima_init() but we=
 need to handle
> > > > > > > > > > it by caller of ima_init().
> > > > > > > > >=20
> > > > > > > > > Only tpm_default_chip() is being called to set the ima_tp=
m_chip.  On failure,
> > > > > > > > > instead of going into TPM-bypass mode, return immediately=
.  There are no calls
> > > > > > > > > to anything else.  Just call ima_init() a second time.
> > > > > > > >=20
> > > > > > > > I=E2=80=99m not fully convinced this is sufficient.
> > > > > > > >=20
> > > > > > > > What I meant is the case where ima_init() fails due to othe=
r
> > > > > > > > initialisation steps, not only tpm_default_chip() (e.g. ima=
_fs_init()).
> > > > > > >=20
> > > > > > > The purpose of THIS patch is to add late_initcall_sync, when =
the TPM is not
> > > > > > > available at late_initcall.  This would be classified as a bu=
g fix and would be
> > > > > > > backported.  No other changes should be included in this patc=
h.
> > > > > >=20
> > > > > > Okay.
> > > > > >=20
> > > > > > > >=20
> > > > > > > > I=E2=80=99d also like to ask again whether it is fine to ca=
ll
> > > > > > > > ima_update_policy_flags() and keep the notifier registered =
in the
> > > > > > > > deferred TPM case. While this may be functionally acceptabl=
e, it seems
> > > > > > > > logically questionable to do so when ima_init() has not com=
pleted.
> > > > > > >=20
> > > > > > > Other than extending the TPM, IMA should behave exactly the s=
ame whether there
> > > > > > > is a TPM or goes into TPM-bypass mode.
> > > > > > >=20
> > > > > > > >=20
> > > > > > > > There is also a possibility that a deferred case ultimately=
 fails (e.g.
> > > > > > > > deferred at late_initcall, but then failing at late_initcal=
l_sync
> > > > > > > > for another reason, even while entering TPM bypass mode). I=
n that case,
> > > > > > > > it seems more appropriate to handle this state in the calle=
r of
> > > > > > > > ima_init(), rather than inside ima_init() itself.
> > > > > > >=20
> > > > > > > If the TPM isn't found at late_initcall_sync(), then IMA shou=
ld go into TPM-
> > > > > > > bypass mode.  Please don't make any other changes to the exis=
ting IMA behavior
> > > > > > > and hide it here behind the late_initcall_sync change.
> > > > > >=20
> > > > > > Okay. you're talking called ima_update_policy_flags() at late_i=
nitcall
> > > > > > wouldn't be not a problem even in case of late_initcall_sync's =
ima_init()
> > > > > > get failed with "TPM-bypass mode".
> > > > > >=20
> > > > > > I see then, I'll make a patch simpler then.
> > > > >=20
> > > > > But I think in case of below situation:
> > > > >  - late_initcall's first ima_init() is deferred.
> > > > >  - late_initcall_sync try again but failed and try again with
> > > > >    CONFIG_IMA_DEFAULT_HASH.
> > > > >=20
> > > > > I would like to sustain init_ima_core to reduce the same code rep=
eat
> > > > > in late_initcall_sync.
> > > >=20
> > > > I think what Mimi's proposing is:
> > > >=20
> > > > If we're in late_initcall, and the TPM isn't available, return
> > > > immediately with an error (the EPROBE_DEFER?), don't do any init.
> > > >=20
> > > > If we're in late_initcall_sync, either we're already initialised, s=
o do
> > > > return and nothing, or run through the entire flow, even if the TPM
> > > > isn't unavailable.
> > > >=20
> > > > So ima_init() just needs to know a) if it's in the sync or non-sync=
 mode
> > > > and b) for the sync mode, if we've already done the init at
> > > > non-sync.
> > >=20
> > > Thanks, Jonathan.  That is exactly what I'm suggesting.  Any other ch=
anges
> > > should not be included in this patch.  Since Yeoreum is not hearing m=
e, feel
> > > free to post a patch.
> >=20
> > I see. so what you need to is this only
> > If it looks good to you. I'll send it at v3.
>=20
> FWIW, I pulled the tpm_default_chip check out a level to account for the=
=20
> extra init you mentioned, and have the following (completely untested or=
=20
> compiled, but gives the approach):

Thanks, Jonathan!  It looks good.  Similarly untested/compiled.

Emitting a message on failure to initialize IMA at late_initcall is good, b=
ut
the attestation service won't know.  Could you somehow differentiate betwee=
n the
late_initcall and late_initcall_sync boot_aggregate records?

Mimi

