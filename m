Return-Path: <linux-integrity+bounces-9013-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CGRVGwnCuWlYNQIAu9opvQ
	(envelope-from <linux-integrity+bounces-9013-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 17 Mar 2026 22:05:13 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E21A2B27E2
	for <lists+linux-integrity@lfdr.de>; Tue, 17 Mar 2026 22:05:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 48BDC3078E8B
	for <lists+linux-integrity@lfdr.de>; Tue, 17 Mar 2026 21:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AC8138F22A;
	Tue, 17 Mar 2026 21:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JP1EJrN6"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08577341660;
	Tue, 17 Mar 2026 21:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773781434; cv=none; b=P7Wty8wxUb2WMWtwgaPbbgte00lkz53JBuBRnqmZYd08YEh1MXof1YsKniOtV4zj14SE1HNki3pQGpIo7jIs9++P9khrpEtUmQ1VCcrtnvMLaPFSc84TImScKvs2Ov4kSYbtKvPzZIinvcWRasbEmRE+jQPhxS9+sZpN1UsRVCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773781434; c=relaxed/simple;
	bh=3ZT6f3l/YJlainCFCLjIngIdwwN+Ha7g9A/gyc8O6dQ=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=R1z2QWnQamGusgQI/YGlNdudTU2xyO0zBF7Z3OF/K6bSGplPkFWsme4R2ijRVH1IH9PLkxHYKJo+Yf9yxL+C4yrnI9krIRIWsSY+aqBFNlD9yly1/qH2/G1p/ZHAS7+H3HB2CPDJ3DVo84/17fuyWg+T+JG6bMW1wa/ZAKwLuVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JP1EJrN6; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62HJ3Xjf437268;
	Tue, 17 Mar 2026 21:03:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=35ox6e
	Tvb+BuV59HQovp9BO6CccMxIDZCex4QrYzgt0=; b=JP1EJrN6yUXRqbDCpFf/HT
	bIwtHuiHxI1vrS0d5uGub28P9ZXhZxSwGR1k/kCmCq6iwuAHNZpX2OlvfFsQNGyO
	nF5ylIj+wqbFXEi9bL70M+0j7IdVG3mAipQXfs9SoCpLwsiQJSjmqu78+lPcjE5y
	43jNQBNC5Zp7FWzO9+K105CkUaR4w08mwIQ6tvjf29lGC0uW2PLQdUbfZKLMFHqp
	ubRrkMvAcE1t/+eP/jc+segwpnCcvivwasU5TN7i+nEx+mudMEbiatagqzNmDpyy
	+m94zpjaJE076deNV4AkecwarRll3HhrkCnYs21/ag9SI9nAFRWxBKbADVKxBzJQ
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvx3cxake-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Mar 2026 21:03:23 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62HJqT9E032346;
	Tue, 17 Mar 2026 21:03:23 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cwm7jtu76-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Mar 2026 21:03:23 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62HL3MsX45547778
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Mar 2026 21:03:22 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 84DB658052;
	Tue, 17 Mar 2026 21:03:22 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8314C58056;
	Tue, 17 Mar 2026 21:03:21 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.96.49])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 17 Mar 2026 21:03:21 +0000 (GMT)
Message-ID: <587e11bf4d29552bbbfc029f716146e8ebfca1eb.camel@linux.ibm.com>
Subject: Re: [PATCH v3 3/3] ima: Add support for staging measurements for
 deletion
From: Mimi Zohar <zohar@linux.ibm.com>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>, corbet@lwn.net,
        skhan@linuxfoundation.org, dmitry.kasatkin@gmail.com,
        eric.snowberg@oracle.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        gregorylumen@linux.microsoft.com, chenste@linux.microsoft.com,
        nramas@linux.microsoft.com, Roberto Sassu <roberto.sassu@huawei.com>
In-Reply-To: <20260311171956.2317781-3-roberto.sassu@huaweicloud.com>
References: <20260311171956.2317781-1-roberto.sassu@huaweicloud.com>
	 <20260311171956.2317781-3-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Mar 2026 17:03:21 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=arO/yCZV c=1 sm=1 tr=0 ts=69b9c19c cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=NEAV23lmAAAA:8
 a=i0EeH86SAAAA:8 a=dI1R9EHszrxaWDBk9sIA:9 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE3MDE4MiBTYWx0ZWRfX5cLbzBYnGnwj
 6SQN1GIBN/SwDITHbHyW7CADzJIUHYWGRceLlJ56vg2ikaxCh9/kcaE2DhueJsr/3lPCUJ6c6IU
 eitwgM1CoeYbNdSuVkIqf8U02ggV3S+fqMaLCxxpv4Nxo88UDF2YrviYTdpn+6ZGYXOxpaVhpg/
 fpcE6o/Bo0IEeX/wzmRv4gHNQ0Mqk94uFtprcSrk8tIzLon49VZml3AyWdf3pBk9AH34JM/4eJ9
 cToshBtkr2b+fDb37+dJL1n/HIwlYYHlbon9NbqLP+l2vHNs95RLhxVZGET5Pc6IT2YVTNUL2cM
 pGg0r7Q9BSQN3MJakGZ6hyBH81IrPr8jQOpBS0NGj8ONkCZtKcvglNyoC6WBaxWN89rXRgjTikN
 6cnsYHOiEn5NR85ZdRyLtAEHBdX2E6P9tA5qp8txuj2hcjjTEv1J+NRQZj1s2N9BjoSQPjAMs1M
 NlCOTXNGAHJySKhQRPw==
X-Proofpoint-GUID: zNRnxCaVKgMQNrTkRUoxvLCZbc9LL6-p
X-Proofpoint-ORIG-GUID: 8wcKCw47HmutuC9-QWJII4BiUYIfn1l1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_04,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 bulkscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603170182
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9013-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[huaweicloud.com,lwn.net,linuxfoundation.org,gmail.com,oracle.com,paul-moore.com,namei.org,hallyn.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,linux.ibm.com:mid];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
X-Rspamd-Queue-Id: 0E21A2B27E2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Roberto,

On Wed, 2026-03-11 at 18:19 +0100, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
>=20
> Introduce the ability of staging the IMA measurement list for deletion.
> Staging means moving the current content of the measurement list to a
> separate location, and allowing users to read and delete it. This causes
> the measurement list to be atomically truncated before new measurements c=
an
> be added.

I really like this design of atomically moving and subsequently deleting th=
e
measurement list.  However this is a solution, not the motivation for the p=
atch.
Please include the motivation for the patch, before describing the solution=
.

> Staging can be done only once at a time. In the event of kexec(),
> staging is reverted and staged entries will be carried over to the new
> kernel.

>=20
> Staged measurements can be deleted entirely, or partially, with the
> non-deleted ones added back to the IMA measurements list.=C2=A0

This patch description is really long, which is an indication that the patc=
h
needs to be split up.  Adding support for partially deleting the measuremen=
t
list records, by prepending the remaining measurement records, should be a
separate patch.

> This allows the
> remote attestation agents to easily separate the measurements that where
> verified (staged and deleted) from those that weren't due to the race
> between taking a TPM quote and reading the measurements list.
>=20
> User space is responsible to concatenate the staged IMA measurements list
> portions (excluding the measurements added back to the IMA measurements
> list) following the temporal order in which the operations were done,
> together with the current measurement list. Then, it can send the collect=
ed
> data to the remote verifiers.

This belongs in a Documentation patch.=20

>=20
> The benefit of staging and deleting is the ability to free precious kerne=
l
> memory,=C2=A0

This is the motivation for the patch.

> in exchange of delegating user space to reconstruct the full
> measurement list from the chunks. No trust needs to be given to user spac=
e,
> since the integrity of the measurement list is protected by the TPM.

Agreed the measurement list, itself, is protected by the TPM.  However, rel=
ying
on userspace to reassemble the chunks is another concern. Support for stagi=
ng
and deleting the measurement list should be configurable.  Defining a Kconf=
ig
should be part of this initial patch.

> By default, staging the measurements list does not alter the hash table.
> When staging and deleting are done, IMA is still able to detect collision=
s
> on the staged and later deleted measurement entries, by keeping the entry
> digests (only template data are freed).
>=20
> However, since during the measurements list serialization only the SHA1
> digest is passed, and since there are no template data to recalculate the
> other digests from, the hash table is currently not populated with digest=
s
> from staged/deleted entries after kexec().
>=20
> Introduce the new kernel option ima_flush_htable to decide whether or not
> the digests of staged measurement entries are flushed from the hash table=
,
> when they are deleted. Flushing the hash table is supported only when
> deleting all the staged measurements, since in that case the old hash tab=
le
> can be quickly swapped with a blank one (otherwise entries would have to =
be
> removed one by one for partial deletion).

Allowing the hash table to be deleted would be an example of another patch.

>=20
> Then, introduce ascii_runtime_measurements_<algo>_staged and
> binary_runtime_measurements_<algo>_staged interfaces to stage and delete
> the measurements. Use 'echo A > <IMA interface>' and
> 'echo D > <IMA interface>' to respectively stage and delete the entire
> measurements list. Use 'echo N > <IMA interface>', with N between 1 and
> ULONG_MAX - 1, to delete the selected staged portion of the measurements
> list.
>=20
> The ima_measure_users counter (protected by the ima_measure_mutex mutex)
> has been introduced to protect access to the measurements list and the
> staged part. The open method of all the measurement interfaces has been
> extended to allow only one writer at a time or, in alternative, multiple
> readers. The write permission is used to stage and delete the measurement=
s,
> the read permission to read them. Write requires also the CAP_SYS_ADMIN
> capability.

Yes, this is part of the initial patch that adds support for staging the
measurement list.

>=20
> Finally, introduce the binary_lists enum and make binary_runtime_size
> and ima_num_entries as arrays, to keep track of their values for the
> current IMA measurements list (BINARY), current list plus staged
> measurements (BINARY_STAGED) and the cumulative list since IMA
> initialization (BINARY_FULL).
>=20
> Use BINARY in ima_show_measurements_count(), BINARY_STAGED in
> ima_add_kexec_buffer() and BINARY_FULL in ima_measure_kexec_event().
>=20
> It should be noted that the BINARY_FULL counter is not passed through
> kexec. Thus, the number of entries included in the kexec critical data
> records refers to the entries since the previous kexec records.
>=20
> Note: This code derives from the Alt-IMA Huawei project, whose license is
>       GPL-2.0 OR MIT.
>=20
> Link: https://github.com/linux-integrity/linux/issues/1
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>

The design looks good.  As I mentioned above, this patch description is qui=
te
long, which is an indication that the patch needs to be split up.  One meth=
od of
breaking it up would be:

- (Basic) support for staging measurements for deletion (based on a Kconfig=
)
- Support for removing the hash table
- Support for deleting N measurement records (and pre-pending the remaining
measurement records)
- Adding documentation

thanks,

Mimi

