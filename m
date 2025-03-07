Return-Path: <linux-integrity+bounces-5173-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A8ECA565F0
	for <lists+linux-integrity@lfdr.de>; Fri,  7 Mar 2025 11:57:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E43967A39AF
	for <lists+linux-integrity@lfdr.de>; Fri,  7 Mar 2025 10:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB4EE20CCFD;
	Fri,  7 Mar 2025 10:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=earth.li header.i=@earth.li header.b="D7+hW5mB"
X-Original-To: linux-integrity@vger.kernel.org
Received: from the.earth.li (the.earth.li [93.93.131.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5B62066F9;
	Fri,  7 Mar 2025 10:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.93.131.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741345011; cv=none; b=MRBn2b7ddCHvGme2+RJnOhJ8NzgCGR7KNwnCX3YNAEvbyUrfQmiJXfuqsSfxD4/QzdqVjQ8g0G00xXjB3ExeKz+Ou+eLIqRLOulnr5ntxnPgOiuFcuLUdqFlt+6Y011zpcoVw5IIgqsjtL7i7PhhelrPnKM+zVGQbnzynnT+nEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741345011; c=relaxed/simple;
	bh=eTRc/R1vwk7APpvRq+dnRaLINEmGkL9jQlBfW6ATyhw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RIntg8zm+2JbOntsCxs+NJkh9tQeS0qLm+0GMZHaTan8cj2JXKpk+vsT6Qgp0iZJySlFdrDf3PqrbtW+eS0kNiLXnfs7iI11EuyOZgdf2hH7Jqc0sFoI9zZ4sHPIdt3rfwhYelAvjIfXkTOpsVSuo+U8MfPAtaM29DAlEvs0WlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li; spf=pass smtp.mailfrom=earth.li; dkim=pass (2048-bit key) header.d=earth.li header.i=@earth.li header.b=D7+hW5mB; arc=none smtp.client-ip=93.93.131.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=earth.li
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=earth.li;
	s=the; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:
	Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=WoTjMvJJto9D8TXVxK8rThpPOlhA/e+cJVWquc8Ex8Q=; b=D7+hW5mBoqVRcpSpaBM6l2vH9E
	9zywA0UoU44/mwab72ZvxRTzzrIEtUldHCZmE2Mplx0h98Yzw/eKlUUKCyolFddiJyMguJhI8eyxs
	0deq7bq33WH2Il8p6fcSkqPGBNKyDhtkBWkk1K/8sCnMOLzeseIuTQLKXkNp+HkwutyT2Le20AheK
	PGe84LfC1i17FKWt7DgjJ6VimO3SrtO8DnlhbA9i2gIUHVNHqHG+dl8MjfxsYIKFAsWPg3wJf6tcv
	+cmql21Lz6kzsA/a4lL6hJFu367C/8jLaBribGiERVPDuhKM/YagkXay6B+sSN4/5ejKQNbYuemM2
	veyLBzaw==;
Received: from noodles by the.earth.li with local (Exim 4.96)
	(envelope-from <noodles@earth.li>)
	id 1tqVNk-00Cu2b-0X;
	Fri, 07 Mar 2025 10:56:44 +0000
Date: Fri, 7 Mar 2025 10:56:44 +0000
From: Jonathan McDowell <noodles@earth.li>
To: Jarkko Sakkinen <jarkko@kernel.org>, Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] tpm: Drop warning when an auth session is active
Message-ID: <Z8rQ7Mxf_G6227HP@earth.li>
References: <Z8m8G0RfiRyYGH_t@earth.li>
 <Z8oV9lJ4hsHualcP@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8oV9lJ4hsHualcP@kernel.org>

Auth sessions are lazily flushed since commit df745e25098dc ("tpm:
Lazily flush the auth session"), so it's expected that we might try to
start a new session when one is still active.

Signed-off-by: Jonathan McDowell <noodles@meta.com>
---
 drivers/char/tpm/tpm2-sessions.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-sessions.c
index b70165b588ec..2d2c192ebb14 100644
--- a/drivers/char/tpm/tpm2-sessions.c
+++ b/drivers/char/tpm/tpm2-sessions.c
@@ -982,7 +982,6 @@ int tpm2_start_auth_session(struct tpm_chip *chip)
 	int rc;
 
 	if (chip->auth) {
-		dev_warn_once(&chip->dev, "auth session is active\n");
 		return 0;
 	}
 
-- 
2.48.1


