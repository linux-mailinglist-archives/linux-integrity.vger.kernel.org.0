Return-Path: <linux-integrity+bounces-1622-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C29098744F5
	for <lists+linux-integrity@lfdr.de>; Thu,  7 Mar 2024 01:04:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 627B41F25B88
	for <lists+linux-integrity@lfdr.de>; Thu,  7 Mar 2024 00:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9C95800;
	Thu,  7 Mar 2024 00:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dKTUS1/m"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767644C92
	for <linux-integrity@vger.kernel.org>; Thu,  7 Mar 2024 00:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709769860; cv=none; b=s/ioYeyyss42DCsy2+ErGFu1xIzEAOXy6bcvoNfe1NXequPG4GbaNBh9cVBtOtM4C9Q761Q/tSHuU7BszQz0jcpHaIMvL4SKOePxqvwZK1VcNeUmq8xFsPbA654RlQh6UISysolPNUgmkb16uLclOog3eF+W1zNIPpI61vsJVzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709769860; c=relaxed/simple;
	bh=NAlBN9eq/tnws7dD5XRNk85z+kCby7uVtkZrGoLJHCk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gMnHqYbQnAWUiVvdfv2qzYlbQZRX+Pidfw/EKg0Pm26Niysm+glPwktGSmLgqE5jR/sZhbT14txyprROVrwKC6uQn1ByQH8dbrtuXDODvZueb7e8Vz/HGmv3iCbXK9kYJhxiYOz9iaeP73UMGQzFihe0dO5YorH7StUowpv4NhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dKTUS1/m; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6e6082eab17so296651b3a.1
        for <linux-integrity@vger.kernel.org>; Wed, 06 Mar 2024 16:04:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709769859; x=1710374659; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gS6wb4l9IGN/kdYMlSs03t9OAlQKjs0RkXsONaKgB38=;
        b=dKTUS1/mjOlkttDN2deeJqDlyvE1PPzF6qgHgH3RBEv2XNT9FoeNfTzhEJKtM3iOir
         jbW8NXBEWKbw1UhLmhIKPNJUv1lb6aOS4FaJbatC+G042m44Wg3/um9H2T4chlWUnLLd
         HpIiuZTZB2jyBgNfZnJtrRTW6I43icq4WOYcwcRjJ9WlRb4ijEDgYzIWK1IRBECp8afh
         jr1+Pln/ADZ9wRqfehyoA2GTZW7b1QILYiPOSx/jHSo6Yd29unu57UFKtq5aZRxj1gl9
         x9ITYWUBVTW1Znr5YuwmUVBzV9X90b2JUky9iyglkcQhv+Vv2Wgs97K7HbV7n3E0wdc4
         /qgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709769859; x=1710374659;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gS6wb4l9IGN/kdYMlSs03t9OAlQKjs0RkXsONaKgB38=;
        b=EEYBGo9YvRvzOyYMP8gCh0EMPu78nvRjWJMI3/BZTuWfvJ3N0v1MbXr9dJp8fTaeQJ
         D7FbmiikIOy9f6KWjnXe7B5T+88dEEKcoAxVL9wPBvtVPo/mWihb8sCPrQhY0Z8RYh7t
         7GW+Rn7oBeaRyFsasWGjiRymMrFY4aC1K0ybpWKnKeXZY018et+lrltVTODCZBmMTXyy
         GEe4WkNZT1DFOMrCSeVJml1O1iQtJr37BjPRwxBxFl7gsiGFq4sbXmey3NsIz3z8GLVR
         MOJTm1GPYAwuB67ssdE2QCP5M7g8LXTxOSfZh54OHCs8rs7lwTCvRsUbXaHpHI5l7TqR
         RwUg==
X-Forwarded-Encrypted: i=1; AJvYcCV2TMrQEyMVHbXFA9sqUNu6fo0dObJcRtwNmFc92camOnOY29sXl9FWGs1swSjpRfqrSNhnZ3JxVBs7YW1hRe8ElmpOi/+BtA44h5wYnFol
X-Gm-Message-State: AOJu0YzNPth4lxAtRipwezpcEkjMCKk8/Nrkz+hIv3D9u2DOMBxWWYq3
	Cqe+3eRtXHJzaeJ/H6vJQGyVxKjcOV/biNaEzxuFB1QoX7hS+POJy3sUIkWa
X-Google-Smtp-Source: AGHT+IGxGOeIre7GPjHB3gBrBBJS0LAGRqRmV+LDswVeFJP255Vs2c7MchU0CZLf/zptLniMUfQrZQ==
X-Received: by 2002:a05:6a00:1955:b0:6e4:aca:ce0d with SMTP id s21-20020a056a00195500b006e40acace0dmr17525094pfk.31.1709769858679;
        Wed, 06 Mar 2024 16:04:18 -0800 (PST)
Received: from fedora.. (189-47-54-93.dsl.telesp.net.br. [189.47.54.93])
        by smtp.gmail.com with ESMTPSA id x23-20020a056a000bd700b006e04553a4c5sm11387449pfu.52.2024.03.06.16.04.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 16:04:18 -0800 (PST)
From: Adam Alves <adamoa@gmail.com>
To: Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	linux-integrity@vger.kernel.org,
	Adam Alves <adamoa@gmail.com>
Subject: [PATCH 0/1] Fix TPM chip hanging system before suspend/shutdown
Date: Wed,  6 Mar 2024 21:03:30 -0300
Message-ID: <20240307000331.14848-1-adamoa@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Fix hanging before shutdown/suspend behaviour on some buggy 
platform firmwares.

Adam Alves (1):
  Some buggy firmwares might require the TPM device to be in default
    locality (Locality 0) before suspend or shutdown. Failing to do so
    would leave the system in a hanged state before sleep or power off
    (after “reboot: Power down” message). Such is the case for the
    ASUSTeK COMPUTER INC. TUF GAMING B460M-PLUS board, I believe this
    might be the case for several other boards based on the bugs I have
    found on the internet while trying to find out how to fix my
    specific issue. Most forums suggest the user to disable the TPM
    device on firmware BIOS in order to work around this specific issue,
    which disables several nice security features provided by TPM, such
    as secure boot attestation, automatic decryption and hardware random
    generator.

 drivers/char/tpm/tpm-chip.c      |  9 ++++++++
 drivers/char/tpm/tpm-interface.c | 36 +++++++++++++++++++++++++++++++-
 drivers/char/tpm/tpm.h           |  1 +
 include/linux/tpm.h              |  1 +
 4 files changed, 46 insertions(+), 1 deletion(-)

-- 
2.44.0

