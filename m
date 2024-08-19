Return-Path: <linux-integrity+bounces-3355-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C849956D7B
	for <lists+linux-integrity@lfdr.de>; Mon, 19 Aug 2024 16:38:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA3F22841CF
	for <lists+linux-integrity@lfdr.de>; Mon, 19 Aug 2024 14:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62074171E5A;
	Mon, 19 Aug 2024 14:38:34 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464DC17166E;
	Mon, 19 Aug 2024 14:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724078314; cv=none; b=ZvPdIhvrTzdtq20WhFN+wek9mntvKjajiH4znfozmivaJDMsNHlZmCJ3UnK3mUk4Qkea+OkP/nk7r61c0AvpSxsYjeYlG1QKKtjhVVDTgUOhsiTurF9qiN9S7PYjoAVqEUCJ1KMV1QcvXZiOtxOKPs66natPr+q9n77GHvT6FTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724078314; c=relaxed/simple;
	bh=ZohGN1b+MVmLdjfygjGavTtu3PvsalA2EoUhvXN3T1I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=p7KD2Htno0mTwF5AoYnvGel+Ifot9rdEmCN6TtoYZHODPnlVdQ6rGI5L6dyR42kgZglkqIKpI3KjZgVo7WaiRFznN2xQ64jVpV7wjUh1edy7anZIq+OUrBodTBCovJ/7ufZo4pmVBrRwCU9PA1LojuihCVFl4GI6IqsKwb/v23U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4WnZMc4vnhz9v7Jb;
	Mon, 19 Aug 2024 22:13:48 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 5D154140443;
	Mon, 19 Aug 2024 22:38:20 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwC31MHTWMNme5uDAQ--.19910S2;
	Mon, 19 Aug 2024 15:38:19 +0100 (CET)
Message-ID: <58a857afc8b97433ab0056628958d81e69bd7421.camel@huaweicloud.com>
Subject: Re: [PATCH v2 06/14] KEYS: PGP data parser
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Jeff Johnson <quic_jjohnson@quicinc.com>, dhowells@redhat.com, 
	dwmw2@infradead.org, herbert@gondor.apana.org.au, davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, keyrings@vger.kernel.org, 
	linux-crypto@vger.kernel.org, zohar@linux.ibm.com, 
	linux-integrity@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>
Date: Mon, 19 Aug 2024 16:38:08 +0200
In-Reply-To: <45accf08-bb98-4199-b0a0-a314f3d0574b@quicinc.com>
References: <20240818165756.629203-1-roberto.sassu@huaweicloud.com>
	 <20240818165756.629203-7-roberto.sassu@huaweicloud.com>
	 <45accf08-bb98-4199-b0a0-a314f3d0574b@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:GxC2BwC31MHTWMNme5uDAQ--.19910S2
X-Coremail-Antispam: 1UD129KBjvJXoW7try7XF1rZF17Gw4fXFWDurg_yoW8JFyfpF
	4kAF4DJF4qyr1jkrWrJ34agasrJa4xCF13K34vgw4UA3sIvrnrGrWvvryDuF1Uta1kK34F
	yFWrXa1YvrZ0qrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAABGbCqfEG7AABsS

On Mon, 2024-08-19 at 07:36 -0700, Jeff Johnson wrote:
> On 8/18/24 09:57, Roberto Sassu wrote:
> ...
> > diff --git a/crypto/asymmetric_keys/pgp_public_key.c b/crypto/asymmetri=
c_keys/pgp_public_key.c
> > new file mode 100644
> > index 000000000000..cb399f5cdd3e
> > --- /dev/null
> > +++ b/crypto/asymmetric_keys/pgp_public_key.c
> > @@ -0,0 +1,366 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/* Instantiate a public key crypto key from PGP format data [RFC 4880]
> > + *
> > + * Copyright (C) 2011 Red Hat, Inc. All Rights Reserved.
> > + * Written by David Howells (dhowells@redhat.com)
> > + */
> > +
> > +#define pr_fmt(fmt) "PGP: "fmt
> > +#include <linux/module.h>
> > +#include <linux/kernel.h>
> > +#include <linux/slab.h>
> > +#include <linux/mpi.h>
> > +#include <keys/asymmetric-subtype.h>
> > +#include <keys/asymmetric-parser.h>
> > +#include <crypto/hash.h>
> > +#include <crypto/public_key.h>
> > +
> > +#include "pgp_parser.h"
> > +
> > +#define MAX_MPI 5
> > +#define KEYCTL_SUPPORTS_ENCDEC \
> > +	(KEYCTL_SUPPORTS_ENCRYPT | KEYCTL_SUPPORTS_DECRYPT)
> > +#define KEYCTL_SUPPORTS_SIGVER (KEYCTL_SUPPORTS_SIGN | KEYCTL_SUPPORTS=
_VERIFY)
> > +
> > +MODULE_LICENSE("GPL");
>=20
> Missing MODULE_DESCRIPTION()

Thanks! Will add it.

Roberto


