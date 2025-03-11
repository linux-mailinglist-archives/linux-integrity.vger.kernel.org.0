Return-Path: <linux-integrity+bounces-5222-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9195BA5BD18
	for <lists+linux-integrity@lfdr.de>; Tue, 11 Mar 2025 11:01:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74290175689
	for <lists+linux-integrity@lfdr.de>; Tue, 11 Mar 2025 10:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EE3522B8D9;
	Tue, 11 Mar 2025 10:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JcFLopar"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6554120B208
	for <linux-integrity@vger.kernel.org>; Tue, 11 Mar 2025 10:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741687306; cv=none; b=ElI8yG8Dm5Sm+5+kUsIFYCJE2o6Z7qyX9nxsUCzIcJX6E/JleMryt/W0Msx2sn/e0r3dzSmPFyYrerbkwTKTUmNR/vgyMY38HA9uAXhrks+ygGOZn6DiN9Ee8OLaWG0wOVJQ2/ZVoyn8mkzbcU8b+oS16B4tCLZo7HKAaqIbKiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741687306; c=relaxed/simple;
	bh=nWPAfhRPvyOxhsczSmiyOuKDVYDhl25/eaHP1Fif16w=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=LMcgxtQ8vLZW8gmsG0wKSq5MlTikjo28zUC2bd5TVsuoLqVs9KoVEyh9qGUBoU9ZE/Fr6qY/UDEesNvWQkZAIPmwYJj6CgHoGjQ5DQnTnCJCtzV+b5R1YiZzyX/J0SrpKCU6VNLYMlEh+zePSD0AEWdV1moK+CuePOmdlACAWvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JcFLopar; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741687303;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qp4CrAYKQo+4LRd4xuzYXPfxibVR96LFmVo4qXJtxW4=;
	b=JcFLopar/V5SUm0PdNvW7HhCFQ9U4SaR3Vf8Mjv0czSPmBH4+Bvus65TvpSaus5RpfwxXV
	Tv1/E88f0tp0voF5KxbAK1ZwkGwyBCafqF2bR9AwxgbQjbyhcFOq8/EtxeNEubu7P/0UwJ
	oABx2Ojzjl8CojHGGgn7LqXBvx/GvVM=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-546-e9Ud0fUOMpCzesd_b2z13Q-1; Tue, 11 Mar 2025 06:01:41 -0400
X-MC-Unique: e9Ud0fUOMpCzesd_b2z13Q-1
X-Mimecast-MFC-AGG-ID: e9Ud0fUOMpCzesd_b2z13Q_1741687301
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5e5b65cda33so5608836a12.1
        for <linux-integrity@vger.kernel.org>; Tue, 11 Mar 2025 03:01:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741687300; x=1742292100;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qp4CrAYKQo+4LRd4xuzYXPfxibVR96LFmVo4qXJtxW4=;
        b=tab/ACwXrvClrv8toQFeoODp3uFp8iW5x5WUN2bGfdAjErjZwBCxNltmUpTwnVVN0U
         mPUsiANmd7K8wpkuL8GH2eSREv8X0l76jkIcmqpfwM6EZtU081INebPuyl+gL/zl5EHh
         zGKO76Ay6dJGdOn/82oCxDpgoDgPAr2dekLTP2yWnmb8le0H38r2T3XBfkX3YprvlLqX
         WJXC7/jq655hqf66iVems3FEvFslrig2HaexbR0OabMKxwd8CNWj+CyiebBNPtmPMmAd
         CdSHRJB3kjIWPkvKdmGoCvzxyoCAZMCICsh9zCNWdlXAqd9q0bM14fEBH5xdPeeTmaDz
         D/8g==
X-Gm-Message-State: AOJu0YxQ7OXdhr3MqPBRXF4OmdtMvytxCix0Xiid4fwuGR0zRtFDjUkt
	CzddFe3FMX5rls8aAP2nJSUKCVkGpQYc8O2PQfd40gYmrJmZ88DcR7oFZjB6VD0cJPKydNfHqrb
	g8PuJBn0VUwINx3DnthO88rCBQ8YpqHsCroGBiVLhZamkEwpjFdiXaF+JYSFZRDLAPA==
X-Gm-Gg: ASbGncsIp5nHoadPyvYZSNZZ65h9ruq81cypsxcZrIQ6UeflMP4Cgg/T6Y9zdvoOeon
	ug1mxyFTfk49FAahNRwQWiJOjG/jqwD/VjNtFRQhMMD9HqA+RerA/6Hi2a4lklWWgOAWJjpWBcV
	OsX+FbzW+z41yTMb7T3F1NPCv63L434zpWw+94erUti5h4H84LAOp+5ZWHhGkdC3Yq2o+hbamje
	mTPtjszAVX2fqwCuEFWU6/MH2vw7R2hnMfjLyKmAliGJLJ3yFiFptNn7n6fKfp8c9STIS6JnxwE
	S2hS5ovBV5mp6BmvbZGTmzUCfRAmDoNnyqBXy4d58BtvT3cHXeytjKzfZaOEnRpbJoshD1tq
X-Received: by 2002:a05:6402:3589:b0:5e0:8c55:501 with SMTP id 4fb4d7f45d1cf-5e5e22a9443mr17057919a12.7.1741687300641;
        Tue, 11 Mar 2025 03:01:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEjv/+3Hnz070c0jpTEuZGKRv3YWN2bvgQrRUiPNEroDj7rznpBt9RarcCiL+T4rK0S1nXivw==
X-Received: by 2002:a05:6402:3589:b0:5e0:8c55:501 with SMTP id 4fb4d7f45d1cf-5e5e22a9443mr17057856a12.7.1741687299960;
        Tue, 11 Mar 2025 03:01:39 -0700 (PDT)
Received: from localhost.localdomain (host-79-46-200-29.retail.telecomitalia.it. [79.46.200.29])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e5c766d0e0sm8344611a12.64.2025.03.11.03.01.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 03:01:39 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Stefano Garzarella <sgarzare@redhat.com>
Subject: [RFC PATCH 0/3] tpm: add send_recv() op and use it in tpm_ftpm_tee and tpm_svsm drivers
Date: Tue, 11 Mar 2025 11:01:27 +0100
Message-ID: <20250311100130.42169-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.48.1
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series is a follow-up to the discussion we had about whether or not
to add send_recv() op in tpm_class_ops[1].

Some devices do not support interrupts and provide a single operation
to send the command and receive the response on the same buffer.
In order to simplify these drivers and avoid temporary buffers to be
used between the .send() and .recv() callbacks, introduce a new callback
send_recv(). This was suggested by Jason Gunthorpe while reviewing
the new SVSM vTPM driver, but the same callback can be used also for the
fTPM driver to simplify it a bit (second patch of this series).
I only successfully compiled fTPM, but I don't know how to test, if anyone
can test or suggest how to do it, I would be grateful.

This series is based on "[PATCH v3 0/4] Enlightened vTPM support for SVSM
on SEV-SNP" [2] (actually only the last patch in this series).

[1] https://lore.kernel.org/linux-integrity/Z8sfiDEhsG6RATiQ@kernel.org/
[2] https://lore.kernel.org/linux-integrity/20250311094225.35129-1-sgarzare@redhat.com/

Stefano Garzarella (3):
  tpm: add send_recv() op in tpm_class_ops
  tpm/tpm_ftpm_tee: use send_recv() op
  tpm/tpm_svsm: use send_recv() op

 drivers/char/tpm/tpm_ftpm_tee.h  |  4 --
 include/linux/tpm.h              |  2 +
 drivers/char/tpm/tpm-interface.c |  7 +++
 drivers/char/tpm/tpm_ftpm_tee.c  | 86 ++++++++------------------------
 drivers/char/tpm/tpm_svsm.c      | 46 ++++-------------
 5 files changed, 39 insertions(+), 106 deletions(-)


base-commit: f2cb83b7f8c58952b424a83bf86680f1263ad417
-- 
2.48.1


