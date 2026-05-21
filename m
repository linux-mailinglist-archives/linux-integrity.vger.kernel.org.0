Return-Path: <linux-integrity+bounces-9611-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gKH4CJZoDmob+gUAu9opvQ
	(envelope-from <linux-integrity+bounces-9611-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Thu, 21 May 2026 04:06:14 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9214D59DDD1
	for <lists+linux-integrity@lfdr.de>; Thu, 21 May 2026 04:06:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5E10D30293D6
	for <lists+linux-integrity@lfdr.de>; Thu, 21 May 2026 02:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92E2E1A8F97;
	Thu, 21 May 2026 02:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="quGdVB7i"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350C33033EA;
	Thu, 21 May 2026 02:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779329150; cv=none; b=us3C9hvEJP6buWFfNRYK+UV/LD1q5DQC5xON+GjeWIRj7VhJuPO+0CRKtokwI/haTl51Wll79oT+BtW8uoByLYuclalDaSHr8q/J8lJNNZd7gi0TZg4o1qzum/aPDcTR+LY93z/zvzB7s7m/1MoAlxO/bKdFw6bC9PMZ1ZPInx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779329150; c=relaxed/simple;
	bh=ndPf8v4qBj08xwcKbsxkbrO0L7YUGiypMH96rBl4T7I=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=PZ9+cbfJYlzlkyEEFKySe0t0TCkJauhIz9TLNAURaCIlim9hRB3EmFH9azWlyMP5JGH8nW/8t9kelZp5mAYRDzCD96lt6qZpqScTgitpxFZjC+HHS5Nop0lt2QUCspGVpiGRKUZtvSbXXxYYMInVUNNXRODkXPxjR+jp7NuWWlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=quGdVB7i; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64KLgalS3991710;
	Thu, 21 May 2026 02:05:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=eYykwn
	H16auSdwRzCiXimLn5bvDbClfxASkRm12VyVo=; b=quGdVB7iuGlnoSh7l2OqAn
	VSXB6IngPCLflAAQEgJlr0ApcqItotUMeKU1NQZJEl51GJtAQ22YP8eatuppGae5
	kr2vCc6oP3laV54Tu7uZebpe7/v6rGPbMLdTWZyqneQmGTpWof+poIMemhAZ/8sc
	U/TxN9FjX+t29+FXI2NqM2QzJ6khrrCOgSf1ES4uX00xY4e9SH+picNByolcj49m
	10In8W9uyUBmUWmAroHDTjAITvPWVdX68suEGg2nc+oRgmzsjapZwTc0s2Uy+uRB
	+OcDBZsz6ubz8xtHEJqm3OMgmB3Mtw9G4mryO/+XN514iDdXgcdGT9SVr95mbJIg
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6hb8km2d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 May 2026 02:05:28 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64L1sBc5024927;
	Thu, 21 May 2026 02:05:27 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e73wka1pm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 May 2026 02:05:27 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64L24wfU17629888
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 May 2026 02:04:58 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 710E258062;
	Thu, 21 May 2026 02:05:27 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DBEAA5805D;
	Thu, 21 May 2026 02:05:25 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.96.83])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 21 May 2026 02:05:25 +0000 (GMT)
Message-ID: <1cf1265ff04a40664335f387917f228796a97ee4.camel@linux.ibm.com>
Subject: Re: [PATCH v5 02/13] ima: Replace static htable queue with
 dynamically allocated array
From: Mimi Zohar <zohar@linux.ibm.com>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>, corbet@lwn.net,
        skhan@linuxfoundation.org, dmitry.kasatkin@gmail.com,
        eric.snowberg@oracle.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        gregorylumen@linux.microsoft.com, chenste@linux.microsoft.com,
        nramas@linux.microsoft.com, Roberto Sassu <roberto.sassu@huawei.com>
In-Reply-To: <20260429160319.4162918-3-roberto.sassu@huaweicloud.com>
References: <20260429160319.4162918-1-roberto.sassu@huaweicloud.com>
	 <20260429160319.4162918-3-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 20 May 2026 22:05:25 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDAwOCBTYWx0ZWRfXyHg16RydTJPs
 3HsI7QO/CxrMzSVdd827f1di2gGla64p3SyU79VGQa9bDakOZl5+I3QBhxBHWSVabuJbt+4xlcg
 aAE2rebE1T7cT6vWYj0xCLKGqQl+oCT23E3wxgTIASj17LPSBrPXC+KqNjbUxGkvoYIwtz7JIZh
 GSckeuxirrqonZsiuv7XhkfCMvWjb4Me3IXOQVWuCY8jONK8e+WcL/E4hDACkcO0Qg2cqh1nn4i
 ME+A2zCnywcxqSETF3C/UforuUb4jZbguZhBt0YkuMLyOo2UKmbggsS5LGIHCI5Mgii8PiPLf4j
 2amv4nhe5wvXT1tIfVYn7hdz4tlvjxWA0qQ5DBdiX31tY1hde1ZDgQgjFBCF3pQhNOz96bZ9RG6
 skMA0V/Wpl+JCxgoPR95cyMmlqujJEwnHVfPauH/iNQS7JyPsWzV6PfvS3eRcK8Uxx/lCLO07ux
 P/DT0kMPVC4b7TuhZaQ==
X-Proofpoint-GUID: V2ZM1HOakxbYjzAtnono1NVQS18YmFrV
X-Proofpoint-ORIG-GUID: zRLI2uvScx_p7wZN5uVPU-eb41H8jBHF
X-Authority-Analysis: v=2.4 cv=aYBRWxot c=1 sm=1 tr=0 ts=6a0e6868 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=NEAV23lmAAAA:8
 a=i0EeH86SAAAA:8 a=VnNF1IyMAAAA:8 a=knqcwaXk2HHkbiZ8WvIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1011 spamscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605210008
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9611-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[huaweicloud.com,lwn.net,linuxfoundation.org,gmail.com,oracle.com,paul-moore.com,namei.org,hallyn.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.ibm.com:mid,huawei.com:email];
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
X-Rspamd-Queue-Id: 9214D59DDD1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 2026-04-29 at 18:03 +0200, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
>=20
> The IMA hash table is a fixed-size array of hlist_head buckets:
>=20
>     struct hlist_head ima_htable[IMA_MEASURE_HTABLE_SIZE];
>=20
> IMA_MEASURE_HTABLE_SIZE is (1 << IMA_HASH_BITS) =3D 1024 buckets, each a
> struct hlist_head (one pointer, 8 bytes on 64-bit). That is 8 KiB allocat=
ed
> in BSS for every kernel, regardless of whether IMA is ever used, and
> regardless of how many measurements are actually made.
>=20
> Replace the fixed-size array with a RCU-protected pointer to a dynamicall=
y
> allocated array that is initialized in ima_init_htable(), which is called
> from ima_init() during early boot. ima_init_htable() calls the static
> function ima_alloc_replace_htable() which, other than initializing the ha=
sh
> table the first time, can also hot-swap the existing hash table with a
> blank one.
>=20
> The allocation in ima_alloc_replace_htable() uses kcalloc() so the bucket=
s
> are zero-initialised (equivalent to HLIST_HEAD_INIT { .first =3D NULL }).
> Callers of ima_alloc_replace_htable() must call synchronize_rcu() and fre=
e
> the returned hash table.
>=20
> Finally, access the hash table with rcu_dereference() in
> ima_lookup_digest_entry() (reader side) and with
> rcu_dereference_protected() in ima_add_digest_entry() (writer side).
>=20
> No functional change: bucket count, hash function, and all locking remain
> identical.
>=20
> Link: https://github.com/linux-integrity/linux/issues/1
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

