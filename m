Return-Path: <linux-integrity+bounces-7903-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DA6A3CB3D66
	for <lists+linux-integrity@lfdr.de>; Wed, 10 Dec 2025 20:14:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B8A57302069C
	for <lists+linux-integrity@lfdr.de>; Wed, 10 Dec 2025 19:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9014032939C;
	Wed, 10 Dec 2025 19:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="nfiNsqT3"
X-Original-To: linux-integrity@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15DCC324B16;
	Wed, 10 Dec 2025 19:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765393980; cv=none; b=OdhA0rptbkYLjlKRmxSpv4Qox/CKTzig+wEr5MZzlzQAKrtmVLMQh5+F/FJ5jv46hXidiHEHp/jTrDqemR/NGHY2teLvxkhdFJ+ZOpcoaG9KVLnwgedLCSzrkIl/O4nMJEAzAWXuSlR0H0bm5zWnlaKzgFOApebCEfiWN28V4sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765393980; c=relaxed/simple;
	bh=HexfkWhZzhhRYY1RjQvP8wQVPapN+x9JfYJuzJfTAdE=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ZiCnSAX4UBiguHySnIluhuA8mLuL556vu3hMRBfNWtlu6Ftx4VXhgGamwNdwZVsJyCj/0zji9jCzcsIZ4GXRhJWZYvLppfSdgUluVGk/ig2hNd4PGLExXXrIcgvPMdKMg+tgWs2I5I2Svc25cCuE2akRDHu7/M8NWGt6johkegw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=nfiNsqT3; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1235)
	id 993EA201D812; Wed, 10 Dec 2025 11:12:58 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 993EA201D812
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1765393978;
	bh=HC899ISq4DPWbUn8v6X3rMIow4EEncJMpvDUWGw4LAo=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=nfiNsqT3K7gvwm728JoA9BoCSDr2+elniroNmesurzsjnzqBtHX5jS+UmSwKLH5U0
	 VfbaAjnpbYCI8wBWjn698JpZ0+XxZOQtHieH67QDr142M2LCL0CmOgC4JSJZktETvd
	 tyHx8D0NVcnB8vJoFk7B+MOa291u/Wr6FZlf8a9g=
Received: from localhost (localhost [127.0.0.1])
	by linux.microsoft.com (Postfix) with ESMTP id 95AAC3001A9D;
	Wed, 10 Dec 2025 11:12:58 -0800 (PST)
Date: Wed, 10 Dec 2025 11:12:58 -0800 (PST)
From: Gregory Lumen <gregorylumen@linux.microsoft.com>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
cc: corbet@lwn.net, zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, 
    eric.snowberg@oracle.com, paul@paul-moore.com, jmorris@namei.org, 
    serge@hallyn.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
    linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, 
    chenste@linux.microsoft.com, nramas@linux.microsoft.com, 
    Roberto Sassu <roberto.sassu@huawei.com>
Subject: Re: [RFC][PATCH] ima: Add support for staging measurements for
 deletion
In-Reply-To: <20251209101725.3680225-1-roberto.sassu@huaweicloud.com>
Message-ID: <207fd6d7-53c-57bb-36d8-13a0902052d1@linux.microsoft.com>
References: <20251209101725.3680225-1-roberto.sassu@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

Roberto,

The proposed approach appears to be workable. However, if our primary goal 
here is to enable UM to free kernel memory consumed by the IMA log with an 
absolute minimum of kernel functionality/change, then I would argue that 
the proposed Stage-then-delete approach still represents unnecessary 
complexity when compared to a trim-to-N solution. Specifically:

- Any functional benefit offered through the introduction of a staged 
measurement list could be equally achieved in UM with a trim-to-N solution 
coupled with the proposed ima_measure_users counter for access locking.

- There exists a potential UM measurement-loss race condition introduced 
by the staging functionality that would not exist with a trim-to-N 
approach. (Occurs if a kexec call occurs after a UM agent has staged 
measurements for deletion, but has not completed copying them to 
userspace). This could be avoided by persisting staged measurements across 
kexec calls at the cost of making the proposed change larger.

Thanks,
-Gregory Lumen


