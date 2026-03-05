Return-Path: <linux-integrity+bounces-8932-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cJ2zFhmmqWnwBgEAu9opvQ
	(envelope-from <linux-integrity+bounces-8932-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Thu, 05 Mar 2026 16:49:45 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C8B7F214D74
	for <lists+linux-integrity@lfdr.de>; Thu, 05 Mar 2026 16:49:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0779C31F0427
	for <lists+linux-integrity@lfdr.de>; Thu,  5 Mar 2026 15:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3024B3CA4B1;
	Thu,  5 Mar 2026 15:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FqL5Py8Q"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1233CA485;
	Thu,  5 Mar 2026 15:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772725059; cv=none; b=qCZsA4XYkWVMzGbq0i8LpMTsV28XV1eR8q12jSlrwJIfTaNTxfnW9uVGt+Th8NJm+Tc5W3C1HDhHay5NGHujnT1y6q0AmLTpcF3VzzLdAOIviNA1iQT+q7o+yA9GmoiO6LhBjjHmOd9q5RLY0zlYpCKzCwByI3UAVsCzT3hTB40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772725059; c=relaxed/simple;
	bh=jK1nSuevZdf0RKkYstE3VQvVjnthz0rex+B4wX8/qiE=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=nwLqKXicgTssbGnR92/qGVaSABPUt+A0cxcSgkV2U0qDAPEyKrDPIIxuqzGxqjEMZjL4yxq/yrcSDOF2T0uVVEYBqjv0OAoflX0VBVPrF3vcv0YzDRqIpr5ak2GesSKq/TdxqBDLsY58C8l5B2AV+lnoayMKXdxsSF+NsH0oCpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FqL5Py8Q; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6259YA8T674109;
	Thu, 5 Mar 2026 15:37:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=n0HweB
	/9FvorYvScvAYglLgAWuWNSf0Q2i8umhzaLaw=; b=FqL5Py8QYKpqdjLJLcM6In
	ahlPSpvqGhiZ87Gzg0gr8f/0O46x1C7zm9IXyV8Jo3eMFzsXf9AtuhbIGFagJLNI
	dxVXI4XJkJzQn3PWZiH50zSXe88XglFBXWku/8TGtLzlhc8hGFaFzoKoKxHkT+DE
	BRQEesV53xlohQGiiohbP7j/5fQitffoDpeqtJQMBNONBXn4K0DBsErgvjuUiuIT
	ma0zmaMjNMVFt27jBxKzKxFSlzGlC/K2oIhGW47G3AEw4fq16+90DZB6++SCE7W8
	mtVJ0ZQMlVu+xtCUdQBgxxTZMxluyCBFv/GeiVej5PQJosAZsEnqf7MEZOQ/G9Vg
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cksrjcdmh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Mar 2026 15:37:11 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 625DbExd029016;
	Thu, 5 Mar 2026 15:37:10 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cmapsc0vh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Mar 2026 15:37:10 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 625FbAEL28312202
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 5 Mar 2026 15:37:10 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 187D75805A;
	Thu,  5 Mar 2026 15:37:10 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9E32A5805D;
	Thu,  5 Mar 2026 15:37:08 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.185.249])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  5 Mar 2026 15:37:08 +0000 (GMT)
Message-ID: <dca994cd0ed11a262d4022c4984984460ba06a78.camel@linux.ibm.com>
Subject: Re: [PATCH v9 01/11] KEYS: trusted: Use get_random-fallback for TPM
From: Mimi Zohar <zohar@linux.ibm.com>
To: Jarkko Sakkinen <jarkko@kernel.org>, Chris Fenner <cfenn@google.com>
Cc: linux-integrity@vger.kernel.org, Jonathan McDowell <noodles@earth.li>,
        Eric Biggers <ebiggers@kernel.org>,
        James Bottomley
 <James.Bottomley@hansenpartnership.com>,
        David Howells	
 <dhowells@redhat.com>,
        Paul Moore <paul@paul-moore.com>, James Morris	
 <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "open
 list:KEYS-TRUSTED" <keyrings@vger.kernel.org>,
        "open list:SECURITY
 SUBSYSTEM" <linux-security-module@vger.kernel.org>,
        open list
 <linux-kernel@vger.kernel.org>,
        Roberto Sassu
 <roberto.sassu@huaweicloud.com>
In-Reply-To: <aadTgsbzDDkCg1Pr@kernel.org>
References: <20260125192526.782202-1-jarkko@kernel.org>
	 <20260125192526.782202-2-jarkko@kernel.org>
	 <06a08cbbe47111a1795e5dcd42fb8cc4be643a72.camel@linux.ibm.com>
	 <CAMigqh1H1NKP9gddjhf4M1v-aM=+EpW9O4KJmu=UysOWhn4ryA@mail.gmail.com>
	 <aadTgsbzDDkCg1Pr@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Mar 2026 10:37:08 -0500
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=Rp/I7SmK c=1 sm=1 tr=0 ts=69a9a328 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=KxeoQpAgAAAA:8
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8 a=oeA2Qd-FWMGMNsobgtoA:9
 a=QEXdDO2ut3YA:10 a=dJtPqE9Y5jwXgJ6xlkAX:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA1MDEyMSBTYWx0ZWRfX7JxhQknPyZhF
 p4wRSHH6i0Hl5NmaLQWXsO3k/0fyiH51/sj8KhsK3Cw5yUDEC9vCWLmZF5nFT1uJZgARd5zpBoX
 O2Zjf9xVPWasIyT1/R97J/w3q1MpwvDDj9PE/jCCmHCWVbz0vX30MFOMGl1U5FtjwkH3srTmaZU
 dB7g1zjWcAZQxoHZqt/YQj3y9YFuvUXJtK/TsopeT0pxisPkQhBYJSsEsKYCQKg+Ymygn0+oia5
 gkPhvottKNL/wvd39Nj37E79FcvuCvx1GDKXInrqDkABxPqTPE0jfwIjxUmXi1k7C2G8OiF1aJi
 i+VYbBU6jS+6BE2eLRGJ8QpthPsXzL9KWaCuamZ5yajk+noZsLdIfwzo/DcOyLNiySOKDZuT8IF
 eQYFl/PfFar5hvSFtMleRupQELVWsArr2Z/7A/r2PApsCVvOyoOg7dVZwhRS7zGFc6u7xBxJEOH
 V6uxqamcUy85SlaYvsQ==
X-Proofpoint-GUID: _C-N74wG_CIJsefjIirPc9Hfg-6Ra2uZ
X-Proofpoint-ORIG-GUID: 5kKQxuakx7GGh-cnWs7XsBKZx4ecLpXD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-05_04,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 spamscore=0 phishscore=0 adultscore=0
 bulkscore=0 clxscore=1015 impostorscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603050121
X-Rspamd-Queue-Id: C8B7F214D74
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-8932-lists,linux-integrity=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,dlp.rip:url,linux.ibm.com:mid];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zohar@linux.ibm.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Action: no action

On Tue, 2026-03-03 at 23:32 +0200, Jarkko Sakkinen wrote:
> On Fri, Feb 20, 2026 at 10:30:26AM -0800, Chris Fenner wrote:
> > My conclusion about TCG_TPM2_HMAC after [1] and [2] was that
> > TPM2_TCG_HMAC doesn't (or didn't at the time) actually solve the
> > threat model it claims to (active interposer adversaries), while
> > dramatically increasing the cost of many kernel TPM activities beyond
> > the amount that would have been required to just solve for
> > passive/bus-sniffer interposer adversaries. The added symmetric crypto
> > required to secure a TPM transaction is almost not noticeable; the big
> > performance problem is the re-bootstrapping of the session with ECDH
> > for every command.
> >=20
> > My primary concern at that time was, essentially, that TCG_TPM2_HMAC
> > punts on checking that the key that was used to secure the session was
> > actually resident in a real TPM and not just an interposer adversary.
> > I wrote up my understanding at
> > https://www.dlp.rip/decorative-cryptography, for anyone who wants a
> > long-form opinionated take :).
> >=20
> > Unless I'm wrong, or TCG_TPM2_HMAC has changed dramatically since
> > August, I don't think "TPM2_TCG_HMAC makes this too costly" is a
> > compelling reason to make a security decision. (There could be other
> > reasons to make choices about whether to use the TPM as a source of
> > randomness in the kernel! This just isn't one IMHO.)
> >=20
> > The version of TCG_TPM2_HMAC that I'd like to see someday would be one
> > that fully admits that its threat model is only passive interposers,
> > and sets up one session upon startup and ContextSaves/ContextLoads it
> > back into the TPM as needed in order to secure parameter encryption
> > for e.g., GetRandom() and Unseal() calls.
>=20
> Neither agreeing nor disagreeing but this patch set clearly does not
> move forward and I spent already enough energy for this. For better
> ideas the patches are available in queue branch.

Jarkko, you totally ignored my comments below.  I object to your removing t=
he
TPM trusted-keys RNG support.

Mimi

>=20
> High-level takes don't move anything forward (or backward), sorry.
>=20
> >=20
> > [1]: https://lore.kernel.org/linux-integrity/CAMigqh2nwuRRxaLyOJ+QaTJ+X=
GmkQj=3DrMj5K9GP1bCcXp2OsBQ@mail.gmail.com/
> > [2]: https://lore.kernel.org/linux-integrity/20250825203223.629515-1-ja=
rkko@kernel.org/
> >=20
> > Thanks
> > Chris
> >=20
> > On Fri, Feb 20, 2026 at 10:04=E2=80=AFAM Mimi Zohar <zohar@linux.ibm.co=
m> wrote:
> > >=20
> > > [Cc: Chris Fenner, Jonathan McDowell, Roberto]
> > >=20
> > > On Sun, 2026-01-25 at 21:25 +0200, Jarkko Sakkinen wrote:
> > > > 1. tpm2_get_random() is costly when TCG_TPM2_HMAC is enabled and th=
us its
> > > >    use should be pooled rather than directly used. This both reduce=
s
> > > >    latency and improves its predictability.
> > >=20
> > > If the concern is the latency of encrypting the bus session, please r=
emember
> > > that:
> > >=20
> > > - Not all environments expose the TPM bus to sniffing.
> > > - The current TPM trusted keys design is based on TPM RNG, but alread=
y allows it
> > > to be replaced with the kernel RNG via the "trusted_rng=3Dkernel" boo=
t command
> > > line option.
> > > - The proposed patch removes that possibility for no reason.
> > >=20
> > > Mimi & Elaine
> > >=20
> > >=20
>=20
> BR, Jarkko

