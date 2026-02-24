Return-Path: <linux-integrity+bounces-8546-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +HX6Mrk8nWkGNwQAu9opvQ
	(envelope-from <linux-integrity+bounces-8546-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Feb 2026 06:52:57 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E5D518236D
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Feb 2026 06:52:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 06CD2302A686
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Feb 2026 05:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BEB72C3757;
	Tue, 24 Feb 2026 05:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TTA+LMoL"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CDF21D5170;
	Tue, 24 Feb 2026 05:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771912375; cv=none; b=tA8sEkTH3ZnPpI2BdBjUwCYTGpA8/uHWXGpPdC25Q8uqtiVkv6EKH85rFuSyBaMFdALj6Zj2gTEWBJHCzzm36VpvV6FMrrbTv/Xe0IA7pb/Zuf3LhjfEGL5nkntHG/9u4/syDBF5XsJaqJvUWvBqrStANQxqZNgJ4GHT69HJs5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771912375; c=relaxed/simple;
	bh=kH4o+o59w7G9ikQ6tVVWWwR1R5OfG0PsSFFjkcxW2ac=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fil1G5y3D3FxKosb/hmXdqX2X2Xjl6hU3KwvoPcQXHq6D1fGIYn9gC6PyXU4537oJFPRuLAVMEI7sYJ4fpQxhLaOPUav02QRgQ9BxMzJXmY9JTLtvvweBxb0OARuuhn8byHKx6JniRcRic1/xPTxegYZCa+gHhx3fx/m4anhGSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=TTA+LMoL; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61NIdo113039381;
	Tue, 24 Feb 2026 05:52:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=JyzHRyhMS23W43iQ6/kdXznfjN0Z7X
	zq2lHwd9qxF+o=; b=TTA+LMoLMpcNwXiqgL/sNC/S4hDp3GITzSS78OwwTuEkBh
	dfFw29SsosNk+quCE0tF9SzIgCxRy5smLlQXVQ2hz7b7I3V7+WAAEu6790SJRcRJ
	xgVa4GjjxxaUfvwUEHEcvA/uZX3+12X15D5hNeAXs0rImOU1UQ9QFt48vt0eiso9
	MUca4d7N2aNuiBoZ0NQSyAy6BRuWrxfZfdmfKrmuwxigyW775Mu+3NjbQ370QNN3
	kJbUkLBqELX1clIjEI+ZXGptD8u9XvbQAAvu/wCXef7YbuCDVLcmQrJrAjw6ly6k
	9yKnmdbxEISFRJLbzljGhR7ai79HEThP7hNcI4lg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cf4cqt2vt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Feb 2026 05:52:43 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61O2wvGw004541;
	Tue, 24 Feb 2026 05:52:42 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cfs8jqfjg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Feb 2026 05:52:42 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61O5qccL53084470
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Feb 2026 05:52:39 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CD7B620043;
	Tue, 24 Feb 2026 05:52:38 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B995420040;
	Tue, 24 Feb 2026 05:52:38 +0000 (GMT)
Received: from localhost (unknown [9.52.203.71])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 24 Feb 2026 05:52:38 +0000 (GMT)
From: Alexander Egorenkov <egorenar@linux.ibm.com>
To: Mimi Zohar <zohar@linux.ibm.com>, Coiby Xu <coxu@redhat.com>,
        linux-integrity@vger.kernel.org
Cc: Heiko Carstens <hca@linux.ibm.com>, Ard Biesheuvel <ardb@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander
 Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger
 <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        "open
 list:S390 ARCHITECTURE" <linux-s390@vger.kernel.org>,
        open list
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 3/3] s390: Drop unnecessary
 CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT
In-Reply-To: <82f97981195dd5e0c1c265c21d5dac3ab907ed4c.camel@linux.ibm.com>
References: <20260213012851.2532722-1-coxu@redhat.com>
 <20260213012851.2532722-4-coxu@redhat.com>
 <82f97981195dd5e0c1c265c21d5dac3ab907ed4c.camel@linux.ibm.com>
Date: Tue, 24 Feb 2026 06:52:38 +0100
Message-ID: <87tsv6ofh5.fsf@li-0ccc18cc-2c67-11b2-a85c-a193851e4c5d.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: iKa9TPH8N-ofN4SZVxV0G6iSrYVwDXCG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI0MDA0NiBTYWx0ZWRfXyrhdVVNJVZ75
 cwS/bPPYXgfWbnNo11nE0CfCBxS8abyMbOZ5TVrWnyoBiA/pGdi1R+ns1GAbffuamrVdhpR32Sv
 gMSrEGKbml16s25U+9ev3BL9HrCOXAkCvt4GPhERuuzQifSbxraeENyKqJnqomW+12JKGJPa6wK
 u/ZILJ/aHOb8xZ3XWIeAFXtb7Dd+0ODN+Ib3+kVDd+FbqqqTRYlNlup2DySaQl447gPnvJB9cvF
 Z5gJsEQW64a9h4kLJo5mBCg9xecISxn+z2Xv5xJbF78+gxbYb9qa8rCIfEmzWXyHGK9DTe+TIUt
 yUIS81x+rgDWpVO6F+P1bJd+FDn+Q2R6bo/2s8SY2EVYO9J4eq+yzEJMrImAYTDl7rv7whykxA1
 /ns84pdp6AC2nexOwRlA6ouWP7Bjcu/Jid2gV3Ezn6Nu7IWxayREz9kqrXf0I6ELYiGNFpMioW2
 epI7zUPBFxOzxBoxW1Q==
X-Proofpoint-GUID: iKa9TPH8N-ofN4SZVxV0G6iSrYVwDXCG
X-Authority-Analysis: v=2.4 cv=bbBmkePB c=1 sm=1 tr=0 ts=699d3cab cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8
 a=zHVu4LtvGnjouKcQAcIA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_06,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 clxscore=1011 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602240046
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-8546-lists,linux-integrity=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[egorenar@linux.ibm.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[li-0ccc18cc-2c67-11b2-a85c-a193851e4c5d.ibm.com:mid];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 6E5D518236D
X-Rspamd-Action: no action

Mimi Zohar <zohar@linux.ibm.com> writes:

> On Fri, 2026-02-13 at 09:28 +0800, Coiby Xu wrote:
>> Commit b5ca117365d9 ("ima: prevent kexec_load syscall based on runtime
>> secureboot flag") and commit 268a78404973 ("s390/kexec_file: Disable
>> kexec_load when IPLed secure") disabled the kexec_load syscall based
>> on the secureboot mode. Commit 9e2b4be377f0 ("ima: add a new CONFIG
>> for loading arch-specific policies") needed to detect the secure boot
>> mode, not to load an IMA architecture specific policy. Since there is
>> the new CONFIG_INTEGRITY_SECURE_BOOT, drop
>> CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT for s390.
>> 
>> Signed-off-by: Coiby Xu <coxu@redhat.com>
>
> Alexander, you added your Tested-by for the original version of this patch set.
> Can I apply it for v3?
>
> thanks,
>
> Mimi

I have verified v3 on one of our secure boot machines, it looks good too.

Tested-by: Alexander Egorenkov <egorenar@linux.ibm.com> 

