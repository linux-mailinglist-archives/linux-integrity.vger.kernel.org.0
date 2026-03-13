Return-Path: <linux-integrity+bounces-8988-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QHk8Mj4xtGmuigAAu9opvQ
	(envelope-from <linux-integrity+bounces-8988-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 13 Mar 2026 16:46:06 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3686E286491
	for <lists+linux-integrity@lfdr.de>; Fri, 13 Mar 2026 16:46:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 282E03290EBE
	for <lists+linux-integrity@lfdr.de>; Fri, 13 Mar 2026 15:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C2E38656C;
	Fri, 13 Mar 2026 15:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qnbCYwOC"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC71F3C4545;
	Fri, 13 Mar 2026 15:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773416465; cv=none; b=LVgKfmlQiIv9FD/R3u3qsHu5hjWS2v+TGevWK2J47zz7lgnclC6q/k/Pbo5PyEKqsGEoq1YpVI8P16iAlQ7aZNU38Q/pfNjroOT5tgbZDhq9BvZVFx/wYiSbSjrTywgYzIy6QIVJGXANwP1pKfjJhlwiT8zez0fTP6uKNYVQHWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773416465; c=relaxed/simple;
	bh=zpAHRTBuanYesHqnPYGrRHED3Yl3Hnq6t9k74xeYPpg=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=TEM79/ezgmprvDuPQ50LB5vBzV4wZCGsE3dQ2Ok3vHaKj+9MJG8z+8W0jmBg6WPIHzSUCl0LbW6BWkkGuPb8E0lG69lU2+MhSnLhY+QQ9rGwcyz1begkhLVk7J5lXnt8hraIz73IiyUKexQBFIH4RhLAIUfI6aTflPPdUSm0BNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qnbCYwOC; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62D5B2Bg2259422;
	Fri, 13 Mar 2026 15:35:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=4blGWL
	TNwciZlJ1JGFf57y21cB/j+hd6OhQxrPFKUBM=; b=qnbCYwOCwfMxxAbYOdsIol
	3FM9CO78egN45nCqMcJmAirimvvKyfQyvzNxFTT+G9mqjEblQLQHSxCCZfwfiX8V
	3t7KbVlQH5kF1CIolbNS/ORb2NhsqcNIAH8TSza+Jc2neJZKialtMUD+hbB2ldOS
	P799UzbEXhC1Y6R1eaisrqqlz/Af93wLYvPzjn1uELA0IuPhijF+lY+HO8I+SfOS
	jmYxj3CzJ1zrSpWdz5LCDuxucMQ4Xn9SoPRGdGPH3lOEtG5ulO2AEIX8dYtC7QXC
	FmifkMWW3ZqA22uNAmtTepbbqcJmNN+s4eaAW59tqeYa8hr7LN040JOVEeUyHq0g
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cuh92gg48-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Mar 2026 15:35:17 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62DFSJH6006130;
	Fri, 13 Mar 2026 15:35:16 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cuha9q6m8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Mar 2026 15:35:16 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62DFZE5V34734722
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Mar 2026 15:35:14 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8CD4058058;
	Fri, 13 Mar 2026 15:35:14 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E58E058057;
	Fri, 13 Mar 2026 15:35:12 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.190.35])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 13 Mar 2026 15:35:12 +0000 (GMT)
Message-ID: <0dec7e06d61eb8775d70e4d8bf1be98fff7a2af3.camel@linux.ibm.com>
Subject: Re: [PATCH] integrity: Eliminate weak definition of
 arch_get_secureboot()
From: Mimi Zohar <zohar@linux.ibm.com>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Roberto Sassu
 <roberto.sassu@huawei.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Eric Snowberg <eric.snowberg@oracle.com>,
        Alexander Egorenkov	
 <egorenar@linux.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy	 <chleroy@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik	 <gor@linux.ibm.com>,
        Alexander Gordeev
 <agordeev@linux.ibm.com>,
        Christian Borntraeger
 <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Paul
 Moore	 <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
        "Serge E.
 Hallyn"	 <serge@hallyn.com>, Coiby Xu <coxu@redhat.com>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, llvm@lists.linux.dev
In-Reply-To: <20260312205533.GC2747807@ax162>
References: 
	<20260309-integrity-drop-weak-arch-get-secureboot-v1-1-6460d5c4bb89@kernel.org>
	 <d2089740-16d8-4ca4-a61c-8c381f8e30a0@app.fastmail.com>
	 <a985c90d9df8ba0fc63f65117cc8e884f70e6035.camel@linux.ibm.com>
	 <20260312205533.GC2747807@ax162>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Mar 2026 11:35:12 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: 59AJO5q2NmJeb8Rolla9nJmSuuxhw6YQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDEyNCBTYWx0ZWRfX9aSEbAynOTD2
 UeJLB+Dd5ETgybJ8X78OLdjbas70sNl4JkiLY2bQgWpqeaA9Bq9rz7HejSSEaj4T0A5FsF28woD
 r0l51GZUhKSYl7jlb/t7A4klpYtKU/gkZNh0HLwC0eZr7N8tvSI2xFbdL3dM5Ft4hBrdmeRl12D
 yN1mi8hd1UFyQ4NJcE5ulUzUuNhrdkchk2nkNzUIKkNFmznEW/dBToaqXOJRXTUbZGEZDWuJTJX
 lIVXqQUI8ikcOEJDFppzCs7DpCJM9/tRjWO43FDUDzFeIg/AWHsViTtEQM9uJvr6LWzuKDUXTp4
 dpeimsnm7vZfjmHKdJBnKYohGLm9SRyAa8bHnNuuQJNcuDP/FFc1ws3/3w9XAy2KFIrQoAT9TXt
 y2AdsOvmkT13f1Htb4+PxPM2BmwyVMOw0jnflDfTJTJNxhiZxg7kK7vmn6f/XEcj7/CdH1zUo5z
 6f68HNPiTwzy7KqoXcA==
X-Proofpoint-GUID: Kc_uVUzOyW2576MqDxMLZmh21g7_PRH-
X-Authority-Analysis: v=2.4 cv=XNk9iAhE c=1 sm=1 tr=0 ts=69b42eb6 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=Jgx6WarZ80nwb2z7rPIA:9
 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10 a=zZCYzV9kfG8A:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_02,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0
 bulkscore=0 phishscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603130124
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[25];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8988-lists,linux-integrity=lfdr.de];
	FREEMAIL_CC(0.00)[arndb.de,huawei.com,gmail.com,oracle.com,linux.ibm.com,ellerman.id.au,kernel.org,paul-moore.com,namei.org,hallyn.com,redhat.com,vger.kernel.org,lists.ozlabs.org,lists.linux.dev];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.ibm.com:mid];
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
X-Rspamd-Queue-Id: 3686E286491
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 2026-03-12 at 13:55 -0700, Nathan Chancellor wrote:
> On Thu, Mar 12, 2026 at 12:07:41PM -0400, Mimi Zohar wrote:
> > I pushed out the patch to next-integrity, but am a bit concerned about=
=C2=A0the
> > definition:
> >=20
> > +config HAVE_ARCH_GET_SECUREBOOT
> > +       def_bool EFI
> > +
>=20
> What is concerning about the definition with regards to s390?
>=20
> > Has anyone actually tested this patch on s390, not just compiled it?  I=
f so, I'd
> > appreciate a tested-by tag.
>=20
> It would be good to test (if it is possible to test in QEMU, I am happy
> to attempt to do so). As far as I can tell, 31a6a07eefeb placed
> arch_get_secureboot() in such a way that the __weak definition would be
> used when CONFIG_KEXEC_FILE was disabled, even though ipl_secure_flag
> should always be available, which this patch avoids.

Thanks, Nathan.  Fortunately I got access to an s390 and was able to test. =
 It
seems to be working.

Mimi

