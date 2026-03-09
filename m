Return-Path: <linux-integrity+bounces-8946-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GF0PIR/irmlPJwIAu9opvQ
	(envelope-from <linux-integrity+bounces-8946-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Mon, 09 Mar 2026 16:07:11 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B8CC23B40B
	for <lists+linux-integrity@lfdr.de>; Mon, 09 Mar 2026 16:07:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 89F943087D00
	for <lists+linux-integrity@lfdr.de>; Mon,  9 Mar 2026 15:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E09F53BE16E;
	Mon,  9 Mar 2026 15:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tsovsDN5"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9EB8258EFF;
	Mon,  9 Mar 2026 15:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773068662; cv=none; b=CW7F3zRxDZF59P8ewcxKr2CmEERmypWzdR/Srs+H0/mpkr/2ufAuiI4hErGIIOMZXDSAfdcC9m793k1Rt6sGtUEoY6KAVkaBJjrvWU0KDZb4Pfr3XvhCp1xRBDEBvHm+ymG7sjZ1mNA7YV9iTSEl96iGTgGnc1F0xxgc1lg1iGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773068662; c=relaxed/simple;
	bh=Y9E4Z9E/tWu9+O1lJltg9G3VDK3rwHuLHZCZOj8vri0=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=lktk2eDPiy7/ZHYNKdE0mqaCeXLVCRS9a9b+yQFF43uc2L5nkknhCPO9NEH+HgcFbpQ5ZWFFo6GXBlFYthPF7r8nZmYP+ro5s9rrjiOEmu50YdqZV65/Naic4k8vNvyQeM1Mpbz9phpMNGMr86bRsYlbvfxeQW9ruu91skdJ5jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tsovsDN5; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 628MMD3N1493050;
	Mon, 9 Mar 2026 15:03:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=eJsmWl
	9HXscCHpoOnTBXgxLOBfsLrA8q1oEitwqFooQ=; b=tsovsDN5TsW++u12nuVxb8
	6FBz6GdAukjGaVJJt1DoG31Dd4lxvIrcDFj+DV/2RbxRhOoxgbt7JcC5F17K7BSt
	uTjK1on6vT3SBGL8NExXsscufW9JipJfJ+8o7VOUNOifTRWAqcWcbDRn5wReDOsu
	is88U7kmEtmSyyzES2E/grCI5tW72EkkLe2korcjoEJwGTD8C1o9sSTx4YY5Znf0
	0twcB41spu6IxJFoHc8zFJj3dRF18IlEvkLpfO0Sn3h9RETPkWvXqRDDlijEqnxm
	XXTQmgeEu5mGaxjbD5GAOpWwLKPKI6A8Ypv+9xCQ+HJL47uQzBBLBTHGjDgN0HJA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4crcyw73jc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Mar 2026 15:03:41 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 629AbxLv025033;
	Mon, 9 Mar 2026 15:03:40 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cs0jjw85x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Mar 2026 15:03:40 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 629F3eTZ19792528
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 9 Mar 2026 15:03:40 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 088D258059;
	Mon,  9 Mar 2026 15:03:40 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CDA8158043;
	Mon,  9 Mar 2026 15:03:38 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.73.138])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  9 Mar 2026 15:03:38 +0000 (GMT)
Message-ID: <c1d570271884159e6c14617fa7dcd39bc2103e45.camel@linux.ibm.com>
Subject: Re: [PATCH v2 v2] evm: check return values of crypto_shash
 functions
From: Mimi Zohar <zohar@linux.ibm.com>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>,
        Daniel Hodges
	 <git@danielhodges.dev>
Cc: roberto.sassu@huawei.com, dmitry.kasatkin@gmail.com,
        eric.snowberg@oracle.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <6ce273a26b396232f3ee64a980575562e766c501.camel@huaweicloud.com>
References: <aYNprpzxppKE0Gf2@fb.com>
		 <20260206024240.19059-1-git@danielhodges.dev>
	 <6ce273a26b396232f3ee64a980575562e766c501.camel@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Mar 2026 11:03:38 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDEzNiBTYWx0ZWRfX9UYLtICT+1LW
 c2FTY9iVp68hMJX96VTZgKdDBX6wL4N1qJ22/W6rb/7bJMf65LTB0XgfiVeYmj9cZzDNheJjCVE
 FqXvYkbc9IlNL9TVHCzM1MZdgep2XIE2toO+U3eiQdjQMxgINRQQyaIXzrio30j7lnx1fbu1dpA
 NhggSQ2FsGHHn6FF57sClhvxo54rXluwrFXyIqIULOV8wZ25D5U/fcR+ALygwTa0hhC4h53luiB
 tIv0kkvefh46D/p6j2Szl/6I0GwBzru/7e08Yux7YDSNExmXnghmv7C1fNlDbYEvyu76xXlnZFC
 cH2DxZlmsX93DlPjkbBNwxYRx1j3elfawb0H89EOEcHiFchncGwvns5ZZiuyemp3KifhMTL4Ggk
 i2SFfabkqoe0/8ku0Lo7uvHm2vOHru23FGMSfUdPMXqZtNbHZWhma+Egy9ZX2iimQ8FBijIlBUV
 AChTKQ7FPXfvMaIVCew==
X-Authority-Analysis: v=2.4 cv=QaVrf8bv c=1 sm=1 tr=0 ts=69aee14e cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=i0EeH86SAAAA:8
 a=23jcPEmS34k7qPULnOIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: p1QpP31w_H5Cwguvjn9cOC30GZXntYia
X-Proofpoint-ORIG-GUID: ldIXQIqXIeDiKZNXhPIpWug7aKerVfrk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_04,2026-03-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 impostorscore=0 clxscore=1011 adultscore=0
 bulkscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603090136
X-Rspamd-Queue-Id: 2B8CC23B40B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[huawei.com,gmail.com,oracle.com,paul-moore.com,namei.org,hallyn.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	TAGGED_FROM(0.00)[bounces-8946-lists,linux-integrity=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,huawei.com:email,linux.ibm.com:mid,danielhodges.dev:email];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zohar@linux.ibm.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.992];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Action: no action

On Thu, 2026-02-19 at 10:26 +0100, Roberto Sassu wrote:
> On Thu, 2026-02-05 at 21:42 -0500, Daniel Hodges wrote:
> > The crypto_shash_update() and crypto_shash_final() functions can fail
> > and return error codes, but their return values were not being checked
> > in several places in security/integrity/evm/evm_crypto.c:
> >=20
> > - hmac_add_misc() ignored returns from crypto_shash_update() and
> >   crypto_shash_final()
> > - evm_calc_hmac_or_hash() ignored returns from crypto_shash_update()
> > - evm_init_hmac() ignored returns from crypto_shash_update()
> >=20
> > If these hash operations fail silently, the resulting HMAC could be
> > invalid or incomplete, which could weaken the integrity verification
> > security that EVM provides.
> >=20
> > This patch converts hmac_add_misc() from void to int return type and
> > adds proper error checking and propagation for all crypto_shash_*
> > function calls. All callers are updated to handle the new return values=
.
> > Additionally, error messages are logged when cryptographic operations
> > fail to provide visibility into the failure rather than silently
> > returning error codes.
> >=20
> > Fixes: 66dbc325afce ("evm: re-release")
> > Signed-off-by: Daniel Hodges <git@danielhodges.dev>
>=20
> After fixing the minor issue below:
>=20
> Reviewed-by: Roberto Sassu <roberto.sassu@huawei.com>

Thanks Daniel, Roberto.  Daniel there are a couple of places where the line
length is greater than 80.  To see them, add "--max-line-length=3D80" to
scripts/checkpatch.pl.  I'd appreciate your fixing them.  Otherwise, the pa=
tch
looks good.

Thanks,=20

Mimi

