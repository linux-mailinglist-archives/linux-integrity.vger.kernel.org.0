Return-Path: <linux-integrity+bounces-4865-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A5DA3A22C
	for <lists+linux-integrity@lfdr.de>; Tue, 18 Feb 2025 17:09:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4D831899917
	for <lists+linux-integrity@lfdr.de>; Tue, 18 Feb 2025 16:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7091E26B95A;
	Tue, 18 Feb 2025 16:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kHng7JcE"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4689926A1D5;
	Tue, 18 Feb 2025 16:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739894782; cv=none; b=d8bF5g0nNgcX1+me2Fw6StsBqp9CnY1UGeu6BCqhBucOjvlM2KPffn4K/+BbqPgUKbNhP9JDdBajVxT842Cn9Dx7omslMl91j+P48U4KqYenSgsmTR4oJz/1SxtTAivkcIke4OCNfVCldl6c0GrrajW8ToPHRE9XbQIeA0TrcCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739894782; c=relaxed/simple;
	bh=9+iwSj8pYZbdZmKJ+JtRz6uR4leeeo47skJB8eQ+F4E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oCwZ2JnAKLPNxTvkdQ/CQz5dXT6o6f8kmvhhaVEGdC1HJgl6OHXUbP+7HI1JaqKbHeI+I3mkpw6PszUDOYgwQsWCHF3hqlQSCdwGIFK3RYGiReLo2yCicl3+N6w9xPeSjVxpTuuJ1xbX9UFyBoGjpD2mP2e9IeAnk/k1XkyiEg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kHng7JcE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F24DDC4CEE2;
	Tue, 18 Feb 2025 16:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739894781;
	bh=9+iwSj8pYZbdZmKJ+JtRz6uR4leeeo47skJB8eQ+F4E=;
	h=From:To:Cc:Subject:Date:From;
	b=kHng7JcErMKXBSlG1DFSKPl9KzlTNbDhqnCkSTo1z+n97rbg1nlg9ob2x4grE83oq
	 eFgt085qpvZXXcRrMGFPAMMLslBr1cyj2vs/x/AGIVq9/sbw2JZlESVTL2EzFfp8XU
	 NbRRScA+fXfOwO+h7jV8pt19Fnh9B2kLemKJz6VC++dtZWKQxHrzhQhWVNutWvmo5K
	 f5r7a5wG88C7Y+b4IxhC4AbZLN9UxAIOCiUPtIGSXmieFqJLsZumLp2stAxpA7YR3k
	 a5vx1ybkqqU9DJ9XYaTjcphiYjPEf/stM6WdHoTluTlA0CZEp0ozDsqaR2vK9x4TKW
	 XFNEcRfSm1BJg==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Simon Wunderlich <sw@simonwunderlich.de>,
	Alex Elder <elder@kernel.org>,
	Antonio Quartulli <antonio@mandelbit.com>,
	Kees Cook <kees@kernel.org>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Mathieu Othacehe <othacehe@gnu.org>,
	Eugen Hristev <eugen.hristev@linaro.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>
Cc: Quentin Monnet <qmo@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: remove never used @parity.io email
Date: Tue, 18 Feb 2025 18:06:05 +0200
Message-ID: <20250218160607.48829-1-jarkko@kernel.org>
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


