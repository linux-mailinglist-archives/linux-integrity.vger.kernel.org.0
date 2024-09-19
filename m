Return-Path: <linux-integrity+bounces-3641-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FE2297C40D
	for <lists+linux-integrity@lfdr.de>; Thu, 19 Sep 2024 07:59:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2ACF1C203DA
	for <lists+linux-integrity@lfdr.de>; Thu, 19 Sep 2024 05:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B7C51386DF;
	Thu, 19 Sep 2024 05:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u0b8hiBk"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1838A136358;
	Thu, 19 Sep 2024 05:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726725545; cv=none; b=EiLg9Uq7QTNS0Uhff48gC2g7h8scHRjv0QoZAHXVmn3O+652gKiaJoj4IGbpX+DRWnajhXshXnn/0c7G6c+SeUxid5yTLPSPU3rMeKwpkGiPPa0U8k7lrWXc8B9BlQQ2EBowW8h+CX+VohnFkYLW06BBgTGqFwq/ZgHrUBYVqh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726725545; c=relaxed/simple;
	bh=0ZQhJlHot1sN0L6cuZE2yajuRfKqV9xX9XlpFaoZPlg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c96Y87ZDsd8IwT/Q6GBQbSHasby9QBQj7EIJm5hj3orqQ4LMV2rKjTje7AekLyL7llXFX6ZR+7gS4IKF01THzqnRzNzLjYdMe8CdjmQZujHk1EsmJssLe/Ay04c0TwFYrv8vHlaZSnovp6RtbnyTIPGAf0h7JvOKQZPILgAAv5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u0b8hiBk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24145C4CEC4;
	Thu, 19 Sep 2024 05:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726725544;
	bh=0ZQhJlHot1sN0L6cuZE2yajuRfKqV9xX9XlpFaoZPlg=;
	h=From:To:Cc:Subject:Date:From;
	b=u0b8hiBkTTwsqcmmW5cxghOS7pKgccUH5WN1uMrzeIeRI30LGwmQ49o6ELYEya+jq
	 iwdrTKIaOHf6fZVgyEvEaio4mLxI6mJdQnCPCqe8Aa2gZ30Rk5K1V3DCJ/QQt2N8DC
	 Q8W7l+hzbF8qhXlFJ/iitFrzoiBOv9aMOzP4o07+eMcbvPlIIGoksAAGw9Et8u6Gjd
	 Fp0oSIggCyiRyC846N3KOzr3vts+rECzW1SizUCAdsi6/n9C1fpgusnrPBAYXBaAZf
	 8oNfR6ZwEtK7OqF89zzcIhYosw2fDTp3momXg2Iq62fJYet54YR5JXK+eFShsG3+YA
	 9UjYFLVsJ2Zvw==
From: tzungbi@kernel.org
To: peterhuewe@gmx.de,
	jarkko@kernel.org
Cc: jgg@ziepe.ca,
	linux-integrity@vger.kernel.org,
	tzungbi@kernel.org,
	apronin@chromium.org,
	jettrink@chromium.org,
	gwendal@chromium.org,
	chrome-platform@lists.linux.dev
Subject: [PATCH] MAINTAINERS: Add Google Security Chip entry
Date: Thu, 19 Sep 2024 05:57:54 +0000
Message-ID: <20240919055754.2036555-1-tzungbi@kernel.org>
X-Mailer: git-send-email 2.46.0.792.g87dc391469-goog
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tzung-Bi Shih <tzungbi@kernel.org>

These are Google Security Chip drivers and are mostly used for ChromeOS
platforms.  Add a new entry for them.

Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8a76c256229c..07dc83e01216 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9593,6 +9593,15 @@ S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git
 F:	drivers/firmware/google/
 
+GOOGLE SECURITY CHIP DRIVERS
+M:	Tzung-Bi Shih <tzungbi@kernel.org>
+R:	Andrey Pronin <apronin@chromium.org>
+L:	chrome-platform@lists.linux.dev
+S:	Maintained
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git
+F:	Documentation/devicetree/bindings/tpm/google,cr50.yaml
+F:	drivers/char/tpm/*cr50*
+
 GOOGLE TENSOR SoC SUPPORT
 M:	Peter Griffin <peter.griffin@linaro.org>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
-- 
2.46.0.792.g87dc391469-goog


