Return-Path: <linux-integrity+bounces-8155-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 66CFACEF0DC
	for <lists+linux-integrity@lfdr.de>; Fri, 02 Jan 2026 18:24:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 10F503012776
	for <lists+linux-integrity@lfdr.de>; Fri,  2 Jan 2026 17:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 595432C0F9E;
	Fri,  2 Jan 2026 17:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gDPp8jog"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC45D273D6F;
	Fri,  2 Jan 2026 17:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767374645; cv=none; b=vDQXqdZnK1APkUXIk9LjbjwDjekkcGGI62i0WoN+iYsxwKv8gMt1V8ZAjDfTJGh2cOWw1gg/5cg3B67BHH9RTAwG1EMt7iHbhAUr/oL7v14xiaW8UHfvz/2vGQZEq9IjbiKP9vzQjagop2I1LmZ1eJY2L3s4dnfOH44zMkuTSRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767374645; c=relaxed/simple;
	bh=ze1t0HSoVtwVpp45sEbdbOBu9rBOWJHz6bjhHet3Le4=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=GNc5yzGPB+AVw4JR6Z3MnXFpRb8L9+a9r2w4VaIlQ4cP7Dxqmye0N30a6fqq70Mb++QKbtZxSiI7IqrEqoysXbER220NRJ2bqPWZfMK5Xmfjr1hDzlwj7TjM/bGFgYnhHE9rBKxC/D3SoA9o4KsV+XrrMgBAPgxH6GUsW95X/+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gDPp8jog; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 602FFKHV010232;
	Fri, 2 Jan 2026 17:23:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ze1t0H
	SoVtwVpp45sEbdbOBu9rBOWJHz6bjhHet3Le4=; b=gDPp8jogfeaMd8HnTKJpEg
	aFEQV5sSGKiku4miEqtdGo+EcnN+M37dwjQyYSmauEcZ6jKS2Fwd8ORECJLugX/y
	k7okoJwQcXt4py5zkZu1NQhtB2j08mwAQ8yG2p1X/fYLxKUnNSvzt6VZBAyxekMB
	xGIrZoVGK0n6ic1B/fLlk0PvCMTxuwpZ+ohRHACrkHER5Ncy7RQeeZWx7aQ7P4lE
	PyXXiN0iDcGvudTBgv3nVn/4q9TMC40/sf5Nxc7j+UTHKzGCNPRXJNC7Zqfz+okv
	hTl24JiJCy79n7cFk65EEb5jwPOx8Yvr0P3EMVVFUjLZ0C/Vw5KM61VPUVaS7kyg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ba5vfdcwx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Jan 2026 17:23:43 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 602HG7q0015791;
	Fri, 2 Jan 2026 17:23:43 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ba5vfdcwv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Jan 2026 17:23:43 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 602EeKta026013;
	Fri, 2 Jan 2026 17:23:42 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4batsnqfdy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Jan 2026 17:23:42 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 602HNeN28127344
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 2 Jan 2026 17:23:41 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D6C195803F;
	Fri,  2 Jan 2026 17:23:40 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7A16858054;
	Fri,  2 Jan 2026 17:23:39 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.43.105])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  2 Jan 2026 17:23:39 +0000 (GMT)
Message-ID: <b37e42f245bff2ac47a0c97d91592f5089f99979.camel@linux.ibm.com>
Subject: Re: [PATCH v2 1/6] pseries/plpks: fix kernel-doc comment
 inconsistencies
From: Mimi Zohar <zohar@linux.ibm.com>
To: Srish Srinivasan <ssrish@linux.ibm.com>, linux-integrity@vger.kernel.org,
        keyrings@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, James.Bottomley@HansenPartnership.com,
        jarkko@kernel.org, nayna@linux.ibm.com, rnsastry@linux.ibm.com,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
In-Reply-To: <20251217172505.112398-2-ssrish@linux.ibm.com>
References: <20251217172505.112398-1-ssrish@linux.ibm.com>
	 <20251217172505.112398-2-ssrish@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Jan 2026 12:23:38 -0500
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.54.3 (3.54.3-2.fc41) 
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=a9k9NESF c=1 sm=1 tr=0 ts=6957ff1f cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=PF3O2vm9e2mnU8G7xqAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: -eDRTaFxnuSK5d7pvnFMlr0GsGZkZWoa
X-Proofpoint-ORIG-GUID: eu82CnB8m5OaGdcVGiFbXbKtjHLp97U5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTAyMDE1NCBTYWx0ZWRfX7RzsYMzBP9qN
 kIH3dcHavEZ7X39qUchrbbE5shCK7T6E3mGJQ7qKPG6XHLgXWnmgfY/YOMytXCznp4UufF7ieFX
 hm6lKi3Kc1y7P7H4sGzTR0QILuQB0NrL00xuJFxkOIQu9bre+LJvzP36kONMfqB47h1riziLe1h
 6vwaWqQDEmt0Qs8ioagHJEf0Q8TPcqOmEu7j94fC11Vx8ArDkxxcpT8iap8eAa9j38pxxwVeBwt
 1UkJZ0rfxbxUJzwQiG18k2tnJ0Nzt3I08xe8quN2DfyarTFhqWZlPr0Wfqn5eC9KCjjdbF354Kt
 f3UbzYJq9LRXp/L9lDt7Xw5WmsJnpPnoysKnfO78WEVwqblFPNREL0m9VI+sFoZLVuri7rEGIBk
 kul6OwixmJz3RHql6qiOffJe9KiZgBUA9iwjdeFSP9vxgOTs3ku5deAKUN4LdZzpkItak+HSfOD
 Ffy61nciehR4tsyL/Lw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-02_02,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 impostorscore=0 clxscore=1011 adultscore=0
 priorityscore=1501 phishscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2512120000 definitions=main-2601020154

On Wed, 2025-12-17 at 22:55 +0530, Srish Srinivasan wrote:
> Fix issues with comments for all the applicable functions to be
> consistent with kernel-doc format. Move them before the function
> definition as opposed to the function prototype.
>=20
> Signed-off-by: Srish Srinivasan <ssrish@linux.ibm.com>

Thanks Srish for moving and fixing the kernel documentation.

--=20
Mimi



