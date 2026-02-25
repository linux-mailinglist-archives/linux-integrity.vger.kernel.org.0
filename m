Return-Path: <linux-integrity+bounces-8559-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aDIkMphWn2mIaQQAu9opvQ
	(envelope-from <linux-integrity+bounces-8559-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Wed, 25 Feb 2026 21:07:52 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 370AE19D0D8
	for <lists+linux-integrity@lfdr.de>; Wed, 25 Feb 2026 21:07:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6C6DA302E85F
	for <lists+linux-integrity@lfdr.de>; Wed, 25 Feb 2026 20:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23DCB2F5311;
	Wed, 25 Feb 2026 20:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kzj/HNkU"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3891239099;
	Wed, 25 Feb 2026 20:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772050061; cv=none; b=nJhQmtHz8bwwDxgNuNQsF8cJNqjRRydEe38/2t79qxT7BVc34eHdDmYnCFv9hFRPY433z8l/4PeZM/Ezo1swIik1jkCafRh/j6VPdkGTsS9MBxcdNILrkxJEmd+y50ezppfCRE4etl+vIjN7B5HsgxbEJ1CH8xYqKZWlN1VhveU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772050061; c=relaxed/simple;
	bh=p+JnkpGZDNm7kZjv338UW0LvmIzt1NOf9KDDkmOSY3k=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=jiIbbfKu57uIMvoaWt71p3XUjO1ZDIfAt5qjNPJiCoP8sDc7Nnx6CFSmn2rVSTBIK14aPUj55IDGOaWveKG819GOfGvzXk+ISjazSYPm3qkiAmtWkzFUGGxaoECATqrBQl7TTAIDDFr1cbeTaNlgOCq4d3vpHPFsG01VjZB2WBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kzj/HNkU; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61PIup1W2346028;
	Wed, 25 Feb 2026 20:07:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=zSEycr
	ZcvnSn1D5j5N83esPG9UobMSwRJ2yvpLarlUU=; b=kzj/HNkUxUJJ1c6a3qM8g8
	yuUenvMu8o1DZjZFO/f4g3LS8Ibcfdf+BTysc1sY+jX8jirpassbbGOSeuybHvyb
	Q55ceMthWQJ/LVOAvZGbzgQzbcgLoyGNKd6pZHnlLcdNQygadmYrR82PXpjxpvIt
	4OyBDOoaH3moGdg46J3MH1US+myIG2Rr1/OLI4++e19Mh4XQM8Yx4UxzYz7fLE9q
	jECkVRnm+apBCM9EUCtCmQ1JJ5VHTBwwXj7OFFNXkp+YZla65YG9Ope5geghI6BE
	GT1q4V8yUkEsZf2Je2CTGNgC8p8aLR3xgb7UVOBwSjTXTUwsuW/l7YsQOCavFdWg
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ch858qr3d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Feb 2026 20:07:19 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61PJWMVD001646;
	Wed, 25 Feb 2026 20:07:18 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cfr1n777f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Feb 2026 20:07:18 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61PK7Hh045679056
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Feb 2026 20:07:17 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E4B9F58067;
	Wed, 25 Feb 2026 20:07:16 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 504EC5804B;
	Wed, 25 Feb 2026 20:07:15 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.41.157])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 25 Feb 2026 20:07:15 +0000 (GMT)
Message-ID: <9e24532f1f67870fd15f50421c2cc2c5db2deaf7.camel@linux.ibm.com>
Subject: Re: [PATCH v5] ima_fs: Avoid creating measurement lists for
 unsupported hash algos
From: Mimi Zohar <zohar@linux.ibm.com>
To: dima@arista.com, Roberto Sassu <roberto.sassu@huawei.com>,
        Dmitry
 Kasatkin	 <dmitry.kasatkin@gmail.com>,
        Eric Snowberg
 <eric.snowberg@oracle.com>,
        Paul Moore <paul@paul-moore.com>, James Morris
 <jmorris@namei.org>,
        "Serge E. Hallyn"	 <serge@hallyn.com>,
        Silvia Sisinni
 <silvia.sisinni@polito.it>,
        Enrico Bravi	 <enrico.bravi@polito.it>
Cc: Jonathan McDowell <noodles@earth.li>, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Dmitry Safonov <0x7f454c46@gmail.com>
In-Reply-To: <20260223-ima-oob-v5-1-91cc1064e767@arista.com>
References: <20260223-ima-oob-v5-1-91cc1064e767@arista.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Feb 2026 15:07:14 -0500
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI1MDE4OCBTYWx0ZWRfX+nb5K3CBuCKs
 MtPJsvNN2PtQtHtYsAZPStXHd0FSaq2X44gHRNACRETYzqiEqyiXH+ha9DZBqsGZy2+lOsjE4B5
 82W1pDuE+rlAiNrSLg9oORaa+9qFRi32P8OF/BGod2Q8gqTZ31lHgST3+WtVBipVVfly/ZyIFB6
 Lf/oq0E9vB6ak3cicFeET01R9+r3UxASz17x/seZrOhg7RjvZvSI2gVrPKSG/hI88WASSIKeKEg
 Otncg+I8lXQPVxAXn840JJZyGGxmS4ZqUns7PfWfEjcEeWTjQiUeL5N3rG4fkgQWKZu04x9RBOq
 XTmvVJAnpVsYcJXBsJRVAxcHqRKb987V7H72Ax27FHeBhcct/OPtikIELEBcOZ160nM99h2mnEz
 fSINaFqh55es10tz+Zh1Dif4o+QImm/oD2jMRBbpbuynnShzNfsERPUyrLWprPAzNV8tFXxh5ph
 KS9elsX6BLUgmi/twjA==
X-Proofpoint-GUID: fua4FRTBKTXPDxgXI6ZqhVqvlt8aGZwN
X-Authority-Analysis: v=2.4 cv=S4HUAYsP c=1 sm=1 tr=0 ts=699f5677 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=n2GhSfulAAAA:8
 a=7bwVOnxALRIXVdpAdZcA:9 a=QEXdDO2ut3YA:10 a=9NqWk_7B-uqI6kdQTXIl:22
X-Proofpoint-ORIG-GUID: ggW3Il2xasovXdUo3BlD0iK867gWpYs6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-25_03,2026-02-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1011 impostorscore=0 malwarescore=0 bulkscore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602250188
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
	TAGGED_FROM(0.00)[bounces-8559-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[arista.com,huawei.com,gmail.com,oracle.com,paul-moore.com,namei.org,hallyn.com,polito.it];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[earth.li,vger.kernel.org,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.ibm.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zohar@linux.ibm.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-integrity];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 370AE19D0D8
X-Rspamd-Action: no action

On Mon, 2026-02-23 at 14:56 +0000, Dmitry Safonov via B4 Relay wrote:
> From: Dmitry Safonov <dima@arista.com>
>=20
> ima_tpm_chip->allocated_banks[i].crypto_id is initialized to
> HASH_ALGO__LAST if the TPM algorithm is not supported. However there
> are places relying on the algorithm to be valid because it is accessed
> by hash_algo_name[].
>=20
> On 6.12.40 I observe the following read out-of-bounds in hash_algo_name:
>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>   BUG: KASAN: global-out-of-bounds in create_securityfs_measurement_lists=
+0x396/0x440
>   Read of size 8 at addr ffffffff83e18138 by task swapper/0/1
>=20
>   CPU: 4 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.12.40 #3
>   Call Trace:
>    <TASK>
>    dump_stack_lvl+0x61/0x90
>    print_report+0xc4/0x580
>    ? kasan_addr_to_slab+0x26/0x80
>    ? create_securityfs_measurement_lists+0x396/0x440
>    kasan_report+0xc2/0x100
>    ? create_securityfs_measurement_lists+0x396/0x440
>    create_securityfs_measurement_lists+0x396/0x440
>    ima_fs_init+0xa3/0x300
>    ima_init+0x7d/0xd0
>    init_ima+0x28/0x100
>    do_one_initcall+0xa6/0x3e0
>    kernel_init_freeable+0x455/0x740
>    kernel_init+0x24/0x1d0
>    ret_from_fork+0x38/0x80
>    ret_from_fork_asm+0x11/0x20
>    </TASK>
>=20
>   The buggy address belongs to the variable:
>    hash_algo_name+0xb8/0x420
>=20
>   Memory state around the buggy address:
>    ffffffff83e18000: 00 01 f9 f9 f9 f9 f9 f9 00 01 f9 f9 f9 f9 f9 f9
>    ffffffff83e18080: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>   >ffffffff83e18100: 00 00 00 00 00 00 00 f9 f9 f9 f9 f9 00 05 f9 f9
>                                           ^
>    ffffffff83e18180: f9 f9 f9 f9 00 00 00 00 00 00 00 04 f9 f9 f9 f9
>    ffffffff83e18200: 00 00 00 00 00 00 00 00 04 f9 f9 f9 f9 f9 f9 f9
>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> Seems like the TPM chip supports sha3_256, which isn't yet in
> tpm_algorithms:
>   tpm tpm0: TPM with unsupported bank algorithm 0x0027
>=20
> Thus solve the problem by creating a file name with "_tpm_alg_<ID>"
> postfix if the crypto algorithm isn't initialized.
>=20
> This is how it looks on the test machine (patch ported to v6.12 release):
>   # ls -1 /sys/kernel/security/ima/
>   ascii_runtime_measurements
>   ascii_runtime_measurements_tpm_alg_27
>   ascii_runtime_measurements_sha1
>   ascii_runtime_measurements_sha256
>   binary_runtime_measurements
>   binary_runtime_measurements_tpm_alg_27
>   binary_runtime_measurements_sha1
>   binary_runtime_measurements_sha256
>   policy
>   runtime_measurements_count
>   violations

When reposting this patch, on top of Roberto's patch, please include the na=
me of
the TCG document, or a link to it, defining the algorithm id number here in=
 the
patch description.

thanks,

Mimi

