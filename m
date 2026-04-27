Return-Path: <linux-integrity+bounces-9343-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qAZTDeZl72kIBAEAu9opvQ
	(envelope-from <linux-integrity+bounces-9343-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Mon, 27 Apr 2026 15:34:30 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 96702473818
	for <lists+linux-integrity@lfdr.de>; Mon, 27 Apr 2026 15:34:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1B34A301BC14
	for <lists+linux-integrity@lfdr.de>; Mon, 27 Apr 2026 13:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADF0A3CAE80;
	Mon, 27 Apr 2026 13:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hAI8jo04"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE453CAE73
	for <linux-integrity@vger.kernel.org>; Mon, 27 Apr 2026 13:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777296630; cv=none; b=A1s8rooIiqPV1XlPI/JCsTOTcZqLQF2zOupTxk/K6YQuGecCezupGq2bABQds4ZghRBBIhV5UNwXkvSr//ZF0dazH7XiT/cw8qLx4u2c8vqscep3oVMU+Ccfvufzlwgjo+OF5B9K2pgSKjlOdrmKV+Sar9B4hf8F6flxTrDmSUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777296630; c=relaxed/simple;
	bh=BTBEUZDydT3nLn3Kv2CZTUjHem8IGhBjxyXsIyMnSNU=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=qWJC+2NR1Wd8mVzQ0E4bK4pdyOLcYCmTX3ROhA9RcFtE2zejm9HbvDKVljaPztlkVfQ5wn8hz6bPQi20N9wc1Z86p7w2zb6aMr7u5zulWS3NMP4Te0VCgf/CYejMFumw/v42UtweEGTu40wCjajMZrVIw8AKMLKTtRjNQlJ7hQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hAI8jo04; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63QLE4hH2581734;
	Mon, 27 Apr 2026 13:30:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=37nNG6
	cH/McLftwMS4n3+C6x02UtYPh7a/apJj9vKUA=; b=hAI8jo04xwczR9NHDNk0SK
	V75Lv2cku5IvYLLCi2z5zLLL2HJzyGZd9Y3MrXtRw9GeJOcMkuUSjkjY48m8WfRe
	SpSoAyw/XW9vf8ecDrRbRP2lHYEwqKyQl/9fYeHLjK1DKAckGCBNJ7qzK5iFG32Q
	PInUWjV3oEAKxrD6LbOCFtb4Ca9a+8+oC+lUNj0RlhNgAZCLb5NQSFDQmDpE/l24
	/yLIy67SoMCEbs2RTqpymekyGSQzkdCIh5nYSv3mTBPOgQ8zoYi29jt3kYwwdN9L
	KugrKuHec5rGcfL0Rk/rW1yn1Li9+3eyRVAmoVZGVWH/S5bSX08xySAGQ4wcIttw
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drn8v7qgu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Apr 2026 13:30:22 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63RDNlh4031956;
	Mon, 27 Apr 2026 13:30:21 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dsa5g5634-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Apr 2026 13:30:21 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63RDULm319202604
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Apr 2026 13:30:21 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EB3F258052;
	Mon, 27 Apr 2026 13:30:20 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 896385805A;
	Mon, 27 Apr 2026 13:30:20 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.24.30])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 27 Apr 2026 13:30:20 +0000 (GMT)
Message-ID: <4a6cec5383a6df072e7cf14ef885ac9b08952455.camel@linux.ibm.com>
Subject: Re: [PATCH 0/3] ima: add regular file data hash support for sigv3
From: Mimi Zohar <zohar@linux.ibm.com>
To: Kamlesh Kumar <kamlesh0hrs@gmail.com>
Cc: ebiggers@kernel.org, linux-integrity@vger.kernel.org,
        stefanb@linux.ibm.com, Kamlesh Kumar <kam@juniper.net>
In-Reply-To: <20260427125743.35245-1-kam@juniper.net>
References: <20260324203929.2475782-1-zohar@linux.ibm.com>
	 <20260427125743.35245-1-kam@juniper.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Apr 2026 09:30:20 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=CIIamxrD c=1 sm=1 tr=0 ts=69ef64ee cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=OUXY8nFuAAAA:8 a=QSkmVZop8svUlP5Agb8A:9 a=QEXdDO2ut3YA:10
 a=cAcMbU7R10T-QSRYIcO_:22
X-Proofpoint-ORIG-GUID: jLJtZn6JyIH0B7fuD0oB0ZdzbT6nCSSX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDE0MSBTYWx0ZWRfXwpGzjbN0Bbg8
 rywVbEQTU/OEYZQfnPkVCvBaisc8UvA1JlSasCFokJ5OMvxeKIlWG/ld2XzKLfBxSmypEbzQID9
 tioF0klgjOxXg4b0pB6zNY/VLZyRp2v8zQGkdvIzBy3tkpXjvGZcLEndwk8YNLFFvq0XGHdC0Po
 BFznjdwR86C1TcsL/vLa0bz2kv9eD9aofeHEdetSr7VBs2/JeRNUMnhFHW1L95r4bs27epudMyT
 NkHDcFvdIWJUhMTZPfGyGtuA4FD2e4TCQGFvbfLHwB3XxzwBy4NBMB5nZdS9zha1A7Nse43JUKg
 0oQaSj9BmnyjWhh8s/yzKCFM3Lde9XhbTMyMqXTe7YX8dBhTVJrCEOx63m4sEhOfT48S+buxUYy
 i3dqnjHJd4cb2DaltT/mUx+HbaUj0xhSafWYGP2Z8FngIFggIQJCz+QCn/uIaRkYVbSgOr08Sul
 yiKIlG7efdwuH6bEXSw==
X-Proofpoint-GUID: SB5KlBAlLLkojYb4XvzxxcqhDDshCr_X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_04,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 malwarescore=0 suspectscore=0 adultscore=0
 impostorscore=0 lowpriorityscore=0 clxscore=1011 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604270141
X-Rspamd-Queue-Id: 96702473818
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.ibm.com:mid];
	TAGGED_FROM(0.00)[bounces-9343-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[zohar@linux.ibm.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCVD_COUNT_SEVEN(0.00)[11]

On Mon, 2026-04-27 at 18:27 +0530, Kamlesh Kumar wrote:
> On 3/24/26 4:39 PM, Mimi Zohar wrote:
> > IMA signature version 3 (sigv3) support was introduced to avoid file
> > signature ambiguity. Instead of directly signing a raw fs-verity hash,
> > IMA signs the hash of ima_file_id structure, containing the type of
> > signature, the hash algorithm, and the hash.
> >=20
> > Pure ML-DSA calculates and signs the hash directly rather than a
> > pre-hashed digest. To avoid ML-DSA having to re-calculate the file data
> > hash, Eric Biggers suggested signing the smaller ima_file_id structure.
> >=20
> > This patch set adds the sigv3 support for regular file data hashes. A
> > subsequent patch set will add the ML-DSA support.
> >=20
> > Mimi Zohar (3):
> >    ima: Define asymmetric_verify_v3() to verify IMA sigv3 signatures
> >    ima: add regular file data hash signature version 3 support
> >    ima: add support to require IMA sigv3 signatures
> >=20
> >   Documentation/ABI/testing/ima_policy   | 10 ++--
> >   security/integrity/digsig.c            |  8 +--
> >   security/integrity/digsig_asymmetric.c | 58 +++++++++++++++++++++
> >   security/integrity/evm/evm_main.c      |  3 +-
> >   security/integrity/ima/ima.h           |  1 +
> >   security/integrity/ima/ima_appraise.c  | 72 ++++++++-----------------=
-
> >   security/integrity/ima/ima_policy.c    | 22 ++++----
> >   security/integrity/integrity.h         | 14 ++++-
> >   8 files changed, 115 insertions(+), 73 deletions(-)
> >=20
> > --
> > 2.53.0
> >=20
>=20
> I have tested this series along with Stefan's ML-DSA patches [1] and an
> additional fix [2] for ima_get_hash_algo().
> With all patches applied, I am able to successfully sign files with
> ML-DSA-65 and verify IMA sigv3 signatures during appraisal.
>=20
> [1] https://lore.kernel.org/linux-integrity/20260405231224.4008298-1-stef=
anb@linux.ibm.com/
> [2] https://lore.kernel.org/linux-integrity/20260424110751.5637-1-kam@jun=
iper.net/
>=20
> Tested-by: Kamlesh Kumar <kam@juniper.net>

Thanks, Kamlesh!

I'd appreciate re-testing with the v3 version now queued in next-integrity-
testing
https://lore.kernel.org/linux-integrity/20260416154039.1648083-1-stefanb@li=
nux.ibm.com
?

Mimi

