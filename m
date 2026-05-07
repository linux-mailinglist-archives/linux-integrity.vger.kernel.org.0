Return-Path: <linux-integrity+bounces-9483-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kF+CKUEG/WklWwAAu9opvQ
	(envelope-from <linux-integrity+bounces-9483-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Thu, 07 May 2026 23:38:09 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 116014EF63D
	for <lists+linux-integrity@lfdr.de>; Thu, 07 May 2026 23:38:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5D193303D70D
	for <lists+linux-integrity@lfdr.de>; Thu,  7 May 2026 21:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2CF7345CA1;
	Thu,  7 May 2026 21:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TyM6Vc0l"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1777234028D;
	Thu,  7 May 2026 21:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778189843; cv=none; b=OtVKvCc8db4phw5T2zGAfgaZDXmEne5kNlf/SPccinRFI3fKBt9DLCYcDn3BvlF7fIPLLZGwrQElkZXPm3hHNa5XCX33j5BurWSdLLHvEtSBVECII2XxpPqzU3zX3/XLn2Xe3LXUqmwWIUCNqF708BSQQ9d06fycuPzEMEuR5zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778189843; c=relaxed/simple;
	bh=3yUWcF8lCFSKPysH0hLsgTmlBa0eNE+fBEArMYmvbs8=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=VgyOkwZyrN9vCAA2N2owFqIvG02VXL1U+ed5Ji0vz2aynYCAq/61EpE6eBw3g3g9cfYmNeobOmV+Ii/st3Lo1an05cjNQIDeL/6HnfjhG6PYXt5FFaFWZk+3IvGS5f1HaeaMngEn0BpYoOjqgmSRoIZfRhI9LDqkuGAkMFUWhUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=TyM6Vc0l; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 647KMarc3638747;
	Thu, 7 May 2026 21:36:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=KJM9TL
	n9BeKUTNdkhmF9S0zsfmt7CGWlFQsmNxoDr7E=; b=TyM6Vc0lQLk3V+jtdoOMGY
	HeRAevekcVjywfqNqcACF/0A2GVRWOHD6AF/b6CeH2CCi6FmH+hOUaHYkLEpt6FS
	MqLLhFZ/+7WLZDQK35V2fd1K//UQaRBVnYuxnNOnWuRdm9Ba35a7N9/BbaiaLXef
	ZPTpTVEFuSmZ1yTzLf/ZJ02ID4BitxHuUxZklHICWMCu5MrPdf66qkPYpI2krFOx
	Tz89TQF/vrFBWCPivLlIOf1jgnirkpi3RDFZp7SXOpxB8+jg9ewefzrd0Ro87sRu
	1hHWKLY5SxB0lIPrMWamynn+MVpOEuQfJhrgicIRNYSm7Q4n/oHkMj/TWbUxMMuA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9xxysmx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 May 2026 21:36:56 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 647LOT0A008352;
	Thu, 7 May 2026 21:36:55 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dwuywdqsd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 May 2026 21:36:55 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 647LataR15139384
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 7 May 2026 21:36:55 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EFD2358054;
	Thu,  7 May 2026 21:36:54 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C0F3A5805D;
	Thu,  7 May 2026 21:36:52 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.31.96.173])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  7 May 2026 21:36:52 +0000 (GMT)
Message-ID: <77ad49cca1acf707f4152ed3e2066b2f24c90c16.camel@linux.ibm.com>
Subject: Re: [PATCH] ima: debugging late_initcall_sync measurements
From: Mimi Zohar <zohar@linux.ibm.com>
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: David Safford <david.safford@gmail.com>,
        Jonathan McDowell	
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
In-Reply-To: <afzwJn+5r15jFxrB@e129823.arm.com>
References: 
	<CAGWfHUW+AX0Hpuw5Vr5iTSaJKQJ+O_4nWWmU1UR8Z_3XFctHZg@mail.gmail.com>
	 <202f90682fe47bb5fb9b08f8678ae00981b5290b.camel@linux.ibm.com>
	 <201b9172ac47c6766443c1f2343cab3548f33c29.camel@linux.ibm.com>
	 <afrXmRiq7XvSe6yN@e129823.arm.com>
	 <9ff4853a8e9932b3a1424f2a6c3347f1723fb5f4.camel@linux.ibm.com>
	 <aftIuPwNeuzc9nY1@e129823.arm.com>
	 <9d1af933ef218b159762884357d127e3644dfe2c.camel@linux.ibm.com>
	 <afwoDgaJxmKwOhXp@e129823.arm.com>
	 <f19081f1eda19d6d1ae133d8ec93e779ab1a25e5.camel@linux.ibm.com>
	 <afyIbW5cljh5ZvTL@e129823.arm.com> <afzwJn+5r15jFxrB@e129823.arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 07 May 2026 17:36:52 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDIxOSBTYWx0ZWRfX7UAVzMXbx+Nk
 nVh3FWtWuc6MCAxEiV1665w86JzzPEc8F120eX6LUl0F61duh2JqZEiBGWfHnGTBV3VW5zIL5gq
 MXib4D4WCOhdu+SQJaOXsri1kLRaT/AFb35L91VEZPF6UaBuQ8RVIFcb1SDtpJyPcEWZv0P1pR2
 oKQaKSmOZFBQgvuSN4lZPhC3+tnTgBX32q9iXljc/ksea6ZkyK/JRPK+nu8RxzyuTcuaAnUAvdN
 t1RU9wVuEuNui8Tg6eX8wdqa0tJ1jgnFajL3AuYMvGGuLADEIP1O/hJacJhyrlMlsRGiR93zLeM
 VM/ntbEeO3NqAvpe3Kql04KIVZiYk9LtMbQ8qAi9juNFgtkAWB8ZnIJNy+rTOSufG0LU/dQhD6g
 cvoSjusLCDuiMWAJjQkQDjqhVPSLnf/K37mgjljO2oxRx90WI/anGrFdb0ta76RygfD3eZ9d5ah
 Wx0kFvGJyieO5UdqOaw==
X-Proofpoint-ORIG-GUID: xworJu3D8CL84380WFdO41WlLtGr9kbt
X-Proofpoint-GUID: SMKawSpR4EXvZ0yXw5eFm2rKTqvybguf
X-Authority-Analysis: v=2.4 cv=ctWrVV4i c=1 sm=1 tr=0 ts=69fd05f8 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=0JQgvdOVZOPKDJRDZfoA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 clxscore=1015
 suspectscore=0 impostorscore=0 spamscore=0 malwarescore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605070219
X-Rspamd-Queue-Id: 116014EF63D
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
	TAGGED_FROM(0.00)[bounces-9483-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,earth.li,vger.kernel.org,lists.infradead.org,lists.linux.dev,paul-moore.com,namei.org,hallyn.com,huawei.com,oracle.com,kernel.org,ziepe.ca,arm.com,meta.com,google.com];
	RCPT_COUNT_TWELVE(0.00)[26];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.ibm.com:mid];
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
X-Rspamd-Action: no action

On Thu, 2026-05-07 at 21:03 +0100, Yeoreum Yun wrote:
> Hi Mimi,
>=20
> >=20
> > > On Thu, 2026-05-07 at 06:50 +0100, Yeoreum Yun wrote:
> > > > Hi Mimi,
> > > >=20
> > > > > On Wed, 2026-05-06 at 14:57 +0100, Yeoreum Yun wrote:
> > > > > > > > > On both Z and PowerVM, there are ~30 measurements between=
 boot_aggregate and
> > > > > > > > > boot_aggregate_late.  For example, on PowerVM:
> > > > > > > > >=20
> > > > > > > > > # grep -n boot_aggregate
> > > > > > > > > /sys/kernel/security/integrity/ima/ascii_runtime_measurem=
ents
> > > > > > > > >=20
> > > > > > > > > 1:10 f60a05d7354fb34aabc02965216abd3428ea52bb ima-sig
> > > > > > > > > sha256:9887dd089ee19a6517bca10580b02c1bb9aa6cd86c157b6ead=
8a1c0403f348d5
> > > > > > > > > boot_aggregate=20
> > > > > > > > > 31:10 e2592b0d61da6300d3db447b143897a9792231ea ima-sig
> > > > > > > > > sha256:9887dd089ee19a6517bca10580b02c1bb9aa6cd86c157b6ead=
8a1c0403f348d5
> > > > > > > > > boot_aggregate_late
> > > > > > > > >=20
> > > > > > > > > It would be interesting to the results from a Raspberry P=
i 5 as well,
> > > > > > > > > with/without a TPM.
> > > > > > > >=20
> > > > > > > > Honestly, I find this result hard to accept.
> > > > > > > >=20
> > > > > > > > This effectively means that there is code invoking IMA meas=
urement during late_initcall().
> > > > > > > > It also implies that if, in the future, a late_initcall is =
added that performs
> > > > > > > > an IMA measurement before IMA initialization has occurred a=
ccoding to order by linker,
> > > > > > > > that measurement could be missed.
> > > > > > >=20
> > > > > > > Exactly.  The results are simply from booting with the builti=
n "tcb" and
> > > > > > > "critical_data" policies.
> > > > > > >=20
> > > > > > > $ sudo grubby --args=3D"ima_policy=3D\"tcb|critical_data\"" -=
-update-kernel
> > > > > > > /boot/vmlinuz-${SUFFIX}
> > > > > >=20
> > > > > > Thanks. but I still wonder what meaasurements there are between
> > > > > > boot_aggregate and boot_aggregate_late.
> > > > > > Might be there would be key measurements if it takes more than
> > > > > > 5 mins before generating boot_aggregate_late but this seems rar=
e.
> > > > > >=20
> > > > > > If you don't mind, would you share the contents of the log betw=
een
> > > > > > boot_aggregate and boot_aggregate_late?
> > > > > > since I only get a kernel_version in my environment.
> > > > >=20
> > > > >      1	10 f60a05d7354fb34aabc02965216abd3428ea52bb ima-sig
> > > > > sha256:9887dd089ee19a6517bca10580b02c1bb9aa6cd86c157b6ead8a1c0403=
f348d5
> > > > > boot_aggregate=20
> > > > >      2	10 49ab61dd97ea2f759edcb6c6a3387ac67f0aa576 ima-buf
> > > > > sha256:0c907aab3261194f16b0c2a422a82f145bc9b9ecb8fdb633fa43e3e537=
9f0af2
> > > > > kernel_version 372e312e302d7263312b
> > > > >      3	10 92c40bfd65512d5224cddb9fb64fef0d72e1c182 ima-sig
> > > > > sha256:412bae0d0e85a99971d6eda198dd2fed3c2959715e8a17a4caddc7bc60=
5bdeeb
> > > > > /usr/bin/kmod=20
> > > > >      4	10 a18f997e1e82d0ef416f93683966d7dda875d71c ima-sig
> > > > > sha256:0050fcc672e03cfdc3a50c771ca9f5219478e5538980a26fd448462071=
2d8163
> > > > > /usr/lib64/ld64.so.2=20
> > > > >      5	10 88f343618caeeed92ed8281d627f4565b0499d66 ima-sig
> > > > > sha256:a0e83c084d8c227f1150a8cd94eece61f62bc1da30f98d1cf57ca7db24=
1a9c45
> > > > > /etc/ld.so.cache=20
> > > > >      6	10 e047868f01908eb95aa180693291decab82bb6be ima-sig
> > > > > sha256:42ebf9cc684419de4d8a1d624102716d88fbcf957f47e50a9a08e38b33=
8023ac
> > > > > /usr/lib64/libzstd.so.1.5.5=20
> > > > >      7	10 da069bc6a44d454510a76c69d3a54c3b238ae27e ima-sig
> > > > > sha256:9b7c788e75c16c8827062016cf15826e43661c4b5b56813ea07ff2635b=
ea2710
> > > > > /usr/lib64/liblzma.so.5.6.2=20
> > > > >      8	10 7ade414e736e7b449cda5ec5e0277b99548e89c6 ima-sig
> > > > > sha256:d899452e8e6369e436ba1a565833d6dcf0d09c35e40ffc0979cf4de2bd=
b8f421
> > > > > /usr/lib64/libz.so.1.3.1.zlib-ng=20
> > > > >      9	10 9a9da8326f36237a47d6ed21bdffd0e1ff855e2a ima-sig
> > > > > sha256:a848f396db7ad135f851b5e9aeb32f4a3ef1439c7913b9b95ab1cda692=
51f6ad
> > > > > /usr/lib64/libcrypto.so.3.5.1=20
> > > > >     10	10 3201d27cd4028f02fc9088ec33e2d0ceb72d2c5b ima-sig
> > > > > sha256:e52dcd1850555c08d60fefe56694c1179b4eaa5796db0907606552ece8=
e1bab1
> > > > > /usr/lib64/libgcc_s-14-20250617.so.1=20
> > > > >     11	10 3b4c6f13e52ca060b290709f737b1ff66564226f ima-sig
> > > > > sha256:f2a900a5b980b289dc028dd3caab16b1b0ad037f2e875546bb3197d23f=
f241f0
> > > > > /usr/lib64/glibc-hwcaps/power10/libc.so.6=20
> > > > >     12	10 b23b616cbd3c9dc4c5743d121c1c5a702b461a9c ima-sig
> > > > > sha256:5a682022beeea9ee7f36a70f0465942bf32e9675d3f45355088e148787=
e02175
> > > > > /usr/lib/modprobe.d/dist-alsa.conf=20
> > > > >     13	10 aec07fad18697f295d7e06796fc8dfd3b472f9c3 ima-sig
> > > > > sha256:067d949bab3bb085d0936031881ff73b2ab39f34b9a90cbd01396d1987=
ff6658
> > > > > /usr/lib/modprobe.d/dist-blacklist.conf=20
> > > > >     14	10 c402c56b66e65914148efd6e3cf0b1d616daabe6 ima-sig
> > > > > sha256:120a02e9b88ba74949224eca7385825e39880f5687f739ade07d94ee22=
ffe325
> > > > > /etc/modprobe.d/firewalld-sysctls.conf=20
> > > > >     15	10 e358ca12bd58e1ce4845e299e1aea8b81edf86f9 ima-sig
> > > > > sha256:fa27abcd357a16ee1254ba38d1225b7f0724036c07ce3d0e83b29eb72d=
97c419
> > > > > /etc/modprobe.d/l2tp_eth-blacklist.conf=20
> > > > >     16	10 4b036d41435d7df3a72b38880f5fe231904b7b66 ima-sig
> > > > > sha256:ecf5f948bfbfb726879a910b3174d139c8af6b1745c88dcc1e4a1cf532=
c02299
> > > > > /etc/modprobe.d/l2tp_ip-blacklist.conf=20
> > > > >     17	10 9c53a7a48c1b5218417c4f25c4a34c09a9f39830 ima-sig
> > > > > sha256:f76c4ac232d5e96c57961a9f10194703b4df6d119530046f0b23eee70b=
fcb089
> > > > > /etc/modprobe.d/l2tp_ip6-blacklist.conf=20
> > > > >     18	10 6c41d7b7d251c400b7e0ba76f7b386a746e8f4ec ima-sig
> > > > > sha256:5cbc958f893a599ef19437014696dd7b112cf9af6a4348830177f8a8f7=
8aa1b3
> > > > > /etc/modprobe.d/l2tp_netlink-blacklist.conf=20
> > > > >     19	10 f37ef48faef5bc51e29d47531726af0bd0654655 ima-sig
> > > > > sha256:7a3d63acb49e4a69b482f26624761b5778fbd6b77be8a3f36926b379b5=
f965ed
> > > > > /etc/modprobe.d/l2tp_ppp-blacklist.conf=20
> > > > >     20	10 82ef59779acdfd6e9b35521bfa09e6ba86fd6174 ima-sig
> > > > > sha256:6a8f2009d87deba7a2de46e3d0c46b114fe388d188b00b9a382fc2156a=
abb676
> > > > > /usr/lib/modules/7.1.0-rc1+/modules.softdep=20
> > > > >     21	10 6ae994e33a6313ab4535da90f5cb6c3beaec7b86 ima-sig
> > > > > sha256:268695dbf23bd0170ec9a95b10e8d596205fd7436617d10101907171bf=
004b7c
> > > > > /etc/modprobe.d/sctp-blacklist.conf=20
> > > > >     22	10 b2c238ae66b03f56191d9955a5ad0f3110bb7e2b ima-sig
> > > > > sha256:64a8ebb0a1fd712a9aeb7aa0f0ad0b72d3277034c8bfa3b66ab063e201=
d6527e
> > > > > /etc/modprobe.d/sctp_diag-blacklist.conf=20
> > > > >     23	10 c0443f2d3c078959ae86276df23abe172234a55d ima-sig
> > > > > sha256:e5a3958cbd3684b63f3cada6604469cc56f727b106d5524daf5aefa693=
5a48ce
> > > > > /usr/lib/modprobe.d/systemd.conf=20
> > > > >     24	10 5c46e012bc7fffc3256b166282a7eaa4bea5fa33 ima-sig
> > > > > sha256:6560abcdd2cdb41e1d0fe73052298d612920d5bccb4a3a7c82bc738951=
28e760
> > > > > /etc/modprobe.d/tipc_diag-blacklist.conf=20
> > > > >     25	10 d5fb1836364732fbc4f87aa7d2c984cf30bdbfd3 ima-sig
> > > > > sha256:358703c09ac2d2c653e11bbc7c65d378c8496e87ca47307f86c36b0b29=
640598
> > > > > /etc/modprobe.d/tuned.conf=20
> > > > >     26	10 a85107163729f696f316d46c0bf3f65f713ba972 ima-sig
> > > > > sha256:7410bb4cec56892e8b0010c5c8b72be532784ccf0240aa0677c5be085a=
530f65
> > > > > /usr/lib/modules/7.1.0-rc1+/modules.dep.bin=20
> > > > >     27	10 80eb261ffb2cc3528d90c33b1c624f657a045867 ima-sig
> > > > > sha256:856e0f083226f8b4fb7d1d71447fb841dae18ea9a50ea6d8505a206167=
288e1d
> > > > > /usr/lib/modules/7.1.0-rc1+/modules.alias.bin=20
> > > > >     28	10 6af2d661da470d7a1c9909ddbc074d3d265eb1d7 ima-sig
> > > > > sha256:4853ca200598c52970c380fda99484068e7db4961a4f94faac6abcfbbd=
52d150
> > > > > /usr/lib/modules/7.1.0-rc1+/modules.symbols.bin=20
> > > > >     29	10 6f9cd405bd57d925baae6ae66c273c61c90b3bc8 ima-sig
> > > > > sha256:193d1e1004848f7d391877507b69a7953e1f94ddbe70eb0e2cf6dc45fc=
e7cd6a
> > > > > /usr/lib/modules/7.1.0-rc1+/modules.builtin.alias.bin=20
> > > > >     30	10 4e20b980bf3a825a866be0c46033ed654df4aeba ima-sig
> > > > > sha256:3a0e3c56d51ba98258ff13f93f82c837de22f4b707d24678f82893babf=
4d77ea
> > > > > /usr/lib/modules/7.1.0-rc1+/modules.builtin.bin=20
> > > > >     31	10 e2592b0d61da6300d3db447b143897a9792231ea ima-sig
> > > > > sha256:9887dd089ee19a6517bca10580b02c1bb9aa6cd86c157b6ead8a1c0403=
f348d5
> > > > > boot_aggregate_late=20
> > > > >     32	10 81830cd3d799e006698258dc1b11fe29a56eeef5 ima-sig
> > > > > sha256:d1651dc50bb5b92c1badcab9aa4dbbca40cb704cdc707d1c536b41d7b1=
aa465e
> > > > > /usr/lib/systemd/systemd=20
> > > >=20
> > > > Hmm... Theses measurements seems to happen while populating
> > > > initramfs which triggers file_post_open as async
> > > > (and I see the RAMFS seems not part of DONT_MEASURE in IMA).
> > > >=20
> > > > If you don't mind, Could you check whether this measurements still
> > > > happen with initramfs_async=3D0?
> > > >=20
> > > > If this measurements aren't generated with above option,
> > > > there is a question whether let IMA measure initramfs which can be
> > > > measured or not depending on boot option or timing (some file measu=
rements
> > > > could be lost all when do_populate_rootfs() executes concurrently w=
hile
> > > > running late_initcall).
> > >=20
> > > There's no difference when adding the "initramfs_async=3D0" boot comm=
and line
> > > argument. The measurement list between boot_aggregate and boot_aggreg=
ate_late is
> > > exactly the same.
> > >=20
> >=20
> > That's quite interesting. This means there're some file operation
> > between late_initcall and late_initcall_sync
> > even before run_init_process() except initramfs population.
> >=20
> > Since initramfs population flush all fputs() it generates and
> > boot_aggregate_late is generated before init process is loaded,
> > I honestly have no idea who triggers above file operations.
> >=20
> > And it seems a little bit weird that it opens the /usr/bin/kmod
> > and its configuration from kernel not by init_process or other user
> > process...
> >=20
>=20
> If you don't mind, Could i get some stacktrace for one of file measuremen=
t log
> between boot_aggregate and boot_aggreate_late?
>=20
> Though I try to produce like you, I've gotten failure to reproduce.
> Sorry to bother you. but it would be helpful to understand where they
> came from.

The kernel selftests caused the measurements between late_initcall and
late_initcall_sync.  After disabling all of the kernel selftests, there wer=
en't
any measurements. Re-enabling the FIPS selftests on PowerVM LPAR resulted i=
n
measurements.  (I didn't try re-enabling any of the other selftests.)

CONFIG_FIPS_SIGNATURE_SELFTEST=3Dy
CONFIG_FIPS_SIGNATURE_SELFTEST_RSA=3Dy
CONFIG_FIPS_SIGNATURE_SELFTEST_ECDSA=3Dy

Mimi

