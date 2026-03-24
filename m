Return-Path: <linux-integrity+bounces-9045-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4BhcFGI+wmmCagQAu9opvQ
	(envelope-from <linux-integrity+bounces-9045-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Mar 2026 08:33:54 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DC73530406D
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Mar 2026 08:33:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EEDA0308C818
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Mar 2026 07:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9577D3D3331;
	Tue, 24 Mar 2026 07:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tc0tOJbq";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="kKl7P/PE"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695FD3B7776
	for <linux-integrity@vger.kernel.org>; Tue, 24 Mar 2026 07:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774336712; cv=none; b=I/B1DQUv3dbwM3Qgz187VhDYcuzat6+GeuDUBjwAOYMorMf8Zanpmj3ZKOOolfqAvf/mmDnCh/SOUhnMQoqUCg45GNo8dZRqfr+RhnUyWPozqoRJB0xQoPfrZTlNrTRug9qnQQ8qMis/zAHDpNWRctAbWxdkM35pTjIMRr/42YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774336712; c=relaxed/simple;
	bh=c0+CCyqLqsT7uXnMFtpyj6HXU7Tg8neMyPe+lwo9mkw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JKQRVHDP7i+uV/01yWxX0FA7lLQT4+wdL+tTg+qNJx09/rtiEFxK8QHYDfyZKST9Un6SdNut0qKQCq3iIOuoru60jxAEPhZuu1w6UayLbkP8ya5IdzGErANvkcgxaE/CzBqz8r0KGkE5VZYndvx1G0ShdneLR/L7H3KvN9ielkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Tc0tOJbq; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=kKl7P/PE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774336701;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jRDEOhjwb87Ldqy0HhU0WTQjTdVi/IKgvfuMA4qMFms=;
	b=Tc0tOJbqOaLsrYdKATVHRHpTp7eVuEuyQUHsQRGWw/GHYxzShFc0tnoAkQ0QFSs/MM0Oxj
	7psJRNou33cCqVAEigzWhMoDlsrfPDpQu35yLg7vSbp+35HNhLowcTT9ebH69HArKuxgim
	xSpKxY2stfaK42gUaiQmtlrWil2RzJ4=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-22-a-RPlrgENzqRUINp3MavoQ-1; Tue, 24 Mar 2026 03:18:20 -0400
X-MC-Unique: a-RPlrgENzqRUINp3MavoQ-1
X-Mimecast-MFC-AGG-ID: a-RPlrgENzqRUINp3MavoQ_1774336699
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-82c661d6a0cso106438b3a.2
        for <linux-integrity@vger.kernel.org>; Tue, 24 Mar 2026 00:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774336699; x=1774941499; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jRDEOhjwb87Ldqy0HhU0WTQjTdVi/IKgvfuMA4qMFms=;
        b=kKl7P/PE7exOqbbERAUrMa8XjizDi+LZoBKJb0fiAUCgkzVKyWpEN2brJik/WoG4rd
         iUHg1mGuti4+55CdiO4+YIn5U6fynOQIi3e7/D3xczhUTG90lFTKT4T2Neogi3lGqeot
         bOI68m5CKig+vudAsV8/6KJdV2+g7vRGwZ8GWXBF1KK5c8X+Ly6eKJqyY1i3HMx1u+8K
         tWuZpa6joKRyFDtdskcXj77poOnFymP6kLNe9C95P7D5xDoSvYA4p1BqmmUf/MjOvKjI
         21MZYbdPc9iPeFwIqHvE6yzArgLQdMiBX82ecRIJZRB/FM/GqimieT4PYBNR39sQGzAK
         esmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774336699; x=1774941499;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jRDEOhjwb87Ldqy0HhU0WTQjTdVi/IKgvfuMA4qMFms=;
        b=CZniDBucpjsDY6y431kQ/t1xMKLDBCQ20NTl9tgWsyIFexyLv41UdYqGZBiUW2CDc5
         EQ/LXI65AqSeZ0Qwowd8GH3gX69mKrOjspwXrBZuZLaoQgNQOEaZ0rePgQoWC4IXusF6
         aNOyeCiIQ94pZ3WTxzbmKtONLRP4/BUntlVMdvxEu8P2K3ZBtvP7az5waHme9wcHcJY9
         aCtKBjnojY7kVeRWazJWACN4vKEgP+YsVceq9QDvXd5kD6qqkaJUSc1iMJOS7+89nYSv
         k788ivDA8+7gqDoUnpgsq1N3cl3YZvVz3J93oZJFPAIjGa1IOP/7zWRbU4vZmc5HinyJ
         tc9A==
X-Gm-Message-State: AOJu0YxyjWvK2L7x+Pzu9Jlv/2trAYx5Tr+T2DvMm1aLhBgKYfdejhmj
	g4GZ2ZWMv7f4WU7prLOzwgjC5dBQ7IX1pTtGcY3Ncn9vuY3gQJL0UwRY0cs1HvSGK2P247tRvKg
	jUaOMshSrvKDOR1CcIvH14j5VzSEAlnEtq7dmQ85iNLNkG+aAmMio3LOi8qH2mhXUaVdP5u34SZ
	bTqA==
X-Gm-Gg: ATEYQzwm+AVH1+TDOIdJmZfUZh31PaSc//rm8qRs5A0SgwmbWXiJRx5TyNevDrC1nLj
	BCybBgqtBCl2q78BLhFN2UpFJobhyaaj4daSs6OhHUi+lRZAA1TRouhKahqItklS+Uda+DvigZW
	7ILXcqSIBLiAW/K0Jvi1RkUSmHwbd+QUfsOWZuRjJ0J5D+icRSjB9cu8mtzwR+/0vQ/e5Me+/Jp
	zigOvSey3PzJJB7+ilpdcvzI5QwjdQ8Jahe1qVkuc9TBXDwbHdhwHASxXMXu/k+wRi1c8qc3IUS
	yBfFxCtH/NbJI/74gqislZYL6J4d9/nyKUMwuUJ01wSpgS/jxhK07kvusysW5iO/laA0apTiJ4g
	YmtShwylmpil/DTZIC+esxJb0lzrYFnAuCetqpxehtB72GJ3YfhYZskBlFQ+u6A==
X-Received: by 2002:a05:6a00:1d13:b0:81c:717b:9d39 with SMTP id d2e1a72fcca58-82a8c3a5119mr13438039b3a.56.1774336699034;
        Tue, 24 Mar 2026 00:18:19 -0700 (PDT)
X-Received: by 2002:a05:6a00:1d13:b0:81c:717b:9d39 with SMTP id d2e1a72fcca58-82a8c3a5119mr13438016b3a.56.1774336698637;
        Tue, 24 Mar 2026 00:18:18 -0700 (PDT)
Received: from fedora.armenon-thinkpadp16vgen1.bengluru.csb ([49.36.106.26])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82b0409c681sm13597766b3a.37.2026.03.24.00.18.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 00:18:18 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-integrity@vger.kernel.org,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Peter Huewe <peterhuewe@gmx.de>,
	Arun Menon <armenon@redhat.com>
Subject: [RFC 4/4] tpm: Increase TPM_BUFSIZE to 64kB for chunking support
Date: Tue, 24 Mar 2026 12:48:03 +0530
Message-ID: <20260324071803.324774-5-armenon@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260324071803.324774-1-armenon@redhat.com>
References: <20260324071803.324774-1-armenon@redhat.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,ziepe.ca,kernel.org,gmx.de,redhat.com];
	TAGGED_FROM(0.00)[bounces-9045-lists,linux-integrity=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[armenon@redhat.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-integrity];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DC73530406D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

- In tpm_common_write() the size of the command is checked against
  TPM_BUFSIZE. We therefore need to increase the TPM_BUFSIZE to allow
  support for larger commands.

Signed-off-by: Arun Menon <armenon@redhat.com>
---
 drivers/char/tpm/tpm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index 87d68ddf270a7..a6933eb075296 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -33,7 +33,7 @@
 #endif
 
 #define TPM_MINOR		224	/* officially assigned */
-#define TPM_BUFSIZE		4096
+#define TPM_BUFSIZE		65536
 #define TPM_NUM_DEVICES		65536
 #define TPM_RETRY		50
 
-- 
2.53.0


