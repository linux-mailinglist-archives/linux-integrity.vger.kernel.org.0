Return-Path: <linux-integrity+bounces-3779-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D4169981E8
	for <lists+linux-integrity@lfdr.de>; Thu, 10 Oct 2024 11:19:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 462A61C2670F
	for <lists+linux-integrity@lfdr.de>; Thu, 10 Oct 2024 09:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5801B1BDAA0;
	Thu, 10 Oct 2024 09:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EkSIHNTk"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84EA71A0AF5
	for <linux-integrity@vger.kernel.org>; Thu, 10 Oct 2024 09:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728551784; cv=none; b=idUYeXH+vr6rS+DOTqDf0To1wtPkj+bmvCcQ4Kzw5IvATzC1MDw6NHVRY7N/ByH0heZ1w5ffc+W3efhP9YIgoBip0fs6eVYj/AMTyh8VmfhOLyLShSu+iJ1n+mHdgPmu+FAKa7kyvpRCgn9aypkcTUk6bCB//L2ZkBQglm9kI1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728551784; c=relaxed/simple;
	bh=EO/fJ5gxawdwHd6z275SjhTP+0iWL961IIKeWy15XJs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pERPOKU2NST9CrbEqI3TUj5nPo0sYyzLf200+z9Kxe8c0dj7epzbgAX01RbOAEvBa/KRRDyNC4VJwK0va2uFA6Eqgtz66GPT/ri9qnA0g2KS7sL03s1IBpjohzLDC8rYoxMdnjy3CYrNESgPPttH1PFD/qt2Z53Fe4mil2SEAgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=EkSIHNTk; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43118c9a955so2952605e9.3
        for <linux-integrity@vger.kernel.org>; Thu, 10 Oct 2024 02:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1728551781; x=1729156581; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Hn61sT4RcQBO3g+5Fw/xbaPw1uDG6B3Lg71XIa3mow=;
        b=EkSIHNTkXY6EMxhUWyUFBxLUZGTbxLHo1lMkbWmwB3laYq87L6Ni0hQvMaElbxf4+I
         2LqQq0klQLkxtENjZtV/134guoVpD6/U0ve0eqrGGpMy9YNLj0X0jyfgBcjTD1cmB0QH
         jXMhMecNKW/waVmMDAFLZCExnK/BFxdObBeOg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728551781; x=1729156581;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Hn61sT4RcQBO3g+5Fw/xbaPw1uDG6B3Lg71XIa3mow=;
        b=b0wXyAz9fA/JA+ITe+FP+tp9W4GedTK1C42n4ZQRA0MiXbYxXx0aGFI9PL8U8HMB95
         EHY+byePXNbPYERS1v1XGyoDxzZmx/mZVSp8TcJIMLwNm23ngn5Rlb1tPCiKDgnXexC7
         bTph8gPzeQM+gWpe9ri+RfccXVmtKhjtSdQvgbovkdD7GVxC2e8T/qRO4gitNj59gyGA
         cBFcCwgi9mcZ9Kn5T7a0YUVBLLCL+4nJUOMGH7vTA8ZL8QUfLYCu5pRUfRJiv81ii8EQ
         DTBKUgnIipq3f4IlFIFZHUc3RH+xt986p8ys0NRRE6FhnwS1wJOvBU/UfKl+8a6As60S
         iBlA==
X-Forwarded-Encrypted: i=1; AJvYcCWNkGXPsU2cGADFiII44TNRVzCsnuTvYMPoJ4xUkWpHe+2D/QCOWorSWEnciaftpEPmBgko9eSBGHn3c3ZzKZw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEwwUD5hqr6f2VjPUmIL9KFU+IQJWH1PRKyeV6CIWjkzocJj0p
	UCjcUVQpefSLSfzbtIhdKTZ027Tohf01MUHdyDVgOAkpSlaNVlK7pu7iiejOgA==
X-Google-Smtp-Source: AGHT+IGsc6ZWOKmMT2C6mmCpBSJNpa6cqmQkvDPQ6WfR1nHR7R6PDd1IVvFXqajvxsApCJ88hYzafg==
X-Received: by 2002:a05:600c:5117:b0:42c:bcc8:5877 with SMTP id 5b1f17b1804b1-430ccf1c2cdmr52396985e9.13.1728551780860;
        Thu, 10 Oct 2024 02:16:20 -0700 (PDT)
Received: from localhost (216.131.76.34.bc.googleusercontent.com. [34.76.131.216])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4304efc0460sm71604375e9.1.2024.10.10.02.16.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Oct 2024 02:16:20 -0700 (PDT)
From: Grzegorz Bernacki <bernacki@chromium.org>
X-Google-Original-From: Grzegorz Bernacki <bernacki@google.com>
To: jsd@semihalf.com
Cc: apronin@google.com,
	arnd@arndb.de,
	gregkh@linuxfoundation.org,
	jarkko@kernel.org,
	jgg@ziepe.ca,
	linux-integrity@vger.kernel.org,
	mw@semihalf.com,
	peterhuewe@gmx.de,
	rrangel@chromium.org,
	timvp@google.com,
	Grzegorz Bernacki <bernacki@chromium.org>
Subject: [PATCH V3 0/2]  char: tpm: Adjust cr50_i2c locking mechanism
Date: Thu, 10 Oct 2024 09:15:57 +0000
Message-ID: <20241010091559.30866-1-bernacki@google.com>
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
In-Reply-To: <20221101020352.939691-1-jsd@semihalf.com>
References: <20221101020352.939691-1-jsd@semihalf.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Grzegorz Bernacki <bernacki@chromium.org>

This patchset contains two patches from original patchset which have
not yet be merged. As per original description:

This patchset aims to add support for a platforms with cr50(tpm) i2c
chip shared across two CPUs. We need to provide a mechanism, which will
allow to synchronize accesses on a TPM-transaction boundaries.

These two patches are modifying cr50 to use generic callbacks for
locality management and then leverage this solution to apply i2c bus
locking on a TPM-operation level.

Changes from V1:
- add dev_err() and return instead of WARN_ONCE()
- correct returned value in tpm_cr50_i2c_probe() functions
- I did not address Tim's suggestion to return 0 instead of loc
in check and request locality, I would like to follow convention
from tpm_tis_core.c file 

Changes from V2:
- remove unnecesary locality checking

Jan Dabros (2):
  char: tpm: cr50: Use generic request/relinquish locality ops
  char: tpm: cr50: Move i2c locking to request/relinquish locality ops

 drivers/char/tpm/tpm_tis_i2c_cr50.c | 114 ++++++++++++++++------------
 1 file changed, 66 insertions(+), 48 deletions(-)

-- 
2.47.0.rc0.187.ge670bccf7e-goog


