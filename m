Return-Path: <linux-integrity+bounces-9898-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id U94HDHeRTWok2QEAu9opvQ
	(envelope-from <linux-integrity+bounces-9898-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Wed, 08 Jul 2026 01:53:27 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BA9A3720811
	for <lists+linux-integrity@lfdr.de>; Wed, 08 Jul 2026 01:53:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ibm.com header.s=pp1 header.b=QZQ62sRz;
	dmarc=pass (policy=none) header.from=ibm.com;
	spf=pass (mail.lfdr.de: domain of "linux-integrity+bounces-9898-lists+linux-integrity=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-integrity+bounces-9898-lists+linux-integrity=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 16915301747D
	for <lists+linux-integrity@lfdr.de>; Tue,  7 Jul 2026 23:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 321E731ED7C;
	Tue,  7 Jul 2026 23:53:25 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06AC227BB9
	for <linux-integrity@vger.kernel.org>; Tue,  7 Jul 2026 23:53:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783468405; cv=none; b=PGnxaDNtEYbDR+0kac7ovPI8XR9xuPJ8MrNwMEjhs5jb2R//8RmWzOVT9LkNXS1ySAyGV2/ckLASfjFZ4Z2einATTuqwEr7WHyM8czL0EWL2lRjBV9ayXflxYB8mCvfO930iybB5VKeuSoEqEhuUgbbxOca881XK7LvWWeVMU+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783468405; c=relaxed/simple;
	bh=Cea+LP2URrjv6sAb8kr+yLYILaR+MqiwJ9i6ZTEMx7Q=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=JYnpV1/CUXuS8PJVrWDkkzPZNPtYVBM5PhE1zqUQ+DqZzTaoA3Zn4zk+BSgd5Va4q6mHN9jEOutY73HqjQ9RUM2S6bcd0U3I0BCq3NK+UP6th+R9NqOeTUnDZjtzE9nMkfVLsEvBSvN44B9GbTPrjs3YaGw/D9NZ6ArMkSDr+u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QZQ62sRz; arc=none smtp.client-ip=148.163.156.1
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 667MmDES920448;
	Tue, 7 Jul 2026 23:53:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ySiAm1
	0qfrpWb6gy8fIwlGewMv4R7CfaL6iW90q+EVA=; b=QZQ62sRzQ+o31EMMcICFnH
	PVzygwki5OoP+iNL5rq6l9qKhO1GBomKLrjFj661P9AyL8In23TuUHKsQnZE7rVG
	j7p/rgyblGdX04D9c+xgmWCbai+da5AK1NtPIk0sWMSd7fA+iAwBznY+rZ1JUa/l
	bjVXnawG5SYizBpz5d/S08jDpQWQiwUNVIvW0YOgiHa8lTd2/rCuu1x/XGbSxpo/
	rqDED1FpUIaKeaZlZ4Ll4RATGuCZojSe9M3nFp5uA/cPXeXkbhIthKcOPqOF5nxK
	AYj9M7tORx6sUmg6EbT1O2TQIvl3eX1uD1GXmrLFleOW1VQmsJPQVVGyKUvcqbVQ
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6sp3sw5w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jul 2026 23:53:14 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 667Nne2o016116;
	Tue, 7 Jul 2026 23:53:12 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7cvw5b4s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jul 2026 23:53:12 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 667NrCF519661424
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 7 Jul 2026 23:53:12 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 389415805A;
	Tue,  7 Jul 2026 23:53:12 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D083D5803F;
	Tue,  7 Jul 2026 23:53:11 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.134.9])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  7 Jul 2026 23:53:11 +0000 (GMT)
Message-ID: <e226a648e923f73ee77e6831dbda462a87d8786e.camel@linux.ibm.com>
Subject: Re: [PATCH v5 1/2] ima: add critical data measurement for loaded
 policy
From: Mimi Zohar <zohar@linux.ibm.com>
To: Enrico Bravi <enrico.bravi@polito.it>, linux-integrity@vger.kernel.org,
        dmitry.kasatkin@gmail.com, roberto.sassu@huawei.com
Cc: eric.snowberg@oracle.com
In-Reply-To: <23b77eb601a40063738e0d9c4253fff51e304a11.camel@linux.ibm.com>
References: <20260702190403.5844-1-enrico.bravi@polito.it>
		 <20260702190403.5844-2-enrico.bravi@polito.it>
	 <23b77eb601a40063738e0d9c4253fff51e304a11.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 19:53:11 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=KsJ9H2WN c=1 sm=1 tr=0 ts=6a4d916a cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=PAF7F5xOKOwVW6GuTTMA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDIzMyBTYWx0ZWRfXzqRkFKtB26Ve
 FeJ1kt7v7gWNKpJUFpbNqO9g96JW71Nk3ZGA5XgK3/lhKt6e8K1m91J7S8u25mNoAVE+5ZukIls
 aBkZ7TFPXVBDdqpghF/XMM2TIVoJ+0I=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDIzMyBTYWx0ZWRfX0fWleSymr21/
 DSYenqyuiJyVnGJ30E6vC7Iu74PR4he/9DP/+B8GPDpY/kHupZOIdd9DPluhezn8lS4GEJrCeU0
 7y9SYiiZyV16AcIKGAm5S6j/9/j6jtHaSWK8d3Z/CTjGCQuVSxZ47bBi99uf+hIueqb25rwD2BR
 YNjxLTkucN0CfWPSh1P51iG6vMdAz9OFPE+Whlq97nfeeSo5RxCpsKPlLXls5SAgy8FPSCBzCVz
 cKShVDkOeWxmXUCfj3Frh4ELJtppAHoNsH9XsShxnkyIjRwek96MIVBH5znZHyO7IWpIJFOCCl9
 Gk5uVcElltkExh9/a7nGmGYvdmdlz29PBG1jgicudV5hNMGPsCZ87U8you0lDnuAulRK3VcLwKS
 XpwtDS8jTyrwf7WQ3E7/pVMFmgEpVkxPcmj8PMcCITCjTwMP6uvOTW8Yu3f7Txk6U3CQ5mtwCSb
 FEdut+AIi/I2LtqRkag==
X-Proofpoint-ORIG-GUID: cdvhTfwsa4Q-atZwVJK_UlQXCJxWgKsE
X-Proofpoint-GUID: FoWwKxelF6iAcWdjtswf3q4kqHdc5te0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_06,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 adultscore=0 clxscore=1015
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070233
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-9898-lists,linux-integrity=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[polito.it,vger.kernel.org,gmail.com,huawei.com];
	FORGED_RECIPIENTS(0.00)[m:enrico.bravi@polito.it,m:linux-integrity@vger.kernel.org,m:dmitry.kasatkin@gmail.com,m:roberto.sassu@huawei.com,m:eric.snowberg@oracle.com,m:dmitrykasatkin@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[zohar@linux.ibm.com,linux-integrity@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.ibm.com:mid,linux.ibm.com:from_mime];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zohar@linux.ibm.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BA9A3720811

On Mon, 2026-07-06 at 23:04 -0400, Mimi Zohar wrote:
> On Thu, 2026-07-02 at 21:04 +0200, Enrico Bravi wrote:
> > diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/i=
ma/ima_policy.c
> > index f7f940a76922..a65b7e4b64d6 100644
> > --- a/security/integrity/ima/ima_policy.c
> > +++ b/security/integrity/ima/ima_policy.c
> > @@ -2379,3 +2385,82 @@ bool ima_appraise_signature(enum kernel_read_fil=
e_id id)
> >  	return found;
> >  }
> >  #endif /* CONFIG_IMA_APPRAISE && CONFIG_INTEGRITY_TRUSTED_KEYRING */
> > +
> > +/**
> > + * ima_measure_loaded_policy - measure the active IMA policy ruleset
> > + *
> > + * Must be called with ima_write_mutex held, as it performs two
> > + * separate RCU read passes over ima_rules and relies on the mutex
> > + * to prevent concurrent policy updates between them.
> > + */
> > +void ima_measure_loaded_policy(void)
> > +{
> > +	const char *event_name =3D "ima_policy_loaded";
> > +	const char *op =3D "measure_loaded_ima_policy";
> > +	size_t rule_len =3D max_rule_len + 2;
> > +	struct ima_rule_entry *rule_entry;
> > +	struct list_head *ima_rules_tmp;
> > +	struct seq_file file;
>=20
> Hi Enrico,
>=20
> FYI, there's a merge conflict with commit 51bedcd803e0 ("ima: Mediate
> open/release method of the measurements list".
>=20
> As long as 2/2 needs to be update, there are two nits: initialize seq_fil=
e like
> "file =3D { 0 };".
>=20
> > +	int result =3D -ENOMEM;
> > +	size_t file_len =3D 0;
> > +	char *rule;
> > +
> > +	lockdep_assert_held(&ima_write_mutex);
> > +
> > +	rule =3D vmalloc(rule_len);

FYI, using vmalloc() isn't wrong, but using kmalloc()/kfree() is more commo=
n.=20
Refer to Documentation/core-api/memory-allocation.rst.

Mimi

> > +	if (!rule) {
> > +		integrity_audit_msg(AUDIT_INTEGRITY_PCR, NULL, event_name,
> > +				    op, "ENOMEM", result, 0);
> > +		return;
> > +	}
> > +
> > +	/* calculate IMA policy rules memory size */
> > +	file.buf =3D rule;
> > +	file.read_pos =3D 0;
> > +	file.size =3D rule_len;
> > +	file.count =3D 0;
> > +
> > +	rcu_read_lock();
> > +	ima_rules_tmp =3D rcu_dereference(ima_rules);
> > +	list_for_each_entry_rcu(rule_entry, ima_rules_tmp, list) {
> > +		ima_policy_show(&file, rule_entry);
> > +
> > +		if (seq_has_overflowed(&file)) {
> > +			result =3D -E2BIG;
> > +			integrity_audit_msg(AUDIT_INTEGRITY_PCR, NULL, event_name,
> > +					    op, "rule_length", result, 0);
>=20
> and limit the integrity_audit_msg to 80 chars.
>=20
> Otherwise the patch looks good.
>=20
> Mimi
>=20
> > +			rcu_read_unlock();
> > +			goto free_rule;
> > +		}
> > +
> > +		file_len +=3D file.count;
> > +		file.count =3D 0;
> > +	}
> > +	rcu_read_unlock();
> > +
> > +	/* copy IMA policy rules to a buffer for measuring */
> > +	file.buf =3D vmalloc(file_len);
> > +	if (!file.buf) {
> > +		integrity_audit_msg(AUDIT_INTEGRITY_PCR, NULL, event_name,
> > +				    op, "ENOMEM", result, 0);
> > +		goto free_rule;
> > +	}
> > +
> > +	file.read_pos =3D 0;
> > +	file.size =3D file_len;
> > +	file.count =3D 0;
> > +
> > +	rcu_read_lock();
> > +	ima_rules_tmp =3D rcu_dereference(ima_rules);
> > +	list_for_each_entry_rcu(rule_entry, ima_rules_tmp, list) {
> > +		ima_policy_show(&file, rule_entry);
> > +	}
> > +	rcu_read_unlock();
> > +
> > +	ima_measure_critical_data("ima_policy", event_name, file.buf,
> > +				  file.count, false, NULL, 0);
> > +
> > +	vfree(file.buf);
> > +free_rule:
> > +	vfree(rule);
> > +}

