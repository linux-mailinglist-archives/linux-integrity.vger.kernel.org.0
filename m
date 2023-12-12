Return-Path: <linux-integrity+bounces-393-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5445380E144
	for <lists+linux-integrity@lfdr.de>; Tue, 12 Dec 2023 03:12:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 035A8282692
	for <lists+linux-integrity@lfdr.de>; Tue, 12 Dec 2023 02:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3CF810FF;
	Tue, 12 Dec 2023 02:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DIGYaDcD"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9DE10EB;
	Tue, 12 Dec 2023 02:12:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E77CAC433C7;
	Tue, 12 Dec 2023 02:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702347164;
	bh=2Cg/52nI3fdI2AVhoHfzbNxd0uf98ZFGlAXCevSa/38=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DIGYaDcDJfgV9V9Kll/eVAjU5Pcg/Odi1Q/oYNIrI5NhQ1ZyMT6o6eIw6XHN0R9wZ
	 jZJPE0ykmH56Zq3PYC8MmI3xEbVcG4FLvsQuecKaL8KGxtO8uN+iygNOIXqAwMa8KY
	 CiaSf/VC9rIQdtJCSxLIBZ0psruQkZRMt14tins9c3QoLaqVODvduQFC/esPlQ7ict
	 EVL2YytgLeB2SDSfp2zL1UIcf5Ug13RA3UyDwztS7JkdC9TrSren1N1ujSy2HZsxKf
	 3n1qxqNE/Sk/SnfnAsoR7AVyKevmv+dvZI6wqHEiym7dgkpP+2F4UlOA00drzROKaH
	 6iDKiMWaLYLdA==
Date: Mon, 11 Dec 2023 21:12:42 -0500
From: Sasha Levin <sashal@kernel.org>
To: rkolchmeyer@google.com
Cc: stable@vger.kernel.org, linux-integrity@vger.kernel.org,
	regressions@lists.linux.dev, eric.snowberg@oracle.com,
	zohar@linux.ibm.com, jlayton@kernel.org
Subject: Re: IMA performance regression in 5.10.194 when using overlayfs
Message-ID: <ZXfBmiTHnm_SsM-n@sashalap>
References: <000000000000b505f3060c454a49@google.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <000000000000b505f3060c454a49@google.com>

On Tue, Dec 12, 2023 at 12:40:05AM +0000, rkolchmeyer@google.com wrote:
>Hi all,
>
>5.10.194 includes 331d85f0bc6e (ovl: Always reevaluate the file
>signature for IMA), which resulted in a performance regression for
>workloads that use IMA and run from overlayfs. 5.10.202 includes
>cd5a262a07a5 (ima: detect changes to the backing overlay file), which
>resolved the regression in the upstream kernel. However, from my
>testing [1], this change doesn't resolve the regression on stable
>kernels.
>
>From what I can tell, cd5a262a07a5 (ima: detect changes to the
>backing overlay file) depends on both db1d1e8b9867 (IMA: use
>vfs_getattr_nosec to get the i_version) and a1175d6b1bda (vfs: plumb
>i_version handling into struct kstat). These two dependent changes
>were not backported to stable kernels. As a result, IMA seems to be
>caching the wrong i_version value when using overlayfs. From my
>testing, backporting these two dependent changes is sufficient to
>resolve the issue in stable kernels.

Thanks for triaging and proposing a resolution to the issue!

>Would it make sense to backport those changes to stable kernels? It's
>possible that they may not follow the stable kernel patching rules. I
>think the issue can also be fixed directly in stable trees with the
>following diff (which doesn't make sense in the upstream kernel):
>
>diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
>index 70efd4aa1bd1..c84ae6b62b3a 100644
>--- a/security/integrity/ima/ima_api.c
>+++ b/security/integrity/ima/ima_api.c
>@@ -239,7 +239,7 @@ int ima_collect_measurement(struct integrity_iint_cache *iint,
> 	 * which do not support i_version, support is limited to an initial
> 	 * measurement/appraisal/audit.
> 	 */
>-	i_version = inode_query_iversion(inode);
>+	i_version = inode_query_iversion(real_inode);
> 	hash.hdr.algo = algo;
>
> 	/* Initialize hash digest to 0's in case of failure */
>
>I've verified that this diff resolves the performance regression.
>
>Which approach would make the most sense to fix the issue in stable
>kernels? Backporting the dependent commits, or merging the above diff?

Looking at the dependencies you've identified, it probably makes sense
to just take them as is (as it's something we would have done if these
dependencies were identified explicitly).

I'll plan to queue them up after the current round of releases is out.

-- 
Thanks,
Sasha

