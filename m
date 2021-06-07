Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4825839E8B3
	for <lists+linux-integrity@lfdr.de>; Mon,  7 Jun 2021 22:48:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbhFGUuJ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 7 Jun 2021 16:50:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:34718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230209AbhFGUuJ (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 7 Jun 2021 16:50:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DF14E61139;
        Mon,  7 Jun 2021 20:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623098897;
        bh=0Uu85hNllNvsWDHLgq688UcbjPL6TiTRY2bV7a76cWU=;
        h=Date:From:To:Cc:Subject:From;
        b=KVK5+llGnjv9NuHyJne9Bor9u8aK/MI8MXgKCySUCnnNo69xjXI1hzlnaJwgV+9fM
         ZxA8qt9/mGcHQ6eyvJsnFyHFWdriCsUw6hV6pc4t1cpmtMVUI6hgcfsop9GYtIh+AF
         +pDj49cdbmsCrKKO7k0s13Wk63vnRW22hWEyBEsNVS6klpr6LS/gULtlLcCxU1FCbj
         1cv1wCESkXy+poh0o77cvcqCIH3skj42YwkKkROZWD0BIm6sWl1By11sa72a8PQ7Jt
         Zk5KgkkgusQw9OVFqVsfIRXYMMyhnIxUdHP5yeCBiNt1jPbwK3kkT8AzP7DWwMKH4l
         o7TjqjO7LqDXA==
Date:   Mon, 7 Jun 2021 15:49:34 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org, Kees Cook <keescook@chromium.org>
Subject: [PATCH][next] ima: Fix fall-through warning for Clang
Message-ID: <20210607204934.GA63263@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

In preparation to enable -Wimplicit-fallthrough for Clang, fix a
fall-through warning by explicitly adding a break statement instead
of just letting the code fall through to the next case.

Link: https://github.com/KSPP/linux/issues/115
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
JFYI: We had thousands of these sorts of warnings and now we are down
      to just 13 in linux-next(20210607). This is one of those last
      remaining warnings. :)

 security/integrity/ima/ima_template_lib.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/security/integrity/ima/ima_template_lib.c b/security/integrity/ima/ima_template_lib.c
index 518fd50ea48a..8f96247b4a5c 100644
--- a/security/integrity/ima/ima_template_lib.c
+++ b/security/integrity/ima/ima_template_lib.c
@@ -119,6 +119,7 @@ static void ima_show_template_data_ascii(struct seq_file *m,
 		default:
 			break;
 		}
+		break;
 	default:
 		break;
 	}
-- 
2.27.0

