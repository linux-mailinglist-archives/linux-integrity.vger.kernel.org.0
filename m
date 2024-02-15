Return-Path: <linux-integrity+bounces-1231-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 619D1855A49
	for <lists+linux-integrity@lfdr.de>; Thu, 15 Feb 2024 07:13:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1383628C7A7
	for <lists+linux-integrity@lfdr.de>; Thu, 15 Feb 2024 06:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25EBB4A12;
	Thu, 15 Feb 2024 06:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="XYkXHuOo"
X-Original-To: linux-integrity@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF2473C17
	for <linux-integrity@vger.kernel.org>; Thu, 15 Feb 2024 06:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707977611; cv=none; b=kmKz0WXluEAPjl+romuv0mEJBnY27oln94bow5+uEGSUcxU5IBfcvC4MToODXf1qjOHMwQTvquOD4HnRIA5eOJ3kfcHyFagwrTb1Qv9Svtlc09gkN+5jZDhcPSv2J2t6C0jXF1ofYjv7nt63mvdmj0HfMfQNWDxj2BTF9BWp1Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707977611; c=relaxed/simple;
	bh=/knKuiTuk3RR/f29Du+MCM6o0maziyaOboGneP7mzM4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J6ns0sfDDX8jGnIeFivvHpXcNQ49ufSslpWZeH+nzzaUPfsxF/iMdIFH9QXoQQP4YKEEwVbrUAaj8/08V8bTa0xDTmsIcZAdAzivyT2YMHspcBmjSzWO1ZmBcJ6llpMYAXrTM6MEg0B2w8twygZJERVKdFrXRip59qOH1P5t2g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=XYkXHuOo; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [192.168.86.69] (unknown [50.46.228.62])
	by linux.microsoft.com (Postfix) with ESMTPSA id 19540207F228;
	Wed, 14 Feb 2024 22:13:29 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 19540207F228
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1707977609;
	bh=/knKuiTuk3RR/f29Du+MCM6o0maziyaOboGneP7mzM4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XYkXHuOoVyCjSfhDYJCiKZQw1T937HOdZb6+lcu6gCCuXAKgb/4CxGuy6n6JUwwCi
	 /XhbsdTl/f0fsjcp0lFwlrv+9inGMiQKeoCAyKigt6fl4y91HZkrgSBJBnivLwYS8Y
	 j+Pw4dS6Hb7HAEzYC24xHS60gvUWXWdoXkseM9iI=
Message-ID: <f5c4259d-977c-455e-95ee-1ed2c53f4c50@linux.microsoft.com>
Date: Wed, 14 Feb 2024 22:13:28 -0800
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/8] kexec: define functions to map and unmap segments
To: Stefan Berger <stefanb@linux.ibm.com>, zohar@linux.ibm.com,
 roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
 eric.snowberg@oracle.com, ebiederm@xmission.com, noodles@fb.com,
 bauermann@kolabnow.com, linux-integrity@vger.kernel.org,
 kexec@lists.infradead.org
Cc: code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com
References: <20240214153827.1087657-1-tusharsu@linux.microsoft.com>
 <20240214153827.1087657-3-tusharsu@linux.microsoft.com>
 <e5d6d47a-c9ee-47a1-aec8-aa59a5264884@linux.ibm.com>
Content-Language: en-US
From: Tushar Sugandhi <tusharsu@linux.microsoft.com>
In-Reply-To: <e5d6d47a-c9ee-47a1-aec8-aa59a5264884@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/14/24 11:43, Stefan Berger wrote:
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>

Thanks for the tag Stefan.

