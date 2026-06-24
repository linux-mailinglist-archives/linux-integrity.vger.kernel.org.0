Return-Path: <linux-integrity+bounces-9829-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rQYVJqc/PGq1lggAu9opvQ
	(envelope-from <linux-integrity+bounces-9829-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Wed, 24 Jun 2026 22:35:51 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E586A6C1362
	for <lists+linux-integrity@lfdr.de>; Wed, 24 Jun 2026 22:35:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ibm.com header.s=pp1 header.b=pMAAfbAc;
	spf=pass (mail.lfdr.de: domain of "linux-integrity+bounces-9829-lists+linux-integrity=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-integrity+bounces-9829-lists+linux-integrity=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=ibm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B888B300CE40
	for <lists+linux-integrity@lfdr.de>; Wed, 24 Jun 2026 20:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C9EA39A7F0;
	Wed, 24 Jun 2026 20:35:49 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1BB5308F26
	for <linux-integrity@vger.kernel.org>; Wed, 24 Jun 2026 20:35:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782333349; cv=none; b=YWhKQGpT/+QVtqtIyTIVSqhIcbsB1NzAa+9Bizi3LvxIfU0xTpS7r+9rD6bC7fJLt0Usnyvw5UEEzJ8ZLVGYARrVoKmEINEsIRIKxihnSmYyid5+o5wdZ/R3MhImlwjBXhl32l2+YUEHVv2UtY73ADmhmMt08KSFlaGDeF8nhdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782333349; c=relaxed/simple;
	bh=XsK47gus/wYyvwrqKXoo0bDYs+3ZvDiEhb3Us4kDOJk=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=tkLiZ62zAEMNNw0JbbHbiFRraAJoQ9JdITZIYW/frMK6Ek7DWchBAP5DI+aW6AgUq1CTRfmGUQP38CUGsDmJLai/Qd3JY5EzJSnjGoOfUCtKsyOP/AdNN4wHfjXATF9VyBJ95LrATMlKRJuhIRNlYMCTsvy5yhNNF3JQ7ZD7Ih8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pMAAfbAc; arc=none smtp.client-ip=148.163.158.5
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65OJmO5Q1947283;
	Wed, 24 Jun 2026 20:35:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=mL0Ap8
	pbFV4IJkLlN3xJiRHCvWVWn59hDBDgBZwigPM=; b=pMAAfbAcSNdPQRoXpFo8Y2
	esKz8b+rfpk1x1AU6SpWfx5zE8Hi1XfCbxkB5kAA0nJpt+MA5mpy5mBt8vu+/fev
	X1ZdL6AZUwzXG1IFl+8qGTV+pInfnh5gYOlR3qIjT17PGIjABBIIJLdP74nIGWep
	5kGgDssoF6dI+n6C2GZwNSSBojGwkrXQCHiiqO99bbx+nykLVBe6hpRkf3BwCv4D
	iUb1KtUerhx/Nr3pdYjKhi7V9JDiH+luZjdscVYQpARVBoLLZY+5fR5BHOd8rQJD
	qmaSt//EKAsVZHtZIIXzbVxyYinC7H4u0QgU30HxQ4enY2AE4iu19qGCDMCIsiQw
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewh9gp61s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jun 2026 20:35:33 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65OKYe0g015806;
	Wed, 24 Jun 2026 20:35:33 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ex7dgaf2w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jun 2026 20:35:33 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65OKZW1G15335936
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jun 2026 20:35:32 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 70BFA58052;
	Wed, 24 Jun 2026 20:35:32 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EC9B358050;
	Wed, 24 Jun 2026 20:35:31 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.31.96.173])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 24 Jun 2026 20:35:31 +0000 (GMT)
Message-ID: <1f23b6cb35538f471dbb68534308784616130cb9.camel@linux.ibm.com>
Subject: Re: [PATCH v4 1/2] ima: measure loaded policy after write on
 securityfs policy file
From: Mimi Zohar <zohar@linux.ibm.com>
To: Enrico Bravi <enrico.bravi@polito.it>, linux-integrity@vger.kernel.org,
        dmitry.kasatkin@gmail.com, roberto.sassu@huawei.com
Cc: eric.snowberg@oracle.com
In-Reply-To: <20260617155832.434517-2-enrico.bravi@polito.it>
References: <20260617155832.434517-1-enrico.bravi@polito.it>
	 <20260617155832.434517-2-enrico.bravi@polito.it>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Jun 2026 16:35:31 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: ZyXdIr5CbvdB-rwrI-KZaueXwoyXRHbw
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDE3MCBTYWx0ZWRfXyNaULmIdQXEp
 P7A+oK/qvtAsRlgw0tLkNiC8Y49U8ybuyOCzCcg4SeBIhlmhMyhE0vPBpQxiN/cEpgRoFBRdFy2
 JIvDGNshz/YEpkwLAErQc+QKYzxbBp4=
X-Authority-Analysis: v=2.4 cv=c62bhx9l c=1 sm=1 tr=0 ts=6a3c3f96 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=6LzU57qDt5mu2e4VMFoA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDE3MCBTYWx0ZWRfXypXSSxdHg8dg
 tMgAuVm6V3UT+LwIANwKauef9jUDcpm8UuBH9caZNpOLdRzLtSIV/hujuLbTeH9M+1zfS8Zw0fh
 5MZ7PXFuX3jkRd92vS0aBqNrGQtAFlmg51u/uTPerzlpEhbG8w+3YfwvKd5atbfgh7c0/lR8Reb
 InLFB5y8Rdbr2uS6nMnsvKOYRn+cfUlzrlgnAzKh2L3aCdYvoiyLtVzjvdjcBmKwwpgyQQee0cK
 PM7NzGzpy0OnvYMYrYgYeMQAIXAh8bU1XRSfTAlvnD0gqWUPrHBVkw+h53E+qwWmjq0vEru6Otk
 CMYbKQIQYWkANRaUFCm1uvPC/b4y5Cac/TjmNa0qirI0pH3x96xQ844a4ObEB+uHQUUWDBK3H80
 KLHIdJeKdX9jjmSj6QGgRn3HFFoBBl9tq9a8LTZlhAk9BOFBWc4IRF92TP8geu/Q/lZ9K+JuHEK
 GKDCECRn/dvv3FtEjtg==
X-Proofpoint-ORIG-GUID: -7XvS-DbitwnL5hc4o4_mzImI7XOJ4Vf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_04,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 phishscore=0 spamscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606240170
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-9829-lists,linux-integrity=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[polito.it,vger.kernel.org,gmail.com,huawei.com];
	FORGED_RECIPIENTS(0.00)[m:enrico.bravi@polito.it,m:linux-integrity@vger.kernel.org,m:dmitry.kasatkin@gmail.com,m:roberto.sassu@huawei.com,m:eric.snowberg@oracle.com,m:dmitrykasatkin@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[zohar@linux.ibm.com,linux-integrity@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E586A6C1362

The Subject line needs to be written from a higher perspective.  It describ=
es
"how", not "what".
Consider using "ima: add critical data measurement for loaded policy".

On Wed, 2026-06-17 at 17:58 +0200, Enrico Bravi wrote:
> IMA policy can be written multiple times in the securityfs policy file
> at runtime if CONFIG_IMA_WRITE_POLICY=3Dy. When IMA_APPRAISE_POLICY is
> required, the policy needs to be signed to be loaded, writing the absolut=
e
> path of the file containing the new policy:
>=20
> echo /path/of/custom_ima_policy > /sys/kernel/security/ima/policy
>=20
> When this is not required, policy can be written directly, rule by rule:
>=20
> echo -e "measure func=3DBPRM_CHECK mask=3DMAY_EXEC\n" \
>         "audit func=3DBPRM_CHECK mask=3DMAY_EXEC\n" \
>      > /sys/kernel/security/ima/policy
>=20
> In this case, a new policy can be loaded without being measured or
> appraised.
>=20
> Add a new critical data record to measure the textual policy
> representation when it becomes effective. Include in the
> architecture-specific policy the new critical data record only when it
> is not mandatory to load a signed policy. Additionally, enable the
> policy serialization code even when CONFIG_IMA_READ_POLICY=3Dn.
>=20
> To verify the template data hash value, convert the buffer policy data
> to binary:
> grep "ima_policy_loaded" \
>         /sys/kernel/security/integrity/ima/ascii_runtime_measurements | \
>         tail -1 | cut -d' ' -f 6 | xxd -r -p | sha256sum
>=20
> Signed-off-by: Enrico Bravi <enrico.bravi@polito.it>

Thank you for making the changes.

[ ... ]

> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima=
/ima_policy.c
> index f7f940a76922..0a70d10da70a 100644
> --- a/security/integrity/ima/ima_policy.c
> +++ b/security/integrity/ima/ima_policy.c

> @@ -2379,3 +2378,70 @@ bool ima_appraise_signature(enum kernel_read_file_=
id id)
>  	return found;
>  }
>  #endif /* CONFIG_IMA_APPRAISE && CONFIG_INTEGRITY_TRUSTED_KEYRING */
> +
> +/**
> +* ima_measure_loaded_policy - measure the active IMA policy ruleset
> +*
> +* Must be called with ima_write_mutex held, as it performs two
> +* separate RCU read passes over ima_rules and relies on the mutex
> +* to prevent concurrent policy updates between them.
> +*/
> +void ima_measure_loaded_policy(void)
> +{
> +	const char *event_name =3D "ima_policy_loaded";
> +	const char *op =3D "measure_loaded_ima_policy";
> +	struct ima_rule_entry *rule_entry;
> +	struct list_head *ima_rules_tmp;
> +	struct seq_file file;
> +	int result =3D -ENOMEM;
> +	size_t file_len =3D 0;
> +	char rule[512];
> +
> +	/* calculate IMA policy rules memory size */
> +	file.buf =3D rule;
> +	file.read_pos =3D 0;
> +	file.size =3D 512;
> +	file.count =3D 0;
> +
> +	lockdep_assert_held(&ima_write_mutex);
> +
> +	rcu_read_lock();
> +	ima_rules_tmp =3D rcu_dereference(ima_rules);
> +	list_for_each_entry_rcu(rule_entry, ima_rules_tmp, list) {
> +		ima_policy_show(&file, rule_entry);
> +		if (seq_has_overflowed(&file)) {
> +			result =3D -E2BIG;
> +			integrity_audit_msg(AUDIT_INTEGRITY_PCR, NULL, event_name,
> +					    op, "rule_length", result, 1);
> +			return;

On failure the new IMA policy will not be measured. Instead of hard coding =
the
buffer to 512, define a file static global variable to keep track of the ma=
ximum
policy rule size.  ima_parse_add_rule() already returns the policy rule len=
gth.
Before returning update the max policy rule size variable as necessary.

Here in ima_measure_loaded_policy() allocate/free the buffer.

Missing rcu_read_unlock() before returning.

thanks,

Mimi

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
> +				    op, "ENOMEM", result, 1);
> +		return;
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
> +}

