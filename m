Return-Path: <linux-integrity+bounces-2471-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75A428C9EFE
	for <lists+linux-integrity@lfdr.de>; Mon, 20 May 2024 16:48:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2ACBF1F234A0
	for <lists+linux-integrity@lfdr.de>; Mon, 20 May 2024 14:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4E58136669;
	Mon, 20 May 2024 14:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R2hAVPvI"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F39453E07
	for <linux-integrity@vger.kernel.org>; Mon, 20 May 2024 14:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716216518; cv=none; b=q2Qfn/CZoNkUD1vou5iJAeVDQdtaTHxqG31FFrPx+zixEDMjYLL34worSEWew6yfqeiQG9c+/FcrfqnV648WZs4QLinTmmVVx4fyuj2GZV+9dwrPtYnnGQkHc1TgXZ/HddmUjDA8Rywokk5+/k4if0AoecE2Oki7s7gKxmD5bJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716216518; c=relaxed/simple;
	bh=9sQ+qETetiPcP7US9VOXWCDDXxvT1L6uozVMA1LD5Bk=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=XQ/ydwr32GPjqrS41vooVsrn5cRnu5/n9YPjOh6skBUSsSJXCj7Qh4vSSpFNBKTqUu+5rqrbW+Xd9/nRZ48xy43j/erYZ2AQGdf9d1/HZfNVZ0BqWbsl9bUBPsfFDz1jKiaWltQjqmGtTmcywOkBFDLuuxXzcG3NwhGoVxTpA2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R2hAVPvI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716216516;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=Hhzl3NIcGBCf4wf9nxhH+bjvFQ9izgsrYOmoqIU5esg=;
	b=R2hAVPvI8+ZtYz38ZrOHhhgmmooD6s3ADEAh7mHZx9c2r6RDDKaY7n+ap76iMTNjhGDAVA
	pltv/CdNwR+bQCRfRxKPNhVx2ECdkGrKd1Zw56gup45Zw/mzK7iw5pG1HHfhW7hHXuxkGo
	msRoj822wtJK3on8PFzw8T2Xve1PAlc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-96-7G0MaQzIM52-R3SaXbfRxg-1; Mon, 20 May 2024 10:48:32 -0400
X-MC-Unique: 7G0MaQzIM52-R3SaXbfRxg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ABC358058D7;
	Mon, 20 May 2024 14:48:31 +0000 (UTC)
Received: from file1-rdu.file-001.prod.rdu2.dc.redhat.com (unknown [10.11.5.21])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 99B491050177;
	Mon, 20 May 2024 14:48:31 +0000 (UTC)
Received: by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix, from userid 12668)
	id 8667430C1C33; Mon, 20 May 2024 14:48:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix) with ESMTP id 836733FB52;
	Mon, 20 May 2024 16:48:31 +0200 (CEST)
Date: Mon, 20 May 2024 16:48:31 +0200 (CEST)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Eric Wheeler <linux-integrity@lists.ewheeler.net>, 
    Mike Snitzer <snitzer@kernel.org>
cc: Milan Broz <gmazyland@gmail.com>, dm-devel@lists.linux.dev, 
    linux-integrity@vger.kernel.org
Subject: [PATCH] dm-integrity: set discard_granularity to logical block
 size
Message-ID: <d015c396-d686-48b1-1460-c8e1b18f4c4c@redhat.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

dm-integrity could set discard_granularity lower than the logical block
size. This could result in failures when sending discard requests to
dm-integrity. This patch fixes discard_granularity.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Reported-by: Eric Wheeler <linux-integrity@lists.ewheeler.net>
Cc: stable@vger.kernel.org

---
 drivers/md/dm-integrity.c |    1 +
 1 file changed, 1 insertion(+)

Index: linux-2.6/drivers/md/dm-integrity.c
===================================================================
--- linux-2.6.orig/drivers/md/dm-integrity.c	2024-04-16 21:31:36.000000000 +0200
+++ linux-2.6/drivers/md/dm-integrity.c	2024-05-20 16:27:50.000000000 +0200
@@ -3492,6 +3492,7 @@ static void dm_integrity_io_hints(struct
 		limits->physical_block_size = ic->sectors_per_block << SECTOR_SHIFT;
 		blk_limits_io_min(limits, ic->sectors_per_block << SECTOR_SHIFT);
 		limits->dma_alignment = limits->logical_block_size - 1;
+		limits->discard_granularity = ic->sectors_per_block << SECTOR_SHIFT;
 	}
 	limits->max_integrity_segments = USHRT_MAX;
 }


