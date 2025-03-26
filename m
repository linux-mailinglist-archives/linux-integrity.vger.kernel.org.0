Return-Path: <linux-integrity+bounces-5436-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDC9CA71489
	for <lists+linux-integrity@lfdr.de>; Wed, 26 Mar 2025 11:15:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53FC017084B
	for <lists+linux-integrity@lfdr.de>; Wed, 26 Mar 2025 10:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E0BF1A0BCA;
	Wed, 26 Mar 2025 10:15:01 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8FE36124;
	Wed, 26 Mar 2025 10:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742984101; cv=none; b=Zi3PLL8Sg+uhDy6HVXCS9SM9IFmVCPeoH7Lv7LxpVBn9DIDTYw89WmEq57g3fMhRvGA1iWWP2hEPZ1WNIHOrMYtMgMgsUM5bx9EGCo7W1kr7fruYfKaIO+UDLcxP74SziFJ7l261suss0N60IlGsTJddTCsPhR4so2dZdW+155w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742984101; c=relaxed/simple;
	bh=kXaKKpHXSslrbwHTWT5CPLZBU7qrIImltiwwUCWX1DA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W/UkQJ0uZ3JkxL4jXzZA8JI/aTaBsxdo3T4VhvmheYBI1IyfuInfcEfL20fWWsGHiRQsSYMYFqHOdHQtUPX4epF3+CywAXfBmdoNmN9w6J139rpG5sRfvtx3v0UHSctnkoFMHb4bdx6wibMEcBpzlbxDrlwQ3n2hgAmdZw9P7rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTPS id 4ZN2Gy10QbzsRwR;
	Wed, 26 Mar 2025 17:55:54 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 7FC691400DD;
	Wed, 26 Mar 2025 17:56:14 +0800 (CST)
Received: from [10.221.98.126] (unknown [10.221.98.126])
	by APP1 (Coremail) with SMTP id LxC2BwDna0o1z+NnTirkBA--.50162S2;
	Wed, 26 Mar 2025 10:56:14 +0100 (CET)
Message-ID: <b39bc11b-11d6-4847-9afd-0e8ead173af8@huaweicloud.com>
Date: Wed, 26 Mar 2025 10:56:02 +0100
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ima: process_measurement() needlessly takes inode_lock()
 on MAY_READ
To: Frederick Lawler <fred@cloudflare.com>, Mimi Zohar <zohar@linux.ibm.com>,
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
 Roberto Sassu <roberto.sassu@huawei.com>
Cc: Eric Snowberg <eric.snowberg@oracle.com>,
 "Serge E. Hallyn" <serge@hallyn.com>, linux-ima-devel@lists.sourceforge.net,
 linux-integrity@vger.kernel.org, linux-ima-user@lists.sourceforge.net,
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-team@cloudfalre.com
References: <20250325181616.79540-2-fred@cloudflare.com>
 <Z-LzWCbROAI2H2Dx@CMGLRV3>
Content-Language: en-US
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
In-Reply-To: <Z-LzWCbROAI2H2Dx@CMGLRV3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:LxC2BwDna0o1z+NnTirkBA--.50162S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYs7kC6x804xWl14x267AKxVW8JVW5JwAF
	c2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII
	0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xv
	wVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjc
	xK6I8E87Iv6xkF7I0E14v26r4j6r4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40E
	FcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr
	0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY
	04v7MxAIw28IcxkI7VAKI48JMxAqzxv26xkF7I0En4kS14v26r1q6r43MxC20s026xCaFV
	Cjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWl
	x4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r
	1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_
	JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcS
	sGvfC2KfnxnUUI43ZEXa7IU1zuWJUUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgATBGfjp1oCQgAAss

On 3/25/2025 7:18 PM, Frederick Lawler wrote:
> My mistake, this is PATCH v2. I forgot to change the subject in git
> send-email. I can resend if that's needed.

No problem. However, let's change:

mask & MAY_WRITE

with

file->f_mode & FMODE_WRITE

Thanks

Roberto


