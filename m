Return-Path: <linux-integrity+bounces-3357-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CA24956E2F
	for <lists+linux-integrity@lfdr.de>; Mon, 19 Aug 2024 17:06:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9080D1C21B5C
	for <lists+linux-integrity@lfdr.de>; Mon, 19 Aug 2024 15:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86FD117554A;
	Mon, 19 Aug 2024 15:06:27 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654DD173355;
	Mon, 19 Aug 2024 15:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724079987; cv=none; b=FHGbmaecBBdChnyz0ZQArJbW5EimtNOf+5lt1+c0IKBysR6gYdr+pFOXK218xk6FRn5m3nUZxCmV2OhOoBVjo75vY2R3EsoUtSbpfn6S+TYzfRNhbWSZ/B9Fd0QTZ7WLQ92EWfFt7Q9b/F+sagAfok13IONa/EimrD6Yeravfjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724079987; c=relaxed/simple;
	bh=QqQN6vdDoD0EVNRgBKtEFsy5SW4OFAJC0HHjmLgckws=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=I3FF3MDjJIjLpzd6SA60kkotkDnY07xZZAF4mfIj0TSCpw3yoOPc9rKNGt6xNoIv7qzUuUE3Qgt2QbmBYnuiVDr7iWvm2giaXyTmvTrXaGX9VNteNtKsRDktTUyHZ4/mmX+XiAF23us+rP09uKVBUZ0j79Y2O3lko1CBoeNY1Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4Wnb6D5j4bz9v7Hk;
	Mon, 19 Aug 2024 22:47:16 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 1E030140154;
	Mon, 19 Aug 2024 23:06:18 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwCXtMFhX8NmEe+DAQ--.19969S2;
	Mon, 19 Aug 2024 16:06:17 +0100 (CET)
Message-ID: <0fc755a5ee1d6d7dd5c5a8d2d4e119905ab44f45.camel@huaweicloud.com>
Subject: Re: [PATCH v2 04/14] PGPLIB: Basic packet parser
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Jeff Johnson <quic_jjohnson@quicinc.com>, dhowells@redhat.com, 
	dwmw2@infradead.org, herbert@gondor.apana.org.au, davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, keyrings@vger.kernel.org, 
	linux-crypto@vger.kernel.org, zohar@linux.ibm.com, 
	linux-integrity@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>
Date: Mon, 19 Aug 2024 17:06:05 +0200
In-Reply-To: <fafa64ff-63ee-4af1-b669-939dc1933012@quicinc.com>
References: <20240818165756.629203-1-roberto.sassu@huaweicloud.com>
	 <20240818165756.629203-5-roberto.sassu@huaweicloud.com>
	 <fafa64ff-63ee-4af1-b669-939dc1933012@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:GxC2BwCXtMFhX8NmEe+DAQ--.19969S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ZF47WryDXw17CF4xGr4xCrg_yoW8GrW7pa
	40k3WUAFs5Jry8Ca97J3W3KF17C34xCrW5J34Fvr1UC3sIvF1kuay29r90gasrGa1DKw1a
	yFWkXw1aqF1YqaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUF1
	v3UUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAABGbCqfEHPwAAsB

On Mon, 2024-08-19 at 07:34 -0700, Jeff Johnson wrote:
> On 8/18/24 09:57, Roberto Sassu wrote:
> ...
> > diff --git a/crypto/asymmetric_keys/pgp_library.c b/crypto/asymmetric_k=
eys/pgp_library.c
> > new file mode 100644
> > index 000000000000..33ed01f67654
> > --- /dev/null
> > +++ b/crypto/asymmetric_keys/pgp_library.c
> > @@ -0,0 +1,272 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/* PGP packet parser (RFC 4880)
> > + *
> > + * Copyright (C) 2011 Red Hat, Inc. All Rights Reserved.
> > + * Written by David Howells (dhowells@redhat.com)
> > + */
> > +
> > +#define pr_fmt(fmt) "PGPL: "fmt
> > +#include <linux/errno.h>
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +
> > +#include "pgplib.h"
> > +
> > +MODULE_LICENSE("GPL");
>=20
> Missing MODULE_DESCRIPTION()
>=20
> Since commit 1fffe7a34c89 ("script: modpost: emit a warning when the
> description is missing"), a module without a MODULE_DESCRIPTION() will
> result in a warning when built with make W=3D1. Recently, multiple
> developers have been eradicating these warnings treewide, and very few
> are left, so please don't introduce a new one :)

Uhm, checked it. Built the kernel with W=3Dn and didn't see it. Also, I
need to build the PGP code as module (W=3D1) for the message to appear
(if you select the preloading facility, the config option switches to
built-in).

Thanks

Roberto


