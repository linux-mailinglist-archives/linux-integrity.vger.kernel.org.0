Return-Path: <linux-integrity+bounces-9889-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id y1iLK75sTGpukQEAu9opvQ
	(envelope-from <linux-integrity+bounces-9889-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 07 Jul 2026 05:04:30 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2262B716EEE
	for <lists+linux-integrity@lfdr.de>; Tue, 07 Jul 2026 05:04:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ibm.com header.s=pp1 header.b=PJ99Ix8y;
	dmarc=pass (policy=none) header.from=ibm.com;
	spf=pass (mail.lfdr.de: domain of "linux-integrity+bounces-9889-lists+linux-integrity=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-integrity+bounces-9889-lists+linux-integrity=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2F32C301EB7E
	for <lists+linux-integrity@lfdr.de>; Tue,  7 Jul 2026 03:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46ED913B293;
	Tue,  7 Jul 2026 03:04:27 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6E63603EE
	for <linux-integrity@vger.kernel.org>; Tue,  7 Jul 2026 03:04:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783393467; cv=none; b=l/fx0JFIahaG2Uj+lEvoN49VaYJwi8tjECr5MV3NC2zNzli9k9wCB3x3pwc/8KniT3gKR9tWmDYBURyat9lPSpN5FawWjwHzyP97REhAPj47su8LlIu1VhE0yhxJl00Vuq9qBtVuR+xCSe3IKOohyZIlQAAcqusrKSR7NbVaQkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783393467; c=relaxed/simple;
	bh=pMqtrTlKEae21aY64leA/ucfOsXWSV/9anlcpP7M4BY=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=mjt4+PQMRjnrzzthMTgn1fUT98BruhTGmsLcXpcOe5AHQnj5heMvbnIXkVTIBSRNgyg4NgNQtGlX8hT1WAB3F4l93kd7ojBTvDcItgjzJytWp3iUTwUhzvSmn8CDmBPRMB1ZE2zfazqwPUA+CivolsC32xvSbFrESc/KJsY+9BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PJ99Ix8y; arc=none smtp.client-ip=148.163.158.5
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666KIWfa534425;
	Tue, 7 Jul 2026 03:04:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Kry3wF
	Bb3zqTMDGLHJvSoL6vVcRARg7li4fEj2khA68=; b=PJ99Ix8yYyzvdkp0KmobNp
	w3UsKZmEUU/IedCICqI4Cx5AVBM5tSH4bm9kviTtnESRpRrTgJud1TEAVuIxh6bx
	vD+X7ImKWwDYzkWb93DE+h6GJz0rcPqAZgTyemk6V8hEJXm2dS352baO39JcHLSV
	veS12s8sx11NIf5w6Xldy//9kuiYvqE4alVBiT7l+8pgDwa7p+DY/ViALsmFVHix
	lioTIsmgmaVIleBH1E7/YHlYOdW1Y8eWhIR+x1iaHYDnWkfWuxhVnIf63adZ0NSN
	cnIY3Y4oPTys7PF3VxTOsOIdHdR4vDAuv03Gf97jSDafenf6quZESMQVxYhCdWAQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6stsn5sm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jul 2026 03:04:14 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6672ngQG023264;
	Tue, 7 Jul 2026 03:04:13 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7cgq0rq5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jul 2026 03:04:13 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66734DlG21758680
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 7 Jul 2026 03:04:13 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 27CE458056;
	Tue,  7 Jul 2026 03:04:13 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BD8CF58052;
	Tue,  7 Jul 2026 03:04:12 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.12.88])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  7 Jul 2026 03:04:12 +0000 (GMT)
Message-ID: <23b77eb601a40063738e0d9c4253fff51e304a11.camel@linux.ibm.com>
Subject: Re: [PATCH v5 1/2] ima: add critical data measurement for loaded
 policy
From: Mimi Zohar <zohar@linux.ibm.com>
To: Enrico Bravi <enrico.bravi@polito.it>, linux-integrity@vger.kernel.org,
        dmitry.kasatkin@gmail.com, roberto.sassu@huawei.com
Cc: eric.snowberg@oracle.com
In-Reply-To: <20260702190403.5844-2-enrico.bravi@polito.it>
References: <20260702190403.5844-1-enrico.bravi@polito.it>
	 <20260702190403.5844-2-enrico.bravi@polito.it>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 23:04:12 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: MMj-BQTwtxFiCZgVeglhY8di1a_F0kRy
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDAyNSBTYWx0ZWRfXwVROOdGD663t
 JibS+83a3oV8ka/Y7Uo86NQBswXSRfiED3VnMTBQ73DeQKkrmQ9ZSx+oEfPC1B0tJqtF20lrUuE
 u848d61Rf1hCaG9xjd0A9qg3ZwCrfVU=
X-Authority-Analysis: v=2.4 cv=DKW/JSNb c=1 sm=1 tr=0 ts=6a4c6cae cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=RNHT0xqgNCNJLLHkEisA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: w0CIH2lApqhDPjOzVbzDaEgioR0NRJR_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDAyNSBTYWx0ZWRfX1nd0kdUvIZnQ
 zkRMlvzxNluTMpprcDpj4AGtLzPdsSVCdCnH5zpp9F6FLwQdtZcRzDF3FLWg2jQ9vZzWh7cZf5A
 hqVnl9kMyUM3Mi3aCZvZjs4Lqpw85IK46WWz06JEsAyK1Q1PhtOIZ24qoYvPYOou+oUNZiZHmK3
 APn2CD4ajsHEm/e4bvHKWggltG5mvR6UctPleb4Esuk5S3bUUJQfkNV2iJxC4/uX236LDxhtcJY
 XvxjL9GosXQmIs1mxqWK3+Ar1JRxQ2vYVEgx/5KIKmDY66uhvUcYY8iTvJkqFlJGjXtns4kTQWx
 8KM4gGkyYE3wkNrKRxZcdgfkrwortwm1o+wQNu+bqY+YF2PGfNR+qVOd3lnheTv/M5zsbXt5pT0
 kdxvl+LyoYMRyClVF2X0n0KGyTOnSfaEMrwK/PSy+lYPqRNsh0rlPF5KBbC8Acl0hOC/jI/kd3x
 e+vGa9RxvpoBFr0uAyA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 phishscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607070025
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-9889-lists,linux-integrity=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[polito.it,vger.kernel.org,gmail.com,huawei.com];
	FORGED_RECIPIENTS(0.00)[m:enrico.bravi@polito.it,m:linux-integrity@vger.kernel.org,m:dmitry.kasatkin@gmail.com,m:roberto.sassu@huawei.com,m:eric.snowberg@oracle.com,m:dmitrykasatkin@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[zohar@linux.ibm.com,linux-integrity@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.ibm.com:mid,linux.ibm.com:from_mime];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2262B716EEE

On Thu, 2026-07-02 at 21:04 +0200, Enrico Bravi wrote:
> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima=
/ima_policy.c
> index f7f940a76922..a65b7e4b64d6 100644
> --- a/security/integrity/ima/ima_policy.c
> +++ b/security/integrity/ima/ima_policy.c
> @@ -2379,3 +2385,82 @@ bool ima_appraise_signature(enum kernel_read_file_=
id id)
>  	return found;
>  }
>  #endif /* CONFIG_IMA_APPRAISE && CONFIG_INTEGRITY_TRUSTED_KEYRING */
> +
> +/**
> + * ima_measure_loaded_policy - measure the active IMA policy ruleset
> + *
> + * Must be called with ima_write_mutex held, as it performs two
> + * separate RCU read passes over ima_rules and relies on the mutex
> + * to prevent concurrent policy updates between them.
> + */
> +void ima_measure_loaded_policy(void)
> +{
> +	const char *event_name =3D "ima_policy_loaded";
> +	const char *op =3D "measure_loaded_ima_policy";
> +	size_t rule_len =3D max_rule_len + 2;
> +	struct ima_rule_entry *rule_entry;
> +	struct list_head *ima_rules_tmp;
> +	struct seq_file file;

Hi Enrico,

FYI, there's a merge conflict with commit 51bedcd803e0 ("ima: Mediate
open/release method of the measurements list".

As long as 2/2 needs to be update, there are two nits: initialize seq_file =
like
"file =3D { 0 };".

> +	int result =3D -ENOMEM;
> +	size_t file_len =3D 0;
> +	char *rule;
> +
> +	lockdep_assert_held(&ima_write_mutex);
> +
> +	rule =3D vmalloc(rule_len);
> +	if (!rule) {
> +		integrity_audit_msg(AUDIT_INTEGRITY_PCR, NULL, event_name,
> +				    op, "ENOMEM", result, 0);
> +		return;
> +	}
> +
> +	/* calculate IMA policy rules memory size */
> +	file.buf =3D rule;
> +	file.read_pos =3D 0;
> +	file.size =3D rule_len;
> +	file.count =3D 0;
> +
> +	rcu_read_lock();
> +	ima_rules_tmp =3D rcu_dereference(ima_rules);
> +	list_for_each_entry_rcu(rule_entry, ima_rules_tmp, list) {
> +		ima_policy_show(&file, rule_entry);
> +
> +		if (seq_has_overflowed(&file)) {
> +			result =3D -E2BIG;
> +			integrity_audit_msg(AUDIT_INTEGRITY_PCR, NULL, event_name,
> +					    op, "rule_length", result, 0);

and limit the integrity_audit_msg to 80 chars.

Otherwise the patch looks good.

Mimi

> +			rcu_read_unlock();
> +			goto free_rule;
> +		}
> +
> +		file_len +=3D file.count;
> +		file.count =3D 0;
> +	}
> +	rcu_read_unlock();
> +
> +	/* copy IMA policy rules to a buffer for measuring */
> +	file.buf =3D vmalloc(file_len);
> +	if (!file.buf) {
> +		integrity_audit_msg(AUDIT_INTEGRITY_PCR, NULL, event_name,
> +				    op, "ENOMEM", result, 0);
> +		goto free_rule;
> +	}
> +
> +	file.read_pos =3D 0;
> +	file.size =3D file_len;
> +	file.count =3D 0;
> +
> +	rcu_read_lock();
> +	ima_rules_tmp =3D rcu_dereference(ima_rules);
> +	list_for_each_entry_rcu(rule_entry, ima_rules_tmp, list) {
> +		ima_policy_show(&file, rule_entry);
> +	}
> +	rcu_read_unlock();
> +
> +	ima_measure_critical_data("ima_policy", event_name, file.buf,
> +				  file.count, false, NULL, 0);
> +
> +	vfree(file.buf);
> +free_rule:
> +	vfree(rule);
> +}

