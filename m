Return-Path: <linux-integrity+bounces-8132-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5027CCD70FF
	for <lists+linux-integrity@lfdr.de>; Mon, 22 Dec 2025 21:24:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E885230161A5
	for <lists+linux-integrity@lfdr.de>; Mon, 22 Dec 2025 20:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B09F3081DF;
	Mon, 22 Dec 2025 20:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4X8kuzj0"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8C93016F4
	for <linux-integrity@vger.kernel.org>; Mon, 22 Dec 2025 20:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766435096; cv=none; b=HAgUtBevRzGrhmjgMCHKvrr5dkpMh4vU17E+N6hviWmQXLCEMUxP9sH7t3pwpVUjXGJ6H9yDzCHYYlxCYb+b5mtoJpgGiLreMg7sNQsngi/phyXL/+KlYAlWwJz7ZY4L0Jqim5bdG/YlRSfC+9M2uPAx2JPnqQtn5sU7g6LZv0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766435096; c=relaxed/simple;
	bh=9rd+GpwzLc1w9cmaB5ydQoPGRQPj7ozHx/DAQZ4dYr4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iHUdyltEiG1Csiy9C9yvUfy0CvcA0sXvdFmq+3Emlyt6a+6iMBi0hCHdgTvE/wlB0Js7elMT94X9pVZQgLatwcvM1I70Oo9cfE3LNbOnYQoG20sw53I6owGEuwvxcNPnPRyOt5kjCfrwi6uq97dU7+31INjxOMvhPEaOe/CfTlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4X8kuzj0; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-34c6cda4a92so8985270a91.3
        for <linux-integrity@vger.kernel.org>; Mon, 22 Dec 2025 12:24:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1766435094; x=1767039894; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Fdi1SM/nAbM7Pof3bvt+6WkayM59q8Xfd87dshQVa90=;
        b=4X8kuzj041k1HMS43Xu9ssbk+iDK1SdzF4u7anEgJdXmY20zHpclegwMrhFnkAOTI2
         tTDNeL7ucsK2LTiKlC9WAGr11pNJlNhS8ex4SbQW6ygXDHeSKoMbfFtG4D494va2E1gF
         HWOxOwv04bQwuY407MPgs6SsZDFJY0+hrMN1Gxb92qIbgVUn0bk63mHUFvvSQFSK8QP/
         br4debh6MoAezq2VvJiivQqkRfsW7Hl1ej06A2iebY1bErH5I6iA8lJmlbVq6R2LmK87
         zMXyBytlS+RFV/5vxmgCDONpaRl+cxtuHz3ntGyA5I8XI/PRjz7wIAyr535Km/P/m7YR
         0Lqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766435094; x=1767039894;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fdi1SM/nAbM7Pof3bvt+6WkayM59q8Xfd87dshQVa90=;
        b=MQ9NVNidWWbaJbkd9en+9IJzR5H6X1rAOiFogBQj/hOmTpdItsmCbAjZUn9FnNJK1g
         enamrnoqfN/3zulMNbyU+s4pD4y+EtMW+cnoOmNBxaG30rktni8eRpJ2qaHMLOMgRomu
         ydznrlkQrHnFXEY1OzJQWh9D8ADQrUjMjBKyseURqf6A/yA24JJMXJPUBmfBOMYbHaio
         NfqJQ0fTAMo+2Gf+GY9pb8Vl8we1xs4dvI8dYe/3Dn2X80+aYNIYfyYLH8no1K3C1sa0
         +JyyN1U9mlduVxALhz17n2y8y0tddAtyW/FCB/zZU4dyuuF5hAEUNSbjrto530FCxo2h
         xmfA==
X-Forwarded-Encrypted: i=1; AJvYcCWiZbfhzW7lU6sm/IR02Afy1aOKgFrl2iAwfeJ1PuvqwWfCd+isS69A7eCCBioww7HjZw1ZgeWh5rlhj2Zs7Pk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVW/gLl/jrW53EM0hWBlu2Lbz8C4BsdAnsO5f4YmkkzFjaSeeB
	2RgKOVLaD1XMThxeoa2M+eTe6iW4nWmEwrKN4U67TuS3PUjhge2d38dCLK5HOEV23k2/6g5sRx6
	Dahc+/xU+aojuIgxINH+JZZVWR6nG6Q==
X-Google-Smtp-Source: AGHT+IGoq1CIOLiUHphOY1xkNyX6Xae168VYvdK7hs6guIsiY2W6mU5hTHiY95SH08FqYdtKbrgKNNqEH3qSoLSsGto=
X-Received: from dlbvv19.prod.google.com ([2002:a05:7022:5f13:b0:11d:cf4c:62ab])
 (user=samitolvanen job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7022:e13:b0:11b:88a7:e1b0 with SMTP id a92af1059eb24-121722eb801mr13420034c88.26.1766435094054;
 Mon, 22 Dec 2025 12:24:54 -0800 (PST)
Date: Mon, 22 Dec 2025 20:24:14 +0000
In-Reply-To: <20251201030606.2295399-1-coxu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251031080949.2001716-1-coxu@redhat.com> <20251201030606.2295399-1-coxu@redhat.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=801; i=samitolvanen@google.com;
 h=from:subject:message-id; bh=9rd+GpwzLc1w9cmaB5ydQoPGRQPj7ozHx/DAQZ4dYr4=;
 b=owGbwMvMwCUWxa662nLh8irG02pJDJmeKz7/TUuY2STVcmh/95Lap9O1J30SM4x+M9PIOXOvN
 uPvE46HO0pZGMS4GGTFFFlavq7euvu7U+qrz0USMHNYmUCGMHBxCsBE7r5nZDgZNNfy3uX0nI7p
 fpdMRcSz7gfnlsRtPckr+/iCelakWALDX9mzntH7zLbJLSlYp8DFIeYRxzA9LKm0t59hYnvZ25d /+AA=
X-Mailer: git-send-email 2.52.0.351.gbe84eed79e-goog
Message-ID: <176643400584.1902051.10979216909918913544.b4-ty@google.com>
Subject: Re: [PATCH v2] module: Only declare set_module_sig_enforced when CONFIG_MODULE_SIG=y
From: Sami Tolvanen <samitolvanen@google.com>
To: linux-modules@vger.kernel.org, Coiby Xu <coxu@redhat.com>
Cc: Sami Tolvanen <samitolvanen@google.com>, linux-integrity@vger.kernel.org, 
	kernel test robot <lkp@intel.com>, Aaron Tomlin <atomlin@atomlin.com>, Daniel Gomez <da.gomez@samsung.com>, 
	Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Mon, 01 Dec 2025 11:06:05 +0800, Coiby Xu wrote:
> Currently if set_module_sig_enforced is called with CONFIG_MODULE_SIG=n
> e.g. [1], it can lead to a linking error,
> 
>     ld: security/integrity/ima/ima_appraise.o: in function `ima_appraise_measurement':
>     security/integrity/ima/ima_appraise.c:587:(.text+0xbbb): undefined reference to `set_module_sig_enforced'
> 
> This happens because the actual implementation of
> set_module_sig_enforced comes from CONFIG_MODULE_SIG but both the
> function declaration and the empty stub definition are tied to
> CONFIG_MODULES.
> 
> [...]

Applied to modules-next, thanks!

[1/1] module: Only declare set_module_sig_enforced when CONFIG_MODULE_SIG=y
      commit: 1ae719a43b0336678172b3eb55c5187816f9a130

Best regards,

	Sami


