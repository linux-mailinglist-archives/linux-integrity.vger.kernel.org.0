Return-Path: <linux-integrity+bounces-8960-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CHMTMOVHsGnFhgIAu9opvQ
	(envelope-from <linux-integrity+bounces-8960-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Mar 2026 17:33:41 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A853254DE0
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Mar 2026 17:33:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9261D312DE1B
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Mar 2026 16:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B06983BF66B;
	Tue, 10 Mar 2026 16:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mEyspq3U"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EBB338BF94;
	Tue, 10 Mar 2026 16:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773158746; cv=none; b=rgLs0UAiwcVQuPLfN9l56oA2I9j/PQaL+D+AFkWraVbAqsbSs8lgKlTajY3fM2M0iIzerU06j3v56ZuQm2BKYWMmyP1KHVd4wYdyzd+rpnjwIRkzjgSenh0E4UDprMLNCp7VEEs0GglUrSXLuejIkj070zVFqXE46Z+IYvX5AGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773158746; c=relaxed/simple;
	bh=QjmXv3J82aNpVvxsT/+P2fPbW9qzk6DDf510Ul/2zYM=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=Rilyk967LzaJ9/XxGJOFBcK1Iubqu5BrU5eZ8hCbMhTGBKIn48p7DNQMUYfWfoya9oBkXsEI5K5H7UpUdlwKWy78seTeo4j5iCjYr+BJWCseZ66zHF/7zo4PFBmurCDmqsHRR1KNI+knXHO7ssTxQtUWUrAbck+vdxEIDjDiaag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mEyspq3U; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62A9JfCg1455623;
	Tue, 10 Mar 2026 16:05:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=cWnPbA
	Lr4v7J4i6+UyjhgVFwJufozAm4abfHYh9aPE8=; b=mEyspq3Ue7i9i+oZlvSgRj
	wqiWSvltjpT/A/iEAUDZJ6YfVBbTUGJ1aaEwKkvZjMrA/KnvmaC5gkZ7mOiBE/v/
	epgfKXPHAVG7P3hHXfX9u4KXXIl7ukMQGipHzgwoB3tZ5fwyffniZWVXFYNdvM/v
	a6LmwI1JuB5UAEQHI6mba/JqONdaK+i4xdFaBprA2UCUtqCfXrtJ15TRxrqUrUJQ
	iyHbhz1B7veM79DdjMmIdu+N6UErZfLGCAJX09k8Qr3EpmqH7ce4tHMwe0VBdwbw
	A9IilKaOT8EtPb4tIaZc6RBii0x1a6o+PY2m556sTBKZN4F6qD0zvC6MNE+mfMpA
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4crcuybq24-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Mar 2026 16:05:17 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62AFsJsG021521;
	Tue, 10 Mar 2026 16:05:16 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4crxbssx72-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Mar 2026 16:05:16 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62AG5FEK63504758
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Mar 2026 16:05:15 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3BF9658067;
	Tue, 10 Mar 2026 16:05:15 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3F6B15805A;
	Tue, 10 Mar 2026 16:05:14 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.8.247])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 10 Mar 2026 16:05:14 +0000 (GMT)
Message-ID: <93bdbda8ff7d732baccc6b2ccfc28d1e2f25d731.camel@linux.ibm.com>
Subject: Re: [PATCH 2/2] EVM: add comment describing why ino field is still
 unsigned long
From: Mimi Zohar <zohar@linux.ibm.com>
To: Jeff Layton <jlayton@kernel.org>, Christian Brauner
 <brauner@kernel.org>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>,
        Roberto Sassu	
 <roberto.sassu@huawei.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Eric Snowberg <eric.snowberg@oracle.com>,
        Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn"	 <serge@hallyn.com>
Cc: linux-nilfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org
In-Reply-To: <20260310-iino-u64-v1-2-18422a053b04@kernel.org>
References: <20260310-iino-u64-v1-0-18422a053b04@kernel.org>
	 <20260310-iino-u64-v1-2-18422a053b04@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Mar 2026 12:05:13 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=EK4LElZC c=1 sm=1 tr=0 ts=69b0413d cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=lgndsluPPLUQNjNvJxsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEwMDEzOSBTYWx0ZWRfX7AfBZa7SBzJt
 rgrndk7Bjmgqakq2EUmANRrO52qlOeuNSsn2Pa0x5dZ5oS/F1UX1LdflCsAsqphIpaigdNuffOX
 iPoMZaSocQpo4N2x+2PuWyDHY4+y5A7TZO0EDaSJHbHsCFdKIqdSLBnWT/j3puqtO3n1nsiawxW
 fBVE5ej+2eeKXX96ClVOg+Q6Y2Uql8oYMxb7eeAgu2F52NC4uW9Zll/wrWWsqZMhhX5IsPqT0Al
 nqBJ/ADZ9SGhM7/tXIuiIrmgWBDJ6aEwxqtYWJmxEKh51pJnc5bpd4kiBgX7ok1KvvuaOMVKPhD
 0wtbaRmjGypif2GUjXRi7m4ucD5ApPH0T9FL1hdL8pXWNz/1AHuTspLIH4Hj+iLpdSYIspBwPdA
 K5lsJjqAHADWJF+G1VFW0e5AAv7Ao0AxFajPzCZwojfEfue9byUNP0TBUamCKLMu0CQi9Opt/55
 0Qxc3TU+zeFnNc71oYQ==
X-Proofpoint-GUID: E-t0rJBRUI1-ZiXIQ2YHBUAuMgBw3s1q
X-Proofpoint-ORIG-GUID: A-FOOk-YvSOo99TgQ_TIFUetByEWl4mX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_03,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0 clxscore=1011
 bulkscore=0 impostorscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603100139
X-Rspamd-Queue-Id: 5A853254DE0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8960-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,dubeyko.com,huawei.com,oracle.com,paul-moore.com,namei.org,hallyn.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.ibm.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
X-Rspamd-Action: no action

On Tue, 2026-03-10 at 07:43 -0400, Jeff Layton wrote:
> Mimi pointed out that we didn't widen the inode number field in struct
> h_misc alongside the inode->i_ino widening. While we could make an
> equivalent change there, that would force EVM remeasurement on all
> 32-bit hosts.

Instead of saying "force EVM remeasurement" say, "require EVM resigning".

>=20
> Instead, leave the field as an unsigned long. This should have no effect
> on 64-bit hosts, and allow things to continue working on 32-bit hosts in
> the cases where the i_ino fits in 32-bits.
>=20
> Add a comment explaining why it's being left as unsigned long.
>=20
> Cc: Mimi Zohar <zohar@linux.ibm.com>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  security/integrity/evm/evm_crypto.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/security/integrity/evm/evm_crypto.c b/security/integrity/evm=
/evm_crypto.c
> index c0ca4eedb0fe5d5c30f45f515a4bc90248ec64ea..3445f4c2097f7e8af61de6299=
b721fc4a1d8afb4 100644
> --- a/security/integrity/evm/evm_crypto.c
> +++ b/security/integrity/evm/evm_crypto.c
> @@ -144,6 +144,12 @@ static void hmac_add_misc(struct shash_desc *desc, s=
truct inode *inode,
>  			  char type, char *digest)
>  {
>  	struct h_misc {
> +		/*
> +		 * Although inode->i_ino is now u64, this field remains
> +		 * unsigned long to allow existing hashes from 32-bit hosts
> +		 * to continue working when i_ino hasn't changed and fitsxi
> +		 * in a u32.

security.evm contains either an HMAC or signature.  Change "hashes" -> HMAC=
 and
signatures"

Mimi

> +		 */
>  		unsigned long ino;
>  		__u32 generation;
>  		uid_t uid;

