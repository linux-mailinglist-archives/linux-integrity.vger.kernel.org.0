Return-Path: <linux-integrity+bounces-4866-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 655BAA3A38B
	for <lists+linux-integrity@lfdr.de>; Tue, 18 Feb 2025 18:06:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 500193AEB50
	for <lists+linux-integrity@lfdr.de>; Tue, 18 Feb 2025 17:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95B6D26FA75;
	Tue, 18 Feb 2025 17:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xx4eqVDe"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3C726FA6E;
	Tue, 18 Feb 2025 17:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739898364; cv=none; b=T2ys9+3TuBk5DczwLeTLx7+MVfZxzhbTc6XCPqXo1shK0mUCGB+Lkq0UV/bnDs51eFJM8yJe2+FZU+0QvfekTHWhx7AhUL2ltxaaraSEzBUA4HCInV2bXFcwwqO/OUVw7u+J0X6LAZGflGwwYnnikxcVanm/O2IQWdFkWJG41SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739898364; c=relaxed/simple;
	bh=PTbtR+JmGwrfTCmOvqXnqMth752ViFO7q1gIDwSLb0k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pqBjPvyGTW0FuPkkKxnMv3kKmG1Lipc2LfVAb0FGW1nDw2cFFMmy7Gn1PygUkrk1ag2os3+UTuuNWwkka7iyzcEVmyU57Gco5pNlWW4mrfKqf47qtYQH4og/g2di1IHAKu+ZCch1O0YbmGZmKuA90eO9wct+f4XvdIbWPNaIgCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xx4eqVDe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56EDEC4CEE8;
	Tue, 18 Feb 2025 17:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739898363;
	bh=PTbtR+JmGwrfTCmOvqXnqMth752ViFO7q1gIDwSLb0k=;
	h=From:To:Cc:Subject:Date:From;
	b=Xx4eqVDeeWA1cLCDtcLdlmfflPRszcSSwOV4pGpIVVLTfCrz6ODi5D86p8Sda5psQ
	 NukWExB6KctPfUQfCyx8nNeclDB2uZSzvpXa5pf6q5GYLLpF1CfHZJnj3OX2GPpzjK
	 +fJY6qp61iqgnBnxmXjtlo6JdWkaZIaZqmTQQA/VQKm1vvjkZQ0IULC3KTZLpYuWez
	 XOhyhuwDlvgTA1nSPvqwHmMBF/Lf/8z9cZgUADpxzVkzVenG0P3XVpgetTiSW/hovP
	 gfMxzxvCSQzwB/XmEwjw2knCFqxQqn/hGGQIv1SGf06RBEwggTFjNeTeSm9iYfDflV
	 7I3ZG2sH0p6hg==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Simon Wunderlich <sw@simonwunderlich.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alex Elder <elder@kernel.org>,
	Antonio Quartulli <antonio@mandelbit.com>,
	Kees Cook <kees@kernel.org>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Satya Priya Kakitapalli <quic_skakitap@quicinc.com>,
	Mathieu Othacehe <othacehe@gnu.org>,
	Quentin Monnet <qmo@kernel.org>
Cc: Eugen Hristev <eugen.hristev@linaro.org>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] mailmap: remove never used @parity.io email
Date: Tue, 18 Feb 2025 19:05:55 +0200
Message-ID: <20250218170557.68371-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As this employment lasted only four months and was never used over here,
let's just rip it off for good.

Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
v2:
- Oops, "MAINTAINERS" was just a typo (sorry).
---
 .mailmap | 1 -
 1 file changed, 1 deletion(-)

diff --git a/.mailmap b/.mailmap
index ae0adc499f4a..146701e57ba9 100644
--- a/.mailmap
+++ b/.mailmap
@@ -303,7 +303,6 @@ Jan Glauber <jan.glauber@gmail.com> <jglauber@cavium.com>
 Jan Kuliga <jtkuliga.kdev@gmail.com> <jankul@alatek.krakow.pl>
 Jarkko Sakkinen <jarkko@kernel.org> <jarkko.sakkinen@linux.intel.com>
 Jarkko Sakkinen <jarkko@kernel.org> <jarkko@profian.com>
-Jarkko Sakkinen <jarkko@kernel.org> <jarkko.sakkinen@parity.io>
 Jason Gunthorpe <jgg@ziepe.ca> <jgg@mellanox.com>
 Jason Gunthorpe <jgg@ziepe.ca> <jgg@nvidia.com>
 Jason Gunthorpe <jgg@ziepe.ca> <jgunthorpe@obsidianresearch.com>
-- 
2.48.1


