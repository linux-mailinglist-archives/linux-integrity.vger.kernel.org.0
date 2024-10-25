Return-Path: <linux-integrity+bounces-3915-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 583559B0CF3
	for <lists+linux-integrity@lfdr.de>; Fri, 25 Oct 2024 20:15:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA6D7280DCE
	for <lists+linux-integrity@lfdr.de>; Fri, 25 Oct 2024 18:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6157033EA;
	Fri, 25 Oct 2024 18:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dN7W8dWv"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311D5800;
	Fri, 25 Oct 2024 18:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729880137; cv=none; b=kE3xjBMFwhhnCW/lhGiR5bfTG3l1J5koyxlTy3xa+vbRIj06qVOlBsFsnkddpZAw8MfqCJwEd4FXOfpDh4bvZriXpg4rEiYc/P+049zJv0g2oPZT98PFuiSVzRFE5KnI87PgquTofeWELVpQailX7R6qezgIOOq2xQGWLuC/8yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729880137; c=relaxed/simple;
	bh=4uWSpXe0OsFhjDgpcwZNsIzSJ70LaDPml3fkTZ/8ecw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Hn4D15Q97H7OeI4CLGlN9ZuYjkqGwRYrsvwE+KJ5yyGP/LJBJQykRIbons/AZFCQA/WnrcDTBbjqbaAuh65Ihdq3QREP3aSDWZ6zOUmpDyLlnybheYBeJqPajv078tT1x+EmbjWq7cMEeFUjbGOY7+8zK0P2P/D6GqU6+QEyGSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dN7W8dWv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E4A8C4CEC3;
	Fri, 25 Oct 2024 18:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729880136;
	bh=4uWSpXe0OsFhjDgpcwZNsIzSJ70LaDPml3fkTZ/8ecw=;
	h=From:To:Cc:Subject:Date:From;
	b=dN7W8dWvZiFW5UGVdUTOUVjx/AzrGY1bG/nrzR5SYHVHBpFnJl8qJKAoiljlrnC/S
	 GZxZl1liMGa2htVrIZxL08QBNxL+g+I96iCkxLBdzTKp3oQrVPC3POfswlKjK45vhX
	 vlq1Xwmju2eStcNA7JVt2UEmlr8c8I41UGs5P52w/TRY3QjG5iVDEnNhoO4V287Jhh
	 gxM6QT16NA4E2F+amnAEfpj3yzE4rbjOZdApsbCPdUWrILYyqONA66YnVRN7ModgZq
	 hBp0k3S+dveZgVsDD6O50K7YWscZSd9DeXqRw0cRS7+PwtjyBqGRfM0SLXpeYg4lhu
	 QYZE9tbmZL6Ew==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Jiri Kosina <jikos@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Alex Elder <elder@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Matt Ranostay <matt@ranostay.sg>,
	Quentin Monnet <qmo@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] mailmap: update email addresses
Date: Fri, 25 Oct 2024 21:15:28 +0300
Message-ID: <20241025181530.6151-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove my previous work email, and the new one. The previous was never
used in the commit log, so there's no good reason to spare it.

Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 .mailmap | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.mailmap b/.mailmap
index 442da8603cef..90064084e92a 100644
--- a/.mailmap
+++ b/.mailmap
@@ -282,7 +282,7 @@ Jan Glauber <jan.glauber@gmail.com> <jglauber@cavium.com>
 Jan Kuliga <jtkuliga.kdev@gmail.com> <jankul@alatek.krakow.pl>
 Jarkko Sakkinen <jarkko@kernel.org> <jarkko.sakkinen@linux.intel.com>
 Jarkko Sakkinen <jarkko@kernel.org> <jarkko@profian.com>
-Jarkko Sakkinen <jarkko@kernel.org> <jarkko.sakkinen@tuni.fi>
+Jarkko Sakkinen <jarkko@kernel.org> <jarkko.sakkinen@parity.io>
 Jason Gunthorpe <jgg@ziepe.ca> <jgg@mellanox.com>
 Jason Gunthorpe <jgg@ziepe.ca> <jgg@nvidia.com>
 Jason Gunthorpe <jgg@ziepe.ca> <jgunthorpe@obsidianresearch.com>
-- 
2.47.0


