Return-Path: <linux-integrity+bounces-4722-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CC0FA27F08
	for <lists+linux-integrity@lfdr.de>; Tue,  4 Feb 2025 23:57:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2B1C167B22
	for <lists+linux-integrity@lfdr.de>; Tue,  4 Feb 2025 22:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35DDE21CA12;
	Tue,  4 Feb 2025 22:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="buDx+2EI"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F621204F94;
	Tue,  4 Feb 2025 22:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738709609; cv=none; b=Trmk8VRjO1uSnFmOsPgnqUvlRNgFggWFNZCBFK3glK6AaedA/zqlWCpgNzRgVM5l6WlIyyHI3yDM6gRaLl5D2SgMlRLouCeIBl4OWEmAlD42shccvijeDHge+x1aIkvn9pib65J+ISFXSwVL0adiu9G2EdiJl2zos5daWRL+VlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738709609; c=relaxed/simple;
	bh=MSRkW2CExr0tVUC2SzMHSlIAyDIbX/p6MVhCG2p/mKw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ve+6Aq8rHIkDIwOSY6Z578N/qNfr3ngOe24pqUu65PcCtrfx9N7+3BXTHtpnV3H8hV1FCwTdm4OnSd/TdgNYg/zegACZmUVaQ5lhDbuKS6lwGjNYO4b/8+fBJFQ86r9XT5lz73tFntaign+PzMCPAHIfSkG+Z3ww5U2C49re9nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=buDx+2EI; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 514GEomA028728;
	Tue, 4 Feb 2025 22:51:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=2FhDku
	tlFDrUXKpErmzzncgU1ZoP8wGLXswD+EnhQbo=; b=buDx+2EIwON7ki0cbzYcuJ
	OoacryrPaq0O9pjpC26J6FQwHw0sJ5aOQkcI6Slj5PHhp7HfDMpL0XHwnLU3zsUk
	kBxg7IqjmQQrIe0eGkn4DNSlvBmP7Pt94OCq1a7wGdANna6hBnJy7e+rygE3ygME
	XpVpqorVcyhGj6lYNU4Pz9OiN/skVuJFH7jy77plKb8FRHjDm2UdTVgljKR13OhQ
	qUxk/XkbSEjsILb+aWOJl7UXcAJvcjrhmQ2gPFGfaKAPvPNCnYod7hFXPIQw2TfS
	xIwNFKymBcMEfreQTE5/jpZPqQdF5R/L6ndcBpaYzVKnaUHGgHEr3OMBiBe1V/AA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44knqtsww9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Feb 2025 22:51:58 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 514L0Zkr005261;
	Tue, 4 Feb 2025 22:51:57 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 44j05jwkxy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Feb 2025 22:51:57 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 514MpvRM6357672
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Feb 2025 22:51:57 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F104B58043;
	Tue,  4 Feb 2025 22:51:56 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1231658055;
	Tue,  4 Feb 2025 22:51:56 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  4 Feb 2025 22:51:55 +0000 (GMT)
Message-ID: <fff34d89-6009-43d1-8033-5c62b812938b@linux.ibm.com>
Date: Tue, 4 Feb 2025 17:51:55 -0500
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 3/7] ima: kexec: skip IMA segment validation after
 kexec soft reboot
To: steven chen <chenste@linux.microsoft.com>, zohar@linux.ibm.com,
        roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
        eric.snowberg@oracle.com, ebiederm@xmission.com, paul@paul-moore.com,
        code@tyhicks.com, bauermann@kolabnow.com,
        linux-integrity@vger.kernel.org, kexec@lists.infradead.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: madvenka@linux.microsoft.com, nramas@linux.microsoft.com,
        James.Bottomley@HansenPartnership.com
References: <20250203232033.64123-1-chenste@linux.microsoft.com>
 <20250203232033.64123-4-chenste@linux.microsoft.com>
 <00eeeb8b-cc28-42af-873f-3478cd22fb6e@linux.ibm.com>
 <aeef2ca5-2538-4487-a501-7eb2925d198b@linux.microsoft.com>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <aeef2ca5-2538-4487-a501-7eb2925d198b@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Z4ncMD1yBBQd530Qu8FeBYpetBqy8kFO
X-Proofpoint-ORIG-GUID: Z4ncMD1yBBQd530Qu8FeBYpetBqy8kFO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-04_09,2025-02-04_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 clxscore=1015 mlxlogscore=857 phishscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502040167



On 2/4/25 3:28 PM, steven chen wrote:
> On 2/4/2025 11:39 AM, Stefan Berger wrote:
>> On 2/3/25 6:20 PM, steven chen wrote:
>
> 
> Hi Stefan, I will update in next release. Thanks!

You should try to rebase it on 6.14-rc1. There were a few changes.


