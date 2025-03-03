Return-Path: <linux-integrity+bounces-5039-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01307A4B9FE
	for <lists+linux-integrity@lfdr.de>; Mon,  3 Mar 2025 09:56:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D3813AAB70
	for <lists+linux-integrity@lfdr.de>; Mon,  3 Mar 2025 08:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 151231E9B3E;
	Mon,  3 Mar 2025 08:54:09 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE7F1EEA57
	for <linux-integrity@vger.kernel.org>; Mon,  3 Mar 2025 08:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740992049; cv=none; b=mLn0azg5u3tiDrb3JVBBL/tNcsYK/EkkkxlShyHHj0BOYS8/VcXqBddZicsdyuWnXPx8Ux3KYLlZgqp+BMi3T/s4mgFzRoKtJltQlrjTDrxq9HWpzh5sbkpmpni6jgNsies0ASqQ+bXHEJm4ohKjtH78evW1H8ExZxslXWw+G38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740992049; c=relaxed/simple;
	bh=o709XhuaN45ocVeQ4ZFyMAG1kYLFR6vp4JWRfgbU/L0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eslKBuWkkZy4Y3aIYiNko0VAHleFszKxMkS9C8BrLlOOgh7rHDjwBFbjAug2mW7J6TEaB7yEyYOpbtckaoVIbRNahyIYkgYTsCSjyIXLB4c6dzxMy6a89pTWztX/MsBRXKUxKq4D7IGDqOKFHdTkHlFHL+zbamwhLzm7yWsirkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4Z5sTT6vRWz9v7J2
	for <linux-integrity@vger.kernel.org>; Mon,  3 Mar 2025 16:30:53 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 52BDB140418
	for <linux-integrity@vger.kernel.org>; Mon,  3 Mar 2025 16:53:52 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwBnHeAabsVnZX57Aw--.61492S2;
	Mon, 03 Mar 2025 09:53:51 +0100 (CET)
Message-ID: <904b5b9164912bed196527ed0f3913b0066dfcdb.camel@huaweicloud.com>
Subject: Re: [PATCH v2 0/2] ima: minimize open-writers and ToMToU violations
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc: roberto.sassu@huawei.com, Stefan Berger <stefanb@linux.ibm.com>, Petr
 Vorel <pvorel@suse.cz>
Date: Mon, 03 Mar 2025 09:53:42 +0100
In-Reply-To: <20250228205505.476845-1-zohar@linux.ibm.com>
References: <20250228205505.476845-1-zohar@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:GxC2BwBnHeAabsVnZX57Aw--.61492S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Ar17ArW8Xr13tF45Ww4DJwb_yoW8Ar15pF
	ZYgrZ8KFn3JryfCFn7C3WUAa1F9a18Ga47Xw4DZ348Zrn5XF10gFWSvF90q3s7WF9ayr12
	qw4xCasIy398AFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAQBGfFVNcBxAAAsy

On Fri, 2025-02-28 at 15:55 -0500, Mimi Zohar wrote:
> Each time a file in policy, that is already opened for write, is opened
> for read, an open-writers integrity violation audit message is emitted
> and a violation record is added to the IMA measurement list.
>=20
> Similarly each time a file in policy, that is already opened for read,
> is opened for write, a Time-of-Measure-Time-of-Use (ToMToU) integrity
> violation audit message is emitted and a violation record is added to
> the IMA measurement list.
>=20
> As there is no benefit in having multiple open-writers or ToMToU
> violations for the same file open in the audit log and IMA measurement
> list, minimize them.
>=20
> Minimizing open-writer violations results in a single open-writers
> violation being emitted until all writers are closed no matter the
> number of subsequent file open readers (or writers).
>=20
> Minimizing ToMToU violations results in a single ToMToU violation being
> emitted for all subsequent file open writers, until another in policy
> file open reader.
>=20
> Since the IMA_MUST_MEASURE atomic flag is only used for tracking ToMToU
> violations, rename the atomic flag to IMA_MAY_EMIT_TOMTOU.
>=20
> Define a new atomic flag named IMA_EMITTED_OPENWRITERS to minimize
> open-writer violations.

Thanks Mimi. For the whole series:

Reviewed-by: Roberto Sassu <roberto.sassu@huawei.com>

Roberto

> Mimi Zohar (2):
>   ima: limit the number of open-writers integrity violations
>   ima: limit the number of ToMToU integrity violations
>=20
>  security/integrity/ima/ima.h      |  3 ++-
>  security/integrity/ima/ima_main.c | 18 +++++++++++++-----
>  2 files changed, 15 insertions(+), 6 deletions(-)
>=20
> --
> 2.48.1
>=20


