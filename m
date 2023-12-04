Return-Path: <linux-integrity+bounces-339-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C6158035BA
	for <lists+linux-integrity@lfdr.de>; Mon,  4 Dec 2023 14:59:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00E3D281071
	for <lists+linux-integrity@lfdr.de>; Mon,  4 Dec 2023 13:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B60A25753;
	Mon,  4 Dec 2023 13:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cmXomMuo"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EE63107;
	Mon,  4 Dec 2023 05:59:12 -0800 (PST)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B4DX86D029757;
	Mon, 4 Dec 2023 13:59:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=uX4riAgz7GvgVjeGz+iSIBg2lEzrAtgqjCIItvWPRz4=;
 b=cmXomMuo6EUsbs41/OeUOmni+/y4rj/HYX/dD/Mn5r9341CceJ2rkd7w2Kk5k00ga2YT
 vO8bz/hqUkwXPBRCRR45Sv02hn8dnWxQ1zQKEy/ZhAHMNSANNPy81lB6YwwyVvrMDij/
 VxFVYYgrXv7urQvKNJdPLsYXtC6gXOMFHahx/qmOBqmVvpf31NoJFiBbjvkHp0r8wzxv
 zTZ4wgdogbJUyvJo7+Z7FVBoKfX9epP0ibhgRzrWz4ZNvgeHFMaodxT1iYMp8diaae5w
 JZzyEvG57BQFuMfnurtNFPxhOOLHShLITqX/dbRPtNIn6zthCyerKv8DhDRI2H0Ql8Te kQ== 
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3usfra8vp5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Dec 2023 13:59:09 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3B4Amxn9005068;
	Mon, 4 Dec 2023 13:59:08 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3urhm1yw0q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Dec 2023 13:59:08 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3B4Dx7V651577106
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 4 Dec 2023 13:59:07 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 982505805D;
	Mon,  4 Dec 2023 13:59:07 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1548E58053;
	Mon,  4 Dec 2023 13:59:07 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.81.193])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  4 Dec 2023 13:59:06 +0000 (GMT)
Message-ID: <113aa55fcdd8167e6cd87b88f0beeef743bc740e.camel@linux.ibm.com>
Subject: Re: [PATCH v4 08/13] tpm: Add full HMAC and encrypt/decrypt session
 handling code
From: Mimi Zohar <zohar@linux.ibm.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>,
        Jarkko Sakkinen
	 <jarkko@kernel.org>, linux-integrity@vger.kernel.org
Cc: keyrings@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 04 Dec 2023 08:59:06 -0500
In-Reply-To: <41fe65c907cbe5683cabe9e3782132391c20f726.camel@HansenPartnership.com>
References: <20230403214003.32093-1-James.Bottomley@HansenPartnership.com>
	 <20230403214003.32093-9-James.Bottomley@HansenPartnership.com>
	 <CX8FJA25TO6W.ET37QQIXFGQH@kernel.org>
	 <4e7fd5c07dede4ebe640dcc3b123adcb1e65f1f0.camel@HansenPartnership.com>
	 <CXF71WGDHXAW.28FXYY08L1DMR@suppilovahvero>
	 <987f9fc8e9e8df38e66e6d4a2fd1f8eb570899ff.camel@HansenPartnership.com>
	 <7d5a1ff219c40efccabcb0336361a16b53796998.camel@linux.ibm.com>
	 <41fe65c907cbe5683cabe9e3782132391c20f726.camel@HansenPartnership.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: MTkzb4ZTEgCl9GeOZwWslSuKeaIKKPJf
X-Proofpoint-GUID: MTkzb4ZTEgCl9GeOZwWslSuKeaIKKPJf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-04_12,2023-12-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 bulkscore=0 mlxlogscore=999 clxscore=1015 mlxscore=0 impostorscore=0
 suspectscore=0 phishscore=0 priorityscore=1501 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2312040105

On Mon, 2023-12-04 at 08:53 -0500, James Bottomley wrote:
> On Mon, 2023-12-04 at 08:43 -0500, Mimi Zohar wrote:
> > On Mon, 2023-12-04 at 07:35 -0500, James Bottomley wrote:
> > > On Mon, 2023-12-04 at 04:29 +0200, Jarkko Sakkinen wrote:
> > > > On Sun Nov 26, 2023 at 5:05 PM EET, James Bottomley wrote:
> > > > > On Sun, 2023-11-26 at 05:39 +0200, Jarkko Sakkinen wrote:
> > > > > > One very obvious thing to fix there is the kconfig flag:
> > > > > > 
> > > > > > 1. Its meaning and purpose is not documented to the commit
> > > > > > message. What is it and what is its meaning and purpose.
> > > > > > 2. TPM_BUS_SECURITY does not follow the naming convention of
> > > > > > other TPM kconfig flags, and to add, "security" is way way
> > > > > > too abstract word. Something like TCG_TPM_HMAC
> > > > > > 
> > > > > >    It should be renamed as TCG_TPM_
> > > > > 
> > > > > One question is do we still need this?  Since my tree has moved
> > > > > ahead, I also need the HMAC code for policy on keys and the
> > > > > primary code for permanent parents.  The only real performance
> > > > > concern is for PCR extension (no-one really cares about the
> > > > > speed of unseal or random), so a different possible way of
> > > > > doing this is simply to CONFIG that one operation.
> > > > 
> > > > I think so.
> > > > 
> > > > Major distributions have started to ship with TPM2 sealed
> > > > hardware drive encryption, based on LVM/LUKS2 partitioning setup.
> > > > It is convenient enough that at least I prefer it over encrypted
> > > > passphrase.
> > > > 
> > > > Having this feature would add defence in depth to that. I could
> > > > definitely see distributions adapting also to HMAC because now
> > > > there is already too legit uses cases (ignoring the people who
> > > > just enjoy configuring obscure things).
> > > > 
> > > > So motivation has rised by a factor now, i.e. it makes sense now
> > > > more as a "product" and not just research topic, given the use in
> > > > the workstation, in addition to the data center.
> > > 
> > > Sorry, miscommunication.  By "this" I meant the config option not
> > > the entire HMAC code.  The proposal without it would be
> > > unconditionally compile tpm2-sessions.c and do HMAC/encryption on
> > > random and seal/unseal but gate the PCR HMAC via a compile or
> > > runtime option so as not to degrade IMA performance if performance
> > > were preferable to security.
> > 
> > Is there a way of not degrading IMA performance without disabling
> > HMAC encryption/decryption?
> 
> Well, perhaps we should measure it.  My operating assumption, since
> extend is a simple hash, is that most of the latency of extend is
> actually in the LPC (or i2c or whatever) bus round trip.  To do HMAC,
> you have to have a session, which adds an extra command and thus
> doubles the round trip.

Agreed getting some statistics would be beneficial.  Instead of
creating a session for each IMA extend, would it be possible to estable
a session once and re-use it?

Mimi


