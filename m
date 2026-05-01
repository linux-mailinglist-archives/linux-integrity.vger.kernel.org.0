Return-Path: <linux-integrity+bounces-9401-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SNweOjcE9WlGHQIAu9opvQ
	(envelope-from <linux-integrity+bounces-9401-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 01 May 2026 21:51:19 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4811A4AF591
	for <lists+linux-integrity@lfdr.de>; Fri, 01 May 2026 21:51:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 912E33009B23
	for <lists+linux-integrity@lfdr.de>; Fri,  1 May 2026 19:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C56421E834E;
	Fri,  1 May 2026 19:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kh0QXSTf"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF371E5201
	for <linux-integrity@vger.kernel.org>; Fri,  1 May 2026 19:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777664895; cv=none; b=U8KwFNK57TtquLswPqfTe0zZvIOMrxU2Uz7VD9KwwpIKUA8+lnO4Z4XhOTPzZW+3V0QYBOD8TXXue0k+bwpQd8/aTIOJ+2Sq5/zR0yn4n/GAHrpMlo4of1lg/S2ddLdaKuS33YeTiNmb2gV2yGMFn/afiJbZOs+Fhkv2HP3f6IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777664895; c=relaxed/simple;
	bh=q/ekd9LPvaSAGW8+IaStQ3SInNYQROOCr276Xjzq2hA=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=Ya71d9I495T9nLH2NXxfJZOauU1U2E94H3R5F1W03ilRg8gzM6S0ZV/cFlP8l6KOBcfk/yT+v0mnHWCTooX6Uc1/QUNweBgnasFgcGmi7NSuKy4sLX4HdgmHusI03MrcP2I+ad9bzJ2ME+Q5k7OYvY/TAum4Jd74nBHVGl+z//I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kh0QXSTf; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 641CVjZx1524774;
	Fri, 1 May 2026 19:48:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=PYDZk0
	IYNzdNNwiMj9cU9mkfWySnpIabKoUfYMLQLUs=; b=kh0QXSTfwFxiO6YqS/XpAP
	gc6IbqryUVUf4d4hKf6ICUiCrXd6rxXLxRaf+HUpA7azq+sDKK3KywEi3nBwS3Vf
	Ab0hstiQODnlzIByPmCs45rDrUm0bl21WaPDa1tynEr/pyE1CWu1zDbY8tmdp7gR
	K0eQ0XD3BsB4W0ZkIqkjVS8BD0T/BAwB6icUyCCXL9LtKhIucrLFEp1GIW7flBgv
	L3QUGz+4SorByq5XMi/Srjw9RgXKEv/Bq7X9sE37Mt4ahga557ITsozNBvtMSFXM
	DwUSgrMcuYnu48o0hi7ht2ULm8IMvu3aU2wdfthWuRnmGABkRCkIKPAGtjuH1cgA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drn8vv4us-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 May 2026 19:48:11 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 641JckZ4018783;
	Fri, 1 May 2026 19:48:10 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dsa5grs28-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 May 2026 19:48:10 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 641JmAJL11010674
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 1 May 2026 19:48:10 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 06E6B5805A;
	Fri,  1 May 2026 19:48:10 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2B02558054;
	Fri,  1 May 2026 19:48:09 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.171.45])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  1 May 2026 19:48:09 +0000 (GMT)
Message-ID: <027d076e3ef0b22b648d024aaa7d8dd27746a624.camel@linux.ibm.com>
Subject: Re: IMA: Avoid redundant rehashing on stacked filesystems backed
 by structurally immutable filesystems
From: Mimi Zohar <zohar@linux.ibm.com>
To: Danny Hu <dannyhu@arista.com>
Cc: Sahil Gupta <s.gupta@arista.com>, linux-integrity@vger.kernel.org,
        Julien Gomes <julien@arista.com>, Pierre De Abreu <pierre@arista.com>,
        Kunal Bharathi <kbharathi@arista.com>
In-Reply-To: <CAFn2k5BciHURkQS9p-vZ70GP==1S_4GmoE=sMhA+WQXOA8nfoA@mail.gmail.com>
References: 
	<CAFn2k5DJNv5SDsx_-odHd3sB0Fw7r8FqhO8fWdXrraZn_vbpDw@mail.gmail.com>
	 <2b3c93a69e70b6fdf637bf9fb921d5e737a79e8e.camel@linux.ibm.com>
	 <CABEuK14__XuRO2KOd3w+qx5_nw4iB2yPcF2R68a09A4hcJkyFw@mail.gmail.com>
	 <4cbd1b20680e2dceba8870f62f2081c333113192.camel@linux.ibm.com>
	 <CAFn2k5BciHURkQS9p-vZ70GP==1S_4GmoE=sMhA+WQXOA8nfoA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 01 May 2026 15:48:08 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=CIIamxrD c=1 sm=1 tr=0 ts=69f5037b cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=5EThp5kMofMhBtMWPNMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: Nx_BVU_9ZzuPwnWB6LneqZpZIlTiBDhr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTAxMDE5NSBTYWx0ZWRfX1/mmUvLvlzsb
 tUlc75M8DnH1kz4YpzT7V+NWqQRD+Z7eTBKDygoedRe93T/17S9eod5s/L2yf9KkWjML7ZdR27+
 UvhTReiGX38Y6hEkt1JtJoMbgVoijCzYkPpvVLdoNSIFoJ61GnTsZznFuw8up0C9H3k3k+4ugBB
 8B/Tq/A2Hsk3mdvZZpZHIPEvrQVmvjvEDe8YJAjkcqjdYRU1jX1bdMczs5sJOMyXfbP3htRhZ/T
 J4thuTJYWN06IC6XmOLrb8eAelKKSMCNZXGBnI0vAAn6BCrD0kHtMlIfKi8whpDbnsPqCyWz2u6
 +qow8FLg7gkvl6XBXIT4ycWplX02VB0qH9Op8QoUxNu5nvTei49MTxNLGKAJ13h84LngiXhULeH
 kiSG1IxSlNMG5X7f8E3MF0Y8/idHt2HZTJ41XTlSBghoe94J4S14rf+rKXaY/adAnVaYlb9SAI8
 z4oDxHeWesxxC8qnXJg==
X-Proofpoint-GUID: Nx_BVU_9ZzuPwnWB6LneqZpZIlTiBDhr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-01_05,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 malwarescore=0 suspectscore=0 adultscore=0
 impostorscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605010195
X-Rspamd-Queue-Id: 4811A4AF591
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-9401-lists,linux-integrity=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.ibm.com:mid];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[zohar@linux.ibm.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCVD_COUNT_SEVEN(0.00)[11]

On Fri, 2026-05-01 at 09:16 -0700, Danny Hu wrote:
> On Fri, May 1, 2026 at 4:42=E2=80=AFAM Mimi Zohar <zohar@linux.ibm.com> w=
rote:
> >=20
> > On Thu, 2026-04-30 at 21:32 -0500, Sahil Gupta wrote:
> > > > Have you considered using IS_RDONLY(real_inode)?
> > >=20
> > > OOC are ima caches invalidated on fs reconfigure? If that is the case=
,
> > > then IS_RDONLY ought to do the trick.
> >=20
> > Per-inode IMA integrity status (iint) is now stored directly in the ino=
de's LSM
> > security blob rather than in a red-black tree cache.  By "fs reconfigur=
ation",
> > do you mean remounting the filesystem?  If so, the iint stored in the L=
SM
> > security blob should be freed when the filesystem is unmounted.
> >=20
>=20
> We considered using IS_RDONLY(), but the concern involved the remount
> path rather than an explicit unmount and subsequent mount. From my
> understanding, userspace can toggle the read only flag using "mount -o
> remount,rw" without freeing the inodes from memory. A malicious user
> could then exploit this by caching the appraisal result, modifying the
> file, remounting fs as read-only, and then IMA would trust the cached
> appraisal result.

Thank you for the explanation. Just be aware that IS_IMMUTABLE  is already
defined.  Otherwise your suggestion is plausible.

Mimi

