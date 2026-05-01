Return-Path: <linux-integrity+bounces-9394-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ICLoIC8H9Gmr9wEAu9opvQ
	(envelope-from <linux-integrity+bounces-9394-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 01 May 2026 03:51:43 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 244B64A9B36
	for <lists+linux-integrity@lfdr.de>; Fri, 01 May 2026 03:51:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4A6503016526
	for <lists+linux-integrity@lfdr.de>; Fri,  1 May 2026 01:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B32AA25F984;
	Fri,  1 May 2026 01:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZPsDB5go"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A9540DFC5;
	Fri,  1 May 2026 01:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777600300; cv=none; b=LZ35SFGoDO4r4UBHgwuqQdxJJYN7198uFRcNgOHuLKhC1xa/9t0xKm4UxLNbBBkhYB+OZkCKB4GmmA+EREH1KQ9P9ZaQiMYO+DitrQpPaYJHTbb+5z0tguMo3QI76UHy9vCjFsiMeOScQL1I56oXyZQ7Z+ajO9iQgtSuhENG6Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777600300; c=relaxed/simple;
	bh=lK8pPbFooQuKJF2LNFeWyb+0ACp8L5ewoP/1vjmWlq0=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=ltoNSmtnqb38K6OLlYg9bhhkKUslHUP2vJ7zAnDoi2sqpft/qXT1CqBoK9dvAwKI3xEnju4PaJ8wxss4HEd0/7yOrEa7aEONajERf2uzS8VsklTTB/Z/dQLg2oqBzDv4Hb7tJMWjkSCExFUbgTVtzSI/IODVdF5N4RmRouU9/VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZPsDB5go; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63UNHI9N3403831;
	Fri, 1 May 2026 01:51:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=pctAgo
	7X9RQj9a/zqNh+bnzttTaEBLL4/27teK03ChE=; b=ZPsDB5gozoNNUJmZR76pNK
	VhWlabDqSQyvCVSDNpT4s9ch2uQXW82wF3kEy77pFvko+JIUlCq5SACYaOH1JD3u
	Gx6eiye6ED/8H6biB015qkiUgoGb23dRbsMnoKVdTuIAdm68IOnh5+M4Q5aLVukZ
	8dlyHFr+8Eb6qosMaHkWQP9k7Pv6T61gp/19r+SOghBFDhfXm/zqOe/uKv98Hds2
	AOawFd0W038O/zvrSgHhVrodEcKe0MCHR1H5pXUkvx9ZLyoK1bWp9+ENA0AkOEgM
	t9+VmnHgmHMjkg/yQxy5SjinbB5jh2eA5xJQyVq7opNpxnKFML1Jwod8BDtP82Lg
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drm1e8y57-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 May 2026 01:51:04 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6411dJYw029174;
	Fri, 1 May 2026 01:51:03 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ds7xqntte-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 May 2026 01:51:03 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6411p2KC38142524
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 1 May 2026 01:51:02 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ABC1858053;
	Fri,  1 May 2026 01:51:02 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7C19458043;
	Fri,  1 May 2026 01:51:00 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.35.95])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  1 May 2026 01:51:00 +0000 (GMT)
Message-ID: <ba4bf28314b679474a6a8da6298e548e54b3754c.camel@linux.ibm.com>
Subject: Re: [PATCH] ima: debugging late_initcall_sync measurements
From: Mimi Zohar <zohar@linux.ibm.com>
To: Paul Moore <paul@paul-moore.com>
Cc: Yeoreum Yun <yeoreum.yun@arm.com>, Jonathan McDowell
 <noodles@earth.li>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.linux.dev, jmorris@namei.org, serge@hallyn.com,
        roberto.sassu@huawei.com, dmitry.kasatkin@gmail.com,
        eric.snowberg@oracle.com, jarkko@kernel.org, jgg@ziepe.ca,
        sudeep.holla@kernel.org, maz@kernel.org, oupton@kernel.org,
        joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com,
        catalin.marinas@arm.com, will@kernel.org, noodles@meta.com,
        sebastianene@google.com
In-Reply-To: <CAHC9VhRsnmPp2KmQAns5uq5qXX5EF2xQQzyfTgrPi4O9AXyPpg@mail.gmail.com>
References: <cover.1777036497.git.noodles@meta.com>
	 <7734099f5e7fda5480bca016a9e6707983325fbd.camel@linux.ibm.com>
	 <afMlgstqahnZg68h@e129823.arm.com>
	 <9f188536f09a2db30877d6bfbb84aeaf2565cccf.camel@linux.ibm.com>
	 <CAHC9VhRsnmPp2KmQAns5uq5qXX5EF2xQQzyfTgrPi4O9AXyPpg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Apr 2026 21:51:00 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: wQfQRKpUY3OQ6rzb7_9sA7HT8Gy0Wcet
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTAxMDAxNSBTYWx0ZWRfX+CCFTEIecljI
 qBcmGjp0BHT61EHAh4Imm+jrh7Ox3VZ5+E3tvkdlAj+3hw400mQr4ggJ+s80f4+i4ckvkyP0WLl
 9Uev4UzpCplVwb2MrmDAnyvfUOpjgjHJR4cGRq6P1wVIT0TN6x/OUzZ5gyZDmmWV/P2Ha3ewoiK
 cFfdAsad08W83aVifg/SN7UmJItYvNSIslB10gPwT0YPEmyUoRcTp5canbDwIlhDj0Mj7C8wVEC
 +l86T1ZnhkluOxjoOHnDI3oVZ7x489qQpA7d1IUvVlRPEL5LEdBf6TKp9KRMmcZY628MuzjsNJP
 PNSXCWb5dwh3K80qJ9C3MblZ/xfzS4YK2DEObUQoV9Zea3pvBB3HY7iaqctEgPb2EHUaiP3IhJd
 aaWlSll2HbYiSKs55H5GD1fV0yD3v0rnvwgxWXQyCiEmcTFEPDRnFZeuxDRa6qGGy0afdnggo7j
 PMtbbpyvnwlSPziAlqw==
X-Authority-Analysis: v=2.4 cv=VZLH+lp9 c=1 sm=1 tr=0 ts=69f40709 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=7CQSdrXTAAAA:8 a=VnNF1IyMAAAA:8 a=-XdNLD7Q-W-cEsWseUgA:9 a=QEXdDO2ut3YA:10
 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-GUID: zdhmN0WO-ojqK2IChMV6ORErdExKpzKo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-30_07,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 spamscore=0 malwarescore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605010015
X-Rspamd-Queue-Id: 244B64A9B36
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-9394-lists,linux-integrity=lfdr.de];
	FREEMAIL_CC(0.00)[arm.com,earth.li,vger.kernel.org,lists.infradead.org,lists.linux.dev,namei.org,hallyn.com,huawei.com,gmail.com,oracle.com,kernel.org,ziepe.ca,meta.com,google.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
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

On Thu, 2026-04-30 at 18:35 -0400, Paul Moore wrote:
> On Thu, Apr 30, 2026 at 5:39=E2=80=AFPM Mimi Zohar <zohar@linux.ibm.com> =
wrote:
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
> > >   10 17ec669c65c401e5e85875cf2962eb7d8c47595f ima-ng sha256:dc6b013e9=
768d9b13bcd6678470448090138ca831f4771a43ce3988d8e54ffce /lib/ld-linux-aarch=
64.so.1
> > >   10 58679a66ac1de17f02595625a8fbeafa259a4c81 ima-ng sha256:494f62bcf=
b2fcf1b427d5092fafa62c8df39a83b4a64402620b28846724f237f /usr/lib/libtirpc.s=
o.3.0.0
> > >   10 42f74ee200434576e33be153830b3d55bbe6d2bf ima-ng sha256:a18856b4f=
6927bc2b8dd4608c0768b8f98544a161b85bf4a64419131243ad300 /lib/libresolv.so.2
> > >   10 626b4f7bd4f123d18d3a3d8719ed0ae19ee5f331 ima-ng sha256:b8d442de5=
d31c3f9d1bbb98785f04d4a23dc53442b286d85d4b355927cbe9af4 /lib/libc.so.6
> > >   10 655a200869696207646377a58cab417fd35b09d2 ima-ng sha256:ad46146b6=
dd32b47213e5327f1bb2f962ef838a4b707ef7445fa2dbc9019b44f /etc/inittab
> > >   10 81353202685e022fcd0069a3b2fc4eaa6b1db537 ima-ng sha256:74d698fe0=
a6862050af29083aa591c960ec1f67be960047e96bb6be5fc2bc0c0 /bin/mount
> > >   10 ae64184ee607ef8f3aa08ab52cb548318534fd4b ima-ng sha256:27846b57e=
8234c6a9611b00351f581a54ad6f9a1920b9aa18ceb0ae28e4f7564 /lib/libmount.so.1.=
1.0
> > >   10 5ea01f34e7705d1bdb936fd576e2aeb5fd78dab9 ima-ng sha256:3d2a414ec=
0355fcf0910224fb4a3c53e13d98731a35241edfdf4fb911ed9b210 /lib/libblkid.so.1.=
1.0
> > >   10 22c48b4853594a08a73ad4ae6dbe6f2c2bebc6c5 ima-ng sha256:e3b0c4429=
8fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855 /run/utmp
> > >   10 3024ea5021f8a5d9fb4bd519d599bdca43b7fb93 ima-ng sha256:71ea9ffe2=
b30e5a9bdceff78785cf281cc41544474db8dc4605a06a597ce1edc /etc/fstab
> > >   10 2e7530a0f56420991ac7611734cea4774b92b9ef ima-ng sha256:df4697d69=
9442cfe73db7cc8b4c1b37e8a31e75e01f66a0d70134ac812fa683b /bin/mkdir
> > >   10 3ad117a863aa1ed7b7c09e1d106f84abf7d2ae96 ima-ng sha256:c19a71098=
9b43222431b02399273dba409fe10ca8eefff88eaa936fa695f8324 /bin/ln
> > >   10 4141c82cb516ac3c846e0b08abcd6abeee7efa1a ima-ng sha256:b75d7f287=
72f71715a941c77e07e3922815391dd9cc5718ad21f2231c2da09bb /etc/hostname
> > >   10 dfcedd3c7dc3ed42e09219804504489ab264e2e3 ima-ng sha256:dc1615df9=
f2012b20b81ffad8e07e16293039ba7fd897854ca3646d6cfea0c0f /etc/init.d/rcS
> > >   ...
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
>=20
> Is it not possible to look at the code and determine if it is safe or
> not?  Or is the initialization of TPM devices at boot done in a random
> order with respect to the initcall levels?

The TPM is normally initialized at the device_initcall, except when other
resources are not ready.

(Abbreviated) AI explanation:
   If the TPM's first probe succeeds at device_initcall with no deferral, I=
MA
   finds it fine. It is only when the TPM is pushed onto the deferred list =
that
   late_initcall can execute before the retry succeeds, leaving
   tpm_default_chip() returning NULL.
  =20
   Recall that the kernel schedules a final deferred probe flush as its own
   late_initcall:
  =20
   This means the TPM retry and IMA init are both late_initcall, and their
   relative order is determined by link order =E2=80=94 which is not guaran=
teed to put
   the deferred probe flush before ima_init. If ima_init happens to run bef=
ore
   deferred_probe_initcall, and the TPM is on the deferred list, IMA will e=
nter
   bypass mode even though the TPM is about to successfully probe moments l=
ater.
   This is the precise and subtle nature of the race.


Mimi





