Return-Path: <linux-integrity+bounces-3303-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D395D94C6B0
	for <lists+linux-integrity@lfdr.de>; Fri,  9 Aug 2024 00:05:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0363A28337B
	for <lists+linux-integrity@lfdr.de>; Thu,  8 Aug 2024 22:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A36AF15ADA4;
	Thu,  8 Aug 2024 22:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EShAfoJi"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708B82A1DF;
	Thu,  8 Aug 2024 22:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723154702; cv=none; b=FBSVdOgNnVM+gXbdDOT/hRLLFUMhVLZIFdwaysfMwlk+X6EuYCtcmLHfINT6/XddkSF0fgicGF1lxYGzoTFU3pWlv7qqTVzgcjn/nXbQNdtS8nWSdKFXw8l9dMJ9qnUGDq28C2ahOZELLEtMNi3n5VNynDp2+3QvJSCq89axXdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723154702; c=relaxed/simple;
	bh=qnpZw+lFbLx8fiwo3zs7XLa7SwYU5KxtlLxuoVA7qLU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=J6dnK7A+Stxz2syexvSHk6l3U2IYPtMzMEbYBybSWWBi6CkDh8O9YYjkFjgsu17ZhyjUgZoBS3pdIQz5p491ystBxA3XuMDvznTO6+GdaG9wQya2V24HYgKXWjox90Tg+plIk+L+Dx8c662/ij11y6h2oBlfuSwxBVeIjr2H+EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EShAfoJi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06378C32782;
	Thu,  8 Aug 2024 22:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723154702;
	bh=qnpZw+lFbLx8fiwo3zs7XLa7SwYU5KxtlLxuoVA7qLU=;
	h=Date:From:To:Cc:Subject:From;
	b=EShAfoJi5V3DpuVchMO7eZNgNNT4VJ9FiGfBB6cdBOC2cPVddqPrWRSuRIB5u1WQJ
	 GDDUegjSxWTNGxZ0aQjkc82DR7bUcjiuBKXUUehGhpLCLJL1d6wKbybV5L2Ws4Izdm
	 k4hYsxJcPR8TL5DNmCWyfvfc1Rh8jhZufMAvZMHu5wkE4RGl0kAjOeBhXNQcLayo3c
	 CTJmSb3EhUAfVuZFK3RPgalpgkVq4H83Ns74mrceou6oDZi0+F0JUqArh+FDTcdIla
	 RzwKBDuqM9wxup9VwyW6WVPMumasLGINrO1guidJGhFtcMRyll/OXb81RdYNPkMe3m
	 0AfRlQjPIw5mA==
Date: Thu, 8 Aug 2024 16:04:59 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH][next] integrity: Use static_assert() to check struct sizes
Message-ID: <ZrVBC9dGwukjfhet@cute>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Commit 38aa3f5ac6d2 ("integrity: Avoid -Wflex-array-member-not-at-end
warnings") introduced tagged `struct evm_ima_xattr_data_hdr` and
`struct ima_digest_data_hdr`. We want to ensure that when new members
need to be added to the flexible structures, they are always included
within these tagged structs.

So, we use `static_assert()` to ensure that the memory layout for
both the flexible structure and the tagged struct is the same after
any changes.

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 security/integrity/integrity.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
index 660f76cb69d3..c2c2da691123 100644
--- a/security/integrity/integrity.h
+++ b/security/integrity/integrity.h
@@ -37,6 +37,8 @@ struct evm_ima_xattr_data {
 	);
 	u8 data[];
 } __packed;
+static_assert(offsetof(struct evm_ima_xattr_data, data) == sizeof(struct evm_ima_xattr_data_hdr),
+	      "struct member likely outside of __struct_group()");
 
 /* Only used in the EVM HMAC code. */
 struct evm_xattr {
@@ -65,6 +67,8 @@ struct ima_digest_data {
 	);
 	u8 digest[];
 } __packed;
+static_assert(offsetof(struct ima_digest_data, digest) == sizeof(struct ima_digest_data_hdr),
+	      "struct member likely outside of __struct_group()");
 
 /*
  * Instead of wrapping the ima_digest_data struct inside a local structure
-- 
2.34.1


