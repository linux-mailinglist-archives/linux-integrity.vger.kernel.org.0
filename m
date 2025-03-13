Return-Path: <linux-integrity+bounces-5269-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D215CA5EFA8
	for <lists+linux-integrity@lfdr.de>; Thu, 13 Mar 2025 10:37:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6849A3A918E
	for <lists+linux-integrity@lfdr.de>; Thu, 13 Mar 2025 09:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30D71264626;
	Thu, 13 Mar 2025 09:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HnlykSsG"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CDAC263F4F
	for <linux-integrity@vger.kernel.org>; Thu, 13 Mar 2025 09:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741858646; cv=none; b=lXVrThkJa9neIWpkw43GNQFj3WOTQckxgRmZhsfNsRRW4Jbly9zNNjYZtsORK9uyUQnbYxqGhuf+Qb+1k8jE28Gs9xQUlhHsIaOCrfAxurzM0JrULLiZYuu6/+pzf8eCgM7ZWWxCXxZRkibP2mlX8L6JDD4yiPy7cuIh/fuX9Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741858646; c=relaxed/simple;
	bh=0O9+tvS721NPS5SfhMQUQOXZjZEeYgWVPm6bA9exrc0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gKGPQuwKHaUWa2tOd926KIWyutQQ/+s7xfVjosRJeq1vX49ITgJ8bNjUxHztzbSV5PbOFWYfNi3LEHa0+ZpnLrEGQKBpUafAWHdwT5wSxq0NTKPG55x0EM7TRy+JQybTF4bYpVmXBGVRIYNFHanoB+Lf2X8Qn7ydnL7MfiaHpSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HnlykSsG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741858643;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=TkMmQDKhA8euP7OgbcejyvBbDNEneAYENQsYyU/R2lQ=;
	b=HnlykSsGr88XHoI0UfhMORZGg9f9NWOMmKEPcoa+OsAVd824jiqXG+z5daT1qTTI1VEssV
	HjBsKOgBftQIu5iegcYadiyvn63Nd3KfYsQgsJI0MPSwMq6dpYlOhQIfqpik9NXhMfVFf7
	uZ5uRkOG61D3f02ICwj5WUwOjXsuC5g=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-14-RBmisXBhODyI7N2n1sJxJw-1; Thu, 13 Mar 2025 05:37:21 -0400
X-MC-Unique: RBmisXBhODyI7N2n1sJxJw-1
X-Mimecast-MFC-AGG-ID: RBmisXBhODyI7N2n1sJxJw_1741858640
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3912d9848a7so949453f8f.0
        for <linux-integrity@vger.kernel.org>; Thu, 13 Mar 2025 02:37:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741858640; x=1742463440;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TkMmQDKhA8euP7OgbcejyvBbDNEneAYENQsYyU/R2lQ=;
        b=Jvqws2Fmc0DhW13uYrJtZxvEEw73bsJVuIxRyiOjZWqTnJfz8W0Oi9YMb3fUnGRdOb
         AC34hg9uc2WIKfqqey5laYAqbn7Wg43GzPiH5PA0S3twSemckju7s8NBrtREmBGQZ18y
         RisqVlQ+5a2BSwHhYK3QwdFzTyltlGTcv3iD/x547E8L2bB/hs/fPaGwz9mYe0bR3cby
         KZIMEucNwh99V2Ez0kXHCCJQKTq9rol+qOKrQ4yzoQSW5H+nuKG514afsHvCuwPSeNvw
         zGXFkVYK4UxfoaJjbS8aXh6Rfr1RL1DRGixZlEtRV23+W5xJ1d2lvRAAZJA+kYI8Lao3
         4+QQ==
X-Forwarded-Encrypted: i=1; AJvYcCWNJq4gZrV/+ZDBflnyz41O/VXah/TIr5efKaXkXjkQlq4g6xUox+bXscdKuQTkMJO1OqOUVG3NXQw6PhCTknU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUcIZpALXtN216lKGl8UHghSTkh1TBh1VZR2YHk5LeX4H945O5
	uln0SvO1UibL9lL94RTPdBrxUS8vwNDn7VkvJN91y8Hl/tZvyRdtewsRYf8ZCb3cLE5OKWkYQnd
	4TPBZBr5c6Mdqedby5HMC4LycQnTPBgreLqojEVPpILL0wzSDx81Etb5FWsvuLD3QBg==
X-Gm-Gg: ASbGncuQjLlrczEGGF7oeEgplEvJYYm3Kwr9dWlxXum7TAJ/2vcT945cP6zyEUWdpYM
	7rvKopiVGZlk7vzXgM+L755qjTw3SboHBW8MahEsYib8jcssFFMH15OmGNuIkTT406okD1B3wXH
	pycsiv38jM927yorhnmVmcRIL4fdXkgbA+sOMujDL8N9dPCMBdrpktztTwiWmVB+cFuYR/Hd9YT
	vZ+UOJG6V+laiwGXlmW0vdbO2qeFR3O2WZXpUS5beOYFfjN3inJBk0TEPzc2+K4GDlOeZHZEXOd
	nNMmlYdqR3vG2trtlZ+XCAzgwwxwjwmK5o6Wuc2jGvfQrZ/9GN6C61q/KzjbDouiFg==
X-Received: by 2002:a05:6000:402c:b0:38d:b028:d906 with SMTP id ffacd0b85a97d-395b830da39mr1197676f8f.21.1741858640545;
        Thu, 13 Mar 2025 02:37:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFHvIc+eTQqAlF1+2P3Z2fgggj2iNqsracn6CCyYCJT454xBxSLuaRc9Q7eu4Ab6lnc9ZGgWw==
X-Received: by 2002:a05:6000:402c:b0:38d:b028:d906 with SMTP id ffacd0b85a97d-395b830da39mr1197645f8f.21.1741858640065;
        Thu, 13 Mar 2025 02:37:20 -0700 (PDT)
Received: from stex1.redhat.com (host-79-46-200-29.retail.telecomitalia.it. [79.46.200.29])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c8975d1dsm1531444f8f.50.2025.03.13.02.37.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 02:37:19 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Peter Huewe <peterhuewe@gmx.de>,
	linux-integrity@vger.kernel.org,
	Jason Gunthorpe <jgg@ziepe.ca>,
	linux-kernel@vger.kernel.org,
	Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH] tpm/tpm_ftpm_tee: fix struct ftpm_tee_private documentation
Date: Thu, 13 Mar 2025 10:37:17 +0100
Message-ID: <20250313093717.69270-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The `state` member in `struct ftpm_tee_private` is in the documentation,
but it has never been in the implementation since the commit 09e574831b27
("tpm/tpm_ftpm_tee: A driver for firmware TPM running inside TEE") that
introduced it.

Remove it to have a match between documentation and implementation.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 drivers/char/tpm/tpm_ftpm_tee.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/char/tpm/tpm_ftpm_tee.h b/drivers/char/tpm/tpm_ftpm_tee.h
index f98daa7bf68c..e39903b7ea07 100644
--- a/drivers/char/tpm/tpm_ftpm_tee.h
+++ b/drivers/char/tpm/tpm_ftpm_tee.h
@@ -21,7 +21,6 @@
 /**
  * struct ftpm_tee_private - fTPM's private data
  * @chip:     struct tpm_chip instance registered with tpm framework.
- * @state:    internal state
  * @session:  fTPM TA session identifier.
  * @resp_len: cached response buffer length.
  * @resp_buf: cached response buffer.
-- 
2.48.1


