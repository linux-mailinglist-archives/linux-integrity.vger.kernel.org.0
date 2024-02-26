Return-Path: <linux-integrity+bounces-1480-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ABD0867FD4
	for <lists+linux-integrity@lfdr.de>; Mon, 26 Feb 2024 19:30:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA948B242D2
	for <lists+linux-integrity@lfdr.de>; Mon, 26 Feb 2024 18:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7188E12CD89;
	Mon, 26 Feb 2024 18:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="iXexnhPL"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101B312F362
	for <linux-integrity@vger.kernel.org>; Mon, 26 Feb 2024 18:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708972137; cv=none; b=IAyUQj9vT8AUz7Xb+cakE14lyvZgMgvAuCmuBE0J2ZAH6X8C8yhbkODt5UoijTCGcuY7FpyDnsCoyvtQ4wENOLFGqFGLoS761qWYOoWYvEE2dsi2u4CFiXKW/wOq8VilreamNsGqoY1jpNioKeChUqGhT9FUQifOj/+ZZLfhnSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708972137; c=relaxed/simple;
	bh=Qrjh/ARFOv0a3OmbZoHLvkT2+G0jFHA9XIW4C6z0D2k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lZxf3Z3aUNshYDfoJ784+4SxdWff3hL5g6uDqONW4G9LlzSQUN7NVjJag7XzCYh8nVHmmJi3gLsKN/YJNu4alwOLivi7ICt9P5PbQ20EgfcNEPoiIH9zu26CpHDVYlilzd8cQltkFcK5wUt9oiqe+0XRBNjW1p1BbLdx24zp5Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=iXexnhPL; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41QHRNDh006885;
	Mon, 26 Feb 2024 18:28:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=83zmaQHEZB1v5WYRuaHsnDCVp07rMHUvP6PNKrX8LnE=;
 b=iXexnhPLR4iYjKALGLlCv3cRz5aF59hnkXr71E4+h9TVF+nV6evYFnkmWe3ecNsWWOyX
 Yk1i7AFq1LKbpprFtvQQpdHhpBzTW17tDqwfepLDmUQaZhybQ7bDggoORyz9OUnj2C18
 GT8hZMfleZeGiijLKF8gYK7bxa8C1p3s39difZhViA60iWJlEtwQ55sj0Pa++iA3yMHj
 JhlMnvqfwDo8Rx2yBDXXhvWDWBIvRmaHg/sHs/ez55LsECOU6ofWA+TAoRVVWvZwyFnl
 7e9sQilT83OmuQsmsskiaZthlupe+yWmXIj8Oy8R0yE5An1H4RvUjlzqSMIdZkXuNvJX AA== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wgy25scfx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Feb 2024 18:28:51 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41QH2TqN008154;
	Mon, 26 Feb 2024 18:28:50 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wfv9m2t6h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Feb 2024 18:28:50 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41QISmWY33686242
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Feb 2024 18:28:50 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E933458065;
	Mon, 26 Feb 2024 18:28:47 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7D0205804B;
	Mon, 26 Feb 2024 18:28:47 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 26 Feb 2024 18:28:47 +0000 (GMT)
Message-ID: <be970db7-b895-4102-9b16-4c5db6914597@linux.ibm.com>
Date: Mon, 26 Feb 2024 13:28:46 -0500
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 ima-evm-utils 0/7] Deprecate sign_hash and add provider
 support
Content-Language: en-US
To: linux-integrity@vger.kernel.org
Cc: zohar@linux.ibm.com, roberto.sassu@huawei.com, vt@altlinux.org
References: <20240226182101.25210-1-stefanb@linux.ibm.com>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20240226182101.25210-1-stefanb@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: DD0Mt7VfwBavcKYETwu3upEfFxzKRptq
X-Proofpoint-GUID: DD0Mt7VfwBavcKYETwu3upEfFxzKRptq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-26_11,2024-02-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 impostorscore=0 phishscore=0 mlxscore=0 mlxlogscore=996 adultscore=0
 priorityscore=1501 spamscore=0 bulkscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402260140



On 2/26/24 13:20, Stefan Berger wrote:
> This series deprecates the sign_hash function and introduces
> imaevm_signhash that requires the necessary parameters to be passed rather
> than relying on the global imaevm_params variable. This way we can remove
> the usage of imaevm_params for the OpenSSL engine and the keyid.
> 
> Add support for an OpenSSL provider. The choice of engine versus provider
> is implemented using a struct imaevm_ossl_access that wraps the engine or
> provider parameters. It also provides a type field where the user can
> choose one or the other. imaevm_signhash takes this structure as an optional
> parameter to support engines and providers.
> 
> Also extend existing test cases with tests with a pkcs11 provider.
> 
> Regards,
>     Stefan
> 
> v3:
>   - Added patch checking for engine support in evmctl before trying to run
>     pkcs11 test (1/7)
>   - Updated README with new --provider option (5/7)
>   - Added 2 more skip's to pkcs11 test in case neither engine nor provider
>     are supported (6/7)
Correction:
  - Added 2 more skip's to pkcs11 test in case softhsm is not installed
    (6/7)


