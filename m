Return-Path: <linux-integrity+bounces-3652-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C72397DD41
	for <lists+linux-integrity@lfdr.de>; Sat, 21 Sep 2024 14:37:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 637161F21B5C
	for <lists+linux-integrity@lfdr.de>; Sat, 21 Sep 2024 12:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C6E1605BA;
	Sat, 21 Sep 2024 12:37:32 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A007238DE1;
	Sat, 21 Sep 2024 12:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726922252; cv=none; b=oJIOQR9OL3hQBDrUjigmDUr+WulIXO6kPs5G0l429Qp51G8cN4QJ6BKW6+mKu0Mgk6EBBA3ibID/vKAqfbmXHQMAFsSo7bLsFEl/6aRxkaBnnLdRkH6TrZbFwJHbd0zPBinHvkzoO9nFA/vFcHQHdvNbueloCXhv14AQeWb/pmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726922252; c=relaxed/simple;
	bh=2amqPYcUihSipIQL5OIHzynIAtbxt3aDa1E1bTMvrgI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=duca2aDUn7ezVVNVmeBzeEcnZZ4wM4xK2ETjs8quNSQ8bmekUheyTCtH5+lREL4qHoop9Qum+enEfjsOJlVho1sMSJyo78YBCP3ikgz9fa8Gr3KFGdydb34mS4m4jlYhNV292Zhg4SWtbg/IyR0tlkWnarlQwPovMqq0gLDt5Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.53] (ip5f5aef34.dynamic.kabel-deutschland.de [95.90.239.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 9175C61E5FE05;
	Sat, 21 Sep 2024 14:36:23 +0200 (CEST)
Message-ID: <f9bbc8a7-4292-47a1-8987-b931284a7738@molgen.mpg.de>
Date: Sat, 21 Sep 2024 14:36:21 +0200
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/5] Lazy flush for the auth session
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-integrity@vger.kernel.org, James.Bottomley@HansenPartnership.com,
 roberto.sassu@huawei.com, mapengyu@gmail.com,
 Mimi Zohar <zohar@linux.ibm.com>, David Howells <dhowells@redhat.com>,
 Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
 "Serge E. Hallyn" <serge@hallyn.com>, Peter Huewe <peterhuewe@gmx.de>,
 Jason Gunthorpe <jgg@ziepe.ca>, keyrings@vger.kernel.org,
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240921120811.1264985-1-jarkko@kernel.org>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20240921120811.1264985-1-jarkko@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Jarkko,


Thank you for working on this and your patches.

Am 21.09.24 um 14:08 schrieb Jarkko Sakkinen:
> This patch set aims to fix:
> https://bugzilla.kernel.org/show_bug.cgi?id=219229.

If I am not mistaken this is about reducing the boot time, right? It’d 
be great if you documented the numbers in the commit messages.


Kind regards,

Paul

