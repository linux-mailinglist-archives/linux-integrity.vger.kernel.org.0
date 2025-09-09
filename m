Return-Path: <linux-integrity+bounces-7040-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 155D8B4A426
	for <lists+linux-integrity@lfdr.de>; Tue,  9 Sep 2025 09:48:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01C8F1882168
	for <lists+linux-integrity@lfdr.de>; Tue,  9 Sep 2025 07:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A598B22172D;
	Tue,  9 Sep 2025 07:48:12 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16CD71D5CE8;
	Tue,  9 Sep 2025 07:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757404092; cv=none; b=amfjUoGyjxIyXvo47152pwr7DSZJAvCbLC1XAD9zYR0YG3hu+29nZoinzeqywJpzvQQZpbYRIs8mXABAW1/Os/zFdZWPIkcV09/WOxd5Y7LmvmfrdArOXy6i52VWP+wpordp8vKasO/lQhVtyokqYACjeHBylTvPQWcLFQyprpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757404092; c=relaxed/simple;
	bh=c5iAKbXkqPtpHNGYxMaTOQYt1Gf9eA8cH13MWswLUdM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GoWqCrfdnjzW5vJvwYDuCiUVQg88qkLA6by6XZpm1beZ8+IXMt27Nso5xgw9zlcmjagIKeV1H7P7KPvTYXXjgVuNYIHUGxJurcyAqWeXRTlJIlqYRFBFVwZr5AAswg9PKRQbvddKFxMIDXSwmc6oKnGKfNAJtxX00sl3lw8XB/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cLbVH1wg2zsjt1;
	Tue,  9 Sep 2025 15:46:15 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 38F341402FA;
	Tue,  9 Sep 2025 15:48:01 +0800 (CST)
Received: from [10.204.63.22] (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwBXrUKn279olzIGAQ--.52053S2;
	Tue, 09 Sep 2025 08:48:00 +0100 (CET)
Message-ID: <db0b620e1eac353190927c45a2adbc13f35722b9.camel@huaweicloud.com>
Subject: Re: [PATCH] ima,evm: move initcalls to the LSM framework
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Paul Moore <paul@paul-moore.com>, roberto.sassu@huawei.com
Cc: Mimi Zohar <zohar@linux.ibm.com>, linux-security-module@vger.kernel.org,
  linux-integrity@vger.kernel.org, selinux@vger.kernel.org, 
 john.johansen@canonical.com, wufan@kernel.org, mic@digikod.net,
 kees@kernel.org,  mortonm@chromium.org, casey@schaufler-ca.com,
 penguin-kernel@i-love.sakura.ne.jp,  nicolas.bouchinet@oss.cyber.gouv.fr,
 xiujianfeng@huawei.com
Date: Tue, 09 Sep 2025 09:47:47 +0200
In-Reply-To: <CAHC9VhRWt54V3nvRDpN_=gb5Fc68KznwDd7xhNmyGJw5+TQ5Dw@mail.gmail.com>
References: <9f35539de7188c6b853c55b76958a286131f5928.camel@huaweicloud.com>
	 <20250902125457.2689519-1-roberto.sassu@huaweicloud.com>
	 <82f22f97486622408bec772a9b025e301c8fa2f4.camel@linux.ibm.com>
	 <CAHC9VhTGAcMTXHReinybpLzer7seCN+NUTHcFte+aU2oRNtNNg@mail.gmail.com>
	 <0cccd05c0005d3b9e85ab92e35363cc69ea6a3f2.camel@linux.ibm.com>
	 <CAHC9VhRWt54V3nvRDpN_=gb5Fc68KznwDd7xhNmyGJw5+TQ5Dw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:GxC2BwBXrUKn279olzIGAQ--.52053S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Zr43Xw18uF1fXrW5Zw13Jwb_yoW8CFW5pF
	W7tayUKr4qvr4aywn2v3W5Ar4Yk3s3XFy5Xrn8t34UA3sI9rnrXr1xCFy5CFyDGr4fJ343
	ZF18Z343A3WDAa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUF1
	v3UUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAGBGi-z8EAnQAAsH

On Mon, 2025-09-08 at 17:04 -0400, Paul Moore wrote:
> On Sun, Sep 7, 2025 at 10:46=E2=80=AFPM Mimi Zohar <zohar@linux.ibm.com> =
wrote:
> > On Sun, 2025-09-07 at 21:08 -0400, Paul Moore wrote:
> > > On Sun, Sep 7, 2025 at 5:18=E2=80=AFPM Mimi Zohar <zohar@linux.ibm.co=
m> wrote:
> > > > On Tue, 2025-09-02 at 14:54 +0200, Roberto Sassu wrote:
> > > > > From: Paul Moore <paul@paul-moore.com>
> > > >=20
> > > > Remove above ...
> > > >=20
> > > > >=20
> > > > > This patch converts IMA and EVM to use the LSM frameworks's initc=
all
> > > > > mechanism. It moved the integrity_fs_init() call to ima_fs_init()=
 and
> > > > > evm_init_secfs(), to work around the fact that there is no "integ=
rity" LSM,
> > > > > and introduced integrity_fs_fini() to remove the integrity direct=
ory, if
> > > > > empty. Both integrity_fs_init() and integrity_fs_fini() support t=
he
> > > > > scenario of being called by both the IMA and EVM LSMs.
> > > > >=20
> > > > > It is worth mentioning that this patch does not touch any of the
> > > > > "platform certs" code that lives in the security/integrity/platfo=
rm_certs
> > > > > directory as the IMA/EVM maintainers have assured me that this co=
de is
> > > > > unrelated to IMA/EVM, despite the location, and will be moved to =
a more
> > > >=20
> > > > This wording "unrelated to IMA/EVM" was taken from Paul's patch des=
cription, but
> > > > needs to be tweaked.  Please refer to my comment on Paul's patch.
> > >=20
> > > Minim, Roberto, would both of you be okay if I changed the second
> > > paragraph to read as follows:
> > >=20
> > > "This patch does not touch any of the platform certificate code that
> > > lives under the security/integrity/platform_certs directory as the
> > > IMA/EVM developers would prefer to address that in a future patchset.=
"
> >=20
> > That's fine.
>=20
> Roberto, is it okay if I update your patch with the text above and use
> it to replace my IMA/EVM patch in the LSM init patchset?  I'll retain
> your From/Sign-off of course.

Yes, absolutely!

Roberto


