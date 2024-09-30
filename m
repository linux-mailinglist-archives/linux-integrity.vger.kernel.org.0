Return-Path: <linux-integrity+bounces-3716-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8766698A12B
	for <lists+linux-integrity@lfdr.de>; Mon, 30 Sep 2024 13:52:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B95431C20F53
	for <lists+linux-integrity@lfdr.de>; Mon, 30 Sep 2024 11:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ECED18CBF7;
	Mon, 30 Sep 2024 11:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="T2SXiZBc"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B037718990E
	for <linux-integrity@vger.kernel.org>; Mon, 30 Sep 2024 11:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727697169; cv=none; b=UDT66XM60KsSp+MI8Plw97gNaq8rS23P1eSS7nJEN/skXEi2TGVy9RKGr91hbN8YQbpJGSKYVVKdoXlGYdcWGZDqu6gDk9N1MUzkkWKyfdpy/W8dVHN30jucOn6WHoST5fGXyZzNfwNzaJi/bHat2SPjX2u54SovupiMJDWx2ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727697169; c=relaxed/simple;
	bh=dRRUQuHc0GNe9ZyioL62Ezc2oC1wAUIvwq5PYUEZ9M0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OIPp4ZrbJpraaRXSQYRHe4mZnjJT+dt94c7wZDtF697tK3PVlE7fMPvgovKtjl8IHeH1XPcHZASEzJsaSBn5XjKnrwFRxhLhe8r3UOSc8vuwSbDJx2PibL6VcylqovsLPM+F/YrSfY2zPDeTRiAByWar++CAXSn6JzM4hP1VI70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=T2SXiZBc; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-37cdb6ebc1cso1308504f8f.1
        for <linux-integrity@vger.kernel.org>; Mon, 30 Sep 2024 04:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727697166; x=1728301966; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G4qzGx2YA4BcjqMp4DFQ4bwP8nQ1tp5t1puB3STC9zU=;
        b=T2SXiZBckkH8Y76pgGxc8whsoOwSFusa1lr2hKiQDjHJlt0fYdEwNUeUrDciF1ZbIi
         byfH6Im9wzH2irovr11oSLfVpgcJYWcreOUWV9O9Hy4R35vMUSiOovgPPCiGI6JW5NSe
         w1PHn3cGM7K9sBKBOkhmEoSESp1uqQ7xYVcf0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727697166; x=1728301966;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G4qzGx2YA4BcjqMp4DFQ4bwP8nQ1tp5t1puB3STC9zU=;
        b=jQvlD0aGe0R9m8TP4UkEx6GFqAjo4brgsLc8isY5QjDV2oinN+sNlZ4S+pbWRNjVXP
         txi9nVXa7FGe9wgQyDbRun6Cqn9iaffF7XOtqVWTWtvuL9xv7Nm3GG9/7B0pGktaOvbT
         K+gnntC5VT/DIt1VicOzQx6AIB3Z6Fe2MgbS1oCJYuLXsnhOm1O7C6UBqsl9GhSckqxr
         9CulGqVeXD6x0BpYUvGJzBvcgHJFZh58LajADlwwBGSHtH+86KjA1w8hox5KR1qzuPkQ
         TEgmfgrSrZZ5xpG0ygzDOX90UyZdaDCMchqWBThNcoaXFLBEdDB8/74sVaEidfisfmui
         pCng==
X-Forwarded-Encrypted: i=1; AJvYcCUrTjkOE8w1hFWta8IPIKUXRB8z8yrCedoyeEvxyI1/7BIapoxGZa1gVq8FdtIOW0Jghx6TeZCyrkJOV+Bki+Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YydSkPvICPbghlrc8qPjfs9ehGQq9UT4jJDGypbaIuquKZh5UZw
	zH0CjcQLfXM1OXAoBQfioJgfX/H7l314QM88U5BcsxMXSFcpbx6fJ8S67jzVHA==
X-Google-Smtp-Source: AGHT+IFwRfq7zUEWcK8J4P/6B/lEVCNtutZmrrq2Dri2PBirN6AfAcOzL3PjimNE9a3+BGkD7iS3Ug==
X-Received: by 2002:adf:dd8e:0:b0:374:c8d1:70be with SMTP id ffacd0b85a97d-37cd5b31966mr6165914f8f.38.1727697165983;
        Mon, 30 Sep 2024 04:52:45 -0700 (PDT)
Received: from localhost (216.131.76.34.bc.googleusercontent.com. [34.76.131.216])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-37cd564d5b7sm8973780f8f.5.2024.09.30.04.52.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Sep 2024 04:52:45 -0700 (PDT)
From: bernacki@chromium.org
To: timvp@google.com,
	jarkko@kernel.org
Cc: apronin@google.com,
	arnd@arndb.de,
	gregkh@linuxfoundation.org,
	jgg@ziepe.ca,
	jsd@semihalf.com,
	linux-integrity@vger.kernel.org,
	mw@semihalf.com,
	peterhuewe@gmx.de,
	rrangel@chromium.org
Subject: Re: [PATCH 2/3] char: tpm: cr50: Use generic request/relinquish locality ops
Date: Mon, 30 Sep 2024 11:52:45 +0000
Message-ID: <20240930115245.2906902-1-bernacki@chromium.org>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
In-Reply-To: <CANkg5ezwYT+ZsiRDW9fe1m4vyncOEDFamq0jXTxmWO37d4i3Nw@mail.gmail.com>
References: <CANkg5ezwYT+ZsiRDW9fe1m4vyncOEDFamq0jXTxmWO37d4i3Nw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Tim,

[...]
> Why is it useful to return the same `loc` value that was passed in,
> rather than just returning `0`? The caller already knows the value of
> `loc`, so they aren't being told anything new.
> 
> I think this should continue to return `0` for success.

I think Jan just followed the conventions, when he returned 'loc' instead of
'0', some others request/release locality function do exactly the same.

[...]
> For each of these ` WARN_ONCE((chip->locality < 0), ...).`, can it
> return immediately rather than attempting to continue using an invalid
> locality value? Do the following commands have a chance of succeeding
> with the invalid value?

WARN_ONCE() macro does not remove checking of locality. If I understand
the code correctly layer above should not called this function if
request locality fails, so this code is an extra check. 
I can remove it in the next patchset if you want.

Jarkko,

Would it be possible to merge this changes. Patch 1. has already been merged,
only 2 and 3 are still waiting. Do you want me to create a new patchset for
these two patches?

thanks,
greg

