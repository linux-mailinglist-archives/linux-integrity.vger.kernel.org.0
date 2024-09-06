Return-Path: <linux-integrity+bounces-3484-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84F3196F2E8
	for <lists+linux-integrity@lfdr.de>; Fri,  6 Sep 2024 13:23:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F198FB219D5
	for <lists+linux-integrity@lfdr.de>; Fri,  6 Sep 2024 11:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72ABA1CB314;
	Fri,  6 Sep 2024 11:23:04 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6DA1CB153;
	Fri,  6 Sep 2024 11:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725621784; cv=none; b=RS8bAxFvFQglMHIRS1cGBNehrUU5om2qkaL65vxswNk0kU/Qo1YtHmZuuiVPJtSp0NjjuqJi3DkVoPFHnhZl0HBXfdOxV4KwtlFjEvTpzOeONnfUpyxIhGTGh5y+4XKTIQ0uNVPFV2koNTB5BPfAA1UAmxkg3wk/IS4ewqMdEjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725621784; c=relaxed/simple;
	bh=Ru0PkiTN7l9B0N5k+rZTGxobkc7vUO2bGiE/8PtUr+w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=O5DDbO8C6Z9kh+rJvGfU5YCPdRzpn3bxKCIqUdWcrl/jTQKJf0crNlM2iWmkJQPFXUgjcbykJJRS08pGvZZwnecdNmLuPo29ZFJL6iOvNhCJbU1QlEEUM+agvYR2vPP1QRk/6iyxIJr516nXT+YNdylbV7w2oK0TCKG12PLT78Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4X0Y9F2kptz9v7JT;
	Fri,  6 Sep 2024 18:57:53 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 2AED9140485;
	Fri,  6 Sep 2024 19:22:46 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwAHmC_05dpmZj9iAA--.22221S2;
	Fri, 06 Sep 2024 12:22:45 +0100 (CET)
Message-ID: <81fd98ce8a43c209e909144a13dcdbf3239e15ff.camel@huaweicloud.com>
Subject: Re: [RFC][PATCH v3 01/10] ima: Introduce hook DIGEST_LIST_CHECK
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Jarkko Sakkinen <jarkko@kernel.org>, corbet@lwn.net,
 zohar@linux.ibm.com,  dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com,
 paul@paul-moore.com,  jmorris@namei.org, serge@hallyn.com
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, 
 wufan@linux.microsoft.com, pbrobinson@gmail.com, zbyszek@in.waw.pl,
 hch@lst.de,  mjg59@srcf.ucam.org, pmatilai@redhat.com, jannh@google.com,
 dhowells@redhat.com,  jikos@kernel.org, mkoutny@suse.com, ppavlu@suse.com,
 petr.vorel@gmail.com,  mzerqung@0pointer.de, kgold@linux.ibm.com, Roberto
 Sassu <roberto.sassu@huawei.com>
Date: Fri, 06 Sep 2024 13:22:24 +0200
In-Reply-To: <D3Z3PDARWOV4.1CBB4U4NW846J@kernel.org>
References: <20240905152512.3781098-1-roberto.sassu@huaweicloud.com>
	 <20240905152512.3781098-2-roberto.sassu@huaweicloud.com>
	 <D3Z3PDARWOV4.1CBB4U4NW846J@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:LxC2BwAHmC_05dpmZj9iAA--.22221S2
X-Coremail-Antispam: 1UD129KBjvJXoW7WF4xKry5ZryfXrWDWFy8Zrb_yoW8Gr15pF
	W5t3WfCFsYqryxKFZI93Wjqay0k39Yg3W5Ww1ktw15ArZ8Zr10v3W8tFWq9a17Gr1kt3W7
	Ars0qryUAw4DAr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWr
	XwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0
	4xRDUUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQASBGbaZPMG4wADsa

On Fri, 2024-09-06 at 12:41 +0300, Jarkko Sakkinen wrote:
> On Thu Sep 5, 2024 at 6:25 PM EEST, Roberto Sassu wrote:
> > From: Roberto Sassu <roberto.sassu@huawei.com>
> >=20
> > Introduce a new hook to check the integrity of digest lists.
>=20
> "Introduce DIGEST_LIST_CHECK, a new hook..."
>=20
> >=20
> > The new hook is invoked during a kernel read with file type
>=20
> "with the file type"
>=20
>=20
> > READING_DIGEST LIST, which is done by the Integrity Digest Cache when i=
t is
> > populating a digest cache with a digest list.
>=20
> The patch creates a new struct imap_rule_entry instance when it parses
> the corresponding rule, which means that there are couple slices of
> information missing here:
>=20
> 1. The commit message does not tell what the code change effectively
>    is. I scavenged this information from [1].

Sorry, to me it seems a bit redundant to state what a IMA hook is. The
new hook will be handled by IMA like the other existing hooks.

> 2. The commit message does no effort to connect the dots between the
>    effective change and the expected goal.

Sure, will mention the goal better.

Thanks

Roberto

> I'd put a lot of effort to this commit message assuming that the new
> hook is at the center of the goals of this patch set.
>=20
> [1] https://elixir.bootlin.com/linux/v6.10-rc4/source/security/integrity/=
ima/ima_policy.c#L1404
>=20
> BR, Jarkko


