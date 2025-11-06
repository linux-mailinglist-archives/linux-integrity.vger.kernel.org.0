Return-Path: <linux-integrity+bounces-7591-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C61AC3C7EF
	for <lists+linux-integrity@lfdr.de>; Thu, 06 Nov 2025 17:39:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5016D502FC6
	for <lists+linux-integrity@lfdr.de>; Thu,  6 Nov 2025 16:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 773D3261B65;
	Thu,  6 Nov 2025 16:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="EMWAvVSo"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694912BE7B4
	for <linux-integrity@vger.kernel.org>; Thu,  6 Nov 2025 16:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762446490; cv=none; b=CFyY4Cs1YySK953kVdK9fDUcwA2s6A5B5MrVAPCUKHxUmEYZg2W7Vtat3mM5ObjaLtoyllfZWm4utXA5tEF4NL3cgemramld53K8t6UBGJxmCuZ9LycoFJ/Zn6Xezc5Avv6J3mZYkiN5IYrm2iRs4DJUSgno+Aaa2Vrjj25QYus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762446490; c=relaxed/simple;
	bh=NxDsSZFL8xp8CNCIpuxRzByCgFIhMyI3+Xgm52UXPE0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SJKfhtpMoCCBuYI1AJMGjzm1nY0FxYxJ3OdzdnK7h8DN+gICDHqjgLnozZ5H18m52nZf6z+/JUpZARJSDlTpRZX2Kqj9jRufGrBrECLumz583iUpi+A7HsQqtxSM7o5Xsp/fBnGXL7iF+BDte/hSN2lgiTV4U5CBlmN+Y6g0SI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=EMWAvVSo; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-421851bca51so955741f8f.1
        for <linux-integrity@vger.kernel.org>; Thu, 06 Nov 2025 08:28:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762446487; x=1763051287; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YPiFUP87SgjGnyl9xYsEHrafdTSjoceBL1CQjrWm6UE=;
        b=EMWAvVSoE2QTm5kMrRX0ACJm93lClxghlo2UWgG2xfRlhLT0DnUFjCWsLjENn+jbzu
         Jz5165e0ges8Z7dQcDtk0252ghaDfi1uMkf19eKU896CYmz+sIsNetwG90/tiERnwj/r
         tTW32outsEasAXSB+3f4/utBGLK6sl0PU3ERnkKgJfZMesX0coXVBbMrOk4wLC+2eXQf
         QMP0z8Tw0Nk6wEJ61QB4si0Wasm5w5e4tjGyujkQWynBz4knRi1rUivG7cwJam9+ZFWv
         Hi2FmFEwkOeHRMfXPp9etJOXTmQ/ufb2w2sLbLjDFAE9hizTtNUOFVZd0u8vYCsWWKfw
         YM4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762446487; x=1763051287;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YPiFUP87SgjGnyl9xYsEHrafdTSjoceBL1CQjrWm6UE=;
        b=d3MloR2vucwZpCMX9p9NzPlfwJXAItpwyG6UC7vCQ241PdU3ibgwY3vwDCsrSSVX8T
         OJVu0Nfe3Ujm72kpGu+cw99ZngOTyyFTP//q82MNo/LEOTv3Oct2dEfb7pelYeLyHLuJ
         wGNsCWfKTWcgrxBeMpq2D1ZNAIACzAibksnUO0lzVQLzWvb/5cdZtKJ+NbGyPP/jqWXV
         2PkE61vnGjZUGjNBYzPNG/qhbnUZ/Bcy0k/0lUvbD4gtwreNXL1P7R1z4uILus9F4IdG
         7ULrebo5aKnY2Ca9um7Sp0meI3u713Mgt7WJTOMicNpZD/Kw5s52wFzoYDyLAIUpiuFJ
         FraA==
X-Forwarded-Encrypted: i=1; AJvYcCUUc77joi6WQyT4l+RlkC7aXcr25U/qo80MHO++xac7W1K2l2vhwqkuBeCC+GqZCl8JmjBBMt+Sv5P4zJSHeJg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4tig7jI1HsSHmNOwG9nFNpSC505FS9uLqWm4qG76QN2Jmkawx
	FngaCOdrIIf3lZEmDvHiDIXAn8I/UZtgjqX3c7LQihcuU0HKsPsYecF5Ysf/0gHOmy0=
X-Gm-Gg: ASbGncufi4VlMpkOQX4rGgdSYRD8u6QCVT/w8DBqe72R3pz+Fpz0pgwc+8KHbbRFufr
	0jkyNin523cd7avwNQ0JeF5PHxrtUe3eMrCBC9nHCtTJrdYKhxywH2fwCYqgvRPngoq8fc0L8Gl
	ObZCjqaXXEftyK1vJ18cIlxtQGr7LTFrdKVsbTJhYqrbBkzua6AuBZ8hWvRpdVlVurMvCNeUWxG
	EJm2c5Le0tccsUCGJJ/mTNG4flgMHjp5jlkdHBJrNUyfqk37GBjRYK4ntRP/pqjf7R9GVs6Qi6I
	yq1zSvSCHWNssqQj8zu0CWltKhIWUDnuLJvpmeOLyrBWKqRU3G+QQ7UKYZLA/mD5UqDx6GIEsaJ
	Tv7GEpRCxClTgUL9kSE/Hph8Y4Xv63MosJ+cpKYjyQqyr+drPDK1aWFvzw0Tg7SGzyZ3l1sbu+Q
	RFXERGpDSspZiWnAKh9j2m1xI=
X-Google-Smtp-Source: AGHT+IEnCMR/0gFgC+aRgL0DQFaOpikSi9W1p59m6FuSKz4Wza1crlEKVQ0M3IW4PxvjEDVxvulglg==
X-Received: by 2002:a05:6000:2012:b0:427:a37:ea3e with SMTP id ffacd0b85a97d-429e330ae1emr7388139f8f.52.1762446486625;
        Thu, 06 Nov 2025 08:28:06 -0800 (PST)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42abe62bf4bsm11047f8f.8.2025.11.06.08.28.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 08:28:06 -0800 (PST)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-integrity@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>
Subject: [PATCH] tpm: add WQ_PERCPU to alloc_workqueue users
Date: Thu,  6 Nov 2025 17:28:00 +0100
Message-ID: <20251106162800.331872-1-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Currently if a user enqueues a work item using schedule_delayed_work() the
used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
schedule_work() that is using system_wq and queue_work(), that makes use
again of WORK_CPU_UNBOUND.
This lack of consistency cannot be addressed without refactoring the API.

alloc_workqueue() treats all queues as per-CPU by default, while unbound
workqueues must opt-in via WQ_UNBOUND.

This default is suboptimal: most workloads benefit from unbound queues,
allowing the scheduler to place worker threads where they’re needed and
reducing noise when CPUs are isolated.

This continues the effort to refactor workqueue APIs, which began with
the introduction of new workqueues and a new alloc_workqueue flag in:

commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")

This change adds a new WQ_PERCPU flag to explicitly request
alloc_workqueue() to be per-cpu when WQ_UNBOUND has not been specified.

With the introduction of the WQ_PERCPU flag (equivalent to !WQ_UNBOUND),
any alloc_workqueue() caller that doesn’t explicitly specify WQ_UNBOUND
must now use WQ_PERCPU.

Once migration is complete, WQ_UNBOUND can be removed and unbound will
become the implicit default.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 drivers/char/tpm/tpm-dev-common.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm-dev-common.c b/drivers/char/tpm/tpm-dev-common.c
index f2a5e09257dd..f942c0c8e402 100644
--- a/drivers/char/tpm/tpm-dev-common.c
+++ b/drivers/char/tpm/tpm-dev-common.c
@@ -275,7 +275,8 @@ void tpm_common_release(struct file *file, struct file_priv *priv)
 
 int __init tpm_dev_common_init(void)
 {
-	tpm_dev_wq = alloc_workqueue("tpm_dev_wq", WQ_MEM_RECLAIM, 0);
+	tpm_dev_wq = alloc_workqueue("tpm_dev_wq", WQ_MEM_RECLAIM | WQ_PERCPU,
+				     0);
 
 	return !tpm_dev_wq ? -ENOMEM : 0;
 }
-- 
2.51.1


