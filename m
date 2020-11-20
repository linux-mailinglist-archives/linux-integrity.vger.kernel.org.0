Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E0F72BB42F
	for <lists+linux-integrity@lfdr.de>; Fri, 20 Nov 2020 19:59:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731395AbgKTSlz (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 20 Nov 2020 13:41:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:58260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731543AbgKTSkJ (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 20 Nov 2020 13:40:09 -0500
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 773412242B;
        Fri, 20 Nov 2020 18:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605897609;
        bh=B/PWRVssyp95V3yRR2KQnwMdlovlDJSISj7CoiNmeh4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SCCw476KOu03o1xkMgCxaH5YNUmznvnmG/uVKvwPzsRd2kuU2OkB2a/V5Bcq9muai
         LWUE0OwDFid+1hs5akQ3kRvbexeCvifjQTKRhLg+VaWj19oRzo2QD/d5ZPG7zdEcuK
         lC6xrsISL4KE1m5gQ6QZ4XppMUTrcJqNq2jL7Zwg=
Date:   Fri, 20 Nov 2020 12:40:14 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH 131/141] tpm: Fix fall-through warnings for Clang
Message-ID: <1804f48dac434541dc60ada5eefcb86f74905671.1605896060.git.gustavoars@kernel.org>
References: <cover.1605896059.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1605896059.git.gustavoars@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

In preparation to enable -Wimplicit-fallthrough for Clang, fix a warning
by explicitly adding a break statement instead of letting the code fall
through to the next case.

Link: https://github.com/KSPP/linux/issues/115
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/char/tpm/eventlog/tpm1.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/char/tpm/eventlog/tpm1.c b/drivers/char/tpm/eventlog/tpm1.c
index 2c96977ad080..8aa9057601d6 100644
--- a/drivers/char/tpm/eventlog/tpm1.c
+++ b/drivers/char/tpm/eventlog/tpm1.c
@@ -210,6 +210,7 @@ static int get_event_name(char *dest, struct tcpa_event *event,
 		default:
 			break;
 		}
+		break;
 	default:
 		break;
 	}
-- 
2.27.0

