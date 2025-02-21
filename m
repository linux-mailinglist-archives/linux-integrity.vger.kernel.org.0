Return-Path: <linux-integrity+bounces-4964-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4594AA3FC46
	for <lists+linux-integrity@lfdr.de>; Fri, 21 Feb 2025 17:55:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD47B704F7C
	for <lists+linux-integrity@lfdr.de>; Fri, 21 Feb 2025 16:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A3B51B85FD;
	Fri, 21 Feb 2025 16:49:59 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0F31F0E53
	for <linux-integrity@vger.kernel.org>; Fri, 21 Feb 2025 16:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740156599; cv=none; b=bpdfKg5Cv1qPIJKY57G8OH4iDSrQn0Cj8ResPBCBUe5cvdHrEiFVY4ZrtfIFwtHUnTH9DQWpe3BXq4DGwp4iljIM0nw/SDt+7LXVPDzPRVdy1hZrdC7JCJ5Yac6f08FNgJ4p1lKhfvl7XgdFlHa3XCJo7WfMtucIYx8kun2Gp8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740156599; c=relaxed/simple;
	bh=biw6h+c3C9O2FKiv2LAaZtn+0hip/xIuf2pHzowKGAI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=e2oNnqWuZ/3laMIH9onbB6Dt9C5um/YgFUJsnbuoKhdxmQc2AdrAvBJl5S29FNflx+7FChFOvQICVCROnAE0ri+OelCdq8JsfWyjXrotabjO1hK/TzYqVp1WHxZD2t87uFarw7EiSkOPgySPMAdVkqvlk1ZUqG0KSaLlK7SflqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4YzwMD30Z0z9v7JP
	for <linux-integrity@vger.kernel.org>; Sat, 22 Feb 2025 00:19:52 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 949D3140445
	for <linux-integrity@vger.kernel.org>; Sat, 22 Feb 2025 00:49:42 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwDHS0qgrrhnvyHrAg--.13931S2;
	Fri, 21 Feb 2025 17:49:42 +0100 (CET)
Message-ID: <fd88dbfd8f066a51f21014b3de24737093f5911f.camel@huaweicloud.com>
Subject: Re: [PATCH 0/2] ima: limit both open-writers and ToMToU violations
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc: roberto.sassu@huawei.com, Stefan Berger <stefanb@linux.ibm.com>, Petr
 Vorel <pvorel@suse.cz>
Date: Fri, 21 Feb 2025 17:49:33 +0100
In-Reply-To: <20250219162131.416719-1-zohar@linux.ibm.com>
References: <20250219162131.416719-1-zohar@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:LxC2BwDHS0qgrrhnvyHrAg--.13931S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Cw1xXr1xKFy5Zw1DKry8Zrb_yoW8Wry5pF
	ZYgr4fK3Z3JFySkFnruw13Za1Fvw1xGFyDXr1DCryDZwn5Xr10qr9Iv3WYq34xWFZayw17
	Xr4IyanI9398ZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUymb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vI
	r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E
	14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jjVbkUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAGBGe4JdgF8wABsW

On Wed, 2025-02-19 at 11:21 -0500, Mimi Zohar wrote:

Hi Mimi

> Each time a file in policy, that is already opened for write, is opened
> for read an open-writers integrity violation audit message is emitted

I would put a comma after 'for read' and remove the previous ones.

> and a violation record is added to the IMA measurement list, even if an

I would stop the sentence before 'even' and start a new sentence.

IMA does not track previous violations, and emits a new one of the same
kind, even if there was one before, resulting in redundant information
being produced.

The information might not be redundant though, if process-based
credentials are added to the measurement list. In that case, more
information about the process causing the violation would be shown.

> open-writers violation has already been recorded.
>=20
> Similalry each time a file in policy, that is already opened for read,

Typo.

> is opened for write a Time-of-Measure-Time-of-Use (ToMToU) integrity
> violation audit message is emitted and a violation record is added to
> the IMA measurement list, even if a ToMToU violation has already been
> recorded.
>=20
> Minimize the violations in the audit log and the IMA measurement list.

I would describe more precisely how you are trying to minimize them.

Thanks

Roberto

> Mimi Zohar (2):
>   ima: limit the number of open-writers integrity violations
>   ima: limit the number of ToMToU integrity violations
>=20
>  security/integrity/ima/ima.h      |  1 +
>  security/integrity/ima/ima_main.c | 16 ++++++++++++----
>  2 files changed, 13 insertions(+), 4 deletions(-)
>=20
> --
> 2.48.1
>=20


