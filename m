Return-Path: <linux-integrity+bounces-9670-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IH9rE0R/FWqtWAcAu9opvQ
	(envelope-from <linux-integrity+bounces-9670-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 26 May 2026 13:08:52 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EC8505D4ACA
	for <lists+linux-integrity@lfdr.de>; Tue, 26 May 2026 13:08:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8CF90300BD8E
	for <lists+linux-integrity@lfdr.de>; Tue, 26 May 2026 11:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E95FB3CAA5E;
	Tue, 26 May 2026 11:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cqPiXxJ9"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 926E933C52E;
	Tue, 26 May 2026 11:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779793728; cv=none; b=X9lGaj05Kq8iETPX5JY9iaN9IX3XF0/HQMTVFMkHMJ+gAj8UNsLc2hM7grwJ9JpUgaoThbt0ydYzzhucBEBG25VlmlhCFSzPXYiSkL0AxqrNdTgtKE6v0HmBLkN5Egafj9GmfFe0eHpwPmRxJjgQbUlVIwSgLJytWD92mJb2Gh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779793728; c=relaxed/simple;
	bh=dqddeWlw96vcPwqnH1MFYNx6lWkzP6atdgtYZoDeP9E=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=SBwHTLPulDPlQKsmJI9PtZ76ge82ml5PcMYCnFUcuODt3YHtH7wFr6VIlMwSdZEY/cK3neEeasshrSMj8pArZFz8PP32mJpMy3d6SWqKvAgPh8REUU2Kxo1ari6STPcUfC/kIoJEnZZwEmZD55UYiZ0K3QSi19JkRN5uhJ4hLKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cqPiXxJ9; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64Q45UJt955810;
	Tue, 26 May 2026 11:08:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=4IJRm5
	jVB3krHAAk9FRxTjMQzBs4+dOPFkyoCcixxRw=; b=cqPiXxJ9W8XaZTvnmeVboH
	Sf9NP6wooHEExBxc+dD8R3LPMH911AXPUQakt16vuKSZ/xpvF0+ply8EU6d8Qrcg
	GRrT5TClymnHR8HYe+N95LqhubXlmVXXlBSk7KYvQRkiCVlElwhDYxehyXWz0woL
	4LVTDG6ydEMcVTyF8+RLydoUq4Rvpec7VD0glITHxe3WS1/ANDdrgeFKCwzVncEO
	/p39uzwJ31RUr0Y5Sl4IbVMVJe4sw3E60fEUqoYthlwoHMjhN/0PdVR18ty+xBKd
	dl+9++iUKDVKObVeLQNWOmtj1SrsLYi7n3e7zFqG31DVT1RNxCaMrcXpley+rLOQ
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eb4nuks4u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 May 2026 11:08:04 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64QAs7uh015085;
	Tue, 26 May 2026 11:08:03 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ebrsg8tn5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 May 2026 11:08:03 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64QB7XnZ31261312
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 May 2026 11:07:33 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C769158064;
	Tue, 26 May 2026 11:08:02 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4AE675806E;
	Tue, 26 May 2026 11:08:01 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.143.56])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 26 May 2026 11:08:01 +0000 (GMT)
Message-ID: <f00aabe05aeee7f6fd0426fd992839758d810da7.camel@linux.ibm.com>
Subject: Re: [PATCH v5 11/13] ima: Support staging and deleting N
 measurements entries
From: Mimi Zohar <zohar@linux.ibm.com>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>, corbet@lwn.net,
        skhan@linuxfoundation.org, dmitry.kasatkin@gmail.com,
        eric.snowberg@oracle.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        gregorylumen@linux.microsoft.com, chenste@linux.microsoft.com,
        nramas@linux.microsoft.com, Roberto Sassu <roberto.sassu@huawei.com>
In-Reply-To: <20260429160319.4162918-12-roberto.sassu@huaweicloud.com>
References: <20260429160319.4162918-1-roberto.sassu@huaweicloud.com>
	 <20260429160319.4162918-12-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 26 May 2026 07:08:00 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDA5NyBTYWx0ZWRfX1BHYFOSSUhbv
 JroqqYjmzNlnHVcP9DesTsIpfEea4Eqr1ZLa3w5hl7EpoWohIqDaKcL9NNyRj90iW00al4aR2Eb
 AK/ZA3vIt3hLhBSUXwWesn5vDEKObKK5aC7dYgjyJk1UePaDbq4Gv8VWFF61GHgksurJyUkimEd
 ng6By1OOLD4rPfvbDObhAfprqhGZQ4eITYUOb0kJ2gajjamMRlfdLGp1686PV0Zbj/WwNi1XZPz
 4xRCQBvJwQYoRCB0sQAy6ex1zd2ZssWgabf6Gv0daI1f4D1HdZtCr/cNjTf4D3lY8aYo2x2lX0F
 aiUszFh5Jsrwywmnf7pHxtLxPTRxW36cOS3J6b7Y8WRnovpv95ZYRVEIjEuWNssKcFys5COkc1T
 TMhm9IBZVxUCqpLI5p9VoP+R44DgiKG7MaHVjo5OFvDADUv2KqTaRMC7Y8rAZKRxjxNlbaDEC/x
 3ibwTXIpEVos7yKTGTQ==
X-Authority-Analysis: v=2.4 cv=UtJT8ewB c=1 sm=1 tr=0 ts=6a157f15 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=NEAV23lmAAAA:8
 a=i0EeH86SAAAA:8 a=yMhMjlubAAAA:8 a=VnNF1IyMAAAA:8 a=Q4I1xE8-wxmIWu5A6OUA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: zd6N8FEPg0-gyZxI2iCIB0GJksVXBj1S
X-Proofpoint-GUID: fjZLvl1KxX-DfFGl7kXm4CKkxkASDtJF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-26_02,2026-05-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 adultscore=0 clxscore=1015 bulkscore=0
 phishscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605260097
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9670-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[huaweicloud.com,lwn.net,linuxfoundation.org,gmail.com,oracle.com,paul-moore.com,namei.org,hallyn.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,huawei.com:email];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zohar@linux.ibm.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-integrity];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: EC8505D4ACA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 2026-04-29 at 18:03 +0200, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
>=20
> Add support for sending a value N between 1 and ULONG_MAX to the IMA
> original measurement interface. This value represents the number of
> measurements that should be deleted from the current measurements list. I=
n
> this case, measurements are staged in an internal non-user visible list,
> and immediately deleted.
>=20
> This staging method allows the remote attestation agents to easily separa=
te
> the measurements that were verified (staged and deleted) from those that
> weren't due to the race between taking a TPM quote and reading the
> measurements list.

The reason for removing records from the IMA measurement list is to free ke=
rnel
memory.  However, the level of precision in removing only those measurement=
s
needed for the quote seems necessary only if the measurement records are no=
t
being saved.=C2=A0 Upstreaming a feature to remove measurement records from=
 the IMA
measurement list is to address the kernel memory issue =E2=80=94 clearly no=
t to drop
measurement records and break attestation.

>=20
> In order to minimize the locking time of ima_extend_list_mutex, deleting
> N entries is realized by doing a lockless walk in the current measurement=
s
> list to determine the N-th entry to cut, to cut the current measurements
> list under the lock, and by deleting the excess entries after releasing t=
he
> lock.
>=20
> Flushing the hash table is not supported for N entries, since it would
> require removing the N entries one by one from the hash table under the
> ima_extend_list_mutex lock, which would increase the locking time.
>=20
> The ima_extend_list_mutex lock is necessary in ima_dump_measurement_list(=
)
> because ima_queue_delete_partial() uses __list_cut_position() to modify
> ima_measurements, for which no RCU-safe variant exists. For the staging
> with prompt flavor alone, list_replace_rcu() could have been used instead=
,
> but since both flavors share the same kexec serialization path, the mutex
> is required regardless.

Thank you for the clear explanation for the changes and limitations require=
d to
support this feature.

The changes needed for supporting "stage and delete N" measurement records
should be limited to this patch.  Patch 9/13 should have used
list_replace_rcu(), without the mutex_lock.

>=20
> Link: https://github.com/linux-integrity/linux/issues/1
> Suggested-by: Steven Chen <chenste@linux.microsoft.com>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>

Otherwise,

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

