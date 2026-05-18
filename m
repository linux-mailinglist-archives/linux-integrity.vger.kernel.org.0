Return-Path: <linux-integrity+bounces-9596-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uGbzEKwtC2opEQUAu9opvQ
	(envelope-from <linux-integrity+bounces-9596-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Mon, 18 May 2026 17:18:04 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E70E56FC39
	for <lists+linux-integrity@lfdr.de>; Mon, 18 May 2026 17:18:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3DBB1301220B
	for <lists+linux-integrity@lfdr.de>; Mon, 18 May 2026 15:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5077B37755A;
	Mon, 18 May 2026 15:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tb2Y8mO0";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="YAZ96yHO"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA5736DA14
	for <linux-integrity@vger.kernel.org>; Mon, 18 May 2026 15:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779117478; cv=none; b=ay51cJDbHCKExkYFr2zj3dObSWuIv3Xklu3RrXg2+D7nnwnC/rDR9CiEXD9BRQk+HEQa4mnT6nHCbfrmIWA1ZdoRh5+Vpn3GOSrDeUWiebaXwWb67z6gTdMuXblzta48dqKVL8lDPPL/Xx64Gt996zGtJtLjxJNSsb4W8namrjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779117478; c=relaxed/simple;
	bh=7mc0+0o7LySHifhkyRGcSW/V20zw7yVVpjyNvNY0pyE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fs7wtLvc+/t0nc++tKR/kLGnNIfkam2Xec0SY8mZiXgupiWv/GHv1uLDsjWSA/BfwwDM47ByZDXQxinQDDeGSSr2Id7hqgWTvCEPkZ532G6Nsg9TtcKldzdzICtQ6iqgyeRmC0Q9YkLHRJwkyxWUGzqEJiF+n3oS46AqaUYVXxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Tb2Y8mO0; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=YAZ96yHO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779117473;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j2TI0MzanH3PuDuy5c7bqP5Hk/GS1GvGyRmHJgGaHX0=;
	b=Tb2Y8mO0G1KsA2i6q3OPqGMC565Guud8drUn8IJuJIiv/UDkA2u1ETge6v9mUsWvUqLubA
	MvgM/6HnLRBLEAxlHanzjIrZojkxRtpk6QWK3u8B1YtjxRYFSpeK1vFp8Evsoqc2p5NyTs
	1HzI2JOB3JckgKvuOzsoky/qfwbrS4s=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-UNx6HXhsMM-MKVK9dRidrg-1; Mon, 18 May 2026 11:17:51 -0400
X-MC-Unique: UNx6HXhsMM-MKVK9dRidrg-1
X-Mimecast-MFC-AGG-ID: UNx6HXhsMM-MKVK9dRidrg_1779117471
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c8279604464so3419085a12.1
        for <linux-integrity@vger.kernel.org>; Mon, 18 May 2026 08:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779117470; x=1779722270; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j2TI0MzanH3PuDuy5c7bqP5Hk/GS1GvGyRmHJgGaHX0=;
        b=YAZ96yHOlV6AsOvzFdWXv5mGqAPutaXpu6xxjo5HM/PqfT2CUOWJYpj0KiZxjb5PWp
         GWKjLNe0Gt2ahr9t8KHAy5qEedS6vVmWyr5hTf8Po79f+iN7DfZtbQMfbsvQ0yFbrOP1
         LrekFK9irf601K+6IaDEyy9mbjATLDQUO7ea6XdTEKHjHSiaxNWgTHQVqfJ4RMHWSG2t
         7xl8gY4P2PJAmMhiOFH5WN/Ag5RUxHulsm0CCAiP3ULfDaYNuU/tBydrdPJo8ib35rC8
         ojRPqAyS4ouRc7shgs3M4+aT2TwmJwuZruU1MVFeXz3cufoDDQ6ixI7yHGRspaiTmDfD
         g/YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779117470; x=1779722270;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=j2TI0MzanH3PuDuy5c7bqP5Hk/GS1GvGyRmHJgGaHX0=;
        b=gWeeNjy9PdLW4bXessIQiCBKgjtaNgANBupZRD9fIn6pZxtAFYWSHNYatpsIxpG/y/
         IPPzBz1o2nAXcxNUOZ+YJw/Z2xHoHjtzAFtJPVMN+7LUB7RGRmUZJy/bLy7Sx6iGEIE2
         K1ip/VHy9QbLqOILpvfDglIw0xwXZZIX2ZjcwSzatSuWKUFW6W8HBp4i1JHY/adiZfAh
         fbPFfPLKl6tREqyFDJFXkzYSDNz9wkq4yMo/0u3qXdH59ACGWmGuKXI9ntOXvumHRx00
         D3WSK8fd5wR18PdRReqr60lGmrJ4UlZRufRQboFZlBpznB46l99NrpuPobha126mglWS
         iMbg==
X-Forwarded-Encrypted: i=1; AFNElJ+LtJ5pUXMWuttnXaP015TyJ03hQiQcvBzjqgHByPYPSnlycCMi+2OAZcMWmAJdysgWgrWxH/nQpwwKXRaA84g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNjRNvzstfxKbmJfsW9HZv4S8MrNO9sLWwZIc+qUB9nF9XPcAm
	/CiBncmDgONJ0XbeHwhzuf0MAXtrEz10vOTOPLHGt8t9m9mXQ0gKE4t5hE2S2gGKZJKT7QrA7ZU
	lUvRoUNOs4IAgqXQUzXbmlQ/GeF1f9myg9hKgzEgK25P2dOk/R+kur2Xn70vTNc1i+SpqwQ==
X-Gm-Gg: Acq92OFIsLQCYGdvEJyAhM0ThtoUle50NkfHS969inRgbZct1G7yGC70r5KPxPGfSX1
	vwEWB1IQ4XBnRpQR5zJsrUuHyyHUyy59B6sdaD+TZMRL4XJuondjkjHRpx0u4NjFlXlTRoHuDID
	SrNdYft25BA0dy74gBnyjHJPEPVYgT1xDPfhr1+yQ1dqLAWWbjebXOjOSGvPy7ehVgxxooJOqj7
	iiMhdxzkBxACc07RNXDVjQ6RyFoUnAdFJecU+GtnNjKFByi4lEe0UuYW6y0uNceoifNDIFayul8
	rDKv3WIHvTfXSdgfWpg3UM0xqMi1gMq6Q80a7rclxoYgHoHU2hxLL8StGoWh4tQMRCayns3tufk
	7KboP91xDZpKV7GE+hxoq/pKaSEiMCWXiHL7eR6SKzkz3l0eB4Asnk4qbXb6CEd4=
X-Received: by 2002:a05:6a00:a221:b0:82f:7b98:e499 with SMTP id d2e1a72fcca58-83f33d9dcb4mr15964656b3a.31.1779117470460;
        Mon, 18 May 2026 08:17:50 -0700 (PDT)
X-Received: by 2002:a05:6a00:a221:b0:82f:7b98:e499 with SMTP id d2e1a72fcca58-83f33d9dcb4mr15964624b3a.31.1779117470023;
        Mon, 18 May 2026 08:17:50 -0700 (PDT)
Received: from fedora.armenon-thinkpadp16vgen1.bengluru.csb ([49.36.104.172])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f197815cesm18181153b3a.24.2026.05.18.08.17.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 08:17:49 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	linux-integrity@vger.kernel.org,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Peter Huewe <peterhuewe@gmx.de>,
	Arun Menon <armenon@redhat.com>
Subject: [PATCH v3 5/6] tpm: Increase TPM_BUFSIZE to 8kB for chunking support
Date: Mon, 18 May 2026 20:47:23 +0530
Message-ID: <20260518151724.730443-6-armenon@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260518151724.730443-1-armenon@redhat.com>
References: <20260518151724.730443-1-armenon@redhat.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,ziepe.ca,gmx.de,redhat.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-9596-lists,linux-integrity=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[armenon@redhat.com,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 2E70E56FC39
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Arun Menon <armenon@redhat.com>

The size of the command is checked against TPM_BUFSIZE early on before
even sending it to the backend. We therefore need to increase the
TPM_BUFSIZE to allow support for larger commands.

For now, 8KB seems sufficient for ML-KEM and ML-DSA algorithms and it is
also order-1 safe.

Signed-off-by: Arun Menon <armenon@redhat.com>
---
 include/linux/tpm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index 01216156a1ec..af2bfac45fe0 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -26,7 +26,7 @@
 #include <crypto/aes.h>
 
 #define TPM_DIGEST_SIZE		20	/* Max TPM v1.2 PCR size */
-#define TPM_BUFSIZE		4096
+#define TPM_BUFSIZE		8192
 
 /*
  * SHA-512 is, as of today, the largest digest in the TCG algorithm repository.
-- 
2.54.0


