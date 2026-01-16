Return-Path: <linux-integrity+bounces-8266-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A527D30DB8
	for <lists+linux-integrity@lfdr.de>; Fri, 16 Jan 2026 13:07:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 670AB3040663
	for <lists+linux-integrity@lfdr.de>; Fri, 16 Jan 2026 12:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA4483612DF;
	Fri, 16 Jan 2026 12:06:55 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F233417A2EA;
	Fri, 16 Jan 2026 12:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768565215; cv=none; b=hj5+gJIGrT+CDfxRM9VTzAtZmSH7jRWvd36GUowcA4Yrj++n7PwUxF2q33pdaetmGERsY3NDpTkMC/02wXgTpyASHFKnFy1Q7mOJF5cq45q7MC9eh/Ey42ObvhDKddqBf5JguR7x3b3BKBEk5voFJVZ+uj6lI+HCxv+Uwul7CDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768565215; c=relaxed/simple;
	bh=dRRHwHf4tT+A5NDTYZEKQicdR7ZrrQw82cF/YhQ3ec8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NiuNnMolTWnI6VQGY3/1fvpWWcHYpooOMS9jkiFCQ0MlmzoUboe8aZmb+NlWFTETOnAM476k7j9X92FUu6sBcWS2ecWowiefC6qNiD0UaUJpNLux+OgJOZxhF4hguSNuErSUfC5Dvcf8w6DfEOqQ9/dAbO+OBu2whHgIGeoMP2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.224.235])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTPS id 4dsz6Y0lGDzpThJ;
	Fri, 16 Jan 2026 20:04:21 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 101654056C;
	Fri, 16 Jan 2026 20:06:44 +0800 (CST)
Received: from [10.204.63.22] (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwB3sgTKKWpptNEPAg--.18910S2;
	Fri, 16 Jan 2026 13:06:43 +0100 (CET)
Message-ID: <f38b2512d51351f83c51b6e2b5dec11eb7e6959d.camel@huaweicloud.com>
Subject: Re: [PATCH 2/3] evm: Don't enable fix mode when secure boot is
 enabled
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Mimi Zohar <zohar@linux.ibm.com>, Coiby Xu <coxu@redhat.com>, 
	linux-integrity@vger.kernel.org
Cc: Heiko Carstens <hca@linux.ibm.com>, Roberto Sassu
 <roberto.sassu@huawei.com>,  Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
 Eric Snowberg <eric.snowberg@oracle.com>, Paul Moore <paul@paul-moore.com>,
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
 "open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
Date: Fri, 16 Jan 2026 13:06:32 +0100
In-Reply-To: <522f60ac43b8757c0d7df5df0239190e49f577a8.camel@linux.ibm.com>
References: <20260115004328.194142-1-coxu@redhat.com>
	 <20260115004328.194142-3-coxu@redhat.com>
	 <522f60ac43b8757c0d7df5df0239190e49f577a8.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:LxC2BwB3sgTKKWpptNEPAg--.18910S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYs7kC6x804xWl14x267AKxVW8JVW5JwAF
	c2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII
	0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xv
	wVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Jr0_Gr1l84ACjc
	xK6I8E87Iv6xkF7I0E14v26r4j6r4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40E
	FcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr
	0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY
	04v7MxAIw28IcxkI7VAKI48JMxAqzxv26xkF7I0En4kS14v26r1q6r43MxC20s026xCaFV
	Cjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWl
	x4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r
	1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_
	JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcS
	sGvfC2KfnxnUUI43ZEXa7IU1zuWJUUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAPBGlprpsK9QAAsD

On Thu, 2026-01-15 at 13:15 -0500, Mimi Zohar wrote:
> On Thu, 2026-01-15 at 08:43 +0800, Coiby Xu wrote:
> > Similar to IMA fix mode, forbid EVM fix mode when secure boot is
> > enabled.
> >=20
> > Reported-and-suggested-by: Mimi Zohar <zohar@linux.ibm.com>
> > Suggested-by: Roberto Sassu <roberto.sassu@huaweicloud.com>

Ah, if possible, could you please change the email to
roberto.sassu@huawei.com?

Thanks

Roberto

> > Signed-off-by: Coiby Xu <coxu@redhat.com>
>=20
> Thanks, Coiby!
>=20
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>


