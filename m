Return-Path: <linux-integrity+bounces-9404-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kEjSBH4z92mWdQIAu9opvQ
	(envelope-from <linux-integrity+bounces-9404-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Sun, 03 May 2026 13:37:34 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B0FF64B54F9
	for <lists+linux-integrity@lfdr.de>; Sun, 03 May 2026 13:37:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 42D1D30053FE
	for <lists+linux-integrity@lfdr.de>; Sun,  3 May 2026 11:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84ECD3081D7;
	Sun,  3 May 2026 11:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gLU4/IMN"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451844414;
	Sun,  3 May 2026 11:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777808250; cv=none; b=ttg0zLhBs44mJ8irZ0ybhdcFTas+I7QwAaVumxtGKF+2fc06nE+fvnsaBkNXAsXc75hcjuaLZbkcG+TZa35sXhVb58sWHi9EYAWkzsfRk0aNrMDtjtAr6JGJatTKdj5+w4l9rKxgA+trKURlXFLStvaeQ3qyUGtZCTQWZM5NyoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777808250; c=relaxed/simple;
	bh=FdLxzGDy7JZtBSiLYjxjsctpfnT11xkjS7XHOXVyR6M=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=AMLdzV3Y5CHzZqoD16KPLB7D/RCcYfO8+sVdX31kbtPrbgRxtbktuMBeAD8FVzOiSM+VmnOhv+FuuSfcdA4LuE2oTD4Jze2KNLiQdth+kkVpk8IOGzmxUPEXxYj/NByQPBHhgmtA4qS4/WFNb4E70LiLGB/DjqnnhLvSHGPqrGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gLU4/IMN; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6435qZtq755481;
	Sun, 3 May 2026 11:36:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=JeO9wp
	JmE2rZ4RmHVIraoaQUKxeV+2cdGG9sRb8QKPk=; b=gLU4/IMNiuNZiXIdXT6BrU
	JaO28btmajScC6x+90eRjEKWFv2bGhKX3ADZ9GXGTPJKAsJDuvrPdSkxCCXgRu65
	cjonIBFxNrcutM9K/RbIls2TTkDN83Mp46AuSfMArtqDVxKNp4iVEhNsL/41nBHP
	JJtC1V+L8F9cIb1x4LjCp3P7zjQWCTJ9x7PTYPHCpbdosNtRDX5cukyRIEjJM1RK
	RWzXs+VXY8NprHV/MY3lSfQ3IYXzWYfg6m/0UJoYtzYqrH2VIERjP22Lo5i9Bl1j
	CIwPTVLPm9VOlNTbbpTrA66nXRfV+dRW0nMrCEt8ssfND5HGDgnd8LLLQQvQMuAw
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9y13js7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 03 May 2026 11:36:54 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 643BOhpg001570;
	Sun, 3 May 2026 11:36:53 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dww3gs8pd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 03 May 2026 11:36:53 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 643BaqjJ29819590
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 3 May 2026 11:36:52 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 872DD58056;
	Sun,  3 May 2026 11:36:52 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E458358052;
	Sun,  3 May 2026 11:36:50 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.175.251])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Sun,  3 May 2026 11:36:50 +0000 (GMT)
Message-ID: <202f90682fe47bb5fb9b08f8678ae00981b5290b.camel@linux.ibm.com>
Subject: Re: [PATCH] ima: debugging late_initcall_sync measurements
From: Mimi Zohar <zohar@linux.ibm.com>
To: David Safford <david.safford@gmail.com>
Cc: Yeoreum Yun <yeoreum.yun@arm.com>, Jonathan McDowell
 <noodles@earth.li>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.linux.dev, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, roberto.sassu@huawei.com, dmitry.kasatkin@gmail.com,
        eric.snowberg@oracle.com, jarkko@kernel.org, jgg@ziepe.ca,
        sudeep.holla@kernel.org, maz@kernel.org, oupton@kernel.org,
        joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com,
        catalin.marinas@arm.com, will@kernel.org, noodles@meta.com,
        sebastianene@google.com
In-Reply-To: <CAGWfHUW+AX0Hpuw5Vr5iTSaJKQJ+O_4nWWmU1UR8Z_3XFctHZg@mail.gmail.com>
References: <cover.1777036497.git.noodles@meta.com>
	 <7734099f5e7fda5480bca016a9e6707983325fbd.camel@linux.ibm.com>
	 <afMlgstqahnZg68h@e129823.arm.com>
	 <9f188536f09a2db30877d6bfbb84aeaf2565cccf.camel@linux.ibm.com>
	 <CAGWfHUW+AX0Hpuw5Vr5iTSaJKQJ+O_4nWWmU1UR8Z_3XFctHZg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 03 May 2026 07:36:50 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: dQ6vNqDViTXOrTVmMehSPZgNp19xmol0
X-Proofpoint-GUID: ZCj7tR0wUAnHWdtxqY_YPlVBcCiYYGZs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTAzMDEyOCBTYWx0ZWRfXw4m7oZKWaAIF
 ifiZrDuRr5g5w9OQ3dKqUPFxaE+PrQoh2Tl3K5l+inyzb57uROLOeSXWFScTmt8pwHy99iXXoDI
 h+Ct4+sFVA64w7nz3TOelolobRZmAr5IPaRBaY9q536/7+wRqDFsNRpnjV9VfsJCHLVpG+7sDD2
 Fn+ucRtSt8BY6vPP03HKt1z9x7YWQUyAbY5Oa3msTtAvqFg+I9h0M7dshE4g2OcyWxrx55RaBNO
 VnHfk3UkqRFPMBc5FKj1Ic5d0Hwe0NcpIgga48JaeavaWD/6q4p7H5tQk2HvmU9u7wvEaCH4LDQ
 G/LxM+/E6fvpnrLVwTaPwONudHvEgf5lPFBgCDob/bfZc48kVjiH9mtFajzpAb6DX9iZ4dvGe6L
 ChVaABPYDW9BKWkCDTmvg1iEUR/lSAk5hw7C3/B/tdPWvEsh8VtFM4haHIC56XFWKCS4h3Aw5F1
 w2m3p+ZAsJnwtOQho6A==
X-Authority-Analysis: v=2.4 cv=UbFhjqSN c=1 sm=1 tr=0 ts=69f73357 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=7CQSdrXTAAAA:8 a=VnNF1IyMAAAA:8 a=wjnevlr4pEST-T4ujgEA:9 a=QEXdDO2ut3YA:10
 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-03_04,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0
 adultscore=0 priorityscore=1501 bulkscore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605030128
X-Rspamd-Queue-Id: B0FF64B54F9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9404-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[arm.com,earth.li,vger.kernel.org,lists.infradead.org,lists.linux.dev,paul-moore.com,namei.org,hallyn.com,huawei.com,gmail.com,oracle.com,kernel.org,ziepe.ca,meta.com,google.com];
	RCPT_COUNT_TWELVE(0.00)[26];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zohar@linux.ibm.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-integrity];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[11]

On Fri, 2026-05-01 at 12:52 -0400, David Safford wrote:
> On Thu, Apr 30, 2026 at 5:43=E2=80=AFPM Mimi Zohar <zohar@linux.ibm.com> =
wrote:
> >=20
> > On Thu, 2026-04-30 at 10:48 +0100, Yeoreum Yun wrote:
> > > With above change I confirmed there is no meaurement log
> > > between boot_aggregate and boot_aggregate_late except "kernel_version=
"
> > > But this is ignorable since this UTS measurement is done in
> > > "ima_init_core() (old: ima_init())" and it is part of ima initialisat=
ion.
> > >=20
> > > 1. ima_policy=3Dtcb
> > >=20
> > >   # cat /sys/kernel/security/ima/ascii_runtime_measurements
> > >   10 0adefe762c149c7cec19da62f0da1297fcfbffff ima-ng sha256:000000000=
0000000000000000000000000000000000000000000000000000000 boot_aggregate
> > >   10 4e5d73ebadfd8f850cb93ce4de755ba148a9a7d5 ima-ng sha256:000000000=
0000000000000000000000000000000000000000000000000000000 boot_aggregate_late
> > >   10 7c23cc970eceec906f7a41bc2fbde770d7092209 ima-ng sha256:72ade6ae3=
d35cfe5ede7a77b1c0ed1d1782a899445fdcb219c0e994a084a70d5 /bin/busybox
> snip
> > >=20
> > > 2. ima_policy=3Dcritical_data
> > >=20
> > >   # cat /sys/kernel/security/ima/ascii_runtime_measurements
> > >   10 0adefe762c149c7cec19da62f0da1297fcfbffff ima-ng sha256:000000000=
0000000000000000000000000000000000000000000000000000000 boot_aggregate
> > >   10 49ab61dd97ea2f759edcb6c6a3387ac67f0aa576 ima-buf sha256:0c907aab=
3261194f16b0c2a422a82f145bc9b9ecb8fdb633fa43e3e5379f0af2 kernel_version 372=
e312e302d7263312b // Ignorable since it's generated by ima_init(_core)().
> > >   10 4e5d73ebadfd8f850cb93ce4de755ba148a9a7d5 ima-ng sha256:000000000=
0000000000000000000000000000000000000000000000000000000 boot_aggregate_late
> > >=20
> > > Therefore, init_ima() could move into late_initcall_sync like v1 did:
> > >   - https://lore.kernel.org/all/20260417175759.3191279-2-yeoreum.yun@=
arm.com/
> >=20
> > Thanks, Yeoreum.  It's a bit premature to claim it's "safe" to move the
> > initcall.  Hopefully others will respond.
> >=20
> > Mimi
>=20
> I have also run with this patch on a number of bare metal and virtual mac=
hines,
> running everything from default Fedora 44 to a version with everything tu=
rned on
> (uefi secure boot, UKI with sdboot stub measurements, IMA measurement
> and appraisal enabled,
> all systemd measurements on, and systemd using the TPM for root
> partition decryption.)
> I too see only the kernel_version event between the normal and late
> calls, if ima_policy=3Dcritical_data.

Thanks, Dave!  Were all the systems you tested x86_64?  The next step would=
 be
to test on different arch's (e.g. Z, Power).

Mimi

