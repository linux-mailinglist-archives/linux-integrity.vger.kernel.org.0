Return-Path: <linux-integrity+bounces-9610-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gK0GMHZoDmoD+gUAu9opvQ
	(envelope-from <linux-integrity+bounces-9610-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Thu, 21 May 2026 04:05:42 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AFFE59DDB3
	for <lists+linux-integrity@lfdr.de>; Thu, 21 May 2026 04:05:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CF8A23029761
	for <lists+linux-integrity@lfdr.de>; Thu, 21 May 2026 02:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40BD1314A6B;
	Thu, 21 May 2026 02:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="W3BKIxOJ"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A731A8F97;
	Thu, 21 May 2026 02:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779329140; cv=none; b=SkpIHjRMiZ8fq2l/sPYEG0eGHvxY8V2FIt4NserMdMQDjc/oPJb4Oi74imWnQWcF20IiaQ9uzavbuxMf4gdVF+HJ+COpB7QZygFRSrBFIW/2qd6sc1fl7kJQ++h02e5gOetBUh5903LnoJyY485bFB9BzUw66yCAn4aezImArao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779329140; c=relaxed/simple;
	bh=cX+s8XndW+pCZGr7A++dOClN7nKItXEB3vYFjorYu1o=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=V070v9XLFQ+bEBT89LYh/mUophQd4jep1tJSEXShEY2wXd8Y2R64Ktbi+cujWLnYk7IalgjCbuAbo8RiscTux037/as5jeuJXNE2Gg+y+ca6mdT5aDCyy1+TvLN1yMJDOooV+Lftl0HHD+SbXEfXBI4/bn9pIElJk9U7+RWahQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=W3BKIxOJ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64KL6Bmo1853987;
	Thu, 21 May 2026 02:05:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=8PSEt6
	911qaGx8YaenR/m76gcNp3+Esd66aa+y3inl0=; b=W3BKIxOJw5sPEY7BY6A0ZJ
	s2kX4V7znr+66cbPeUs0Zbm21hFP5naohRgh7ECPLR8u7C05S2vaJM6tYekZ/eGK
	oLzvyPBuW1EiFXhKrc0pco/ff4aUlcALtIGjQj0U5Vx61lqC6AD4ePiX5lvTQsl5
	GalbXMJsKwklFPK9rxTfLoxwBoSNkQhG2tDMcra+MUlFhJURixLE68+xZQG3bNEe
	e1KMLKQiMALhTpjzoYad2KDUBBmJtRC3zouEw2YvCJouA4QIMWY7/5gqgrSqwHG8
	FPCHL1pHhKLzFuOXeHoPRcSSdxuWgGFyoLLfgsF0Rcd8m0eGMDgtGJF+lpUAw1xw
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6hb8km1b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 May 2026 02:05:06 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64L1s6Ju016931;
	Thu, 21 May 2026 02:05:06 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e72wqa8td-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 May 2026 02:05:06 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64L2556q60359058
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 May 2026 02:05:05 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 08C3A5805F;
	Thu, 21 May 2026 02:05:05 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 08A8D5805E;
	Thu, 21 May 2026 02:05:04 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.96.83])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 21 May 2026 02:05:03 +0000 (GMT)
Message-ID: <02e3032e9e50ca9ff0dd2123118c31d72ea844d9.camel@linux.ibm.com>
Subject: Re: [PATCH v5 01/13] ima: Remove ima_h_table structure
From: Mimi Zohar <zohar@linux.ibm.com>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>, corbet@lwn.net,
        skhan@linuxfoundation.org, dmitry.kasatkin@gmail.com,
        eric.snowberg@oracle.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        gregorylumen@linux.microsoft.com, chenste@linux.microsoft.com,
        nramas@linux.microsoft.com, Roberto Sassu <roberto.sassu@huawei.com>
In-Reply-To: <20260429160319.4162918-2-roberto.sassu@huaweicloud.com>
References: <20260429160319.4162918-1-roberto.sassu@huaweicloud.com>
	 <20260429160319.4162918-2-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 20 May 2026 22:05:03 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDAwOCBTYWx0ZWRfX5eSSs9S9/gMx
 bR/ILX+80JwEOLrcFssH5zfiabrZXuWCXLc5KMLSiL/vCmS+EiQ0R8Lkwuitiy9LqFXFDbX48rp
 xMwLPtY2c6Pn/wYgFleFYBZQPY841jFwfPbZ6PTwp+eZbz4WnZlGM9hK1tW97A1uRJ3JU9P8zY8
 a58dfamaMu4ooPdeYh7vCNfGIGtwWMkZzebRxrRPZlinbX6zu9gAoZT3ldouZIANTZ/p+Hss2eS
 idbm4nG1H/Ux2NQnkrzUUT/OSmo+QdiGb2OFuysra3UQruVUtveRpf3bA4qZqPHvNF4RbPN4Oif
 HRJTHI6FuHGcWn+gJggC69xvX9vPHr3K6xqrLZ3FV0aQ16wPApXRqOYooDyJhOaisqvp0myrhCH
 v9znqhg6Q2LsmcFwN0PQCScVjcnjNNo7wxSbOAdwCLo6922peWY7xTgB/bDQzDuIYuYMJmwaiAS
 skicS2ut5aeK0K/VB/g==
X-Proofpoint-GUID: zy7jWsAwRPud2ZjZn3uKrT0q3VNJrfY7
X-Proofpoint-ORIG-GUID: tj_IKYdMPmyvd7DvAv3LRZqpepJjpJJ1
X-Authority-Analysis: v=2.4 cv=aYBRWxot c=1 sm=1 tr=0 ts=6a0e6853 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=NEAV23lmAAAA:8
 a=i0EeH86SAAAA:8 a=YK1qB_coChW7bZurkuwA:9 a=QEXdDO2ut3YA:10
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9610-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[huaweicloud.com,lwn.net,linuxfoundation.org,gmail.com,oracle.com,paul-moore.com,namei.org,hallyn.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.ibm.com:mid,huawei.com:email];
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
X-Rspamd-Queue-Id: 2AFFE59DDB3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 2026-04-29 at 18:03 +0200, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
>=20

Instead of jumping straight to "With the upcoming change ...", some context=
 is
needed.  Perhaps something like:

The ima_h_table structure is a collection of IMA measurement list metadata =
-
number of records in the IMA measurement list, number of integrity violatio=
ns,
and a hash table containing the IMA template data hash, needed to prevent
measurement list record duplication.

Removing records from the measurement list needs to be reflected in the has=
h
table.  As a pre-req to removing records from the measurement list, separat=
e ...

> With the upcoming change of dynamically allocating and replacing the hash
> table, the ima_h_table structure would have been replaced with a new one.
>=20
> However, since the ima_h_table structure contains also the counters for
> number of measurements entries and violations, we would have needed to
> preserve their values in the new ima_h_table structure.
>=20
> Instead, separate those counters from the hash table, remove the
> ima_h_table structure, and just replace the hash table pointer.
>=20
> Finally, rename ima_show_htable_value(), ima_show_htable_violations()
> and ima_htable_violations_ops respectively to ima_show_counter(),
> ima_show_num_violations() and ima_num_violations_ops.
>=20
> Link: https://github.com/linux-integrity/linux/issues/1
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>


Other than referring to "entries" in the measurement list, the patch looks =
good.
I prefer referring to them as "records".

> ---
>  security/integrity/ima/ima.h       |  9 +++------
>  security/integrity/ima/ima_api.c   |  2 +-
>  security/integrity/ima/ima_fs.c    | 19 +++++++++----------
>  security/integrity/ima/ima_kexec.c |  2 +-
>  security/integrity/ima/ima_queue.c | 17 ++++++++++-------
>  5 files changed, 24 insertions(+), 25 deletions(-)
>=20
> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> index 69e9bf0b82c6..51a8a582df56 100644
> --- a/security/integrity/ima/ima.h
> +++ b/security/integrity/ima/ima.h
> @@ -324,12 +324,9 @@ int ima_lsm_policy_change(struct notifier_block *nb,=
 unsigned long event,
>   */
>  extern spinlock_t ima_queue_lock;
> =20
> -struct ima_h_table {
> -	atomic_long_t len;	/* number of stored measurements in the list */
> -	atomic_long_t violations;
> -	struct hlist_head queue[IMA_MEASURE_HTABLE_SIZE];
> -};
> -extern struct ima_h_table ima_htable;
> +extern atomic_long_t ima_num_entries;

-> ima_num_records	/* Total number of measurement list records */

Will this be the current or total number of measurement list records since =
a
hard boot?

> +extern atomic_long_t ima_num_violations;

Similarly, will this be the current number or total number of violations si=
nce a
hard boot?  Please add a comment.

> +extern struct hlist_head ima_htable[IMA_MEASURE_HTABLE_SIZE];
> =20
>  static inline unsigned int ima_hash_key(u8 *digest)
>  {

thanks,

Mimi

