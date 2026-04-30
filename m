Return-Path: <linux-integrity+bounces-9391-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kH5jFfPM82nq7AEAu9opvQ
	(envelope-from <linux-integrity+bounces-9391-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Thu, 30 Apr 2026 23:43:15 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0259C4A8549
	for <lists+linux-integrity@lfdr.de>; Thu, 30 Apr 2026 23:43:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 38F3830146B4
	for <lists+linux-integrity@lfdr.de>; Thu, 30 Apr 2026 21:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EDF233A031;
	Thu, 30 Apr 2026 21:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="oRjQHFqO"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1252DEA90;
	Thu, 30 Apr 2026 21:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777585196; cv=none; b=sRvTFUcftbH1wA6zZNY+sJlIQ/Ja8LUk71Znv2ZNk7GvkmaxtiRppfFWsNe4Y/PgvOu8Qg/oY5KFYysq3PdRLSWwqO6yFGhVNdxLA41ylj9axLQ6ayF2L+kIGmQfg7F0HF6IZCH/JK00zkG1RWmU7hI6dBlOrKV2BszBhgHDABo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777585196; c=relaxed/simple;
	bh=TLJKOEFsS13UCJrCvQpa8BYGG8rX5qDKiTrbs/bCqvE=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=d4ooO76zzaPyk/3wxLi01sWAQ1vIbMG2MovAcLDAk86W+USdbtfrRNTWjbu1xEEEvuqeoVNq9I5T+CrS8XM0Lla4IQitR1PDG1Gzx6+5YoZk9W6rFDY2EaiAELEriiKk5A13EX7b94k8R9g+Lnb73Vfrpw38WiwrC+Lo4mHg2jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=oRjQHFqO; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63UIajDr3450963;
	Thu, 30 Apr 2026 21:39:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=kOIVI/
	+QPMj+HcDRfkbB9Z0JXy5Jvv7wZtXW/0D7F14=; b=oRjQHFqOjgoh8bR44BKl9b
	rRvXpyK/+UTyo8imSHCOv2sb0NPNfDRSJ46DNCHg7+OGytYAhSoVbJaaE2TZkcVH
	gZQLCX2jaJSldz/w1sN52F1//jwnoSOOcN+ucSW6tT/2Tms7Ouo6K5ZHOKgR65s3
	4IIs+HleWRwjdrkO/CpC1X2ZthQ0LkYFZJf1gAyWng2U/ABXq+HuHw8ZJ/8Y3egC
	Oia2PWf3exlP9CSMRlrldI3S8fqrzBf8SZpimF5mcFj51qApn0wK2p9sMO91VFgg
	Eii6QEzF+kbSLUIIW2tzUgBt3FrYI81pJE4ThMW+bXF2WVzVQLlicc5wF3+e/gsw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drnb5j2q5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Apr 2026 21:39:25 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63ULcqx0017093;
	Thu, 30 Apr 2026 21:39:23 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ds8aw51ra-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Apr 2026 21:39:23 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63ULdN3E30016018
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Apr 2026 21:39:23 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 194125805A;
	Thu, 30 Apr 2026 21:39:23 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9D6F558051;
	Thu, 30 Apr 2026 21:39:21 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.47.107])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 30 Apr 2026 21:39:21 +0000 (GMT)
Message-ID: <9f188536f09a2db30877d6bfbb84aeaf2565cccf.camel@linux.ibm.com>
Subject: Re: [PATCH] ima: debugging late_initcall_sync measurements
From: Mimi Zohar <zohar@linux.ibm.com>
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: Jonathan McDowell <noodles@earth.li>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.linux.dev, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, roberto.sassu@huawei.com, dmitry.kasatkin@gmail.com,
        eric.snowberg@oracle.com, jarkko@kernel.org, jgg@ziepe.ca,
        sudeep.holla@kernel.org, maz@kernel.org, oupton@kernel.org,
        joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com,
        catalin.marinas@arm.com, will@kernel.org, noodles@meta.com,
        sebastianene@google.com
In-Reply-To: <afMlgstqahnZg68h@e129823.arm.com>
References: <cover.1777036497.git.noodles@meta.com>
	 <7734099f5e7fda5480bca016a9e6707983325fbd.camel@linux.ibm.com>
	 <afMlgstqahnZg68h@e129823.arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Apr 2026 17:39:21 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=AqDeGu9P c=1 sm=1 tr=0 ts=69f3cc0d cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=7CQSdrXTAAAA:8 a=kfywWr5o1HTmsyUdr2YA:9 a=QEXdDO2ut3YA:10
 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDIyMCBTYWx0ZWRfX/y+c23+jpmeu
 M3AYFTUdxehwWfGkJlDLCf1MS7bbT4l1GwAZ04l+V2oa6kzKxAUVeEGWoJgEDL2quUNdvYd/8ap
 D8N2H3RUgwxO48BK/3OtRm6HA/2RIxz14cB+oOCXscn9JG1yAwihNdeQx+vLVVgr5l+HNv0zInW
 4Pokd6oTcgWCMmPy2shY0IUPrerH3e1aflyh6gwoRfiuSAT2rpdewJC0x5eM/MnE98AC7dR9N+2
 vj+BvbwSZzQRN6rEFzF30YMD/5C2ncENz70GOAgYrulva+FKbLT9o62gS917iFEBjigaHBZ8ekc
 sc03GBWBB2Uc/mPpPb4gJq08/DjspmF/bdQ8clkpOXTfPHRqNlgntJ+/t2mHikSeYqlqjNtIYBw
 DD+NeTVY995nA/59OyvJ0cqR9PwGg34Hs/RI0aVP9p3RJZrU3p1hrTyXYj19oJnjvF7KBB3sE9Q
 8imcv3q0SfqXDv0QqDQ==
X-Proofpoint-GUID: MBkBhuJvcbCVEra9xd0J21Vsh6VKtCRY
X-Proofpoint-ORIG-GUID: QtCnuy_nwfyJU8UBcsSswD-9mCQeQJY8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-30_06,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 phishscore=0 suspectscore=0 clxscore=1015
 lowpriorityscore=0 spamscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604300220
X-Rspamd-Queue-Id: 0259C4A8549
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[25];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9391-lists,linux-integrity=lfdr.de];
	FREEMAIL_CC(0.00)[earth.li,vger.kernel.org,lists.infradead.org,lists.linux.dev,paul-moore.com,namei.org,hallyn.com,huawei.com,gmail.com,oracle.com,kernel.org,ziepe.ca,arm.com,meta.com,google.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.ibm.com:mid];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
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

On Thu, 2026-04-30 at 10:48 +0100, Yeoreum Yun wrote:
> With above change I confirmed there is no meaurement log
> between boot_aggregate and boot_aggregate_late except "kernel_version"
> But this is ignorable since this UTS measurement is done in
> "ima_init_core() (old: ima_init())" and it is part of ima initialisation.
>=20
> 1. ima_policy=3Dtcb
>=20
>   # cat /sys/kernel/security/ima/ascii_runtime_measurements
>   10 0adefe762c149c7cec19da62f0da1297fcfbffff ima-ng sha256:0000000000000=
000000000000000000000000000000000000000000000000000 boot_aggregate
>   10 4e5d73ebadfd8f850cb93ce4de755ba148a9a7d5 ima-ng sha256:0000000000000=
000000000000000000000000000000000000000000000000000 boot_aggregate_late
>   10 7c23cc970eceec906f7a41bc2fbde770d7092209 ima-ng sha256:72ade6ae3d35c=
fe5ede7a77b1c0ed1d1782a899445fdcb219c0e994a084a70d5 /bin/busybox
>   10 17ec669c65c401e5e85875cf2962eb7d8c47595f ima-ng sha256:dc6b013e9768d=
9b13bcd6678470448090138ca831f4771a43ce3988d8e54ffce /lib/ld-linux-aarch64.s=
o.1
>   10 58679a66ac1de17f02595625a8fbeafa259a4c81 ima-ng sha256:494f62bcfb2fc=
f1b427d5092fafa62c8df39a83b4a64402620b28846724f237f /usr/lib/libtirpc.so.3.=
0.0
>   10 42f74ee200434576e33be153830b3d55bbe6d2bf ima-ng sha256:a18856b4f6927=
bc2b8dd4608c0768b8f98544a161b85bf4a64419131243ad300 /lib/libresolv.so.2
>   10 626b4f7bd4f123d18d3a3d8719ed0ae19ee5f331 ima-ng sha256:b8d442de5d31c=
3f9d1bbb98785f04d4a23dc53442b286d85d4b355927cbe9af4 /lib/libc.so.6
>   10 655a200869696207646377a58cab417fd35b09d2 ima-ng sha256:ad46146b6dd32=
b47213e5327f1bb2f962ef838a4b707ef7445fa2dbc9019b44f /etc/inittab
>   10 81353202685e022fcd0069a3b2fc4eaa6b1db537 ima-ng sha256:74d698fe0a686=
2050af29083aa591c960ec1f67be960047e96bb6be5fc2bc0c0 /bin/mount
>   10 ae64184ee607ef8f3aa08ab52cb548318534fd4b ima-ng sha256:27846b57e8234=
c6a9611b00351f581a54ad6f9a1920b9aa18ceb0ae28e4f7564 /lib/libmount.so.1.1.0
>   10 5ea01f34e7705d1bdb936fd576e2aeb5fd78dab9 ima-ng sha256:3d2a414ec0355=
fcf0910224fb4a3c53e13d98731a35241edfdf4fb911ed9b210 /lib/libblkid.so.1.1.0
>   10 22c48b4853594a08a73ad4ae6dbe6f2c2bebc6c5 ima-ng sha256:e3b0c44298fc1=
c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855 /run/utmp
>   10 3024ea5021f8a5d9fb4bd519d599bdca43b7fb93 ima-ng sha256:71ea9ffe2b30e=
5a9bdceff78785cf281cc41544474db8dc4605a06a597ce1edc /etc/fstab
>   10 2e7530a0f56420991ac7611734cea4774b92b9ef ima-ng sha256:df4697d699442=
cfe73db7cc8b4c1b37e8a31e75e01f66a0d70134ac812fa683b /bin/mkdir
>   10 3ad117a863aa1ed7b7c09e1d106f84abf7d2ae96 ima-ng sha256:c19a710989b43=
222431b02399273dba409fe10ca8eefff88eaa936fa695f8324 /bin/ln
>   10 4141c82cb516ac3c846e0b08abcd6abeee7efa1a ima-ng sha256:b75d7f28772f7=
1715a941c77e07e3922815391dd9cc5718ad21f2231c2da09bb /etc/hostname
>   10 dfcedd3c7dc3ed42e09219804504489ab264e2e3 ima-ng sha256:dc1615df9f201=
2b20b81ffad8e07e16293039ba7fd897854ca3646d6cfea0c0f /etc/init.d/rcS
>   ...
>=20
> 2. ima_policy=3Dcritical_data
>=20
>   # cat /sys/kernel/security/ima/ascii_runtime_measurements
>   10 0adefe762c149c7cec19da62f0da1297fcfbffff ima-ng sha256:0000000000000=
000000000000000000000000000000000000000000000000000 boot_aggregate
>   10 49ab61dd97ea2f759edcb6c6a3387ac67f0aa576 ima-buf sha256:0c907aab3261=
194f16b0c2a422a82f145bc9b9ecb8fdb633fa43e3e5379f0af2 kernel_version 372e312=
e302d7263312b // Ignorable since it's generated by ima_init(_core)().
>   10 4e5d73ebadfd8f850cb93ce4de755ba148a9a7d5 ima-ng sha256:0000000000000=
000000000000000000000000000000000000000000000000000 boot_aggregate_late
>=20
> Therefore, init_ima() could move into late_initcall_sync like v1 did:
>   - https://lore.kernel.org/all/20260417175759.3191279-2-yeoreum.yun@arm.=
com/

Thanks, Yeoreum.  It's a bit premature to claim it's "safe" to move the
initcall.  Hopefully others will respond.

Mimi

