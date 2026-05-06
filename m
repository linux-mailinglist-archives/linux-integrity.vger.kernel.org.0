Return-Path: <linux-integrity+bounces-9470-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kFGqAMIq+2lAXAMAu9opvQ
	(envelope-from <linux-integrity+bounces-9470-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Wed, 06 May 2026 13:49:22 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 70AA64D9DBF
	for <lists+linux-integrity@lfdr.de>; Wed, 06 May 2026 13:49:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BBAC8301E6D7
	for <lists+linux-integrity@lfdr.de>; Wed,  6 May 2026 11:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1099A3368B7;
	Wed,  6 May 2026 11:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TbB5uinX"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B511C3368A9;
	Wed,  6 May 2026 11:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778068091; cv=none; b=JH2CW4NdD1agRDbbPkl6djO7jkF8gSqKLrQrHtvzXHFybbqrq2e5eI6Y9ATQIBFgQcP+yv0zs5kDJd73R0TNlHyH+gPKrZfaC9Q9RBxDCkHpXLyQRLa86AzY32Bcs9i7Jjz91ZchnlawVq1sVcLFQcip1CnMIoHA2wr+BmrFQB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778068091; c=relaxed/simple;
	bh=ps/92ifstO8ZBnlDJYFeF8f0YhF5CQXvzvHo4JglspU=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=T3Q61ky79bO6NruhYMV5XSmsl0bNUFzo3fA/3pwMJscLkx5FI3L7255vLeqbH4wa0gQ5e8sMnxTaiMP/ClHcu7rlwxNtDUVTAmjnB0EuaVvxS9NYOZERfyq+blf55pxyP8SHDcxJtuOmrmNbUXy77kxob9swmQhYWH5OnyAs7Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=TbB5uinX; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6465XHDN1385448;
	Wed, 6 May 2026 11:47:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=CoZuVG
	MzrLKqPde8Gc9GLmVdmA+y/Ik+9dvrqcNrnBw=; b=TbB5uinXdty9XaiN6bMvAt
	KHlS5Qiu7HF/X2dDIMDsXCxbXLgCri+Lxg6s1p97tZEFYQBlHOWZJBLU9W7Q0kv/
	JP2y8I0UczGu89H1fUULS7mDwrxKPwrWhZLGNELW0vTBS6CkDFfnbzVtzrckUD0d
	oqDew4ZnY3RoeS4oMlam/cu7TtjXx2e7doIKPhGB/8UOXXn/Xui5IHpKhlkbhpkV
	BNcyeSJDkY9EwBsabry4a6VM5C4Psb1Gli1J/nPCUyEoN+8biH21f5j3RyjH7Ol7
	my3evYM96gZIJOwmqJPQRIdiidigJIfehpNMMoxh1/wo4Hv5s8ycEQ/yHaTvPLPw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9x4rc09-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 May 2026 11:47:46 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 646BdZuP004811;
	Wed, 6 May 2026 11:47:44 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dwuyw63vc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 May 2026 11:47:44 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 646BlGTw9830974
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 6 May 2026 11:47:16 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1158B5805F;
	Wed,  6 May 2026 11:47:44 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9F59F58051;
	Wed,  6 May 2026 11:47:42 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.187.213])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  6 May 2026 11:47:42 +0000 (GMT)
Message-ID: <9ff4853a8e9932b3a1424f2a6c3347f1723fb5f4.camel@linux.ibm.com>
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
In-Reply-To: <afrXmRiq7XvSe6yN@e129823.arm.com>
References: <cover.1777036497.git.noodles@meta.com>
	 <7734099f5e7fda5480bca016a9e6707983325fbd.camel@linux.ibm.com>
	 <afMlgstqahnZg68h@e129823.arm.com>
	 <9f188536f09a2db30877d6bfbb84aeaf2565cccf.camel@linux.ibm.com>
	 <CAGWfHUW+AX0Hpuw5Vr5iTSaJKQJ+O_4nWWmU1UR8Z_3XFctHZg@mail.gmail.com>
	 <202f90682fe47bb5fb9b08f8678ae00981b5290b.camel@linux.ibm.com>
	 <201b9172ac47c6766443c1f2343cab3548f33c29.camel@linux.ibm.com>
	 <afrXmRiq7XvSe6yN@e129823.arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 06 May 2026 07:47:42 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA2MDExNCBTYWx0ZWRfXxvIr9kK7Z5Ca
 YVY8N0eesJnNiFb4FtL5ir7Z4DK0QkF/UHY8jB1hjIVr393tcRP1ujEG8S4xPq+MibIlJjjRlPI
 4p/9oB1Ppja5wDoiQEo9XCVgOUYZkS5gmcscaDACqLmjNzIto+777KIaD0d7Tchd0Ok4FsLKTpI
 5M1pXNsjk/0rf+KHwEvPxw3Lqp0U6B7DxWczQE/XiRwzB1y+LvUN3yVHqj4tiJPvrryOdCu2wx/
 /QoSkhF84NMFcbTcmsjufpvn6VPFujeUkQYEHf4AFt4Fiwx1yVxz+xgwX3y3uC5ctit2KWZk8Sg
 /yAeImCaMyxLdgYBoSSoVQuQeh4GAnT87TAha2Uv45OLHUIQy6nkrU7Zcm8m3t+YWAO1B+uwLV3
 bGfzLdLUbyBKoiQxzdGuPSVtzPEdhMmk9to7VbWEt7xNMIJVyroQtoG6oe91Dj7bChn0ccjYhYE
 nplG7y923rA3M+N5Gow==
X-Proofpoint-ORIG-GUID: zBCpxcB4SOpi00kKIDQpauz6hvzgZ9gV
X-Proofpoint-GUID: 5f63IcCaRWTpmjciH9SIG7FkzvtdsUaz
X-Authority-Analysis: v=2.4 cv=W7UIkxWk c=1 sm=1 tr=0 ts=69fb2a62 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=7CQSdrXTAAAA:8 a=VnNF1IyMAAAA:8 a=LclGMN0sgN7LpYzSrHoA:9 a=QEXdDO2ut3YA:10
 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_03,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 spamscore=0 clxscore=1015 phishscore=0 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605060114
X-Rspamd-Queue-Id: 70AA64D9DBF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[26];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9470-lists,linux-integrity=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,earth.li,vger.kernel.org,lists.infradead.org,lists.linux.dev,paul-moore.com,namei.org,hallyn.com,huawei.com,oracle.com,kernel.org,ziepe.ca,arm.com,meta.com,google.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zohar@linux.ibm.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[linux-integrity];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[11]

On Wed, 2026-05-06 at 06:54 +0100, Yeoreum Yun wrote:
> Hi Mimi,
>=20
> > On Sun, 2026-05-03 at 07:36 -0400, Mimi Zohar wrote:
> > > On Fri, 2026-05-01 at 12:52 -0400, David Safford wrote:
> > > > On Thu, Apr 30, 2026 at 5:43=E2=80=AFPM Mimi Zohar <zohar@linux.ibm=
.com> wrote:
> > > > >=20
> > > > > On Thu, 2026-04-30 at 10:48 +0100, Yeoreum Yun wrote:
> > > > > > With above change I confirmed there is no meaurement log
> > > > > > between boot_aggregate and boot_aggregate_late except "kernel_v=
ersion"
> > > > > > But this is ignorable since this UTS measurement is done in
> > > > > > "ima_init_core() (old: ima_init())" and it is part of ima initi=
alisation.
> > > > > >=20
> > > > > > 1. ima_policy=3Dtcb
> > > > > >=20
> > > > > >   # cat /sys/kernel/security/ima/ascii_runtime_measurements
> > > > > >   10 0adefe762c149c7cec19da62f0da1297fcfbffff ima-ng sha256:000=
0000000000000000000000000000000000000000000000000000000000000 boot_aggregat=
e
> > > > > >   10 4e5d73ebadfd8f850cb93ce4de755ba148a9a7d5 ima-ng sha256:000=
0000000000000000000000000000000000000000000000000000000000000 boot_aggregat=
e_late
> > > > > >   10 7c23cc970eceec906f7a41bc2fbde770d7092209 ima-ng sha256:72a=
de6ae3d35cfe5ede7a77b1c0ed1d1782a899445fdcb219c0e994a084a70d5 /bin/busybox
> > > > snip
> > > > > >=20
> > > > > > 2. ima_policy=3Dcritical_data
> > > > > >=20
> > > > > >   # cat /sys/kernel/security/ima/ascii_runtime_measurements
> > > > > >   10 0adefe762c149c7cec19da62f0da1297fcfbffff ima-ng sha256:000=
0000000000000000000000000000000000000000000000000000000000000 boot_aggregat=
e
> > > > > >   10 49ab61dd97ea2f759edcb6c6a3387ac67f0aa576 ima-buf sha256:0c=
907aab3261194f16b0c2a422a82f145bc9b9ecb8fdb633fa43e3e5379f0af2 kernel_versi=
on 372e312e302d7263312b // Ignorable since it's generated by ima_init(_core=
)().
> > > > > >   10 4e5d73ebadfd8f850cb93ce4de755ba148a9a7d5 ima-ng sha256:000=
0000000000000000000000000000000000000000000000000000000000000 boot_aggregat=
e_late
> > > > > >=20
> > > > > > Therefore, init_ima() could move into late_initcall_sync like v=
1 did:
> > > > > >   - https://lore.kernel.org/all/20260417175759.3191279-2-yeoreu=
m.yun@arm.com/
> > > > >=20
> > > > > Thanks, Yeoreum.  It's a bit premature to claim it's "safe" to mo=
ve the
> > > > > initcall.  Hopefully others will respond.
> > > > >=20
> > > > > Mimi
> > > >=20
> > > > I have also run with this patch on a number of bare metal and virtu=
al machines,
> > > > running everything from default Fedora 44 to a version with everyth=
ing turned on
> > > > (uefi secure boot, UKI with sdboot stub measurements, IMA measureme=
nt
> > > > and appraisal enabled,
> > > > all systemd measurements on, and systemd using the TPM for root
> > > > partition decryption.)
> > > > I too see only the kernel_version event between the normal and late
> > > > calls, if ima_policy=3Dcritical_data.
> > >=20
> > > Thanks, Dave!  Were all the systems you tested x86_64?  The next step=
 would be
> > > to test on different arch's (e.g. Z, Power).
> >=20
> > On both Z and PowerVM, there are ~30 measurements between boot_aggregat=
e and
> > boot_aggregate_late.  For example, on PowerVM:
> >=20
> > # grep -n boot_aggregate
> > /sys/kernel/security/integrity/ima/ascii_runtime_measurements
> >=20
> > 1:10 f60a05d7354fb34aabc02965216abd3428ea52bb ima-sig
> > sha256:9887dd089ee19a6517bca10580b02c1bb9aa6cd86c157b6ead8a1c0403f348d5
> > boot_aggregate=20
> > 31:10 e2592b0d61da6300d3db447b143897a9792231ea ima-sig
> > sha256:9887dd089ee19a6517bca10580b02c1bb9aa6cd86c157b6ead8a1c0403f348d5
> > boot_aggregate_late
> >=20
> > It would be interesting to the results from a Raspberry Pi 5 as well,
> > with/without a TPM.
>=20
> Honestly, I find this result hard to accept.
>=20
> This effectively means that there is code invoking IMA measurement during=
 late_initcall().
> It also implies that if, in the future, a late_initcall is added that per=
forms
> an IMA measurement before IMA initialization has occurred accoding to ord=
er by linker,
> that measurement could be missed.

Exactly.  The results are simply from booting with the builtin "tcb" and
"critical_data" policies.

$ sudo grubby --args=3D"ima_policy=3D\"tcb|critical_data\"" --update-kernel
/boot/vmlinuz-${SUFFIX}

>=20
> Could you please check how the index (1, 31) was added to either
> ima_template_entry or ima_queue_entry to produce this result?

The grep "-n" option includes line numbers.  It doesn't have anything to do=
 with
the kernel.

Mimi

