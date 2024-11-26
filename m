Return-Path: <linux-integrity+bounces-4209-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F6529D9BEF
	for <lists+linux-integrity@lfdr.de>; Tue, 26 Nov 2024 17:58:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0194B277FB
	for <lists+linux-integrity@lfdr.de>; Tue, 26 Nov 2024 16:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17CD81DA0F1;
	Tue, 26 Nov 2024 16:39:40 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162D61D8E18;
	Tue, 26 Nov 2024 16:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732639180; cv=none; b=LFv1YWVS+tvXMNq9WLybKfl/3sxvtEhm4kY/+7QeSZCuUNbL9X2ggXMI9yEql0UY3/NdyImm4E5X5YzeO7awg/szz4MQJ82P0S8HbFlyIiz40I9U0eHzPEO515sr4Q72+4LU6QSEmn5pqK1qrcbf+VoybOFHaKUr/l1ihdX5Lmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732639180; c=relaxed/simple;
	bh=Z4XD5OrWzqAVBLdYcAAAXahUtN+dCsjkstxAk7mQ8y4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JW/HBhIKyel3MAWER0+gMANFxaJ3aVjDOcIh2/IOyv4NVayOKEUQEajeOO5SlMQVBhRPqtxi3JsxVThlrLagT05u44aBRzSPrYyCWyTkvzgKIus8QzRveVxUqCloUXYuXG50NYB8ugSldVmIX5yLN6uy9XhGquVf4eemAOWah7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4XySJM2cfMz9v7JM;
	Wed, 27 Nov 2024 00:12:03 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 5157A140544;
	Wed, 27 Nov 2024 00:39:18 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwBnzHut+UVnf0VZAg--.24971S2;
	Tue, 26 Nov 2024 17:39:17 +0100 (CET)
Message-ID: <86863031e74c46e9982fee38706a4d17b5c536dd.camel@huaweicloud.com>
Subject: Re: ima: property parameter unused in ima_match_rules()
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Paul Moore <paul@paul-moore.com>, Casey Schaufler
 <casey@schaufler-ca.com>,  Mimi Zohar <zohar@linux.ibm.com>
Cc: Christian =?ISO-8859-1?Q?G=F6ttsche?= <cgzones@googlemail.com>, 
 linux-integrity@vger.kernel.org, "M: Roberto Sassu"
 <roberto.sassu@huawei.com>,  "M: Dmitry Kasatkin"
 <dmitry.kasatkin@gmail.com>, "R: Eric Snowberg" <eric.snowberg@oracle.com>,
 LSM List <linux-security-module@vger.kernel.org>
Date: Tue, 26 Nov 2024 17:39:05 +0100
In-Reply-To: <CAHC9VhS7KRcpA7cHcwpKknYsC7iZiBjZGVz1xznC=d=uDYu7EQ@mail.gmail.com>
References: 
	<CAJ2a_DeUX9UdAYOo9OwG-yXSH1etKQZortPcyxfzG70K3N+g7g@mail.gmail.com>
	 <92e5fd64-8c75-4e82-981a-846364fc7a38@schaufler-ca.com>
	 <91a227f3b57374a8aece5480f285c433d3888572.camel@huaweicloud.com>
	 <CAHC9VhS7KRcpA7cHcwpKknYsC7iZiBjZGVz1xznC=d=uDYu7EQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:GxC2BwBnzHut+UVnf0VZAg--.24971S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ArWkJr17ArWDCFy5JrWfuFg_yoW8XF48pF
	Wrta1jya1vvr1IkF1Svr4xu3y8KrZ3Wr17X3WkWryUZF92gFyI9r1fKFWa934DWFn7CFya
	yaya9ryaywnrCaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyCb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07UAwIDUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgATBGdFMnMG7gAAse

On Tue, 2024-11-26 at 10:57 -0500, Paul Moore wrote:
> On Tue, Nov 26, 2024 at 2:50=E2=80=AFAM Roberto Sassu
> <roberto.sassu@huaweicloud.com> wrote:
> >=20
> > On Mon, 2024-11-25 at 10:23 -0800, Casey Schaufler wrote:
> > > On 11/25/2024 3:38 AM, Christian G=C3=B6ttsche wrote:
> > > > Hi,
> > > >=20
> > > > I noticed that the `prop` parameter of `ima_match_rules()` is
> > > > currently unused (due to shadowing).
> > > > Is that by design or a mishap of the recent rework?
> > > >=20
> > > > Related commits:
> > > >=20
> > > > 37f670a ("lsm: use lsm_prop in security_current_getsecid")
> > > > 870b7fd ("lsm: use lsm_prop in security_audit_rule_match")
> > > > 07f9d2c ("lsm: use lsm_prop in security_inode_getsecid")
> > >=20
> > > The shadowing was inadvertent. The use of lsm_prop data is
> > > corrected by this patch.
> >=20
> > Thanks Casey. Yes, this is what I had in mind.
>=20
> Looks good to me too.  Casey can you resend the patch with the proper
> sign-off, commit description, etc.?  Roberto, can we convert your
> comment above into an ACK?

Yes:

Suggested-by: Roberto Sassu <roberto.sassu@huawei.com>
Reviewed-by: Roberto Sassu <roberto.sassu@huawei.com>
Acked-by: Roberto Sassu <roberto.sassu@huawei.com>

> Lastly, Mimi and Roberto, would you like me to take this fix up to
> Linus via the LSM tree, or would you prefer to take it via IMA?
> Either way is fine with me as long as we get it fixed :)

It is fine if you take in your tree.

May I also ask to double check for the patches in your PRs that we are
aware and me or Mimi acked our parts?

Thanks!

Roberto


