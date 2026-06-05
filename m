Return-Path: <linux-integrity+bounces-9750-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1wxfLGbnImoXfAEAu9opvQ
	(envelope-from <linux-integrity+bounces-9750-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 05 Jun 2026 17:12:38 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1308B6492B8
	for <lists+linux-integrity@lfdr.de>; Fri, 05 Jun 2026 17:12:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ibm.com header.s=pp1 header.b=tgivJK+Y;
	spf=pass (mail.lfdr.de: domain of "linux-integrity+bounces-9750-lists+linux-integrity=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-integrity+bounces-9750-lists+linux-integrity=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=ibm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AD3D43084AD6
	for <lists+linux-integrity@lfdr.de>; Fri,  5 Jun 2026 14:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F06743EF64C;
	Fri,  5 Jun 2026 14:58:03 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935623ECBF3;
	Fri,  5 Jun 2026 14:58:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780671483; cv=none; b=ejn2/2OwKIGsGLE/iO/mMW9gkAWRYEjLaJMBMWRYeyg7RLEu5k/Q2tdfLtzdiTo4m2vuiLv2vlm8cmWqYas+LzHQMwH7uD5KnAOnuB4GRS1I4k+nKsTs2etsxREMVO+Nh9NntPBVVHdKMmK8kNq51rtV2qKUkVRpaN67E/+UYPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780671483; c=relaxed/simple;
	bh=dtHfLVBcmS5hIznYKZ+F6ont1znMR6GB88uzgLP/7wQ=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=tMsspAyMrvIyzUff+mXvWwOKXEQ0nAT4RoDMik2QhnLjNH5UIpQgakc7f/xNHwexsk2PYmjnZftB6kwj3bX3bdPKo7H0/xihmkkd1ju1gMEntqGy1VzUznop84sBscQM0EdFF9klLVyH+fDVANZGJbQ8reQt5jvpIKCJxU0IlM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tgivJK+Y; arc=none smtp.client-ip=148.163.156.1
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 655ENS9v1957750;
	Fri, 5 Jun 2026 14:57:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=szlPJQ
	eKvYjqCLoNHvB+7KcQAULKpxMmegmOg2lRkpE=; b=tgivJK+YpCAPCZUA8mHC6h
	h6XDQMs3fn5UDpqlSzR7XsGZglaz0sofYfJbTimmR8gaZKPsP2K4gZOkSC4vOzRy
	tUedqn5KOe/H5zig5+ec7RcLzAZqwXgEKWjFZI0mS2LjcQcxsNvQ5XE1GAwTaUuh
	/r/KtmQXXT8fzwTC4vB0Q8Q/lZy/wgoNJDMSE3CHtZq7knZwWo7vq0zRwbgMGcWx
	/bL0q3ttqvxMiiOk/uGF9wE+Ntj95DULENCiFifQ1ftGf8Mtifs3Fe5FXvt6W7Zl
	kY+vNlqzGO/KsGsDWp5UgKPkkXx4hE/Eq36rH8gMxZpugmuC2ioddqcINd23dsEg
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efqm5cwet-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Jun 2026 14:57:22 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 655Es9NQ020328;
	Fri, 5 Jun 2026 14:57:21 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4egakwa8vk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Jun 2026 14:57:21 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 655EvKcT21234380
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 5 Jun 2026 14:57:20 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 92B2358043;
	Fri,  5 Jun 2026 14:57:20 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7F73B58055;
	Fri,  5 Jun 2026 14:57:19 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.67.126])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  5 Jun 2026 14:57:19 +0000 (GMT)
Message-ID: <b76773079caf314622eda470f59b245e0270ba46.camel@linux.ibm.com>
Subject: Re: [PATCH v6 09/12] ima: Add support for staging measurements
 with prompt
From: Mimi Zohar <zohar@linux.ibm.com>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>, corbet@lwn.net,
        skhan@linuxfoundation.org, dmitry.kasatkin@gmail.com,
        eric.snowberg@oracle.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        gregorylumen@linux.microsoft.com, chenste@linux.microsoft.com,
        nramas@linux.microsoft.com, Roberto Sassu <roberto.sassu@huawei.com>,
        Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20260602111401.1706052-10-roberto.sassu@huaweicloud.com>
References: <20260602111401.1706052-1-roberto.sassu@huaweicloud.com>
	 <20260602111401.1706052-10-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2026 10:57:18 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: EUlY1e3JgfKCCM4aSVgVsVYZZZtY023V
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA1MDE0NCBTYWx0ZWRfX02b/b6NA10df
 PpzQD9HhIPRFSMk19ryweZRpIhiVRUJsqem4nHHp8ecfbxV+/dMTzcKmOBaDHn+wnNDwYRFYRLq
 6XmFGYJnU06cfFizb1yHrjbAQWWnB5p3g+ReKdgd+iHSLvFhHyYY5dQ1sAJydlbcfI6pw8gJrPr
 ndC/yEoR6kIgWKghfb5biNt+TeOpn+PsN+YY/HqUdIOnTiusqAO05shS7k+CIfICIoeMcT0rDt/
 FUPhWAivkiVtwskYzWtsKFHqL/NeHwkDaAJLdyoTaWNwck3TzQCAacydJcQ9ZW3dDcXRDpGn0kk
 84Rr/fRAgypcLRLphnniI3Itruy4t6Y/jkm1lfnV2Kl/T5uTT2tMB5RICqOyuaoaWoduH7X9fvd
 WjhQlubW1lkFBtZZ+srPj2RyMGGQ63zW0pcAUw/bqgdm5hNZls5wQ+6P4awB8LfNpLrFG+BnqVw
 iCj/OxNOH0j29KMXhPQ==
X-Proofpoint-ORIG-GUID: F7-cuoMD5meFmenHPaBSC-n5kDnY_iVI
X-Authority-Analysis: v=2.4 cv=Vf3H+lp9 c=1 sm=1 tr=0 ts=6a22e3d3 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=NEAV23lmAAAA:8
 a=i0EeH86SAAAA:8 a=yMhMjlubAAAA:8 a=VnNF1IyMAAAA:8 a=0I6YCydjegjod4RL-ycA:9
 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-05_02,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 adultscore=0 bulkscore=0 impostorscore=0
 phishscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606050144
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-9750-lists,linux-integrity=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[huaweicloud.com,lwn.net,linuxfoundation.org,gmail.com,oracle.com,paul-moore.com,namei.org,hallyn.com];
	FORGED_RECIPIENTS(0.00)[m:roberto.sassu@huaweicloud.com,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:dmitry.kasatkin@gmail.com,m:eric.snowberg@oracle.com,m:paul@paul-moore.com,m:jmorris@namei.org,m:serge@hallyn.com,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-integrity@vger.kernel.org,m:linux-security-module@vger.kernel.org,m:gregorylumen@linux.microsoft.com,m:chenste@linux.microsoft.com,m:nramas@linux.microsoft.com,m:roberto.sassu@huawei.com,m:stefanb@linux.ibm.com,m:dmitrykasatkin@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[zohar@linux.ibm.com,linux-integrity@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,linux.ibm.com:from_mime,linux.ibm.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,huawei.com:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zohar@linux.ibm.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1308B6492B8

On Tue, 2026-06-02 at 13:13 +0200, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
>=20
> Introduce the ability of staging the IMA measurement list and deleting th=
em
> with a prompt.
>=20
> Staging means moving the current measurement list records to a separate
> location, and allowing users to read and delete it. This causes the curre=
nt
> measurement list to be emptied (since records were moved) and new
> measurements to be added on the empty list. Staging can be done only once
> at a time. In the event of kexec(), staging is aborted and staged records
> will be carried over to the new kernel.

The kexec locking changes look good, thanks.

>=20
> Introduce ascii_runtime_measurements_<algo>_staged and
> binary_runtime_measurements_<algo>_staged interfaces to access and delete
> the measurements.
>=20
> Use 'echo A > <IMA _staged interface>' and
> 'echo D > <IMA _staged interface>' to respectively stage and delete the
> entire measurements list. Locking of these interfaces is also mediated wi=
th
> a call to _ima_measurements_open() and with ima_measurements_release().
>=20
> Implement the staging functionality by introducing the new global
> measurements list ima_measurements_staged, and ima_queue_stage() and
> ima_queue_staged_delete_all() to respectively move measurements from the
> current measurements list to the staged one, and to move staged
> measurements to the ima_measurements_trim list for deletion. Introduce
> ima_queue_delete() to delete the measurements.
>=20
> Staging is forbidden after measurement is suspended, and between staging
> and deleting, so that walking the staged and current measurements list ca=
n
> be done locklessly in ima_dump_measurement_list(). Strict ordering of
> suspending and dumping is enforced by two reboot notifiers with different
> priority. Refusing to delete staged measurements also signals to user spa=
ce
> that those measurements are already carried over to the secondary kernel,
> so that it does not save them twice.
>=20
> Finally, introduce the BINARY_STAGED and BINARY_FULL binary measurements
> list types, to maintain the counters and the binary size of staged
> measurements and the full measurements list (including records that were
> staged). BINARY still represents the current binary measurements list.
>=20
> Use the binary size for the BINARY + BINARY_STAGED types in
> ima_add_kexec_buffer(), since both measurements list types are copied to
> the secondary kernel during kexec. Use BINARY_FULL in
> ima_measure_kexec_event(), to generate a critical data record.
>=20
> It should be noted that the BINARY_FULL counter is not passed through
> kexec. Thus, the number of records included in the kexec critical data
> records refers to the records since the critical data records generated
> from the previous kexec event.
>=20
> Note: This code derives from the Alt-IMA Huawei project, whose license is
>       GPL-2.0 OR MIT.
>=20
> Link: https://github.com/linux-integrity/linux/issues/1
> Suggested-by: Gregory Lumen <gregorylumen@linux.microsoft.com> (staging r=
evert)
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> Tested-by: Stefan Berger <stefanb@linux.ibm.com>

Thanks for the updates to the patch description, function docs, and comment=
s.
Just one change needed (below) =E2=80=94 otherwise this looks great.

> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> index c00c133a140f..a05db5b18982 100644
> --- a/security/integrity/ima/ima.h
> +++ b/security/integrity/ima/ima.h

[...]

> @@ -337,6 +342,7 @@ extern atomic_long_t ima_num_records[BINARY__LAST];
>  /* Total number of violations since hard boot. */
>  extern atomic_long_t ima_num_violations;
>  extern struct hlist_head __rcu *ima_htable;
> +extern struct mutex ima_extend_list_mutex;

With the kexec locking change in this version, making ima_extend_list_mutex
global isn't necessary.

> =20
>  static inline unsigned int ima_hash_key(u8 *digest)
>  {
>=20
> diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/=
ima_queue.c
> index 618694d5c082..a1aa141756e1 100644
> --- a/security/integrity/ima/ima_queue.c
> +++ b/security/integrity/ima/ima_queue.c

[...]

> @@ -42,11 +43,11 @@ atomic_long_t ima_num_violations =3D ATOMIC_LONG_INIT=
(0);
>  /* key: inode (before secure-hashing a file) */
>  struct hlist_head __rcu *ima_htable;
> =20
> -/* mutex protects atomicity of extending measurement list
> +/* mutex protects atomicity of extending and staging measurement list
>   * and extending the TPM PCR aggregate. Since tpm_extend can take
>   * long (and the tpm driver uses a mutex), we can't use the spinlock.
>   */
> -static DEFINE_MUTEX(ima_extend_list_mutex);
> +DEFINE_MUTEX(ima_extend_list_mutex);

Please drop this change.

Mimi

