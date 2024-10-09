Return-Path: <linux-integrity+bounces-3752-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64A409965BB
	for <lists+linux-integrity@lfdr.de>; Wed,  9 Oct 2024 11:43:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24C3B282E57
	for <lists+linux-integrity@lfdr.de>; Wed,  9 Oct 2024 09:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D402E18A959;
	Wed,  9 Oct 2024 09:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Nq6+H/jf"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C627189528
	for <linux-integrity@vger.kernel.org>; Wed,  9 Oct 2024 09:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728466993; cv=none; b=sEEsIAHtARTGJyOCpO8rmAuy38qoLxr/FU8Yoiu8fJrlxkrDBUzq2eSsrQmcCC/azRr8jJJZ+beci+83cI78QynopNcrB7qPT8MFLfKveDR4iTUsXBCrr6Z45xuSyU6JLonZ7VBXSnTWEZ+WFFTWkvmOGngMncgFma5cvkt9ipk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728466993; c=relaxed/simple;
	bh=R8Fpbs+IJnMKJ20FfmWTV1PCmAd/65i/H9+Ai95x1AU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bju24VTyFhgJfpRc31Vf0kAqbLF7cJCJWP1k031VFNEaGDpRjvoEwQD+9WrxYzTdjNGMeI84/Osvsc7UeLT474oVPztUaYKyxMyONGvJXqQkEmp46hq/F1B8CLaxy1191UxdRWYHg4E4tm6nGlbUeq4dTfZoONOUWHEsm8f/nH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Nq6+H/jf; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42cbb08a1a5so67593105e9.3
        for <linux-integrity@vger.kernel.org>; Wed, 09 Oct 2024 02:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1728466990; x=1729071790; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dYCcffVybIKhQ7agkyd0kgUK0/AlvIVahjbhgAABYFc=;
        b=Nq6+H/jfUSjaqCCV7aesrF/nslWWRVA/mEVyVocxYBLJsjCUf68TL89ULUCCOiy1HZ
         nlq80BPvjC6xHeRD1Pltw9Su5HlVGIYKBDy5Oo+MJncOMoiSe/hEoLpWwZF/Ej3JP1dU
         ydT5cZ4tPcutqgnAOZaHsPo+uZAzZ9a/4j/Ng=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728466990; x=1729071790;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dYCcffVybIKhQ7agkyd0kgUK0/AlvIVahjbhgAABYFc=;
        b=HfO49S0vVwQ+zbEpNf9txV7YJLY7kU8nqTuo05Ti0kmnzeCGoPMjWbHST6346INYSv
         NkzQI2dRiwhd/1k7RV72EqxH/QOfQ4duxsI+QtMFfhSPtd2dyQMtycaQZVauKyEQro2s
         0c8pqz5W2UX8QtnAlJs1QpdXJ5G7L+3OOLyyjRjRvi2T0ZuENKqK2P0Xd7CoTPyjfjF0
         brGLWwv0a1LjBA0Vo5eTS6sRqd2Jr5JNWombOHLleafRyPeUrFLNhQooZ09wqO5TgtkE
         PIG96BxGBB3WxcpltX0RNvg/nTyP1LT6lfb+7HT2UWSHrXzBlU9YQ6QP1vSYCX7YEOZ8
         N89Q==
X-Forwarded-Encrypted: i=1; AJvYcCWoybC6TJDqsCb/H2AOR7DjNRe9PWYlnxR59cH8/xsIHHeVUEmWoHfdGebNOvUuO4ADrgT/cptE4iziTnaW6hc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyja5CdmsVA3UOtWEnSalDVT+pXZq+iDIoTGy5hpWCnXRc5jq3L
	aSSyXSPFv11yJWijclXILoFiLtMOBtgWU55aRM+xImptW416m03FzrbafltILQ==
X-Google-Smtp-Source: AGHT+IHG90zXY3p0SxW5+6EjuqsdewIlt2tmich+8oNmtYPheI5brad0lWA2rcKE52wuXxFLmBXm5w==
X-Received: by 2002:adf:f850:0:b0:37d:f4b:b6ab with SMTP id ffacd0b85a97d-37d3aaeb04emr1075699f8f.59.1728466990500;
        Wed, 09 Oct 2024 02:43:10 -0700 (PDT)
Received: from localhost (216.131.76.34.bc.googleusercontent.com. [34.76.131.216])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-37d1697024fsm9935712f8f.95.2024.10.09.02.43.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Oct 2024 02:43:10 -0700 (PDT)
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
Subject: [PATCH V2 0/2] char: tpm: Adjust cr50_i2c locking mechanism
Date: Wed,  9 Oct 2024 09:42:05 +0000
Message-ID: <20241009094207.2897048-1-bernacki@google.com>
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

Jan Dabros (2):
  char: tpm: cr50: Use generic request/relinquish locality ops
  char: tpm: cr50: Move i2c locking to request/relinquish locality ops

 drivers/char/tpm/tpm_tis_i2c_cr50.c | 132 ++++++++++++++++++----------
 1 file changed, 85 insertions(+), 47 deletions(-)

-- 
2.47.0.rc0.187.ge670bccf7e-goog


