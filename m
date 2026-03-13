Return-Path: <linux-integrity+bounces-8993-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CGKeAZ5qtGn9ngAAu9opvQ
	(envelope-from <linux-integrity+bounces-8993-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 13 Mar 2026 20:50:54 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E18482896FF
	for <lists+linux-integrity@lfdr.de>; Fri, 13 Mar 2026 20:50:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5243A3027E13
	for <lists+linux-integrity@lfdr.de>; Fri, 13 Mar 2026 19:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6749A3E0247;
	Fri, 13 Mar 2026 19:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="S3nOlJDd"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61613B777C;
	Fri, 13 Mar 2026 19:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773431443; cv=none; b=hzVQlnIs4TfImTGHu8tTI0pspEmTcx5Aaj2IkKCK91bmG8b65saquIJ5tmnLsAMDEcXEVAXaLTQo65ofVMSDKxZ7fSVKdThKAnvX+lpSaTIvraTseJ/A1eNzw/A4LLQr1rvy3XGZJV0eswxL6PynVqwQkj+pNDtwJvuca3D6RdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773431443; c=relaxed/simple;
	bh=hncn5BCKObZONCZsgpKJyKge4JN0MuOzMVcsOCaE9z8=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=tNM+FxciLRYf/FnnRh2A8tKiM8V+UPxV0wLdfvuhPDK8IGfmimkgvTQZ17IWvlUeTWZRG018Hfs3v/WIOjqqhByNnC434c06dFYgb5AgoH9xg3Q9DpqonClmTrbY1fXaWMYF2kv+9Qwh/e35M8Vf7JumHs2CoBpgsk+PgHxJ/Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=S3nOlJDd; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62DHrIMO2279199;
	Fri, 13 Mar 2026 19:50:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=QCy4pl
	8G59y/3LGebq3uU8uZ9lRFoZKVhvLxcLxUsL4=; b=S3nOlJDdApv9mEZQQHpPic
	NZ//xMA6DLpu0SD1EMLQ4PNjwswKRiBHTpULZJEOsWFqrHg1YQT+yQubxeVbA9zP
	Kvmke6ZVyslXDE7kIahznlihpBMKOdrHdn/yO73zoLjdxmaIorGUtP2dAY59plhs
	dFp3VyPF4fo5fuF9ZXkAKr447L8CqHkKNhJvYGzDH2IYTjb960MtN0dkk0uwGmeR
	A1phjR34oRZ7YQFxGwFCxqi68UBYuCjNnVvfrmtu1yQ+2rDybI5Bn1T2TvrhThwG
	2OMZAX9WQ66KPYSeacwOU9lyeA09yy+IEANJpdg19vVEoU5ZVaIFQtVnneKaGJjg
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cuh91sgb3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Mar 2026 19:50:16 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62DJ4foi008820;
	Fri, 13 Mar 2026 19:50:15 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cuha784j2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Mar 2026 19:50:15 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62DJoEir32244232
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Mar 2026 19:50:14 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9853958059;
	Fri, 13 Mar 2026 19:50:14 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1221458066;
	Fri, 13 Mar 2026 19:50:13 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.190.35])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 13 Mar 2026 19:50:12 +0000 (GMT)
Message-ID: <247c2ee1da486aef7b66b317743ded6271d2b2e2.camel@linux.ibm.com>
Subject: Re: [PATCH v2 2/2] EVM: add comment describing why ino field is
 still unsigned long
From: Mimi Zohar <zohar@linux.ibm.com>
To: Jeff Layton <jlayton@kernel.org>,
        Ryusuke Konishi	
 <konishi.ryusuke@gmail.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>,
        Christian Brauner	 <brauner@kernel.org>,
        Roberto Sassu
 <roberto.sassu@huawei.com>,
        Dmitry Kasatkin	 <dmitry.kasatkin@gmail.com>,
        Eric Snowberg <eric.snowberg@oracle.com>,
        Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn"	 <serge@hallyn.com>
Cc: linux-nilfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
In-Reply-To: <20260313-iino-u64-v2-2-f9abda2464d5@kernel.org>
References: <20260313-iino-u64-v2-0-f9abda2464d5@kernel.org>
	 <20260313-iino-u64-v2-2-f9abda2464d5@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Mar 2026 15:50:12 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: DuF97vR81Tvmpk6h4ouo44YtbbzRF-Ef
X-Authority-Analysis: v=2.4 cv=E6/AZKdl c=1 sm=1 tr=0 ts=69b46a78 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=wTD1aXBEoiP3mpnRQToA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDE1NSBTYWx0ZWRfX4rBm9XPKx3jx
 Sg9CIIbU6AzuVdeUUdqhj4v6r1WwJo1P8OyijzSDGmCg55SHkgAwNramzoY1hcEpJ0e4Pmi8XFY
 aucTCbxi4Xwu0ChonruUzPcEiDaWFL8R8F457q1hsWs8jRGwecFwhRdGUa8xTa0WF2+scZ0zCoF
 w5s+t7usi7B6fQTtBKHh1sMbhBBpMZxz1hxfnzhergusyaFAgulYhzW71AzsAP4Phgc+wPakaqx
 SWO7bW71Serv/gIy/Rrx0dqGt5NxvnRzip3lOHIVx/iYbkpYIvQtkD6jf0YkyFXXPwWBF/eAkCS
 c5+J6m4Mms19dXFABSyAkcs0+7UfJInMRiETGDtK6uA1I8JGGrZE/vaTw74TgFuaiavkO5Spf54
 h53LiFy8AKw01xQlxWmU00ec5NJwvoOiIOL57uO44FL/zu7Gb0yFrlXwQrRRJ8+saHmN6S60662
 lzD0az/jjbqyHb2OnlQ==
X-Proofpoint-ORIG-GUID: GtoohHtJBL3J7ckGlBw5vIRtiEzmahFq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_03,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1015 malwarescore=0 phishscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603130155
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8993-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,dubeyko.com,huawei.com,oracle.com,paul-moore.com,namei.org,hallyn.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.ibm.com:mid];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
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
X-Rspamd-Queue-Id: E18482896FF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 2026-03-13 at 14:45 -0400, Jeff Layton wrote:
> Mimi pointed out that we didn't widen the inode number field in struct
> h_misc alongside the inode->i_ino widening. While we could make an
> equivalent change there, that would require EVM resigning on all 32-bit
> hosts.
>=20
> Instead, leave the field as an unsigned long. This should have no effect
> on 64-bit hosts, and allow things to continue working on 32-bit hosts in
> the cases where the i_ino fits in 32-bits.
>=20
> Add a comment explaining why it's being left as unsigned long.
>=20
> Cc: Mimi Zohar <zohar@linux.ibm.com>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Thanks, Jeff.

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>


> ---
>  security/integrity/evm/evm_crypto.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/security/integrity/evm/evm_crypto.c b/security/integrity/evm=
/evm_crypto.c
> index c0ca4eedb0fe5d5c30f45f515a4bc90248ec64ea..1c41af2f91a60a714878ff93b=
554c90e45546503 100644
> --- a/security/integrity/evm/evm_crypto.c
> +++ b/security/integrity/evm/evm_crypto.c
> @@ -144,6 +144,12 @@ static void hmac_add_misc(struct shash_desc *desc, s=
truct inode *inode,
>  			  char type, char *digest)
>  {
>  	struct h_misc {
> +		/*
> +		 * Although inode->i_ino is now u64, this field remains
> +		 * unsigned long to allow existing HMAC and signatures from
> +		 * 32-bit hosts to continue working when i_ino hasn't changed
> +		 * and fits in a u32.
> +		 */
>  		unsigned long ino;
>  		__u32 generation;
>  		uid_t uid;

