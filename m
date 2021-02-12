Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E53FA31A420
	for <lists+linux-integrity@lfdr.de>; Fri, 12 Feb 2021 19:02:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbhBLR74 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 12 Feb 2021 12:59:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47809 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229451AbhBLR7y (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 12 Feb 2021 12:59:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613152709;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=oiM9NzW+OJCzAgrhPcpTmDiJAuJGosABB7vwf+qiiiU=;
        b=CrAiRoN+IbqbTROfeifskwq3dJOkelvW3LmVor8WRS3nxDBa1WFFRvUn572LcDiQLdusPr
        SUQFyZOoLBCNyBiCc+6968tKgUvosxLfOihHHqEybkeVNahBnr7fXZjAXiR48ERGlZdhdx
        Br1HjU5dUkQ+77fM0pVxMt5UlU8IaOo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-267-Kg7F51yrO6qiw2Jxt12DBg-1; Fri, 12 Feb 2021 12:58:28 -0500
X-MC-Unique: Kg7F51yrO6qiw2Jxt12DBg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 55CDB835E21
        for <linux-integrity@vger.kernel.org>; Fri, 12 Feb 2021 17:58:27 +0000 (UTC)
Received: from bearskin.sorenson.redhat.com (ovpn-114-125.phx2.redhat.com [10.3.114.125])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 375A35D9DB;
        Fri, 12 Feb 2021 17:58:23 +0000 (UTC)
From:   Frank Sorenson <sorenson@redhat.com>
To:     linux-integrity@vger.kernel.org
Cc:     sorenson@redhat.com
Subject: [PATCH] ima-evm-utils: Prevent crash if pcr is invalid
Date:   Fri, 12 Feb 2021 11:58:22 -0600
Message-Id: <20210212175822.2917142-1-sorenson@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

If the pcr is invalid, evmctl will crash while accessing
an invalid memory address.  Verify the pcr is in the
expected range.

Also, correct range of an existing check.

Signed-off-by: Frank Sorenson <sorenson@redhat.com>
---
 src/evmctl.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/src/evmctl.c b/src/evmctl.c
index 1815f55..a14337a 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -1975,6 +1975,11 @@ static int ima_measurement(const char *file)
 		tpmbanks = 0;
 
 	while (fread(&entry.header, sizeof(entry.header), 1, fp)) {
+		if (entry.header.pcr >= NUM_PCRS) {
+			log_err("Invalid PCR %d.\n", entry.header.pcr);
+			fclose(fp);
+			exit(1);
+		}
 		if (entry.header.name_len > TCG_EVENT_NAME_LEN_MAX) {
 			log_err("%d ERROR: event name too long!\n",
 				entry.header.name_len);
@@ -2180,7 +2185,7 @@ static int read_binary_bios_measurements(char *file, struct tpm_bank_info *bank)
 			log_info("%02u ", event.header.pcr);
 			log_dump(event.header.digest, SHA_DIGEST_LENGTH);
 		}
-		if (event.header.pcr > NUM_PCRS) {
+		if (event.header.pcr >= NUM_PCRS) {
 			log_err("Invalid PCR %d.\n", event.header.pcr);
 			err = 1;
 			break;
-- 
2.29.2

