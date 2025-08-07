Return-Path: <linux-integrity+bounces-6785-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E943B1DE70
	for <lists+linux-integrity@lfdr.de>; Thu,  7 Aug 2025 22:51:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74BCD1AA429F
	for <lists+linux-integrity@lfdr.de>; Thu,  7 Aug 2025 20:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAA9222A813;
	Thu,  7 Aug 2025 20:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HOu9W4K5"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19820226CFF
	for <linux-integrity@vger.kernel.org>; Thu,  7 Aug 2025 20:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754599883; cv=none; b=LawW7nPzjV5BPNSDgM9jGy2XxoI8OfbHkMJmlPr8yNs6r7cBAUxrixEjaULs2QeMZULuYPsIqn4+2ot1XqCp7QUjWZrAb0gSt3NDf2HuKDBqPwWtOilFQVIPxF30+rsr+S6XxBaFj6JGKKCxSavY6IpJ86vqmha5npgu1znwtaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754599883; c=relaxed/simple;
	bh=AOynFPQxt6NZQp3OuNQcUfXCvysHw9uWj9W9kuEJTrg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=UGrKJm3fBVaco6Kg9t80yz4gnahLRHUum5aswQFP4KmE5cd4DfUWb7KQdDk61qMJFHnNFwA7f8+IIR5cOwZ0ilXpsXpWEreZrRDgk0smDZtknWaZvc6tiuPAAwsOokRMHT/5c0HBvIgA5k+SIke3b2CuFAfOWt6HXKzRcmdCPkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HOu9W4K5; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-55b797ad392so1650143e87.3
        for <linux-integrity@vger.kernel.org>; Thu, 07 Aug 2025 13:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754599880; x=1755204680; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AOynFPQxt6NZQp3OuNQcUfXCvysHw9uWj9W9kuEJTrg=;
        b=HOu9W4K5lcZARv6gCnxxAnaDILWxfNftfzPIdpkY1YNwt8TN7sROKePvmMPYRcxcZN
         /3n8XeHIjjqJwgM3E3MAnSK+LLAt4TxYQtGhGofn2k28ykyYn5u7HWTW0zIbCIJTHYja
         /UHZuvXbxkXiUgKuMfktUPLniISji0OEIoqyxyUy0T11xYe3tTESU4kdvFhabNsr/ZIo
         BWcVuuJY8uXXnj/eDcYxmufh1hV5lBizpLzLJMMp/A5YOo5LLuor8ayEOErnRfFrqhh/
         sNnk6rzccnGftjNEm0Hx4KmvCh5UsbYIlAfSy2OEibDL0ynPf10MXdtB0vCk+3GmXOMS
         0W1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754599880; x=1755204680;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AOynFPQxt6NZQp3OuNQcUfXCvysHw9uWj9W9kuEJTrg=;
        b=kL2BMwShylkJm7KO002anW0n3z4xriad1wsxqb0nZpIqEH48bhXHRps21p6uQl4OU3
         gjlJW96pmqwIHrZq2fcuJ3NimYqNMbMzvd0zhsTRu2XKhzcFrKko+uY1f7pTLtPxpvzQ
         pK9a6RtOQqRN4/rniibsy2LFExaT4aHIaUmWXn1obdZCI7SFHsFTMCrpu6izfVLDsXRB
         8OFYRZvpcJLZaY8S0jKJLxHrcYbjM3Jk8t4GvxCG62/BBu73WWFGzSGXMs/X1BkAmrbc
         yuTu8jNKCmibjOBhaepJiOIRMndL9cxETl6tjTSE9WcDWlKsKcK7MaJvypHqiVqPkEHr
         Ffpw==
X-Gm-Message-State: AOJu0YwCNjTRcQ+m4kemB+5rr4syKGOMPVAlRXkmdsgyKx9aqrlkcQEo
	0SjlFkx+Kq/eg6L5edyHrKEb9qH3MzZfHeNLfzx7sbtaaqAImnZIRGmuwLqKmWzYQiOBX3Y3sNq
	NomRjzvl49DwqSnsTAtplYy5Y+vapCqHEllP/uD+3dN9TO46+0vApRNIsMXc=
X-Gm-Gg: ASbGncvM2j6ODLYT12/GP9IvOYCrlLDUhTLl3NKMRegOX7II7Bw/U4DV8xr47NTwOY3
	1yXgdSjoqity+GWc/9MaRqF4kUpySi5C4jmlfCxvp4cq23+RrZQWAmH/DBPrppryFdJMk6zd6jh
	tRduPg3rJznyTPiG8Dj9TvKjqrA6TFYyi60gCJUivSqFe9H2F9cj4bwr32fIr5sQlOmjKpK7I4u
	g+x15ecGe6tbtB8VtYRaJh6aQuuH9mVJRWd3A==
X-Google-Smtp-Source: AGHT+IGYuvPYpkyB4utPFPSPLAYD0kdLDeBQepZ5FBalW2woNDJ5/ROcmzWfcln1KyZg0hg2m3xy1y3YLyDPmRfDgks=
X-Received: by 2002:a05:6512:2394:b0:553:2cc1:2bb2 with SMTP id
 2adb3069b0e04-55cc0098744mr52308e87.6.1754599879291; Thu, 07 Aug 2025
 13:51:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Chris Fenner <cfenn@google.com>
Date: Thu, 7 Aug 2025 13:51:07 -0700
X-Gm-Features: Ac12FXwrZc81cB174mUIJqxDwspAkKd5ZXEEstzFi9V4VqX0DDmrJYT8Vx2iKxQ
Message-ID: <CAMigqh2nwuRRxaLyOJ+QaTJ+XGmkQj=rMj5K9GP1bCcXp2OsBQ@mail.gmail.com>
Subject: Questions about CONFIG_TCG_TPM2_HMAC
To: linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi all,

I'm investigating an issue where the TPM driver breaks on the latest
upstream kernel. I believe I've tracked it down to the HMAC session
feature that primarily lives in drivers/char/tpm/tpm2-sessions.c.

Our TPM doesn't support TPM2_ContextSave. So we get the following call
stack during initialization:

1. tpm_tis_init calls

2. tpm_tis_core_init, which calls

3. tpm_chip_bootstrap, which calls

4. tpm_auto_startup, which calls

5. tpm2_auto_startup, which calls

6. tpm2_sessions_init, which calls

7. tpm2_create_null_primary, which calls

8. tpm2_save_context, which fails because the command is not
supported. This causes tpm_tis_core_init to skip the call to
tpm_chip_register. This causes processes trying to open /dev/tpm0 to
hit the error "no such device"

I have two main concerns about this feature:

1. It seems problematic that the kernel autonomously sends
not-strictly-necessary traffic to the TPM, and breaks userspace if it
fails. I would define "strictly necessary" traffic as things like
calling TPM2_Startup.
2. It's not clear to me that the HMAC session feature solves its own
threat model. Reading through the documentation at the top of
https://github.com/torvalds/linux/blob/master/drivers/char/tpm/tpm2-sessions.c,
it seems like we assume that the adversary either isn't sophisticated
enough to interpose the CreatePrimary command, or that userspace
somehow recovers trust after the fact by attesting the null key with
the EK. I'm not sure how this is expected to work, given this
userspace wasn't correctly measured into the TPM (due to the
interposer) and could therefore be malicious.

Is someone able to help me fill in the gaps in my understanding here?

Thanks
Chris

