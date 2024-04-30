Return-Path: <linux-integrity+bounces-2290-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E5E08B736B
	for <lists+linux-integrity@lfdr.de>; Tue, 30 Apr 2024 13:18:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 442CBB21CCC
	for <lists+linux-integrity@lfdr.de>; Tue, 30 Apr 2024 11:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D4EA1E50A;
	Tue, 30 Apr 2024 11:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="haI+hWjy"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DDD617592;
	Tue, 30 Apr 2024 11:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714475926; cv=none; b=mNpnypQu41oqYPKEA33vfAAXsVCqnLddNEeE9jpoVvNGSbYME1RrqiJK5ZgyhoYw6J9nt+uNPPjEzRYKJu4hP5BV0/djpSPnC7nxgTLb5xI7I1P4TVOijuF1lCTcIf5HoQT50vsdBoik6yggTDsaTg3SUqyRcl3thOVc/OXusq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714475926; c=relaxed/simple;
	bh=Qz/jPeOli8r+rNkNjZsfTvEYFbwvvgk4Yhq9HLqJ0vE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=S4sKlRt10xBApu5/3bFVaM0Y1F/UOg7dv9wmKLs46wt1I/tpQtWZOaYPFxuhM1ZvCl7NOa6glEovbLCboWeEWTU5Mtzx4RSLsg0rftAaUmXU589E/Om+mqCfUt/Vuo6zAcGM6QURRDyMNL+ZHBTGC4oRWE2v5g20REDh2cTZuXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=haI+hWjy; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43UBDm2X020762;
	Tue, 30 Apr 2024 11:18:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=Jtt6L/XYsuVTnicLUyvX1Q8oT/AB3kf8LXYoFZ2v51M=;
 b=haI+hWjykZptSaKj00STsLcFk4cRChX+IohYsRhaw7saDuY0XWxtnYAapnLmhGRhhaTL
 uu00VQpZ7pT4cCxXPSNvCcd0dQZfRMO1B15eYkiMrUtHgmiRzy8c2Xd1q7U2vDS99Zsd
 RDkgP6ZpLqoT5JcljPRKses8bHHoj4WhDLIVtZYMauUTiF3oFNStePiB5rOApKnDeeWU
 s/76KRlrLpEG3msUeDVfGqh4zxfo7liCeXj/PURz3UTc5eXIkk+lWTm3yjh55wkDtrMU
 ySuPSBpZZ33hqbtEiDQO1AbLQw+mkvYgaGLUR9cvm4+K/9Nqm2qFUvjz+pF9qWglYxM+ Ug== 
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xtyk0g0d1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Apr 2024 11:18:39 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 43UB0dGQ015577;
	Tue, 30 Apr 2024 11:18:38 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3xsed2v9vu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Apr 2024 11:18:38 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 43UBIaR234865666
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Apr 2024 11:18:38 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 305FA58058;
	Tue, 30 Apr 2024 11:18:36 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DA3865805D;
	Tue, 30 Apr 2024 11:18:35 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 30 Apr 2024 11:18:35 +0000 (GMT)
Message-ID: <3e6bafc8-99df-4e84-8f3a-8181c9f84e24@linux.ibm.com>
Date: Tue, 30 Apr 2024 07:18:35 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 00/22] add integrity and security to TPM2 transactions
To: Jarkko Sakkinen <jarkko@kernel.org>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-integrity@vger.kernel.org
Cc: keyrings@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
References: <20240429202811.13643-1-James.Bottomley@HansenPartnership.com>
 <D0WYH9UDXCZC.3OZ9MSOVTDBE1@kernel.org>
 <D0WYKBCRV1BS.EWPTEY7QUG85@kernel.org>
 <D0X0BN0RI4UG.2T8WRIFTWXE96@kernel.org>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <D0X0BN0RI4UG.2T8WRIFTWXE96@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: g2vJ2yLBsW_O_IjGWW9eG3AvUKwhrIrj
X-Proofpoint-GUID: g2vJ2yLBsW_O_IjGWW9eG3AvUKwhrIrj
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-30_04,2024-04-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1011
 bulkscore=0 impostorscore=0 mlxscore=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0
 mlxlogscore=999 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2404010000 definitions=main-2404300081



On 4/29/24 19:49, Jarkko Sakkinen wrote:
> On Tue Apr 30, 2024 at 1:26 AM EEST, Jarkko Sakkinen wrote:
>> Right and obviously 3rd option is to send a PR to
>> https://gitlab.com/jarkkojs/linux-tpmdd-test.
>>
>> I.e. patch file goes to patches/qemu (BR2_GLOBAL_PATCH_DIR
>> points there).
> 
> Stefan, can I do a "zero QEMU changes" negative test for
> changing null seed by somehow reseting swtpm? That would
> be best possible option (if it is possible).

You cannot easily reset swtpm without changing 'something' and resetting 
the NULL seed only works when running TPM2_Startup. You could modify 
some TPM2 command to do what HierarchyStartup does with the nullSeed to 
simulate what you want.

> 
> It does not matter what side-effects it has on swtpm side
> as long as the hmac path gets invalidated, as then the
> device is rendered as unusable.
> 
> BR, Jarkko

