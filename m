Return-Path: <linux-integrity+bounces-9301-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4Pb0M6Eb6mmUuQIAu9opvQ
	(envelope-from <linux-integrity+bounces-9301-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Thu, 23 Apr 2026 15:16:17 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C107452A42
	for <lists+linux-integrity@lfdr.de>; Thu, 23 Apr 2026 15:16:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 75BE8308F097
	for <lists+linux-integrity@lfdr.de>; Thu, 23 Apr 2026 13:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9099E3EF0B7;
	Thu, 23 Apr 2026 13:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pXw+Y3yG"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2083E6DC6
	for <linux-integrity@vger.kernel.org>; Thu, 23 Apr 2026 13:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776949905; cv=none; b=rWk2RMG3mcW2Hz9iTcihoBU9xBjFxcghst5rnrADiQbIO7IGcpBuYYOxg4Uw7rjWV6L1jgSN0I3rHi4G1ZnTPF8WL96+ypsgHORONJOoQyodZ+spNpFnjw6/pjxirVu88iPZ2YUiuvgHENPMqR10ReqBPxPMPq4RH9pEIMBiGj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776949905; c=relaxed/simple;
	bh=jdVb6GBUMaFJnA7fXAqm461UORnVhmf+4HbY1VeHoUk=;
	h=Message-ID:Subject:From:To:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=VnQN7QGO3/MeMIKikl2eiv7378pNNKvhTXhbNun3NXBHrIfsEsaFWHs/HCGaGW5GfGvIYZC1UdpwPYAbDJO/rPT/QCDcNyZnu2cvc/tcBwwDd6C8xpjsueYbA7kyaEWLvSo3r18YtnRRaaMNTcBefCBGcHprK9uZRdLpausMj2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pXw+Y3yG; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63N7JGr93292147;
	Thu, 23 Apr 2026 13:11:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=PsYRg+
	Z+Ni2NJ/Kxxwx7ZnK2GNbBziZw1zgomKRrT8c=; b=pXw+Y3yGWIpoB9mAePq916
	EmRdlv6ej8hhP2nfpyiLlE8MnncG90yxAf3DtmdG9dNQy2rq6VrExLzxlp4w34hH
	hQo74SGCKQHd+2JQMKatpl2ZF0YL4zGdfbp1EE7m7rDO3tciakQ60QqQ0Zs9Y5FI
	Lav3ZCasYN+yyB7+VFOD9DbE5AsRe7tdX4JZOxvgJi4j8fPF6YEJ5MjMZHkCl7zt
	6D6QJp5YEzPi5S88SUWbjdrFuPVxDI3ncpiNLZhmeohTdXZJLwe3WwC6nI3YgyLQ
	6aNKi5n4OMioG06DcrhxSFxuVUsIZCbzGgCaKYgNgrmdVskaXRmIt6m42kKtAxhg
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dphfrg57d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Apr 2026 13:11:35 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63ND5Mi8004165;
	Thu, 23 Apr 2026 13:11:34 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dpjkyeq8m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Apr 2026 13:11:34 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63NDBXCZ16188094
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Apr 2026 13:11:33 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D312B58051;
	Thu, 23 Apr 2026 13:11:33 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9A0EE5805E;
	Thu, 23 Apr 2026 13:11:33 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.20.220])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 23 Apr 2026 13:11:33 +0000 (GMT)
Message-ID: <03597d02213b4e1a6942a5fffb5bda233bbc2e76.camel@linux.ibm.com>
Subject: Re: [PATCH] ima: return error early if file xattr cannot be changed
From: Mimi Zohar <zohar@linux.ibm.com>
To: Goldwyn Rodrigues <rgoldwyn@suse.de>, linux-integrity@vger.kernel.org
In-Reply-To: <aposxvqsrlbe7gtyvtsdh5nyg5sgofimerqpt6ez4fbxhtqyjj@4u3othdcgipp>
References: 
	<aposxvqsrlbe7gtyvtsdh5nyg5sgofimerqpt6ez4fbxhtqyjj@4u3othdcgipp>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Apr 2026 09:11:33 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Y5rRiMECfBtGsiMeLewh4d7UfyYYbmOK
X-Proofpoint-ORIG-GUID: Y5rRiMECfBtGsiMeLewh4d7UfyYYbmOK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIzMDEyNyBTYWx0ZWRfX2Ct+VU0GuM6z
 Y7KmH/Rn1oXOc78h4HJY9d88rkEyWP5rShJlMr+16utdWgsLbtuL257nCP7KAOOjv1JLh8Mj5NH
 ZcJ4wOekmEw1jqVrTnAc1UjrFw6F0QAQeHg6YMe5PjG0TdohdqGkNSNXStrNJJtuCoAaj79QfqX
 c/pU2GYEeBruHWRaw6KLwX8xkTZj3J1GjR83PGs/iZK0NulGIJOCpBTfPaTbRxDT0T07d4E1oat
 IhNtQbpbcmJdDNSyyacCYOfLY8okIYLdxhAkg+W/RfpUE+dqrJJ7IYL3bLcS1iKbePoMGC7E4+c
 Y09whrpfe19U0Ma03chr7tWz2He4o/92g02pGKT0Y0deErLxnqAyxDu175S1rGygBcZ/48IRD30
 jSWzAuNsKUDMcksH3v79CIccCwLPwRv4vOEVlVblpQmKvxm5rD7ASW3qn5Ct9dNJ+5XvDcSBy1I
 eneoK6XlTC/mWayXZPg==
X-Authority-Analysis: v=2.4 cv=SJxykuvH c=1 sm=1 tr=0 ts=69ea1a87 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=iox4zFpeAAAA:8
 a=alqwI6bSkIfl5Z6tSWsA:9 a=QEXdDO2ut3YA:10 a=WzC6qhA0u3u7Ye7llzcV:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1011 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604230127
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-9301-lists,linux-integrity=lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zohar@linux.ibm.com,linux-integrity@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MAILSPIKE_FAIL(0.00)[172.105.105.114:server fail];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 7C107452A42
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 2026-04-22 at 07:34 -0400, Goldwyn Rodrigues wrote:
> During early boot, the filesystem is read-only and any changes
> to xattrs are not allowed. This fails in case of ext4 because
> changing xattr starts an ext4 transaction which fails with the
> following warning.
>=20
> WARNING: fs/ext4/ext4_jbd2.c:75 at ext4_journal_check_start+0x63/0xa0 [ex=
t4], CPU#1: systemd-sysroot/561
> CPU: 1 UID: 0 PID: 561 Comm: systemd-sysroot Not tainted 6.19.12-1-defaul=
t #1 PREEMPT(voluntary) openSUSE Tumbleweed  c2dfc3c9d9f6f1233251c5d4410574=
fe82a348ee
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS unknown 02/02/20=
22
> RIP: 0010:ext4_journal_check_start+0x63/0xa0 [ext4]
> Call Trace:
>   __ext4_journal_start_sb+0x3e/0x180 [ext4 6d025f3bc52c89a957b89a89d211fa=
df5e9434e1]
>   ext4_xattr_set+0x104/0x150 [ext4 6d025f3bc52c89a957b89a89d211fadf5e9434=
e1]
>   __vfs_setxattr+0x9a/0xd0
>   __vfs_setxattr_noperm+0x76/0x1f0
>   ima_appraise_measurement+0x23e/0xe40
>   ima_d_path+0x5a/0xd0
>   process_measurement+0xb29/0xc40
>   ? copy_from_kernel_nofault+0x21/0xe0
>   ? fscrypt_file_open+0xc0/0xe0
>   ? ext4_file_open+0x60/0x490 [ext4 6d025f3bc52c89a957b89a89d211fadf5e943=
4e1]
>   ? bpf_prog_31efb7c56239148b_restrict_filesystems+0xab/0x126
>   ? __bpf_prog_exit+0x23/0xd0
>   ? __bpf_tramp_exit+0xd/0x50
>   ? bpf_trampoline_6442530367+0x9f/0xea
>   ima_file_check+0x57/0x80
>   security_file_post_open+0x50/0xf0
>   path_openat+0x493/0x1650
>   do_filp_open+0xc7/0x170
>=20
> Detect the state of the file early and return the error.
>=20
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>

Thank you!  The patch makes a lot of sense.

Mimi

> ---
>  security/integrity/ima/ima_appraise.c | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/i=
ma/ima_appraise.c
> index 870dde67707b..6a4dda46114c 100644
> --- a/security/integrity/ima/ima_appraise.c
> +++ b/security/integrity/ima/ima_appraise.c
> @@ -90,6 +90,11 @@ static int ima_fix_xattr(struct dentry *dentry,
>  	int rc, offset;
>  	u8 algo =3D iint->ima_hash->algo;
> =20
> +	if (IS_RDONLY(d_inode(dentry)))
> +		return -EROFS;
> +	if (IS_IMMUTABLE(d_inode(dentry)))
> +		return -EPERM;
> +
>  	if (algo <=3D HASH_ALGO_SHA1) {
>  		offset =3D 1;
>  		iint->ima_hash->xattr.sha1.type =3D IMA_XATTR_DIGEST;

